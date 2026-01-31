import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'sections/hero_section.dart';
import 'sections/featured_section.dart';
import 'sections/mimanitas_showcase_section.dart';
import 'sections/tools_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';
import 'widgets/nav_bar.dart';
import 'utils/constants.dart';

void main() {
  runApp(const OtterlyApp());
}

class OtterlyApp extends StatelessWidget {
  const OtterlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paul Ward | ward.no',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  // Section keys for scroll navigation
  final _projectsKey = GlobalKey();
  final _toolsKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    GlobalKey? key;
    switch (section) {
      case 'top':
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        );
        return;
      case AppConstants.sectionProjects:
        key = _projectsKey;
        break;
      case AppConstants.sectionTools:
        key = _toolsKey;
        break;
      case AppConstants.sectionAbout:
        key = _aboutKey;
        break;
      case AppConstants.sectionContact:
        key = _contactKey;
        break;
    }

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero
                HeroSection(
                  onCtaTap: () =>
                      _scrollToSection(AppConstants.sectionProjects),
                ),

                // Featured projects
                Container(
                  key: _projectsKey,
                  child: const FeaturedSection(),
                ),

                // MiManitas deep dive
                const MiManitasShowcaseSection(),

                // Tools
                Container(
                  key: _toolsKey,
                  child: const ToolsSection(),
                ),

                // About
                Container(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),

                // Contact form
                Container(
                  key: _contactKey,
                  child: const ContactSection(),
                ),

                // Footer
                const FooterSection(),
              ],
            ),
          ),

          // Sticky nav bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollOffset: _scrollOffset,
              onNavTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}
