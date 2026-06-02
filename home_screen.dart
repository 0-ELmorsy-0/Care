import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/nurse.dart';
import '../providers/booking_provider.dart';
import '../widgets/service_card.dart';
import 'service_details_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    // قائمة الخدمات الطبية الأساسية للتطبيق
    final services = [
      {'id': 'nurs', 'title': 'تمريض منزلي', 'icon': Icons.medical_services, 'col': const Color(0xFF2A7FFF), 'price': 350.0},
      {'id': 'eld', 'title': 'رعاية كبار السن', 'icon': Icons.favorite, 'col': Colors.rose, 'price': 500.0},
      {'id': 'inj', 'title': 'حقن ومحاليل', 'icon': Icons.vaccines, 'col': Colors.emerald, 'price': 150.0},
      {'id': 'wnd', 'title': 'تغيير جروح', 'icon': Icons.healing, 'col': Colors.amber, 'price': 250.0},
      {'id': 'pt', 'title': 'علاج طبيعي', 'icon': Icons.accessibility, 'col': Colors.purple, 'price': 400.0},
      {'id': 'doc', 'title': 'زيارة طبيب', 'icon': Icons.person_search, 'col': Colors.indigo, 'price': 600.0},
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر والترحيب بالمريض
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'أهلاً بك 👋',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'م. د/ محمد صبحي',
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black80,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: theme.primaryColor, size: 28),
                  )
                ],
              ),
              const SizedBox(height: 12),
              
              // موقع المريض الحالي
              Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFF2A7FFF), size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'التجمع الخامس، القاهرة، مصر',
                    style: GoogleFonts.cairo(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // شريط البحث الأنيق
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن خدمة طبية أو ممرض...',
                    hintStyle: GoogleFonts.cairo(fontSize: 14, color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // عنوان الخدمات
              Text(
                'خدماتنا الطبية',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black80,
                ),
              ),
              const SizedBox(height: 12),

              // شبكة الخدمات بعمودين متناسقين
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  final s = services[index];
                  return ServiceCard(
                    title: s['title'] as String,
                    icon: s['icon'] as IconData,
                    color: s['col'] as Color,
                    onTap: () {
                      // اختيار الخدمة في البوليس بروحها
                      ref.read(bookingProvider.notifier).selectService(
                        s['id'] as String,
                        s['title'] as String,
                        s['price'] as double,
                      );
                      // الانتقال لشاشة التفاصيل
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailsScreen(serviceId: s['id'] as String),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 28),

              // الممرضون المتميزون
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'أفضل الممرضين المتوفرين',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black80,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'عرض الكل',
                      style: GoogleFonts.cairo(color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              // سكرول أفقي للممرضين
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, idx) {
                    final names = ['أميرة سالم', 'أحمد المرسي', 'سارة الشافعي'];
                    final ratings = [4.9, 4.85, 4.95];
                    final prices = [300, 350, 400];
                    return Container(
                      width: 180,
                      margin: const EdgeInsets.only(left: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: theme.primaryColor.withOpacity(0.1),
                                radius: 18,
                                child: Text('👩‍⚕️', style: const TextStyle(fontSize: 16)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  names[idx],
                                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '★ ${ratings[idx]}',
                                style: GoogleFonts.cairo(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Text(
                                '${prices[idx]} ج.م/ساعة',
                                style: GoogleFonts.cairo(color: const Color(0xFF28C76F), fontWeight: FontWeight.bold, fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
