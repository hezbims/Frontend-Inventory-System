import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_setting_akun/domain/model/register_dto.dart';

class RegisterApiClient {
  final ITokenManager _tokenManager = GetIt.I.get();
  Future<Response> register(RegisterDto data) async {
    final url = "${CommonUrl.baseUrl}/register";

    return post(
      Uri.parse(url),
      body: {
        'username' : data.username,
        'password' : data.password,
      },
      headers: await _tokenManager.getTokenizedHeader(),
    );
  }
}