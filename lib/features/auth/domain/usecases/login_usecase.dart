import 'package:event_booking/features/auth/domain/entities/user_entity.dart';
import 'package:event_booking/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async => await authRepository.login(email: email, password: password);
}
