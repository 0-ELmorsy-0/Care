import '../../domain/entities/nurse.dart';

class NurseModel extends Nurse {
  const NurseModel({
    required super.id,
    required super.name,
    required super.title,
    required super.rating,
    required super.reviewsCount,
    required super.experienceYears,
    required super.experienceText,
    required super.pricePerSession,
    required super.gender,
    required super.baseLocationName,
    required super.latitude,
    required super.longitude,
  });

  // تحويل مستند Firestore JSON إلى كائن ممرض
  factory NurseModel.fromJson(Map<String, dynamic> json, String documentId) {
    return NurseModel(
      id: documentId,
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      rating: (json['rating'] ?? 5.0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      experienceYears: json['experienceYears'] ?? 0,
      experienceText: json['experienceText'] ?? '',
      pricePerSession: (json['price_per_session'] ?? 200).toDouble(),
      gender: json['gender'] ?? 'male',
      baseLocationName: json['base_location_name'] ?? 'Cairo',
      latitude: (json['latitude'] ?? 30.0444).toDouble(),
      longitude: (json['longitude'] ?? 31.2357).toDouble(),
    );
  }

  // تحويل الكائن إلى Map لإرساله لـ Firestore عند الحاجة لتسجيل ممرض جديد
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'experienceYears': experienceYears,
      'experienceText': experienceText,
      'price_per_session': pricePerSession,
      'gender': gender,
      'base_location_name': baseLocationName,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
