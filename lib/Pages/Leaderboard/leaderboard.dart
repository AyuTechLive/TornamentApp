import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late DatabaseReference participantsRef;
  late Stream<DatabaseEvent> participantsStream;

  @override
  void initState() {
    super.initState();
    participantsRef = FirebaseDatabase.instance
        .ref()
        .child('COD')
        .child('1716443500452')
        .child('Kills');
    participantsStream = participantsRef.onValue;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double height = screenSize.height;
    final double width = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluecolor,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DatabaseEvent>(
          stream: participantsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic>? participantsMap =
                  snapshot.data?.snapshot.value as Map?;
              if (participantsMap != null) {
                List<MapEntry<dynamic, dynamic>> participantsList =
                    participantsMap.entries.toList();
                int rowNum = 0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.93,
                      height: height * 0.05,
                      decoration: ShapeDecoration(
                        color: Color(0xFF5ECDB1),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF73C8B1)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Match Results',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 40, 40, 40),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF73C8B1)),
                          ),
                        ),
                        child: Container(
                          width: width * 0.93,
                          child: DataTable(
                            headingRowHeight: height * 0.05,
                            columns: [
                              DataColumn(
                                  label: Text(
                                '#',
                                style: TextStyle(color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Player Name',
                                style: TextStyle(color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text('Kills',
                                      style: TextStyle(color: Colors.white))),
                            ],
                            rows: participantsList.map((participant) {
                              String uid = participant.key.toString();
                              Map<dynamic, dynamic> participantData =
                                  participant.value;
                              String email = participantData['Email'];
                              String kills =
                                  participantData['Killing'].toString();
                              rowNum++; // Increment the row number

                              return DataRow(
                                color: MaterialStateProperty.all(Colors.white),
                                cells: [
                                  DataCell(Text(rowNum.toString())),
                                  DataCell(Text(uid)),
                                  DataCell(Text(kills.toString())),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
