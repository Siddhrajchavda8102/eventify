enum ApiStatus { idle, loading, completed, error }

class BaseApiResult<T> {
  ApiStatus status;
  T? data;
  String? errMessage;

  BaseApiResult({this.status = ApiStatus.idle, this.data, this.errMessage});

  bool get isIdle => status == ApiStatus.idle;
  bool get isLoading => status == ApiStatus.loading;
  bool get isCompleted => status == ApiStatus.completed;
  bool get isError => status == ApiStatus.error;

  void reset() {
    status = ApiStatus.idle;
    data = null;
    errMessage = null;
  }
}
