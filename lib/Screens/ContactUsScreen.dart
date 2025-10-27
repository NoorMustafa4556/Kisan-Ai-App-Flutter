// lib/Screens/ContactUsScreen.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppConstants.dart';
import 'package:provider/provider.dart';
import '../Providers/AuthProvider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  void _launchEmail() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userEmail = authProvider.user?.email ?? '';

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'noormustafa4556@gmail.com',
      queryParameters: {
        'subject': 'Inquiry from KisanMitra App - User: $userEmail',
        'body':
        'Dear KisanMitra Support,\n\nI am writing to you from laborator the KisanMitra app. ',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      _showSnackBar(
          'Could not launch email client. Please ensure you have an email app installed.');
    }
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showSnackBar('Could not launch $url');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppConstants.contactUs),
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We'd love to hear from you!",
              style: AppStyles.headlineStyle(context).copyWith(
                color: theme.textTheme.headlineMedium?.color,
              ),
            ),
            const SizedBox(height: AppStyles.defaultPadding),
            Text(
              "If you have any questions, feedback, or need assistance, please feel free to reach out to us through the options below.",
              style: AppStyles.bodyTextStyle(context).copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: AppStyles.largePadding),

            _buildContactOption(
              icon: FontAwesomeIcons.solidEnvelope,
              title: "Email Us",
              subtitle: "Send us an email directly from your app.",
              onTap: _launchEmail,
            ),
            const SizedBox(height: AppStyles.defaultPadding),

            _buildContactOption(
              icon: FontAwesomeIcons.phone,
              title: "Call Us",
              subtitle: "Connect with us via phone for urgent queries.",
              onTap: () => _launchURL('tel:+923087655076'),
            ),
            const SizedBox(height: AppStyles.defaultPadding),

            _buildContactOption(
              icon: FontAwesomeIcons.whatsapp,
              title: "WhatsApp",
              subtitle: "Chat with us on WhatsApp.",
              onTap: () => _launchURL('https://wa.me/923087655076'),
            ),
            const SizedBox(height: AppStyles.largePadding),

            Center(
              child: Text(
                "KisanMitra - Your Farming Companion",
                style: AppStyles.bodyTextStyle(context).copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppStyles.defaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppStyles.defaultPadding),
          child: Row(
            children: [
              FaIcon(
                icon,
                size: 30,
                color: AppStyles.primaryColor,
              ),
              const SizedBox(width: AppStyles.defaultPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.subTitleStyle(context).copyWith(
                        color: theme.textTheme.titleMedium?.color,
                      ),
                    ),
                    const SizedBox(height: AppStyles.smallPadding / 2),
                    Text(
                      subtitle,
                      style: AppStyles.bodyTextStyle(context).copyWith(
                        color:
                        theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
