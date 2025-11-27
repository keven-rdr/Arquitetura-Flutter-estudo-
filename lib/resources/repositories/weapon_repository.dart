import '../models/weapon_model.dart';

class WeaponRepository {
  static final WeaponRepository _instance = WeaponRepository._internal();
  factory WeaponRepository() => _instance;
  WeaponRepository._internal();

  final List<WeaponModel> _allWeapons = [
    WeaponModel(
      id: '1', name: 'ACE32', damage: '43', speed: '720 m/s', type: 'AR', imagePath: 'assets/weapons/ace32.webp',
      bodyDamageLevel2: 25.8, powerValue: 9000.0,
    ),
    WeaponModel(
      id: '2', name: 'AKM', damage: '47', speed: '715 m/s', type: 'AR', imagePath: 'assets/weapons/akm.jpg',
      bodyDamageLevel2: 29.4, powerValue: 10000.0,
    ),
    WeaponModel(
      id: '3', name: 'AUG A3', damage: '41', speed: '940 m/s', type: 'AR', imagePath: 'assets/weapons/aug.jfif',
      bodyDamageLevel2: 25.8, powerValue: 9000.0,
    ),
    WeaponModel(
      id: '4', name: 'AWM', damage: '105', speed: '945 m/s', type: 'SR', imagePath: 'assets/weapons/awm.jfif',
      bodyDamageLevel2: 81.8, powerValue: 40000.0,
    ),
    WeaponModel(
      id: '5', name: 'Beryl M762', damage: '44', speed: '740 m/s', type: 'AR', imagePath: 'assets/weapons/beryl.jfif',
      bodyDamageLevel2: 28.2, powerValue: 10000.0,
    ),
    WeaponModel(
      id: '6', name: 'Besta', damage: '105', speed: '160 m/s', type: 'Outros', imagePath: 'assets/weapons/crossbow.jfif',
      bodyDamageLevel2: 62.8, powerValue: 8000.0,
    ),
    WeaponModel(
      id: '7', name: 'M416', damage: '40', speed: '780 m/s', type: 'AR', imagePath: 'assets/weapons/m416.jfif',
      bodyDamageLevel2: 24.0, powerValue: 3500.0,
    ),
  ];

  Future<List<WeaponModel>> searchWeapons(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) return _allWeapons;

    return _allWeapons.where((w) =>
        w.name.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  WeaponModel? getById(String id) {
    try {
      return _allWeapons.firstWhere((w) => w.id == id);
    } catch (e) {
      return null;
    }
  }
}