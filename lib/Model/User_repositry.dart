// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:gmailapp/Model/EmailModel.dart';
//
// class UserRepository {
//   final FlutterSecureStorage _storage;
//
//   UserRepository(this._storage);
//
//   Future<User> getUser() async {
//     final token = await _storage.read('token');
//     if (token == null) return null;
//     final payload = JwtDecoder.decode(token);
//     return User.fromJson(payload);
//   }
// }