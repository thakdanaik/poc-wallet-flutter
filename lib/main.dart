import 'package:flutter/material.dart';
import 'package:poc_wallet_flutter/widgets/wallet_list.dart';

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
          child: WalletList(
            cardHeight: 150,
            cardHeightFactor: 0.7,
          ),
        ),
      ),
    );
  }
}
