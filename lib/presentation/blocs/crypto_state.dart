import '../../domain/entities/crypto_price.dart';

abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<CryptoPrice> cryptoPrices;

  CryptoLoaded(this.cryptoPrices);
}

class CryptoError extends CryptoState {
  final String message;

  CryptoError(this.message);
}
