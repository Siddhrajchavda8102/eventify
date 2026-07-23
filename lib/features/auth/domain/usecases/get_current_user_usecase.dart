import 'package:event_booking/features/auth/domain/entities/user_entity.dart';
import 'package:event_booking/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUsecase {
  final AuthRepository authRepository;

  GetCurrentUserUsecase({required this.authRepository});

  Future<UserEntity?> getCurrentUser() async =>
      await authRepository.getCurrentUser();
}
