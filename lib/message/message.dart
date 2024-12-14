import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/flutter_sound.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  String _text = "Nyomd meg a gombot és beszélj";
  late stt.SpeechToText _speech;
  late FlutterSoundRecorder _recorder;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _recorder = FlutterSoundRecorder();
    _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  void _startRecording() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _text = "Felvétel folyamatban...";
        _isRecording = true;
      });
      _speech.listen(onResult: (val) {
        setState(() {
          _text = val.recognizedWords;
        });
      });
      await _recorder.startRecorder(toFile: 'audio.aac');
    }
  }

  void _stopRecording() async {
    await _recorder.stopRecorder();
    _speech.stop();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level diktálása'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_text),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Állítsa le a felvételt' : 'Indítsa el a felvételt'),
            ),
          ],
        ),
      ),
    );
  }
}
