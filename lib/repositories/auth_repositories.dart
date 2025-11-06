import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvvm_review/models/user_model.dart';
import 'package:mvvm_review/services/auth_services.dart';

class AuthRepositories {
  final AuthServices _authServices = AuthServices();

  // đăng nhập user
  Future<UserModel?> login(String email, String password) async {
    try {
      final user = await _authServices.login(email, password);

      if (user != null) {
        return UserModel(
          id: user.id,
          name: user.name,
          email: user.email,
          password: user.password 
        );
      }
    } catch (e) {
      print('Đăng nhập thất bại: $e');
    }
    return null;
  }

  // đăng xuất user
  Future<void> logout() {
    return _authServices.logout();
  }

  Future<UserModel?> register(String name, String email, String password) async {
    try {
      final user = await _authServices.register(name, email, password);

      if (user != null) {
        return UserModel(
          id: user.id,
          name: user.name,
          email: user.email,
          password: user.password
        );
      }
    } catch (e) {
      print('Đăng ký thất bại: $e');
    }
    return null;
  }

  // lắng nghe thay đổi trạng thái xác thực người dùng
  Stream<UserModel?> get userChanges {
    return _authServices.authStateChanges.map((user) {
      if (user != null) {
        return UserModel(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          password: '',
        );
      } else {
        return null;
      }
    });
  }

}
