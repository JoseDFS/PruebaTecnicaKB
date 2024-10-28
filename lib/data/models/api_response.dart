class ApiResponse {
  bool completed = false;
  bool wasTimeout = false;
  bool hasError = false;
  bool showError = false;
  bool showProgress = true;
  Exception? exception;
  int statusCode = 500;
  int timeout = 30;
  String strResponse = '';
  String errorTechMessage = '';
  String errorUserMessage = '';
  String encryptedResponse = '';
  List<int> okCodes = [200];

  Map<String, dynamic> toMap() => _$ApiResponsetoMap(this);

  Map<String, dynamic> _$ApiResponsetoMap(ApiResponse instance) =>
      <String, dynamic>{
        'completed': instance.completed,
        'wasTimeout': instance.wasTimeout,
        'hasError': instance.hasError,
        'statusCode': instance.statusCode,
        'strResponse': instance.strResponse,
        'encryptedResponse': instance.encryptedResponse,
        'errorTechMessage': instance.errorTechMessage,
        'userErrorMessage': instance.errorUserMessage,
        'okCodes': instance.okCodes,
        'timeout': instance.timeout,
      };
}
