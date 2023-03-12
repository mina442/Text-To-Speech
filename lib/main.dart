import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
return runApp( MyApp());
   }

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
enum TtsState{playing , stopped} 
class _MyAppState extends State<MyApp> {
  late FlutterTts flutterTts;
  String? tts;
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
// FlutterTts flutterTts = FlutterTts();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
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
      ),
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