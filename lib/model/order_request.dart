class OrderRequest {
  const OrderRequest({required this.productName, required this.buyerAddress});

  final String productName;
  final String buyerAddress;

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'buyerAddress': buyerAddress,
    };
  }

  factory OrderRequest.fromMap(Map<String, dynamic> map) {
    return OrderRequest(
      productName: map['productName'] ?? '',
      buyerAddress: map['buyerAddress'] ?? '',
    );
  }

  @override
  String toString() =>
      'OrderRequest(productName: $productName, buyerAddress: $buyerAddress)';
}
