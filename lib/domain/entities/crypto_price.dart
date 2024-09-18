class CryptoPrice {
  final String symbol; // Ticker code (e.g., "ETH-USD", "BTC-USD")
  final double lastPrice; // Last traded price of the cryptocurrency
  final double? quantity; // Quantity of the trade (optional)
  final double? dailyChangePercentage; // Daily change percentage (optional)
  final double? dailyDifferencePrice; // Daily difference in price (optional)
  final DateTime timestamp; // Timestamp of the trade

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
