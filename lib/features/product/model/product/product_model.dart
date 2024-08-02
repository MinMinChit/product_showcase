class ProductCategoryModel {
  String slug;
  String name;
  String url;

  ProductCategoryModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
    };
  }

  static List<ProductCategoryModel> fromJsonList(dynamic result) {
    final parsed = result.cast<Map<String, dynamic>>();
    return parsed
        .map<ProductCategoryModel>(
            (json) => ProductCategoryModel.fromJson(json))
        .toList();
  }
}

// Review Model
class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

// Dimensions Model
class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: double.tryParse('${json['width']}') ?? 0,
      height: double.tryParse('${json['height']}') ?? 0,
      depth: double.tryParse('${json['depth']}') ?? 0,
    );
  }
}

// Meta Model
class Meta {
  final DateTime createdAt;
  final DateTime updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      barcode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }
}

// Product Model
class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var tagsFromJson = json['tags'] as List;
    var reviewsFromJson = json['reviews'] as List;
    var imagesFromJson = json['images'] as List;

    List<String> tagsList = tagsFromJson.map((tag) => tag as String).toList();
    List<Review> reviewsList =
        reviewsFromJson.map((review) => Review.fromJson(review)).toList();
    List<String> imagesList =
        imagesFromJson.map((image) => image as String).toList();

    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      stock: json['stock'],
      tags: tagsList,
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight'],
      dimensions: Dimensions.fromJson(json['dimensions']),
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews: reviewsList,
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: Meta.fromJson(json['meta']),
      images: imagesList,
      thumbnail: json['thumbnail'],
    );
  }

  static List<Product> fromJsonList(dynamic result) {
    final parsed = result.cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }
}

// Response Model
class ProductsResponse {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductsResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    var productsFromJson = json['products'] as List;
    List<Product> productsList =
        productsFromJson.map((product) => Product.fromJson(product)).toList();

    return ProductsResponse(
      products: productsList,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
