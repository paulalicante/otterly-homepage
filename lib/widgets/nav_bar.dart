import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';
import '../utils/responsive.dart';

class NavBar extends StatelessWidget {
  final double scrollOffset;
  final Function(String) onNavTap;

  const NavBar({
    super.key,
    required this.scrollOffset,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasBackground = scrollOffset > 50;
    final isMobile = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.contentPadding(context),
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: hasBackground
            ? OtterlyColors.cream.withOpacity(0.95)
            : Colors.transparent,
        boxShadow: hasBackground
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => onNavTap('top'),
                  child: Text(
                    'ward.no',
                    style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: OtterlyColors.textDark,
                    ),
                  ),
                ),
              ),
              // Nav links
              if (!isMobile)
                Row(
                  children: [
                    _NavLink(label: 'Projects', onTap: () => onNavTap('projects')),
                    _NavLink(label: 'Tools', onTap: () => onNavTap('tools')),
                    _NavLink(label: 'About', onTap: () => onNavTap('about')),
                    _NavLink(
                      label: 'Say Hello',
                      onTap: () => onNavTap('contact'),
                      accent: true,
                    ),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu, color: OtterlyColors.textDark),
                  onPressed: () => _showMobileMenu(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: OtterlyColors.warmWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MobileMenuItem(
                  label: 'Projects',
                  icon: Icons.star,
                  onTap: () {
                    Navigator.pop(context);
                    onNavTap('projects');
                  },
                ),
                _MobileMenuItem(
                  label: 'Tools',
                  icon: Icons.build,
                  onTap: () {
                    Navigator.pop(context);
                    onNavTap('tools');
                  },
                ),
                _MobileMenuItem(
                  label: 'About',
                  icon: Icons.person,
                  onTap: () {
                    Navigator.pop(context);
                    onNavTap('about');
                  },
                ),
                _MobileMenuItem(
                  label: 'Say Hello',
                  icon: Icons.mail,
                  onTap: () {
                    Navigator.pop(context);
                    onNavTap('contact');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool accent;

  const _NavLink({
    required this.label,
    required this.onTap,
    this.accent = false,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: widget.accent
                  ? OtterlyColors.coral
                  : _hovering
                      ? OtterlyColors.coral
                      : OtterlyColors.textMedium,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: OtterlyColors.coral),
      title: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: OtterlyColors.textDark,
        ),
      ),
      onTap: onTap,
    );
  }
}
