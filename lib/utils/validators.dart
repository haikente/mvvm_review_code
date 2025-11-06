class Validators {

  // Hàm kiểm tra tính hợp lệ của email
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email không được để trống';
    }

    // Biểu thức chính quy để kiểm tra định dạng email
    const emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(email)) {
      return 'Email không hợp lệ';
    }
    return null;
  }
  // Hàm kiểm tra tính hợp lệ của mật khẩu
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    if (password.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  
}
