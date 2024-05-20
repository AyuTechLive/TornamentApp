import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oneup_noobs/Pages/Wallet/components/wallettext.dart';
import 'package:oneup_noobs/Pages/Wallet/mywallet.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
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
          title: Row(
            children: [
              Text('Tournaments'),
              Spacer(),
              InkWell(
                onTap: () {
                  nextScreen(context, Wallet());
                },
                child: Container(
                  width: width * 0.300,
                  height: height * 0.039,
                  decoration: ShapeDecoration(
                    color: Color(0xFEFCFDFB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF96D2EB)),
                      borderRadius: BorderRadius.circular(6.50),
                    ),
                  ),
                  child: Center(
                    child: FutureBuilder<String>(
                      future: _walletbalance(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Wallettext(
                            title: 'Loading...',
                          );
                        } else if (snapshot.hasError) {
                          return Wallettext(
                            title: 'Error',
                          );
                        } else {
                          return Text(
                            '🪙 ${snapshot.data}',
                            style: TextStyle(
                              color: Color(0xFF494B4D),
                              fontSize: 25,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          );
                          // Wallettext(
                          //   title: '🪙${snapshot.data}',
                          // );
                        }
                      },
                    ),
                    // Text(
                    //   '🪙 0.00',
                    //   style: TextStyle(
                    //     color: Color(0xFF494B4D),
                    //     fontSize: 25,
                    //     fontFamily: 'Inter',
                    //     fontWeight: FontWeight.w400,
                    //     height: 0,
                    //   ),
                    // ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(children: [Expanded(child: notificationFetcher())]));
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
                  nextScreen(
                      context,
                      TournamentPage(
                        gamename:
                            snapshot.data!.docs[index]['GameName'].toString(),
                      ));
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

  Future<String> _walletbalance() async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['Wallet'] ?? '0';
      return currentWalletValue.toString();
    } else {
      return '0';
    }
  }
}
