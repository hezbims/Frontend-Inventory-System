import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/textfield/search_with_filter_app_bar.dart';
import 'package:common/constant/routes/routes_path.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:dependencies/font_awesome_flutter.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/kategori_filter_drawer.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/list_stock_barang.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/kategori_filter_provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';
import 'package:flutter/material.dart';

class LihatStockBarangScreen extends StatelessWidget {
  const LihatStockBarangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<LihatStockBarangProvider>()
        ),
        ChangeNotifierProvider(
          create: (context) =>  GetIt.I.get<KategoriFilterProvider>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final stockBarangProvider = context.read<LihatStockBarangProvider>();

          // Mengobserve perubahanan apabila notifylistener dipanggil pada KategoriFilterProvider
          context.select<KategoriFilterProvider , void>(
            (kategoriFilterProvider) =>
              stockBarangProvider.setChoosenIdKategori(
                kategoriFilterProvider.choosenKategori.id
              ),
          );

          return Scaffold(
            endDrawerEnableOpenDragGesture: false,
            endDrawer: const KategoriFilterDrawer(),
            appBar: SearchWithFilterAppBar(
              label: "Cari nama barang",
              onFilterPressed: (context){
                Scaffold.of(context).openEndDrawer();
              },
              searchController: stockBarangProvider.searchController,
              onValueChange: (newValue) =>
                  stockBarangProvider.tryRefreshPagination(),
            ),
            floatingActionButton: GetIt.I.get<User>().isAdmin ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).phoneLandscapePadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: 'fab-+',
                    onPressed: () async {
                      final result = await Navigator.of(context).pushNamed(
                          RoutesPath.inputDataBarangPath('add')
                      );

                      if (result != null){
                        stockBarangProvider.tryRefreshPagination();
                      }
                    },
                    child: const FaIcon(FontAwesomeIcons.one),
                  ),

                  const SizedBox(height: 12,),

                  FloatingActionButton(
                    onPressed: () async {
                      final result = await Navigator.of(context).pushNamed(
                          RoutesPath.inputDataBarangByCsvPath
                      );

                      if (result != null){
                        stockBarangProvider.tryRefreshPagination();
                      }
                    },
                    child: const FaIcon(FontAwesomeIcons.fileCsv),
                  ),
                ],
              ),
            ) : null,
            bottomNavigationBar: const StockBottomNavBar(
              currentIndex: RoutesPath.lihatStockBarangIndex,
            ),
            body: ListStockBarang(provider: stockBarangProvider),
          );
        }
      ),
    );
  }
}