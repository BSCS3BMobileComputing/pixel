import 'dart:async' as async;

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/game.dart';
import 'package:darkness_dungeon/menu.dart';
import 'package:darkness_dungeon/util/custom_sprite_animation_widget.dart';
import 'package:darkness_dungeon/util/enemy_sprite_sheet.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/npc_sprite_sheet.dart';
import 'package:darkness_dungeon/util/player_sprite_sheet.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:darkness_dungeon/widgets/custom_radio.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  bool showSplash = true;
  int currentPosition = 0;
  late async.Timer _timer;
   
  List<Future<SpriteAnimation>> sprites = [
    NpcSpriteSheet.dance(),
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
                "SETTINGS",
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
                    animation:  NpcSpriteSheet.dance(),
                  ),
                ),
              
               
              SizedBox(
                height: 20,
              ),
              Text(
                
                 'CONTROLLER',
                 style: TextStyle(
                    color: Colors.white, fontFamily: 'Normal', fontSize: 20.0),
                
                
              ),

              SizedBox(
                height: 20,
              ),
              DefectorRadio<bool>(
                value: false,
                label: 'Keyboard',
                group: Game.useJoystick,
                onChange: (value) {
                  setState(() {
                    Game.useJoystick = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              DefectorRadio<bool>(
                value: true,
                group: Game.useJoystick,
                label: 'Joystick',
                onChange: (value) {
                  setState(() {
                    Game.useJoystick = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (!Game.useJoystick)
                SizedBox(
                  height: 80,
                  width: 200,
                  child: Sprite.load('keyboard_tip.png').asWidget(),
                ),

                SizedBox(
                height: 10.0,
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
