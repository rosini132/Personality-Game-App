import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'node.dart';

//List<Node> decisionMap = [];
late Box<Node> box;

//void main() async {
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //HIVE SETUP
  Hive.registerAdapter(NodeAdapter());
  box = await Hive.openBox<Node>('decisionMap');

  String csv = "decision_map.csv";
  String fileData = await rootBundle.loadString(csv);
  print(fileData); //test data is loaded

  List<String> rows = fileData.split("\n");
  for (int i = 0; i < rows.length; i++) {
    String row = rows[i];
    List<String> itemInRow = row.split(",");
    String aud = itemInRow[8].trim();
    Node node = Node(
      int.parse(itemInRow[0]),
      int.parse(itemInRow[1]),
      int.parse(itemInRow[2]),
      int.parse(itemInRow[3]),
      itemInRow[4],
      itemInRow[5],
      itemInRow[6],
      itemInRow[7],
      aud,
      int.parse(itemInRow[9]),
    );

    //decisionMap.add(node);
    int key = int.parse(itemInRow[0]);
    box.put(key, node);
  }

  runApp(
    const MaterialApp(
      home: MyGameApp(),
    ),
  );
}

class MyGameApp extends StatelessWidget {
  const MyGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personality Quiz',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //Widgets go in here
      //Stack widget
      backgroundColor: const Color.fromARGB(245, 97, 184, 189),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, 0.8),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const GamePage();
                    }));
                  },
                  color: const Color.fromARGB(245, 189, 102, 97),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  textColor: const Color.fromARGB(255, 0, 0, 0),
                  height: screenHeight * 0.1,
                  minWidth: screenWidth * 0.14,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    'START',
                    style: TextStyle(
                      fontFamily: 'Play',
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment(0.0, -0.9),
                child: Text(
                  'Personality Quiz - Character Selection',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'CaveatBrush',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 50,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment(0.0, -0.1),
                child: Image(
                  image: NetworkImage(
                    'https://media.giphy.com/media/Wj7lNjMNDxSmc/giphy.gif',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<GamePage> {
  final audioPlayer = AudioPlayer(); //audio player instance
  final musicPlayer = AudioPlayer();
  String audioUrl = "";

  void playAudio() {
    String localFilePath = 'assets//music/Overland.mp3';
    musicPlayer.play(localFilePath, isLocal: true);
  }

  void stopAudio() {
    musicPlayer.stop();
    musicPlayer.dispose();
  }

  late int iD;
  late int option1;
  late int option2;
  late int option3;
  late int colour;
  String description = "";
  String button1 = "";
  String button2 = "";
  String button3 = "";

  bool isButton1Visible = true;
  bool isButton2Visible = false;
  bool isButton3Visible = true;
  bool playmusic = true;

  void toggleButtonsVisibility() {
    setState(() {
      isButton1Visible = !isButton1Visible;
      isButton3Visible = !isButton3Visible;
    });
  }

  void toggleButton2Visibility() {
    setState(() {
      isButton2Visible = !isButton2Visible;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        Node? current = box.get(1);
        //Node current = decisionMap.first;
        if (current != null) {
          iD = current.iD;
          option1 = current.option1;
          option2 = current.option2;
          option3 = current.option3;
          description = current.description;
          button1 = current.button1;
          button2 = current.button2;
          button3 = current.button3;
          colour = current.colour;
          audioUrl = current.audioUrl;
        }
      });
    });
  }

  void option1Handler() {
    setState(() {
      Node? nextNode = box.get(option1);
      //for (Node nextNode in decisionMap) {
      if (nextNode != null) {
        iD = nextNode.iD;
        option1 = nextNode.option1;
        option2 = nextNode.option2;
        option3 = nextNode.option3;
        description = nextNode.description;
        button1 = nextNode.button1;
        button2 = nextNode.button2;
        button3 = nextNode.button3;
        audioUrl = nextNode.audioUrl;
        colour = nextNode.colour;
      }
    });
  }

  void option2Handler() {
    setState(() {
      Node? nextNode = box.get(option2);
      //for (Node nextNode in decisionMap) {
      if (nextNode != null) {
        iD = nextNode.iD;
        option1 = nextNode.option1;
        option2 = nextNode.option2;
        option3 = nextNode.option3;
        description = nextNode.description;
        button1 = nextNode.button1;
        button2 = nextNode.button2;
        button3 = nextNode.button3;
        audioUrl = nextNode.audioUrl;
        colour = nextNode.colour;
      }
    });
  }

  void option3Handler() {
    setState(() {
      Node? nextNode = box.get(option3);
      // for (Node nextNode in decisionMap) {
      if (nextNode != null) {
        iD = nextNode.iD;
        option1 = nextNode.option1;
        option2 = nextNode.option2;
        option3 = nextNode.option3;
        description = nextNode.description;
        button1 = nextNode.button1;
        button2 = nextNode.button2;
        button3 = nextNode.button3;
        audioUrl = nextNode.audioUrl;
        colour = nextNode.colour;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    playAudio();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //Widgets go in here
      //Stack widget
      backgroundColor: Color(colour),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(-0.5, 0.8),
                child: isButton1Visible
                    ? MaterialButton(
                        onPressed: () {
                          option1Handler();
                          if (iD == 10 ||
                              iD == 12 ||
                              iD == 13 ||
                              iD == 14 ||
                              iD == 16 ||
                              iD == 17 ||
                              iD == 20 ||
                              iD == 21 ||
                              iD == 22 ||
                              iD == 23 ||
                              iD == 24 ||
                              iD == 26 ||
                              iD == 27 ||
                              iD == 28 ||
                              iD == 30 ||
                              iD == 31 ||
                              iD == 34 ||
                              iD == 35 ||
                              iD == 36 ||
                              iD == 37) {
                            toggleButtonsVisibility();
                          } else if (iD == 3 || iD == 2) {
                            toggleButton2Visibility();
                          } else if (isButton2Visible) {
                            toggleButton2Visibility();
                          }
                          stopAudio();
                          String localFilePath = 'assets/music/$audioUrl';
                          audioPlayer.play(localFilePath, isLocal: true);
                        },
                        color: const Color.fromARGB(245, 189, 102, 97),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        textColor: const Color.fromARGB(255, 0, 0, 0),
                        height: screenHeight * 0.1,
                        minWidth: screenWidth * 0.14,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          button1,
                          style: const TextStyle(
                            fontFamily: 'Play',
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: const Alignment(0.0, 0.8),
                child: isButton2Visible
                    ? MaterialButton(
                        onPressed: () {
                          option2Handler();
                          if (isButton2Visible) {
                            toggleButton2Visibility();
                          }
                          stopAudio();
                          String localFilePath = 'assets/music/$audioUrl';
                          audioPlayer.play(localFilePath, isLocal: true);
                        },
                        color: const Color.fromARGB(245, 189, 102, 97),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        textColor: const Color.fromARGB(255, 0, 0, 0),
                        height: screenHeight * 0.1,
                        minWidth: screenWidth * 0.14,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          button2,
                          style: const TextStyle(
                            fontFamily: 'Play',
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: const Alignment(0.5, 0.8),
                child: isButton3Visible
                    ? MaterialButton(
                        onPressed: () {
                          option3Handler();
                          if (iD == 10 ||
                              iD == 12 ||
                              iD == 13 ||
                              iD == 14 ||
                              iD == 16 ||
                              iD == 17 ||
                              iD == 20 ||
                              iD == 21 ||
                              iD == 22 ||
                              iD == 23 ||
                              iD == 24 ||
                              iD == 26 ||
                              iD == 27 ||
                              iD == 28 ||
                              iD == 30 ||
                              iD == 31 ||
                              iD == 34 ||
                              iD == 35 ||
                              iD == 36 ||
                              iD == 37) {
                            toggleButtonsVisibility();
                          } else if (iD == 3 || iD == 2) {
                            toggleButton2Visibility();
                          } else if (isButton2Visible) {
                            toggleButton2Visibility();
                          }
                          stopAudio();
                          String localFilePath = 'assets/music/$audioUrl';
                          audioPlayer.play(localFilePath, isLocal: true);
                        },
                        color: const Color.fromARGB(245, 189, 102, 97),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        textColor: const Color.fromARGB(255, 0, 0, 0),
                        height: screenHeight * 0.1,
                        minWidth: screenWidth * 0.14,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          button3,
                          style: const TextStyle(
                            fontFamily: 'Play',
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: const Alignment(0.0, -0.9),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontFamily: 'CaveatBrush',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 50,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.1),
                child: Image.asset('assets/images/$iD.jpg',
                    width: 500, height: 350),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
