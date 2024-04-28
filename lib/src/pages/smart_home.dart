import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_app/src/widgets/render_svg.dart';

import '../controllers/smart_home_data.dart';
import '../widgets/Ktext.dart';
import '../widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SmartHome extends StatefulWidget {
  @override
  State<SmartHome> createState() => _SmartHomeState();
}

class _SmartHomeState extends State<SmartHome> {
  int value = 0;

  bool positive = false;

  bool loading = false;

  // Add a new Map to store the switch state for each item
  Map<String, bool> switchStates = {};
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    // Initialize switchStates with default values (all false) based on smartModel length
    for (var i = 0; i < smartModel.length; i++) {
      switchStates['item_$i'] = false; // Use a unique key for each item
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: HexColor('#D8E4E8'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor('#4C7380'),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: HexColor('#4C7380'),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(40))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 40,
                              ),
                              child: KText(
                                text: 'Smart Home',
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 38,
                                right: 15,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RenderSvg(
                                    path: 'persent',
                                    color: HexColor('#507682'),
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: HexColor('#D8E4E8'),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Living Room',
                                    fontSize: 20,
                                    color: Colors.black87,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 25,
                                    color: HexColor('#507682'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                color: HexColor('#D8E4E8'),
                borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 2,
                    ),
                    child: Row(
                      children: [
                        KText(
                          text: 'Smart Mode ',
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: HexColor('#4C7380'),
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: KText(
                              text: '3',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: smartModel.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      final item = smartModel[index];
                      final isSwitchedOn = switchStates['item_$index'];
                      return Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 8,
                        ),
                        height: 110,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: '${item['title']}',
                                        fontSize: 15,
                                      ),
                                      KText(
                                        text: '${item['category']}  | Tue Thu',
                                        fontWeight: FontWeight.w400,
                                      )
                                    ],
                                  ),
                                  AnimatedToggleSwitch<bool>.dual(
                                    current: isSwitchedOn!,
                                    first: false,
                                    second: true,
                                    dif: 10.0,
                                    borderColor: Colors.transparent,
                                    borderWidth: 3.0,
                                    height: 26,
                                    indicatorSize: Size(30, 20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, .5),
                                      ),
                                    ],
                                    onChanged: (b) {
                                      setState(() {
                                        switchStates['item_$index'] =
                                            b; // Update state in switchStates
                                        _updateLEDStatus(index,b); // Pass index and new state for LED control
                                      });
                                      return Future.delayed(
                                        Duration(
                                            seconds:
                                                1), // Optional delay, remove if not needed
                                      );
                                    },
                                    colorBuilder: (b) =>
                                        b ? Colors.yellow[900] : Colors.teal,
                                    iconBuilder: (value) => value
                                        ? Icon(
                                            Icons.coronavirus_rounded,
                                            size: 19,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.tag_faces_rounded,
                                            size: 19,
                                            color: HexColor('#ffffff'),
                                          ),
                                    textBuilder: (value) => value
                                        ? Center(
                                            child: KText(
                                              text: 'ON',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Center(
                                            child: KText(
                                                text: 'OFF',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  RenderSvg(
                                    path: '${item['image']}',
                                    height: 45,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 57,
                                    ),
                                    child: Column(
                                      children: [
                                        KText(
                                          text: 'from',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        KText(
                                          text: '8 pm',
                                          fontSize: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      KText(
                                        text: 'to',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      KText(
                                        text: '8 am',
                                        fontSize: 16,
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 40,
                                    width: 1,
                                    color: Colors.blueGrey,
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                   
                                      SizedBox(
                                        height: 10,
                                      ),
                                   
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void checkDatabaseConnection() {
    FirebaseDatabase.instance
        .ref()
        .child("LEDControl")
        .once()
        .then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            print(
                "Connexion à la base de données en temps réel Firebase réussie !");
            print("Valeur actuelle de LEDControl : ${snapshot.value}");
          } else {
            print(
                "Échec de la connexion à la base de données en temps réel Firebase !");
          }
        } as FutureOr Function(DatabaseEvent value))
        .catchError((error) {
      print(
          "Erreur lors de la connexion à la base de données en temps réel Firebase: $error");
    });
  }

  void _updateLEDStatus(int index, bool isOn) {
    String status = isOn ? "LED ON" : "LED OFF";
    print("Nouvel état de la LED $index: $status");
    _databaseReference.child("LEDControl$index").set(status).then((_) {
      print("Données mises à jour avec succès !");
    }).catchError((error) {
      print("Erreur lors de la mise à jour des données: $error");
    });
  }
}
