abstract class ConverterEvent {
  final String value;

  const ConverterEvent(this.value);
}

class ConvertValueToKgEvent extends ConverterEvent {
  final String convertValue;

  ConvertValueToKgEvent({required this.convertValue}) : super(convertValue);
}

class ConvertValueToPoundEvent extends ConverterEvent {
  final String convertValue;

  ConvertValueToPoundEvent({required this.convertValue}) : super(convertValue);
}
