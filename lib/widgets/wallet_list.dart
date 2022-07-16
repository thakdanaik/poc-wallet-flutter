import 'package:flutter/material.dart';
import 'package:poc_wallet_flutter/models/card_data.dart';
import 'package:poc_wallet_flutter/widgets/wallet_card.dart';

class WalletList extends StatefulWidget {
  final List<CardData> dataList;
  final double cardHeight;
  final double cardHeightFactor;

  const WalletList({
    Key? key,
    required this.dataList,
    required this.cardHeight,
    required this.cardHeightFactor,
  }) : super(key: key);

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0);

  final double _verticalMargin = 10;

  double get _remainingHeight =>
      ((widget.cardHeight + (_verticalMargin * 2)) * widget.cardHeightFactor);

  @override
  void initState() {
    _scrollController.addListener(() {
      _scrollOffset.value = _scrollController.offset;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              CardData data = widget.dataList[index];

              return ValueListenableBuilder(
                valueListenable: _scrollOffset,
                builder: (context,double value, child) {
                  double dy = 0;

                  int indexAtTop = (value / _remainingHeight).floor();

                  if (indexAtTop == index) {
                    dy = _scrollController.offset - (_remainingHeight * index);
                  }

                  return Transform.translate(
                      offset: Offset(0, dy),
                      child: child
                  );
                },
                child: Align(
                  heightFactor: widget.cardHeightFactor,
                  alignment: Alignment.topCenter,
                  child: WalletCard(
                    name: data.name,
                    cardNo: data.cardNo,
                    height: widget.cardHeight,
                    verticalMargin: _verticalMargin,
                    color: data.cardColor,
                    // isShowShadow: indexAtTop != index,
                    isMultipleCard: data.isMultiCard,
                  ),
                ),
              );
            },
            childCount: widget.dataList.length,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: widget.cardHeight,
          ),
        ),
      ],
    );
  }
}
