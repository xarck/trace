import 'package:flutter/material.dart';

// Convert Hex To Color
Color hexToColor(String hex) {
  return Color(int.parse("0xff$hex"));
}
