import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoWebSocketDataSource {
  final WebSocketChannel _channel;
  final StreamController<Map<String, dynamic>> _cryptoPriceController = StreamController.broadcast();
  int? _lastTimestampInSeconds;

  CryptoWebSocketDataSource()
      : _channel = WebSocketChannel.connect(
          Uri.parse('${dotenv.env['WEBSOCKET_URL']}?api_token=${dotenv.env['API_TOKEN']}'),
        ) {
    _initializeListeners();
  }

  void subscribeToCryptoPrices(List<String> symbols) {
    _sendAction("subscribe", symbols);
  }

  void unsubscribeFromCryptoPrices(List<String> symbols) {
    _sendAction("unsubscribe", symbols);
  }

  void _sendAction(String action, List<String> symbols) {
    final message = jsonEncode({
      "action": action,
      "symbols": symbols.join(","),
    });
    _channel.sink.add(message);
  }

  void _initializeListeners() {
    _channel.stream.listen(_onDataReceived, onError: _onError, onDone: _onDone);
  }

  void _onDataReceived(dynamic event) {
    try {
      final data = jsonDecode(event);
      if (data is Map<String, dynamic>) {
        final timestampInSeconds = _extractTimestampInSeconds(data['t']);
        if (_shouldUpdate(timestampInSeconds)) {
          _lastTimestampInSeconds = timestampInSeconds;
          _cryptoPriceController.add(data);
        }
      }
    } catch (e) {
      print('Error decoding WebSocket data: $e');
    }
  }

  int? _extractTimestampInSeconds(dynamic timestamp) {
    if (timestamp is int) {
      return (timestamp / 1000).round();
    }
    return null;
  }

  bool _shouldUpdate(int? timestampInSeconds) {
    return _lastTimestampInSeconds == null || _lastTimestampInSeconds != timestampInSeconds;
  }

  void _onError(error) {
    print('WebSocket error: $error');
  }

  void _onDone() {
    print('WebSocket connection closed');
  }

  Stream<Map<String, dynamic>> get cryptoPricesStream => _cryptoPriceController.stream;

  void dispose() {
    _channel.sink.close(status.goingAway);
    _cryptoPriceController.close();
  }
}