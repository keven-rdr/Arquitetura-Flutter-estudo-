import 'package:flutter/material.dart' hide CardTheme;
import 'package:arqmvvm/DesignSystem/Components/Card/card_view_model.dart';
import '../../resources/models/user_model.dart';
import '../../resources/repositories/auth_repository.dart';
import '../../resources/services/auth_service.dart';
import '../../resources/shared/app_coordinator.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthService _authService;
  final AppCoordinator _coordinator;

  ProfileViewModel({
    required AuthService authService,
    required AppCoordinator coordinator,
  }) : _authService = authService,
        _coordinator = coordinator,
        _authRepository = AuthRepository();

  UserModel? get currentUser => _authRepository.currentUser;

  String get avatarUrl => currentUser != null
      ? 'https://i.pravatar.cc/150?u=${currentUser!.id}'
      : '';

  FormCardViewModel get userDetailsCard {
    final user = currentUser;
    final name = user?.name ?? 'Não disponível';
    final email = user?.email ?? 'Não disponível';

    final fields = <FormFieldModel>[
      if (user != null)
        FormFieldModel(
          label: 'Nome',
          value: name,
        ),
      if (user != null && user.email.isNotEmpty)
        FormFieldModel(
          label: 'E-mail',
          value: email,
        ),
    ];

    return FormCardViewModel(
      title: 'Meus Dados',
      theme: CardTheme.dark,
      fields: fields,
    );
  }
  Future<void> logoutAndNavigate() async {
    try {
      await _authService.logout();

      _coordinator.goToLogin();
    } catch (e) {
      print("Erro ao tentar deslogar: $e");
    }
  }
}