import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  UrlLauncherUtil._();

  static Future<void> launchURL(
    String url, {
    BuildContext? context,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final uri = Uri.parse(url);
    try {
      final canLaunch = await canLaunchUrl(uri);
      if (canLaunch) {
        await launchUrl(uri, mode: mode);
      } else {
        debugPrint('Could not launch $url');
        if (context != null && context.mounted) {
          _showErrorSnackBar(context, 'Could not open link: $url');
        }
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      if (context != null && context.mounted) {
        _showErrorSnackBar(context, 'Error opening link');
      }
    }
  }

  static Future<void> launchEmail(
    String email, {
    String? subject,
    String? body,
    BuildContext? context,
  }) async {
    final params = StringBuffer('mailto:$email');
    final queryParts = <String>[];
    if (subject != null) queryParts.add('subject=${Uri.encodeComponent(subject)}');
    if (body != null) queryParts.add('body=${Uri.encodeComponent(body)}');
    if (queryParts.isNotEmpty) {
      params.write('?${queryParts.join('&')}');
    }
    await launchURL(params.toString(), context: context);
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
