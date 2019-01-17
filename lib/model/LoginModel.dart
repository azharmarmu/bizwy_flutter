
class LoginModel {
  String _userId;
  String _userEmail;
  String _userFirstName;
  String _userLastName;
  String _userType;
  String _userPhoto;
  String _catalogueId;
  String _companyId;
  String _lobId;
  String _branchId;
  String _loginTime;
  String _userMobileNumber;


  LoginModel();

  LoginModel.map(dynamic obj) {
    this._userId = obj["userId"];
    this._userEmail = obj["userEmail"];
    this._userFirstName = obj["userFirstName"];
    this._userLastName = obj["userLastName"];
    this._userType = obj["userType"];
    this._userPhoto = obj["userPhoto"];
    this._catalogueId = obj["catalogueId"];
    this._companyId = obj["companyId"];
    this._lobId = obj["lobId"];
    this._branchId = obj["branchId"];
    this._loginTime = obj["loginTime"];
    this._userMobileNumber = obj["userMobileNumber"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = _userId;
    map["userEmail"] = _userEmail;
    map["userFirstName"] = _userFirstName;
    map["userLastName"] = _userLastName;
    map["userType"] = _userType;
    map["userPhoto"] = _userPhoto;
    map["catalogueId"] = _catalogueId;
    map["companyId"] = _companyId;
    map["lobId"] = _lobId;
    map["branchId"] = _branchId;
    map["loginTime"] = _loginTime;
    map["userMobileNumber"] = _userMobileNumber;
    return map;
  }

  String get userId => _userId;
  String get userEmail => _userEmail;
  String get userFirstName => _userFirstName;
  String get userLastName => _userLastName;
  String get userType => _userType;
  String get userPhoto => _userPhoto;
  String get catalogueId => _catalogueId;
  String get companyId => _companyId;
  String get lobId => _lobId;
  String get branchId => _branchId;
  String get loginTime => _loginTime;
  String get userMobileNumber => _userMobileNumber;


  set userMobileNumber(String value) {
    _userMobileNumber = value;
  }

  set loginTime(String value) {
    _loginTime = value;
  }

  set branchId(String value) {
    _branchId = value;
  }

  set lobId(String value) {
    _lobId = value;
  }

  set companyId(String value) {
    _companyId = value;
  }

  set catalogueId(String value) {
    _catalogueId = value;
  }

  set userPhoto(String value) {
    _userPhoto = value;
  }

  set userType(String value) {
    _userType = value;
  }

  set userLastName(String value) {
    _userLastName = value;
  }

  set userFirstName(String value) {
    _userFirstName = value;
  }

  set userEmail(String value) {
    _userEmail = value;
  }

  set userId(String value) {
    _userId = value;
  }


}
