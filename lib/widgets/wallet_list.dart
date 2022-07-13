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
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              double dy = 0;
              if (_indexAtTop == index) {
                dy = _scrollController.offset - (_remainingHeight * index);
              }

              CardData data = widget.dataList[index];
              return Transform.translate(
                offset: Offset(0, dy),
                child: Align(
                  heightFactor: widget.cardHeightFactor,
                  alignment: Alignment.topCenter,
                  child: WalletCard(
                    name: data.name,
                    cardNo: data.cardNo,
                    height: widget.cardHeight,
                    verticalMargin: _verticalMargin,
                    color: data.cardColor,
                    isShowShadow: _indexAtTop != index,
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

    return ListView.builder(
        controller: _scrollController,
        itemCount: widget.dataList.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.dataList.length) {
            return SizedBox(
              height: widget.cardHeight,
            );
          }

          double dy = 0;
          if (_indexAtTop == index) {
            dy = _scrollController.offset - (_remainingHeight * index);
          }

          CardData data = widget.dataList[index];
          return Transform.translate(
            offset: Offset(0, dy),
            child: Align(
              heightFactor: widget.cardHeightFactor,
              alignment: Alignment.topCenter,
              child: WalletCard(
                name: data.name,
                cardNo: data.cardNo,
                height: widget.cardHeight,
                verticalMargin: _verticalMargin,
                color: data.cardColor,
                isShowShadow: _indexAtTop != index,
                isMultipleCard: data.isMultiCard,
              ),
            ),
          );
        });
  }
}
