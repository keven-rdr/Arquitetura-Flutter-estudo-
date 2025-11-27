import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/Card/app_card.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../resources/shared/colors.dart';
import 'profile_view_model.dart';

class ProfilePage extends StatefulWidget {
  final ProfileViewModel viewModel;
  const ProfilePage({super.key, required this.viewModel});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF1C1C1C),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: _buildTopSection(),
                      ),
                      _buildBody(),
                    ],
                  ),
                ),

                _buildBackButton(context),
              ],
            ),
          );
        }
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 50,
      left: 16,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: brandPrimary,
            shape: BoxShape.circle,
          ),
          child: const Icon(LucideIcons.chevronLeft, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    final user = widget.viewModel.currentUser;
    final hasAvatar = user != null && user.avatarUrl.isNotEmpty;

    return Container(
      width: double.infinity,
      height: 240,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: neutralLight,
            backgroundImage: hasAvatar
                ? NetworkImage(user!.avatarUrl)
                : null,
            child: !hasAvatar
                ? Icon(LucideIcons.user, size: 60, color: brandPrimary)
                : null,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppCard(viewModel: widget.viewModel.userDetailsCard),
        ),

        const SizedBox(height: 32),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ActionButton.instantiate(
            viewModel: ActionButtonViewModel(
              size: ActionButtonSize.large,
              style: ActionButtonStyle.destructive,
              text: 'Sair da Aplicação',
              icon: LucideIcons.logOut,
              onPressed: () => widget.viewModel.logoutAndNavigate(),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}