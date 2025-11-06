import 'package:flutter/material.dart';
import 'package:mvvm_review/repositories/auth_repositories.dart';
import 'package:mvvm_review/utils/validators.dart';
import 'package:mvvm_review/view/home_view.dart';



class LoginViewmodel extends ChangeNotifier {

  
  final AuthRepositories _authRepositories = AuthRepositories();
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  LoginViewmodel(AuthRepositories read);

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
  Future<void> login() async {
    if (!validate()) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _authRepositories.login(_email, _password);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();

    } catch (e) {
      _errorMessage = 'Đăng nhập thất bại: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
      
    }
   }
  }