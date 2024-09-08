import 'package:dio/dio.dart';
import 'package:expense_tracker/local_storage/local_storage.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      var response = await Dio().post(
        "http://10.0.2.2:8000/api/login",
        options: Options(headers: {"Content-Type": "application/json"}),
        data: {
          "email": email,
          "password": password,
        },
      );

      var responseData = response.data;

      LocalStorage().writeData("token", responseData['token']);
      return responseData;
    } on DioException catch (e) {
      print(e);
      return await e.response!.data;
    }
  }

  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      var response = await Dio().post(
        "http://10.0.2.2:8000/api/register",
        options: Options(headers: {"Content-Type": "application/json"}),
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
      );

      var responseData = response.data;

      LocalStorage().writeData("token", responseData['token']);

      return responseData;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
}
