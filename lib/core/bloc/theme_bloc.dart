import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object?> get props => [];
}

class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

// State
class ThemeState extends Equatable {
  const ThemeState({required this.isDark});
  final bool isDark;

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  ThemeState copyWith({bool? isDark}) =>
      ThemeState(isDark: isDark ?? this.isDark);

  @override
  List<Object?> get props => [isDark];
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDark: false)) {
    on<ToggleTheme>((event, emit) {
      emit(state.copyWith(isDark: !state.isDark));
    });
  }
}
