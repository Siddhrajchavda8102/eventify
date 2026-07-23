import 'package:event_booking/core/router/app_routes.dart';
import 'package:event_booking/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSession();
    });
  }

  Future<void> _checkSession() async {
    final provider = context.read<LAuthProvider>();

    await Future.wait([
      provider.getCurrentUser(),
      Future.delayed(const Duration(seconds: 2)),
    ]);

    if (!mounted) return;

    if (provider.currentUser != null) {
      context.goNamed(Routes.homeName);
    } else {
      context.goNamed(Routes.loginName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Eventify",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
