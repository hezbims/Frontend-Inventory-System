import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_setting_akun/data/api_client/setting_akun_api_client.dart';
import 'package:fitur_setting_akun/domain/repository/i_setting_akun_repository.dart';

class SettingAkunRepositoryImpl implements ISettingAkunRepository {
  final _apiClient = SettingAkunApiClient();
  @override
  Future<ApiResponse> logout() {
    return ApiRequestProcessor.process(apiRequest: _apiClient.logout());
  }

}