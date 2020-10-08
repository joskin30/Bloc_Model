import 'dart:async';
import 'package:Bloc_Model/src/models/ItemModel.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class ApiProvider<T>{
  Client client = Client();
  List<T> model = List<T>();

  //Hace una llamada a la API y devuelve una lista generica.
  Future<List<T>> getData (String api) async {
    final response = await client.get(api);
    //valido si la llamada fue corecta
    if (response.statusCode == 200) {
      var reponseString = json.decode(response.body);
      //aqui lo convierto en objeto
      for (Map list in reponseString) {
        model.add(_fromGenericJson<T>(list));
      }
      return model;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<String> sendData(String api, T sendBody) async {
    final response = await client.post(api, body: _toGenericJson<T>(sendBody));
    if (response.statusCode == 200) {
      var reponseString = json.decode(response.body);
      return reponseString;
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Aqui dependiendo de cuantas clases tenga se ira deserializando segun el valor que conenta T
  T _fromGenericJson<T>(Map<String, dynamic> json) {
    if (T == ItemModel) {
      return json == null ? null : ItemModel.fromJson(json) as T;
    } else {
      throw Exception("No se puedo convertir a objeto");
    }
  }

  //Aqui dependiendo de cuantas clases tenga se ira serializando segun el valor que conenta T
  Map<String, dynamic> _toGenericJson<T>(T value) {
    if (T == ItemModel) {
      return (T as ItemModel).toJson();
    } else {
      throw Exception("No se pudo serializar a json correctamente");
    }
  }

}