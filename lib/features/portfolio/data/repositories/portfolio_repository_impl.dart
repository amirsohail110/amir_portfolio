import '../../domain/entities/experience.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill_category.dart';
import '../../domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  const PortfolioRepositoryImpl();

  @override
  List<Experience> getExperiences() {
    return const [
      Experience(
        id: 'exp_1',
        role: 'Senior Software Engineer — Flutter',
        company: 'KTrade Securities',
        period: 'Mar 2024 — Present',
        isCurrent: true,
        description:
            'Technical lead on KTrade 2.0, the firm\'s flagship trading platform. '
            'I own the client architecture end-to-end — mobile and web from one '
            'codebase — and the real-time layer that keeps order books and '
            'prices live for thousands of concurrent traders without dropping a '
            'frame.',
        highlights: [
          'Re-architected KTrade as a single Flutter codebase shipping to iOS, Android and web, serving 50K+ traders at ~5K concurrent sessions.',
          'Designed the real-time execution layer — live order book, buy/sell, fills — over WebSocket with reconnection and back-pressure handling.',
          'Embedded the platform inside the JazzCash & Easypaisa super-apps (22M+ combined users) via a hardened WebView bridge.',
          'Cut crash rate ~80% with structured error tracking, defensive networking and a disciplined release process.',
          'Held complex chart and order screens to sub-16ms frame budgets under live data.',
        ],
        techStack: [
          'Flutter',
          'Dart',
          'BLoC',
          'WebSocket',
          'SignalR',
          'Clean Architecture',
          'WebView Bridge',
          'Crashlytics',
          'CI/CD',
        ],
      ),
      Experience(
        id: 'exp_2',
        role: 'Software Engineer — Flutter',
        company: 'KTrade Securities',
        period: 'Jan 2023 — Feb 2024',
        isCurrent: false,
        description:
            'Built KTrade Saudi from an empty repository — a trading and '
            'financial-literacy platform for the Saudi market. This is where I '
            'learned that a price feed isn\'t a feature, it\'s a contract: it has '
            'to be fast, ordered, and never silently wrong.',
        highlights: [
          'Shipped KTrade Saudi end-to-end: live market data, trading engine and a gamified learning track.',
          'Built a Redis Pub/Sub → WebSocket pipeline delivering sub-100ms price updates to the client.',
          'Established Clean Architecture + BLoC as the codebase foundation, keeping domain logic framework-free.',
          'Published to both the App Store and Google Play.',
          'Designed adaptive layouts handling Arabic RTL and English LTR from the same widget tree.',
        ],
        techStack: [
          'Flutter',
          'Dart',
          'BLoC / Cubit',
          'Redis Pub/Sub',
          'WebSocket',
          'Clean Architecture',
          'Firebase',
          'iOS',
          'Android',
        ],
      ),
      Experience(
        id: 'exp_3',
        role: 'Software Engineer — .NET Backend',
        company: 'Block Tech Pakistan',
        period: 'Aug 2021 — Dec 2022',
        isCurrent: false,
        description:
            'Started on the server side, which is why I think in systems, not '
            'screens. Built the REST backend for a virtual trading platform '
            'distributed to JazzCash\'s 16M+ users — portfolio engine, matching '
            'logic, and the leaderboard that drove engagement.',
        highlights: [
          'Designed and built the REST API surface for a virtual trading platform reaching 16M+ JazzCash users.',
          'Implemented the portfolio manager, trade-execution core and competitive leaderboard.',
          'Secured the API with JWT auth and role-based access control.',
          'Tuned SQL hot paths, cutting API response times ~40%.',
        ],
        techStack: [
          '.NET Web API',
          'C#',
          'MySQL',
          'JWT',
          'REST',
          'Postman',
          'Git',
        ],
      ),
    ];
  }

  @override
  List<Project> getProjects() {
    return const [
      // ── Signature case studies ──────────────────────────────────────────────
      Project(
        id: 'proj_ktrade_jazz',
        title: 'KTrade 2.0',
        tagline: 'Real-time stock trading, embedded inside a 22M-user super-app.',
        role: 'Client architecture & real-time systems lead',
        year: '2024 — Present',
        description:
            'A production Flutter trading platform running standalone and '
            'embedded inside the JazzCash & Easypaisa super-apps.',
        problem:
            'KTrade needed to put live equity trading in front of millions of '
            'first-time investors — inside payment super-apps where users expect '
            'instant, reliable, banking-grade behaviour. A janky chart or a stale '
            'price isn\'t a bug here; it\'s a loss of trust with someone\'s money.',
        architecture:
            'One Flutter codebase targets iOS, Android and web, with a Clean '
            'Architecture core that keeps trading logic independent of UI and '
            'transport. The real-time layer streams the order book and fills over '
            'WebSocket with automatic reconnection, sequence checks and '
            'back-pressure so a market spike degrades gracefully instead of '
            'flooding the UI thread. A hardened WebView bridge handles auth and '
            'deep-linking from the host super-apps.',
        impact: [
          'Serves 50K+ active traders at ~5K concurrent live sessions.',
          'Reachable by 22M+ JazzCash & Easypaisa users through in-app embedding.',
          'Crash rate cut ~80% versus the previous generation.',
          'Order and chart screens hold sub-16ms frames under live data.',
        ],
        metrics: [
          ['50K+', 'active traders'],
          ['5K', 'concurrent sessions'],
          ['~80%', 'fewer crashes'],
        ],
        techStack: [
          'Flutter',
          'Dart',
          'BLoC',
          'WebSocket',
          'WebView Bridge',
          'Clean Architecture',
          'Firebase',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.wave.kedia',
        isHighlighted: true,
      ),
      Project(
        id: 'proj_ktrade_saudi',
        title: 'KTrade Saudi',
        tagline: 'A trading + learning platform built from zero for the Saudi market.',
        role: 'Founding mobile engineer',
        year: '2023 — 2024',
        description:
            'Cross-platform trading and financial-literacy app with live market '
            'data and a gamified learning track, localised for Arabic.',
        problem:
            'New investors don\'t just need a place to trade — they need to learn '
            'without leaving. The product had to fuse a live trading surface with '
            'a teaching experience, in a fully bilingual (RTL/LTR) interface, on a '
            'fresh codebase with no existing foundation to lean on.',
        architecture:
            'I set the foundation: Clean Architecture with BLoC/Cubit, a '
            'framework-free domain layer, and a Redis Pub/Sub → WebSocket price '
            'pipeline delivering sub-100ms updates. Arabic RTL and English LTR are '
            'driven from one widget tree through directionality-aware layout, so '
            'there\'s no forked UI to maintain.',
        impact: [
          'Shipped to both App Store and Google Play.',
          'Sub-100ms live price updates via Redis Pub/Sub + WebSocket.',
          'Single codebase serving Arabic RTL and English LTR.',
          'Gamified learning track to lift engagement and retention.',
        ],
        metrics: [
          ['<100ms', 'price latency'],
          ['2', 'app stores'],
          ['RTL+LTR', 'one codebase'],
        ],
        techStack: [
          'Flutter',
          'Dart',
          'BLoC / Cubit',
          'Redis Pub/Sub',
          'WebSocket',
          'Clean Architecture',
          'Firebase',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.ktradesaudi.ktradesaudi',
        appStoreUrl:
            'https://apps.apple.com/us/app/ktrade-saudi/id6474119850',
        isHighlighted: true,
      ),
      Project(
        id: 'proj_payments',
        title: 'JazzCash & Easypaisa Integration',
        tagline: 'Putting a trading client inside Pakistan\'s biggest payment rails.',
        role: 'Integration engineer',
        year: '2022 — 2025',
        description:
            'Embedding and payment-flow integration across the two largest '
            'mobile-money ecosystems in Pakistan.',
        problem:
            'Reaching scale in Pakistan means living inside the super-apps people '
            'already trust with money. That means surrendering some control — host '
            'auth, host navigation, host lifecycle — while still guaranteeing a '
            'secure, seamless trading experience to a combined 22M+ users.',
        architecture:
            'A WebView bridge mediates session hand-off, deep-linking and '
            'event-passing between the host super-app and the Flutter client, with '
            'token exchange kept off the JavaScript surface. On the backend side '
            '(earlier .NET work) I built the virtual-trading API distributed to '
            'JazzCash\'s user base with JWT auth and role-based access.',
        impact: [
          'Combined reach of 22M+ JazzCash & Easypaisa users.',
          'Secure session hand-off between host app and trading client.',
          'Backend API (earlier) served 16M+ JazzCash users.',
        ],
        metrics: [
          ['22M+', 'users reached'],
          ['2', 'super-apps'],
        ],
        techStack: [
          'Flutter',
          'WebView Bridge',
          'JWT',
          '.NET Web API',
          'Deep Linking',
        ],
        isHighlighted: true,
      ),

      // ── Selected open-source / craft work ───────────────────────────────────
      Project(
        id: 'proj_ocr',
        title: 'Image-to-Text Recognition',
        description:
            'On-device OCR that extracts and exports text from images using ML Kit '
            '— multi-source capture, no server round-trip.',
        techStack: ['Flutter', 'ML Kit', 'Camera', 'Image Picker'],
        githubUrl:
            'https://github.com/amirsohail110/Image-To-Text-Recognition-Flutter',
        stars: 3,
      ),
      Project(
        id: 'proj_easyride',
        title: 'EasyRide — Neumorphic UI',
        description:
            'A ride-booking concept exploring a full neumorphic component library '
            'with custom shadow rendering and fluid state transitions.',
        techStack: ['Flutter', 'CustomPainter', 'Animations'],
        githubUrl:
            'https://github.com/amirsohail110/EasyRide-Neumorphic-Design',
        stars: 1,
      ),
      Project(
        id: 'proj_counter',
        title: 'Animated Counter',
        description:
            'A performance-minded animated number counter — custom tweens tuned '
            'for dashboards and live stat displays.',
        techStack: ['Flutter', 'Animation', 'Tween'],
        githubUrl:
            'https://github.com/amirsohail110/Number-Counter-Animation',
      ),
    ];
  }

  @override
  List<SkillCategory> getSkillCategories() {
    return const [
      SkillCategory(
        id: 'cat_realtime',
        name: 'Real-Time & Networking',
        icon: 'network',
        skills: [
          'WebSocket',
          'SignalR',
          'Redis Pub/Sub',
          'NATS',
          'REST',
          'Dio',
          'RxDart',
        ],
      ),
      SkillCategory(
        id: 'cat_architecture',
        name: 'Architecture & State',
        icon: 'architecture',
        skills: [
          'Clean Architecture',
          'MVVM',
          'BLoC / Cubit',
          'Riverpod',
          'Provider',
          'GetX',
        ],
      ),
      SkillCategory(
        id: 'cat_mobile',
        name: 'Client Engineering',
        icon: 'mobile',
        skills: ['Flutter', 'Dart', 'Flutter Web', 'iOS', 'Android', 'Kotlin'],
      ),
      SkillCategory(
        id: 'cat_backend',
        name: 'Backend',
        icon: 'backend',
        skills: ['.NET Web API', 'C#', 'MySQL', 'NoSQL', 'REST Design'],
      ),
      SkillCategory(
        id: 'cat_security',
        name: 'Security',
        icon: 'security',
        skills: [
          'JWT',
          'OAuth 2.0',
          'Biometric Auth',
          'Secure Storage',
          'Encryption',
        ],
      ),
      SkillCategory(
        id: 'cat_integrations',
        name: 'Platforms & Integrations',
        icon: 'integrations',
        skills: [
          'JazzCash',
          'Easypaisa',
          'WebView Bridge',
          'Firebase FCM',
          'Crashlytics',
          'Analytics',
        ],
      ),
      SkillCategory(
        id: 'cat_storage',
        name: 'Storage',
        icon: 'storage',
        skills: ['SQLite', 'Hive', 'SharedPreferences', 'NoSQL'],
      ),
      SkillCategory(
        id: 'cat_devops',
        name: 'Delivery & Tooling',
        icon: 'devops',
        skills: ['Git', 'CI/CD', 'Firebase', 'Postman', 'Jira', 'Xcode'],
      ),
    ];
  }
}
