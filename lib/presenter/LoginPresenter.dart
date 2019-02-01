import 'package:bizwy_flutter/database/DBHelper.dart';
import 'package:bizwy_flutter/sql_model/LoginModel.dart';

class LoginPresenter {
  var db = new DatabaseHelper();

  LoginPresenter();

  Future<int> addUser(LoginModel loginModel) {
    if (loginModel.userType == "1") {
      print("add Admin");
      return db.addAdminDetails(loginModel);
    } else {
      print("add Login");
      return db.addLoginDetails(loginModel);
    }
  }

  Future<List<LoginModel>> getAdmin() {
    return db.getAdminLoginDetails();
  }

  Future<List<LoginModel>> getUser() {
      return db.getLoginDetails();
  }
}
