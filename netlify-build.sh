#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define Flutter version to use
FLUTTER_VERSION="3.22.2" # You can change this to your project's specific version

# 1. Install Flutter SDK

echo "Cloning Flutter SDK..."
git clone https://github.com/flutter/flutter.git --depth 1 --branch $FLUTTER_VERSION /opt/flutter
export PATH="$PATH:/opt/flutter/bin"

echo "Flutter SDK installed. Version:"
flutter --version

# 2. Install dependencies for Netlify Functions

echo "Installing Netlify Functions dependencies..."
if [ -f "netlify/functions/package.json" ]; then
  (cd netlify/functions && npm install)
else
  echo "No package.json found for functions, skipping npm install."
fi

# 3. Build the Flutter web application

echo "Building Flutter web app..."
flutter build web --release --dart-define=CLOVA_API_KEY=$CLOVA_API_KEY

echo "Build finished successfully."
