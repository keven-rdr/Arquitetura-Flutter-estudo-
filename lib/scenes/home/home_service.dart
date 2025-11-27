class ResultadoBusca {
  final String nome;
  ResultadoBusca({required this.nome});
}

class HomeService {
  Future<List<ResultadoBusca>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (query.isNotEmpty) {
      return [
        ResultadoBusca(nome: "Resultado 1 para '$query'"),
        ResultadoBusca(nome: "Resultado 2 para '$query'"),
      ];
    }
    return [];
  }
}