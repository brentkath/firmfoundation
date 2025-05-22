#!/usr/bin/env bash
# — STEP 1: Navigate to your Rails project directory
cd ~/myapp

# — STEP 2: Ensure GitHub CLI is installed and authenticated
if ! command -v gh >/dev/null 2>&1; then
  echo "Error: GitHub CLI not found. Install with 'brew install gh' or from https://cli.github.com/"
  exit 1
fi

# Authenticate if needed
if ! gh auth status >/dev/null 2>&1; then
  echo "Authenticating GitHub CLI..."
  gh auth login || { echo "Failed to authenticate gh"; exit 1; }
fi

# — STEP 3: Create GitHub repository if it doesn't exist
OWNER="BrentleyKath"
REPO_NAME="firmfoundation"
FULL_REPO="$OWNER/$REPO_NAME"
if ! gh repo view "$FULL_REPO" >/dev/null 2>&1; then
  echo "Creating GitHub repo $FULL_REPO..."
  gh repo create "$FULL_REPO" --public --source=. --remote=origin --push || { echo "Repo creation failed"; exit 1; }
else
  echo "GitHub repo $FULL_REPO already exists. Setting remote..."
  git remote remove origin 2>/dev/null || true
  git remote add origin "https://github.com/$FULL_REPO.git"
  git push -u origin main || { echo "Push failed"; exit 1; }
fi

# — STEP 4: Verify remote configuration
git remote -v

echo "✅ Remote configured successfully."

# — STEP 5: Install project dependencies
bundle install || { echo "bundle install failed"; exit 1; }

echo "✅ Dependencies installed."

# — STEP 6: Free up port 3000 if occupied
lsof -i :3000 | awk 'NR>1 {print $2}' | xargs -r kill -9

echo "✅ Freed port 3000."

# — STEP 7: Start the Rails server
echo "Starting Rails server on port 3000..."
rails server -p 3000 