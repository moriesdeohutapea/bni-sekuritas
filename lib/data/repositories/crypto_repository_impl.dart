import '../../domain/entities/crypto_price.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/crypto_websocket_data_source.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoWebSocketDataSource _dataSource;
  final Map<String, CryptoPrice> _latestPrices = {};

  CryptoRepositoryImpl(this._dataSource);

  @override
  Stream<List<CryptoPrice>> getCryptoPrices(List<String> symbols) {
    _dataSource.subscribeToCryptoPrices(symbols);
    return _dataSource.cryptoPricesStream.map(_processPriceEvent);
  }

  List<CryptoPrice> _processPriceEvent(Map<String, dynamic> event) {
    try {
      final symbol = event['s'] as String?;
      if (symbol != null && event['p'] != null && event['t'] != null) {
        _latestPrices[symbol] = _createCryptoPriceFromEvent(symbol, event);
      }
    } catch (e) {
      throw Exception('Error processing data in repository: $e');
    }
    return _latestPrices.values.toList();
  }

  CryptoPrice _createCryptoPriceFromEvent(String symbol, Map<String, dynamic> event) {
    return CryptoPrice(
      symbol: symbol,
      lastPrice: _convertToDouble(event['p']) ?? 0.0,
      quantity: _convertToDouble(event['q']),
      dailyChangePercentage: _convertToDouble(event['dc']),
      dailyDifferencePrice: _convertToDouble(event['dd']),
      timestamp: DateTime.fromMillisecondsSinceEpoch(event['t'] as int),
    );
  }

  double? _convertToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsedValue = double.tryParse(value);
      if (parsedValue != null) return parsedValue;

      throw Exception('Failed to convert String to double: $value');
    }

    throw Exception('Unhandled type for value conversion: $value (${value.runtimeType})');
  }

  @override
  void dispose() {
    _dataSource.dispose();
  }
}