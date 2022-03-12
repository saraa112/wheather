import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

//DioHelper.init()

class DioHelper{
  static late Dio dio;

  static init()
  {
    dio=Dio(
        BaseOptions(
            baseUrl: 'https://newsapi.org/',
            receiveDataWhenStatusError: true
        )
    );
  }

  static Future<Response> getData({
    String ?url,
    Map<String,dynamic> ?query})

  async {
    return await dio.get(
        'v2/everything?q=tesla&from=2022-01-11&sortBy=publishedAt&apiKey=556550e17f5043cf886552a5a881e437', queryParameters: query);
  }
}
