<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome

import '../Utils/AppStyles.dart'; // Assuming AppStyles contains your color/style definitions
import '../Utils/AppConstants.dart'; // Assuming AppConstants contains app name etc.
import 'package:provider/provider.dart'; // For accessing AuthProvider
import '../Providers/AuthProvider.dart'; // Import AuthProvider
=======
// lib/Screens/ContactUsScreen.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Utils/AppStyles.dart';
import '../Utils/AppConstants.dart';
import 'package:provider/provider.dart';
import '../Providers/AuthProvider.dart';
>>>>>>> b11e7d7 (first commit)

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
<<<<<<< HEAD
  // Function to launch email client
  void _launchEmail() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userEmail = authProvider.user?.email ?? ''; // Get user's registered email
=======
  void _launchEmail() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userEmail = authProvider.user?.email ?? '';
>>>>>>> b11e7d7 (first commit)

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'noormustafa4556@gmail.com',
      queryParameters: {
<<<<<<< HEAD
        'subject': 'Inquiry from KisanMitra App - User: $userEmail', // Subject with user email
        'body': 'Dear KisanMitra Support,\n\nI am writing to you from the KisanMitra app. ', // Pre-filled body
=======
        'subject': 'Inquiry from KisanMitra App - User: $userEmail',
        'body': 'Dear KisanMitra Support,\n\nI am writing to you from laborator the KisanMitra app. ',
>>>>>>> b11e7d7 (first commit)
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
<<<<<<< HEAD
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Could not launch email client. Please ensure you have an email app installed.')),
      );
    }
  }

  // You can add more social media links or contact options here
=======
      _showSnackBar('Could not launch email client. Please ensure you have an email app installed.');
    }
  }

>>>>>>> b11e7d7 (first commit)
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
<<<<<<< HEAD
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor, // Use your app's background color
      appBar: AppBar(
        title: Text(AppConstants.contactUs), // Use your constant for title
        backgroundColor: AppStyles.primaryColor, // Use your app's primary color
        foregroundColor: AppStyles.whiteColor, // Text color for app bar title
=======
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
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
>>>>>>> b11e7d7 (first commit)
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We'd love to hear from you!",
<<<<<<< HEAD
              style: AppStyles.headlineStyle.copyWith(color: AppStyles.textColor),
=======
              style: AppStyles.headlineStyle(context).copyWith(
                color: theme.textTheme.headlineMedium?.color,
              ),
>>>>>>> b11e7d7 (first commit)
            ),
            const SizedBox(height: AppStyles.defaultPadding),
            Text(
              "If you have any questions, feedback, or need assistance, please feel free to reach out to us through the options below.",
<<<<<<< HEAD
              style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor),
            ),
            const SizedBox(height: AppStyles.largePadding),

            // Email Option
            _buildContactOption(
              icon: FontAwesomeIcons.solidEnvelope, // Font Awesome Gmail icon
=======
              style: AppStyles.bodyTextStyle(context).copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: AppStyles.largePadding),

            _buildContactOption(
              icon: FontAwesomeIcons.solidEnvelope,
>>>>>>> b11e7d7 (first commit)
              title: "Email Us",
              subtitle: "Send us an email directly from your app.",
              onTap: _launchEmail,
            ),
            const SizedBox(height: AppStyles.defaultPadding),

<<<<<<< HEAD
            // Optional: Phone Call
            _buildContactOption(
              icon: FontAwesomeIcons.phone, // Font Awesome phone icon
              title: "Call Us",
              subtitle: "Connect with us via phone for urgent queries.",
              onTap: () => _launchURL('tel:+923087655076'), // Replace with your actual phone number
            ),
            const SizedBox(height: AppStyles.defaultPadding),

            // Optional: WhatsApp
            _buildContactOption(
              icon: FontAwesomeIcons.whatsapp, // Font Awesome WhatsApp icon
              title: "WhatsApp",
              subtitle: "Chat with us on WhatsApp.",
              onTap: () => _launchURL('https://wa.me/923087655076'), // Replace with your actual WhatsApp number
=======
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
>>>>>>> b11e7d7 (first commit)
            ),
            const SizedBox(height: AppStyles.largePadding),

            Center(
              child: Text(
                "KisanMitra - Your Farming Companion",
<<<<<<< HEAD
                style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor.withOpacity(0.7)),
=======
                style: AppStyles.bodyTextStyle(context).copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
>>>>>>> b11e7d7 (first commit)
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
<<<<<<< HEAD
=======
    final theme = Theme.of(context);

>>>>>>> b11e7d7 (first commit)
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
<<<<<<< HEAD
              FaIcon(icon, size: 30, color: AppStyles.primaryColor), // Using FaIcon for Font Awesome
=======
              FaIcon(
                icon,
                size: 30,
                color: theme.colorScheme.primary,
              ),
>>>>>>> b11e7d7 (first commit)
              const SizedBox(width: AppStyles.defaultPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
<<<<<<< HEAD
                      style: AppStyles.subTitleStyle.copyWith(color: AppStyles.textColor),
=======
                      style: AppStyles.subTitleStyle(context).copyWith(
                        color: theme.textTheme.titleMedium?.color,
                      ),
>>>>>>> b11e7d7 (first commit)
                    ),
                    const SizedBox(height: AppStyles.smallPadding / 2),
                    Text(
                      subtitle,
<<<<<<< HEAD
                      style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor),
=======
                      style: AppStyles.bodyTextStyle(context).copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
>>>>>>> b11e7d7 (first commit)
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
<<<<<<< HEAD
              const Icon(Icons.arrow_forward_ios, color: AppStyles.lightTextColor, size: 20),
=======
              Icon(
                Icons.arrow_forward_ios,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                size: 20,
              ),
>>>>>>> b11e7d7 (first commit)
            ],
          ),
        ),
      ),
    );
  }
}