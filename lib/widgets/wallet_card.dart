import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WalletCard extends StatefulWidget {
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
  }) : super(key: key);

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  Color get textColor =>
      widget.color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  final ValueNotifier<double> _translateOffset = ValueNotifier<double>(0);
  final GlobalKey _globalKey = GlobalKey();
  double? _actualCardOffset;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _actualCardOffset ??= _findCardOffsetInListview();
      if (_actualCardOffset != null) {
        widget.scrollController.addListener(_scrollAnimationFunction);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollAnimationFunction);
    super.dispose();
  }

  double? _findCardOffsetInListview() {
    if (_globalKey.currentContext == null) {
      return null;
    }

    RenderTransform currentRender =
        _globalKey.currentContext!.findRenderObject() as RenderTransform;

    /// Find RenderIndexedSemantics from the parent widget.
    /// Up to 5 layers above in the widget tree.
    RenderIndexedSemantics? indexedSemantics;
    AbstractNode? tempRender = currentRender.parent;
    for (int i = 0; i < 5; i++) {
      tempRender = tempRender?.parent;
      if (tempRender == null) {
        return null;
      } else if (tempRender is RenderIndexedSemantics) {
        indexedSemantics = tempRender;
        break;
      }
    }

    if (indexedSemantics != null) {
      var indexedData =
          indexedSemantics.parentData as SliverMultiBoxAdaptorParentData;
      return indexedData.layoutOffset;
    }

    return null;
  }

  void _scrollAnimationFunction() {
    if (_actualCardOffset != null) {
      if (widget.scrollController.offset >= _actualCardOffset!) {
        _translateOffset.value =
            widget.scrollController.offset - _actualCardOffset!;
      } else {
        _translateOffset.value = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      key: _globalKey,
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
