import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

final server = InAppLocalhostServer(documentRoot: 'assets/www', port: 8080);

Future<void> startLocalServer() async {
  if (!server.isRunning()) {
    await server.start();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _openWebView() async {
    await startLocalServer();
    final targetUrl = 'https://www.google.com';
    final jumpUrl =
        'http://localhost:8080/jump.html?next=${Uri.encodeComponent(targetUrl)}';
    await launchUrl(
      Uri.parse(jumpUrl),
      mode: LaunchMode.externalApplication,
    ); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hoge', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openWebView,
        tooltip: 'Open web view',
        child: const Icon(Icons.add),
      ),
    );
  }
}
