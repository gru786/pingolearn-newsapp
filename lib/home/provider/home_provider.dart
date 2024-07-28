import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:my_news/global/global.dart';
import 'package:my_news/home/models/news_model.dart';

class HomeProvider extends ChangeNotifier {
  NewsModel? newsModel;
final remoteConfig = FirebaseRemoteConfig.instance;
  getRemoteConfigValue() async {
    
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.setDefaults(const {
    "country": "in",
    
});
  }

  getNews() async {
    Dio dio = Dio();
    await getRemoteConfigValue();

    try {
      final response = await dio.get(
          "https://newsapi.org/v2/top-headlines?country=${remoteConfig.getString("country")}&apiKey=${kApiKey}");
      if (response.statusCode == 200) {
        newsModel = NewsModel.fromJson(response.data);
        notifyListeners();
      } else {
        log("Unexpected status code");
      }
    } on DioException catch (e) {
      log("Exception : $e");
    }
  }
}
