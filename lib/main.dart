import 'package:flutter/material.dart';

void main() {
  runApp(const SanadApp());
}

const teal = Color(0xFF0F5560);
const mint = Color(0xFFD3EAE6);
const navy = Color(0xFF0B2530);
const red = Color(0xFFC8102E);

class SanadApp extends StatelessWidget {
  const SanadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سَنَد',
      theme: ThemeData(
        scaffoldBackgroundColor: mint,
        colorScheme: ColorScheme.fromSeed(seedColor: teal),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String elderName = 'ضيف سَنَد';
  String elderAge = '';
  String familyPhone = '';

  final List<Map<String, dynamic>> medicines = [
    {'name': 'دواء الضغط', 'time': '08:00', 'taken': false},
    {'name': 'دواء السكر', 'time': '13:00', 'taken': false},
    {'name': 'فيتامين', 'time': '20:00', 'taken': false},
  ];

  void openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: teal,
          foregroundColor: Colors.white,
          title: const Text(
            '❤ سَنَد',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => openPage(
                SettingsPage(
                  name: elderName,
                  age: elderAge,
                  phone: familyPhone,
                  onSave: (name, age, phone) {
                    setState(() {
                      elderName = name;
                      elderAge = age;
                      familyPhone = phone;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 10),
            const Text(
              'بقاء مستقل، طمأنينة للعائلة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'مرحباً، $elderName 🌷',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 23, color: teal),
            ),
            const SizedBox(height: 25),

            SizedBox(
              height: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('🆘 طلب المساعدة'),
                      content: const Text(
                        'هل تريد فتح الاتصال برقم الحماية المدنية 14؟',
                        style: TextStyle(fontSize: 19),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text('إلغاء'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            openPage(const CallHelpPage());
                          },
                          child: const Text('متابعة'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  '🆘  استغاثة',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 18),

            MenuButton(
              icon: Icons.phone,
              title: 'اتصال بالعائلة',
              onTap: () {
                if (familyPhone.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('أضف رقم العائلة من الإعدادات أولاً'),
                    ),
                  );
                } else {
                  openPage(CallHelpPage(phone: familyPhone));
                }
              },
            ),

            MenuButton(
              icon: Icons.medication,
              title: 'أدويتي',
              onTap: () => openPage(
                MedicinesPage(
                  medicines: medicines,
                  onChanged: () => setState(() {}),
                ),
              ),
            ),

            MenuButton(
              icon: Icons.family_restroom,
              title: 'لوحة العائلة',
              onTap: () => openPage(
                FamilyPage(
                  name: elderName,
                  age: elderAge,
                  medicines: medicines,
                ),
              ),
            ),

            const SizedBox(height: 18),
            const Text(
              'نسخة تجريبية — المعلومات المعروضة ليست مراقبة طبية حقيقية.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: navy),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: SizedBox(
        height: 75,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: 30),
          label: Text(title, style: const TextStyle(fontSize: 21)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: teal,
            elevation: 2,
            alignment: Alignment.centerRight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    );
  }
}

class MedicinesPage extends StatefulWidget {
  final List<Map<String, dynamic>> medicines;
  final VoidCallback onChanged;

  const MedicinesPage({
    super.key,
    required this.medicines,
    required this.onChanged,
  });

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('أدويتي'),
          backgroundColor: teal,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'قائمة أدوية تجريبية',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...widget.medicines.map((medicine) {
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine['name'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'الوقت: ${medicine['time']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: medicine['taken']
                              ? null
                              : () {
                                  setState(() {
                                    medicine['taken'] = true;
                                  });
                                  widget.onChanged();
                                },
                          child: Text(
                            medicine['taken']
                                ? 'تم التسجيل ✔'
                                : 'أخذت الدواء',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            const Text(
              'الأدوية والأوقات المعروضة تجريبية. اعتمد على وصفة الطبيب الفعلية.',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyPage extends StatelessWidget {
  final String name;
  final String age;
  final List<Map<String, dynamic>> medicines;

  const FamilyPage({
    super.key,
    required this.name,
    required this.age,
    required this.medicines,
  });

  @override
  Widget build(BuildContext context) {
    final taken = medicines.where((m) => m['taken'] == true).length;
    final percentage = medicines.isEmpty
        ? 0
        : (taken * 100 ~/ medicines.length);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('لوحة العائلة'),
          backgroundColor: teal,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(Icons.family_restroom, size: 70, color: teal),
            const SizedBox(height: 18),
            InfoCard(title: 'اسم المسن', value: name),
            InfoCard(
              title: 'العمر',
              value: age.isEmpty ? 'غير محدد' : '$age سنة',
            ),
            const InfoCard(
              title: 'الحالة',
              value: 'بيانات تجريبية فقط',
            ),
            InfoCard(
              title: 'الأدوية المسجلة',
              value: '$taken من ${medicines.length}',
            ),
            InfoCard(
              title: 'نسبة التسجيل التجريبية',
              value: '$percentage%',
            ),
            const SizedBox(height: 15),
            const Text(
              'هذه البيانات محلية على الجهاز، ولا ترسل تقارير إلى أفراد العائلة.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 17)),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 21,
            color: teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final String name;
  final String age;
  final String phone;
  final Function(String, String, String) onSave;

  const SettingsPage({
    super.key,
    required this.name,
    required this.age,
    required this.phone,
    required this.onSave,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final TextEditingController nameController;
  late final TextEditingController ageController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات'),
          backgroundColor: teal,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'معلومات المسن والعائلة',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم المسن',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'العمر',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'رقم هاتف العائلة',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave(
                    nameController.text.trim().isEmpty
                        ? 'ضيف سَنَد'
                        : nameController.text.trim(),
                    ageController.text.trim(),
                    phoneController.text.trim(),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم تحديث البيانات في الواجهة'),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'حفظ الإعدادات',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CallHelpPage extends StatelessWidget {
  final String? phone;

  const CallHelpPage({super.key, this.phone});

  @override
  Widget build(BuildContext context) {
    final number = phone ?? '14';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الاتصال'),
          backgroundColor: teal,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.phone_in_talk, size: 80, color: teal),
                const SizedBox(height: 20),
                Text(
                  'رقم الاتصال: $number',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'هذه النسخة تعرض رقم الاتصال فقط. '
                  'الاتصال الفعلي يحتاج إلى ربط التطبيق بوظيفة الاتصال في الهاتف.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}