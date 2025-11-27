import 'package:arqmvvm/scenes/main_tab/main_tab_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../scenes/Matches/matches_factory.dart';
import '../../scenes/login/login_factory.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final ValueNotifier<int> tabNotifier = ValueNotifier<int>(0);

  Widget startApp() {
    return goToLoginWidget();
  }

  Widget goToLoginWidget() {
    return LoginFactory.make(coordinator: this);
  }

  void goToLogin() {
    final login = LoginFactory.make(coordinator: this);

    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => login),
          (Route<dynamic> route) => false,
    );
  }

  void goToHome() {
    final home = MainTabFactory.make(coordinator: this);
    navigatorKey.currentState?.pushReplacement( MaterialPageRoute(builder: (_) => home ));
  }

  void selectTab(int index) {
    tabNotifier.value = index;
  }

}