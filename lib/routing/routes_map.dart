import 'package:common/presentation/dependency_setup/pilih_kategori_dependency_setup.dart';
import 'package:common/constant/routes/routes.dart';
import 'package:fitur_auth_guard/dependency_setup/login_dependency_setup.dart';
import 'package:fitur_buat_laporan/dependency_setup/preview_laporan_dependency_setup.dart';
import 'package:fitur_buat_laporan/presentation/page/pilih_bulan_tahun_page.dart';
import 'package:fitur_input_data_barang/dependency_setup/input_data_barang_dependency_setup.dart';
import 'package:fitur_input_pengajuan/dependency_setup/input_data_pengajuan_page_setup.dart';
import 'package:fitur_input_pengajuan/dependency_setup/pilih_pengaju_dependency_setup.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_list_barang_page.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_pages.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:fitur_setting_akun/dependency_setup/setting_akun_page_dependency_setup.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:flutter/material.dart';

final Map<String , Widget Function(RouteSettings)> routesMap = {
  Routes.initialRoute : (settings) => GetItDependencySetup(
      setup: (){},
      disposeFunction: (){},
      page: const LihatStockBarangPage()
  ),
  Routes.fiturLihatStockBarangRoute : (settings) => GetItDependencySetup(
      setup: (){},
      disposeFunction: (){},
      page: const LihatStockBarangPage()
  ),
  Routes.fiturInputDataBarangRoute : (settings) =>
    InputDataBarangDependencySetup(settings: settings),
  Routes.fiturPilihKategoriRoute : (settings) => GetItDependencySetup(
      setup: (){},
      disposeFunction: (){},
      page: PilihKategoriDependencySetup()
  ),
  Routes.fiturLihatPengajuanRoute : (settings) => GetItDependencySetup(
      setup: (){},
      disposeFunction: (){},
      page: const LihatPengajuanPages()
  ),
  Routes.fiturInputDataPengajuanRoute : (settings) =>
      InputDataPengajuanPageSetup(),
  Routes.fiturInputListBarangRoute : (settings) =>
    const PilihListBarangPage(),
  Routes.fiturPilihGroupRoute : (settings) =>
    PilihPengajuDependencySetup(settings: settings),
  Routes.fiturBuatLaporanRoute : (settings) => GetItDependencySetup(
      setup: (){},
      disposeFunction: (){},
      page: const PilihTahunBulanPage()
  ),
  Routes.previewLaporanRoute : (settings) =>
      PreviewLaporanDependencySetup(settings: settings),
  Routes.settingAkunRoute : (settings) =>
      SettingAkunPageDependencySetup(),
  Routes.loginRoute : (settings) => GetItDependencySetup(
      setup: (){},
      disposeFunction: (){},
      page: LoginDependencySetup()
  ),
};