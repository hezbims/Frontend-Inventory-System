// ignore_for_file: unused_import

import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';
import 'package:fitur_buat_laporan/presentation/component/table/laporan_barang_summary_row.dart';
import 'package:pdf/widgets.dart';

Widget buildLaporanListBarangSummary({required List<TransaksiBarangSummary> data}){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ...data.map(
        (barang) => SizedBox()// LaporanBarangSummaryRow(data: barang),
      )
    ]
  );
}