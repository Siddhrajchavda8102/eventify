import 'package:event_booking/app/app/all_providers.dart';
import 'package:event_booking/core/router/app_router.dart';
import 'package:event_booking/shared/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  App({super.key});

  final allProviders = AllProviders();
  final GoRouter router = AppRouter.createRoute();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders.getAllProvider(),
      child: ToastificationWrapper(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
