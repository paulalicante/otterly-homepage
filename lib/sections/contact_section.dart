import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../app_theme.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/animated_on_scroll.dart';
import '../widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sending = false;
  String? _status;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      setState(() => _status = 'Please fill in all fields.');
      return;
    }

    setState(() {
      _sending = true;
      _status = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.web3forms.com/submit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'access_key': AppConstants.web3FormsKey,
          'name': name,
          'email': email,
          'message': message,
          'subject': 'New message from ward.no — $name',
        }),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        setState(() {
          _status = 'Message sent! I\'ll get back to you soon.';
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        });
      } else {
        setState(() => _status = 'Something went wrong. Please try again.');
      }
    } catch (e) {
      setState(() => _status = 'Could not send message. Please try again.');
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.contentPadding(context),
        vertical: AppConstants.sectionSpacing,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 700),
          child: AnimatedOnScroll(
            child: Column(
              children: [
                const SectionHeader(title: 'Say Hello'),
                const SizedBox(height: 16),
                Text(
                  'Got an idea, a question, or just want to chat? '
                  'Drop me a message — I\'d love to hear from you.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Form card
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: OtterlyColors.warmWhite,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!isMobile)
                        Row(
                          children: [
                            Expanded(child: _buildField('Your name', _nameController)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildField('Your email', _emailController)),
                          ],
                        )
                      else ...[
                        _buildField('Your name', _nameController),
                        const SizedBox(height: 16),
                        _buildField('Your email', _emailController),
                      ],
                      const SizedBox(height: 16),
                      _buildField('Your message', _messageController, maxLines: 5),
                      const SizedBox(height: 24),

                      // Send button
                      Align(
                        alignment: Alignment.centerRight,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _sending ? null : _sendMessage,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    OtterlyColors.coral,
                                    OtterlyColors.coralDark,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _sending ? Icons.hourglass_top : Icons.send,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _sending ? 'Sending...' : 'Send Message',
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Status message
                      if (_status != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          _status!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: OtterlyColors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        fontSize: 15,
        color: OtterlyColors.textDark,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 15,
          color: OtterlyColors.textLight,
        ),
        filled: true,
        fillColor: OtterlyColors.cream,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: OtterlyColors.sand),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: OtterlyColors.sand),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: OtterlyColors.coral, width: 2),
        ),
      ),
    );
  }
}
