import 'package:flutter/material.dart';
import '../resources/shared/app_coordinator.dart';

void main() {
  final coordinator = AppCoordinator();
  runApp(Application(coordinator: coordinator));
}

class Application extends StatelessWidget {
  final AppCoordinator coordinator;
  const Application({super.key, required this.coordinator});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MVVC Sample",
        navigatorKey: coordinator.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: coordinator.startApp());
  }
}


