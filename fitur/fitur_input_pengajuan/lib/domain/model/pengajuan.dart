import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';

class Pengajuan {
  final int? id;

  // tanggal dibuatnya pengajuan ini
  final DateTime tanggal;

  final Pengaju? pengaju;

  final List<BarangTransaksi> listBarangTransaksi;
  Pengajuan({
    required this.id,
    required this.tanggal,
    required this.pengaju,
    this.listBarangTransaksi = const [],
  });
}