import 'package:event_booking/core/network/helpers/base_api_result.dart';
import 'package:event_booking/shared/state/reset_data_registry.dart';
import 'package:flutter/widgets.dart';

class BaseNotifier extends ChangeNotifier {
  BaseNotifier() {
    ResetDataRegistry.register(this);
  }

  void setIsLoading(BaseApiResult result) {
    result.status = ApiStatus.loading;
    result.data = null;
    result.errMessage = null;
    notifyListeners();
  }

  void setIsCompleted<T>(BaseApiResult<T> result, T? data) {
    result.status = ApiStatus.completed;
    result.data = data;
    notifyListeners();
  }

  void setIsError(BaseApiResult result, String err) {
    result.status = ApiStatus.error;
    result.errMessage = err;
    notifyListeners();
  }

  void resetState() {}

  @override
  void dispose() {
    ResetDataRegistry.unregister(this);
    super.dispose();
  }
}
