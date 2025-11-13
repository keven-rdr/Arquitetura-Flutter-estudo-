import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../resources/shared/colors.dart';
import 'login_view_model.dart';


class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;
  const LoginView({super.key, required this.viewModel});
  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandSecondary.withOpacity(0.9),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StyledInputField.instantiate(
                viewModel: InputTextViewModel(
                  controller: _loginController,
                  label: 'Login',
                  hintText: 'Digite seu usuário',
                  theme: InputFieldTheme.dark,
                ),
              ),
              const SizedBox(height: 24),
              StyledInputField.instantiate(
                viewModel: InputTextViewModel(
                  controller: _passwordController,
                  label: 'Senha',
                  hintText: 'Digite sua senha',
                  isPassword: true,
                  theme: InputFieldTheme.dark,
                ),
              ),
              const SizedBox(height: 32),
              ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  size: ActionButtonSize.large,
                  style: ActionButtonStyle.primary,
                  text: 'Entrar',
                  onPressed: () {
                    final user = _loginController.text;
                    final password = _passwordController.text;
                    widget.viewModel.performLogin(user: user, password: password, onSuccess: (name, address) {
                      //mudança de esta
                      widget.viewModel.presentHome(name, address);

                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}