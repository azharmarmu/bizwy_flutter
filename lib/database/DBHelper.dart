import 'dart:async';
import 'dart:io' as io;

import 'package:bizwy_flutter/model/LoginModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database _db;

  static final String dbName = "SmartBusiness";

  /*User Table*/
  static final String loginDetails = "LoginDetails";
  static final String userEmail = "Email";
  static final String userId = "userid";
  static final String userFirstName = "FirstName";
  static final String userLastName = "LastName";
  static final String userMobileNumber = "MobileNumber";
  static final String userType = "UserType";
  static final String userPhoto = "UserPhoto";
  static final String catalogueId = "CatalogueId";
  static final String companyId = "CompanyId";
  static final String lobId = "LobId";
  static final String branchId = "branchid";
  static final String loginTime = "LoginTime";

  /*Company Table*/
  static final String companyDetails = "CompanyDetails";
  static final String companyName = "companyname";
  static final String companyPhoto = "companyphoto";
  static final String companyNumber = "companynumber";
  static final String companyAddress = "companyaddress";
  static final String companyGstin = "companygstin";
  static final String companyWebsite = "companywebsite";
  static final String companyDawn = "companydawn";
  static final String companyDusk = "companydusk";
  static final String companycreateddtm = "companydate";

  /*Cart table */
  static final String cartTable = "CartTable";
  static final String productBrandName = "productbrandname";
  static final String customerMobileNumber = "customermobile";
  static final String productId = "productid";
  static final String productName = "productname";
  static final String quantity = "product_quantity";
  static final String price = "product_price";
  static final String dynamicPrice = "product_dynamic_price";
  static final String productImage = "productimage";
  static final String productUnit = "product_unit";
  static final String productDiscountId = "productdiscountid";
  static final String productPriceDiscountId = "productpricediscountid";
  static final String productDiscountPerValue = "productdiscountpervalue";
  static final String productDiscountType = "productdiscounttype";
  static final String productTaxId = "producttaxid";
  static final String productTmpId = "productmpdid";

  /*Tax Table*/
  static final String taxTable = "TaxTable";
  static final String taxName = "taxname";
  static final String taxId = "taxid";
  static final String taxValue = "taxvalue";
  static final String productTaxPriceId = "producttaxpriceid";
  static final String taxMobileNumber = "taxmobile";

  /*Admin Table*/
  static final String adminLoginDetails = "AdminLoginDetails";
  static final String adminEmail = "AdminEmail";
  static final String adminId = "Adminid";
  static final String adminFirstName = "AdminFirstName";
  static final String adminLastName = "AdminLastName";
  static final String adminMobileNumber = "AdminMobileNumber";
  static final String adminType = "AdminUserType";
  static final String adminPhoto = "AdminUserPhoto";
  static final String adminCompanyId = "AdminCompanyId";
  static final String adminLoginTime = "AdminLoginTime";

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE " +
        loginDetails +
        " (" +
        userId +
        " TEXT, " +
        userEmail +
        " TEXT, " +
        userFirstName +
        " TEXT, " +
        userLastName +
        " TEXT, " +
        userType +
        " TEXT, " +
        userPhoto +
        " TEXT, " +
        catalogueId +
        " TEXT, " +
        companyId +
        " TEXT, " +
        lobId +
        " TEXT, " +
        branchId +
        " TEXT, " +
        loginTime +
        " TEXT, " +
        userMobileNumber +
        " TEXT)");

    await db.execute("CREATE TABLE " +
        cartTable +
        " (" +
        productBrandName +
        " TEXT, " +
        customerMobileNumber +
        " TEXT, " +
        productDiscountId +
        " TEXT, " +
        productPriceDiscountId +
        " TEXT, " +
        productDiscountPerValue +
        " TEXT, " +
        quantity +
        " FLOAT, " +
        productUnit +
        " TEXT, " +
        productTaxId +
        " TEXT, " +
        productId +
        " TEXT, " +
        productTmpId +
        " TEXT, " +
        productImage +
        " TEXT, " +
        productDiscountType +
        " TEXT, " +
        price +
        " TEXT, " +
        dynamicPrice +
        " TEXT, " +
        productName +
        " TEXT)");

    await db.execute("CREATE TABLE " +
        taxTable +
        " (" +
        taxName +
        " TEXT, " +
        taxId +
        " TEXT, " +
        productId +
        " TEXT, " +
        taxMobileNumber +
        " TEXT, " +
        productTaxPriceId +
        " TEXT, " +
        taxValue +
        " TEXT)");

    await db.execute("CREATE TABLE " +
        companyDetails +
        " (" +
        companyName +
        " TEXT, " +
        companyNumber +
        " TEXT," +
        companyId +
        " TEXT, " +
        companyAddress +
        " TEXT, " +
        companyGstin +
        " TEXT, " +
        companyWebsite +
        " TEXT, " +
        companyPhoto +
        " TEXT, " +
        companycreateddtm +
        " TEXT, " +
        companyDawn +
        " TEXT, " +
        companyDusk +
        " TEXT)");

    await db.execute("CREATE TABLE " +
        adminLoginDetails +
        " (" +
        adminId +
        " TEXT, " +
        adminEmail +
        " TEXT, " +
        adminFirstName +
        " TEXT, " +
        adminLastName +
        " TEXT, " +
        adminType +
        " TEXT, " +
        adminPhoto +
        " TEXT, " +
        adminCompanyId +
        " TEXT, " +
        adminLoginTime +
        " TEXT, " +
        adminMobileNumber +
        " TEXT)");
  }


  Future<int> addLoginDetails(LoginModel loginModel) async {
    var dbClient = await db;
    int res = await dbClient.insert(loginDetails, loginModel.toMap());
    return res;
  }

  Future<List<LoginModel>> getLoginDetails() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM ' + loginDetails);
    List<LoginModel> users = new List();
    for (int i = 0; i < list.length; i++) {
      LoginModel loginModel = new LoginModel();
      loginModel.userId = list[i]['userId'];
      loginModel.userEmail = list[i]['userEmail'];
      loginModel.userFirstName = list[i]['userFirstName'];
      loginModel.userLastName = list[i]['userLastName'];
      loginModel.userType = list[i]['userType'];
      loginModel.userPhoto = list[i]['userPhoto'];
      loginModel.catalogueId = list[i]['catalogueId'];
      loginModel.companyId = list[i]['companyId'];
      loginModel.lobId = list[i]['lobId'];
      loginModel.branchId = list[i]['branchId'];
      loginModel.loginTime = list[i]['loginTime'];
      loginModel.userMobileNumber = list[i]['userMobileNumber'];
      users.add(loginModel);
    }
    return users;
  }
}
