import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

var data = [
  "https://images.unsplash.com/photo-1485291571150-772bcfc10da5?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNTA2MzZ8MHwxfHNlYXJjaHw0fHxjYXJ8ZW58MHx8fHwxNjI3ODE0Nzc1&ixlib=rb-1.2.1&q=85",
  "https://images.unsplash.com/photo-1542282088-fe8426682b8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNTA2MzZ8MHwxfHNlYXJjaHw2fHxjYXJ8ZW58MHx8fHwxNjI3ODE0Nzc1&ixlib=rb-1.2.1&q=80&w=1080",
  "https://images.unsplash.com/photo-1485291571150-772bcfc10da5?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNTA2MzZ8MHwxfHNlYXJjaHw0fHxjYXJ8ZW58MHx8fHwxNjI3ODE0Nzc1&ixlib=rb-1.2.1&q=85",
  "https://images.unsplash.com/photo-1494976388531-d1058494cdd8?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNTA2MzZ8MHwxfHNlYXJjaHwzfHxjYXJ8ZW58MHx8fHwxNjI3ODE0Nzc1&ixlib=rb-1.2.1&q=85",
  "https://images.unsplash.com/photo-1493238792000-8113da705763?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNTA2MzZ8MHwxfHNlYXJjaHwyfHxjYXJ8ZW58MHx8fHwxNjI3ODE0Nzc1&ixlib=rb-1.2.1&q=85",
  "https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNTA2MzZ8MHwxfHNlYXJjaHwxfHxjYXJ8ZW58MHx8fHwxNjI3ODE0Nzc1&ixlib=rb-1.2.1&q=85"
];
void main() {
  runApp(GeeksForGeeks());
}

class GeeksForGeeks extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey[900],
            title: Center(
              child: Text(
                'Flutter GridView Demo',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          body: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                child: Image.network(
                  data[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          )),
    );
  }
}
