import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../../../core/utils/url_launcher_util.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background(isDark),
        border: Border(
          top: BorderSide(color: AppColors.border(isDark)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtil.horizontalPadding(context),
              vertical: 32,
            ),
            child: isMobile
                ? _buildMobileFooter(context, isDark)
                : _buildDesktopFooter(context, isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCopyright(isDark),
        _buildSocialIcons(context, isDark),
        _buildMadeWith(isDark),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context, bool isDark) {
    return Column(
      children: [
        _buildSocialIcons(context, isDark),
        const SizedBox(height: 20),
        _buildCopyright(isDark),
        const SizedBox(height: 8),
        _buildMadeWith(isDark),
      ],
    );
  }

  Widget _buildCopyright(bool isDark) {
    return Text(
      '© ${DateTime.now().year} ${AppConstants.name}. All rights reserved.',
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.textMuted(isDark),
      ),
    );
  }

  Widget _buildSocialIcons(BuildContext context, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterIconButton(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub',
          isDark: isDark,
          onTap: () => UrlLauncherUtil.launchURL(
            AppConstants.githubUrl,
            context: context,
          ),
        ),
        const SizedBox(width: 12),
        _FooterIconButton(
          icon: FontAwesomeIcons.linkedin,
          tooltip: 'LinkedIn',
          isDark: isDark,
          onTap: () => UrlLauncherUtil.launchURL(
            AppConstants.linkedInUrl,
            context: context,
          ),
        ),
        const SizedBox(width: 12),
        _FooterIconButton(
          icon: FontAwesomeIcons.envelope,
          tooltip: 'Email',
          isDark: isDark,
          onTap: () => UrlLauncherUtil.launchEmail(
            AppConstants.email,
            context: context,
          ),
        ),
      ],
    );
  }

  Widget _buildMadeWith(bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Designed & engineered in Flutter',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textMuted(isDark),
          ),
        ),
        const SizedBox(width: 6),
        Icon(Icons.bolt_outlined, size: 13, color: AppColors.gold(isDark)),
      ],
    );
  }
}

class _FooterIconButton extends StatefulWidget {
  const _FooterIconButton({
    required this.icon,
    required this.tooltip,
    required this.isDark,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<_FooterIconButton> createState() => _FooterIconButtonState();
}

class _FooterIconButtonState extends State<_FooterIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _isHovered ? AppColors.primarySoft : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary
                    : AppColors.border(isDark),
              ),
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 15,
                color: _isHovered
                    ? AppColors.primary
                    : AppColors.textMuted(isDark),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
