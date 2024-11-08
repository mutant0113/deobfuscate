import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  static const platform = MethodChannel('com.example.deobfuscate/channel');

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final result = await platform.invokeMethod('getNativeMessage');
                    print('Native message: $result');
                  } catch (exception, stacktrace) {
                    print('Failed to get native message: $exception');
                    FirebaseCrashlytics.instance.recordError(exception, stacktrace);
                  }
                },
                child: const Text('Get Native Message'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  try {
                    throw Exception('This is a flutter exception');
                  } catch (exception, stackTrace) {
                    print('Failed to get flutter exception: $exception, $stackTrace');
                    FirebaseCrashlytics.instance.recordError(exception, stackTrace);
                  }
                },
                child: const Text('Get flutter exception'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => FirebaseCrashlytics.instance.crash(),
                child: const Text('Force a crash'),
              ),
            ),
          ],
        ),
      );
}
