import 'package:formz/formz.dart';

enum DefaultValidationError { invalid }

class DefaultValidator extends FormzInput<String?, DefaultValidationError> {
  const DefaultValidator.pure() : super.pure('');

  const DefaultValidator.dirty([String? value = '']) : super.dirty(value);

  @override
  DefaultValidationError? validator(String? value) {
    return value!.length > 0 ? null : DefaultValidationError.invalid;
  }
}