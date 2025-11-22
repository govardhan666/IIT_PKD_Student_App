# 🚀 Quick Start Guide - IIT Palakkad Student App

## ⚠️ If You're Seeing the Flutter Counter Demo

Don't panic! The app is correctly built. You just need to follow these steps:

---

## 📋 Step-by-Step Setup

### **Option 1: Use the Run Script (Recommended)** ⭐

```bash
cd /home/user/IIT_PKD_Student/iitpkd_student_app
./run_app.sh
```

This interactive script will give you options to:
1. **Build APK (Release)** - For installation on devices
2. **Build APK (Debug)** - For testing
3. **Run on connected device** - Direct development mode
4. **Build APK and Run** - Build + run in one step
5. **Exit**

### **Option 2: Manual Setup**

```bash
# 1. Navigate to the app directory
cd /home/user/IIT_PKD_Student/iitpkd_student_app

# 2. Clean previous builds
flutter clean

# 3. Install dependencies
flutter pub get

# 4. Build APK (choose one)
flutter build apk --release    # For production
flutter build apk --debug      # For testing

# OR run directly on device
flutter run
```

---

## 📱 Building the APK

### **Release APK (Recommended for Installation)**

```bash
cd /home/user/IIT_PKD_Student/iitpkd_student_app
flutter build apk --release
```

**Output:** `build/app/outputs/flutter-apk/app-release.apk`

- Optimized and minified
- Smaller file size
- Production ready
- Install on any Android device

### **Debug APK (For Testing)**

```bash
flutter build apk --debug
```

**Output:** `build/app/outputs/flutter-apk/app-debug.apk`

- Includes debugging symbols
- Larger file size
- Easier to debug

### **Installing the APK**

1. **Transfer to your phone:**
   - USB cable
   - Email
   - Cloud storage
   - ADB: `adb install build/app/outputs/flutter-apk/app-release.apk`

2. **Enable "Install from Unknown Sources"** in your phone settings

3. **Tap the APK file** and install

---

## 🔍 Troubleshooting

### **Still seeing Flutter Demo?**

If you're still seeing the counter demo after following the steps above, try:

1. **Stop the app completely**
   - Press `Ctrl + C` in terminal
   - Or close the app on your device

2. **Clear app data on device**
   - Go to Settings → Apps → Flutter Demo → Clear Data
   - Or uninstall the app completely

3. **Run with full rebuild**
   ```bash
   flutter run --no-hot-reload
   ```

4. **Run in release mode**
   ```bash
   flutter run --release
   ```

5. **Use the APK instead**
   ```bash
   ./run_app.sh
   # Choose option 1 to build APK
   # Then install the APK on your device
   ```

---

## ✅ Verify It's Working

Once the app launches correctly, you should see:

1. **Splash Screen**
   - IIT Palakkad logo (school icon)
   - "IIT Palakkad" title in blue
   - "Student Portal" subtitle
   - Loading indicator

2. **Login Page** (after 2 seconds)
   - Clean white/dark background
   - "IIT Palakkad" title
   - "Student Portal" subtitle
   - Username/Roll Number field
   - Password field
   - Login button
   - "Need help?" button

**NOT** the Flutter counter demo with "Flutter Demo Home Page"!

---

## 📱 App Structure

Once logged in, you'll see 5 bottom navigation tabs:

1. 🏠 **Home** - Weather, Classes, Quick Access
2. 📅 **Timetable** - Your weekly schedule
3. 🚌 **Bus** - Bus schedules
4. 🍽️ **Mess** - Mess menu
5. 👤 **Account** - Profile & settings

---

## 🐛 Common Issues & Solutions

### **Issue: Dependencies not installing**
```bash
flutter pub cache repair
flutter pub get
```

### **Issue: Build errors**
```bash
flutter clean
flutter pub get
flutter run
```

### **Issue: App won't start**
- Check Flutter version: `flutter --version`
- Check device connection: `flutter devices`
- Update Flutter: `flutter upgrade`

### **Issue: APK build fails**
```bash
# Make sure Android SDK is installed
flutter doctor

# Accept Android licenses
flutter doctor --android-licenses

# Try building again
flutter clean
flutter pub get
flutter build apk --release
```

### **Issue: "App not installed" when installing APK**
- Uninstall any previous version first
- Enable "Install from Unknown Sources"
- Check if APK is corrupted (re-download/rebuild)

---

## 📞 Need Help?

1. Check `README.md` for full documentation
2. Check `PROJECT_SUMMARY.md` for project details
3. Verify you're in the correct directory:
   ```bash
   pwd
   # Should show: /home/user/IIT_PKD_Student/iitpkd_student_app
   ```

4. Verify main.dart is correct:
   ```bash
   head -30 lib/main.dart
   # Should show IITPKDStudentApp, not MyApp
   ```

---

## 🎯 Expected vs Wrong

### ✅ CORRECT (IIT Palakkad App)
- App icon: School building icon
- App bar says: "IIT Palakkad"
- Has login page with username/password
- Material 3 design with blue/orange colors
- Bottom nav with 5 tabs (Home, Timetable, Bus, Mess, Account)
- Splash screen with loading

### ❌ WRONG (Flutter Demo)
- App bar says: "Flutter Demo Home Page"
- Has counter with + button
- "You have pushed the button this many times: X"
- Material 2 design with purple theme
- No bottom navigation
- No login page

---

## 💡 Pro Tips

1. **Always run from the correct directory**
   ```bash
   cd /home/user/IIT_PKD_Student/iitpkd_student_app
   ```

2. **Use the interactive script for convenience**
   ```bash
   ./run_app.sh
   ```

3. **Build APK for easy distribution**
   - Share the APK file with other students
   - No need for Flutter on their devices
   - Just install and use!

4. **Use hot reload during development**
   - Press `r` in terminal for hot reload
   - Press `R` for hot restart
   - Press `q` to quit

5. **Check logs if something's wrong**
   ```bash
   flutter logs
   ```

---

## 🚀 Quick Commands Reference

```bash
# Setup and run (interactive)
./run_app.sh

# Build release APK
flutter build apk --release

# Build debug APK
flutter build apk --debug

# Run on device
flutter run

# Run in release mode
flutter run --release

# Clean and rebuild
flutter clean && flutter pub get && flutter run

# Check connected devices
flutter devices

# View logs
flutter logs

# Check Flutter setup
flutter doctor
```

---

## 📦 APK Locations

After building, find your APK here:

- **Release APK:** `build/app/outputs/flutter-apk/app-release.apk`
- **Debug APK:** `build/app/outputs/flutter-apk/app-debug.apk`

**File Size:**
- Release: ~20-30 MB (optimized)
- Debug: ~40-50 MB (with debug symbols)

---

**If you're still seeing the counter demo after all this, please share:**
- Your current directory (`pwd`)
- First 30 lines of `lib/main.dart`
- Output of `flutter run`

The IIT Palakkad Student App is definitely there and correctly built! 🎉
