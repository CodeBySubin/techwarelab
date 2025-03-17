import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:techware/core/network/api_client.dart';
import 'package:techware/core/network/api_endpoint.dart';
import 'package:techware/core/network/dio_exception.dart';
import 'package:techware/model/home_model.dart';

class HomeViewModel extends GetxController {
  List<HomeModel> homelist = [];
  Dio dio = Dio();
  bool isloading = true;
  Errors? errorMessage;
  final ApiClient apiClient = ApiClient();

  Future<void> fetchHome() async {
    try {
      final response = await apiClient.get(APIEndPoints.todo);
      homelist =
          (response.data as List)
              .map((item) => HomeModel.fromJson(item))
              .toList();
      update();
    } on DioException catch (e) {
      errorMessage = DioExceptionHandler.handleDioError(e);
      update();
    } finally {
      isloading = false;
      update();
    }
  }
}
