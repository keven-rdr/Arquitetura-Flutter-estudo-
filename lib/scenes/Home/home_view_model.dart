import 'package:flutter/material.dart';
import 'home_service.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _service;

  HomeViewModel({required HomeService service}) : _service = service;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ResultadoBusca> _resultados = [];
  List<ResultadoBusca> get resultados => _resultados;

  Future<void> search(String query) async {
    _isLoading = true;
    notifyListeners();

    _resultados = await _service.search(query);

    _isLoading = false;
    notifyListeners();
  }
}