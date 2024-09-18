import '../../domain/entities/crypto_price.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_websocket_data_source.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoWebSocketDataSource dataSource;
  final Map<String, CryptoPrice> _latestPrices = {};

  CryptoRepositoryImpl(this.dataSource);

  @override
  Stream<List<CryptoPrice>> getCryptoPrices(List<String> symbols) {
    dataSource.subscribeToCryptoPrices(symbols);
    return dataSource.cryptoPricesStream.map((event) {
      try {
        final symbol = event['s'];
        if (symbol != null && event['p'] != null && event['t'] != null) {
          _latestPrices[symbol] = CryptoPrice(
            symbol: symbol,
            lastPrice: _convertToDouble(event['p']) ?? 0.0,
            quantity: _convertToDouble(event['q']),
            dailyChangePercentage: _convertToDouble(event['dc']),
            dailyDifferencePrice: _convertToDouble(event['dd']),
            timestamp: DateTime.fromMillisecondsSinceEpoch(event['t']),
          );
        }
      } catch (e) {
        print('Error processing data in repository: $e');
      }
      return _latestPrices.values.toList();
    });
  }

  double? _convertToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsedValue = double.tryParse(value);
      if (parsedValue != null) {
        return parsedValue;
      } else {
        print('Failed to convert String to double: $value');
      }
    }
    print('Unhandled type for value conversion: $value (${value.runtimeType})');
    return null;
  }

  @override
  void dispose() {
    dataSource.dispose();
  }
}