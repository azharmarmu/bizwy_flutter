import 'package:bizwy_flutter/utils/Api.dart';

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
    this._userId = obj[Constants.userId];
    this._userEmail = obj[Constants.email];
    this._userFirstName = obj[Constants.firstName];
    this._userLastName = obj[Constants.lastName];
    this._userPhoto = obj[Constants.userPhoto];
    this._userMobileNumber = obj[Constants.userMobile];
    this._companyId = obj[Constants.userCompanyId];
    this._loginTime = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    this._userType = obj[Constants.userType];
    if (this._userType != Constants.admin) {
      this._catalogueId = obj[Constants.catalogueId];
      this._lobId = obj[Constants.lobId];
      this._branchId = obj[Constants.branchId];
    }
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map[Constants.userId] = _userId;
    map[Constants.email] = _userEmail;
    map[Constants.firstName] = _userFirstName;
    map[Constants.lastName] = _userLastName;
    map[Constants.userPhoto] = _userPhoto;
    map[Constants.userCompanyId] = _companyId;
    map[Constants.loginTime] = _loginTime;
    map[Constants.userMobile] = _userMobileNumber;
    map[Constants.userType] = _userType;
    if (this._userType != Constants.admin) {
      map[Constants.catalogueId] = _catalogueId;
      map[Constants.lobId] = _lobId;
      map[Constants.branchId] = _branchId;
    }
    print(map);
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
