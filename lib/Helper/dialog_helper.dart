import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as flutter_widgets;
import '../Constants/colors.dart';
import '../data/material_dialog_content.dart';
import '../widgets/button.dart';

class DialogHelper {
  static DialogHelper? _instance;

  DialogHelper._();

  static DialogHelper instance() {
    _instance ??= DialogHelper._();
    return _instance!;
  }

  flutter_widgets.BuildContext? _context;

  bool get isProgressShowing => _context != null;

  void injectContext(BuildContext context) => _context = context;

  void dismissProgress({BuildContext? context}) {
    final tempContext = context ?? _context;
    if (tempContext == null) return;
    Navigator.pop(tempContext);
    _context = null;
  }

  void showTitleContentDialog(MaterialDialogContent dialogContent, VoidCallback positiveClosure,
      {VoidCallback? negativeClosure}) {
    final context = _context;
    if (context == null) return;
    showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
              child: AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                  content: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(dialogContent.title,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white12))),
                            const SizedBox(height: 20),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(dialogContent.content,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white10, fontSize: 14))),
                            const SizedBox(height: 20),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: MyButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          positiveClosure.call();
                                        },
                                        name: dialogContent.positiveText,
                                        color: primary))),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  negativeClosure?.call();
                                },
                                child: Text(dialogContent.negativeText,
                                    style: TextStyle(
                                        color: Colors.black, decoration: TextDecoration.underline, fontSize: 14))),
                            const SizedBox(height: 25)
                          ]))),
              onWillPop: () async => false);
        });
  }

  void showProgressDialog(String progressContent) {
    final context = _context;
    if (context == null) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            child: Dialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(strokeWidth: 2),
                          const SizedBox(width: 15),
                          Text(progressContent, style: TextStyle(color: Colors.black, fontSize: 15))
                        ]))),
            onWillPop: () async => false));
  }
}
