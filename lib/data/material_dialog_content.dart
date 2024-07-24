import '../Constants/appStrings.dart';

class MaterialDialogContent {
  final String title;
  final String content;
  final String positiveText;
  final String negativeText;

  MaterialDialogContent(
      {required this.title,
      required this.content,
      this.positiveText = AppStrings.TRY_AGAIN,
      this.negativeText = AppStrings.CANCEL});

  MaterialDialogContent.networkError()
      : this(title: AppStrings.LIMITED_NETWORK_CONNECTION, content: AppStrings.LIMITED_NETWORK_CONNECTION_CONTENT);

  MaterialDialogContent copyWith({String? title}) =>
      MaterialDialogContent(title: title ?? this.title, content: content);

  @override
  String toString() {
    return 'MaterialDialogContent{title: $title, content: $content, positiveText: $positiveText, negativeText: $negativeText}';
  }
}
