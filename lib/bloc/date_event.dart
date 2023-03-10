part of 'date_bloc.dart';

@immutable
abstract class DateEvent {
  DateTime date;

  DateEvent({required this.date});
}

class NewDateEvent extends DateEvent{
  DateTime date;

  NewDateEvent({required this.date}):super(date: date);
}