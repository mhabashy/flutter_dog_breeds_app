import 'package:flutter/material.dart';

String titleCase(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

Widget titleCaseWidget(String title) {
  return Text(
    titleCase(title),
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}