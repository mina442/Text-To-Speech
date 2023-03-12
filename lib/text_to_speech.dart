import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}
enum TtsState{playing , stopped} 
class _TextToSpeechState extends State<TextToSpeech> {
  String? tts;
  late FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;
  @override
  void initState() {
    super.initState();
    initTts();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterTts.stop();
  }
initTts()async{
    flutterTts = FlutterTts();
    flutterTts.awaitSpeakCompletion(true);
    flutterTts.setStartHandler(() {
      setState(() {
        
      print('start');

      ttsState = TtsState.playing;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        
      ttsState = TtsState.stopped;
      print('complite');
      });
    });
    flutterTts.setCancelHandler(() {
      setState(() {
      ttsState = TtsState.stopped;
        print('cancel'); 
      });
    });
    flutterTts.setErrorHandler((message) {
      setState(() {
        ttsState = TtsState.stopped;
        print('error: $message');
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    tts = value;
                  });
                },
              ),
            TextButton(onPressed:speak, child: Text('play')),
            TextButton(onPressed:stop, child: Text('stop')),
             
            
               
             
            ],
          ),
        )
      );
  }
   Future speak()async{
await flutterTts.setVolume(1);
await flutterTts.setSpeechRate(0.5);
await flutterTts.setPitch(1);
if(tts != null){
  if(tts!.isNotEmpty){
await flutterTts.speak(tts!);
  }
}
  }
    Future stop()async{
var resulte = await flutterTts.stop();
if(resulte == 1){
  setState(() {
    ttsState = TtsState.stopped;
  });
}
  }
}