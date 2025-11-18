import '../models/weapon_model.dart';

class WeaponRepository {
  static final WeaponRepository _instance = WeaponRepository._internal();
  factory WeaponRepository() => _instance;
  WeaponRepository._internal();

  final List<WeaponModel> _allWeapons = [
    WeaponModel(id: '1', name: 'ACE32', damage: '43', speed: '720 m/s', type: 'AR', imagePath: 'assets/weapons/ace32.png'),
    WeaponModel(id: '2', name: 'AKM', damage: '47', speed: '715 m/s', type: 'AR', imagePath: 'assets/weapons/akm.png'),
    WeaponModel(id: '3', name: 'AUG A3', damage: '41', speed: '940 m/s', type: 'AR', imagePath: 'assets/weapons/aug.png'),
    WeaponModel(id: '4', name: 'AWM', damage: '105', speed: '945 m/s', type: 'SR', imagePath: 'assets/weapons/awm.png'),
    WeaponModel(id: '5', name: 'Beryl M762', damage: '44', speed: '740 m/s', type: 'AR', imagePath: 'assets/weapons/beryl.png'),
    WeaponModel(id: '6', name: 'Besta', damage: '105', speed: '160 m/s', type: 'Outros', imagePath: 'assets/weapons/crossbow.png'),
    WeaponModel(id: '7', name: 'M416', damage: '40', speed: '780 m/s', type: 'AR', imagePath: 'assets/weapons/m416.png'),
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