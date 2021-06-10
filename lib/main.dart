import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musique/model/musique.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration position = Duration(seconds: 0);
  bool isPLay = true;
  int index = 0;
  List <Musique> mesMusiques = [];
  Duration duree = Duration(seconds: 0);






  AudioPlayer audioPlayer = AudioPlayer();

  @override void initState() {
    super.initState();
    AudioPlayer audioPlayer = AudioPlayer();

    mesMusiques= [
      Musique('artiste 1', 'titre 1', 'lib/assets/musique.jpg', 'https://noisyliens.fr/wp-content/uploads/2021/06/audiohub__4066141002255_zombie-invasion-2015__testversion.mp3'),
      Musique('artiste 2', 'titre 2', 'lib/assets/musique-1.jpg', 'https://noisyliens.fr/wp-content/uploads/2021/06/audiohub__4066141002828_all-the-summer-girls_276__testversion.mp3')

    ];
  }
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Spotify'),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        Center(
            child: Image.asset(
                mesMusiques[index].image)
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mesMusiques[index].artiste),
              Text(mesMusiques[index].titre)
            ],
          ),
        ),
        Container(
          color: Colors.red,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              IconButton(
                onPressed: () {},
                icon: Icon(Icons.fast_rewind),
              ),
              (!this.isPLay)
                  ? IconButton(
                      onPressed: () {
                        playerStatut(statutPlayer.lecture);
                        setState(() {
                          isPLay = !isPLay;
                        });
                      },
                      icon: Icon(Icons.pause_circle),
                    )
                  : IconButton(
                      onPressed: () {
                        playerStatut(statutPlayer.pause);
                        setState(() {
                          isPLay = !isPLay;
                        });
                      },
                      icon: Icon(Icons.play_arrow),
                    ),
              IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.fast_forward),
              ),
            ],
          ),
        ),
        Slider(
          value: position.inSeconds.toDouble(),
          min: 0,
          max: 100,
          onChanged: (double value) {
            setState(() {
              Duration time = Duration(seconds: value.toInt());
              position = time;
            });
          },
        )
      ],
    );
  }


  //fonctions

  void configMyPlayer (){
    StreamSubscription positionSubPlay;
    StreamSubscription positionSubStop;

    positionSubPlay = audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });

    positionSubPlay = audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });


    // positionSubStop = audioPlayer.onAudioPositionChanged.listen((state) {
     //if(state == statutPlayer.lecture){
       // duree = await audioPlayer.();
     //}
    //});



  }

  Future play () async {
    await audioPlayer.play(mesMusiques[index].urlSon);
  }

  void pause (){

  }

  void stop (){

  }

  void playerStatut (statutPlayer statut) {
    switch (statut) {
      case statutPlayer.lecture:
        print("lecture");
        break;
      case statutPlayer.pause:
        print("pause");
        break;
      case statutPlayer.stop:
        print("stop");
        break;


      default:
        print('case inconnu');
        break;

    }
  }
}
 enum statutPlayer {
    lecture,
    pause,
    stop
 }