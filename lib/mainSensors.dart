import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'mainContact.dart';
import 'contact_list_screen.dart';
import 'package:mowegen/message/message.dart';

class MainSensors extends StatefulWidget {
  const MainSensors({super.key, required this.title});

  final String title;

  @override
  State<MainSensors> createState() => _MainSensorsState();
}

class _MainSensorsState extends State<MainSensors> {
  int _counter = 0;

  // szenzorok értékeit az alábbi listákban tároljuk
  List<double>? _gyroscopeValues;
  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {
    final accelerometer =
    _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
    _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();


    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ennyiszer nyomtad meg a gombot:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
            //megjelenitjük a szenzorok értékeit:
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('UserAccelerometer: $userAccelerometer'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Gyroscope: $gyroscope'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactListScreen()),
                );
              },
              child: Text('Open Contacts'),
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewScreen()),
                  );
                },
                child: Text('Level kuldese'),
              ),
            )//medve
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        onPressed: () {
          _incrementCounter;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainContact()),
          );
          tooltip: 'Increment';
          child: const Icon(Icons.add);
        }


      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

//eseményfigyelö
  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

//szenzorok adatainak felvétele
  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add( //giroszkóp
      gyroscopeEvents.listen(
            (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions
        .add( //gyorsulásmérö figyelmenkivül hagyva a gravitációt
      userAccelerometerEvents.listen(
            (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
            if (event.y > 2 ){
              _counter++;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactListScreen()),
              );
            }
            if (event.y < -2 ){
              _counter--;
            }
          });
        },
      ),
    );
  }
}

