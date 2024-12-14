import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoiseCancellationExample(),
    );
  }
}

class NoiseCancellationExample extends StatefulWidget {
  @override
  _NoiseCancellationExampleState createState() => _NoiseCancellationExampleState();
}

class _NoiseCancellationExampleState extends State<NoiseCancellationExample> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  NoiseMeter _noiseMeter = NoiseMeter();
  bool _isRecording = false;
  double _noiseLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
    await Permission.microphone.request();
  }

  Future<void> _startRecording() async {
    await _recorder.startRecorder(
      toFile: 'audio.aac',
      codec: Codec.aacADTS,
    );
    _noiseMeter.noise.listen((NoiseReading noiseReading) {
      setState(() {
        _noiseLevel = noiseReading.meanDecibel;
      });
    });
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noise Cancellation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            Text('Noise Level: $_noiseLevel dB'),
          ],
        ),
      ),
    );
  }
}

