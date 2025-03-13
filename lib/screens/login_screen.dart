import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // In a real app, you would handle authentication here
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    const Color.fromARGB(255, 37, 38, 66),
                    const Color.fromARGB(255, 24, 22, 47),
                  ]
                : [
                    const Color.fromARGB(255, 245, 245, 250),
                    const Color.fromARGB(255, 235, 235, 245),
                  ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo and App Name
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDarkMode
                                  ? Colors.black.withOpacity(0.3)
                                  : Colors.white,
                              border: Border.all(
                                color: const Color.fromARGB(255, 243, 109, 201)
                                    .withOpacity(0.5),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 243, 109, 201)
                                          .withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.music_note,
                              color: Color.fromARGB(255, 243, 109, 201),
                              size: 50,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "JukeVibe",
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color.fromARGB(255, 60, 60, 80),
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                              shadows: [
                                Shadow(
                                  color:
                                      const Color.fromARGB(255, 243, 109, 201)
                                          .withAlpha(178),
                                  blurRadius: 15,
                                ),
                                Shadow(
                                  color:
                                      const Color.fromARGB(255, 243, 109, 201)
                                          .withAlpha(128),
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Your music, your vibe",
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // Login Form
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color.fromARGB(255, 60, 60, 80)),
                              decoration: InputDecoration(
                                labelText: 'Email or Username',
                                labelStyle: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.7)
                                        : Colors.grey.shade600),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.grey.shade600,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 243, 109, 201),
                                  ),
                                ),
                                filled: true,
                                fillColor: isDarkMode
                                    ? Colors.black.withOpacity(0.2)
                                    : Colors.white,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email or username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color.fromARGB(255, 60, 60, 80)),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.7)
                                        : Colors.grey.shade600),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.grey.shade600,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.7)
                                        : Colors.grey.shade600,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 243, 109, 201),
                                  ),
                                ),
                                filled: true,
                                fillColor: isDarkMode
                                    ? Colors.black.withOpacity(0.2)
                                    : Colors.white,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),

                            // Remember Me and Forgot Password
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Checkbox(
                                          value: _rememberMe,
                                          onChanged: (value) {
                                            setState(() {
                                              _rememberMe = value ?? false;
                                            });
                                          },
                                          fillColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
                                                return const Color.fromARGB(
                                                    255, 243, 109, 201);
                                              }
                                              return isDarkMode
                                                  ? Colors.white
                                                      .withOpacity(0.3)
                                                  : Colors.grey.shade300;
                                            },
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Remember me',
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white.withOpacity(0.7)
                                              : Colors.grey.shade600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigate to forgot password screen
                                    },
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 243, 109, 201),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Login Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 243, 109, 201),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                  shadowColor:
                                      const Color.fromARGB(255, 243, 109, 201)
                                          .withOpacity(0.5),
                                ),
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // OR Divider
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.grey.shade300,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.grey.shade300,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Social Login Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            icon: Icons.g_mobiledata,
                            color: Colors.red,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            icon: Icons.facebook,
                            color: Colors.blue,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            icon: Icons.apple,
                            color: isDarkMode ? Colors.white : Colors.black,
                            onPressed: () {},
                          ),
                        ],
                      ),

                      // Sign Up Link
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to sign up screen
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 243, 109, 201),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Theme Toggle
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isDarkMode ? Icons.dark_mode : Icons.light_mode,
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey.shade600,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Theme:',
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Switch(
                              value: isDarkMode,
                              onChanged: (value) {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .toggleTheme();
                              },
                              activeColor:
                                  const Color.fromARGB(255, 243, 109, 201),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.white,
          border: Border.all(
            color: isDarkMode
                ? Colors.white.withOpacity(0.3)
                : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: color,
          size: 30,
        ),
      ),
    );
  }
}
