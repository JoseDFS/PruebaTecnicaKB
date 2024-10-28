class GenericSuccessResponse {
  GenericSuccessResponse(
      {this.userMessage, this.statusCode, this.responseCode, this.data});

  final String? userMessage;
  final String? statusCode;
  final int? responseCode;
  final Map<String, dynamic>? data;
}
