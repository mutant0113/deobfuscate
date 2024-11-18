import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.deobfuscate/channel');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue, // foreground
              ),
              onPressed: () async {
                try {
                  final result = await platform.invokeMethod('getNativeMessage');
                  print('Native message: $result');
                } catch (exception, stacktrace) {
                  print('Failed to get native message: $exception');
                  FirebaseCrashlytics.instance.recordError(exception, stacktrace);
                }
              },
              child: const Text('Native crash 4'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue, // foreground
              ),
              onPressed: () {
                try {
                  throw Exception('Fatal Crash 7');
                } catch (exception, stacktrace) {
                  FirebaseCrashlytics.instance.recordError(exception, stacktrace);
                }
              },
              child: const Text('Fatal crash 7'),
            ),
          ],
        ),
      ),
    );
  }
}
