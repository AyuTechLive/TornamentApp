import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oneup_noobs/Pages/tournament_page.dart';
import 'package:oneup_noobs/Services/database_Services.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> games;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    games = DatabaseService().getGamesStream();
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bluecolor,
        ),
        body: Expanded(child: notificationFetcher()));
  }

  Widget notificationFetcher() {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return StreamBuilder(
      stream: games,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // Sort the list of notifications based on timestamp
          // Assuming 'id' is the timestamp

          return GridView.builder(
            padding: const EdgeInsets.all(4.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of items per row
              crossAxisSpacing:
                  width * 0.03, // Space between items horizontally
              mainAxisSpacing: height * 0.015, // Space between items vertically
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Returning each item for the grid
              return InkWell(
                onTap: () {
                  nextScreen(context, TournamentPage());
                },
                child: Container(
                  width: width * 0.3, // Adjust the width as needed
                  height: width * 0.3,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          snapshot.data!.docs[index]['GameImg'].toString()),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.50),
                        topRight: Radius.circular(9.75),
                        bottomLeft: Radius.circular(13.50),
                        bottomRight: Radius.circular(9.75),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
