import 'package:equatable/equatable.dart';

/// A signature project, modelled as a case study rather than a card:
/// problem → challenge → architecture → impact.
class Project extends Equatable {
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
    this.tagline,
    this.role,
    this.year,
    this.problem,
    this.architecture,
    this.impact = const [],
    this.metrics = const [],
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
    this.stars,
    this.isHighlighted = false,
  });

  final String id;
  final String title;

  /// One-line positioning shown under the title.
  final String? tagline;
  final String? role;
  final String? year;

  /// Short summary (used in compact cards / fallbacks).
  final String description;

  /// Case-study narrative blocks (null on minor projects).
  final String? problem;
  final String? architecture;

  /// Outcome bullets (qualitative).
  final List<String> impact;

  /// Headline metrics as [value, label] pairs, e.g. ['50K+', 'active users'].
  final List<List<String>> metrics;

  final List<String> techStack;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? githubUrl;
  final int? stars;
  final bool isHighlighted;

  bool get hasPlayStore => playStoreUrl != null && playStoreUrl!.isNotEmpty;
  bool get hasAppStore => appStoreUrl != null && appStoreUrl!.isNotEmpty;
  bool get hasGithub => githubUrl != null && githubUrl!.isNotEmpty;
  bool get isCaseStudy => problem != null && architecture != null;

  @override
  List<Object?> get props => [
        id,
        title,
        tagline,
        role,
        year,
        description,
        problem,
        architecture,
        impact,
        metrics,
        techStack,
        playStoreUrl,
        appStoreUrl,
        githubUrl,
        stars,
        isHighlighted,
      ];
}
