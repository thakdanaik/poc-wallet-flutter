import 'dart:math';

import 'package:flutter/material.dart';

class WalletCard extends StatefulWidget {
  final int index;
  final String name;
  final String? cardNo;
  final double height;
  final double verticalMargin;
  final Color color;
  final bool isMultipleCard;
  final double cardHeightFactor;
  final ScrollController scrollController;

  const WalletCard({
    Key? key,
    required this.name,
    required this.height,
    required this.color,
    required this.verticalMargin,
    this.cardNo,
    this.isMultipleCard = false,
    required this.cardHeightFactor,
    required this.scrollController,
    required this.index,
  }) : super(key: key);

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  Color get textColor =>
      widget.color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  double get _remainingHeight =>
      ((widget.height + (widget.verticalMargin * 2)) * widget.cardHeightFactor);

  final ValueNotifier<double> _translateOffset = ValueNotifier<double>(0);

  @override
  void initState() {
    widget.scrollController.addListener(() {
      int indexAtTop =
          max(0, (widget.scrollController.offset / _remainingHeight).floor());

      if (indexAtTop == widget.index) {
        _translateOffset.value =
            widget.scrollController.offset - (_remainingHeight * widget.index);
      } else {
        _translateOffset.value = 0;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _translateOffset,
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
      child: Align(
        heightFactor: widget.cardHeightFactor,
        alignment: Alignment.topCenter,
        child: Container(
          height: widget.height,
          margin: EdgeInsets.symmetric(
              horizontal: 20, vertical: widget.verticalMargin),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              if (widget.isMultipleCard) multipleCardBackground(),
              Container(
                height: widget.isMultipleCard
                    ? widget.height * 0.85
                    : widget.height,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: widget.color,
                  border: Border.all(color: Colors.black, width: 0.2),
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
                        Text(widget.name,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: textColor)),
                        if (widget.cardNo != null)
                          Text(widget.cardNo!,
                              style: TextStyle(color: textColor)),
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
        ),
      ),
    );
  }

  Widget multipleCardBackground() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.color.withAlpha(100),
            border: Border.all(color: Colors.black, width: 0.2),
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
        ),
        Container(
          height: widget.height * 0.925,
          decoration: BoxDecoration(
            color: widget.color.withAlpha(100),
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
