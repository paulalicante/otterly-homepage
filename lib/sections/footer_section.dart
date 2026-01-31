import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OtterlyColors.sand.withOpacity(0.4),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.contentPadding(context),
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: Column(
            children: [
              // Otter wave
              const Text('🦦', style: TextStyle(fontSize: 36)),
              const SizedBox(height: 20),

              // Contact links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FooterLink(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    onTap: () => _launch(AppConstants.emailAddress),
                  ),
                  const SizedBox(width: 32),
                  _FooterLink(
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: () => _launch(AppConstants.githubUrl),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Tagline
              Text(
                'Built with Flutter & a lot of coffee',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: OtterlyColors.textLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\u00a9 2026 Paul Ward',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: OtterlyColors.textLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _FooterLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FooterLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 18,
              color: _hovering ? OtterlyColors.coral : OtterlyColors.textMedium,
            ),
            const SizedBox(width: 6),
            Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color:
                    _hovering ? OtterlyColors.coral : OtterlyColors.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
