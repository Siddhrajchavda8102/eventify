import 'package:event_booking/core/network/helpers/base_notifier.dart';

class ResetDataRegistry {
  static final List<BaseNotifier> _providers = [];

  static void register(BaseNotifier provider) => _providers.add(provider);
  static void unregister(BaseNotifier provider) => _providers.remove(provider);

  static void resetAll() {
    for (final p in _providers) {
      p.resetState();
    }
  }
}
