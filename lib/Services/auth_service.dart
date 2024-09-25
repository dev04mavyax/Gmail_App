// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:gmailapp/Model/EmailModel.dart';
// import 'package:gmailapp/Services/Api.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
//
// class AuthService {
//   final FlutterSecureStorage _storage;
//   final Api _api;
//
//   AuthService(this._storage, this._api);
//
//   Future<User> login(String email, String password) async {
//     final response = await _api.post('/login', {'email': email, 'password': password});
//     final token = response['token'];
//     final user = User.fromJson(response['user']);
//     await _storage.write('token', token);
//     return user;
//   }
//
//   Future<void> logout() async {
//     await _storage.delete('token');
//   }
//
//   Future<bool> isLoggedIn() async {
//     final token = await _storage.read('token');
//     return token != null;
//   }
//
//   Future<void> forgotPassword(String email) async {
//     await _api.post('/forgot-password', {'email': email});
//   }
//
//   Future<void> resetPassword(String token, String password) async {
//     await _api.post('/reset-password', {'token': token, 'password': password});
//   }
// }