import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:oneup_noobs/Utils/roundbutton.dart';
import 'package:oneup_noobs/Utils/utils.dart';

class AddpdfAdmin extends StatefulWidget {
  const AddpdfAdmin({
    super.key,
  });

  @override
  State<AddpdfAdmin> createState() => _AddpdfAdminState();
}

class _AddpdfAdminState extends State<AddpdfAdmin> {
  bool loading = false;
  final postcontroller = TextEditingController();
  late TextEditingController cousenamecontroller;
  final matchtitlecontroller = TextEditingController();
  final mapcontroller = TextEditingController();
  final entryfeescontroller = TextEditingController();
  final matchimgcontroller = TextEditingController();
  final matchtypecontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final timecontroller = TextEditingController();
  final prizepoolcontroller = TextEditingController();
  final perkillcontroller = TextEditingController();
  final roomidcontroller = TextEditingController();

  late DatabaseReference databaseRef;
  late FirebaseStorage storage;
  String? selectedCourse;
  List<String> courses = [];

  @override
  void initState() {
    fetchCourses();
    // TODO: implement initState

    cousenamecontroller = TextEditingController();
    storage = FirebaseStorage.instance;
  }

  void fetchCourses() async {
    // Fetch courses from Firestore and update the local list
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Games').get();
    for (var doc in querySnapshot.docs) {
      courses.add(doc.id); // Assuming you use document IDs as course names
    }
    // If required, update the state to reflect the changes in the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String action = 'Pdfs';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF17306),
        title: Text('Add Your Course Content'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              DropdownButtonFormField<String>(
                value: selectedCourse,
                hint: Text('Select Game'),
                items: courses.map((String course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (newValue) {
                  // Update the selected course state
                  setState(() {
                    selectedCourse = newValue;
                    cousenamecontroller.text = selectedCourse ?? '';
                  });
                },
              ),
              // TextFormField(
              //   controller: cousenamecontroller,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //       hintText: 'Enter the course name',
              //       border: OutlineInputBorder()),
              // ),
              TextFormField(
                controller: matchtitlecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Match Title',
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: matchtypecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Match Type',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: mapcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'map', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: entryfeescontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Your Entry Fees',
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: datecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Match Date',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: timecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Match Time', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: prizepoolcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Prizepool', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: perkillcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Per Kill', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: roomidcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Room Id', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: matchimgcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Your Image url',
                    border: OutlineInputBorder(),
                    icon: InkWell(
                        onTap: () {
                          // pickAndUploadPdf();
                        },
                        child: Icon(Icons.add))),
              ),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                loading: loading,
                title: 'Add PDF',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  databaseRef = FirebaseDatabase.instance
                      .ref(cousenamecontroller.text.toString());

                  String id = postcontroller.text.toString();
                  String idnew =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef
                      .child(id)
                      // inreplacement of videos action is used
                      .child(idnew)
                      .set({
                    'id': idnew,
                    'Match Title': matchtitlecontroller.text.toString(),
                    'Match Img': matchimgcontroller.text.toString(),
                    'Match Type': matchtypecontroller.text.toString(),
                    'Map': mapcontroller.text.toString(),
                    'Entry Fees': entryfeescontroller.text.toString(),
                    'Date': datecontroller.text.toString(),
                    'Time': timecontroller.text.toString(),
                    'Prize Pool': prizepoolcontroller.text.toString(),
                    'Per Kill': perkillcontroller.text.toString(),
                    'Participants': {},
                    'Room ID': roomidcontroller.text.toString(),
                  }).then(
                    (value) {
                      Utils().toastMessage('Post Succesfully Added');
                      setState(() {
                        loading = false;
                        matchtitlecontroller.clear();
                        mapcontroller.clear();
                        entryfeescontroller.clear();
                        matchimgcontroller.clear();
                        matchtypecontroller.clear();
                      });
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
