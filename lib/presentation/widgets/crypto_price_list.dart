import 'package:flutter/material.dart';

import '../../domain/entities/crypto_price.dart';
import 'crypto_price_tile.dart';

class CryptoPriceList extends StatelessWidget {
  final List<CryptoPrice> cryptoPrices;

  const CryptoPriceList({super.key, required this.cryptoPrices});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Symbol',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Last',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Chg',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Chg%',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: cryptoPrices.length,
            itemBuilder: (context, index) {
              return CryptoPriceTile(cryptoPrice: cryptoPrices[index]);
            },
          ),
        ),
      ],
    );
  }
}