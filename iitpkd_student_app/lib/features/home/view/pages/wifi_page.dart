import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/current_user_provider.dart';

class WiFiPage extends ConsumerStatefulWidget {
  const WiFiPage({super.key});

  @override
  ConsumerState<WiFiPage> createState() => _WiFiPageState();
}

class _WiFiPageState extends ConsumerState<WiFiPage> {
  bool _isLoading = false;
  String? _message;
  bool? _isConnected;

  Future<void> _performAutoLogin() async {
    setState(() {
      _isLoading = true;
      _message = null;
    });

    try {
      final credentials = await ref
          .read(currentUserProvider.notifier)
          .getCredentials();

      final username = credentials['username'];
      final password = credentials['password'];

      if (username == null || password == null) {
        setState(() {
          _isLoading = false;
          _message = 'No credentials found. Please login again.';
          _isConnected = false;
        });
        return;
      }

      // Attempt WiFi login
      final response = await http.post(
        Uri.parse(AppConstants.wifiLoginUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'password': password,
          'action': 'login',
        },
      );

      if (response.statusCode == 200 &&
          !response.body.contains('error') &&
          !response.body.contains('failed')) {
        setState(() {
          _isLoading = false;
          _message = 'Successfully connected to WiFi!';
          _isConnected = true;
        });
      } else {
        setState(() {
          _isLoading = false;
          _message =
              'Failed to connect to WiFi. Please check your credentials or try connecting manually.';
          _isConnected = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _message = 'Error: ${e.toString()}';
        _isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WiFi Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.wifi_copy,
                size: 80,
                color: _isConnected == true
                    ? Colors.green
                    : theme.colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'Automatic WiFi Login',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Connect to IIT Palakkad WiFi automatically',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Status message
              if (_message != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isConnected == true
                        ? Colors.green.withOpacity(0.1)
                        : theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isConnected == true
                            ? Icons.check_circle
                            : Icons.error_outline,
                        color: _isConnected == true
                            ? Colors.green
                            : theme.colorScheme.error,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _message!,
                          style: TextStyle(
                            color: _isConnected == true
                                ? Colors.green
                                : theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_message != null) const SizedBox(height: 24),

              // Connect button
              FilledButton.icon(
                onPressed: _isLoading ? null : _performAutoLogin,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Iconsax.wifi_copy),
                label: Text(_isLoading ? 'Connecting...' : 'Connect to WiFi'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Info card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'How it works',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '1. Make sure you are connected to IIT Palakkad WiFi network\n\n'
                        '2. Tap the "Connect to WiFi" button\n\n'
                        '3. The app will automatically authenticate using your credentials\n\n'
                        '4. Once connected, you can access the internet',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
