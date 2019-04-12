import 'package:flutter/material.dart';
import './ui/app.dart';
import './ui/splash_screen.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light
  ),
  home: SplashScreen()//App(),
));