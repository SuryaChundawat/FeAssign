import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../data/repository/login_repository.dart';
import '../model/response/base/api_response.dart';
import '../model/user_model.dart';

class LoginProvider extends ChangeNotifier{

  final LoginRepository? loginRepository;

  LoginProvider({required this.loginRepository});

  List<User>? _users;
  bool _isLoading = false;

  int? _userId = -1;
  int? get userId => _userId;

  List<User>? get users => _users;
  bool get isLoading => _isLoading;

  set setIsLoading(bool value)=> _isLoading = value;

  Future<bool> fetchUsers(String email) async {
    _isLoading = true;
    bool isSuccess=  false;
    notifyListeners();
    try {
      ApiResponse apiResponse = await loginRepository!.getUserDeatils(email);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _users = [];
        isSuccess = true;
        apiResponse.response!.data.forEach((category) => _users!.add(User.fromJson(category)));
        if(_userId != null){
          _userId = _users?.first.id;
        }
      } else {
        isSuccess = false;
        // handle the error
      }
    } catch (error) {
      print("Error fetching users: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return isSuccess;
  }

  bool validateUser(String username, String password) {
    final user = _users?.firstWhere((user) => user.username == username, orElse: () => User(id: -1, name: '', username: '', email: ''));
    return user?.id != -1 && password == "password";
  }

}