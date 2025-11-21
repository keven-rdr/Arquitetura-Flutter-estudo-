import '../models/user_model.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  factory AuthRepository() => _instance;
  AuthRepository._internal();

  final List<UserModel> _mockUsers = [
    UserModel(
      id: '1',
      username: 'admin',
      password: '123',
      name: 'Administrador',
    ),
    UserModel(
      id: '2',
      username: 'usuario',
      password: 'abc',
      name: 'Usuário Comum',
    ),
  ];

  Future<UserModel> login({required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final user = _mockUsers.firstWhere(
            (u) => u.username == username && u.password == password,
      );
      return user;
    } catch (e) {
      throw Exception('Usuário ou senha inválidos');
    }
  }
}