#!/usr/bin/env bash
# — STEP 1: Ensure GitHub CLI authentication (optional)
if command -v gh >/dev/null 2>&1; then
  echo "Checking GitHub CLI auth..."
  gh auth status || { echo "Not authenticated. Please run 'gh auth login' when prompted."; gh auth login; }
else
  echo "GitHub CLI not installed; ensure you're authenticated via HTTPS (PAT) or SSH."
fi

# — STEP 2: Remove old 'myapp' folder if broken
cd ~
rm -rf myapp

# — STEP 3: Clone your Rails project from GitHub
REPO_URL="https://github.com/BrentleyKath/firmfoundation.git"
git clone "$REPO_URL" myapp || { echo "Error: failed to clone $REPO_URL"; exit 1; }

# — STEP 4: Enter the cloned project directory
cd myapp

# — STEP 5: Verify remote URL
git remote -v

# — STEP 6: Install project dependencies
bundle install || { echo "Bundle install failed. Check Gemfile and Ruby version."; exit 1; }

# — STEP 7: Free up port 3000 if occupied
lsof -i :3000 | awk 'NR>1 {print $2}' | xargs -r kill -9

# — STEP 8: Start the Rails server
rails server -p 3000 