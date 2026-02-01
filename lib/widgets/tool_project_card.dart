import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_theme.dart';
import '../models/project.dart';
import 'tech_chip.dart';

class ToolProjectCard extends StatefulWidget {
  final Project project;

  const ToolProjectCard({super.key, required this.project});

  @override
  State<ToolProjectCard> createState() => _ToolProjectCardState();
}

class _ToolProjectCardState extends State<ToolProjectCard> {
  bool _hovering = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _hovering
            ? (Matrix4.identity()..translate(0, -3, 0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: OtterlyColors.warmWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovering
                ? OtterlyColors.coralLight
                : OtterlyColors.sand,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovering ? 0.08 : 0.03),
              blurRadius: _hovering ? 20 : 8,
              offset: Offset(0, _hovering ? 8 : 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon + title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: OtterlyColors.sand,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(p.icon, color: OtterlyColors.coral, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    p.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 19,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Tagline
            Text(
              p.tagline,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Highlights
            ...p.highlights.map(
              (h) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.arrow_right,
                        size: 16,
                        color: OtterlyColors.teal,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        h,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: OtterlyColors.textMedium,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (p.liveUrl != null) ...[
              const SizedBox(height: 14),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _launchUrl(p.liveUrl!),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.open_in_new,
                          size: 15, color: OtterlyColors.coral),
                      const SizedBox(width: 5),
                      Text(
                        'Try it live',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: OtterlyColors.coral,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const Spacer(),
            const SizedBox(height: 12),

            // Tech chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: p.techStack.map((t) => TechChip(label: t)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
