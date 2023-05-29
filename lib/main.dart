import 'package:flutter/material.dart';
import 'package:tictactoe/tic_tac_toe_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application. @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> boardState = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];

  bool isCross = false;
  Map<String, dynamic> winnerLine = {
    "x1": null,
    "y1": null,
    "x2": null,
    "y2": null
  };

  List<List<Offset>> boxCenters = List.generate(3, (i) {
    return List.generate(3, (j) => Offset.zero);
  });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      calculateBoxCenters();
    });
  }

  void calculateBoxCenters() {
    final double width = 400 / 3;
    final double height = 400 / 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        final double x = width * j + width / 2;
        final double y = height * i + height / 2;
        boxCenters[i][j] = Offset(x, y);
      }
    }
  }

  void checkWinner() {
    //check for rows
    for (int i = 0; i < 2; i++) {
      if (boardState[i][0] != 0 &&
          boardState[i][0] == boardState[i][1] &&
          boardState[i][0] == boardState[i][2]) {
        setState(() {
          winnerLine = {"x1": i, "y1": 0, "x2": i, "y2": 2};
        });
      }
    }

    //check for cols
    for (int i = 0; i < 2; i++) {
      if (boardState[0][i] != 0 &&
          boardState[0][i] == boardState[1][i] &&
          boardState[0][i] == boardState[2][i]) {
        setState(() {
          winnerLine = {"x1": 0, "y1": i, "x2": 2, "y2": i};
        });
      }
    }

    // Check diagonals
    if (boardState[0][0] != 0 &&
        boardState[0][0] == boardState[1][1] &&
        boardState[0][0] == boardState[2][2]) {
      setState(() {
        winnerLine = {"x1": 0, "y1": 0, "x2": 2, "y2": 2};
      });
    }
    if (boardState[0][2] != 0 &&
        boardState[0][2] == boardState[1][1] &&
        boardState[0][2] == boardState[2][0]) {
      setState(() {
        winnerLine = {"x1": 0, "y1": 2, "x2": 2, "y2": 0};
      });
    }
  }

  void handleTap(int row, int col) {
    if (boardState[row][col] == 0) {
      setState(() {
        boardState[row][col] = isCross ? "X" : "O";
        isCross = !isCross;
      });
    }
    checkWinner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tic Tac Toe')),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Text("Turn : ${isCross ? "X" : "O"}",
                      style: const TextStyle(fontSize: 29))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) {
                      final localOffset = details.localPosition;
                      final double width = 400 / 3;
                      final double height = 400 / 3;

                      final int row = (localOffset.dy ~/ height).clamp(0, 2);
                      final int col = (localOffset.dx ~/ width).clamp(0, 2);

                      handleTap(row, col);
                    },
                    child: CustomPaint(
                      painter: TicTacToePainter(
                          boardState: boardState, boxCenters: boxCenters, winnerLine: winnerLine),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              if(winnerLine["x1"] != null)
                Text("Winner is ${isCross ? "0" : "X"}", style: TextStyle(fontSize: 25),)
            ],
          ),
        ));
  }
}


