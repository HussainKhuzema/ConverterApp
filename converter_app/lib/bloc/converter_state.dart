abstract class ConverterState {
  final String value;

  const ConverterState(this.value);
}

class ConvertedToKgState extends ConverterState {
  final String validValue;
  ConvertedToKgState({required this.validValue}) : super(validValue);
}

class ConvertedToPoundState extends ConverterState {
  final String validValue;
  ConvertedToPoundState({required this.validValue}) : super(validValue);
}

class ConverterInvalidState extends ConverterState {
  final String inValidValue;
  ConverterInvalidState({required this.inValidValue}) : super(inValidValue);
}
