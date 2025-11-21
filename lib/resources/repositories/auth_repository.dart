import '../models/user_model.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  factory AuthRepository() => _instance;
  AuthRepository._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  final List<UserModel> _mockUsers = [
    UserModel(
      id: '1',
      username: 'admin',
      password: '123',
      name: 'Administrador',
      email: ""
    ),
    UserModel(
      id: '2',
      username: 'usuario',
      password: 'abc',
      name: 'Usuário Comum',
      email: ""
    ),
  ];

  Future<UserModel> login({required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final user = _mockUsers.firstWhere(
            (u) => u.username == username && u.password == password,
      );

      _currentUser = user;

      return user;
    } catch (e) {
      throw Exception('Usuário ou senha inválidos');
    }
  }

  void logout() {
    _currentUser = null;
    print("Estado do usuário limpo no Repositório.");
  }
}