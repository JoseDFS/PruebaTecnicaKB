class ErrorModel {
  ErrorModel({
    this.userMessage = '',
    this.errorMessage = '',
    this.technicalMessage = '',
    required this.statusCode,
    this.responseCode = 0,
    this.exception,
  });

  final String? userMessage;
  final String? errorMessage;
  final String? technicalMessage;
  final String statusCode;
  final int? responseCode;
  final Exception? exception;

  Map<String, dynamic> toMap() {
    return {
      'userMessage': userMessage,
      'statusCode': statusCode,
      'responseCode': responseCode,
      'exception': exception,
    };
  }
}
