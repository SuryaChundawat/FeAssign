


import '../../model/response/base/api_response.dart';
import '../../utils/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';

class LoginRepository{

  final DioClient? dioClient;

  LoginRepository({required this.dioClient});

  Future<ApiResponse> getUserDeatils(String email) async {
    try {
      String uri = AppConstants.userLogin+"email="+email;
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}