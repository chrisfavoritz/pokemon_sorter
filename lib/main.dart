import 'package:flutter/material.dart';
import 'package:pokemon_sorter/home.dart';
import 'package:pokemon_sorter/services/service_locator.dart';



const kLitePrimaryColor = Color(0xFF92E3E7);
const kBGColor = Color(0xFFE3FDFF);
const kDarkPrimaryColor = Color(0xFF32C7D0);
const kBGGradient = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [kBGColor, kDarkPrimaryColor]),
);
const kEndBGGradient = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [kBGColor, kLitePrimaryColor]),
);
const kTextStyle = TextStyle(
  color: Colors.white,
  letterSpacing: 5,
  fontSize: 15,
  fontWeight: FontWeight.w300,
);


void main() {
 setupGetIt();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kLitePrimaryColor,
        textTheme: const TextTheme(
          bodyText1:  TextStyle(
              color: Colors.white
          ),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.blue,
        ),
      ),
      home: Home(),
    );
  }
}
