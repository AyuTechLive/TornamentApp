import 'package:flutter/material.dart';
import 'package:oneup_noobs/Utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluecolor,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: width * 0.06, right: width * 0.06, top: height * 0.015),
        child: GridView.builder(
          padding: const EdgeInsets.all(4.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of items per row
            crossAxisSpacing: width * 0.03, // Space between items horizontally
            mainAxisSpacing: height * 0.015, // Space between items vertically
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            // Returning each item for the grid
            return Container(
              width: width * 0.3, // Adjust the width as needed
              height: width * 0.3,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/defaultbg.png'),
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
            );
          },
        ),
      ),
    );
  }
}
