import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Components/tournamentpage_tile.dart';
import 'package:oneup_noobs/Pages/tournament_details.dart';
import 'package:oneup_noobs/Services/database_Services.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

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
          backgroundColor: AppColors.bluecolor,
        ),
        body: Expanded(child: tournamentpage()));
  }
  // SingleChildScrollView(
  //   child: Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Center(child: TornamentPageTile(
  //         ontap: () {
  //           nextScreen(context, TournamentDetails());
  //         },
  //       )),
  //       SizedBox(
  //         height: height * 0.03,
  //       ),
  //       Center(child: TornamentPageTile(
  //         ontap: () {
  //           nextScreen(context, TournamentDetails());
  //         },
  //       ))
  //     ],
  //   ),
  // ),
}

Widget tournamentpage() {
  return StreamBuilder<DatabaseEvent>(
    stream: DatabaseService().getNodeStream('PUBG'),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        DataSnapshot dataValues = snapshot.data!.snapshot;
        Map<dynamic, dynamic>? values =
            dataValues.value as Map<dynamic, dynamic>?;
        if (values == null) {
          return Center(child: Text('No data available'));
        }
        List<dynamic> list = values.values.toList();

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return TornamentPageTile(
              matchtitle: list[index]['Match Title'],
              map: list[index]['Map'],
              date: list[index]['Date'],
              entryfees: list[index]['Entry Fees'],
              matchimg: list[index]['Match Img'],
              matchtype: list[index]['Match Type'],
              perkill: list[index]['Per Kill'],
              prizepool: list[index]['Prize Pool'],
              time: list[index]['Prize Pool'],
              ontap: () {
                nextScreen(context, TournamentDetails());
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
