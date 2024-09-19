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
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Symbol',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Last',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Chg',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Chg%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cryptoPrices.length,
            itemBuilder: (context, index) {
              return Card(
                color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CryptoPriceTile(cryptoPrice: cryptoPrices[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}