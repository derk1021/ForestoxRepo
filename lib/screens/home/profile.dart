import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:tonyyaooo/screens/home/discussion/view/discussion_screen.dart';
import 'package:tonyyaooo/screens/home/stocks/stocks_landing/view/stocks_landing_screen.dart';
import 'package:tonyyaooo/service/authentication.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile"
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Get.off(
                  ()=> const StocksLandingScreen(),
              transition: Transition.fade
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  auth.currentUser?.photoURL ?? "https://firebasestorage.googleapis.com/v0/b/forestox-ee2a6.appspot.com/o/images%2F2023-09-20%2016%3A37%3A07.166333?alt=media&token=f41bb547-cdff-4fae-a95b-6d3438198867"
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "User",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    width: 100,
                    height: 70,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          "2353",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Poppins'
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "Posts",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    width: 100,
                    height: 70,
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            "2353",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins'
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                              "Likes",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'
                              )
                          )
                        ]
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2
                      ),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    width: 100,
                    height: 70,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            "24",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins'
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                              "Watchlist",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'
                              )
                          )
                        ]
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 80, 8, 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child:
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Text(
                        "About us",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child:  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: GestureDetector(
                        onTap: (){
                          AuthenticationHelper().signOut();
                        },
                        child: const Text(
                          "Log out",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}