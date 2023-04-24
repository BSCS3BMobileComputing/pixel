import 'dart:async' as async;

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/game.dart';
import 'package:darkness_dungeon/menu.dart';
import 'package:darkness_dungeon/util/custom_sprite_animation_widget.dart';
import 'package:darkness_dungeon/util/enemy_sprite_sheet.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/player_sprite_sheet.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:darkness_dungeon/widgets/custom_radio.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Leaderboard extends StatefulWidget {
  @override
  _Leaderboard createState() => _Leaderboard();
}

class _Leaderboard extends State<Leaderboard> {
  bool showSplash = true;
  int currentPosition = 0;
  late async.Timer _timer;
   
  List<Future<SpriteAnimation>> sprites = [
    PlayerSpriteSheet.idleRight(),
    EnemySpriteSheet.goblinIdleRight(),
    EnemySpriteSheet.impIdleRight(),
    EnemySpriteSheet.miniBossIdleRight(),
    EnemySpriteSheet.bossIdleRight(),
  ];

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    _timer.cancel();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
          showSplash = false;
        });
       startTimer();
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: buildMenu(),
      
    );
  }



  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 136, 176),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "LEADERBOARD",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Normal', fontSize: 30.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              if (sprites.isNotEmpty)
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CustomSpriteAnimationWidget(
                    animation: sprites[currentPosition],
                  ),
                ),
              
              SizedBox(
                height: 50.0,
              ),

              Text(
                "COMING SOON!",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Normal', fontSize: 20.0),
              ),
               
              
                SizedBox(
                height: 100.0,
              ),
              
              
              

              
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minimumSize: Size(100, 40), //////// HERE
                  ),
                  child: Text(
                    "BACK",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),

            ],
          ),
        ),
      ),
      
    );
  }

 

  void startTimer() {
    _timer = async.Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        currentPosition++;
        if (currentPosition > sprites.length - 1) {
          currentPosition = 0;
        }
      });
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
