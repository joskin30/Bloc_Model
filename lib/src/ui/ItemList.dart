import 'package:Bloc_Model/src/blocs/ItemBloc.dart';
import 'package:Bloc_Model/src/models/ItemModel.dart';
import 'package:flutter/material.dart';



class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> { 

  @override
  void initState() { 
    super.initState();
    blocT.fill();
  }

  @override
  void dispose() { 
    blocT.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: blocT.counterStream,
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
        return Column(
          children: [
            Text(snapshot.data[index].name),
            Text(snapshot.data[index].alamat),
            Text(snapshot.data[index].latitude.toString()),
            Text(snapshot.data[index].longitude.toString()),
          ],
        );
      }
    );
  }
}