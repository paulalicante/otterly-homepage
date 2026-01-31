import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectData {
  static const List<Project> featured = [
    Project(
      title: 'Inmersion Natural',
      tagline:
          'A language learning app that teaches you like a toddler learns — '
          'through pictures, sounds, and play. No boring grammar tables.',
      description:
          'Built for adults who want to pick up a new language efficiently. '
          'Visual-first learning with AI-generated artwork, professional-quality '
          'pronunciation, and a grammar engine that works invisibly.',
      highlights: [
        'Over 1,000 vocabulary cards today — growing to 5,000 in the full release',
        'Three ways to learn: match images, absorb grammar naturally, or practice speaking',
        'A hidden 10-stage grammar engine that teaches without ever showing a grammar label',
        'Designed for easy adaptation to any language pair — starting with English to Spanish, with Norwegian and all major languages to follow',
      ],
      techStack: ['Flask', 'AI Images', 'ElevenLabs', 'OpenAI'],
      icon: Icons.school,
      isFeatured: true,
    ),
    Project(
      title: 'MiManitas',
      tagline:
          'A local help marketplace that connects people who need a hand '
          'with skilled helpers nearby — painting, gardening, moving, you name it.',
      description:
          'MiManitas flips the gig economy model: helpers post when '
          'they\'re available, and people find trusted help close by.',
      highlights: [
        'Launching in Alicante, rolling out across all of Spain in Q2 2026',
        'Helpers post when they\'re available — flipping the traditional gig model',
        'Secure escrow payments with a 7-day satisfaction guarantee',
        'Seeking partners to bring MiManitas to other countries',
      ],
      techStack: ['Flutter', 'Supabase', 'Stripe Connect'],
      icon: Icons.handyman,
      isFeatured: true,
      isLive: true,
      liveUrl: 'https://mimanitas.me',
      logoAsset: 'assets/images/mimanitas-wordmark.png',
    ),
  ];

  static const List<Project> tools = [
    Project(
      title: 'Claude Memory',
      tagline:
          'Never lose a conversation with AI again. '
          'Captures, searches, and remembers everything.',
      highlights: [
        'Works with Claude, ChatGPT, Gemini, Copilot, and Gmail',
        'Finds people in photos using face recognition',
        'Full-text search across all your saved conversations',
      ],
      techStack: ['Python', 'PyQt6', 'SQLite', 'Chrome Extension'],
      icon: Icons.psychology,
    ),
    Project(
      title: 'Otterly Project Manager',
      tagline:
          'A command center for all my projects — '
          'tracks what\'s happening, analyzes what needs attention.',
      highlights: [
        'Web dashboard + desktop app from one codebase',
        'AI-powered project health analysis',
        'Works entirely offline on Google Drive',
      ],
      techStack: ['Flask', 'HTMX', 'Tailwind CSS'],
      icon: Icons.dashboard,
    ),
    Project(
      title: 'Otterly Launcher',
      tagline:
          'Double-tap Shift, and your favorite apps appear '
          'right where your cursor is.',
      highlights: [
        'Appears exactly at your cursor — no hunting for it',
        'Launch apps, trigger hotkeys, or paste text snippets',
      ],
      techStack: ['Python', 'CustomTkinter'],
      icon: Icons.rocket_launch,
    ),
    Project(
      title: 'Otterly Screenshots',
      tagline:
          'Screenshots that organize themselves. '
          'Capture regions, windows, or everything — with highlights.',
      highlights: [
        'Region, window, or full screen capture with global hotkeys',
        'Automatic folder organization with drag-and-drop',
        'Built-in highlight annotations',
      ],
      techStack: ['Python', 'Tkinter', 'Pillow'],
      icon: Icons.screenshot_monitor,
    ),
    Project(
      title: 'Claude Usage Monitor',
      tagline:
          'Keeps an eye on how fast you\'re burning through '
          'Claude\'s rate limits. Predicts when you\'ll run out.',
      highlights: [
        'Chrome extension — always visible in your toolbar',
        'Burn rate calculation with exhaustion countdown',
        'Color-coded so you know at a glance',
      ],
      techStack: ['JavaScript', 'Chrome Extension API'],
      icon: Icons.speed,
    ),
  ];
}
