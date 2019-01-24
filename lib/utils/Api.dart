class Api {
  static const _API_KEY = "asdbaklsadfkasdlfkasdjfl";

  /*DEV*/
  static String domainUrl = "http://ide18.com/dev/";
  /*QA*/
  //static String domainUrl = "http://ide18.com/";
  /*Live*/
  //static String domainUrl = "https://momasama.bizwy.com/";

  static String loginApi = domainUrl + "log_api.php";
}

class Constants{
  //Users
  static String admin = "1";

  //Params
  static String userId = "user_id";
  static String email = "email";
  static String firstName = "first_name";
  static String lastName = "last_name";
  static String userPhoto = "user_photo";
  static String userMobile = "user_mobile";
  static String userCompanyId = "user_company_id";
  static String userType = "user_type";
  static String catalogueId = "catalogue_id";
  static String lobId = "lob_id";
  static String branchId = "branch_id";
  static String loginTime = "login_time";
}