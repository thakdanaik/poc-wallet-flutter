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

  @override
  void initState() {
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

              return WalletCard(
                index: index,
                name: data.name,
                cardNo: data.cardNo,
                height: widget.cardHeight,
                verticalMargin: _verticalMargin,
                color: data.cardColor,
                // isShowShadow: indexAtTop != index,
                isMultipleCard: data.isMultiCard,
                cardHeightFactor: widget.cardHeightFactor,
                scrollController: _scrollController,
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
