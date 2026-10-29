import 'package:flutter/material.dart';
import 'home_page.dart'; // Подключаем наш новый файл с карточками

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторные 3-4',
      debugShowCheckedModeBanner: false, // Убирает красную полоску в углу
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(), // Запускаем экран с карточками
    );
  }
}