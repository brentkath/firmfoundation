#!/usr/bin/env bash
# — STEP 1: Navigate to your Rails project directory
cd ~/myapp

# — STEP 2: Add or update the Git remote for your GitHub repo
# Replace with your actual GitHub repo URL if different
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/BrentleyKath/firmfoundation.git

# — STEP 3: Push your main branch to GitHub, setting upstream
git push -u origin main

# — STEP 4: Confirm the remote and branches
git remote -v

echo "✅ Remote origin set and main branch pushed." 