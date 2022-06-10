import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'service.dart';
import 'queries.dart';

GetIt getIt = GetIt.instance;

const allowedSHAFingerprints =
    '07 2F 78 8D 06 6A F6 D4 45 B7 42 13 90 AE 41 8D ED 7E 54 AA 36 92 24 E8 9E E3 83 45 F7 C9 2E 20';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final certData = await rootBundle.load('assets/facebook.com.pem');
  getIt.registerSingleton<Service>(Service([allowedSHAFingerprints]));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GQL & API SSL Pinning Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _gqlCall() async {
    try {
      final secureClient = GetIt.I<Service>().gqlClient;
      final options = QueryOptions(
        document: gql(homePageQuery),
      );
      final result = await secureClient.query(options);
      if (!result.hasException) {
        _showSnackbar('GQL Success');
      } else {
        throw Exception();
      }
    } on Exception catch (_) {
      _showSnackbar('GQL Fail');
    }
  }

  Future<void> _apiCall() async {
    try {
      final url = Uri.parse('https://core.setoko-test.com/ping');

      final result = await GetIt.I<Service>().secureHttpClient.get(url);

      if (result.statusCode == 200) {
        _showSnackbar('API Success');
      } else {
        throw Exception();
      }
    } on Exception catch (_) {
      _showSnackbar('API Fail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _gqlCall,
              child: const Text('GQL Hit!'),
            ),
            ElevatedButton(
              onPressed: _apiCall,
              child: const Text('API Hit!'),
            ),
          ],
        ),
      ),
    );
  }
}
