part of 'autogen_cubit.dart';

@immutable
abstract class AutogenState {}

class AutogenInitial extends AutogenState {}
class AutogenLoadingState extends AutogenState {}
class AutogenSuccessState extends AutogenState {}
class AutogenErrorState extends AutogenState {}
