import 'package:common/response/api_response.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';
import 'package:fitur_input_pengajuan/domain/use_case/null_validation_use_case.dart';
import 'package:flutter/material.dart';

class MainFormProvider extends ChangeNotifier {
  final _nullValidator = NullValidationUseCase();
  final ISubmitPengajuanRepository _repository;
  final int? _id;

  MainFormProvider({
    required Pengajuan initialData,
    required ISubmitPengajuanRepository repository
  })  :
    _repository = repository,
    _id = initialData.id,
    tanggal = initialData.tanggal,
    jam = TimeOfDay.fromDateTime(initialData.tanggal),
    isPemasukan = initialData.pengaju?.isPemasok,
    _group = initialData.pengaju?.isPemasok == false ? initialData.pengaju : null,
    _pemasok = initialData.pengaju?.isPemasok == true ? initialData.pengaju : null,
    listBarangTransaksi = initialData.listBarangTransaksi;

  DateTime tanggal;
  TimeOfDay jam;
  bool? isPemasukan;
  final tipePengajuanList = const ['Pemasukan' , 'Pengeluaran'];
  String? get currentTipePengajuan {
    if (isPemasukan == null) {
      return null;
    } else if (isPemasukan == true) {
      return tipePengajuanList[0];
    } else {
      return tipePengajuanList[1];
    }
  }

  Pengaju? _group;
  Pengaju? get group => _group;
  void onChangeGroup(Pengaju newGroup) {
    _group = newGroup;
    notifyListeners();
  }
  Pengaju? _pemasok;
  Pengaju? get pemasok => _pemasok;
  void onChangePemasok(Pengaju newPemasok){
    _pemasok = newPemasok;
    notifyListeners();
  }

  List<BarangTransaksi> listBarangTransaksi;

  String? tanggalError;
  String? jamError;
  String? tipePengajuanError;
  String? namaPemasokError;
  String? groupError;
  String? pemasokError;

  ApiResponse? submitResponse;
  void Function()? get submit {
    if (submitResponse is ApiResponseLoading){
      return null;
    }
    return _submit;
  }
  void _submit() async {
    if (submitResponse is! ApiResponseLoading) {
      submitResponse = ApiResponseLoading();
      tipePengajuanError =
          _nullValidator(isPemasukan, fieldName: "Tipe pengajuan");
      if (isPemasukan == true) {
        pemasokError = _nullValidator(_pemasok, fieldName: "Nama pemasok");
      }
      else if (isPemasukan == false) {
        groupError = _nullValidator(_group, fieldName: "Group");
      }
      notifyListeners();

      if (listBarangTransaksi.isEmpty){
        Fluttertoast.showToast(
          msg: "Anda harus memilih minimal satu jenis barang!",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
        );
      }

      // kalo semua validasi lolos
      if (
        tipePengajuanError == null &&
        pemasokError == null &&
        groupError == null &&
        listBarangTransaksi.isNotEmpty
      ){
        submitResponse = await _repository.submitData(
          Pengajuan(
            id: _id,
            tanggal: tanggal,
            pengaju: isPemasukan! ? _pemasok : _group,
            listBarangTransaksi: listBarangTransaksi,
          )
        );

        if (submitResponse is ApiResponseFailed){
          debugPrint((submitResponse as ApiResponseFailed).error.toString());
          Fluttertoast.showToast(
            msg: (submitResponse as ApiResponseFailed).error.toString(),
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
          );
        }
      }
      else {
        submitResponse = null;
      }
      notifyListeners();
    }
  }

  void onTanggalChange(DateTime newValue){
    tanggal = newValue;
    notifyListeners();
  }
  void onJamChange(TimeOfDay newValue){
    jam = newValue;
    notifyListeners();
  }

  void Function(String?)? get onTipePengajuanChange {
    if (_id == null){
      return _onTipePengajuanChange;
    }
    return null;
  }

  void _onTipePengajuanChange(String? newValue){
    if (newValue != null){
      isPemasukan = newValue == tipePengajuanList[0];
      notifyListeners();
    }
  }
  void setNewListBarang(List<BarangTransaksi> newBarang) {
    listBarangTransaksi = newBarang;
    notifyListeners();
  }
  void deleteBarang(BarangTransaksi oldBarang) {
    listBarangTransaksi.remove(oldBarang);
    notifyListeners();
  }
}