import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultsList extends StatelessWidget {
  final List<String> names;
  final List<String> imageUrls;

  ResultsList({Key? key, required this.names, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      //passing in the ListView.builder
      body:
      GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Card(
            child: GridTile(
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Text((index+1).toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ), ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Image.network(imageUrls[index]),
                        Text(names[index].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}