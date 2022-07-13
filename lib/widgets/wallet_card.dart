import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final String name;
  final String cardNo;
  final double height;

  const WalletCard(
      {Key? key,
      required this.name,
      required this.cardNo,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 10,
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //----- Card Detail -----//
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold)),
              Text(cardNo),
            ],
          ),
          //----- Card Detail -----//
          //
          //------ Card Logo ------//
          const Align(
            alignment: Alignment.topRight,
            child: FlutterLogo(size: 50),
          ),
          //------ Card Logo ------//
        ],
      ),
    );
  }
}
