import 'package:crowd_counting_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/auth_bloc.dart';
import 'dashboard_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 120),
              const SizedBox(height: 24),
              Text(
                'Selamat Datang',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Silakan login untuk melanjutkan',
                style: TextStyle(color: AppColors.textLight),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty || !value.contains('@')
                          ? 'Masukkan email yang valid'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value == null || value.length < 6
                          ? 'Minimal 6 karakter'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) async {
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is AuthSuccess) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('token', state.user.token);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => DashboardPage()),
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  LoginRequested(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                            child: state is AuthLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.background,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Atau daftar dengan",
                      style: TextStyle(color: AppColors.textLight),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.envelope, color: Colors.blueGrey),
                          onPressed: () {}, // Implementasi daftar via email
                          tooltip: 'Daftar via Email',
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.google, color: Colors.red),
                          onPressed: () {}, // Implementasi daftar via Google
                          tooltip: 'Daftar via Google',
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.facebookF, color: Colors.blue),
                          onPressed: () {}, // Implementasi daftar via Facebook
                          tooltip: 'Daftar via Facebook',
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.xTwitter,
                            color: Colors.black,
                          ),
                          onPressed: () {}, // Implementasi daftar via X
                          tooltip: 'Daftar via X',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
