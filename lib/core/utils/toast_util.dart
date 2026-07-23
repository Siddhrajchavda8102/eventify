import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  //
  void showSuccessToast({
    Widget? title,
    required Widget? description,
    ToastificationStyle? style = ToastificationStyle.fillColored,
    AlignmentGeometry? alignment = Alignment.bottomCenter,
    Duration? autoCloseDuration,
    BorderRadiusGeometry? borderRadius,
    bool? showProgressBar,
    bool? closeOnClick,
    bool? dragToClose,
    bool? showIcon,
  }) {
    ToastUtils().dismissAllToast();
    toastification.show(
      type: ToastificationType.success,
      style: style,
      title: title,
      description: description,
      alignment: alignment,
      autoCloseDuration: Duration(seconds: 5),
      borderRadius: borderRadius,
      showProgressBar: showProgressBar,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      showIcon: showIcon,
    );
  }

  void showInfoToast({
    Widget? title,
    required Widget? description,
    ToastificationStyle? style = ToastificationStyle.fillColored,
    AlignmentGeometry? alignment = Alignment.bottomCenter,
    BorderRadiusGeometry? borderRadius,
    bool? showProgressBar,
    bool? closeOnClick,
    bool? dragToClose,
    bool? showIcon,
  }) {
    ToastUtils().dismissAllToast();
    toastification.show(
      type: ToastificationType.info,
      style: style,
      title: title,
      description: description,
      alignment: alignment,
      autoCloseDuration: Duration(seconds: 5),
      borderRadius: borderRadius,
      showProgressBar: showProgressBar,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      showIcon: showIcon,
    );
  }

  void showErrorToast({
    Widget? title,
    required Widget? description,
    ToastificationStyle? style,
    AlignmentGeometry? alignment = Alignment.bottomCenter,
    Duration? autoCloseDuration,
    BorderRadiusGeometry? borderRadius,
    bool? showProgressBar,
    bool? closeOnClick,
    bool? dragToClose,
    bool? showIcon,
    ToastCloseButton closeButton = const ToastCloseButton(),
  }) {
    ToastUtils().dismissAllToast();

    toastification.show(
      type: ToastificationType.error,
      style: style,
      title: title,
      description: description,
      alignment: alignment,
      autoCloseDuration: autoCloseDuration ?? Duration(seconds: 5),
      borderRadius: borderRadius,
      showProgressBar: showProgressBar,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      showIcon: showIcon,
      closeButton: closeButton,
    );
  }

  void showWarningToast({
    Widget? title,
    required Widget? description,
    ToastificationStyle? style,
    AlignmentGeometry? alignment = Alignment.center,
    Duration? autoCloseDuration,
    BorderRadiusGeometry? borderRadius,
    bool? showProgressBar,
    bool? closeOnClick,
    bool? dragToClose,
    bool? showIcon,
    ToastCloseButton closeButton = const ToastCloseButton(),
  }) {
    ToastUtils().dismissAllToast();
    toastification.show(
      type: ToastificationType.warning,
      style: style,
      title: title,
      description: description,
      alignment: alignment,
      autoCloseDuration: autoCloseDuration,
      borderRadius: borderRadius,
      showProgressBar: showProgressBar,
      closeOnClick: closeOnClick,
      dragToClose: dragToClose,
      showIcon: showIcon,
      closeButton: closeButton,
    );
  }

  void showNoInternetConnectionToast() {
    ToastUtils().showErrorToast(
      style: ToastificationStyle.fillColored,
      // title: Text("Component updates available."),
      description: Text("No Internet Connection"),
      alignment: Alignment.bottomCenter,
      // autoCloseDuration: const Duration(seconds: 4),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      borderRadius: BorderRadius.circular(12.0),
      dragToClose: false,
    );
  }

  void dismissAllToast() {
    toastification.dismissAll();
  }
}
