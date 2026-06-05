class AppConstants {
  AppConstants._();

  // ── Identity ───────────────────────────────────────────────────────────────
  static const String name = 'Amir Sohail';
  static const String nameInitials = 'AS';
  static const String title = 'FinTech Systems Engineer';
  static const String subtitle = 'Real-Time Trading & Payments Infrastructure';
  static const String location = 'Karachi, Pakistan';
  static const String availability = 'Open to senior & contract roles';
  static const String email = 'amir.sohail.pro@gmail.com';
  static const String phone = '+92 370-2624518';

  // ── Positioning ────────────────────────────────────────────────────────────
  // Hero headline is split so the accent line can be styled separately.
  static const String heroEyebrow = 'SOFTWARE ENGINEER · FINTECH · FLUTTER · .NET';
  static const String heroHeadlineLead = 'Engineering financial systems';
  static const String heroHeadlineAccent = 'that hold under load.';
  static const String heroSubhead =
      'Four years building the real-time trading and payments infrastructure '
      'behind production fintech — order books, live price feeds, and payment '
      'rails serving tens of thousands of concurrent users. Flutter on the '
      'surface, systems thinking underneath.';

  static const String storyEyebrow = 'THE THROUGH-LINE';
  static const String storyHeadline = 'I build for the moments money is moving.';

  static const String visionEyebrow = 'WHERE I\'M HEADED';
  static const String visionHeadline =
      'Reliability is a feature you only notice when it\'s missing.';
  static const String visionBody =
      'My next chapter is going deeper on the infrastructure layer — the '
      'event-driven backbones, observability, and failure-mode design that let '
      'a trading platform stay calm during a market spike. I want to own '
      'systems where correctness and latency are non-negotiable, and where the '
      'difference between good and great is measured in milliseconds and '
      'recovered sessions.';

  // ── Social / store links ───────────────────────────────────────────────────
  static const String linkedInUrl = 'https://linkedin.com/in/amirsohail110';
  static const String githubUrl = 'https://github.com/amirsohail110';
  static const String emailUrl = 'mailto:amir.sohail.pro@gmail.com';

  static const String ktradejazzcashUrl =
      'https://play.google.com/store/apps/details?id=com.wave.kedia';
  static const String ktradeSaudiPlayUrl =
      'https://play.google.com/store/apps/details?id=com.ktradesaudi.ktradesaudi';
  static const String ktradeSaudiAppUrl =
      'https://apps.apple.com/us/app/ktrade-saudi/id6474119850';

  // ── Hero metrics (the credibility numbers) ──────────────────────────────────
  // value, suffix, label
  static const List<List<String>> heroMetrics = [
    ['50', 'K+', 'Active traders served'],
    ['5', 'K', 'Concurrent live sessions'],
    ['22', 'M+', 'Payment-app users reached'],
    ['80', '%', 'Crash-rate reduction'],
  ];

  // ── Trust strip (the platforms his work has touched) ────────────────────────
  static const List<String> trustedBy = [
    'KTrade Securities',
    'JazzCash',
    'Easypaisa',
    'KASB',
    'Tadawul (Saudi)',
  ];

  // ── Section IDs ─────────────────────────────────────────────────────────────
  static const String sectionHero = 'hero';
  static const String sectionStory = 'story';
  static const String sectionExperience = 'experience';
  static const String sectionWork = 'work';
  static const String sectionArchitecture = 'architecture';
  static const String sectionSkills = 'skills';
  static const String sectionVision = 'vision';
  static const String sectionContact = 'contact';

  // ── Nav ─────────────────────────────────────────────────────────────────────
  static const List<String> navLabels = [
    'Story',
    'Experience',
    'Work',
    'Architecture',
    'Contact',
  ];

  static const List<String> navSectionIds = [
    sectionStory,
    sectionExperience,
    sectionWork,
    sectionArchitecture,
    sectionContact,
  ];

  // ── Layout ──────────────────────────────────────────────────────────────────
  static const double maxContentWidth = 1180.0;
  static const double narrowContentWidth = 760.0;
  static const double navBarHeight = 76.0;
  static const double sectionPaddingVertical = 120.0;
  static const double sectionPaddingHorizontalDesktop = 80.0;
  static const double sectionPaddingHorizontalMobile = 24.0;
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;

  // ── Motion ──────────────────────────────────────────────────────────────────
  static const int animationFastMs = 280;
  static const int animationMediumMs = 600;
  static const int animationSlowMs = 900;
}
