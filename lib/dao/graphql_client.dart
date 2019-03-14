import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class Client {
  static final Client _client = new Client._internal();
  final _path = DotEnv().env['graphql'];

  Dio _dio = new Dio( new BaseOptions(
      baseUrl: DotEnv().env['baseUrl'],
  ));

  factory Client() {
    return _client;
  }

  Client._internal();

  // Use DIO's build in cookie manager
  // Cookie jar will store in memorey
  // PersistCookieJar will store in files
  void setup() {
    _dio.interceptors.add(CookieManager(CookieJar()));
  }

  /**
   * Post operation.
   */
  Future<Map<String, dynamic>> post (data, {headers=null} ) async {
    return await _dio.post(_path, data: data, options: new Options(headers: headers))
      .then(_unwrap)
      .catchError(_handleError);
  }

  /**
   * Get Operations
   */
  Future<Map<String, dynamic>> get(String query) async {
    return await _dio.get(_path, queryParameters: {"query": query})
      .then(_unwrap)
      .catchError(_handleError);
  }

  Map<String, dynamic> _unwrap(Response response) {
    return response.data['data'];
  }

  void _handleError(response) {
    return response.data['message'];
  }
}