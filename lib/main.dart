import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Intropage.dart';
import 'package:flutter_application_1/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Intropage(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkSneakerTheme,
    );
  }
}
