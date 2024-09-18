import '../entities/crypto_price.dart';

abstract class CryptoRepository {
  Stream<List<CryptoPrice>> getCryptoPrices(List<String> symbols);

  void dispose();
}
