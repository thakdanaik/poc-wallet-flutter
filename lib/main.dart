import 'package:flutter/material.dart';
import 'package:poc_wallet_flutter/widgets/wallet_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Wallet')),
        body: const SafeArea(
          child: WalletCard(
            name: 'Donut Shop',
            cardNo: 'XXXXXX-9999',
            height: 150,
          ),
        ),
      ),
    );
  }
}
