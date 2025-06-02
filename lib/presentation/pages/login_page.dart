import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/auth_bloc.dart';
import 'dashboard_page.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value == null || value.isEmpty || !value.contains('@')
                    ? 'Masukkan email yang valid'
                    : null,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) => value == null || value.length < 6
                    ? 'Minimal 6 karakter'
                    : null,
              ),
              SizedBox(height: 16),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) async {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is AuthSuccess) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('token', state.user.token);
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => DashboardPage()),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  return state is AuthLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                LoginRequested(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                          child: Text('Login'),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
