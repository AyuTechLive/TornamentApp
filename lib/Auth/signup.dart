import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oneup_noobs/Auth/login.dart';
import 'package:oneup_noobs/Pages/homepage.dart';
import 'package:oneup_noobs/Pages/mainpage.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/utils.dart';
import 'package:oneup_noobs/minorcomponents/roundbutton.dart';

class SignUpNew extends StatefulWidget {
  const SignUpNew({super.key});

  @override
  State<SignUpNew> createState() => _SignUpNewState();
}

class _SignUpNewState extends State<SignUpNew> {
  bool loading = false;
  final _formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  bool _isPasswordVisible = false;

  // final databaseref = FirebaseDatabase.instance;
  var username = '';

  FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('Users');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    DateTime currentDate = DateTime.now();
    String formattedDate =
        '${currentDate.day}-${currentDate.month}-${currentDate.year}';
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              ),
              SizedBox(
                height: height * 0.0425,
              ),
              Text(
                'Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
              Form(
                  key: _formfield,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.04125,
                      ),
                      TextFormField(
                        controller: namecontroller,
                        decoration: const InputDecoration(
                            hintText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                    color: AppColors.bluecolor, width: 3)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: AppColors.bluecolor, width: 3),
                            ),
                            //helperText: 'Enter your email',
                            prefixIcon: Icon(
                              Icons.perm_identity,
                              color: AppColors.bluecolor,
                            )),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text(
                        'Email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                    color: AppColors.bluecolor, width: 3)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: AppColors.bluecolor, width: 3),
                            ),
                            //helperText: 'Enter your email',
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: AppColors.bluecolor,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text(
                        'Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                    color: AppColors.bluecolor, width: 3)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: AppColors.bluecolor, width: 3),
                            ),
                            // helperText: 'Enter your password',
                            prefixIcon: Icon(
                              Icons.lock_clock_outlined,
                              color: AppColors.bluecolor,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? (Icons.visibility)
                                      : Icons.visibility_off,
                                  color: _isPasswordVisible
                                      ? AppColors
                                          .bluecolor // Color when password is visible
                                      : AppColors.bluecolor,
                                ))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: height * 0.05375,
              ),
              Roundbuttonnew(
                  loading: loading,
                  title: 'SignUp',
                  ontap: () {
                    if (_formfield.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });

                      _auth
                          .createUserWithEmailAndPassword(
                        email: emailcontroller.text.toString(),
                        password: passwordcontroller.text.toString(),
                      )
                          .then((value) {
                        String id = emailcontroller.text.toString();
                        fireStore.doc(id).set({
                          'Email': emailcontroller.text.toString(),
                          'Password': passwordcontroller.text.toString(),
                          'UID':
                              DateTime.now().microsecondsSinceEpoch.toString(),
                          'My Courses': [],
                          'DOJ': formattedDate,
                          'Name': namecontroller.text.toString(),
                          'Wallet': "0",
                        }).then(
                          (value) {
                            setState(() {
                              loading = false;
                              Utils()
                                  .toastMessage('Account Sucessfully Created');
                              _auth // login succesful to then function mei chala jayega warna on error mei chala jayegaa
                                  .signInWithEmailAndPassword(
                                      email: emailcontroller.text.toString(),
                                      password:
                                          passwordcontroller.text.toString())
                                  .then(
                                (value) {
                                  Utils().toastMessage('Login succesful');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainPage(),
                                      ));
                                },
                              ).onError(
                                (error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                },
                              );
                            });
                          },
                        );
                      }).onError(
                        (error, stackTrace) {
                          Utils().toastMessage(error.toString());
                          setState(() {
                            loading = false;
                          });
                        },
                      );
                    }
                  }),
              SizedBox(
                height: height * 0.0475,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have An Account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: AppColors.bluecolor),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
