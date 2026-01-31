import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/animated_on_scroll.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.contentPadding(context),
        vertical: AppConstants.sectionSpacing,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: isMobile ? _buildMobile(context) : _buildDesktop(context),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildContent(context)),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildDecorative()),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      children: [
        _buildContent(context),
        const SizedBox(height: 40),
        _buildDecorative(),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return AnimatedOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'About Me'),
          const SizedBox(height: 32),
          // Placeholder bio — user will provide their own text
          Text(
            'I live in Alicante, Spain, where the sun shines most of the year '
            'and the coffee is strong.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  height: 1.7,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'I build tools because I can\'t help it. If something could be '
            'smoother, faster, or more fun, I want to make it that way. '
            'Most of these projects started as something I personally needed, '
            'and grew from there.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  height: 1.7,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'I work with AI as a creative partner — I describe what I want, '
            'and together we bring it to life. It\'s the most exciting time '
            'to be a builder.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  height: 1.7,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorative() {
    return AnimatedOnScroll(
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: OtterlyColors.sand.withOpacity(0.5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const Text('🦦', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 16),
            Text(
              'Alicante, Spain',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: OtterlyColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Builder of apps,\ntamer of spreadsheets,\nfriend to otters.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 15,
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
