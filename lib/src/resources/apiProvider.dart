import 'dart:async';
import 'package:Bloc_Model/src/models/ItemModel.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class MovieApiProvider<T>{
  Client client = Client();
  List<T> model = List<T>();

  Future<List<T>> getData (String api) async {
    final response = await client.get(api);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var reponseString = json.decode(response.body);
      for (Map list in reponseString) {
        model.add(_fromGenericJson<T>(list));
      }
      return model;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<String> sendData(String api, T sendBody) async {
    final response = await client.post(api, body: _toGenericJson<T>(sendBody));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var reponseString = json.decode(response.body);
      return reponseString;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  T _fromGenericJson<T>(Map<String, dynamic> json) {
    if (T == ItemModel) {
      return json == null ? null : ItemModel.fromJson(json) as T;
    } else {
      throw Exception("Prueba");
    }
  }

  Map<String, dynamic> _toGenericJson<T>(T value) {
    if (T == ItemModel) {
      return (T as ItemModel).toJson();
    } else {
      throw Exception("_exceptionMessage");
    }
  }

}
