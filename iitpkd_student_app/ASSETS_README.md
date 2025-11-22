# 📦 Assets Setup Instructions

## ❌ Current State: Assets Missing

The following assets are **referenced in pubspec.yaml but NOT present**:

### 1. Fonts (4 files missing)
- `assets/fonts/Poppins-Regular.ttf`
- `assets/fonts/Poppins-Medium.ttf`
- `assets/fonts/Poppins-SemiBold.ttf`
- `assets/fonts/Poppins-Bold.ttf`

### 2. Images (optional but recommended)
- App logo/icon
- Placeholder images

### 3. PDFs (✅ NOW FIXED)
- ✅ `00_Slot_system.pdf` - Copied to app root
- ✅ `MESS_MENU.pdf` - Copied to app root
- ✅ `bus schedule.pdf` - Copied to app root

---

## 🔧 How to Fix

### Option 1: Download Poppins Fonts (Recommended)

1. **Go to Google Fonts:**
   - https://fonts.google.com/specimen/Poppins

2. **Download the font family**
   - Click "Get font" → "Download all"

3. **Extract and copy files:**
   ```bash
   cd ~/Downloads/Poppins  # or wherever you extracted
   cp Poppins-Regular.ttf iitpkd_student_app/assets/fonts/
   cp Poppins-Medium.ttf iitpkd_student_app/assets/fonts/
   cp Poppins-SemiBold.ttf iitpkd_student_app/assets/fonts/
   cp Poppins-Bold.ttf iitpkd_student_app/assets/fonts/
   ```

### Option 2: Use System Default Font (Quick Fix)

Edit `pubspec.yaml` and **comment out** the fonts section:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/data/
    - 00_Slot_system.pdf
    - MESS_MENU.pdf
    - bus schedule.pdf

  # fonts:  # COMMENTED OUT - using default font
  #   - family: Poppins
  #     fonts:
  #       - asset: assets/fonts/Poppins-Regular.ttf
  #       - asset: assets/fonts/Poppins-Medium.ttf
  #         weight: 500
  #       - asset: assets/fonts/Poppins-SemiBold.ttf
  #         weight: 600
  #       - asset: assets/fonts/Poppins-Bold.ttf
  #         weight: 700
```

Also update `lib/core/theme/app_theme.dart`:

```dart
// Remove this line from both themes:
// fontFamily: 'Poppins',
```

### Option 3: Use initialize_project.sh

The `initialize_project.sh` script can download fonts automatically (if you add that functionality).

---

## 📱 Adding App Logo (Optional)

1. Create or download an IIT Palakkad logo
2. Save as: `assets/images/logo.png`
3. Use in splash screen or app bar

---

## ✅ Verification

After adding fonts, verify with:

```bash
ls -la assets/fonts/
# Should show:
# Poppins-Regular.ttf
# Poppins-Medium.ttf
# Poppins-SemiBold.ttf
# Poppins-Bold.ttf
```

Then rebuild:
```bash
flutter pub get
flutter build apk --release
```

---

## 🚨 Current Build Impact

**Without fonts, the build will FAIL with:**
```
Error: Unable to load asset: assets/fonts/Poppins-Regular.ttf
```

**Quick fix to build now:**
- Use Option 2 above (comment out fonts in pubspec.yaml)
- Or download fonts (Option 1)

---

## 📋 Complete Asset Checklist

- [ ] Download Poppins fonts from Google Fonts
- [ ] Copy 4 font files to `assets/fonts/`
- [ ] (Optional) Add app logo to `assets/images/`
- [x] PDFs copied to app root ✅
- [ ] Run `flutter pub get`
- [ ] Run `flutter build apk --release`

---

## 💡 Note

The **Dart code is 100% correct**. Assets are just missing files that need to be downloaded separately (fonts) or are optional (images).

Once fonts are added, the app will build successfully!
