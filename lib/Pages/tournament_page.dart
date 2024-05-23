import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Components/tournamentpage_tile.dart';
import 'package:oneup_noobs/Pages/Wallet/components/wallettext.dart';
import 'package:oneup_noobs/Pages/Wallet/mywallet.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Pages/tournament_details.dart';
import 'package:oneup_noobs/Services/database_Services.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class TournamentPage extends StatefulWidget {
  final String gamename;
  final String walletbalance;
  const TournamentPage(
      {super.key, required this.gamename, required this.walletbalance});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
        backgroundColor: AppColors.greycolor,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.bluecolor,
          title: Row(
            children: [
              Text(
                widget.gamename,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Image.asset(
                            'assets/coin.png',
                            scale: 20,
                          ),
                          Spacer(),
                          FutureBuilder<String>(
                            future: _walletbalance(),
                            builder: (context, snapshot) {
                              return Text(
                                '${widget.walletbalance}',
                                style: TextStyle(
                                  color: Color(0xFF494B4D),
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  height: 0,
                                ),
                              );
                            },
                          ),
                          Spacer(),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(children: [
          Expanded(child: tournamentpage(widget.gamename, context))
        ]));
  }
}

Future<String> _walletbalance() async {
  String userEmailsDocumentId = checkUserAuthenticationType();
  DocumentReference userDocRef =
      FirebaseFirestore.instance.collection('Users').doc(userEmailsDocumentId);

  DocumentSnapshot userDocSnapshot = await userDocRef.get();
  if (userDocSnapshot.exists) {
    var currentWalletValue = userDocSnapshot['Wallet'] ?? '0';
    return currentWalletValue.toString();
  } else {
    return '0';
  }
}

Widget tournamentpage(String gamename, BuildContext context) {
  final Size screensize = MediaQuery.of(context).size;
  final double height = screensize.height;
  final double width = screensize.width;
  return StreamBuilder<DatabaseEvent>(
    stream: DatabaseService().getNodeStream(gamename),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        DataSnapshot dataValues = snapshot.data!.snapshot;
        Map<dynamic, dynamic>? values =
            dataValues.value as Map<dynamic, dynamic>?;

        if (values == null) {
          return Center(child: Text('No data available'));
        }
        List<dynamic> list = values.values.toList();
        List<String> participantEmailList = [];

        return ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: height * 0.005,
            );
          },
          itemCount: list.length,
          itemBuilder: (context, index) {
            int participantCount = 0;
            if (list[index]['Participants'] != null) {
              Map<dynamic, dynamic> participants = list[index]['Participants'];

              participantCount = participants.length;
              participantEmailList
                  .addAll(participants.values.map((value) => value.toString()));
            }

            return TornamentPageTile(
              matchtitle: list[index]['Match Title'],
              map: list[index]['Map'],
              date: list[index]['Date'],
              entryfees: list[index]['Entry Fees'],
              matchimg: list[index]['Match Img'],
              matchtype: list[index]['Match Type'],
              perkill: list[index]['Per Kill'],
              prizepool: list[index]['Prize Pool'],
              time: list[index]['Time'],
              maxparticipants: list[index]['Max Participants'],
              enrolledparticipants: participantCount.toString(),
              ontap: () {
                nextScreen(
                    context,
                    TournamentDetails(
                      matchtitle: list[index]['Match Title'],
                      img: list[index]['Match Img'],
                      date: list[index]['Date'],
                      entryfees: list[index]['Entry Fees'],
                      game: gamename,
                      map: list[index]['Map'],
                      matchid: list[index]['id'],
                      perkill: list[index]['Per Kill'],
                      prizepool: list[index]['Prize Pool'],
                      team: list[index]['Match Type'],
                      time: list[index]['Time'],
                      roomid: list[index]['Room ID'],
                      partcipantlist: participantEmailList,
                    ));
              },
            );
            // ListTile(
            //   title: Text(list[index]['Match Title'] ?? 'No Title'),
            //   subtitle: Text(list[index]['Date'] ?? 'No Date'),
            // );
          },
        );
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
