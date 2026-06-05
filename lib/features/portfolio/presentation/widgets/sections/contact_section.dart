import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive_util.dart';
import '../../../../../core/utils/url_launcher_util.dart';
import '../../../../../core/widgets/premium_button.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../../core/widgets/section_container.dart';

/// Closing CTA. Deliberately uses direct, secure contact channels (mailto +
/// social) instead of an unauthenticated web form — there's no backend to
/// validate or rate-limit submissions, so a form would only invite spam.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);

    return SectionContainer(
      child: RevealOnScroll(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 28 : 56),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.card(isDark),
                AppColors.gold(isDark).withValues(alpha: isDark ? 0.10 : 0.07),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border(isDark)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 1.4,
                    color: AppColors.gold(isDark),
                  ),
                  const SizedBox(width: 12),
                  Text('LET\'S TALK',
                      style: AppTextStyles.sectionTag
                          .copyWith(color: AppColors.gold(isDark))),
                ],
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  'Building something where reliability matters? Let\'s talk.',
                  style: (isMobile
                          ? AppTextStyles.headlineLarge
                          : AppTextStyles.displaySmall)
                      .copyWith(color: AppColors.textPrimary(isDark)),
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'I\'m open to senior and contract roles in fintech, trading, '
                  'and real-time systems — and always happy to trade notes on '
                  'architecture. The fastest way to reach me is email.',
                  style: AppTextStyles.bodyLarge
                      .copyWith(color: AppColors.textSecondary(isDark)),
                ),
              ),
              const SizedBox(height: 36),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  PremiumButton(
                    label: 'Email me',
                    icon: Icons.mail_outline,
                    trailingIcon: Icons.arrow_forward,
                    onTap: () => UrlLauncherUtil.launchEmail(
                      AppConstants.email,
                      subject: 'Let\'s build something',
                      context: context,
                    ),
                  ),
                  const _CopyEmail(),
                ],
              ),
              const SizedBox(height: 36),
              Divider(height: 1, color: AppColors.border(isDark)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 28,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _MetaItem(
                          icon: Icons.place_outlined,
                          label: AppConstants.location,
                          isDark: isDark,
                        ),
                        _MetaItem(
                          icon: Icons.circle,
                          label: AppConstants.availability,
                          isDark: isDark,
                          accent: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  _SocialButton(
                    icon: FontAwesomeIcons.linkedinIn,
                    onTap: () => UrlLauncherUtil.launchURL(
                        AppConstants.linkedInUrl,
                        context: context),
                    isDark: isDark,
                  ),
                  const SizedBox(width: 12),
                  _SocialButton(
                    icon: FontAwesomeIcons.github,
                    onTap: () => UrlLauncherUtil.launchURL(
                        AppConstants.githubUrl,
                        context: context),
                    isDark: isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CopyEmail extends StatefulWidget {
  const _CopyEmail();
  @override
  State<_CopyEmail> createState() => _CopyEmailState();
}

class _CopyEmailState extends State<_CopyEmail> {
  bool _copied = false;
  bool _hover = false;

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: AppConstants.email));
    if (!mounted) return;
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: _copy,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _hover
                  ? AppColors.gold(isDark)
                  : AppColors.border(isDark),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_copied ? Icons.check : Icons.copy_outlined,
                  size: 16, color: AppColors.textSecondary(isDark)),
              const SizedBox(width: 10),
              Text(_copied ? 'Copied!' : AppConstants.email,
                  style: AppTextStyles.mono.copyWith(
                    color: AppColors.textSecondary(isDark),
                    fontSize: 13,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.icon,
    required this.label,
    required this.isDark,
    this.accent = false,
  });
  final IconData icon;
  final String label;
  final bool isDark;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,
            size: accent ? 9 : 16,
            color: accent
                ? AppColors.success
                : AppColors.textMuted(isDark)),
        const SizedBox(width: 8),
        Text(label,
            style: AppTextStyles.labelMedium
                .copyWith(color: AppColors.textSecondary(isDark))),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final gold = AppColors.gold(widget.isDark);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _hover ? gold.withValues(alpha: 0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: _hover ? gold : AppColors.border(widget.isDark)),
          ),
          child: Center(
            child: FaIcon(widget.icon,
                size: 16,
                color: _hover
                    ? gold
                    : AppColors.textSecondary(widget.isDark)),
          ),
        ),
      ),
    );
  }
}
