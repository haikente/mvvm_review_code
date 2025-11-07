import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_review/repositories/auth_repositories.dart';
import 'package:mvvm_review/utils/validators.dart';
import 'package:mvvm_review/view/home_view.dart';



class LoginViewmodel extends ChangeNotifier {

  
  final AuthRepositories _authRepositories;
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  LoginViewmodel(this._authRepositories);

  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  // validate 
  bool validate() {
    final emailError = Validators.validateEmail(_email);
    final passwordError = Validators.validatePassword(_password);
    
    if(emailError != null) {
      _errorMessage = emailError;
      notifyListeners();
      return false;
    }


    if(passwordError != null) {
      _errorMessage = passwordError;
      notifyListeners();
      return false;
    }

    _errorMessage = null;
    notifyListeners();
    return true;
  }

  // đăng nhập
  Future<bool> login() async {
    if (!validate()) return false;

    _isLoading = true;
    notifyListeners();

    try {
      // nhận kết quả trả về từ repository
      final user = await _authRepositories.login(_email, _password);

      // nếu repository trả về null => đăng nhập thất bại
      if (user == null) {
        _errorMessage = 'Email hoặc mật khẩu không đúng.';
        return false;
      }

      _errorMessage = null;
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Đăng nhập thất bại.';
      return false;
    } catch (e) {
      _errorMessage = 'Đăng nhập thất bại: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //đăng ký
  Future<bool> register(String name ,String confirmPassword) async {
    if (!validate()) return false;

    //Kiểm tra mk
    if (_password != confirmPassword) {
      _errorMessage = 'Mật khẩu xác nhận không khớp.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      //gọi repository đăng ký user
      final user = await _authRepositories.registerUser(name, _email, _password);

      if (user == null) {
        _errorMessage = 'Đăng ký thất bại.';
        return false;
      }

      _errorMessage = null;
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Đăng ký thất bại.';
      return false;
    } catch (e) {
      _errorMessage = 'Đăng ký thất bại: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //đăng xuất
  Future<void> logout() async {
    await _authRepositories.logout();
  }


}