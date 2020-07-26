import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String token;
  String tokenExpirationTime;
  bool isAuthenticated = false;
  String userId;

  Future<void> addUser(String email, String password) async {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAn18pZzchPXGuariXP_6DE3-T_xlj8LDI';
    var response =
        await http.post(url, body: json.encode({'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = json.decode(response.body);
    token = responseData['idToken'];
    tokenExpirationTime = responseData['expiresIn'];
    isAuthenticated = true;
    userId = responseData['localId'];
    notifyListeners();
  }

  //https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAn18pZzchPXGuariXP_6DE3-T_xlj8LDI
  //https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAn18pZzchPXGuariXP_6DE3-T_xlj8LDI
  Future<void> loginUser(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAn18pZzchPXGuariXP_6DE3-T_xlj8LDI';
    var response =
        await http.post(url, body: json.encode({'email': email, 'password': password, 'returnSecureToken': true}));
    var responseData = json.decode(response.body);
    token = responseData['idToken'];
    tokenExpirationTime = responseData['expiresIn'];
    isAuthenticated = true;
    userId = responseData['localId'];
    notifyListeners();
  }
}
