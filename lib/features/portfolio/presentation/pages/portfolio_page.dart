import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/usecases/get_portfolio_data.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../bloc/portfolio_bloc.dart';
import '../bloc/portfolio_event.dart';
import '../widgets/footer_widget.dart';
import '../widgets/nav_bar.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/architecture_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/vision_section.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PortfolioBloc(
        getPortfolioData: GetPortfolioData(
          const PortfolioRepositoryImpl(),
        ),
      )..add(const LoadPortfolioData()),
      child: const _PortfolioView(),
    );
  }
}

class _PortfolioView extends StatefulWidget {
  const _PortfolioView();

  @override
  State<_PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<_PortfolioView> {
  final ScrollController _scrollController = ScrollController();
  String? _activeSection;

  final Map<String, GlobalKey> _sectionKeys = {
    AppConstants.sectionHero: GlobalKey(),
    AppConstants.sectionStory: GlobalKey(),
    AppConstants.sectionExperience: GlobalKey(),
    AppConstants.sectionWork: GlobalKey(),
    AppConstants.sectionArchitecture: GlobalKey(),
    AppConstants.sectionSkills: GlobalKey(),
    AppConstants.sectionVision: GlobalKey(),
    AppConstants.sectionContact: GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSectionVisibilityChanged(String sectionId, double visibleFraction) {
    if (visibleFraction > 0.3 && _activeSection != sectionId) {
      setState(() => _activeSection = sectionId);
    }
  }

  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    final ctx = key?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 760),
      curve: Curves.easeInOutCubic,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      alignment: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: NavBar(
        onNavTap: _scrollToSection,
        activeSection: _activeSection,
        scrollController: _scrollController,
      ),
      drawer: AppDrawer(
        onNavTap: _scrollToSection,
        activeSection: _activeSection,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _track(
              AppConstants.sectionHero,
              HeroSection(
                key: _sectionKeys[AppConstants.sectionHero],
                onPrimaryCta: () =>
                    _scrollToSection(AppConstants.sectionWork),
                onSecondaryCta: () =>
                    _scrollToSection(AppConstants.sectionContact),
              ),
            ),
            _track(
              AppConstants.sectionStory,
              AboutSection(key: _sectionKeys[AppConstants.sectionStory]),
            ),
            _track(
              AppConstants.sectionExperience,
              ExperienceSection(
                  key: _sectionKeys[AppConstants.sectionExperience]),
            ),
            _track(
              AppConstants.sectionWork,
              ProjectsSection(key: _sectionKeys[AppConstants.sectionWork]),
            ),
            _track(
              AppConstants.sectionArchitecture,
              ArchitectureSection(
                  key: _sectionKeys[AppConstants.sectionArchitecture]),
            ),
            _track(
              AppConstants.sectionSkills,
              SkillsSection(key: _sectionKeys[AppConstants.sectionSkills]),
            ),
            _track(
              AppConstants.sectionVision,
              VisionSection(key: _sectionKeys[AppConstants.sectionVision]),
            ),
            _track(
              AppConstants.sectionContact,
              ContactSection(key: _sectionKeys[AppConstants.sectionContact]),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _track(String sectionId, Widget child) {
    return VisibilityDetector(
      key: Key('nav-tracker-$sectionId'),
      onVisibilityChanged: (info) =>
          _onSectionVisibilityChanged(sectionId, info.visibleFraction),
      child: child,
    );
  }
}
