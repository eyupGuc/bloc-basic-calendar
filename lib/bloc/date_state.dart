part of 'date_bloc.dart';

@immutable
abstract class DateState {
  DateTime date;

  DateState({required this.date});
}

class DateInitial extends DateState {
  DateInitial({required DateTime currentDate}) : super(date: currentDate);
}

class MyDateState extends DateState{
  MyDateState({required DateTime date}):super(date: date);

}
