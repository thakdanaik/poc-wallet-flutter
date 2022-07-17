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

class _WalletListState extends State<WalletList> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _otherCardController;
  late AnimationController _selectionController;
  final double _verticalMargin = 10;
  int _selectionCard = 0;

  double get _remainingHeight =>
      ((widget.cardHeight + (_verticalMargin * 2)) * widget.cardHeightFactor);

  @override
  void initState() {
    _otherCardController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _selectionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _otherCardController.addListener(() {
      if (_otherCardController.status == AnimationStatus.completed) {
        _selectionController.forward();
      }
      setState(() {});
    });

    _selectionController.addListener(() {
      if (_selectionController.status == AnimationStatus.dismissed) {
        _otherCardController.reverse();
      }
      setState(() {});
    });

    super.initState();
  }

  _onCardTap(int index) async {
    setState(() {
      _selectionCard = index;
    });
    _otherCardController.forward();
    await Future.delayed(const Duration(milliseconds: 800)).then(
      (value) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Wallet')),
            body: SafeArea(
              child: Center(
                child: Text(widget.dataList[index].name),
              ),
            ),
          ),
        ),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 200)).then(
      (value) => _selectionController.reverse(from: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              double dyAnimation = 0;

              if (_otherCardController.value > 0 && _selectionCard != index) {
                int vectorFactor = index.compareTo(_selectionCard);
                dyAnimation = vectorFactor *
                    _otherCardController.value *
                    MediaQuery.of(context).size.height;
              }

              if (_selectionController.value > 0 && _selectionCard == index) {
                dyAnimation = _selectionController.value *
                    (_scrollController.offset - (_remainingHeight * index));
              }

              CardData data = widget.dataList[index];
              return Transform.translate(
                offset: Offset(0, dyAnimation),
                child: GestureDetector(
                  onTap: () => _onCardTap(index),
                  child: WalletCard(
                    index: index,
                    name: data.name,
                    cardNo: data.cardNo,
                    height: widget.cardHeight,
                    verticalMargin: _verticalMargin,
                    color: data.cardColor,
                    isMultipleCard: data.isMultiCard,
                    cardHeightFactor: widget.cardHeightFactor,
                    scrollController: _scrollController,
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
