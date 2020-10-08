import 'package:Bloc_Model/src/resources/apiProvider.dart';

class RepositoryItem<T> {
  var apiProvider = ApiProvider<T>();

  //Aqui se obtiene los datos en forma generica de la clase ApiProvider y se devulve una Lista Generica por igual
  Future<List<T>> fetchAll(String api) async {
    return await apiProvider.getData(api);
  }

}
