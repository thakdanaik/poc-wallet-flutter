import 'package:flutter/material.dart';
import 'package:poc_wallet_flutter/widgets/wallet_card.dart';

class WalletList extends StatelessWidget {
  const WalletList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 30),
      itemCount: 5+1,
      itemBuilder: (context, index) {
        if(index == 5){
          return const SizedBox(height: 50,);
        }

        return const Align(
          heightFactor: 0.7,
          child: WalletCard(name: 'Donut Shop',
            cardNo: 'XXXXXX-9999',
            height: 150,
            color: Colors.white,),
        );
      }
    );
  }
}
