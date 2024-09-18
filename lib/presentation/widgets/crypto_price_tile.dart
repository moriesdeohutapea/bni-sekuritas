import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/crypto_price.dart';

class CryptoPriceTile extends StatelessWidget {
  final CryptoPrice cryptoPrice;

  const CryptoPriceTile({super.key, required this.cryptoPrice});

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              cryptoPrice.symbol,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '\$${numberFormat.format(cryptoPrice.lastPrice)}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                numberFormat.format(cryptoPrice.dailyDifferencePrice ?? 0),
                style: TextStyle(
                  fontSize: 16.0,
                  color: _getChangeColor(cryptoPrice.dailyDifferencePrice),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${numberFormat.format(cryptoPrice.dailyChangePercentage ?? 0)}%',
                style: TextStyle(
                  fontSize: 16.0,
                  color: _getChangeColor(cryptoPrice.dailyChangePercentage),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getChangeColor(double? value) {
    if (value == null) return Colors.black;
    return value >= 0 ? Colors.green : Colors.red;
  }
}