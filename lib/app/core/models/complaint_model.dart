// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ComplaintModel {
  final String id;
  final String description;
  final String longitude;
  final String latitude;
  final String status;
  final String image;
  final String createdAt;

  ComplaintModel({
    required this.id,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.status,
    required this.image,
    required this.createdAt,
  });

  ComplaintModel copyWith({
    String? id,
    String? description,
    String? longitude,
    String? latitude,
    String? status,
    String? image,
    String? createdAt,
  }) {
    return ComplaintModel(
      id: id ?? this.id,
      description: description ?? this.description,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      status: status ?? this.status,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'longitude': longitude,
      'latitude': latitude,
      'status': status,
      'image': image,
      'createdAt': createdAt,
    };
  }

  factory ComplaintModel.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        "id": final String id,
        "description": final String description,
        "longitude": final String longitude,
        "latitude": final String latitude,
        "createdAt": final String createdAt,
        "status": final String status,
        "image": final String image,
      } =>
        ComplaintModel(
          id: id,
          description: description,
          longitude: longitude,
          latitude: latitude,
          status: status,
          image: image,
          createdAt: createdAt,
        ),
      _ => throw ArgumentError("Houve um problema em transformar os dados")
    };
  }

  String toJson() => json.encode(toMap());

  factory ComplaintModel.fromJson(String source) =>
      ComplaintModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ComplaintModel(id: $id, description: $description, longitude: $longitude, latitude: $latitude, status: $status, image: $image, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ComplaintModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.status == status &&
        other.image == image &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        status.hashCode ^
        image.hashCode ^
        createdAt.hashCode;
  }
}
