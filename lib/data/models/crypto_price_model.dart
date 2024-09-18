class CryptoPriceModel {
  final String symbol; // Ticker code (e.g., "ETH-USD", "BTC-USD")
  final double lastPrice; // Last traded price of the cryptocurrency
  final double? quantity; // Quantity of the trade (optional)
  final double? dailyChangePercentage; // Daily change percentage (optional)
  final double? dailyDifferencePrice; // Daily difference in price (optional)
  final DateTime timestamp; // Timestamp of the trade in seconds

  CryptoPriceModel({
    required this.symbol,
    required this.lastPrice,
    this.quantity,
    this.dailyChangePercentage,
    this.dailyDifferencePrice,
    required this.timestamp,
  });

  // Factory method to create a CryptoPriceModel from a JSON map
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

  // Method to convert CryptoPriceModel instance to JSON map
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

  // Overriding equality operator
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

  // Overriding hashCode
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
