import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Đăng nhập thành công vào Home', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      ),
    );
  }
}