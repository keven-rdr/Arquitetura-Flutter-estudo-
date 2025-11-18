import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../DesignSystem/Components/Animations/vs_animation.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Spinner/spinner.dart';
import '../../DesignSystem/Components/Spinner/spinner_view_model.dart';
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
  bool _isLoading = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return const VsAnimation(height: 180);
  }

  Widget _buildBody() {
    return Column(
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
            onPressed: () async {
              final user = _loginController.text;
              final password = _passwordController.text;

              setState(() {
                _isLoading = true;
              });

              try {
                await widget.viewModel.performLogin(
                  user: user,
                  password: password,
                  onSuccess: () {
                    widget.viewModel.presentHome();
                  },
                );
              } catch (e) {
                print("Erro no login: $e");
                setState(() {
                  _isLoading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString().replaceAll('Exception: ', '')),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: neutralBlack.withOpacity(0.9),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildBody(),
                  const SizedBox(height: 32),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),

        Visibility(
          visible: _isLoading,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: SpinnerComponent.instantiate(
              viewModel: SpinnerViewModel(
                color: brandPrimary,
                size: 50.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}