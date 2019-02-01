import 'package:flutter/services.dart';

class Api {

  /*DEV*/
  static String domainUrl = "http://ide18.com/dev/";
  /*QA*/
  //static String domainUrl = "http://ide18.com/";
  /*Live*/
  //static String domainUrl = "https://momasama.bizwy.com/";

  static String loginApi = domainUrl + "log_api.php";
  static String getUserList = domainUrl + "listUsers.php";
}

class Constants{
  //Users
  static String admin = "1";

  //Pagination limit
  static int limit = 20;

  //Encryption channel
  static const platform = const MethodChannel('flutter.bizwy.com.channel');

  //Params
  static String userId = "user_id";
  static String userStatus = "user_status";
  static String email = "email";
  static String firstName = "first_name";
  static String lastName = "last_name";
  static String userPhoto = "user_photo";
  static String userMobile = "user_mobile";
  static String maritalStatus = "marital_status";
  static String dob = "user_dob";
  static String gender = "user_gender";
  static String userCompanyId = "user_company_id";
  static String userType = "user_type";
  static String catalogueId = "catalogue_id";
  static String lobId = "lob_id";
  static String branchId = "branch_id";
  static String loginTime = "login_time";
  static String address = "address1";
  static String pincode = "pincode";
  static String city = "city";
  static String state = "state";
  static String country = "country";
  static String area = "area";
}