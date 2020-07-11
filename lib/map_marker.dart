import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaskMapMarker {
  TaskMapMarker._();

  static Future<BitmapDescriptor> getMarkerIcon(
      {@required double size,
        Color color = Colors.red,
        String text = ""}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final canvasSize = Size(size * 2, size * 3.7);
    final canvas = Canvas(pictureRecorder);

    _paintMapMarker(
        canvas: canvas,
        canvasSize: canvasSize,
        size: size,
        color: color,
        text: text);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(canvasSize.width.toInt(), canvasSize.height.toInt());

    // Convert image to bytes
    final ByteData byteData =
    await markerAsImage.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List data = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(data);
  }

  static Canvas _paintMapMarker(
      {@required Canvas canvas,
        @required Size canvasSize,
        @required double size,
        Color color = Colors.red,
        String text = ""}) {
    final fontSize = size * 0.9;

    final markerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final innerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final center = Offset(canvasSize.width / 2, canvasSize.height / 2);

    final yOffset = size * 0.35;
    final xOffset = size * 0.055;

    final path = Path()
      ..moveTo(center.dx - size + xOffset, center.dy + yOffset)
      ..lineTo(center.dx, (center.dy + size * 1.5) + yOffset)
      ..lineTo(center.dx + size - xOffset, center.dy + yOffset)
      ..close();

    canvas.drawPath(path, markerPaint);
    canvas.drawCircle(center, size, markerPaint);
    canvas.drawCircle(center, size * 0.8, innerCirclePaint);

    final textStyle = ui.TextStyle(
      color: Colors.black87,
      fontSize: fontSize,
    );

    final paragraphStyle = ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
    );

    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(text);

    final constraints = ui.ParagraphConstraints(width: size * 3);
    final paragraph = paragraphBuilder.build();

    final textOffset = Offset(
      center.dx - (fontSize * (text.length * 0.28)),
      center.dy - (fontSize / 2 * 1.1),
    );

    paragraph.layout(constraints);
    canvas.drawParagraph(paragraph, textOffset);

    return canvas;
  }
}
