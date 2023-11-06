import 'dart:convert';

import 'package:fitur_input_data_barang/domain/model/submit_barang_dto.dart';

class SubmitBarangMapper {
  Map<String , String?> getAllError(String body){
    final jsonBody = jsonDecode(body);

    final errors = jsonBody['data'];

    return {
      SubmitBarangDto.kolomNama : errors[SubmitBarangDto.kolomNama]?[0],
      SubmitBarangDto.kolomMinStock : errors[SubmitBarangDto.kolomMinStock]?[0],
      SubmitBarangDto.kolomNomorRak : errors[SubmitBarangDto.kolomNomorRak]?[0],
      SubmitBarangDto.kolomNomorLaci : errors[SubmitBarangDto.kolomNomorLaci]?[0],
      SubmitBarangDto.kolomNomorKolom : errors[SubmitBarangDto.kolomNomorKolom]?[0],
      SubmitBarangDto.kolomLastMonthStock : errors[SubmitBarangDto.kolomLastMonthStock]?[0],
      SubmitBarangDto.kolomStockSekarang : errors[SubmitBarangDto.kolomStockSekarang]?[0],
      SubmitBarangDto.kolomUnitPrice : errors[SubmitBarangDto.kolomUnitPrice]?[0],
      SubmitBarangDto.kolomIdKategori : errors[SubmitBarangDto.kolomIdKategori]?[0],
      SubmitBarangDto.kolomUom : errors[SubmitBarangDto.kolomUom]?[0],

    };
  }
}