import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/http.dart';

class SubmitPengajuanApiClient {
  final ITokenManager _tokenManager;
  SubmitPengajuanApiClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? TokenManagerImpl();

  Future<Response> submitData(String body) async {
    final url = "${CommonUrl.baseUrl}/pengajuan/add";

    return post(
      Uri.parse(url),
      headers: await _tokenManager.getTokenizedHeader(),
      body: body
    );
  }
}