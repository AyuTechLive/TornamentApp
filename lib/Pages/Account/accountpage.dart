import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Auth/login.dart';
import 'package:oneup_noobs/Pages/Account/itemcard.dart';
import 'package:oneup_noobs/Pages/Wallet/mywallet.dart';
import 'package:oneup_noobs/Pages/Wallet/userauthenticationtype.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;

    // Define the height of the blue container
    final double blueContainerHeight = height * 0.241;

    // Define the height of the green container
    final double greenContainerHeight = height * 0.1231;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.bluecolor,
        title: Text('Me'),
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior:
                  Clip.none, // Allows overflow of children outside the stack
              children: [
                Positioned(
                  child: Container(
                    width: width,
                    height: blueContainerHeight,
                    color: AppColors.bluecolor,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Container(
                            height: height * 0.12,
                            width: width * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset('assets/mainlogo.png'),
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Username       :  ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  FutureBuilder<String>(
                                    future: _walletbalance('Name'),
                                    builder: (context, snapshot) {
                                      return Text(
                                        '${snapshot.data}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Balance   : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  FutureBuilder<String>(
                                    future: _walletbalance('Wallet'),
                                    builder: (context, snapshot) {
                                      return Text(
                                        '${snapshot.data}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: height * 0.1,
                      )
                    ]),
                  ),
                ),
                Positioned(
                  left: 30,
                  right: 30,
                  bottom: -greenContainerHeight /
                      2, // Positioning half outside the blue container
                  child: Container(
                    width: width * 0.8,
                    height: greenContainerHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.greencolor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder<String>(
                              future: _walletbalance('matches'),
                              builder: (context, snapshot) {
                                return Text(
                                  '${snapshot.data}',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                            // Text(
                            //   "0",
                            //   style: const TextStyle(
                            //     fontFamily: "Inter",
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.white,
                            //   ),
                            //   textAlign: TextAlign.right,
                            // ),
                            Text(
                              "Matches",
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              "Played",
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Container(
                            height: height *
                                0.06, // Adjust the height of the vertical divider
                            width:
                                1, // Adjust the width of the vertical divider
                            color: Colors
                                .white // Specify the color of the vertical divider
                            ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder<String>(
                              future: _walletbalance('kills'),
                              builder: (context, snapshot) {
                                return Text(
                                  '${snapshot.data}',
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                            // Text(
                            //   "0",
                            //   maxLines: 3,
                            //   style: const TextStyle(
                            //     fontFamily: "Inter",
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.white,
                            //   ),
                            //   textAlign: TextAlign.left,
                            // ),
                            Text(
                              "Total",
                              maxLines: 3,
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Killed",
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Container(
                            height: height *
                                0.06, // Adjust the height of the vertical divider
                            width:
                                1, // Adjust the width of the vertical divider
                            color: Colors.white
                            // Specify the color of the vertical divider
                            ),
                        SizedBox(
                          width: width * 0.1,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "0",
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Amount",
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Won",
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Column(
              children: [
                ItemCardAccount(
                  iconname: Icons.person,
                  ontap: () {},
                  title: 'About Us',
                ),
                ItemCardAccount(
                  iconname: Icons.share,
                  ontap: () {},
                  title: 'Share',
                ),
                ItemCardAccount(
                  iconname: Icons.wallet,
                  ontap: () {
                    nextScreen(context, Wallet());
                  },
                  title: 'My Wallet',
                ),
                ItemCardAccount(
                  iconname: Icons.military_tech,
                  ontap: () {},
                  title: 'My Matches',
                ),
                ItemCardAccount(
                  iconname: Icons.bar_chart,
                  ontap: () {},
                  title: 'My Statistics',
                ),
                ItemCardAccount(
                  iconname: Icons.emoji_events,
                  ontap: () {},
                  title: 'My Rewards',
                ),
                ItemCardAccount(
                  iconname: Icons.leaderboard,
                  ontap: () {},
                  title: 'Leaderboard',
                ),
                ItemCardAccount(
                  iconname: Icons.group_add,
                  ontap: () {},
                  title: 'My Referal',
                ),
                ItemCardAccount(
                  iconname: Icons.logout,
                  ontap: () {
                    auth.signOut().then(
                      (value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                    );
                  },
                  title: 'Logout',
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> _walletbalance(String value) async {
    String userEmailsDocumentId = checkUserAuthenticationType();
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmailsDocumentId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    if (userDocSnapshot.exists) {
      if (value == 'matches') {
        List<dynamic> matches = userDocSnapshot.get(value) ?? [];
        return matches.length.toString();
      } else {
        var currentValue = userDocSnapshot[value] ?? '0';
        return currentValue.toString();
      }
    } else {
      return '0';
    }
  }
}
