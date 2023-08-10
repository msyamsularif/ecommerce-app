import 'package:equatable/equatable.dart';

import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/gallery_model.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final double price;
  final String description;
  final String? tags;
  final CategoryModel category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<GalleryMdoel> galleries;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.tags,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.galleries,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        tags,
        category,
        createdAt,
        updatedAt,
        galleries,
      ];

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
    String? tags,
    CategoryModel? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<GalleryMdoel>? galleries,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      galleries: galleries ?? this.galleries,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'category': category.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      'galleries': galleries.map((x) => x.toJson()).toList(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      price: double.parse(map['price'].toString()),
      description: map['description'],
      tags: map['tags'],
      category: CategoryModel.fromJson(map['category']),
      createdAt: DateTime.parse(map['created_at'].toString()),
      updatedAt: DateTime.parse(map['updated_at'].toString()),
      galleries: List<GalleryMdoel>.from(
          map['galleries']?.map((x) => GalleryMdoel.fromJson(x))),
    );
  }
}

class UninitializedProductModel extends ProductModel {
  UninitializedProductModel({
    DateTime? dateTime,
    super.id = 0,
    super.name = '',
    super.price = 0.0,
    super.description = '',
    super.category = const CategoryModel(id: 0, name: ''),
    super.galleries = const [],
  }) : super(
          createdAt: dateTime ?? DateTime.now(),
          updatedAt: dateTime ?? DateTime.now(),
        );
}
