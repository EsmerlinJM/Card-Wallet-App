import 'package:flutter/material.dart';
import './ui/app.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light
  ),
  home: App(),
));