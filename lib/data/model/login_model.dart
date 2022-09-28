class LoginModel {
  final int otp;
  final String mobile;

  const LoginModel({required this.otp, required this.mobile});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      otp: json['OTP'],
      mobile: json['mobile'],
    );
  }
}
