import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/gradient_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onCtaTap;

  const HeroSection({super.key, required this.onCtaTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    final curved = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(curved);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 30),
      end: Offset.zero,
    ).animate(curved);

    // Start animation after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(minHeight: screenHeight * 0.85),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.contentPadding(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: AnimatedBuilder(
            animation: _fadeController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnim.value,
                child: Transform.translate(
                  offset: _slideAnim.value,
                  child: child,
                ),
              );
            },
            child: isMobile ? _buildMobile(context) : _buildDesktop(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        // Left: text content
        Expanded(
          flex: 3,
          child: _buildTextContent(context),
        ),
        const SizedBox(width: 60),
        // Right: decorative otter placeholder
        Expanded(
          flex: 2,
          child: _buildOtterPlaceholder(),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        _buildOtterPlaceholder(),
        const SizedBox(height: 40),
        _buildTextContent(context),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, I'm Paul.",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 40 : 56,
              ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 16),
        Text(
          'I build tools that make life a little easier\n'
          '— and sometimes a lot more fun.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: isMobile ? 17 : 20,
                height: 1.5,
              ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 12),
        Text(
          'Based in sunny Alicante, Spain.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: OtterlyColors.textLight,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 36),
        GradientButton(
          label: 'See what I\'ve built',
          icon: Icons.arrow_downward_rounded,
          onPressed: widget.onCtaTap,
        ),
      ],
    );
  }

  Widget _buildOtterPlaceholder() {
    return Image.asset(
      'assets/images/otter_mascot.png',
      width: 280,
      height: 280,
      fit: BoxFit.contain,
    );
  }
}
