GREEN='\033[1;32m'
WARNING='\033[1;33m'

echo "${GREEN}========================Analyze Start======================="
if hash fvm 2>/dev/null; then
  echo "Using fvm flutter version"
  fvm flutter format . --set-exit-if-changed
  fvm flutter analyze

else
  echo "Using local flutter version"
  flutter format . --set-exit-if-changed
  flutter analyze
fi
echo "${GREEN}========================Analyze Finish======================="
