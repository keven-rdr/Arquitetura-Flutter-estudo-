import 'package:flutter/cupertino.dart';
import 'package:arqmvvm/scenes/Profile/profile_scene.dart';
import 'package:arqmvvm/scenes/Profile/profile_view_model.dart';
import '../../resources/repositories/auth_repository.dart';
import '../../resources/services/auth_service.dart';
import '../../resources/shared/app_coordinator.dart';

class ProfileFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final authRepository = AuthRepository();
    final authService = AuthService(repository: authRepository);

    final viewModel = ProfileViewModel(authService: authService,
      coordinator: coordinator,);
    return ProfilePage(viewModel: viewModel);
  }
}