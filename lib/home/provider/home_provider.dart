import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_news/global/global.dart';
import 'package:my_news/home/models/news_model.dart';

class HomeProvider extends ChangeNotifier{

  

  NewsModel? newsModel;


  getNews() async{
    Dio dio = Dio();

    try {
      final response = await dio.get("https://newsapi.org/v2/top-headlines?country=in&apiKey=${kApiKey}");
      if(response.statusCode == 200){
        newsModel = NewsModel.fromJson(response.data);
        notifyListeners();
      }
      else{
        log("Unexpected status code");
      }
    }
    
    on DioException catch (e) {
      log("Exception : $e");
    }

  }
}