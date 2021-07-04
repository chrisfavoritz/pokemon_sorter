import 'package:flutter/material.dart';
import 'package:pokemon_sorter/cards/cards.dart';
import 'package:pokemon_sorter/cards/card_sorter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key:key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CardSorter cardSorter = CardSorter();

  @override
  void initState() {
    super.initState();
    print('initState called');
    cardSorter.valueList();
    cardSorter.initCardState();
    print('initState completed cardSorter length = ${cardSorter.cardSorter.length}');
  }

  @override
  void dispose() {
   // sorter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            LeftCard(),
            RightCard(),
          ],
        ),
      ),
    );
  }
}

