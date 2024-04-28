import 'package:flutter/material.dart';
import 'dart:ui';

// ignore: must_be_immutable
class FrostedGlassBox extends StatelessWidget {
  final dotEnable;
  final theWidth;
  final theHeight;
  Widget theChild;
  FrostedGlassBox(
      {Key? key,
      required this.dotEnable,
      required this.theWidth,
      required this.theHeight,
      required this.theChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: theWidth,
                height: theHeight,
                color: Colors.transparent,
                //we use Stack(); because we want the effects be on top of each other,
                //  just like layer in photoshop.
                child: Stack(
                  children: [
                    //blur effect ==> the third layer of stack
                    _filterEffect(),
                    //gradient effect ==> the second layer of stack
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.13), width: 2.0),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              //begin color
                              Colors.white.withOpacity(0.5),
                              //end color
                              Colors.white.withOpacity(0.02),
                            ]),
                      ),
                    ),
                    //child ==> the first/top layer of stack
                    Center(child: theChild),
                  ],
                ),
              ),
            ),
            dotEnable ? dotWhite() : SizedBox.shrink()
          ],
        ),
      ],
    );
  }

  Widget dotWhite() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
          ),
        ),
      );

  BackdropFilter _filterEffect() => BackdropFilter(
        filter: ImageFilter.blur(
          //sigmaX is the Horizontal blur
          sigmaX: 4.0,
          //sigmaY is the Vertical blur
          sigmaY: 4.0,
        ),
        //we use this container to scale up the blur effect to fit its
        //  parent, without this container the blur effect doesn't appear.
        child: Container(),
      );
}
