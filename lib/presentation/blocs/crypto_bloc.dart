import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/crypto_price.dart';
import '../../domain/usecases/get_crypto_prices.dart';
import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final GetCryptoPrices getCryptoPrices;

  CryptoBloc(this.getCryptoPrices) : super(CryptoInitial()) {
    on<SubscribeToCryptoPrices>((event, emit) async {
      emit(CryptoLoading());
      try {
        final cryptoStream = getCryptoPrices.call(event.symbols);
        await emit.forEach<List<CryptoPrice>>(
          cryptoStream,
          onData: (data) => CryptoLoaded(data),
          onError: (error, stackTrace) {
            print('Error occurred: $error');
            print('Stack trace: $stackTrace');
            return CryptoError('Failed to fetch data');
          },
        );
      } catch (error, stackTrace) {
        print('Exception caught in CryptoBloc: $error');
        print('Stack trace: $stackTrace');
        emit(CryptoError('Failed to fetch data'));
      }
    });

    on<UnsubscribeFromCryptoPrices>((event, emit) async {
      getCryptoPrices.dispose();
      emit(CryptoInitial());
    });
  }
}
