abstract class Failure {
  final String msg;
  const Failure(this.msg);
}

class ServerFailure extends Failure {
  const ServerFailure(super.msg);
}

class NetworkException extends Failure {
  const NetworkException(super.msg);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
