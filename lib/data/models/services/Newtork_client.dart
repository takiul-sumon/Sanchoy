import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:sanchoy/app.dart';
import 'package:sanchoy/ui/controller/Auth_controller.dart';
import 'package:sanchoy/ui/screans/Login_screan.dart';


class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkClient {
  static final Logger _logger = Logger();
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'token': AuthController.token ?? ''};
      _preRequestLog(url, headers);
      Response response = await get(uri, headers: headers);
      _postRequestLog(
        url,
        response.statusCode,
        headers: response.headers,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else if (response.statusCode == 401) {
        _moveToLoginScrean();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Un-authorized plase login again',
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errormessage = decodedJson['data'] ?? "Something went wrong";
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errormessage,
        );
      }
    } catch (e) {
      _postRequestLog(url, -1);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-type': 'Application/json',
        'token': AuthController.token ?? '',
      };

      _preRequestLog(url, headers, body: body);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _postRequestLog(
        url,
        response.statusCode,
        headers: response.headers,
        responseBody: response.body,
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJson,
        );
      } else if (response.statusCode == 401) {
        _moveToLoginScrean();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Un authorized plase login again',
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        String errorMessange = decodedJson['data'] ?? "Something went wrong";
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessange,
        );
      }
    } catch (e) {
      _postRequestLog(url, -1, errorMessage: e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _preRequestLog(
    String url,
    Map<String, String> headers, {
    Map<String, dynamic>? body,
  }) {
    _logger.i(
      'Url: $url\nheaders:$headers'
      'body:$body\n',
    );
  }

  static void _postRequestLog(
    String url,
    int statusCode, {
    Map<String, dynamic>? headers,
    dynamic responseBody,
    dynamic errorMessage,
  }) {
    if (errorMessage != null) {
      _logger.e(
        'Url: $url\n'
        'statusCode:$statusCode\n'
        'headers:$headers\n'
        'responseBody:$responseBody\n',
      );
    } else {
      _logger.i(
        'Url: $url\n'
        'statusCode:$statusCode\n'
        'headers:$headers\n'
        'responseBody:$responseBody\n',
      );
    }
  }

  static Future<void> _moveToLoginScrean() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      Sanchoy.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
      (predicate) => false,
    );
  }
}
