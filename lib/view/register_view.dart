import 'package:flutter/material.dart';
import 'package:mvvm_review/view/home_view.dart';
import 'package:mvvm_review/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _onRegister(LoginViewmodel viewModel) async {
    if(!_formKey.currentState!.validate()) return;

    viewModel.setEmail(_emailController.text.toString());
    viewModel.setPassword(_passwordController.text.toString());

    final success = await viewModel.register(_nameController.text.toString(), _confirmController.text.toString());
    
    if (success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeView()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(viewModel.errorMessage ?? 'Đăng ký thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<LoginViewmodel>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
         padding: const EdgeInsets.all(24),
         child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8,),
              const Text("Tạo tài khoản", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),

              //Ho ten người dùng
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey,),
                  hintText: 'Họ và tên',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => (value == null || value.trim().isEmpty) ? "Vui lòng nhập tên" : null,
              ),

              const SizedBox(height: 12,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.grey,),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if(v == null || v.isEmpty) return 'Vui lòng nhập email';
                  if(!v.contains('@')) return 'Email không hợp lệ';
                  return null;
                },
              ),

               const SizedBox(height: 12,),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey,),
                  hintText: 'Mật khẩu',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey,),
                    onPressed: () => setState(() =>
                    _obscurePassword = !_obscurePassword),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: _obscurePassword,
                validator: (v) {
                  if(v == null || v.length < 6) return 'Mật khẩu không hợp lệ';
                  return null;
                },
              ),


               const SizedBox(height: 12,),
              TextFormField(
                controller: _confirmController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey,),
                  hintText: 'Xác nhận mật khẩu',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: _obscurePassword,
                validator: (v) {
                  if(v == null || v.isEmpty) return 'Vui lòng xác nhận mật khẩu';
                  if(v != _passwordController.text) return 'Mật khẩu không khớp';
                  return null;
                },
              ),


              const SizedBox(height: 20,),
              viewModel.isLoading 
              ? const CircularProgressIndicator() 
              : SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(onPressed: ()=> _onRegister(viewModel),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Đăng ký", style: TextStyle(fontSize: 16, color: Colors.white))),
              ),
              const SizedBox(height: 12),
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Quay lại đăng nhập')),
            ],
          )),
        )
      )
    );
  }
}