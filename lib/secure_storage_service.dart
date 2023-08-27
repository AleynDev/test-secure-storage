import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'card_dto.dart';

class SecureStorageServicve {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final _cardsKey = 'cards'; // Key for storing the list of cards

  bool matchingCardsIds(List<CardDto> newCards, List<CardDto> currentCards) {
    for (var newCard in newCards) {
      if (!currentCards.any((card) => card.id == newCard.id)) {
        return false;
      }
    }
    return true;
  }

  Future<void> saveCard(List<CardDto> newCards) async {
    List<CardDto> currentCards = await getAllCards();
    final matchingIds = matchingCardsIds(newCards, currentCards);
    if (matchingIds) {
      return;
    }

    await _secureStorage.delete(key: _cardsKey);
    String cardsJson =
        jsonEncode(newCards.map((card) => card.toJson()).toList());
        print('✅ $newCards');

    await _secureStorage.write(key: _cardsKey, value: cardsJson);
  }

  Future<List<CardDto>> getAllCards() async {
    String? cardsJson = await _secureStorage.read(key: _cardsKey);

    if (cardsJson != null) {
      List<dynamic> cardsData = jsonDecode(cardsJson);
      return cardsData.map((cardData) => CardDto.fromJson(cardData)).toList();
    }

    return [];
  }

  List<CardDto> getCards() {
    return [
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
  }
}
