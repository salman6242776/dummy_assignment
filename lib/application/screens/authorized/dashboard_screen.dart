import 'package:dummy_assignment/application/common/constants.dart';
import 'package:dummy_assignment/application/common/shared_preference/app_shared_preference.dart';
import 'package:dummy_assignment/application/screens/unauthorized/bloc/authorize_bloc.dart';
import 'package:dummy_assignment/application/screens/unauthorized/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard-screen';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthorizeBloc authorizeBloc = BlocProvider.of(context, listen: false);

    authorizeBloc.stream.listen(
      (event) {
        if (event is AuthorizeFailed) {
          Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                authorizeBloc.add(LogoutUserEvent());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text('Welcome, ${AppSharedPreference.get(USER_EMAIL)}'),
      ),
    );
  }
}
