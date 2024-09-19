abstract class CryptoEvent {}

class SubscribeToCryptoPrices extends CryptoEvent {
  final List<String> symbols;

  SubscribeToCryptoPrices(this.symbols);
}

class UnsubscribeFromCryptoPrices extends CryptoEvent {}

class WebSocketErrorOccurred extends CryptoEvent {
  final Object error;

  WebSocketErrorOccurred(this.error);
}

class WebSocketConnectionClosed extends CryptoEvent {}
