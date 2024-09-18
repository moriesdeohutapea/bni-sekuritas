import 'package:flutter/material.dart';

import '../../domain/entities/crypto_price.dart';

class CryptoPriceTile extends StatelessWidget {
  final CryptoPrice cryptoPrice;

  const CryptoPriceTile({super.key, required this.cryptoPrice});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cryptoPrice.symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('Last Price: \$${cryptoPrice.lastPrice.toStringAsFixed(2)}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Chg: ${cryptoPrice.dailyDifferencePrice?.toStringAsFixed(2) ?? 'N/A'}',
            style: TextStyle(color: _getChangeColor(cryptoPrice.dailyDifferencePrice)),
          ),
          Text(
            'Chg%: ${cryptoPrice.dailyChangePercentage?.toStringAsFixed(2) ?? 'N/A'}%',
            style: TextStyle(color: _getChangeColor(cryptoPrice.dailyChangePercentage)),
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
