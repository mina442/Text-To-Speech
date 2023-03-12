import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:text_to_spech/text_to_speech.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
return runApp( MyApp());
   }

class MyApp extends StatelessWidget {
// FlutterTts flutterTts = FlutterTts();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: TextToSpeech(),
    );
  }
}