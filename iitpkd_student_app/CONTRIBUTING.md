# Contributing to IIT Palakkad Student App

Thank you for your interest in contributing to the IIT Palakkad Student App! This document provides guidelines and instructions for contributing.

## 🤝 How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Screenshots (if applicable)
- Device and OS information

### Suggesting Features

Feature requests are welcome! Please provide:
- Clear description of the feature
- Use case and benefits
- Potential implementation approach (if you have ideas)

### Code Contributions

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the code style guidelines below
   - Write clear commit messages
   - Add comments for complex logic
   - Update documentation if needed

4. **Test your changes**
   - Ensure the app builds without errors
   - Test on both Android and iOS (if possible)
   - Test in both light and dark modes

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Provide a clear description of changes
   - Reference any related issues
   - Add screenshots for UI changes

## 📝 Code Style Guidelines

### Dart/Flutter Best Practices

- Use `const` constructors wherever possible
- Prefer final for variables that won't change
- Use meaningful variable and function names
- Keep functions small and focused
- Extract complex widgets into separate files

### File Organization

- Place new features in the `features/` directory
- Use the existing folder structure
- Keep related files together

### Naming Conventions

- **Files**: lowercase_with_underscores.dart
- **Classes**: PascalCase
- **Variables**: camelCase
- **Constants**: UPPER_CASE_WITH_UNDERSCORES

### Comments

- Add comments for complex logic
- Use doc comments (///) for public APIs
- Keep comments up-to-date with code changes

## 🧪 Testing

- Write widget tests for new features
- Ensure existing tests pass
- Test on multiple devices/emulators

## 📋 Commit Message Format

Use conventional commit messages:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

Examples:
```
feat: add attendance tracking feature
fix: resolve timetable generation issue
docs: update README with new features
```

## 🔍 Code Review Process

1. All contributions require review
2. Reviewers may request changes
3. Address feedback promptly
4. Once approved, changes will be merged

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 💬 Questions?

Feel free to open an issue for questions or reach out to the maintainers.

---

Thank you for contributing to making this app better for IIT Palakkad students!
