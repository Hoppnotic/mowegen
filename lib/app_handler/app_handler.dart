import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Application> _apps = [];

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  Future<void> _loadApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true,
      includeAppIcons: true,
    );
    setState(() {
      _apps = apps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Installed Apps'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Apps'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Home Tab')),
            _buildAppsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppsTab() {
    return ListView.builder(
      itemCount: _apps.length,
      itemBuilder: (context, index) {
        Application app = _apps[index];
        return ListTile(
          leading: app is ApplicationWithIcon
              ? Image.memory(app.icon, width: 40, height: 40)
              : null,
          title: Text(app.appName),
          onTap: () {
            DeviceApps.openApp(app.packageName);
          },
        );
      },
    );
  }
}

