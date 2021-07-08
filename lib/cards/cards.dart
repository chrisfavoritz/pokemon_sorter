import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_sorter/services/service_locator.dart';
import 'package:pokemon_sorter/cards/card_sorter.dart';

class Cards extends StatelessWidget {
  const Cards({Key? key, required this.onPressed, required this.name, required this.image}) : super(key:key);
//should there be constructors for functions or anything here?
final VoidCallback onPressed;
final String name;
final String image;

  @override
  Widget build(BuildContext context) {
    //  final cardSorter = getIt<CardSorter>();

    //make these futurebuilders


    return Container(
      color: Colors.lightBlueAccent,
      child: GestureDetector(
        onTap:  onPressed,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Container(
            decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            child: Image.network(image,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              fit: BoxFit.fitWidth,),
          ),
             Text(name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
             ),
          ],
        ),
      ),
    );
  }
}

// class RightCard extends StatelessWidget {
//   const RightCard({Key? key}) : super(key:key);
//
//   @override
//   Widget build(BuildContext context) {
//    // final sorter = getIt<CardSorter>();
//
//     return ValueListenableBuilder(
//         valueListenable: sorter.rightImage,
//         builder: (context, value, child){
//           return Container(
//             color: Colors.lightBlueAccent,
//             child: GestureDetector(
//               onTap: () {
//                 //final sorter = getIt<CardSorter>();
//                 sorter.rightCardTapped();
//               },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.redAccent,
//                   ),
//                   child: Image.network(sorter.rightImage.value,
//                     width: MediaQuery.of(context).size.width * 0.5,
//                     fit: BoxFit.fitWidth,),
//                 ),
//                   ValueListenableBuilder(
//                       valueListenable: sorter.rightName,
//                       builder: (context, value,child) {
//                         return Text(sorter.rightName.value.toUpperCase(),
//                           style: const TextStyle(
//                             color: Colors.black,
//                           ),);
//                       }
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }