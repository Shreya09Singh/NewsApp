import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nextnew/model/CatagoryModel.dart';
import 'package:nextnew/model/NewsHeadLinesModel.dart';

class Newsapioperation {
  Future<NewsHeadLinesModel> getNewsHeadLinesApi(String channelname) async {
    final String apiKey = dotenv.env['Api_Key'] ?? '';
    String url =
        "https://newsapi.org/v2/top-headlines?sources=${channelname}&apiKey=$apiKey";
    final responsedata = await http.get(Uri.parse(url));
    if (responsedata.statusCode == 200) {
      final jsonData = jsonDecode(responsedata.body);
      // if (kDebugMode) {
      //   print(responsedata.body);
      // }

      return NewsHeadLinesModel.fromJson(jsonData);
    } else {
      throw Exception('Error');
    }
  }

  Future<CatagoryModel> getCatagoryHeadLinesApi(String catagory) async {
    final String apiKey = dotenv.env['Api_Key'] ?? '';
    String url =
        "https://newsapi.org/v2/everything?q=${catagory}&apiKey=${apiKey}";
    final responsedata = await http.get(Uri.parse(url));
    if (responsedata.statusCode == 200) {
      final jsonData = jsonDecode(responsedata.body);
      // if (kDebugMode) {
      //   print(responsedata.body);
      // }

      return CatagoryModel.fromJson(jsonData);
    } else {
      throw Exception('Error');
    }
  }
}
