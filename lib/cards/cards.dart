import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_sorter/services/service_locator.dart';
import 'package:pokemon_sorter/cards/card_sorter.dart';

class LeftCard extends StatelessWidget {
  const LeftCard({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final cardSorter = getIt<CardSorter>();

    return ValueListenableBuilder(
        valueListenable: cardSorter.lcnNotifier.leftImage,
        builder: (context, value, child){
      return Container(
        color: Colors.lightBlueAccent,
        child: GestureDetector(
          onTap: () {
            final sorter = getIt<CardSorter>();
            sorter.leftCardTapped();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Image.network(cardSorter.lcnNotifier.leftImage.value,
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.fitWidth,),
            ),
              ValueListenableBuilder(
                valueListenable: cardSorter.lcnNotifier.leftName,
                builder: (context, value,child) {
                  return Text(cardSorter.lcnNotifier.leftName.value.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),);
                }
              ),
            ],
          ),
        ),
      );
    });
  }
}

class RightCard extends StatelessWidget {
  const RightCard({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final sorter = getIt<CardSorter>();

    return ValueListenableBuilder(
        valueListenable: sorter.rcnNotifier.rightImage,
        builder: (context, value, child){
          return Container(
            color: Colors.lightBlueAccent,
            child: GestureDetector(
              onTap: () {
                final sorter = getIt<CardSorter>();
                sorter.rightCardTapped();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Container(
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  child: Image.network(sorter.rcnNotifier.rightImage.value,
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.fitWidth,),
                ),
                  ValueListenableBuilder(
                      valueListenable: sorter.rcnNotifier.rightName,
                      builder: (context, value,child) {
                        return Text(sorter.rcnNotifier.rightName.value.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                          ),);
                      }
                  ),
                ],
              ),
            ),
          );
        });
  }
}