import 'package:flutter/material.dart';

Widget loadingWidget({double? height}) {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.blue,
      strokeWidth: 2,
    ),
  );
}