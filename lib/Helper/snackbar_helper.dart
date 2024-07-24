import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as flutter_widgets;
import '../Constants/colors.dart';
import '../data/snackbar_message.dart';
import '../widgets/flushbar.dart';

class SnackbarHelper {
  static SnackbarHelper? _instance;

  SnackbarHelper._internal();

  static SnackbarHelper instance() {
    _instance ??= SnackbarHelper._internal();
    return _instance!;
  }

  Flushbar? _lastFlushbar;
  flutter_widgets.BuildContext? _context;

  void injectContext(BuildContext context) => _context = context;

  void showSnackbar({required SnackbarMessage snackbarMessage, EdgeInsets margin = const EdgeInsets.all(8)}) async {
    final context = _context;
    if (context == null) return;

    final tempLastFlushbar = _lastFlushbar;
    if (tempLastFlushbar != null && tempLastFlushbar.isShowing()) {
      await tempLastFlushbar.dismiss();
    }

    // bool flag = true;
    _lastFlushbar = Flushbar(
        animationDuration: const Duration(milliseconds: 850),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        duration: snackbarMessage.duration,
        messageText: Text(snackbarMessage.content,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15)),
        margin: margin,
        shouldIconPulse: false,
        mainButton: null,
        leftBarIndicatorColor: snackbarMessage.isForError ? red : null,
        onStatusChanged: (status) {
          // if (status == FlushbarStatus.DISMISSED && flag) onDismissClosure?.call(snackbarMessage.action);
        },
        backgroundColor: black,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        icon: _getSnackbarIcon(snackbarMessage.isForError),
        borderWidth: 0.9,
        borderColor: primary);
    // ignore: use_build_context_synchronously
    _lastFlushbar?.show(context);
  }

  Widget? _getSnackbarIcon(bool isForError) {
    if (isForError) {
      return Icon(CupertinoIcons.info_circle_fill, color: red, size: 24);
    }
    return null;
  }
}
