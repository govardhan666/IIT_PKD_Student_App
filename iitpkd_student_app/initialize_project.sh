#!/bin/bash
# Complete Project Initialization Script
# This fixes the missing Android/iOS platform files

set -e  # Exit on error

echo "========================================="
echo "IIT Palakkad Student App"
echo "Complete Project Initialization"
echo "========================================="
echo ""

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "❌ ERROR: Flutter is not installed or not in PATH"
    echo ""
    echo "Please install Flutter first:"
    echo "https://docs.flutter.dev/get-started/install"
    echo ""
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -1)"
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
APP_NAME="iitpkd_student_app"

echo "📁 Working directory: $PARENT_DIR"
echo ""

# Step 1: Backup existing lib folder
echo "📦 Step 1: Backing up existing code..."
cp -r "$SCRIPT_DIR/lib" "$PARENT_DIR/lib_backup"
cp "$SCRIPT_DIR/pubspec.yaml" "$PARENT_DIR/pubspec_backup.yaml"
cp -r "$SCRIPT_DIR"/*.md "$PARENT_DIR/" 2>/dev/null || true
cp -r "$SCRIPT_DIR"/*.sh "$PARENT_DIR/" 2>/dev/null || true
echo "✅ Code backed up to $PARENT_DIR/lib_backup"
echo ""

# Step 2: Create fresh Flutter project
echo "🔨 Step 2: Creating fresh Flutter project..."
echo "This will take a minute..."
cd "$PARENT_DIR"

# Remove old incomplete project
mv "$APP_NAME" "${APP_NAME}_old" 2>/dev/null || true

# Create new project
flutter create --org com.iitpkd --project-name "$APP_NAME" "$APP_NAME"

if [ $? -ne 0 ]; then
    echo "❌ Failed to create Flutter project"
    exit 1
fi

echo "✅ Flutter project created"
echo ""

# Step 3: Replace with our code
echo "📝 Step 3: Replacing with IIT Palakkad app code..."

# Remove default lib and pubspec
rm -rf "$APP_NAME/lib"
rm "$APP_NAME/pubspec.yaml"

# Copy our code
cp -r "$PARENT_DIR/lib_backup" "$APP_NAME/lib"
cp "$PARENT_DIR/pubspec_backup.yaml" "$APP_NAME/pubspec.yaml"

# Copy documentation and scripts
cp "$PARENT_DIR"/*.md "$APP_NAME/" 2>/dev/null || true
cp "$PARENT_DIR"/*.sh "$APP_NAME/" 2>/dev/null || true
chmod +x "$APP_NAME"/*.sh 2>/dev/null || true

echo "✅ Code replaced"
echo ""

# Step 4: Get dependencies
echo "📦 Step 4: Installing dependencies..."
cd "$APP_NAME"
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Failed to get dependencies"
    exit 1
fi

echo "✅ Dependencies installed"
echo ""

# Step 5: Clean up backups
echo "🧹 Step 5: Cleaning up..."
rm -rf "$PARENT_DIR/lib_backup"
rm "$PARENT_DIR/pubspec_backup.yaml"
rm -rf "$PARENT_DIR/${APP_NAME}_old"
echo "✅ Cleanup complete"
echo ""

# Step 6: Verify
echo "🔍 Step 6: Verifying project..."
echo ""
echo "Checking main.dart..."
if [ -f "lib/main.dart" ]; then
    head -5 lib/main.dart
    echo "✅ main.dart exists"
else
    echo "❌ main.dart missing!"
    exit 1
fi
echo ""

echo "Checking Android files..."
if [ -f "android/app/build.gradle" ]; then
    echo "✅ Android project files exist"
else
    echo "❌ Android files missing!"
    exit 1
fi
echo ""

echo "Checking iOS files..."
if [ -d "ios/Runner.xcodeproj" ]; then
    echo "✅ iOS project files exist"
else
    echo "⚠️  iOS files missing (OK if you're only building for Android)"
fi
echo ""

# Final message
echo "========================================="
echo "✅ PROJECT INITIALIZATION COMPLETE!"
echo "========================================="
echo ""
echo "📱 Your app is now ready to build!"
echo ""
echo "Next steps:"
echo "1. cd $APP_NAME"
echo "2. ./build_apk.sh"
echo "3. Choose option 1 to build release APK"
echo ""
echo "Or build manually:"
echo "flutter build apk --release"
echo ""
echo "APK will be at:"
echo "build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "========================================="
