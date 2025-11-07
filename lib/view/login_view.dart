import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_review/view/home_view.dart';
import 'package:mvvm_review/view/register_view.dart';
import 'package:mvvm_review/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<LoginViewmodel>(context);

    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("LOGIN_MVVM", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
          
                const SizedBox(height: 20,),


                // Nhập email
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey,),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),      
                      ),
                    ),
                    onChanged: viewModel.setEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
          


                // Nhập mật khẩu
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: (){
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.grey,),
                      hintText: 'Mật khẩu',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),    
                      ),
                    ),
                    obscureText: obscurePassword,
                    onChanged: viewModel.setPassword,
                  ),
                ),


                //Quên mật khẩu
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: (){
                    // Quên mật khẩu
                  },
                   child: const Text("Quên mật khẩu?", style: TextStyle(color: Colors.blue),)),
                ),



                const SizedBox(height: 10,),


                // Nút đăng nhập
                viewModel.isLoading
                    ? CircularProgressIndicator()
                    : Container(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async{
                          final success = await viewModel.login();
                          try {
                            final user = FirebaseAuth.instance.currentUser;
                              if (success && user != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeView(),
                                  ),
                                );
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(viewModel.errorMessage ?? 'Đăng nhập thất bại! Vui lòng kiểm tra lại.')),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Lỗi khi đăng nhập: ${e.toString()}')),
                              );
                            }
                          },
                          child: Text('Đăng nhập', style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
          
                        ),
                    ),


                    const SizedBox(height: 10,),


                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){
                          // Đăng ký tài khoản  
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        }, 
                        child: const Text("Tạo tài khoản mới", style: TextStyle(color: Colors.blue),)),
                    ),

                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Hoặc", style: TextStyle(color: Colors.grey),),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 20,),


                    //đăng nhập với google
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: IconButton(onPressed: (){
                        // Đăng nhập với Google
                      },
                       icon: Icon(Icons.g_mobiledata, size: 40, color: const Color(0xFF4285F4),)),
                    ) 
                  ],
            ),
          ),
      ),
      
    );
  }
}