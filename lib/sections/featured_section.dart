import 'package:flutter/material.dart';
import '../data/project_data.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/animated_on_scroll.dart';
import '../widgets/featured_project_card.dart';
import '../widgets/section_header.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final projects = ProjectData.featured;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.contentPadding(context),
        vertical: AppConstants.sectionSpacing,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'The Big Ones',
                subtitle: 'Projects I\'m most proud of.',
              ),
              const SizedBox(height: 48),
              if (isMobile)
                Column(
                  children: [
                    for (int i = 0; i < projects.length; i++) ...[
                      AnimatedOnScroll(
                        delay: Duration(
                            milliseconds: i * AppConstants.staggerDelay.inMilliseconds),
                        child: FeaturedProjectCard(project: projects[i]),
                      ),
                      if (i < projects.length - 1) const SizedBox(height: 24),
                    ],
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < projects.length; i++) ...[
                      Expanded(
                        child: AnimatedOnScroll(
                          delay: Duration(
                              milliseconds: i * AppConstants.staggerDelay.inMilliseconds),
                          child: FeaturedProjectCard(project: projects[i]),
                        ),
                      ),
                      if (i < projects.length - 1) const SizedBox(width: 24),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
