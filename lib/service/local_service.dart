import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EventService {
  static const storage = FlutterSecureStorage();

  static Future<void> storeInfo(
    String fullName,
    String phoneNumber,
    String token,
    String updatedAt,
    String createdAt,
    int id,
  ) async {
    await storage.write(
      key: 'fullName',
      value: fullName,
    );
    await storage.write(
      key: 'phoneNumber',
      value: phoneNumber,
    );
    await storage.write(
      key: 'token',
      value: token,
    );
    await storage.write(
      key: 'updatedAt',
      value: updatedAt,
    );
    await storage.write(
      key: 'createdAt',
      value: createdAt,
    );
    await storage.write(
      key: 'id',
      value: '$id',
    );
  }

  static Future<void> storegeInfo(bool smart) async {
    await storage.write(
      key: 'isLogged',
      value: '$smart',
    );
  }

  static Future<void> storeImage(String imagePath) async {
    await storage.write(
      key: 'imagePath',
      value: imagePath,
    );
  }

  static Future<String?> getImagePath() async {
    return await storage.read(key: 'imagePath');
  }

  static Future<String?> getIsLogged() async {
    return await storage.read(key: 'isLogged');
  }

  static Future<String?> getName() async {
    return await storage.read(key: 'fullName');
  }

  static Future<String?> getPhoneNumber() async {
    return await storage.read(key: 'phoneNumber');
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  static Future<String?> getCreatedAt() async {
    return await storage.read(key: 'createdAt');
  }

  static Future<String?> getUpdatedAt() async {
    return await storage.read(key: 'updatedAt');
  }

  static Future<String?> getId() async {
    return await storage.read(key: 'id');
  }
}
