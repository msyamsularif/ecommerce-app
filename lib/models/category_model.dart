import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;

  const CategoryModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  CategoryModel copyWith({
    int? id,
    String? name,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
