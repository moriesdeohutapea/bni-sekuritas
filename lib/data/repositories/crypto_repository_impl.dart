import '../../domain/entities/crypto_price.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_websocket_data_source.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoWebSocketDataSource dataSource;

  CryptoRepositoryImpl(this.dataSource);

  @override
  Stream<List<CryptoPrice>> getCryptoPrices(List<String> symbols) {
    dataSource.subscribeToCryptoPrices(symbols);
    return dataSource.cryptoPricesStream.map((event) {
      try {
        if (event['s'] != null && event['p'] != null && event['t'] != null) {
          final symbol = event['s'];
          return symbols
              .where((s) => s == symbol)
              .map((s) => CryptoPrice(
                    symbol: s,
                    lastPrice: _convertToDouble(event['p']) ?? 0.0,
                    quantity: _convertToDouble(event['q']),
                    dailyChangePercentage: _convertToDouble(event['dc']),
                    dailyDifferencePrice: _convertToDouble(event['dd']),
                    timestamp: DateTime.fromMillisecondsSinceEpoch(event['t']),
                  ))
              .toList();
        }
      } catch (e) {
        print('Error processing data in repository: $e');
      }
      return [];
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
