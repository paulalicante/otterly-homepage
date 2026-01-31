import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../models/project.dart';
import '../utils/responsive.dart';
import 'tech_chip.dart';

class FeaturedProjectCard extends StatefulWidget {
  final Project project;

  const FeaturedProjectCard({super.key, required this.project});

  @override
  State<FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<FeaturedProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;
  bool _expanded = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final hasShowcase = p.showcaseFeatures.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _hovering
            ? (Matrix4.identity()..translate(0, -4, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: OtterlyColors.warmWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovering ? 0.1 : 0.05),
              blurRadius: _hovering ? 30 : 15,
              offset: Offset(0, _hovering ? 12 : 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: icon + title + live badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: OtterlyColors.coralLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(p.icon, color: OtterlyColors.coral, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: p.logoAsset != null
                        ? Image.asset(
                            p.logoAsset!,
                            height: 32,
                            fit: BoxFit.contain,
                            alignment: Alignment.centerLeft,
                          )
                        : Text(
                            p.title,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                  ),
                  if (p.isLive)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: OtterlyColors.leafGreen.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: OtterlyColors.leafGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Live',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: OtterlyColors.leafGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Tagline
              Text(
                p.tagline,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 24),

              // Highlights
              ...p.highlights.map(
                (h) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.check_circle,
                          size: 18,
                          color: OtterlyColors.teal,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          h,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: OtterlyColors.textMedium,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tech chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: p.techStack.map((t) => TechChip(label: t)).toList(),
              ),

              // Live link + Show more button
              if (p.liveUrl != null || hasShowcase) ...[
                const SizedBox(height: 20),
                Row(
                  children: [
                    if (p.liveUrl != null)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _launchUrl(p.liveUrl!),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.open_in_new,
                                  size: 16, color: OtterlyColors.coral),
                              const SizedBox(width: 6),
                              Text(
                                'Visit ${p.title}',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: OtterlyColors.coral,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (p.liveUrl != null && hasShowcase)
                      const SizedBox(width: 20),
                    if (hasShowcase)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => setState(() => _expanded = !_expanded),
                          child: AnimatedBuilder(
                            animation: _pulseAnim,
                            builder: (context, child) {
                              return Opacity(
                                opacity: _expanded ? 1.0 : _pulseAnim.value,
                                child: child,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: OtterlyColors.tealLight,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _expanded
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    size: 18,
                                    color: OtterlyColors.teal,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _expanded
                                        ? 'Show less'
                                        : 'See what\'s under the hood',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: OtterlyColors.teal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],

              // Expandable showcase
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: hasShowcase
                    ? _buildShowcase(context, p.showcaseFeatures)
                    : const SizedBox.shrink(),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShowcase(
      BuildContext context, List<ShowcaseFeature> features) {
    final isMobile = Responsive.isMobile(context);
    final crossAxisCount = isMobile ? 1 : 2;

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: OtterlyColors.sand,
          ),
          const SizedBox(height: 24),
          for (int i = 0; i < features.length; i += crossAxisCount) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int j = i;
                    j < i + crossAxisCount && j < features.length;
                    j++) ...[
                  Expanded(child: _buildFeatureTile(features[j])),
                  if (j < i + crossAxisCount - 1 && j < features.length - 1)
                    const SizedBox(width: 12),
                ],
                if (i + crossAxisCount > features.length)
                  const Expanded(child: SizedBox()),
              ],
            ),
            if (i + crossAxisCount < features.length)
              const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildFeatureTile(ShowcaseFeature feature) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: OtterlyColors.cream,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: OtterlyColors.tealLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(feature.icon, color: OtterlyColors.teal, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: OtterlyColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: OtterlyColors.textMedium,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
