import 'package:flutter/material.dart';
import 'package:mvvm_review/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<LoginViewmodel>(context);

    return Scaffold(

      body: Column(
        children: [
          
        ],
      ),
    );
  }
}