import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class JoiningMatch extends StatefulWidget {
  final String entryfees;
  final String game;
  final String matchid;
  const JoiningMatch(
      {super.key,
      required this.entryfees,
      required this.game,
      required this.matchid});

  @override
  State<JoiningMatch> createState() => _JoiningMatchState();
}

class _JoiningMatchState extends State<JoiningMatch> {
  late DatabaseReference databaseRef;
  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluecolor,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/wallet.png',
                scale: 1.5,
              ),
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    FutureBuilder<String>(
                      future: _walletbalance(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...');
                        } else if (snapshot.hasError) {
                          return Text('Error');
                        } else {
                          return Text(
                            "Your Current Balance: 🪙${snapshot.data}",
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff595a5d),
                              height: 21 / 22,
                            ),
                            textAlign: TextAlign.left,
                          );
                          // Wallettext(
                          //   title: '🪙${snapshot.data}',
                          // );
                        }
                      },
                    ),
                    // Text(
                    //   "Your Current Balance: 🪙 0.00",
                    //   style: const TextStyle(
                    //     fontFamily: "Inter",
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w400,
                    //     color: Color(0xff595a5d),
                    //     height: 21 / 22,
                    //   ),
                    //   textAlign: TextAlign.left,
                    // ),
                  ]),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Match Entry Fee Per Person :🪙${widget.entryfees}",
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff595b5d),
                          height: 23 / 20,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Total Payable Amount : 🪙10",
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff5a5c5e),
                      height: 23 / 20,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              )
            ],
          ),
          // Container(
          //   child: Column(
          //     children: [
          //       Container(
          //         width: width * 0.94,
          //         height: height * 0.0584795321637427,
          //         decoration: ShapeDecoration(
          //           color: Color(0xFF5ECDB1),
          //           shape: RoundedRectangleBorder(
          //             side: BorderSide(width: 1, color: Color(0xFF73C8B1)),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: height * 0.3,
          ),
          Row(
            children: [
              Spacer(),
              Container(
                width: width * 0.38,
                height: height * 0.069,
                decoration: ShapeDecoration(
                  color: Color(0xFFEF7A78),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF8FCCBB)),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Center(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Color(0xFFD1F9F4),
                      fontSize: 21,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  _updateWallet(widget.matchid);
                },
                child: Container(
                  width: width * 0.38,
                  height: height * 0.069,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5DCDB1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF8FCCBB)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'JOIN',
                      style: TextStyle(
                        color: Color(0xFFD1F9F4),
                        fontSize: 21,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer()
            ],
          )
        ],
      ),
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

  Future<void> _updateWallet(String matchid) async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      var currentWalletValue = userDocSnapshot['Wallet'] ?? '0';
      int currentWallet = int.parse(currentWalletValue);
      int entryFees = int.parse(widget.entryfees);

      if (currentWallet >= entryFees) {
        int updatedWalletValue = currentWallet - entryFees;

        await userDocRef.update({'Wallet': updatedWalletValue.toString()}).then(
          (value) async {
            await userDocRef.update({
              'matches': FieldValue.arrayUnion([matchid])
            }).then((value) {
              databaseRef = FirebaseDatabase.instance.ref(widget.game);
              databaseRef
                  .child(widget.matchid)
                  .child('Participants')
                  .update({userDocSnapshot['UID']: userDocSnapshot['Email']});
              print('Match ID added successfully');
            });
          },
        );
      } else {
        // Show insufficient balance message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Insufficient balance to join the match'),
          ),
        );
      }
    }
  }
}
