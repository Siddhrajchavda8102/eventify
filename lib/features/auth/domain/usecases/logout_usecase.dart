import 'package:event_booking/features/auth/domain/repository/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  Future<void> logout() async => await authRepository.logout();
}
