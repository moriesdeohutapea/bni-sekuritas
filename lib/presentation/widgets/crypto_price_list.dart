import 'package:flutter/material.dart';

import '../../domain/entities/crypto_price.dart';
import 'crypto_price_tile.dart';

class CryptoPriceList extends StatelessWidget {
  final List<CryptoPrice> cryptoPrices;

  CryptoPriceList({super.key, required this.cryptoPrices});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoPrices.length,
      itemBuilder: (context, index) {
        return CryptoPriceTile(cryptoPrice: cryptoPrices[index]);
      },
    );
  }
}
