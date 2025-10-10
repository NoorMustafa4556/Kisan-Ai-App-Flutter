import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome

import '../Utils/AppStyles.dart'; // Assuming AppStyles contains your color/style definitions
import '../Utils/AppConstants.dart'; // Assuming AppConstants contains app name etc.
import 'package:provider/provider.dart'; // For accessing AuthProvider
import '../Providers/AuthProvider.dart'; // Import AuthProvider

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // Function to launch email client
  void _launchEmail() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userEmail = authProvider.user?.email ?? ''; // Get user's registered email

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'noormustafa4556@gmail.com',
      queryParameters: {
        'subject': 'Inquiry from KisanMitra App - User: $userEmail', // Subject with user email
        'body': 'Dear KisanMitra Support,\n\nI am writing to you from the KisanMitra app. ', // Pre-filled body
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Could not launch email client. Please ensure you have an email app installed.')),
      );
    }
  }

  // You can add more social media links or contact options here
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppStyles.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We'd love to hear from you!",
              style: AppStyles.headlineStyle.copyWith(color: AppStyles.textColor),
            ),
            const SizedBox(height: AppStyles.defaultPadding),
            Text(
              "If you have any questions, feedback, or need assistance, please feel free to reach out to us through the options below.",
              style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor),
            ),
            const SizedBox(height: AppStyles.largePadding),

            // Email Option
            _buildContactOption(
              icon: FontAwesomeIcons.solidEnvelope, // Font Awesome Gmail icon
              title: "Email Us",
              subtitle: "Send us an email directly from your app.",
              onTap: _launchEmail,
            ),
            const SizedBox(height: AppStyles.defaultPadding),

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
            ),
            const SizedBox(height: AppStyles.largePadding),

            Center(
              child: Text(
                "KisanMitra - Your Farming Companion",
                style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor.withOpacity(0.7)),
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
              FaIcon(icon, size: 30, color: AppStyles.primaryColor), // Using FaIcon for Font Awesome
              const SizedBox(width: AppStyles.defaultPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.subTitleStyle.copyWith(color: AppStyles.textColor),
                    ),
                    const SizedBox(height: AppStyles.smallPadding / 2),
                    Text(
                      subtitle,
                      style: AppStyles.bodyTextStyle.copyWith(color: AppStyles.lightTextColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: AppStyles.lightTextColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}