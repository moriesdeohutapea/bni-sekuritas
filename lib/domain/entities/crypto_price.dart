class CryptoPrice {
  final String symbol;
  final double lastPrice;
  final double? quantity;
  final double? dailyChangePercentage;
  final double? dailyDifferencePrice;
  final DateTime timestamp;

  CryptoPrice({
    required this.symbol,
    required this.lastPrice,
    this.quantity,
    this.dailyChangePercentage,
    this.dailyDifferencePrice,
    required this.timestamp,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final CryptoPrice otherPrice = other as CryptoPrice;
    return symbol == otherPrice.symbol &&
        lastPrice == otherPrice.lastPrice &&
        quantity == otherPrice.quantity &&
        dailyChangePercentage == otherPrice.dailyChangePercentage &&
        dailyDifferencePrice == otherPrice.dailyDifferencePrice &&
        timestamp == otherPrice.timestamp;
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
