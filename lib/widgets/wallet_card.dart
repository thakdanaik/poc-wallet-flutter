import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final String name;
  final String? cardNo;
  final double height;
  final double verticalMargin;
  final Color color;
  final bool isShowShadow;
  final bool isMultipleCard;

  const WalletCard({
    Key? key,
    required this.name,
    required this.height,
    required this.color,
    required this.verticalMargin,
    this.cardNo,
    this.isShowShadow = true,
    this.isMultipleCard = false,
  }) : super(key: key);

  Color get textColor =>
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: verticalMargin),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (isMultipleCard) multipleCardBackground(),
          Container(
            height: isMultipleCard ? height * 0.85 : height,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.black, width: 0.2),
              boxShadow: isShowShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withAlpha(100),
                        blurRadius: 10,
                      ),
                    ]
                  : null,
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
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: textColor)),
                    if (cardNo != null)
                      Text(cardNo!, style: TextStyle(color: textColor)),
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
          ),
        ],
      ),
    );
  }

  Widget multipleCardBackground() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: color.withAlpha(100),
            border: Border.all(color: Colors.black, width: 0.2),
            boxShadow: isShowShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 10,
                    ),
                  ]
                : null,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        Container(
          height: height * 0.925,
          decoration: BoxDecoration(
            color: color.withAlpha(100),
            border: Border.all(color: Colors.black, width: 0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
