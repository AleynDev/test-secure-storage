import 'package:flutter/material.dart';
import 'package:test_secure_storage/secure_storage_service.dart';

import 'card_dto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Secure Storage Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SecureStorageServicve _secureStorageService = SecureStorageServicve();

  final List<CardDto> _cards = [
    CardDto(
      id: 1,
      pan: '**** **** **** 1234',
    ),
    CardDto(
      id: 2,
      pan: '**** **** **** 5678',
    ),
    CardDto(
      id: 3,
      pan: '**** **** **** 9012',
    ),
    
  ];

  void _saveCards() {
    _secureStorageService.saveCard(_cards);
  }

  void _readCards() async {
    final cardsFromSecureStorage = await _secureStorageService.getAllCards();
    cardsFromSecureStorage.forEach((element) {
      print('✅ card Id: ${element.id}');
      print('✅ card Pan: ${element.pan}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Test Secure Storage:'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCards,
              child: Text('Save Cards'),
            ),
            ElevatedButton(
              onPressed: _readCards,
              child: Text('Read Cards'),
            ),
          ],
        ),
      ),
    );
  }
}
