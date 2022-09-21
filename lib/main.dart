import 'package:flutter/material.dart';

import 'color_schemes.dart';
import 'lista.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
        scaffoldBackgroundColor: const Color(0xFF8F00FF),
    ),
    title: "Lista Flutter",
    home: Scaffold(
      body:Lista(),
    )
  ));
}
