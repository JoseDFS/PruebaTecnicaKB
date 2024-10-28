
import 'package:prueba_tecnica_kb/data/models/error_model.dart';

class EitherModel<T> {
  EitherModel.right(T el) {
    _left = null;
    _right = el;
  }

  EitherModel.left(ErrorModel error) {
    _left = error;
    _right = null;
  }

  ErrorModel? _left;
  T? _right;

  ErrorModel? get left => _left;
  T? get right => _right;

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
