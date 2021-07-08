import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokemon_sorter/cards/cards.dart';
import 'package:pokemon_sorter/cards/card_sorter.dart';
import 'package:pokemon_sorter/lists/results_list.dart';
import 'package:pokemon_sorter/services/data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key:key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Cards(onPressed: leftCardTapped, name: leftName, image: leftImage),
            Cards(onPressed: rightCardTapped, name: rightName, image: rightImage),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    setCards();
    makeValueList();
    makeNameList();
    super.initState();
    print('initState completed cardSorter length = ${cardSorter.length}');

  }

  @override
  void dispose() {
   // sorter.dispose();
    super.dispose();
  }

  int lcn = 0;
  int rcn = 1;
  var leftImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png";
  var rightImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png";

  var leftName = "loading";
  var rightName = "loading";
  int numberInSorter = 2;
  int shiftCutOff =0;
  int sortCutOff =0;

  //these are not being emptied but returned to their initial value
  List<int> values = [];
  List<Sorter> cardSorter = <Sorter>[];
  var valuesSet = <int>{};
  int numberOfObjects = 151;
  int tapCounter = 0;

  void makeValueList() {
    for (int i = 0; i < numberOfObjects; i++) {
      values.add(numberOfObjects + 1);
    }
    valuesSet = values.toSet();
    print('valueList complete values.length = ${values.length}, valueSet.length = ${valuesSet.length}, ');
    makeCardSorter();
  }

  void makeCardSorter() {
    print('valueSet length = ${valuesSet.length}');
    for (int i = 0; i < valuesSet.length; i++) {
      cardSorter.add(Sorter(values[i], i));
    }
    print('makeCardSorter complete cardSorter.length = ${cardSorter.length}');
  }

  void sortCardSorter() {
    cardSorter.sort((a, b) => b.value.compareTo(a.value));
  }

  void clearCardSorter() {
    cardSorter.clear();
  }

  void reduceCardSorterLeftTap() {
    //could just remove the indexes above and disregard values
    sortCutOff = values[lcn];
    for (int i = cardSorter.length - 1; i > -1; i--) {
      if (cardSorter[i].value >= sortCutOff) {
        cardSorter.removeAt(i);
      }
    }
  }

  void reduceCardSorterRightTap() {
    sortCutOff = values[lcn];
    for (int i = cardSorter.length - 1; i > -1; i--) {
      if (cardSorter[i].value <= sortCutOff) {
        cardSorter.removeAt(i);
      }
    }
  }

  void shiftValues() {
    for (int i = 0; i < values.length; i++) {
      if (values[i] > shiftCutOff) {
        values[i]++;
      }
    }
  }

  void setCards() async {
    //could make this return the widget and have circular progress indicator while loading
    print('setCards');
    Data data = Data();
    var decodedDataLeft =  await data.getData(lcn+1);
    var decodedDataRight =  await data.getData(rcn+1);
    setState(() {
      leftName = decodedDataLeft['name'];
      rightName = decodedDataRight['name'] as String;
      rightImage = decodedDataRight['sprites']['front_default'] as String;
      leftImage = decodedDataLeft['sprites']['front_default'] as String;
    });
  }

  void getMiddleCard() {
    setState(() {
      if (cardSorter.length == 0) {
      } else if (cardSorter.length == 1) {
        lcn = cardSorter[0].index;
      } else if (cardSorter.length.isEven) {
        lcn = cardSorter[((cardSorter.length) / 2).round()].index;
      } else {
        lcn = cardSorter[(((cardSorter.length) / 2).round()) - 1].index;
      }
      rcn = numberInSorter - 1;
      values[rcn] = values[lcn];
    });
  }

  void checkIfDone() {
    valuesSet.clear();
    valuesSet = values.toSet();
    print('tapcounter = $tapCounter');
    print('values.length =${values.length}, valuesSet=${valuesSet.length}, numberInSorter = $numberInSorter');
    if (values.length == valuesSet.length) {
     // timer.stop();
      print('done - go to results page');
      makeResultList();
      sortResultList();
      makeFinalResultList();
      clearResultList();
      print('tapcounter = $tapCounter');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsList(names: names,imageUrls: imageNames,),
        ),
      );
    } else {
      nextCard();
    }
  }

  void nextCard() {
    //undoNumInSorter = numberInSorter;
    if (numberInSorter == valuesSet.length) {
      clearCardSorter();
      makeCardSorter();
      sortCardSorter();
      numberInSorter++;
      getMiddleCard();
    } else {}
  }

  void leftCardTapped() {
    tapCounter++;
    print('leftCardTapped called, valuesSet length = ${valuesSet.length} cardSorter length = ${cardSorter.length}, values length = ${values.length}, lcn= $lcn, rcn = $rcn');
    setState(() {
      if (cardSorter.length == 1) {
        if (values[rcn] == values.reduce(min)) {
          values[rcn] = values[lcn] - 1;
        } else {
          shiftCutOff = values[lcn];
          shiftValues();
          values[lcn]++;
          values[rcn] = values[lcn] - 1;
        }
      } else if (cardSorter.length == 2) {
        if (values[lcn] == values.reduce(min)) {
          values[rcn] = values[lcn] - 1;
        } else {
          shiftCutOff = values[lcn];
          shiftValues();
          values[lcn]++;
          values[rcn] = values[lcn] - 1;
        }
      } else {
        reduceCardSorterLeftTap();
        if (cardSorter.length == 0) {
          shiftCutOff = values[lcn];
          shiftValues();
          values[rcn] = values[lcn] - 1;
        } else {
          getMiddleCard();
        }
      }
      checkIfDone();
    });
    setCards();
  }

  void rightCardTapped() {
    tapCounter++;
    print('rightCardTapped called, valuesSet length = ${valuesSet.length} cardSorter length = ${cardSorter.length}, values length = ${values.length}, lcn= $lcn, rcn = $rcn');
    if (cardSorter.length == 1) {
      if (values[lcn] == values.reduce(max)) {
        values[rcn] = values[lcn] + 1;
      } else {
        shiftCutOff = values[lcn];
        shiftValues();
        values[rcn] = values[lcn] + 1;
      }
    } else if (cardSorter.length == 2) {
      if (values[lcn] == values.reduce(max)) {
        values[rcn] = values[lcn] + 1;
      } else {
        reduceCardSorterRightTap();
        getMiddleCard();
      }
    } else {
      reduceCardSorterRightTap();
      if (cardSorter.length == 0) {
        shiftCutOff = lcn;
        shiftValues();
        values[rcn] = values[lcn] + 1;
      } else {
        getMiddleCard();
      }
    }
    checkIfDone();
    setCards();
  }

  List<FinalResult> results = [];
  List<String> names = [];
  String newName = '';
  List<String> imageNames = [];
  String newImageName = '';
  void makeNameList() async {
    Data data = Data();
    for (int i = 0; i < (values.length); i++) {
      var decodedData =  await data.getData(i+1);
      newName =  decodedData['name'];
      names.add(newName);
      newImageName =  decodedData['sprites']['front_default'] as String;
      imageNames.add(newImageName);
  }
  }

  void makeResultList() {
    for (int i = 0; i < (valuesSet.length); i++) {
      results.add(FinalResult(values[i], names[i], imageNames[i]));
    }
  }

  void sortResultList() {
    results.sort((a, b) => b.value.compareTo(a.value));
  }

  void makeFinalResultList() {
    names.clear();
    for (int i = 0; i < (results.length); i++) {
      names.add(results[i].name);
    }
    imageNames.clear();
    for (int i = 0; i < (results.length); i++) {
      imageNames.add(results[i].imageName);
    }
  }

  void clearResultList() {
    results.clear();
  }
  
  
}


class Sorter {
  int value;
  final int index;
  Sorter(this.value, this.index);
}

class FinalResult {
  int value;
  final String name;
  final String imageName;
  FinalResult(this.value, this.name, this.imageName);
}