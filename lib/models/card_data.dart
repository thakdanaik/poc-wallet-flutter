import 'package:flutter/material.dart';

class CardData {
  String name;
  String? cardNo;
  Color cardColor;

  CardData({
    required this.name,
    required this.cardColor,
    this.cardNo,
  });
}
