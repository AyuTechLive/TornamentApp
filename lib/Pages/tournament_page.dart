import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Components/tournamentpage_tile.dart';
import 'package:oneup_noobs/Pages/tournament_details.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: TornamentPageTile(
              ontap: () {
                nextScreen(context, TournamentDetails());
              },
            )),
            SizedBox(
              height: height * 0.03,
            ),
            Center(child: TornamentPageTile(
              ontap: () {
                nextScreen(context, TournamentDetails());
              },
            ))
          ],
        ),
      ),
    );
  }
}
