import 'package:arqmvvm/scenes/favorites/favorites_service.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:arqmvvm/DesignSystem/Components/InputField/input_text.dart';
import 'package:arqmvvm/resources/shared/colors.dart';
import '../../DesignSystem/Components/Card/app_card.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Spinner/spinner.dart';
import '../../DesignSystem/Components/Spinner/spinner_view_model.dart';
import '../../resources/services/comparison_service.dart';
import 'home_view_model.dart';
import 'package:arqmvvm/resources/repositories/weapon_repository.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomePage({super.key, required this.viewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(repository: WeaponRepository(), comparisonService: ComparisonService(), favoritesService: FavoritesService());
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(){
    _viewModel.search(_searchController.text);
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: StyledInputField.instantiate(
        viewModel: InputTextViewModel(
          controller: _searchController,
          label: null,
          hintText: 'Busque por arma...',
          theme: InputFieldTheme.dark,
          prefixIcon: LucideIcons.search,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_viewModel.cards.isEmpty && !_viewModel.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Text("Nenhuma arma encontrada",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _viewModel.cards.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return AppCard(viewModel: _viewModel.cards[index]);
      },
    );
  }

  Widget _buildLoadingOverlay() {
    return Visibility(
      visible: _viewModel.isLoading,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: SpinnerComponent.instantiate(
          viewModel: SpinnerViewModel(
            color: brandPrimary,
            size: 50.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: dividerColorLight,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildHeader(),
                      _buildBody(),
                    ],
                  ),
                ),
              ),
            ),
            _buildLoadingOverlay(),
          ],
        );
      },
    );
  }
}