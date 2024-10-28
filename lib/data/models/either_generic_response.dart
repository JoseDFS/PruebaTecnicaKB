
import 'package:prueba_tecnica_kb/data/models/error_model.dart';
import 'package:prueba_tecnica_kb/data/models/generic_success_response.dart';

class EitherGenericResponse {
  ErrorModel? _left;
  GenericSuccessResponse? _right;

  ErrorModel? get left => _left;
  GenericSuccessResponse? get right => _right;

  EitherGenericResponse.right(GenericSuccessResponse successResponse) {
    _right = successResponse;
  }

  EitherGenericResponse.left(ErrorModel error) {
    _right = null;
    _left = error;
  }

  bool isLeft() {
    if (_left != null && _right == null) {
      return true;
    }
    return false;
  }

  bool isRight() {
    if (_right != null && _left == null) {
      return true;
    }
    return false;
  }
}
