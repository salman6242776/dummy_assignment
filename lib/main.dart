import 'dart:io';

import 'package:dummy_assignment/application/common/shared_preference/app_shared_preference.dart';
import 'package:dummy_assignment/application/screens/authorized/dashboard_screen.dart';
import 'package:dummy_assignment/application/screens/unauthorized/bloc/authorize_bloc.dart';
import 'package:dummy_assignment/application/screens/unauthorized/login/login_screen.dart';
import 'package:dummy_assignment/application/screens/unauthorized/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthorizeBloc()),
      ],
      child: const MyApp(),
    ),
  );

  HttpOverrides.global = MyHttpOverrides();
  AppSharedPreference.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.orange),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        drawerTheme: const DrawerThemeData(elevation: 100),
        textTheme: const TextTheme(
          // title medium for list item tile.
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      // home: const SplashScreen(),
      // home: MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (context) => AuthorizeBloc()),
      //   ],
      //   child: const SplashScreen(),
      // ),
      routes: {
        "/": (_) => const SplashScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        DashboardScreen.routeName: (_) => const DashboardScreen(),
      },
    );
  }
}
