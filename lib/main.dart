import 'package:bni_sekuritas/presentation/blocs/crypto_bloc.dart';
import 'package:bni_sekuritas/presentation/screens/crypto_prices_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'data/datasources/crypto_websocket_data_source.dart';
import 'data/repositories/crypto_repository_impl.dart';
import 'domain/usecases/get_crypto_prices.dart';

void main() async{
  await dotenv.load(fileName: 'bni_environment.env');
  final dataSource = CryptoWebSocketDataSource();
  final repository = CryptoRepositoryImpl(dataSource);
  final getCryptoPrices = GetCryptoPrices(repository);

  runApp(MyApp(getCryptoPrices: getCryptoPrices));
}

class MyApp extends StatelessWidget {
  final GetCryptoPrices getCryptoPrices;

  const MyApp({super.key, required this.getCryptoPrices});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BNI Sekuritas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => CryptoBloc(getCryptoPrices),
        child: const CryptoPricesScreen(),
      ),
    );
  }
}
