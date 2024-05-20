import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Pages/Wallet/components/walletbutton.dart';
import 'package:oneup_noobs/Pages/Wallet/components/wallettext.dart';
import 'package:oneup_noobs/Pages/Wallet/paymentgateway.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.01220,
          ),
          Center(
            child: Container(
              // height: height * 0.198,
              width: width * 0.9625,
              child: Column(
                children: [
                  Container(
                    width: width * 0.9625,
                    height: height * 0.0437,
                    decoration: ShapeDecoration(
                      color: Color(0xFF5FCCB1),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF75C7B3)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'TOTAL BALANCE',
                        style: TextStyle(
                          color: Color(0xFFD3FAF5),
                          fontSize: 27,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.9625,
                    height: height * 0.155,
                    color: Color(0xffADE5D7),
                    child: Center(
                      child: Column(children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Column(
                              children: [
                                FutureBuilder<String>(
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
                                      return Wallettext(
                                        title: '🪙${snapshot.data}',
                                      );
                                    }
                                  },
                                ),
                                Wallettext(
                                  title: 'Win money : 🪙0.00',
                                ),
                                Wallettext(
                                  title: 'Join money : 🪙0.00',
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Walletbutton(
                                  ontap: () {
                                    nextScreen(context, Paymentgatway());
                                  },
                                  title: 'Add',
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Walletbutton(
                                  ontap: () {},
                                  title: 'Withdraw',
                                )
                              ],
                            ),
                            Spacer()
                          ],
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
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
}
