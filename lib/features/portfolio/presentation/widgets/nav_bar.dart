import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/bloc/theme_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../../../core/utils/url_launcher_util.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
    required this.onNavTap,
    this.activeSection,
    this.scrollController,
  });

  final void Function(String sectionId) onNavTap;
  final String? activeSection;
  final ScrollController? scrollController;

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.navBarHeight);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      widget.scrollController?.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final offset = widget.scrollController?.offset ?? 0;
    final scrolled = offset > 20;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgBase = AppColors.background(isDark);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: AppConstants.navBarHeight,
      decoration: BoxDecoration(
        color: _isScrolled
            ? bgBase.withValues(alpha: 0.97)
            : bgBase.withValues(alpha: 0.92),
        border: Border(
          bottom: BorderSide(
            color: _isScrolled
                ? AppColors.border(isDark)
                : Colors.transparent,
          ),
        ),
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.12),
                  blurRadius: 20,
                ),
              ]
            : [],
      ),
      child: ResponsiveUtil.isDesktop(context)
          ? _buildDesktopNav(context, isDark)
          : _buildMobileNav(context, isDark),
    );
  }

  Widget _buildDesktopNav(BuildContext context, bool isDark) {
    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtil.horizontalPadding(context),
          ),
          child: Row(
            children: [
              _buildLogo(context, isDark),
              const Spacer(),
              // Nav links
              ...AppConstants.navLabels.asMap().entries.map((entry) {
                final sectionId = AppConstants.navSectionIds[entry.key];
                final isActive = widget.activeSection == sectionId;
                return Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: _NavLink(
                    label: entry.value,
                    isActive: isActive,
                    isDark: isDark,
                    onTap: () => widget.onNavTap(sectionId),
                  ),
                );
              }),
              const SizedBox(width: 24),
              // Theme toggle
              _ThemeToggleButton(isDark: isDark),
              const SizedBox(width: 12),
              // GitHub icon link
              _GithubIconButton(isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNav(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(context, isDark),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ThemeToggleButton(isDark: isDark),
              const SizedBox(width: 4),
              Builder(
                builder: (ctx) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: AppColors.textPrimary(isDark),
                  ),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => widget.onNavTap(AppConstants.sectionHero),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Center(
                child: Text(
                  AppConstants.nameInitials,
                  style: AppTextStyles.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Amir Sohail',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textPrimary(isDark),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Theme Toggle ────────────────────────────────────────────────────────────

class _ThemeToggleButton extends StatefulWidget {
  const _ThemeToggleButton({required this.isDark});

  final bool isDark;

  @override
  State<_ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<_ThemeToggleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    return Tooltip(
      message: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () =>
              context.read<ThemeBloc>().add(const ToggleTheme()),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isHovered ? AppColors.primarySoft : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary
                    : AppColors.border(isDark),
              ),
            ),
            child: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              size: 18,
              color: _isHovered
                  ? AppColors.primary
                  : AppColors.textSecondary(isDark),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Nav Link ────────────────────────────────────────────────────────────────

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = widget.isActive || _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: isHighlighted
                    ? AppTextStyles.navLinkActive
                    : AppTextStyles.navLink.copyWith(
                        color: AppColors.textSecondary(widget.isDark),
                      ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isHighlighted ? 24 : 0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── GitHub Icon Button ───────────────────────────────────────────────────────

class _GithubIconButton extends StatefulWidget {
  const _GithubIconButton({required this.isDark});

  final bool isDark;

  @override
  State<_GithubIconButton> createState() => _GithubIconButtonState();
}

class _GithubIconButtonState extends State<_GithubIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlLauncherUtil.launchURL(
          AppConstants.githubUrl,
          context: context,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primarySoft : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  _isHovered ? AppColors.primary : AppColors.border(isDark),
            ),
          ),
          child: FaIcon(
            FontAwesomeIcons.github,
            size: 18,
            color: _isHovered
                ? AppColors.primary
                : AppColors.textSecondary(isDark),
          ),
        ),
      ),
    );
  }
}

// ─── App Drawer ───────────────────────────────────────────────────────────────

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.onNavTap,
    this.activeSection,
  });

  final void Function(String sectionId) onNavTap;
  final String? activeSection;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Container(
        color: AppColors.card(isDark),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              AppConstants.nameInitials,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Menu',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary(isDark),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Theme toggle in drawer header
                        IconButton(
                          icon: Icon(
                            isDark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: AppColors.textSecondary(isDark),
                          ),
                          tooltip: isDark
                              ? 'Switch to Light Mode'
                              : 'Switch to Dark Mode',
                          onPressed: () =>
                              context.read<ThemeBloc>().add(const ToggleTheme()),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.textSecondary(isDark),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(height: 1, color: AppColors.border(isDark)),
              const SizedBox(height: 16),
              ...AppConstants.navLabels.asMap().entries.map((entry) {
                final sectionId = AppConstants.navSectionIds[entry.key];
                final isActive = activeSection == sectionId;
                return _DrawerItem(
                  label: entry.value,
                  isActive: isActive,
                  isDark: isDark,
                  onTap: () {
                    Navigator.pop(context);
                    onNavTap(sectionId);
                  },
                );
              }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    _DrawerIconButton(
                      icon: FontAwesomeIcons.github,
                      isDark: isDark,
                      onTap: () => UrlLauncherUtil.launchURL(
                        AppConstants.githubUrl,
                        context: context,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _DrawerIconButton(
                      icon: FontAwesomeIcons.linkedin,
                      isDark: isDark,
                      onTap: () => UrlLauncherUtil.launchURL(
                        AppConstants.linkedInUrl,
                        context: context,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _DrawerIconButton(
                      icon: FontAwesomeIcons.envelope,
                      isDark: isDark,
                      onTap: () => UrlLauncherUtil.launchEmail(
                        AppConstants.email,
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.label,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarySoft : Colors.transparent,
          border: isActive
              ? const Border(
                  left: BorderSide(color: AppColors.primary, width: 3),
                )
              : null,
        ),
        child: Text(
          label,
          style: isActive
              ? AppTextStyles.navLinkActive.copyWith(fontSize: 16)
              : AppTextStyles.navLink.copyWith(
                  fontSize: 16,
                  color: AppColors.textSecondary(isDark),
                ),
        ),
      ),
    );
  }
}

class _DrawerIconButton extends StatelessWidget {
  const _DrawerIconButton({
    required this.icon,
    required this.isDark,
    required this.onTap,
  });

  final IconData icon;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface(isDark),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border(isDark)),
        ),
        child: Center(
          child: FaIcon(
            icon,
            size: 16,
            color: AppColors.textSecondary(isDark),
          ),
        ),
      ),
    );
  }
}
