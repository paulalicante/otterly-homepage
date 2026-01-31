# Otterly Homepage

## What This Is
Public portfolio/showcase website at **www.ward.no** — playful, warm "Otterly" brand showcasing Paul's projects. Two star projects (Inmersion Natural + Mi Manitas) get featured treatment; five tools get smaller cards. Single-page smooth scroll with reveal-on-scroll animations.

## Tech Stack
- **Language:** Dart
- **Framework:** Flutter Web (CanvasKit renderer)
- **Typography:** Google Fonts (Nunito headings, Inter body)
- **Packages:** google_fonts, url_launcher, visibility_detector
- **Hosting:** Vercel → custom domain www.ward.no
- **No backend, no CMS** — all content hardcoded in Dart

## How to Run
```bash
# Development
flutter pub get
flutter run -d chrome

# Production build
flutter build web --release
# Output in build/web/
```

## Project Structure
```
Otterly_Homepage/
├── pubspec.yaml
├── CLAUDE.md
├── web/
│   ├── index.html              # SEO meta tags, Open Graph, loading spinner
│   └── manifest.json           # PWA manifest
├── assets/images/              # Project screenshots, otter mascot (TBD)
├── lib/
│   ├── main.dart               # MaterialApp, scroll controller, section assembly
│   ├── app_theme.dart          # Colors (cream/coral/teal), typography, ThemeData
│   ├── data/
│   │   └── project_data.dart   # All 7 projects as typed Dart objects
│   ├── models/
│   │   └── project.dart        # Project data model
│   ├── sections/
│   │   ├── hero_section.dart       # "Hi, I'm Paul" + otter placeholder + CTA
│   │   ├── featured_section.dart   # Two star project cards side-by-side
│   │   ├── tools_section.dart      # Responsive grid of 5 tool cards
│   │   ├── about_section.dart      # Personal bio (placeholder)
│   │   └── footer_section.dart     # Contact links, copyright
│   ├── widgets/
│   │   ├── nav_bar.dart            # Sticky nav, transparent→cream on scroll
│   │   ├── featured_project_card.dart  # Large card with highlights + tech chips
│   │   ├── tool_project_card.dart      # Smaller card for tools
│   │   ├── section_header.dart     # Title + subtitle + coral underline
│   │   ├── animated_on_scroll.dart # Fade+slide reveal on scroll
│   │   ├── tech_chip.dart          # Teal pill badge
│   │   └── gradient_button.dart    # Coral gradient CTA button
│   └── utils/
│       ├── responsive.dart     # Breakpoints: mobile <600, tablet <1024, desktop
│       └── constants.dart      # Section keys, animation durations, external URLs
└── build/web/                  # Production build output
```

## Current Status (Updated: 2026-01-30)
- All 17 Dart files created and building cleanly
- Single-page scroll layout with 5 sections: Hero, Featured, Tools, About, Footer
- Sticky nav bar with smooth scroll-to-section links
- Responsive: 1-col mobile, 2-col tablet, 3-col desktop for tools grid
- Scroll-triggered fade+slide animations on all cards and sections
- Warm Otterly color palette: cream (#FFF8F0), coral (#E8785A), teal (#5BA4A4)

## Pending
- [ ] Otter mascot illustration (currently emoji placeholder)
- [ ] Project screenshots for cards
- [ ] User-provided About section bio text
- [ ] Deploy to Vercel with www.ward.no custom domain
- [ ] Favicon and PWA icons

## Color Palette (Warm Otter)
- Background cream: `#FFF8F0`
- Card white: `#FFFDF9`
- Sand (alt sections): `#F5E6D3`
- Coral (primary): `#E8785A`
- Coral light: `#FAD4C8`
- Teal (secondary): `#5BA4A4`
- Teal light: `#D4EDED`
- Text dark: `#2D3436`
- Text medium: `#636E72`
- Text light: `#99A4A8`

## Content Editing
To update project descriptions, edit `lib/data/project_data.dart`. Each project has:
- `title`, `tagline`, `description`, `highlights` (list), `techStack` (list)
- `icon` (Material icon), `isFeatured`, `isLive`, `liveUrl`

## User Preferences
- Design philosophy: playful, warm, approachable but professional
- The user is a "vibe coder" — describes what they want, Claude writes the code
- The user has limited memory — this CLAUDE.md is the single source of truth
- Always read this file FIRST when starting a new session
- Keep this file updated after every significant change

## Workflow Rules
- After every successful change, remind me to commit to git
- Do not start a new feature until the previous change is committed
- If a new feature causes a bug, debug it properly — do NOT revert without explicit approval
- Always push to origin after every commit
- For bug fixes: do NOT push until I confirm the fix works
