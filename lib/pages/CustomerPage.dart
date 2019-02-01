import 'package:bizwy_flutter/presenter/LoginPresenter.dart';
import 'package:bizwy_flutter/sql_model/LoginModel.dart';
import 'package:bizwy_flutter/utils/Api.dart';
import 'package:bizwy_flutter/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:bizwy_flutter/utils/Theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  //Pagination
  static int pageStart = 0;
  bool isLoading = false;
  bool isLastPage = false;
  int totalPages = 0;
  int currentPage = pageStart;

  Widget appBarTitle;
  Icon actionIcon;

  final TextEditingController _searchQuery = new TextEditingController();

  LoginPresenter loginPresenter;
  List<LoginModel> data;

  var values = ['Name', 'Mobile Number', 'Address', 'Pincode', 'City', 'State'];
  var postValues = ["name", "mobile", "address", "pincode", "city", "state"];

  List<Customer> _customersList = List();

  String _searchType = "";

  @override
  void initState() {
    super.initState();
    this.appBarTitle = MyAppBar(
      title: 'Customer List',
      appBarType: 1,
    );
    this.actionIcon = Icon(
      Icons.search,
      color: Colors.white,
    );
    _searchType = postValues[0];
    loginPresenter = new LoginPresenter();
    getAllCustomers("0");
    controller = new ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    currentPage += 1;
    getAllCustomers((currentPage * Constants.limit).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              if (this.actionIcon.icon == Icons.search) {
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            },
          ),
        ],
      ),
      body: customersListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Theme.myColor[500],
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      this.appBarTitle = InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  searchCustomers();
                },
                controller: _searchQuery,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                  hintText: "Search name",
                  hintStyle: new TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
      this.actionIcon = new Icon(
        Icons.close,
        color: Colors.white,
      );
    });
  }

  searchCustomers() {
    print('SearchQuery: ${_searchQuery.text}');
    if (_searchQuery.text.length > 3) {
      _customersList.clear();
      getSearchedCustomers("0");
    } else if (_searchQuery.text.length == 3) {
      _customersList.clear();
      getAllCustomers("0");
    }
  }

  void _handleSearchEnd() {
    if (_searchQuery.text.length > 0) {
      _searchQuery.text = "";
      _customersList.clear();
      getAllCustomers("0");
    } else {
      setState(() {
        this.appBarTitle = MyAppBar(
          title: 'Customer List',
          appBarType: 1,
        );
        this.actionIcon = Icon(
          Icons.search,
          color: Colors.white,
        );
        _searchQuery.clear();
      });
    }
  }

  ScrollController controller;

  customersListWidget() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: controller,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: _customersList.map((Customer customer) {
                return Card(
                  child: ListTile(
                      onTap: null,
                      trailing: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/user.png',
                          image: 'assets/user.png',
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(customer.name),
                          Text(customer.userMobile)
                        ],
                      )),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  getAllCustomers(String offset) async {
    data = await loginPresenter.getUser();
    try {
      LoginModel loginModel = data[0];
      Map<String, String> map = {};
      map['offset'] = offset;
      map['limit'] = Constants.limit.toString();
      map['user_type'] = "5";
      map['company_id'] = loginModel.companyId;
      map['loggedin_user_id'] = loginModel.userId;
      map['loggedin_user_type'] = loginModel.userType;
      map['module_id'] = "8";

      final String encrypted = await Constants.platform.invokeMethod(
          'getEncryptedValue', {"input": convert.jsonEncode(map)});

      final response =
          await http.post(Api.getUserList, body: {'json_data': encrypted});

      if (response.statusCode == 200) {
        Map jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['error_flag'] == false) {
          List usersList = jsonResponse['user_list'];
          for (final users in usersList) {
            Customer customer = new Customer.map(users);
            _customersList.add(customer);
          }
          setState(() {});
        }
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  getSearchedCustomers(String offset) async {
    data = await loginPresenter.getUser();
    try {
      LoginModel loginModel = data[0];
      Map<String, String> map = {};
      map['offset'] = offset;
      map['limit'] = Constants.limit.toString();
      map['user_type'] = "5";
      map['company_id'] = loginModel.companyId;
      map['loggedin_user_id'] = loginModel.userId;
      map['loggedin_user_type'] = loginModel.userType;
      map["user_search"] = _searchQuery.text;
      map["search_param"] = _searchType;

      print(map);
      final String encrypted = await Constants.platform.invokeMethod(
          'getEncryptedValue', {"input": convert.jsonEncode(map)});

      final response =
          await http.post(Api.getUserList, body: {'json_data': encrypted});

      if (response.statusCode == 200) {
        Map jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse);
        if (jsonResponse['error_flag'] == false) {
          List usersList = jsonResponse['user_list'];
          for (final users in usersList) {
            Customer customer = new Customer.map(users);
            _customersList.add(customer);
          }
          setState(() {});
        }
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class ChildItem extends StatelessWidget {
  final String name;

  ChildItem(this.name);

  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(this.name));
  }
}

class Customer {
  String _userId;
  String _firstName;
  String _lastName;
  String _name;
  String _userMobile;
  String _userPhoto;
  String _maritalStatus;
  String _dob;
  String _gender;
  String _userStatus;
  String _address;
  String _email;
  String _pincode;
  String _area;
  String _city;
  String _state;
  String _country;

  Customer.map(dynamic obj) {
    this._userId = obj[Constants.userId];
    this._firstName = obj[Constants.firstName];
    this._lastName = obj[Constants.lastName];
    this._name = this._firstName + " " + this._lastName;
    this._userMobile = obj[Constants.userMobile];
    this._userPhoto = obj[Constants.userPhoto];
    this._maritalStatus = obj[Constants.maritalStatus];
    this._dob = obj[Constants.dob];
    this._gender = obj[Constants.gender];
    this._userStatus = obj[Constants.userStatus];
    this._address = obj[Constants.address];
    this._email = obj[Constants.email];
    this._pincode = obj[Constants.pincode];
    this._area = obj[Constants.area];
    this._city = obj[Constants.city];
    this._state = obj[Constants.state];
    this._country = obj[Constants.country];
  }

  String get country => _country;

  String get state => _state;

  String get city => _city;

  String get area => _area;

  String get pincode => _pincode;

  String get email => _email;

  String get address => _address;

  String get userStatus => _userStatus;

  String get gender => _gender;

  String get dob => _dob;

  String get maritalStatus => _maritalStatus;

  String get userPhoto => _userPhoto;

  String get userMobile => _userMobile;

  String get name => _name;

  String get lastName => _lastName;

  String get firstName => _firstName;

  String get userId => _userId;
}
