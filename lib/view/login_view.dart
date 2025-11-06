import 'package:flutter/material.dart';
import 'package:mvvm_review/view/home_view.dart';
import 'package:mvvm_review/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<LoginViewmodel>(context);

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),

            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: viewModel.setEmail,
                keyboardType: TextInputType.emailAddress,
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
                onChanged: viewModel.setPassword,
              ),
            ),

            const SizedBox(height: 10,),

            viewModel.isLoading
                ? CircularProgressIndicator()
                : Container(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () async{
                        final success = await viewModel.login();
                        if(success){

                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => const HomeView()));
                         
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Đăng nhập thất bại! Vui lòng kiểm tra lại.')),
                          );
                        }
                      },
                      child: Text('Đăng nhập', style: TextStyle(fontSize: 16),
                    ),

                            ),
                )],
        ),
      ),
    );
  }
}