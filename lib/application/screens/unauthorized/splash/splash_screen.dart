import 'package:dummy_assignment/application/common/constants.dart';
import 'package:dummy_assignment/application/common/shared_preference/app_shared_preference.dart';
import 'package:dummy_assignment/application/screens/authorized/dashboard_screen.dart';
import 'package:dummy_assignment/application/screens/unauthorized/bloc/authorize_bloc.dart';
import 'package:dummy_assignment/application/screens/unauthorized/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash-screen';
  const SplashScreen({super.key});

  void _splashDelay(BuildContext context) {
    // AuthorizeBloc _authorizeBloc =
    //     BlocProvider.of<AuthorizeBloc>(context, listen: false);

    Future.delayed(const Duration(seconds: 1), () {
      // _authorizeBloc.add(AutoAuthorizeEvent());
      _navigateToScreen(
        context: context,
        destinationRouteName: AppSharedPreference.containsKey(USER_EMAIL)
            ? DashboardScreen.routeName
            : LoginScreen.routeName,
      );
    });

    // _authorizeBloc.stream.listen((stateEvent) {
    //   _navigateToScreen(
    //     context: context,
    //     destinationRouteName: stateEvent is AuthorizeFailed
    //         ? LoginScreen.routeName
    //         : DashboardScreen.routeName,
    //   );
    // });
  }

  void _navigateToScreen(
      {required BuildContext context, required String destinationRouteName}) {
    Navigator.of(context).popAndPushNamed(destinationRouteName);
  }

  @override
  Widget build(BuildContext context) {
    _splashDelay(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text("Dummy App"),
      ),
    );
  }
}
