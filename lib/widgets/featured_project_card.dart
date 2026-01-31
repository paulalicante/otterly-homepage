import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../models/project.dart';
import 'tech_chip.dart';

class FeaturedProjectCard extends StatefulWidget {
  final Project project;

  const FeaturedProjectCard({super.key, required this.project});

  @override
  State<FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<FeaturedProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

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

              // Live link
              if (p.liveUrl != null) ...[
                const SizedBox(height: 20),
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
              ],
            ],
          ),
        ),
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
