import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/textfield/search_with_filter_app_bar.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/constant/routes/routes_path.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/pengajuan_card.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju_drawer.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class LihatPengajuanScreen extends StatelessWidget {
  const LihatPengajuanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<LihatPengajuanProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<FilterPengajuProvider>(),
        ),
      ],
      child: Consumer<LihatPengajuanProvider>(
        builder: (context , provider , child) {
          final routeStateProvider = context.read<MyRouteStateProvider>();
          return Scaffold(
            appBar: SearchWithFilterAppBar(
              label: "Cari transaksi ",
              hintText: "ex : TRXI20220914001",
              onFilterPressed: (context){
                Scaffold.of(context).openEndDrawer();
              },
              searchController: provider.searchController,
              onValueChange: (_) => provider.tryRefresh(),
            ),
            endDrawer: const FilterPengajuDrawer(),
            onEndDrawerChanged: (isOpened){
              if (!isOpened){
                final filterProvider = Provider.of<FilterPengajuProvider>(
                  context,
                  listen: false
                );
                provider.setFilterPengaju(filterProvider.pengajuDipilih);
              }
            },
            bottomNavigationBar: const StockBottomNavBar(
              currentIndex: RoutesPath.fiturLihatPengajuanIndex,
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).phoneLandscapePadding,
              ),
              child: FloatingActionButton(
                onPressed: () async {
                  routeStateProvider.setRouteState(
                    RouteInputPengajuanState(idPengajuan: null)
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
            body: PagedListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).phoneLandscapePadding,
                vertical: 24,
              ),
              pagingController: provider.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context , PengajuanPreview pengajuan , index){
                  return PengajuanCard(
                    pengajuan: pengajuan,
                    onTap: () async {
                      routeStateProvider.setRouteState(
                        RouteInputPengajuanState(idPengajuan: pengajuan.id)
                      );
                    },
                  );
                },
                firstPageErrorIndicatorBuilder: (context){
                  return DefaultErrorWidget(
                    onTap: provider.tryRefresh,
                    errorMessage: provider.pagingController.error.toString(),
                  );
                }
              ),
              separatorBuilder: (context , index){
                return const VerticalFormSpacing();
              },
            )
          );
        }
      ),
    );
  }
}
