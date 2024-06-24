import 'package:nextnew/model/CatagoryModel.dart';
import 'package:nextnew/model/NewsHeadLinesModel.dart';
import 'package:nextnew/model/SourceNewsModel.dart';

import 'package:nextnew/services/newsApiOperation.dart';

class NewsViewModel {
  final _rep = Newsapioperation();
  Future<NewsHeadLinesModel> fetchnewsHeadlines(String channelname) async {
    final response = await _rep.getNewsHeadLinesApi(channelname);

    return response;
  }

  Future<CatagoryModel> fetchcatagoryHeadlines(String catagory) async {
    final response = await _rep.getCatagoryHeadLinesApi(catagory);
    Future.delayed(Duration(seconds: 3));
    print(response);
    return response;
  }
}
