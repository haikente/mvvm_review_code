import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvvm_review/models/user_model.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  // đăng nhập với email và mật khẩu
  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Lấy thông tin người dùng từ Firebase
      User? user = userCredential.user;
      if (user != null) {
        return UserModel(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          password: password,
        );
      }
    } catch (e) {
      print('Đăng nhập thất bại: $e');
    }
    return null;
  }


  // đăng xuất
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
  

  // đăng ký với email và mật khẩu
  Future<UserModel?> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Cập nhật tên hiển thị của người dùng
      await userCredential.user?.updateDisplayName(name);
      // Lấy thông tin người dùng từ Firebase
      User? user = userCredential.user;
      if (user != null) {
        return UserModel(
          id: user.uid,
          name: name,
          email: user.email ?? '',
          password: password,
        );
      }
    } catch (e) {
      print('Đăng ký thất bại: $e');
    }
    return null;
  }


  // theo doi trạng thái đăng nhập
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();



  // ánh xạ firebase sang thông báo tiếng việt
  String _mapFirebaseErrorToMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Email không hợp lệ.';
      case 'user-disabled':
        return 'Tài khoản đã bị vô hiệu hóa.';
      case 'user-not-found':
        return 'Không tìm thấy người dùng.';
      case 'wrong-password':
        return 'Mật khẩu không đúng.';
      case 'email-already-in-use':
        return 'Email đã được sử dụng.';
      case 'weak-password':
        return 'Mật khẩu quá yếu.';
      default:
        return 'Đã xảy ra lỗi không xác định.';
    }
  }
}
