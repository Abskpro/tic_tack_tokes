import 'package:flutter/material.dart';


class TicTacToePainter extends CustomPainter {
  static const double LINE_WIDTH = 5.0;
  static const Color LINE_COLOR = Colors.black;
  static const double CIRCLE_RADIUS = 40.0;
  static const Color PLAYER_1_COLOR = Colors.red;
  static const Color PLAYER_2_COLOR = Colors.blue;

  final List<List<dynamic>> boardState;
  final List<List<Offset>> boxCenters;
  final Map<String, dynamic> winnerLine;

  TicTacToePainter(
      {required this.boxCenters, required this.boardState, required this.winnerLine});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = LINE_COLOR
      ..strokeWidth = LINE_WIDTH
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final boxSize = size.width / 3;

    for (int i = 1; i <= 2; i++) {
      canvas.drawLine(
          Offset(0, boxSize * i),
          Offset(size.width, boxSize * i),
          linePaint);
    }

    for (int i = 1; i <= 2; i++) {
      canvas.drawLine(
          Offset(boxSize * i, 0),
          Offset(boxSize * i, size.height),
          linePaint);
    }

    // Draw circles for each player's moves
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        final dynamic player = boardState[i][j];
        Offset center = boxCenters[i][j];
        center = Offset(center.dx, center.dy);

        if (player == "O") {
          final Paint circlePaint = Paint()
            ..color = PLAYER_1_COLOR;
          canvas.drawCircle(center, CIRCLE_RADIUS, circlePaint);
        } else if (player == "X") {
          canvas.drawLine(
              Offset(center.dx - 30, center.dy - 30),
              Offset(center.dx + 30, center.dy + 30),
              linePaint);
          canvas.drawLine(
              Offset(center.dx - 30, center.dy + 30),
              Offset(center.dx + 30, center.dy - 30),
              linePaint);
        }
      }
    }

    if (winnerLine["x1"] != null && winnerLine["y1"] != null && winnerLine["x2"] != null && winnerLine["y2"] != null) {
      final Offset coord1 = boxCenters[winnerLine["x1"]][winnerLine['y1']];
      final Offset coord2 = boxCenters[winnerLine["x2"]][winnerLine['y2']];

      canvas.drawLine(
          coord1,
          coord2,
          linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

// class TicTacToePainter extends CustomPainter {
//   static const double LINE_WIDTH = 5.0;
//   static const double CELL_HEIGHT = 200;
//   static const double CELL_WIDTH = 125;
//   static const Color LINE_COLOR = Colors.black;
//   static const double verticalOffset = 120;
//   static const double CIRCLE_RADIUS = 40.0;
//   static const Color PLAYER_1_COLOR = Colors.red;
//   static const Color PLAYER_2_COLOR = Colors.blue;
//
//   final List<List<int>> boardState;
//   final List<List<Offset>> boxCenters;
//
//   TicTacToePainter({required this.boxCenters,required this.boardState});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double width = size.width;
//     final Paint linePaint = Paint()
//       ..color = LINE_COLOR
//       ..strokeWidth = LINE_WIDTH
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.butt;
//
//
//       for(int i = 1; i <= 2; i ++){
//         canvas.drawLine(
//             Offset(0, CELL_HEIGHT * i),
//             Offset(width, CELL_HEIGHT * i),
//             linePaint);
//       }
//       for(int i = 1; i <= 2; i ++){
//         canvas.drawLine(
//             Offset(verticalOffset * i, 0),
//             Offset(verticalOffset * i, size.height),
//             linePaint);
//       }
//     // Draw circles for each player's moves
//     for (int i = 0; i < 3; i++) {
//       for (int j = 0; j < 3; j++) {
//         final int player = boardState[i][j];
//         Offset center = boxCenters[i][j];
//         center = Offset(center.dx, center.dy - 50);
//
//         if (player == 1) {
//           final Paint circlePaint = Paint()..color = PLAYER_1_COLOR;
//           canvas.drawCircle(center, CIRCLE_RADIUS, circlePaint);
//         } else if (player == 2) {
//           final Paint circlePaint = Paint()..color = PLAYER_2_COLOR;
//           canvas.drawCircle(center, CIRCLE_RADIUS, circlePaint);
//         }
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(TicTacToePainter oldDelegate) => true;
// }
//

