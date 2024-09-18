import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoWebSocketDataSource {
  final WebSocketChannel _channel;
  final StreamController<Map<String, dynamic>> _cryptoPriceController = StreamController.broadcast();
  int? lastTimestampInSeconds;

  CryptoWebSocketDataSource()
      : _channel = WebSocketChannel.connect(
          Uri.parse('${dotenv.env['WEBSOCKET_URL']}?api_token=${dotenv.env['API_TOKEN']}'),
        ) {
    _initializeListeners();
  }

  void subscribeToCryptoPrices(List<String> symbols) {
    final subscribeMessage = jsonEncode({
      "action": "subscribe",
      "symbols": symbols.join(","),
    });
    _channel.sink.add(subscribeMessage);
  }

  void unsubscribeFromCryptoPrices(List<String> symbols) {
    final unsubscribeMessage = jsonEncode({
      "action": "unsubscribe",
      "symbols": symbols.join(","),
    });
    _channel.sink.add(unsubscribeMessage);
  }

  void _initializeListeners() {
    _channel.stream.listen((event) {
      try {
        final data = jsonDecode(event);
        if (data is Map<String, dynamic>) {
          final timestampInMilliseconds = data['t'] as int;
          final timestampInSeconds = (timestampInMilliseconds / 1000).round();

          if (lastTimestampInSeconds == null || lastTimestampInSeconds != timestampInSeconds) {
            lastTimestampInSeconds = timestampInSeconds;
            _cryptoPriceController.add(data);
          }
        }
      } catch (e) {
        print('Error decoding WebSocket data: $e');
      }
    }, onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket connection closed');
    });
  }

  Stream<Map<String, dynamic>> get cryptoPricesStream => _cryptoPriceController.stream;

  void dispose() {
    _channel.sink.close(status.goingAway);
    _cryptoPriceController.close();
  }
}