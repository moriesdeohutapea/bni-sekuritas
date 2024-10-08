import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/crypto_price.dart';
import '../../domain/usecases/get_crypto_prices.dart';
import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final GetCryptoPrices _getCryptoPrices;

  CryptoBloc(this._getCryptoPrices) : super(CryptoInitial()) {
    on<SubscribeToCryptoPrices>(_onSubscribeToCryptoPrices);
    on<UnsubscribeFromCryptoPrices>(_onUnsubscribeFromCryptoPrices);
    on<WebSocketErrorOccurred>(_onWebSocketErrorOccurred);
    on<WebSocketConnectionClosed>(_onWebSocketConnectionClosed);
  }

  Future<void> _onSubscribeToCryptoPrices(SubscribeToCryptoPrices event, Emitter<CryptoState> emit) async {
    emit(CryptoLoading());
    try {
      final cryptoStream = _getCryptoPrices.call(event.symbols);
      await emit.forEach<List<CryptoPrice>>(
        cryptoStream,
        onData: (data) => CryptoLoaded(data),
        onError: (error, _) => _handleError(error),
      );
    } catch (error) {
      emit(_handleError(error));
    }
  }

  Future<void> _onUnsubscribeFromCryptoPrices(UnsubscribeFromCryptoPrices event, Emitter<CryptoState> emit) async {
    _getCryptoPrices.dispose();
    emit(CryptoInitial());
  }

  Future<void> _onWebSocketErrorOccurred(WebSocketErrorOccurred event, Emitter<CryptoState> emit) async {
    emit(CryptoError('WebSocket error: ${event.error}'));
  }

  Future<void> _onWebSocketConnectionClosed(WebSocketConnectionClosed event, Emitter<CryptoState> emit) async {
    emit(CryptoError('WebSocket connection closed'));
  }

  CryptoState _handleError(Object error) {
    print('Error occurred: $error');
    return CryptoError('Failed to fetch data');
  }
}