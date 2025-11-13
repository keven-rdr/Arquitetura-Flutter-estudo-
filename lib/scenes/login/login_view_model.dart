import 'package:asdasd/resources/shared/app_coordinator.dart';
import 'login_service.dart';

class LoginViewModel {
  final LoginService service;
  final AppCoordinator coordinator;

  LoginViewModel({
    required LoginService service,
    required AppCoordinator coordinator,
  }) : service = service,
        coordinator = coordinator;


  Future<void> performLogin({required String user, required String password,
    required void Function(String name, String address) onSuccess, }) async {
    final response = await service.fetchLogin(user: user, password: password);
    final name = response ["name"] as String? ?? "";
    final address = response ["address"] as String? ?? "";

    onSuccess(name, address);
  }

  void presentHome(String name,
      String address){
    coordinator.goToHome(name: name, address: address);
  }

}