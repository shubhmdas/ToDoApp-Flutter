import 'package:flutter/material.dart';
import 'package:todo_app/screen_arguments.dart';
import 'package:todo_app/screens/nav_home.dart';
import 'package:todo_app/screens/nav_todos.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/register.dart';
import 'package:todo_app/screens/welcome_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as ScreenArguments;
    switch (settings.name) {

      case '/welcome':
        return MaterialPageRoute(builder: (_) {
          ScreenArguments arguments = args;
          return WelcomeScreen(auth: arguments.auth, firestore: arguments.firestore);
        });

      case '/login':
        return MaterialPageRoute(builder: (_) {
          ScreenArguments arguments = args;
          return LoginScreen(auth: arguments.auth, firestore: arguments.firestore);
        });

      case '/register':
        return MaterialPageRoute(builder: (_) {
          ScreenArguments arguments = args;
          return Register(auth: arguments.auth, firestore: arguments.firestore);
        });

      case '/home':
        return MaterialPageRoute(builder: (_) {
          ScreenArguments arguments = args;
          return Home(auth: arguments.auth, firestore: arguments.firestore);
        });

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}