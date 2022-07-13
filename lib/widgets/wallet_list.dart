import 'package:flutter/material.dart';
import 'package:poc_wallet_flutter/widgets/wallet_card.dart';

class WalletList extends StatelessWidget {
  const WalletList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) =>
          const WalletCard(name: 'Donut Shop',
            cardNo: 'XXXXXX-9999',
            height: 150,
            color: Colors.white,),
    );
  }
}
