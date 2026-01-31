import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/animated_on_scroll.dart';

class MiManitasShowcaseSection extends StatelessWidget {
  const MiManitasShowcaseSection({super.key});

  static const _features = [
    _Feature(
      icon: Icons.payments_outlined,
      title: 'End-to-End Payments',
      description:
          'Full Stripe Connect integration with escrow, instant payouts, '
          'and Spanish bank validation (IBAN, DNI, NIE).',
    ),
    _Feature(
      icon: Icons.gavel_outlined,
      title: 'Spanish Legal Compliance',
      description:
          'Built from day one around Spanish labor law, DAC7 tax reporting, '
          'and GDPR — not patched in later.',
    ),
    _Feature(
      icon: Icons.calendar_month_outlined,
      title: 'Availability Calendar',
      description:
          'Helpers post when they\'re free. Seekers browse and book. '
          'No back-and-forth scheduling.',
    ),
    _Feature(
      icon: Icons.chat_outlined,
      title: 'Real-Time Messaging',
      description:
          'In-app messaging with live notifications so helpers and seekers '
          'can coordinate without sharing personal numbers.',
    ),
    _Feature(
      icon: Icons.verified_user_outlined,
      title: 'Phone Verification',
      description:
          'SMS verification via Twilio keeps the community trusted. '
          'WhatsApp notifications coming next.',
    ),
    _Feature(
      icon: Icons.language_outlined,
      title: 'Multi-Platform',
      description:
          'One Flutter codebase serves web, Android, and iOS. '
          'Live today at mimanitas.me with mobile apps to follow.',
    ),
    _Feature(
      icon: Icons.notifications_active_outlined,
      title: 'Smart Notifications',
      description:
          'Real-time alerts when new jobs are posted nearby. '
          'Helpers never miss an opportunity.',
    ),
    _Feature(
      icon: Icons.security_outlined,
      title: 'Escrow Protection',
      description:
          'Payment is held securely until the job is done. '
          'Both sides are protected.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      color: OtterlyColors.sand.withOpacity(0.3),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.contentPadding(context),
        vertical: AppConstants.sectionSpacing,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: Column(
            children: [
              // Logo + intro
              AnimatedOnScroll(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/mimanitas-wordmark.png',
                      height: isMobile ? 36 : 48,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 50,
                      height: 3,
                      decoration: BoxDecoration(
                        color: OtterlyColors.coral,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        'A full-stack marketplace — from real-time chat to Stripe payments '
                        'to Spanish legal compliance — built and launched as a solo project.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: isMobile ? 16 : 18,
                              height: 1.6,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 56),

              // Feature grid
              _buildFeatureGrid(context, isMobile, isTablet),

              const SizedBox(height: 48),

              // Bottom tagline
              AnimatedOnScroll(
                delay: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 20),
                  decoration: BoxDecoration(
                    color: OtterlyColors.warmWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: OtterlyColors.coralLight,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.rocket_launch,
                          color: OtterlyColors.coral, size: 22),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          'Launching in Alicante. Rolling out across Spain in Q2 2026. '
                          'Looking for partners internationally.',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: OtterlyColors.textDark,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureGrid(
      BuildContext context, bool isMobile, bool isTablet) {
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 4);
    final rows = <Widget>[];

    for (int i = 0; i < _features.length; i += crossAxisCount) {
      final rowItems = <Widget>[];
      for (int j = i; j < i + crossAxisCount && j < _features.length; j++) {
        rowItems.add(
          Expanded(
            child: AnimatedOnScroll(
              delay: Duration(milliseconds: j * 100),
              child: _FeatureCard(feature: _features[j]),
            ),
          ),
        );
        if (j < i + crossAxisCount - 1 && j < _features.length - 1) {
          rowItems.add(const SizedBox(width: 16));
        }
      }
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowItems,
      ));
      if (i + crossAxisCount < _features.length) {
        rows.add(const SizedBox(height: 16));
      }
    }

    return Column(children: rows);
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String description;

  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _FeatureCard extends StatefulWidget {
  final _Feature feature;

  const _FeatureCard({required this.feature});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: OtterlyColors.warmWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovering ? 0.08 : 0.03),
              blurRadius: _hovering ? 20 : 8,
              offset: Offset(0, _hovering ? 6 : 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: OtterlyColors.tealLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.feature.icon,
                color: OtterlyColors.teal,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.feature.title,
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: OtterlyColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.feature.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: OtterlyColors.textMedium,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
