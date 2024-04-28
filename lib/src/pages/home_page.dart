import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:smart_home_app/src/consts/app_colors.dart';
import 'package:smart_home_app/src/pages/details_page.dart';
import 'package:smart_home_app/src/widgets/render_img.dart';
import '../config/app_utils.dart';
import '../widgets/Ktext.dart';
import '../widgets/hex_color.dart';
import '../widgets/render_svg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched2 = true;
  int value = 0;
  bool positive = false;
  bool loading = false;
  bool positive2 = false;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 5,
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
                          color: Colors.white,
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
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: HexColor('#4C7380'),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(40))),
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(40)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Get.to(DetailsPage());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 15,
                                ),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: HexColor('#9A7265'),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: RenderImg(
                                              path: 'light-bulbs.png',
                                              height: 65,
                                              width: 65,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                  ),
                                                  child: KText(
                                                    text: 'Couleur',
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                KText(
                                                  text: 'Blanc',
                                                  fontSize: 18,
                                                  color: Colors.white70,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1, bottom: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Lampe',
                                                  color: Colors.white70,
                                                  fontSize: 16,
                                                ),
                                                KText(
                                                  text: 'Salle à manger',
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IgnorePointer(
                                                ignoring:
                                                    true, // Ajoutez cette ligne
                                                child: AnimatedToggleSwitch<
                                                    bool>.dual(
                                                  current: positive2,
                                                  first: false,
                                                  second: true,
                                                  dif: 10.0,
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderWidth: 3.0,
                                                  height: 22,
                                                  indicatorSize: Size(25, 16),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      offset: Offset(0, .5),
                                                    ),
                                                  ],
                                                  onChanged: (b) {
                                                    setState(
                                                        () => positive2 = b);
                                                    _updateLEDStatus(b);
                                                  },
                                                  colorBuilder: (b) => b
                                                      ? Colors.yellow[900]
                                                      : Colors.teal,
                                                  iconBuilder: (value) => value
                                                      ? Icon(
                                                          Icons
                                                              .coronavirus_rounded,
                                                          size: 15,
                                                          color: Colors.white,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .tag_faces_rounded,
                                                          size: 15,
                                                          color: HexColor(
                                                              '#ffffff'),
                                                        ),
                                                  textBuilder: (value) => value
                                                      ? Center(
                                                          child: KText(
                                                            text: 'ON',
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : Center(
                                                          child: KText(
                                                              text: 'OFF',
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
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

  void _updateLEDStatus(bool isOn) {
    String status = isOn ? "LED ON" : "LED OFF";
    print("Nouvel état de la LED : $status");
    _databaseReference.child("LEDControl").set(status).then((_) {
      print("Données mises à jour avec succès !");
    }).catchError((error) {
      print("Erreur lors de la mise à jour des données: $error");
    });
  }
}
