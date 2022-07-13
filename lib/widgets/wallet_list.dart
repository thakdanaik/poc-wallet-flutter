import 'package:flutter/material.dart';
import 'package:poc_wallet_flutter/widgets/wallet_card.dart';

class WalletList extends StatefulWidget {
  final double cardHeight;
  final double cardHeightFactor;

  const WalletList(
      {Key? key, required this.cardHeight, required this.cardHeightFactor})
      : super(key: key);

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  final ScrollController _scrollController = ScrollController();
  final double _verticalMargin = 10;
  int _indexAtTop = 0;

  double get _remainingHeight =>
      ((widget.cardHeight + (_verticalMargin * 2)) * widget.cardHeightFactor);

  @override
  void initState() {
    _scrollController.addListener(() {
      double value = _scrollController.offset / _remainingHeight;

      setState(() {
        _indexAtTop = value.floor();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: 25 + 1,
        itemBuilder: (context, index) {
          if (index == 25) {
            return SizedBox(
              height: widget.cardHeight,
            );
          }

          double dy = 0;
          if (_indexAtTop == index) {
            dy = _scrollController.offset - (_remainingHeight * index);
          }

          return Transform.translate(
            offset: Offset(0, dy),
            child: Align(
              heightFactor: widget.cardHeightFactor,
              alignment: Alignment.topCenter,
              child: WalletCard(
                name: 'Donut Shop $index',
                cardNo: 'XXXXXX-9999',
                height: widget.cardHeight,
                verticalMargin: _verticalMargin,
                color: Colors.white,
                isShowShadow: _indexAtTop != index,
              ),
            ),
          );
        });
  }
}
