import 'package:bloc/bloc.dart';
import 'package:converter_app/bloc/converter_event.dart';
import 'package:converter_app/bloc/converter_state.dart';
import 'package:converter_app/constants.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  ConverterBloc() : super(ConvertedToKgState(validValue: "")) {
    on<ConvertValueToKgEvent>((event, emit) {
      double? value = double.tryParse(event.convertValue);

      if (event.convertValue.isEmpty) {
        emit(ConvertedToKgState(validValue: event.convertValue));
      } else if (value != null) {
        value = value / kgToLbValue;
        emit(ConvertedToKgState(validValue: value.toStringAsFixed(1)));
      } else {
        emit(ConverterInvalidState(inValidValue: event.convertValue));
      }
    });
    on<ConvertValueToPoundEvent>((event, emit) {
      double? value = double.tryParse(event.convertValue);

      if (event.convertValue.isEmpty) {
        emit(ConvertedToPoundState(validValue: event.convertValue));
      } else if (value != null) {
        value = value * kgToLbValue;
        emit(ConvertedToPoundState(validValue: value.toStringAsFixed(1)));
      } else {
        emit(ConverterInvalidState(inValidValue: event.convertValue));
      }
    });
  }
}
