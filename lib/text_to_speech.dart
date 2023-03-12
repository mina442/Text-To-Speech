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
   FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  double volume = 1.0;
double pitch = 1.0;
double speechRate = 0.5;
List<String>? Languages;
String LangCode = "en-US";
  @override
  void initState() {
    super.initState();
    initTts();
    init();
  }
  @override
  init()async{
    Languages = List<String>.from(await flutterTts.getLanguages);
    setState(() {
      
    });
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
             mainAxisAlignment:  MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    tts = value;
                  });
                },
              ),
            Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed:speak, child: Text('play')),
            TextButton(onPressed:stop, child: Text('stop')),
              ],
            ),
             Column(
               mainAxisAlignment:  MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
Slider(min: 0.0,max: 1.0, value: volume, onChanged: (value) {
  setState(() {
    volume =value;
  });
},),
Slider(min: 0.0,max: 0.5, value: speechRate, onChanged: (value) {
  setState(() {
    speechRate =value;
  });
},),
Slider(min: 0.0,max: 1.0, value: pitch, onChanged: (value) {
  setState(() {
    pitch =value;
  });
},),
if(Languages != null)
DropdownButton<String>(
  value: LangCode,
  focusColor: Colors.white,
  //  value: LangCode,
style: const TextStyle (color: Colors.white),
iconEnabledColor: Colors.black,
  items: Languages!
.map<DropdownMenuItem<String>>((String? value) {
return DropdownMenuItem<String>(
value: value!, 
child: Text(
value,
style: const TextStyle (color: Colors.black),
),
); }).toList(), onChanged:(String? value) {
  setState(() {
    LangCode =value!;
  });
},)
              ],
             )
            
               
             
            ],
          ),
        )
      );
  }
   Future speak()async{
await flutterTts.setVolume(volume);
await flutterTts.setSpeechRate(speechRate);
await flutterTts.setPitch(pitch);
await flutterTts.setLanguage(LangCode);

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