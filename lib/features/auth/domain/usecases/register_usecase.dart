import 'package:event_booking/features/auth/domain/entities/user_entity.dart';
import 'package:event_booking/features/auth/domain/repository/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async => await authRepository.register(
    name: name,
    email: email,
    password: password,
  );
}
