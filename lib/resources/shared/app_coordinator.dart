import 'package:arqmvvm/scenes/main_tab/main_tab_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../scenes/login/login_factory.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget startApp() {
    return goToLogin();
  }


  Widget goToLogin() {
    return LoginFactory.make(coordinator: this);
  }


  void goToHome() {
    final home = MainTabFactory.make(coordinator: this);
    navigatorKey.currentState?.pushReplacement( MaterialPageRoute(builder: (_) => home ));
  }

} 