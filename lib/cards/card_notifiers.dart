import 'package:flutter/cupertino.dart';
import 'package:pokemon_sorter/services/data.dart';
import 'package:pokemon_sorter/services/service_locator.dart';
import 'package:pokemon_sorter/services/storage_service.dart';

//don't think I need to save undo stuff but need current details to initialize then
//cardSorter, values, valueSet probably..

class LeftCardNotifier extends ValueNotifier<int> {
  LeftCardNotifier() : super(_initialLCNValue);

  static const int _initialLCNValue = 0;
  //this was private
  int currentLeftCardValue = _initialLCNValue;
  final _storageService = getIt<StorageService>();

  var leftImage = ValueNotifier<String>("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png");
 var leftName = ValueNotifier<String>("loading");

  Future<void> initialize() async {
    final savedLCN = await _storageService.getLeftCardNumber() ?? _initialLCNValue;
    updateLeftCard(savedLCN);
    notifyListeners();
  }

  void start({required Function onDone}) {
    updateLeftCard(currentLeftCardValue);
    notifyListeners();
  }
  
//this was private
  void updateLeftCard(int lcn) async {
    //should this set name and image
    print('update left card');
    value = lcn;
    currentLeftCardValue = lcn;
    Data data = Data();
    var decodedData =  await data.getData(lcn+1);
    leftImage.value = decodedData['sprites']['front_default'];
    leftName.value = decodedData['name'];
    notifyListeners();
  }
}






class RightCardNotifier extends ValueNotifier<int> {
  RightCardNotifier() : super(_initialRCNValue);

  static const int _initialRCNValue = 0;
  int currentRightCardValue = _initialRCNValue;
  final _storageService = getIt<StorageService>();

 var rightImage = ValueNotifier<String>("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png");
  var rightName = ValueNotifier<String>("loading");

  Future<void> initialize() async {
    final savedRCN = await _storageService.getRightCardNumber() ?? _initialRCNValue;
    updateRightCard(savedRCN);
  }

  void start({required Function onDone}) {
    updateRightCard(currentRightCardValue);
  }


  void updateRightCard(int rcn) async {
    //should this set name and image
    value = rcn;
    currentRightCardValue = rcn;
    Data data = Data();
    var decodedData =  await data.getData(rcn+1);
    rightImage.value = decodedData['sprites']['front_default'];
    rightName.value = decodedData['name'];
  }
}
