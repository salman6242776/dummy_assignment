// ignore_for_file: avoid_print

import 'package:dummy_assignment/application/common/components/custom_text_form_field.dart';
import 'package:dummy_assignment/application/common/utils/validation_utiils.dart';
import 'package:dummy_assignment/application/screens/authorized/dashboard_screen.dart';
import 'package:dummy_assignment/application/screens/unauthorized/bloc/authorize_bloc.dart';
import 'package:dummy_assignment/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login-screen';

  LoginScreen({super.key});

  final _form = GlobalKey<FormState>();
  var userModel = UserModel();
  // we can have TextEditingControllers as well and can have input in different objects. But I prefer to populate objects instantly.
  late AuthorizeBloc _loginBloc;
  // late StreamSubscription _loginBlockStream;

  void _onLoginClickListener() {
    if (_form.currentState?.validate() == true) {
      _loginBloc.add(AuthorizeUserEvent(userModel: userModel));
    }
  }

  Widget blockStreamReceiver(context, state) {
    print("***----------- Received BUILD Callback -----------***");
    if (state is AuthorizeStarted) {
      print("*** LoginAuthorizeStarted ***");
      return const Center(child: CircularProgressIndicator());
    } else if (state is AuthorizeSuccessful) {
      onLoginSuccess(context);
    } else if (state is AuthorizeFailed) {
      print("*** LoginAuthorizeFailed ***");
      showSnackBar(context, "Login Failed!");
    }
    print("*** EMPTYYYYY ***");
    return ElevatedButton(
      onPressed: _onLoginClickListener,
      child: const Text("Login"),
    );
  }

  void onLoginSuccess(BuildContext context) {
    print("*** LoginAuthorizeSuccessful ***");
    showSnackBar(context, "Login SUCCESS!");
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Navigator.of(context).popAndPushNamed(DashboardScreen.routeName));
  }

  void showSnackBar(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message))));
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = AuthorizeBloc();
    print("***////// BUILD ***///////////");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              CustomTextFormField(
                label: "Email",
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  return ValidationUtils.isValidEmail(value)
                      ? null
                      : "Please enter valid email";
                  // return (value as String).isValidEmail() ? null : "Please enter name";
                },
                onTextChangeListener: (value) {
                  userModel.setEmail(value);
                },
              ),
              CustomTextFormField(
                initalValue: "",
                label: "Password",
                isPassword: true,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  return ValidationUtils.isValidPassword(value)
                      ? null
                      : "Please enter atleast 6 charaters";
                },
                onTextChangeListener: (value) {
                  userModel.setPassword(value);
                },
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder(
                bloc: _loginBloc,
                builder: (_, state) => blockStreamReceiver(context, state),
                buildWhen: (previous, current) =>
                    previous.runtimeType != current.runtimeType,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
