import 'package:flutter/material.dart';
import 'wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '食物轮盘',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const FoodRoulettePage(),
    );
  }
}

class FoodRoulettePage extends StatefulWidget {
  const FoodRoulettePage({super.key});
  @override
  State<FoodRoulettePage> createState() => _FoodRoulettePageState();
}

class _FoodRoulettePageState extends State<FoodRoulettePage> {
  final List<String> foodItems = [
    '火锅',
    '寿司',
    '披萨',
    '汉堡',
    '炸鸡',
    '面条',
    '沙拉',
    '烤肉'
  ];
  
  String _selectedFood = '';

  void _onFoodSelected(String food) {
    setState(() {
      _selectedFood = food;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('今天吃什么？'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 轮盘组件
            RouletteWheel(
              items: foodItems,
              onSelected: _onFoodSelected,
            ),
            const SizedBox(height: 30),
            // 显示选中的食物
            if (_selectedFood.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '今天就吃：$_selectedFood！',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
  }
}
