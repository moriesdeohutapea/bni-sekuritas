import 'package:bni_sekuritas/domain/usecases/get_crypto_prices.dart';
import 'package:bni_sekuritas/presentation/blocs/crypto_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/crypto_websocket_data_source.dart';
import 'data/repositories/crypto_repository_impl.dart';
import 'domain/repositories/crypto_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CryptoWebSocketDataSource>(() => CryptoWebSocketDataSource());

  locator.registerLazySingleton<CryptoRepository>(() => CryptoRepositoryImpl(locator<CryptoWebSocketDataSource>()));

  locator.registerLazySingleton<GetCryptoPrices>(() => GetCryptoPrices(locator<CryptoRepository>()));

  locator.registerFactory(() => CryptoBloc(locator<GetCryptoPrices>()));
}
