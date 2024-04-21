import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/minorcomponents/tournamentdetails_container.dart';

class TournamentDetails extends StatefulWidget {
  const TournamentDetails({super.key});

  @override
  State<TournamentDetails> createState() => _TournamentDetailsState();
}

class _TournamentDetailsState extends State<TournamentDetails> {
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
      body: Column(
        children: [
          Center(
            child: Container(
              width: width * 0.953,
              height: height * 0.229,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/defaultbg.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text(
                      'Duo Night Battlemania -Match #2',
                      style: TextStyle(
                        color: AppColors.greencolor,
                        fontSize: 23,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.04,
                      ),
                      TournamentDetailsContainer(
                        title: 'Team',
                        value: 'Duo',
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      TournamentDetailsContainer(
                        title: 'Entry Fee 🪙',
                        value: '50',
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.04,
                      ),
                      TournamentDetailsContainer(
                        title: 'Match Type',
                        value: 'PAID',
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      TournamentDetailsContainer(
                        title: 'Map',
                        value: 'Miramar',
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.04,
                      ),
                      TournamentDetailsContainer(
                        title: 'Match Schedule',
                        value: '22/01/202111:00pm',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text(
                      'Price Details',
                      style: TextStyle(
                        color: AppColors.greencolor,
                        fontSize: 23,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.04,
                      ),
                      TournamentDetailsContainer(
                        title: 'WinningPrize',
                        value: '50(%)',
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      TournamentDetailsContainer(
                        title: 'Per Kill',
                        value: '45(%)',
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Text(
                      'About This Match',
                      style: TextStyle(
                        color: AppColors.greencolor,
                        fontSize: 23,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Row(children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    SizedBox(
                      width: width * 0.9,
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen bookIt was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                        style: TextStyle(
                          color: Color(0xFF545657),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          Container(
            width: width,
            height: height * 0.05,
            color: AppColors.orangecolor,
            child: Center(
              child: Text(
                'JOIN NOW',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
