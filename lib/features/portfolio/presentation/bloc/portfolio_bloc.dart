import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_portfolio_data.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc({required GetPortfolioData getPortfolioData})
      : _getPortfolioData = getPortfolioData,
        super(const PortfolioInitial()) {
    on<LoadPortfolioData>(_onLoadPortfolioData);
  }

  final GetPortfolioData _getPortfolioData;

  Future<void> _onLoadPortfolioData(
    LoadPortfolioData event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const PortfolioLoading());
    try {
      final experiences = _getPortfolioData.getExperiences();
      final projects = _getPortfolioData.getProjects();
      final skillCategories = _getPortfolioData.getSkillCategories();
      emit(PortfolioLoaded(
        experiences: experiences,
        projects: projects,
        skillCategories: skillCategories,
      ));
    } catch (e) {
      emit(PortfolioError(message: e.toString()));
    }
  }
}
