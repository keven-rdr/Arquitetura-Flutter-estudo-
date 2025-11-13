import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../scenes/login/login_factory.dart';
import '../../scenes/main_tab/home_factory.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget startApp() {
    return goToLogin();
  }


  Widget goToLogin() {
    return LoginFactory.make(coordinator: this);
  }


  void goToHome({required String name, required String address}) {
    final home = HomeFactory.make(name: name, address: address, coordinator: this);
    navigatorKey.currentState?.pushReplacement( MaterialPageRoute(builder: (_) => home ));
  }

} 