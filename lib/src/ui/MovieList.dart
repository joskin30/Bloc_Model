import 'package:Bloc_Model/src/blocs/moviebloc.dart';
import 'package:Bloc_Model/src/models/ItemModel.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<List<ItemModel>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<ItemModel>> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return Center(child: Text(snapshot.data[index].name));
      }
    );
  }
}