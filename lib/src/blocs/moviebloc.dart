import 'package:Bloc_Model/src/models/ItemModel.dart';
import 'package:Bloc_Model/src/resources/apiProvider.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = MovieApiProvider<ItemModel>();
  final _moviesFetcher = PublishSubject<List<ItemModel>>();

  Observable<List<ItemModel>> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    List<ItemModel> itemModel = await _repository.getData("https://my.api.mockaroo.com/mall.json?key=dbcde960");
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();