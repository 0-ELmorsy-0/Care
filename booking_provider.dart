import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/nurse.dart';

// هيكل يصف حالة الحجز بالكامل
class BookingState {
  final String? selectedServiceId;
  final String? selectedServiceTitle;
  final double servicePrice;
  final Nurse? selectedNurse;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;
  final String address;
  final String notes;
  final String paymentMethod; // 'cash' | 'vodafone' | 'card'
  final bool isSubmitting;
  final String? error;
  final String? bookingId;

  BookingState({
    this.selectedServiceId,
    this.selectedServiceTitle,
    this.servicePrice = 0.0,
    this.selectedNurse,
    this.selectedDate,
    this.selectedTimeSlot,
    this.address = '',
    this.notes = '',
    this.paymentMethod = 'cash',
    this.isSubmitting = false,
    this.error,
    this.bookingId,
  });

  BookingState copyWith({
    String? selectedServiceId,
    String? selectedServiceTitle,
    double? servicePrice,
    Nurse? selectedNurse,
    DateTime? selectedDate,
    String? selectedTimeSlot,
    String? address,
    String? notes,
    String? paymentMethod,
    bool? isSubmitting,
    String? error,
    String? bookingId,
  }) {
    return BookingState(
      selectedServiceId: selectedServiceId ?? this.selectedServiceId,
      selectedServiceTitle: selectedServiceTitle ?? this.selectedServiceTitle,
      servicePrice: servicePrice ?? this.servicePrice,
      selectedNurse: selectedNurse ?? this.selectedNurse,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}

// مٌتحكم إدارة الحجز (StateNotifier) لـ Riverpod
class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier() : super(BookingState());

  void selectService(String serviceId, String title, double price) {
    state = state.copyWith(
      selectedServiceId: serviceId,
      selectedServiceTitle: title,
      servicePrice: price,
      error: null,
    );
  }

  void selectNurse(Nurse nurse) {
    state = state.copyWith(selectedNurse: nurse, error: null);
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date, error: null);
  }

  void selectTimeSlot(String slot) {
    state = state.copyWith(selectedTimeSlot: slot, error: null);
  }

  void updateAddress(String addr) {
    state = state.copyWith(address: addr);
  }

  void updateNotes(String text) {
    state = state.copyWith(notes: text);
  }

  void selectPaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method);
  }

  // إرسال البيانات وتخزينها بـ Cloud Firestore
  Future<bool> confirmBookingAndSaveToFirestore() async {
    if (state.selectedDate == null || state.selectedTimeSlot == null) {
      state = state.copyWith(error: 'الرجاء اختيار تاريخ ووقت الحجز');
      return false;
    }
    if (state.address.trim().isEmpty) {
      state = state.copyWith(error: 'الرجاء إدخال عنوان الإقامة بدقة');
      return false;
    }

    state = state.copyWith(isSubmitting: true, error: null);

    try {
      // محاكاة تأخير الإرسال لـ Firestore
      await Future.delayed(const Duration(seconds: 2));
      
      // في الكود الحقيقي، ستتصل بـ Firestore هكذا:
      // final docRef = await FirebaseFirestore.instance.collection('bookings').add({
      //   'service_id': state.selectedServiceId,
      //   'service_title': state.selectedServiceTitle,
      //   'nurse_id': state.selectedNurse?.id,
      //   'nurse_name': state.selectedNurse?.name,
      //   'date': state.selectedDate!.toIso8601String(),
      //   'time_slot': state.selectedTimeSlot,
      //   'address': state.address,
      //   'notes': state.notes,
      //   'payment_method': state.paymentMethod,
      //   'total_price': state.servicePrice + (state.selectedNurse?.pricePerSession ?? 0),
      //   'status': 'pending',
      //   'created_at': FieldValue.serverTimestamp(),
      // });
      
      String generatedId = 'ELM-${DateTime.now().millisecond}99';
      state = state.copyWith(
        isSubmitting: false, 
        bookingId: generatedId,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false, 
        error: 'فشل تحميل الحجز السحابي: ${e.toString()}',
      );
      return false;
    }
  }

  void reset() {
    state = BookingState();
  }
}

// إنشاء الـ Provider الخاص بحالة الحجر بالكامل
final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  return BookingNotifier();
});
