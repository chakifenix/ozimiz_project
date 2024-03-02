import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ozimiz_project/features/ar_page/view/animatedCharacterScreen.dart';

class ArListPages extends StatelessWidget {
  const ArListPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Wrap(
          spacing: 40,
          children: [
            GestureDetector(
              onTap: () {
                if (Platform.isIOS) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimatedCharacterScreen(
                                arModel: 'models.scnassets/horse.dae',
                                size: 0.02,
                              )));
                } else if (Platform.isAndroid) {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ARWidget()));
                }
              },
              child: Container(
                child: Column(
                  children: [
                    Image.asset('images/16.png'),
                    Text('Ar Concierge Show')
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Platform.isIOS) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimatedCharacterScreen(
                                arModel: 'models.scnassets/mercedes.dae',
                                size: 0.07,
                              )));
                } else if (Platform.isAndroid) {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ARWidget()));
                }
              },
              child: Container(
                child: Column(
                  children: [Image.asset('images/16.png'), Text('Ar Mercedes')],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
