import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/crypto_bloc.dart';
import '../blocs/crypto_event.dart';
import '../blocs/crypto_state.dart';
import '../widgets/crypto_price_list.dart';

class CryptoPricesScreen extends StatelessWidget {
  const CryptoPricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the event to subscribe to crypto prices
    context.read<CryptoBloc>().add(SubscribeToCryptoPrices(['ETH-USD', 'BTC-USD']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Prices'),
      ),
      body: const CryptoPricesView(),
    );
  }
}

class CryptoPricesView extends StatelessWidget {
  const CryptoPricesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoBloc, CryptoState>(
      builder: (context, state) {
        if (state is CryptoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CryptoLoaded) {
          return CryptoPriceList(cryptoPrices: state.cryptoPrices);
        } else if (state is CryptoError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Press the button to fetch crypto prices.'));
        }
      },
    );
  }
}
