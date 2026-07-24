import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/core/network/helpers/base_api_result.dart';
import 'package:event_booking/core/network/helpers/base_notifier.dart';
import 'package:event_booking/features/auth/domain/entities/user_entity.dart';
import 'package:event_booking/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/login_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/logout_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter/material.dart';

class LAuthProvider extends BaseNotifier {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;

  LAuthProvider({
    required this.registerUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.getCurrentUserUsecase,
  });

  BaseApiResult<UserEntity?> authResult = BaseApiResult();

  UserEntity? get currentUser => authResult.data;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    VoidCallback? onSuccess,
    ValueChanged<String>? onError,
  }) async {
    try {
      setIsLoading(authResult);

      final currentUser = await registerUsecase.register(
        name: name,
        email: email,
        password: password,
      );

      setIsCompleted(authResult, currentUser);
      onSuccess?.call();
    } on AppException catch (e) {
      setIsError(authResult, e.message);
      onError?.call(e.message);
    } catch (e) {
      setIsError(authResult, e.toString());
      onError?.call(e.toString());
    }
  }

  Future<void> login({
    required String email,
    required String password,
    VoidCallback? onSuccess,
    ValueChanged<String>? onError,
  }) async {
    try {
      setIsLoading(authResult);

      final user = await loginUsecase.login(email: email, password: password);

      setIsCompleted(authResult, user);
      onSuccess?.call();
    } on AppException catch (e) {
      setIsError(authResult, e.message);
      onError?.call(e.message);
    } catch (e) {
      setIsError(authResult, e.toString());
      onError?.call(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      setIsLoading(authResult);

      await logoutUsecase.logout();

      authResult.reset();

      setIsCompleted(authResult, null);
    } catch (e) {
      setIsError(authResult, e.toString());
    }
  }

  Future<void> getCurrentUser() async {
    try {
      setIsLoading(authResult);

      final user = await getCurrentUserUsecase.getCurrentUser();

      setIsCompleted(authResult, user);
    } catch (e) {
      setIsError(authResult, e.toString());
    }
  }
}
