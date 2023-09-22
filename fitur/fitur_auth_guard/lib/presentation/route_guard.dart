import 'package:common/domain/model/user.dart';
import 'package:common/presentation/provider/user_provider.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_auth_guard/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';

class RouteGuard extends StatelessWidget {
  final Widget displayedPage;
  const RouteGuard({
    super.key , required this.displayedPage
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context , provider , child) {
        return FutureBuilder(
          future: provider.getUserResponse,
          builder: (context , snapshot){
            if (snapshot.hasData){
              final data = snapshot.data!;

              if (data is ApiResponseFailed){
                // berarti gagal tersambung ke server
                if (data.statusCode == null){
                  return Scaffold(
                    body: DefaultErrorWidget(
                      onTap: provider.refresh,
                      errorMessage: data.error.toString(),
                    ),
                  );
                }
                // Berarti local token (dari shared-pref) sekarang enggak valid
                else if (data.statusCode == 401){
                  return LoginScreen();
                }
                else {
                  throw Exception('Get Current User ngedapetin status yang enggak diketahui');
                }
              }
              else if (data is ApiResponseSuccess<User>){
                return displayedPage;
              }
              else { throw Exception('Unknown Api Response Route Guard'); }

            }
            else {
              return Scaffold(body: const Center(child: CircularProgressIndicator(),));
            }
          }
        );
      }
    );
  }
}
