class CryptoPriceModel {
  final String symbol;
  final double lastPrice;
  final double? quantity;
  final double? dailyChangePercentage;
  final double? dailyDifferencePrice;
  final DateTime timestamp;

  CryptoPriceModel({
    required this.symbol,
    required this.lastPrice,
    this.quantity,
    this.dailyChangePercentage,
    this.dailyDifferencePrice,
    required this.timestamp,
  });

  factory CryptoPriceModel.fromJson(Map<String, dynamic> json) {
    return CryptoPriceModel(
      symbol: json['s'] as String,
      lastPrice: (json['p'] as num).toDouble(),
      quantity: json['q'] != null ? (json['q'] as num).toDouble() : null,
      dailyChangePercentage: json['dc'] != null ? (json['dc'] as num).toDouble() : null,
      dailyDifferencePrice: json['dd'] != null ? (json['dd'] as num).toDouble() : null,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['t'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's': symbol,
      'p': lastPrice,
      'q': quantity,
      'dc': dailyChangePercentage,
      'dd': dailyDifferencePrice,
      't': timestamp.millisecondsSinceEpoch,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final CryptoPriceModel otherModel = other as CryptoPriceModel;
    return symbol == otherModel.symbol &&
        lastPrice == otherModel.lastPrice &&
        quantity == otherModel.quantity &&
        dailyChangePercentage == otherModel.dailyChangePercentage &&
        dailyDifferencePrice == otherModel.dailyDifferencePrice &&
        timestamp == otherModel.timestamp;
  }

  @override
  int get hashCode {
    return Object.hash(
      symbol,
      lastPrice,
      quantity,
      dailyChangePercentage,
      dailyDifferencePrice,
      timestamp,
    );
  }
}
