import 'package:flutter/material.dart';
import '../../scenes/login/login_scene.dart';
import '../../scenes/main_tab/main_tab_scene.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget startApp() {
    return goToLogin();
  }

  Widget goToLogin() {
    return LoginFactory.make(coordinator: this);
  }

  void goToHome() {
    Widget homePage = MainTabFactory.make(coordinator: this);
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => homePage),
    );
  }
}