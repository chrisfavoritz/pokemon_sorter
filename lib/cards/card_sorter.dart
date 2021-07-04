import 'package:flutter/cupertino.dart';
import 'package:pokemon_sorter/cards/card_notifiers.dart';
import 'package:pokemon_sorter/services/data.dart';
import 'dart:math';

class CardSorter {

  final lcnNotifier = LeftCardNotifier();
  final rcnNotifier = RightCardNotifier();

  void initCardState() {
    lcnNotifier.initialize();
    rcnNotifier.initialize();
    //setCardState();
  }

  int lcn = 0;
  int rcn = 1;
  int numberInSorter = 2;
  //changed to 0 from uninitialized
int shiftCutOff =0;
int sortCutOff =0;
List<int> values = [];
List<Sorter> cardSorter = <Sorter>[];
  var valuesSet = <int>{};

//switched favpicz.length to 25 (would be 151)
  void valueList() {
    for (int i = 0; i < 25; i++) {
      values.add(25 + 1);
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
    print('reduceCardSorterLeftTap start cardSorter.length = ${cardSorter.length}');
    //could just remove the indexes above and disregard values
    sortCutOff = values[lcn];
    for (int i = cardSorter.length - 1; i > -1; i--) {
      //could be one statement
      if (cardSorter[i].value > sortCutOff) {
        cardSorter.removeAt(i);
      } else if (cardSorter[i].value == sortCutOff) {
        cardSorter.removeAt(i);
      }
    }
    print('reduceCardSorterLeftTap complete cardSorter.length = ${cardSorter.length}');
  }

  void reduceCardSorterRightTap() {
    print('reduceCardSorterRightTap start cardSorter.length = ${cardSorter.length}');
    sortCutOff = values[lcn];
    for (int i = cardSorter.length - 1; i > -1; i--) {
      if (cardSorter[i].value < sortCutOff) {
        //could be one statement
        cardSorter.removeAt(i);
      } else if (cardSorter[i].value == sortCutOff) {
        cardSorter.removeAt(i);
      }
    }
    print('reduceCardSorterRightTap complete cardSorter.length = ${cardSorter.length}');
  }

  void shiftValues() {
    print('shiftValues');
    for (int i = 0; i < values.length; i++) {
      if (values[i] > shiftCutOff) {
        values[i]++;
      }
    }
  }

  void getMiddleCard() {
    print('getMiddleCard start');
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
    setCardState();
    print('getMiddleCard complete values[rcn] = ${values[rcn]}, values[lcn] = ${values[lcn]}');
}

void checkIfDone() {
    print('checkIfDone called');
  valuesSet.clear();
  valuesSet = values.toSet();
  print('values.length =${values.length}, valuesSet=${valuesSet.length}, numberInSorter = $numberInSorter');
  if (values.length == valuesSet.length) {
    //timer.stop();
    //_toResultsPage();
  } else {
    nextCard();
  }
}

void nextCard() {
    print('nextCard called');
 // undoNumInSorter = numberInSorter;
  if (numberInSorter == valuesSet.length) {
    clearCardSorter();
    makeCardSorter();
    sortCardSorter();
    numberInSorter++;
    getMiddleCard();
  } else {
    print('number in sorter does not equal valuesSet length');
  }
}

  void leftCardTapped() {
   print('leftCardTapped called, valuesSet length = ${valuesSet.length} cardSorter length = ${cardSorter.length}');
    //lcnNotifier.currentLeftCardValue++;
   lcn++;
    //makeCardSorter();

  //   undoVisibility = true;
  // undoButtonColor = kLitePrimaryColor.withOpacity(1);
  // tapCounter++;
  // setUndo();
  // if (cardSorter.length == 1) {
  //   if (values[rcn] == values.reduce(min)) {
  //     print('leftCardTapped cardsorter length = 1, values[rcn] is min');
  //     values[rcn] = values[lcn] - 1;
  //   } else {
  //     print('leftCardTapped cardsorter length = 1, values[rcn] is not min');
  //     shiftCutOff = values[lcn];
  //     shiftValues();
  //     values[lcn]++;
  //     values[rcn] = values[lcn] - 1;
  //   }
  // } else if (cardSorter.length == 2) {
  //   if (values[lcn] == values.reduce(min)) {
  //     print('leftCardTapped cardsorter length = 2, values[rcn] is min');
  //     values[rcn] = values[lcn] - 1;
  //   } else {
  //     print('leftCardTapped cardsorter length = 2, values[rcn] is not min');
  //     shiftCutOff = values[lcn];
  //     shiftValues();
  //     values[lcn]++;
  //     values[rcn] = values[lcn] - 1;
  //   }
  // } else {
  //   reduceCardSorterLeftTap();
  //   if (cardSorter.length == 0) {
  //     shiftCutOff = values[lcn];
  //     shiftValues();
  //     values[rcn] = values[lcn] - 1;
  //   } else {
  //     getMiddleCard();
  //   }
  // }
  // checkIfDone();
    print('leftCardTapped complete');
  // rcVisibility = true;
  // lcVisibility = true;
  }

  void rightCardTapped() {
    print('leftCardTapped called, valuesSet length = ${valuesSet.length} cardSorter length = ${cardSorter.length}, values length = ${values.length}, lcn= $lcn, rcn = $rcn');
    makeCardSorter();
    print('rightCardTapped called');
    //   undoVisibility = true;
//   undoButtonColor = kLitePrimaryColor.withOpacity(1);
//   tapCounter++;
//   setUndo();
  if (cardSorter.length == 1) {
    if (values[lcn] == values.reduce(max)) {
      print('rightCardTapped cardsorter length = 1, values[lcn] is max');
      values[rcn] = values[lcn] + 1;
    } else {
      print('rightCardTapped cardsorter length = 1, values[lcn] is not max');
      shiftCutOff = values[lcn];
      shiftValues();
      values[rcn] = values[lcn] + 1;
    }
  } else if (cardSorter.length == 2) {
    if (values[lcn] == values.reduce(max)) {
      print('rightCardTapped cardsorter length = 2, values[lcn] is max');
      values[rcn] = values[lcn] + 1;
    } else {
      print('rightCardTapped cardsorter length = 1, values[lcn] is not max');
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
  print('rightCardTapped complete');
//   rcVisibility = true;
//   lcVisibility = true;
  }

  void setCardState() {
    print('setCardState lcn = $lcn, rcn = $rcn');
    // setBodyLeft();
    // setBodyRight();
    lcnNotifier.updateLeftCard(lcnNotifier.currentLeftCardValue);
    rcnNotifier.updateRightCard(rcnNotifier.currentRightCardValue);
  }

//   var leftImage = ValueNotifier<String>("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png");
//   var rightImage = ValueNotifier<String>("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png");
//
//   var leftName = ValueNotifier<String>("loading");
//   var rightName = ValueNotifier<String>("loading");
//
//   void setBodyLeft() async {
//     Data data = Data();
//     var decodedData =  await data.getData(lcn+1);
//       leftImage.value = decodedData['sprites']['front_default'];
//     leftName.value = decodedData['name'];
//   }
//
//   void setBodyRight() async {
//     Data data = Data();
//     var decodedData =  await data.getData(rcn+1);
//       rightImage.value = decodedData['sprites']['front_default'];
//     rightName.value = decodedData['name'];
//   }
}

class Sorter {
  int value;
  final int index;

  Sorter(this.value, this.index);
}

//// int lcn = 0;
//// int rcn = 1;
//
//// int numberInSorter = 2;
//// int shiftCutOff;
//// int sortCutOff;
//
//// List<int> values = [];
//// List<Sorter> cardSorter = [];
//// var valuesSet;
//
// int undoLCN;
// int undoRCN;
// int undoNumInSorter;
// List<int> undoValues = [];
// List<Sorter> _undoCardSorter = [];
// List<File> undofavpicz = [];
//
// void setUndo() {
//   undofavpicz = List.from(favpicz);
//   undoLCN = lcn;
//   undoRCN = rcn;
//   undoValues = List.from(values);
//   _undoCardSorter = List.from(cardSorter);
// }
//
// void undo() {
//   tapCounter--;
//   setState(() {
//     favpicz = List.from(undofavpicz);
//     lcn = undoLCN;
//     rcn = undoRCN;
//     numberInSorter = undoNumInSorter;
//     values = List.from(undoValues);
//     valuesSet = values.toSet();
//     cardSorter = List.from(_undoCardSorter);
//     undoButtonColor = kLitePrimaryColor.withOpacity(0.50);
//   });
// }
//
// Color undoButtonColor;
//
//// void valueList() {
//   for (int i = 0; i < favpicz.length; i++) {
//     values.add(favpicz.length + 1);
//   }
//   valuesSet = values.toSet();
//   makeCardSorter();
// }
//
//// void makeCardSorter() {
//   for (int i = 0; i < valuesSet.length; i++) {
//     cardSorter.add(Sorter(values[i], i));
//   }
// }
//
//// void sortCardSorter() {
//   cardSorter.sort((a, b) => b.value.compareTo(a.value));
// }
//
//// void clearCardSorter() {
//   cardSorter.clear();
// }
//
//// void reduceCardSorterLeftTap() {
//   //could just remove the indexes above and disregard values
//   sortCutOff = values[lcn];
//   for (int i = cardSorter.length - 1; i > -1; i--) {
//     //could be one statement
//     if (cardSorter[i].value > sortCutOff) {
//       cardSorter.removeAt(i);
//     } else if (cardSorter[i].value == sortCutOff) {
//       cardSorter.removeAt(i);
//     }
//   }
// }
//
//// void reduceCardSorterRightTap() {
//   sortCutOff = values[lcn];
//   for (int i = cardSorter.length - 1; i > -1; i--) {
//     if (cardSorter[i].value < sortCutOff) {
//       //could be one statement
//       cardSorter.removeAt(i);
//     } else if (cardSorter[i].value == sortCutOff) {
//       cardSorter.removeAt(i);
//     }
//   }
// }
//
//// void shiftValues() {
//   for (int i = 0; i < values.length; i++) {
//     if (values[i] > shiftCutOff) {
//       values[i]++;
//     }
//   }
// }
//
// void _leftCardTapped() {
//   undoVisibility = true;
//   undoButtonColor = kLitePrimaryColor.withOpacity(1);
//   tapCounter++;
//   setUndo();
//   if (cardSorter.length == 1) {
//     if (values[rcn] == values.reduce(min)) {
//       values[rcn] = values[lcn] - 1;
//     } else {
//       shiftCutOff = values[lcn];
//       shiftValues();
//       values[lcn]++;
//       values[rcn] = values[lcn] - 1;
//     }
//   } else if (cardSorter.length == 2) {
//     if (values[lcn] == values.reduce(min)) {
//       values[rcn] = values[lcn] - 1;
//     } else {
//       shiftCutOff = values[lcn];
//       shiftValues();
//       values[lcn]++;
//       values[rcn] = values[lcn] - 1;
//     }
//   } else {
//     reduceCardSorterLeftTap();
//     if (cardSorter.length == 0) {
//       shiftCutOff = values[lcn];
//       shiftValues();
//       values[rcn] = values[lcn] - 1;
//     } else {
//       getMiddleCard();
//     }
//   }
//   checkIfDone();
//   rcVisibility = true;
//   lcVisibility = true;
// }
//
// void _rightCardTapped() {
//   undoVisibility = true;
//   undoButtonColor = kLitePrimaryColor.withOpacity(1);
//   tapCounter++;
//   setUndo();
//   if (cardSorter.length == 1) {
//     if (values[lcn] == values.reduce(max)) {
//       values[rcn] = values[lcn] + 1;
//     } else {
//       shiftCutOff = values[lcn];
//       shiftValues();
//       values[rcn] = values[lcn] + 1;
//     }
//   } else if (cardSorter.length == 2) {
//     if (values[lcn] == values.reduce(max)) {
//       values[rcn] = values[lcn] + 1;
//     } else {
//       reduceCardSorterRightTap();
//       getMiddleCard();
//     }
//   } else {
//     reduceCardSorterRightTap();
//     if (cardSorter.length == 0) {
//       shiftCutOff = lcn;
//       shiftValues();
//       values[rcn] = values[lcn] + 1;
//     } else {
//       getMiddleCard();
//     }
//   }
//   checkIfDone();
//   rcVisibility = true;
//   lcVisibility = true;
// }
//
// int tapCounter = 0;
//
// void getMiddleCard() {
//   setState(() {
//     if (cardSorter.length == 0) {
//     } else if (cardSorter.length == 1) {
//       lcn = cardSorter[0].index;
//     } else if (cardSorter.length.isEven) {
//       lcn = cardSorter[((cardSorter.length) / 2).round()].index;
//     } else {
//       lcn = cardSorter[(((cardSorter.length) / 2).round()) - 1].index;
//     }
//     rcn = numberInSorter - 1;
//     values[rcn] = values[lcn];
//   });
// }
//
// void checkIfDone() {
//   valuesSet.clear();
//   valuesSet = values.toSet();
//   print('values.length =${values.length}, valuesSet=${valuesSet.length}, numberInSorter = $numberInSorter');
//   if (values.length == valuesSet.length) {
//     timer.stop();
//     _toResultsPage();
//   } else {
//     nextCard();
//   }
// }
//
// void nextCard() {
//   undoNumInSorter = numberInSorter;
//   if (numberInSorter == valuesSet.length) {
//     clearCardSorter();
//     makeCardSorter();
//     sortCardSorter();
//     numberInSorter++;
//     getMiddleCard();
//   } else {}
// }