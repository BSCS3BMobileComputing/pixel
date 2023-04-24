import 'dart:async' as async;
import 'dart:io';

import 'package:bonfire/bonfire.dart';
import 'package:darkness_dungeon/credits.dart';
import 'package:darkness_dungeon/game.dart';
import 'package:darkness_dungeon/leaderboard.dart';
import 'package:darkness_dungeon/settings.dart';
import 'package:darkness_dungeon/util/custom_sprite_animation_widget.dart';
import 'package:darkness_dungeon/util/enemy_sprite_sheet.dart';
import 'package:darkness_dungeon/util/localization/strings_location.dart';
import 'package:darkness_dungeon/util/player_sprite_sheet.dart';
import 'package:darkness_dungeon/util/sounds.dart';
import 'package:darkness_dungeon/widgets/custom_radio.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';



class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
  
}

class _MenuState extends State<Menu> {
  bool showSplash = true;
  int currentPosition = 0;
  late async.Timer _timer;
double sideLength = 50;

  //var assetsImage = new AssetImage('assets/images/bg.png'); //<- Creates an object that fetches an image.
   // var image = new Image(image: assetsImage, fit: BoxFit.cover); //<- Creates a widget that displays an image.

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
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(), 
      
   );
 
  }




  Widget buildMenu() {
    return 
    Stack(
children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
     Scaffold( 
//      backgroundColor: Color.fromARGB(255, 255, 136, 176),
     // decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/bg.png"),fit: BoxFit.cover)),
   backgroundColor: Colors.transparent,
    
      body: Center(
        
      
        child: SingleChildScrollView(
          child: 
          
          Column(
            mainAxisSize: MainAxisSize.min,
            
            children: <Widget>[
              Image(image: AssetImage('assets/images/title.png'),width: 500,height: 100,),
             
              if (sprites.isNotEmpty)
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CustomSpriteAnimationWidget(
                    animation: sprites[currentPosition],
                  ),
                ),

                //play button
             
              SizedBox(
                
              width: 200,
                height: 60,
                child: AnimatedContainer(
                duration: Duration(seconds: 2),
                
                curve: Curves.easeIn,
      
                child: Material(
                 
                  color:Colors.transparent,
                child: InkWell(
                      borderRadius: BorderRadius.circular(5),                     
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Game()),
                    );
                  },
                 onHover: (value) {
                 setState(() {
                  sideLength = value?200 :100;
                  });
                 },
                  child: Ink.image(
                    image: const AssetImage("assets/images/play.png"),),
                    
                ),
                
                ),
                
              ),
              ),


              //settings button
              
              SizedBox(
                
               width: 200,
                height: 60,
                child: AnimatedContainer(
                duration: Duration(seconds: 2),
                
                curve: Curves.easeIn,
      
                child: Material(
                 
                  color:Colors.transparent,
                child: InkWell(
                      borderRadius: BorderRadius.circular(5),                     
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    );
                  },
                 onHover: (value) {
                 setState(() {
                  sideLength = value?200 :100;
                  });
                 },
                  child: Ink.image(
                    image: const AssetImage("assets/images/settings.png"),),
                    
                ),
                
                ),
                
              ),
              ),

              //leaderboardbutton
              
              SizedBox(
                
               width: 200,
                height: 60,
                child: AnimatedContainer(
                duration: Duration(seconds: 2),
               
                curve: Curves.easeIn,
      
                child: Material(
                 
                  color:Colors.transparent,
                child: InkWell(
                      borderRadius: BorderRadius.circular(5),                     
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Leaderboard()),
                    );
                  },
                 onHover: (value) {
                 setState(() {
                  sideLength = value?200 :100;
                  });
                 },
                  child: Ink.image(
                    image: const AssetImage("assets/images/leaderboard.png"),),
                    
                ),
                
                ),
                
              ),
              ),


              //credits button
               
              SizedBox(
                
              width: 200,
                height: 60,
                child: AnimatedContainer(
                duration: Duration(seconds: 2),
               
                curve: Curves.easeIn,
      
                child: Material(
                 
                  color:Colors.transparent,
                child: InkWell(
                      borderRadius: BorderRadius.circular(5),                     
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Credits()),
                    );
                  },
                 onHover: (value) {
                 setState(() {
                  sideLength = value?200 :100;
                  });
                 },
                  child: Ink.image(
                    image: const AssetImage("assets/images/credits.png"),),
                    
                ),
                
                ),
                
              ),
              ),


              //exit button
              
              SizedBox(
                
              width: 200,
                height: 60,
                child: AnimatedContainer(
                duration: Duration(seconds: 2),
                
                curve: Curves.easeIn,
      
                child: Material(
                 
                  color:Colors.transparent,
                child: InkWell(
                      borderRadius: BorderRadius.circular(5),                     
                  onTap: ()=> exit(0),
                 onHover: (value) {
                 setState(() {
                  sideLength = value?200 :100;
                  });
                 },
                  child: Ink.image(
                    image: const AssetImage("assets/images/exit.png"),),
                    
                ),
                
                ),
                
              ),
              ),

              //end button column
              
            ],
          ),
         
        ),
      ),
      
      
    ),
   ],
    );
    
  }

  Widget buildSplash() {
    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      onFinish: (BuildContext context) {
        setState(() {
          showSplash = false;
        });
        startTimer();
      },
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

