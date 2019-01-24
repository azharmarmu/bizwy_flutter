import 'dart:async';
import 'dart:io' as io;

import 'package:bizwy_flutter/sql_model/LoginModel.dart';
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
  static final String userEmail = "email";
  static final String userId = "user_id";
  static final String userFirstName = "first_name";
  static final String userLastName = "last_name";
  static final String userMobileNumber = "user_mobile";
  static final String userType = "user_type";
  static final String userPhoto = "user_photo";
  static final String catalogueId = "catalogue_id";
  static final String companyId = "user_company_id";
  static final String lobId = "lob_id";
  static final String branchId = "branch_id";
  static final String loginTime = "login_time";

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

  Future<int> addAdminDetails(LoginModel loginModel) async {
    var dbClient = await db;
    int res = await dbClient.insert(adminLoginDetails, loginModel.toMap());
    print(res);
    return res;
  }

  Future<List<LoginModel>> getAdminLoginDetails() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM ' + adminLoginDetails);
    print("Admin: $list");
    List<LoginModel> users = new List();
    for (int i = 0; i < list.length; i++) {
      users.add(LoginModel.map(list[i]));
    }
    return users;
  }

  Future<int> addLoginDetails(LoginModel loginModel) async {
    var dbClient = await db;
    int res = await dbClient.insert(loginDetails, loginModel.toMap());
    return res;
  }

  Future<List<LoginModel>> getLoginDetails() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM ' + loginDetails);
    print("Login: $list");
    List<LoginModel> users = new List();
    for (int i = 0; i < list.length; i++) {
      users.add(LoginModel.map(list[i]));
    }
    return users;
  }
}
