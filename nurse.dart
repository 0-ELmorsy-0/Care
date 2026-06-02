import 'package:geolocator/geolocator.dart';

class Nurse {
  final String id;
  final String name;
  final String title;
  final double rating;
  final int reviewsCount;
  final int experienceYears;
  final String experienceText;
  final double pricePerSession;
  final String gender; // 'male' | 'female'
  final String baseLocationName;
  final double latitude;
  final double longitude;

  const Nurse({
    required this.id,
    required this.name,
    required this.title,
    required this.rating,
    required this.reviewsCount,
    required this.experienceYears,
    required this.experienceText,
    required this.pricePerSession,
    required this.gender,
    required this.baseLocationName,
    required this.latitude,
    required this.longitude,
  });

  // حساب المسافة المباشرة بالكيلومترات من موقع المريض الحالي باستعمال مكتبة Geolocator
  double calculateDistanceInKm(double patientLat, double patientLng) {
    double distanceInMeters = Geolocator.distanceBetween(
      latitude,
      longitude,
      patientLat,
      patientLng,
    );
    return distanceInMeters / 1000.0;
  }

  // لعمل نسخة معدلة بسهولة
  Nurse copyWith({
    String? id,
    String? name,
    String? title,
    double? rating,
    int? reviewsCount,
    int? experienceYears,
    String? experienceText,
    double? pricePerSession,
    String? gender,
    String? baseLocationName,
    double? latitude,
    double? longitude,
  }) {
    return Nurse(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      experienceYears: experienceYears ?? this.experienceYears,
      experienceText: experienceText ?? this.experienceText,
      pricePerSession: pricePerSession ?? this.pricePerSession,
      gender: gender ?? this.gender,
      baseLocationName: baseLocationName ?? this.baseLocationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
