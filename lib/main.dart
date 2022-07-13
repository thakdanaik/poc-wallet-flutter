import 'package:flutter/material.dart';
import 'package:poc_wallet_flutter/widgets/wallet_list.dart';

import 'models/card_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final List<CardData> _cardData = [
    CardData(name: 'Donut Shop', cardNo: 'xxxxxx-9999', cardColor: Colors.pink),
    CardData(name: 'Sushi Shop', cardNo: 'xxxxxx-9999', cardColor: Colors.white),
    CardData(name: 'Cola Shop', cardNo: 'xxxxxx-9999', cardColor: Colors.black),
    CardData(name: 'Beer Shop', cardNo: 'xxxxxx-9999', cardColor: Colors.yellow, isMultiCard: true),
    CardData(name: 'Popcorn Shop', cardNo: 'xxxxxx-9999', cardColor: Colors.orange),
    CardData(name: 'Chicken Shop', cardNo: 'xxxxxx-9999', cardColor: Colors.brown),
    CardData(name: 'Duck Shop', cardColor: Colors.grey),
    CardData(name: 'Gun Shop', cardColor: Colors.red),
    CardData(name: 'Bread Shop', cardNo: 'xxxxxx-9999', cardColor: Colors.lime),
    CardData(name: 'Barber Shop', cardNo: 'xxxxxx-9999', cardColor: Colors.black, isMultiCard: true),
    CardData(name: 'A Bank', cardNo: 'xxxxxx-9999', cardColor: Colors.purple),
    CardData(name: 'B Bank', cardNo: 'xxxxxx-9999', cardColor: Colors.green),
    CardData(name: 'ID Card', cardNo: 'xxxxxx-9999', cardColor: Colors.blue),
    CardData(name: 'Coupon Card', cardColor: Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Wallet')),
        body: SafeArea(
          child: WalletList(
            cardHeight: 150,
            cardHeightFactor: 0.7,
            dataList: _cardData,
          ),
        ),
      ),
    );
  }
}
