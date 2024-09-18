import '../entities/crypto_price.dart';
import '../repositories/crypto_repository.dart';

class GetCryptoPrices {
  final CryptoRepository repository;

  GetCryptoPrices(this.repository);

  Stream<List<CryptoPrice>> call(List<String> symbols) {
    return repository.getCryptoPrices(symbols);
  }

  void dispose() {
    repository.dispose();
  }
}
