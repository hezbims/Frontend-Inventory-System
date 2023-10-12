import 'package:common/data/api_client/barang_api_client.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/data/mapper/barang/get_detail_barang_mapper.dart';
import 'package:common/data/mapper/barang/get_list_barang_mapper.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';

class BarangRepositoryImpl implements IBarangRepository {
  final _getDetailBarangMapper = GetDetailBarangMapper();

  final _apiClient = BarangApiClient();

  @override
  Future<ApiResponse> getStockBarang(int pageNumber , String keyword) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getBarang(pageNumber , keyword),
      getModelFromBody: GetListBarangMapper.getListBarangFromBody,
      isPagination: true,
    );
  }

  @override
  Future<ApiResponse> getDetailBarang({required int id}) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getDetailBarang(id: id),
      getModelFromBody: _getDetailBarangMapper.fromBodyToBarang,
    );
  }
}