class LoginApiModel{
  String userMobile;
  String userPin;
  String keyFCM;

  LoginApiModel({
    this.userMobile,
    this.userPin,
    this.keyFCM
  });

  factory LoginApiModel.fromJson(Map<String, dynamic> parsedJson){
    return LoginApiModel(
        userMobile: parsedJson['user_mobile'],
        userPin : parsedJson['user_pin'],
        keyFCM : parsedJson ['key_fcm']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': userMobile,
        'user_pin': userPin,
        'key_fcm': keyFCM,
      };
}