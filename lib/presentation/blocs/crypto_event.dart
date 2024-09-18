abstract class CryptoEvent {}

class SubscribeToCryptoPrices extends CryptoEvent {
  final List<String> symbols;

  SubscribeToCryptoPrices(this.symbols);
}

class UnsubscribeFromCryptoPrices extends CryptoEvent {}
