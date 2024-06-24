import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nextnew/model/CatagoryModel.dart';
import 'package:nextnew/view/Detailscreen.dart';
import 'package:nextnew/view_model/NewsViewModel.dart';

class Catagoryscreen extends StatefulWidget {
  const Catagoryscreen({super.key});

  @override
  State<Catagoryscreen> createState() => _CatagoryscreenState();
}

class _CatagoryscreenState extends State<Catagoryscreen> {
  final NewsViewModel _catagorymodel = NewsViewModel();
  final formate = DateFormat('MMMM dd, yyyy');
  List catagoryList = [
    'general',
    'sports',
    'entertainment',
    'health',
    'science',
    'business'
  ];
  String selectedCatagory = 'general';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25,
              )),
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catagoryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectedCatagory = catagoryList[index];
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: selectedCatagory == catagoryList[index]
                            ? Colors.lightBlueAccent
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        catagoryList[index],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      )),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder<CatagoryModel>(
                future: _catagorymodel.fetchcatagoryHeadlines(selectedCatagory),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.grey,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.articles.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles[index].publishedAt
                              .toString());

                          final imagedata =
                              snapshot.data!.articles[index].urlToImage;
                          final titledata =
                              snapshot.data?.articles[index].title;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detailscreen(
                                          title: snapshot
                                              .data!.articles[index].title,
                                          imageUrl: snapshot
                                              .data!.articles[index].urlToImage
                                              .toString(),
                                          datetime: dateTime,
                                          source: snapshot.data!.articles[index]
                                              .source.name,
                                          details: snapshot
                                              .data!.articles[index].description
                                              .toString(),
                                          author: snapshot
                                              .data!.articles[index].author
                                              .toString())));
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 8,
                                        bottom: 12),
                                    child: CachedNetworkImage(
                                      width: width * .3,
                                      height: height * .18,
                                      imageUrl: imagedata != null
                                          ? imagedata.toString()
                                          : 'https://via.placeholder.com/150', // Use a placeholder URL
                                      placeholder: (context, url) =>
                                          SpinKitCircle(
                                              color: Colors
                                                  .blue), // Placeholder widget
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: height * .18,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        titledata != null &&
                                                titledata.isNotEmpty
                                            ? titledata
                                            : 'No title available',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles[index]
                                                .source.name,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            formate.format(
                                              dateTime,
                                            ),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromARGB(
                                                    255, 20, 75, 118)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
