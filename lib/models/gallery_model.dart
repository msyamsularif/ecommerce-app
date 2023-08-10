import 'package:equatable/equatable.dart';

class GalleryMdoel extends Equatable {
  final int id;
  final String url;

  const GalleryMdoel({
    required this.id,
    required this.url,
  });

  @override
  List<Object?> get props => [id, url];

  GalleryMdoel copyWith({
    int? id,
    String? url,
  }) {
    return GalleryMdoel(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }

  factory GalleryMdoel.fromJson(Map<String, dynamic> map) {
    return GalleryMdoel(
      id: map['id'],
      url: map['url'],
    );
  }
}
