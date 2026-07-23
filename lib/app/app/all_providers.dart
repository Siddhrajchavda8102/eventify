import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking/core/network/dio/api_client.dart';
import 'package:event_booking/features/auth/data/datasource/auth_remote_data_sorce.dart';
import 'package:event_booking/features/auth/data/repository/auth_repository_impl.dart';
import 'package:event_booking/features/auth/domain/repository/auth_repository.dart';
import 'package:event_booking/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/login_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/logout_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/register_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';

class AllProviders {
  late final ApiClient apiClient;

  late final FirebaseAuth firebaseAuth;
  late final FirebaseFirestore firebaseFirestore;

  /// DataSources
  late AuthRemoteDataSource authRemoteDataSource;

  /// Repo
  late AuthRepository authRepository;

  /// usecases
  late RegisterUsecase registerUsecase;
  late LoginUsecase loginUsecase;
  late GetCurrentUserUsecase getCurrentUserUsecase;
  late LogoutUsecase logoutUsecase;

  /// Providers
  late LAuthProvider authProvider;

  AllProviders() {
    apiClient = ApiClient();

    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;

    /// datasources
    authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth,
      firebaseFirestore,
    );

    /// Repos
    authRepository = AuthRepositoryImpl(
      authRemoteDataSource: authRemoteDataSource,
    );

    /// Usecases
    registerUsecase = RegisterUsecase(authRepository: authRepository);
    loginUsecase = LoginUsecase(authRepository: authRepository);
    logoutUsecase = LogoutUsecase(authRepository: authRepository);
    getCurrentUserUsecase = GetCurrentUserUsecase(
      authRepository: authRepository,
    );

    authProvider = LAuthProvider(
      registerUsecase: registerUsecase,
      loginUsecase: loginUsecase,
      logoutUsecase: logoutUsecase,
      getCurrentUserUsecase: getCurrentUserUsecase,
    );
  }

  List<SingleChildWidget> getAllProvider() {
    return [ChangeNotifierProvider(create: (context) => authProvider)];
  }
}
