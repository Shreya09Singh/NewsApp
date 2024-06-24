// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Detailscreen extends StatefulWidget {
  String title;
  String imageUrl;
  DateTime datetime;
  String source;
  String details;

  String author;
  Detailscreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.datetime,
    required this.source,
    required this.details,
    required this.author,
  }) : super(key: key);

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  final formate = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.source),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                height: height * .43,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formate.format(
                        widget.datetime,
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: Text(
                        widget.source,
                        style: GoogleFonts.poppins(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  widget.details,
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),

                // SizedBox(
                //   height: 15,
                // ),
                //
                SizedBox(
                  height: 13,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '${widget.author}',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
