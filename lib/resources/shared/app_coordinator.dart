import 'package:arqmvvm/scenes/main_tab/main_tab_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../scenes/login/login_factory.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget startApp() {
    return goToLoginWidget();
  }

  Widget goToLoginWidget() {
    return LoginFactory.make(coordinator: this);
  }

  void goToLogin() {
    final login = LoginFactory.make(coordinator: this);

    // Limpa toda a pilha de navegação (Home, Profile, etc.) e coloca o Login
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => login),
          (Route<dynamic> route) => false, // 'false' garante que todas as rotas anteriores sejam removidas
    );
  }


  void goToHome() {
    final home = MainTabFactory.make(coordinator: this);
    navigatorKey.currentState?.pushReplacement( MaterialPageRoute(builder: (_) => home ));
  }

}