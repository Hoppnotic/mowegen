import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Nyomd meg a gombot és beszélj";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (val) => setState(() {
        _text = val.recognizedWords;
      }));
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Új képernyő'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_text),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isListening ? _stopListening : _startListening,
              child: Text(_isListening ? 'Állj meg' : 'Indítsa el a felvételt'),
            ),
          ],
        ),
      ),
    );
  }
}
