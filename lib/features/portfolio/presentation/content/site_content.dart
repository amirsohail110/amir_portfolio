import 'package:flutter/material.dart';

/// Static, editorial copy for the narrative sections (career story, the
/// architecture philosophy, leadership). These aren't data that changes at
/// runtime, so they live as presentation content rather than going through the
/// BLoC — which stays focused on experiences / projects / skills.

// ── Career story ──────────────────────────────────────────────────────────────

class StoryChapter {
  const StoryChapter({required this.kicker, required this.title, required this.body});
  final String kicker;
  final String title;
  final String body;
}

const List<StoryChapter> kCareerStory = [
  StoryChapter(
    kicker: 'Why fintech',
    title: 'I started where the stakes were real.',
    body:
        'My first production work was a virtual trading backend distributed to '
        'sixteen million payment-app users. When that many people touch a number '
        'you computed, you stop thinking about features and start thinking about '
        'correctness, latency and trust. Fintech is unforgiving in the best way — '
        'it rewards engineers who care about the unglamorous parts.',
  ),
  StoryChapter(
    kicker: 'Why real-time',
    title: 'A price feed is a contract, not a feature.',
    body:
        'Trading taught me that "live" is a promise with sharp edges: data has to '
        'arrive fast, in order, and never be silently wrong. Building order books '
        'and price streams over WebSocket, Redis Pub/Sub and SignalR pushed me '
        'into the questions that actually matter at scale — reconnection, '
        'back-pressure, sequencing, and how a system behaves when the market — '
        'and the load — spikes at once.',
  ),
  StoryChapter(
    kicker: 'Why architecture',
    title: 'Good architecture is how you stay fast for years.',
    body:
        'Shipping KTrade across mobile and web from one codebase only works '
        'because the domain logic doesn\'t know or care what\'s rendering it. '
        'Clean Architecture isn\'t dogma to me — it\'s the reason a crash rate '
        'drops 80%, a new platform is a target and not a rewrite, and a team can '
        'move quickly without breaking the parts that handle money.',
  ),
];

// ── Architecture philosophy ───────────────────────────────────────────────────

class ArchPrinciple {
  const ArchPrinciple({
    required this.index,
    required this.title,
    required this.body,
    required this.tags,
  });
  final String index;
  final String title;
  final String body;
  final List<String> tags;
}

const List<ArchPrinciple> kArchPrinciples = [
  ArchPrinciple(
    index: '01',
    title: 'Clean, framework-free core',
    body:
        'Domain and use-cases never import Flutter. The business rules of trading '
        'outlive any UI framework, so they stay isolated, testable and portable '
        'across mobile and web.',
    tags: ['Clean Architecture', 'Use-cases', 'Testability'],
  ),
  ArchPrinciple(
    index: '02',
    title: 'Predictable state, one direction',
    body:
        'BLoC gives every screen a single source of truth and an auditable trail '
        'of events. Under live data, predictable beats clever — you can reason '
        'about exactly why the UI is in the state it\'s in.',
    tags: ['BLoC / Cubit', 'Unidirectional', 'Auditable'],
  ),
  ArchPrinciple(
    index: '03',
    title: 'Real-time that degrades gracefully',
    body:
        'Streams reconnect, sequence-check and apply back-pressure. A market spike '
        'should slow the system down politely, never flood the UI thread or '
        'corrupt the order book.',
    tags: ['WebSocket', 'Back-pressure', 'Reconnection'],
  ),
  ArchPrinciple(
    index: '04',
    title: 'Scale by isolation, not by hope',
    body:
        'Features are vertical slices with clear boundaries. New platforms become '
        'targets, not rewrites; new screens compose existing pieces instead of '
        'reaching across the codebase.',
    tags: ['Feature-first', 'Modularity', 'Composition'],
  ),
  ArchPrinciple(
    index: '05',
    title: 'Security at the boundary',
    body:
        'Tokens stay off the JavaScript surface, secrets live in secure storage, '
        'and the WebView bridge treats the host app as untrusted input. In '
        'fintech, the boundary is the product.',
    tags: ['JWT', 'Secure Storage', 'Bridge Hardening'],
  ),
  ArchPrinciple(
    index: '06',
    title: 'Maintainability is a performance metric',
    body:
        'Sub-16ms frames and an 80% crash-rate drop come from the same place: '
        'disciplined error handling, defensive networking and code a team can '
        'change without fear.',
    tags: ['60fps', 'Error Tracking', 'CI/CD'],
  ),
];

// ── Real-time data-flow diagram (rendered as nodes, not an image) ─────────────

class FlowNode {
  const FlowNode({required this.label, required this.sub, required this.icon});
  final String label;
  final String sub;
  final IconData icon;
}

const List<FlowNode> kDataFlow = [
  FlowNode(label: 'Exchange feed', sub: 'Market data source', icon: Icons.show_chart),
  FlowNode(label: 'Redis Pub/Sub', sub: 'Fan-out + ordering', icon: Icons.hub_outlined),
  FlowNode(label: 'WebSocket / SignalR', sub: 'Push transport', icon: Icons.bolt_outlined),
  FlowNode(label: 'BLoC stream', sub: 'Back-pressure + state', icon: Icons.account_tree_outlined),
  FlowNode(label: 'Order book UI', sub: 'Sub-16ms render', icon: Icons.candlestick_chart_outlined),
];

// ── Leadership & collaboration ────────────────────────────────────────────────

class LeadPoint {
  const LeadPoint({required this.title, required this.body, required this.icon});
  final String title;
  final String body;
  final IconData icon;
}

const List<LeadPoint> kLeadership = [
  LeadPoint(
    icon: Icons.architecture_outlined,
    title: 'Set the foundation',
    body:
        'Established the architecture, conventions and real-time patterns that the '
        'rest of the team builds on day to day.',
  ),
  LeadPoint(
    icon: Icons.handshake_outlined,
    title: 'Work across the seam',
    body:
        'Comfortable on both sides of the wire — I speak fluently to backend, '
        'product and the super-app partners we integrate with.',
  ),
  LeadPoint(
    icon: Icons.verified_outlined,
    title: 'Own the outcome',
    body:
        'From first commit to store release and crash dashboards — I treat '
        'reliability in production as part of the job, not someone else\'s.',
  ),
];
