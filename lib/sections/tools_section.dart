import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../data/project_data.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/animated_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/tool_project_card.dart';

class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = ProjectData.tools;
    final crossAxisCount = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Tools I Built When I Needed Them',
                subtitle:
                    'Each one started as a "wouldn\'t it be nice if..." moment.',
              ),
              const SizedBox(height: 48),
              _buildGrid(tools, crossAxisCount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List tools, int crossAxisCount) {
    final rows = <List>[];
    for (var i = 0; i < tools.length; i += crossAxisCount) {
      rows.add(
        tools.sublist(
          i,
          i + crossAxisCount > tools.length ? tools.length : i + crossAxisCount,
        ),
      );
    }

    return Column(
      children: [
        for (int r = 0; r < rows.length; r++) ...[
          _buildRow(rows[r], crossAxisCount, r),
          if (r < rows.length - 1) const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildRow(List items, int crossAxisCount, int rowIndex) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < crossAxisCount; i++) ...[
            Expanded(
              child: i < items.length
                  ? AnimatedOnScroll(
                      delay: Duration(
                        milliseconds:
                            (rowIndex * crossAxisCount + i) *
                                AppConstants.staggerDelay.inMilliseconds,
                      ),
                      child: ToolProjectCard(project: items[i]),
                    )
                  : const SizedBox(),
            ),
            if (i < crossAxisCount - 1) const SizedBox(width: 20),
          ],
        ],
      ),
    );
  }
}
