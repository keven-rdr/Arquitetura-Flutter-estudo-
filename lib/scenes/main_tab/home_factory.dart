import 'package:flutter/cupertino.dart';
import '../../resources/shared/app_coordinator.dart';
import 'home_view.dart';

class HomeFactory {
  static Widget make ({required String name, required String address, required AppCoordinator coordinator}){
    return HomeView(name: name, address: address);
  }

}