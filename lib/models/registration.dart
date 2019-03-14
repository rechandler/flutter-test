import 'package:flutter/material.dart';
import 'package:cooking_app/dao/graphql_client.dart';
import 'dart:convert';

class Registration {
  String username;
  String email;
  String password;

  Future register() async{
    return await Client().post(_toQuery(this))
        .then((response) {
            print(response);
        });
  }

  _toQuery(Registration registration) {
    var mutation = '''
      mutation Signup(\$username: String!, \$email: String!, \$password: String!) {
        signup(username: \$username, email: \$email, password: \$password)
      }
    ''';

    Map<String, String> body = new Map();
    body['query'] = mutation;
    body['variables'] = json.encode(_toJson(registration));

    return body;
  }

  _toJson(Registration registration) {
    return {
      'email': registration.email,
      'username': registration.username,
      'password': registration.password
    };
  }
}