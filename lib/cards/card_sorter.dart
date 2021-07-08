// import 'package:flutter/cupertino.dart';
// import 'package:pokemon_sorter/services/data.dart';
//
// class CardSorter {
//
//   int lcn = 1;
//   int rcn = 2;
//   var leftImage = ValueNotifier<String>("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png");
//   var rightImage = ValueNotifier<String>("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png");
//
//   var leftName = ValueNotifier<String>("loading");
//   var rightName = ValueNotifier<String>("loading");
//
//   int shiftCutOff =0;
//   int sortCutOff =0;
//
//   //these are not being emptied but returned to their initial value
//   var values =ValueNotifier<List<int>>([]);
//   List<Sorter> cardSorter = <Sorter>[];
//   var valuesSet = <int>{};
//
//   void makeValueList() {
//     for (int i = 0; i < 25; i++) {
//       values.value.add(25 + 1);
//     }
//     valuesSet = values.value.toSet();
//     print('valueList complete values.length = ${values.value.length}, valueSet.length = ${valuesSet.length}, ');
//     makeCardSorter();
//   }
//
//   void makeCardSorter() {
//     print('valueSet length = ${valuesSet.length}');
//     for (int i = 0; i < valuesSet.length; i++) {
//       cardSorter.add(Sorter(values.value[i], i));
//     }
//     print('makeCardSorter complete cardSorter.length = ${cardSorter.length}');
//   }
//
//   void leftCardTapped() {
//     print('leftCardTapped called, valuesSet length = ${valuesSet.length} cardSorter length = ${cardSorter.length}, values length = ${values.value.length}, lcn= $lcn, rcn = $rcn');
//     lcn++;
//     setBodyLeft();
//   }
//
//   void setBodyLeft() async {
//     Data data = Data();
//     var decodedData =  await data.getData(lcn);
//       leftImage.value = decodedData['sprites']['front_default'];
//     leftName.value = decodedData['name'];
//   }
//
//   void rightCardTapped() {
//     print('rightCardTapped called, valuesSet length = ${valuesSet.length} cardSorter length = ${cardSorter.length}, values length = ${values.value.length}, lcn= $lcn, rcn = $rcn');
//     rcn++;
//     setBodyRight();
//   }
//
//   void setBodyRight() async {
//     Data data = Data();
//     var decodedData =  await data.getData(rcn);
//       rightImage.value = decodedData['sprites']['front_default'] as String;
//     rightName.value = decodedData['name'] as String;
//   }
// }
