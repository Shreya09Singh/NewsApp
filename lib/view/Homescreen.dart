import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nextnew/model/NewsHeadLinesModel.dart';
import 'package:nextnew/view/Catagoryscreen.dart';
import 'package:nextnew/view/Detailscreen.dart';

import 'package:nextnew/view_model/NewsViewModel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

enum NewsFilterList { TimesOfIndia, CNN, GoogleNews, TheNextWeb, Reuters }

class _HomescreenState extends State<Homescreen> {
  final NewsViewModel _newsViewModel = NewsViewModel();
  late NewsHeadLinesModel? bbcNewsHeadLinesModel;

  NewsFilterList? selectedValue;
  String name = "the-times-of-india";

  final formate = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Catagoryscreen()));
            },
            icon: Image.asset(
              "images/category_icon.png",
              height: 25,
              width: 25,
            )),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              initialValue: selectedValue,
              onSelected: (NewsFilterList item) {
                if (NewsFilterList.TimesOfIndia.name == item.name) {
                  name = 'the-times-of-india';
                }
                if (NewsFilterList.GoogleNews.name == item.name) {
                  name = 'new-scientist';
                }
                if (NewsFilterList.CNN.name == item.name) {
                  name = 'cnn';
                }
                if (NewsFilterList.Reuters.name == item.name) {
                  name = 'reuters';
                }
                if (NewsFilterList.TheNextWeb.name == item.name) {
                  name = 'the-next-web';
                }

                setState(() {
                  selectedValue = item;
                });

                // setState(() {
                //   selectedValue = item;
                //   // seletcedSource = source;
                // });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<NewsFilterList>>[
                    PopupMenuItem<NewsFilterList>(
                      child: Text("TimesOfIndia"),
                      value: NewsFilterList.TimesOfIndia,
                    ),
                    PopupMenuItem<NewsFilterList>(
                      child: Text("GoogleNews"),
                      value: NewsFilterList.GoogleNews,
                    ),
                    PopupMenuItem<NewsFilterList>(
                      child: Text("CNN"),
                      value: NewsFilterList.CNN,
                    ),
                    PopupMenuItem<NewsFilterList>(
                      child: Text("Reuters"),
                      value: NewsFilterList.Reuters,
                    ),
                    PopupMenuItem<NewsFilterList>(
                      child: Text("TheNextWe"),
                      value: NewsFilterList.TheNextWeb,
                    ),
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
              height: height,
              width: width,
              child: FutureBuilder<NewsHeadLinesModel>(
                  future: _newsViewModel.fetchnewsHeadlines(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: SpinKitCircle(
                        color: Colors.red,
                        size: 50,
                      ));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.articles == null) {
                      print('This is the data${snapshot.data}');

                      return Center(child: Text("No data available"));
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.articles.length ?? 0,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles[index].publishedAt
                                .toString());
                            final imageData =
                                snapshot.data!.articles[index].urlToImage;
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Detailscreen(
                                                    imageUrl: snapshot
                                                        .data!
                                                        .articles[index]
                                                        .urlToImage,
                                                    source: snapshot
                                                        .data!
                                                        .articles[index]
                                                        .source
                                                        .name,
                                                    title: snapshot.data!
                                                        .articles[index].title
                                                        .toString(),
                                                    datetime: dateTime,
                                                    details: snapshot
                                                        .data!
                                                        .articles[index]
                                                        .description,
                                                    author: snapshot.data!
                                                        .articles[index].author,
                                                  )));
                                    },
                                    child: Container(
                                      height: height * .45,
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, top: 15),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          width: width * .9,
                                          height: height * 1,
                                          imageUrl: imageData,
                                          errorListener: (value) {
                                            SpinKitCircle(
                                              color: Colors.red,
                                            );
                                          },
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              spinkitcircle,
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: height * .02,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: EdgeInsets.only(
                                          left: 12, right: 12, top: 12),
                                      width: width * .7,
                                      height: height * .25,
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles[index].title,
                                            maxLines: 3,
                                            // overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  snapshot.data!.articles[index]
                                                      .source!.name
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              Expanded(
                                                child: Text(
                                                    formate.format(
                                                      dateTime,
                                                    ),
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  })),
        ],
      ),
    );
  }
}

const spinkitcircle = SpinKitCircle(
  color: Colors.red,
);
