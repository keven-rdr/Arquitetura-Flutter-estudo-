import 'package:arqmvvm/DesignSystem/Components/InputField/input_text.dart';
import 'package:arqmvvm/resources/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(){
    final query = _searchController.text;
    print("Buscando por: $query");
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StyledInputField.instantiate(
          viewModel: InputTextViewModel(
            controller: _searchController,
            label: null,
            hintText: 'Digite para buscar...',
            theme: InputFieldTheme.dark,
            prefixIcon: LucideIcons.search,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: brandSecondary.withOpacity(0.9),
          body: SafeArea(child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(),
              ],
            ),
          )),
        )
      ],
    );
  }
}