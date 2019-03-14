import 'package:flutter/material.dart';
import 'package:cooking_app/dao/graphql_client.dart';
import 'dart:convert';

class UserLogin {
  String Email;
  String Password;

  Future login() async {
    print('logging in');
    return await Client().post(_toQuery(this))
        .then((response) {
          print(response);
          //Navigate to second screen
        });
  }

  me() async {
    return await Client().get('{me{email}}')
        .then((response) {
      print(response);
    });
  }

  _toQuery(params) {
    var mutation = '''
      mutation Login(\$email: String!, \$password: String!) {
        login(email: \$email, password: \$password)
      }
    ''';

    Map<String, String> body = new Map();
    body['query'] = mutation;
    body['variables'] = json.encode(_toJson(params));

    return json.encode(body);
  }

  _toJson(userLogin) {
    return {
      "email": userLogin.Email,
      "password": userLogin.Password
    };

  }
}