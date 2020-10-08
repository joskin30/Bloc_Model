import 'package:Bloc_Model/src/models/ItemModel.dart';
import 'package:Bloc_Model/src/resources/repository.dart';
import 'dart:async';

class BaseBloc<T> {
  RepositoryItem<T> _repository = RepositoryItem<T>();
  StreamController _input = StreamController();
  StreamController<List<T>> _output = StreamController<List<T>>.broadcast();

  Stream<List<T>> get  counterStream => _output.stream;
  StreamSink get sendEvent => _input.sink;

  BaseBloc(){
    _input.stream.listen(onEvent);
  }

  void onEvent(String api) async {
    List<T> itemModel = await _repository.fetchAll(api);
    _output.add(itemModel);
  }

   void dispose(){
    _input.close();
    _output.close();
  }

}

//Aqui extiendo de la case BaseBloc y le pago como parametro la clase ItemModel esto ocaciona que todas las funciones anteriores se creen 
//parte de ItemModel
class ItemT extends BaseBloc<ItemModel>{
  void fill(){
    super.onEvent("https://my.api.mockaroo.com/mall.json?key=dbcde960");
  }
}

final blocT = ItemT();
