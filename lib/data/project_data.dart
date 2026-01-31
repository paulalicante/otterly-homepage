import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectData {
  static const List<Project> featured = [
    Project(
      title: 'Inmersion Natural',
      tagline:
          'A Spanish learning app that teaches you like a toddler learns — '
          'through pictures, sounds, and play. No boring grammar tables.',
      description:
          'Built for adults who want to pick up Spanish efficiently, '
          'Inmersion Natural immerses you in visual-first learning. '
          'Every word has custom AI-generated artwork, professional-quality '
          'pronunciation, and context-rich example sentences.',
      highlights: [
        '932 vocabulary cards, each with custom AI-generated artwork',
        'Three ways to learn: match images, absorb grammar naturally, or practice speaking',
        'A hidden 10-stage grammar engine that teaches without ever showing a grammar label',
        'Every word pronounced by a professional-quality AI voice',
      ],
      techStack: ['Flask', 'AI Images', 'ElevenLabs', 'OpenAI'],
      icon: Icons.school,
      isFeatured: true,
    ),
    Project(
      title: 'Mi Manitas',
      tagline:
          'A neighborhood marketplace where your neighbors help each other '
          'with everyday tasks — painting, gardening, moving, you name it.',
      description:
          'Built for real barrios in Alicante, Spain. Mi Manitas flips the '
          'gig economy model: workers post when they\'re available, and '
          'neighbors find help right around the corner.',
      highlights: [
        'Built for real neighborhoods in Alicante, Spain',
        'Workers post when they\'re free — not the other way around',
        'Secure payments held in escrow until you\'re happy',
        'Full Spanish tax compliance baked in from day one',
      ],
      techStack: ['Flutter', 'Supabase', 'Stripe Connect'],
      icon: Icons.handyman,
      isFeatured: true,
      isLive: true,
      liveUrl: 'https://mimanitas.me',
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
