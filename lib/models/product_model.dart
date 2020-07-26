class Product {
  final String id;
  // final String associatedUserId;
  String title;
  String description;
  String imageUrl;
  double price;
  bool isFavourite;
  int itemCount;
  int currentItemCount;

  Product(
      {this.id,
      // this.associatedUserId,
      this.title,
      this.description,
      this.imageUrl,
      this.price,
      this.isFavourite = false,
      this.itemCount = 0,
      this.currentItemCount = 0});
}
