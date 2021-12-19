// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const CustomSlider(imageUrl: 'assets/slider_thumb.png'),
//     );
//   }
// }

// class CustomSlider extends StatefulWidget {
//   const CustomSlider({Key? key, required this.imageUrl}) : super(key: key);

//   final String imageUrl;

//   @override
//   _CustomSliderState createState() => _CustomSliderState();
// }

// class _CustomSliderState extends State<CustomSlider> {
//   ui.Image? customImage;

//   RangeValues _currentRangeValues = RangeValues(21, 34);

//   Future<ui.Image> loadImage(String assetPath) async {
//     ByteData data = await rootBundle.load(assetPath);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
//     ui.FrameInfo fi = await codec.getNextFrame();

//     return fi.image;
//   }

//   @override
//   void initState() {
//     loadImage(widget.imageUrl).then((image) {
//       setState(() {
//         customImage = image;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SliderTheme(
//           data: SliderThemeData(
//             trackHeight: 10,
//             trackShape: SliderTrackImage(customImage),
//           ),
//           child: RangeSlider(
//             max: 100.0,
//             min: 0.0,
//             onChanged: (values) {
//               setState(() {
//                 _currentRangeValues = values;
//               });
//             },
//             values: _currentRangeValues,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SliderTrackImage extends SliderTrackShape {
//   final ui.Image? image;

//   SliderTrackImage(this.image);

//   // @override
//   // Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//   //   return Size(0, 0);
//   // }

//   @override
//   void paint(PaintingContext context, Offset center,
//       {required Animation<double> activationAnimation,
//       required Animation<double> enableAnimation,
//       required bool isDiscrete,
//       required TextPainter labelPainter,
//       required RenderBox parentBox,
//       required Size sizeWithOverflow,
//       /*The missing link*/
//       // required double textScaleFactor,
//       required SliderThemeData sliderTheme,
//       required double textScaleFactor,
//       required TextDirection textDirection,
//       required double value}) {
//     final canvas = context.canvas;
//     final imageWidth = image!.width;
//     final imageHeight = image!.height;

//     Offset imageOffset = Offset(
//       center.dx - (imageWidth / 2),
//       center.dy - (imageHeight / 2),
//     );

//     Paint paint = Paint()..filterQuality = FilterQuality.high;

//     canvas.drawImage(image!, imageOffset, paint);
//   }
// }

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomSlider(imageUrl: 'assets/slider_thumb.png'),
    );
  }
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  ui.Image? customImage;
  double sliderValue = 0.0;
  RangeValues _currentRangeValues = RangeValues(21, 34);

  Future<ui.Image> loadImage(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();

    return fi.image;
  }

  @override
  void initState() {
    loadImage(widget.imageUrl).then((image) {
      setState(() {
        customImage = image;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SliderTheme(
          data: SliderThemeData(
            trackHeight: 10,
            thumbShape: SliderThumbImage(customImage),
            thumbColor: Colors.red,
          ),
          child: Slider(
            max: 1.0,
            min: 0.0,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            },
            value: sliderValue,
          ),
        ),
      ),
    );
  }
}

class SliderThumbImage extends SliderComponentShape {
  final ui.Image? image;

  SliderThumbImage(this.image);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(0, 0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required Size sizeWithOverflow,
      /*The missing link*/
      required double textScaleFactor,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value}) {
    final canvas = context.canvas;
    final imageWidth = image!.width;
    final imageHeight = image!.height;

    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2),
    );

    Paint paint = Paint()..filterQuality = FilterQuality.high;

    canvas.drawImage(image!, imageOffset, paint);
  }
}
