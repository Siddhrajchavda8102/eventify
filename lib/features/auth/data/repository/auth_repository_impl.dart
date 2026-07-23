import 'package:event_booking/features/auth/data/datasource/auth_remote_data_sorce.dart';
import 'package:event_booking/features/auth/domain/entities/user_entity.dart';
import 'package:event_booking/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userModel = await authRemoteDataSource.getCurrentUser();
    return userModel?.toEntity();
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userModel = await authRemoteDataSource.login(
      email: email,
      password: password,
    );

    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    return await authRemoteDataSource.logout();
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userModel = await authRemoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );

    return userModel.toEntity();
  }
}
