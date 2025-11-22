#!/bin/bash
# Setup, Build APK, and Run Script for IIT Palakkad Student App

echo "========================================="
echo "IIT Palakkad Student App - Setup & Build"
echo "========================================="
echo ""

# Navigate to the app directory
cd /home/user/IIT_PKD_Student/iitpkd_student_app

echo "✓ Changed to app directory"
echo ""

# Clean any previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

echo "✓ Clean complete"
echo ""

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

echo "✓ Dependencies installed"
echo ""

# Ask user what they want to do
echo "========================================="
echo "What would you like to do?"
echo "========================================="
echo "1) Build APK (Release)"
echo "2) Build APK (Debug)"
echo "3) Run on connected device"
echo "4) Build APK and Run"
echo "5) Exit"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo ""
        echo "🔨 Building Release APK..."
        echo "This may take a few minutes..."
        echo ""
        flutter build apk --release

        if [ $? -eq 0 ]; then
            echo ""
            echo "========================================="
            echo "✅ APK BUILD SUCCESSFUL!"
            echo "========================================="
            echo ""
            echo "📱 APK Location:"
            echo "build/app/outputs/flutter-apk/app-release.apk"
            echo ""
            echo "📊 APK Size:"
            ls -lh build/app/outputs/flutter-apk/app-release.apk | awk '{print $5}'
            echo ""
            echo "You can install this APK on your Android device!"
            echo ""
        else
            echo ""
            echo "❌ APK build failed. Check the errors above."
            echo ""
        fi
        ;;

    2)
        echo ""
        echo "🔨 Building Debug APK..."
        echo ""
        flutter build apk --debug

        if [ $? -eq 0 ]; then
            echo ""
            echo "========================================="
            echo "✅ DEBUG APK BUILD SUCCESSFUL!"
            echo "========================================="
            echo ""
            echo "📱 APK Location:"
            echo "build/app/outputs/flutter-apk/app-debug.apk"
            echo ""
            echo "📊 APK Size:"
            ls -lh build/app/outputs/flutter-apk/app-debug.apk | awk '{print $5}'
            echo ""
        else
            echo ""
            echo "❌ APK build failed. Check the errors above."
            echo ""
        fi
        ;;

    3)
        echo ""
        echo "🚀 Launching app on connected device..."
        echo ""
        echo "Available devices:"
        flutter devices
        echo ""
        flutter run
        ;;

    4)
        echo ""
        echo "🔨 Building Release APK..."
        echo ""
        flutter build apk --release

        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ APK built successfully!"
            echo "📱 Location: build/app/outputs/flutter-apk/app-release.apk"
            echo ""
            echo "🚀 Now launching app on connected device..."
            echo ""
            flutter run --release
        else
            echo ""
            echo "❌ APK build failed. Check the errors above."
            echo ""
        fi
        ;;

    5)
        echo "Exiting..."
        exit 0
        ;;

    *)
        echo "Invalid choice. Please run the script again and choose 1-5."
        exit 1
        ;;
esac

echo ""
echo "========================================="
echo "Done!"
echo "========================================="
