import 'package:bizwy_flutter/database/DBHelper.dart';
import 'package:bizwy_flutter/model/LoginModel.dart';

class LoginPresenter {
  var db = new DatabaseHelper();
  LoginPresenter();

  Future<List<LoginModel>> getUser() {
    return db.getLoginDetails();
  }
}