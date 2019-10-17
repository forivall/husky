#!/bin/sh

set -e
set -x

mkdir -p repos/repo
cd repos/repo
git init
git config user.name 'Test User'
git config user.email 'test@example.org'
cp ../package.json .
npm i
git add package.json
[ -f package-lock.json ] && git add package-lock.json
git commit -m 'init'

mkdir -p ../workdirs
git worktree add ../workdirs/workdir
# Preparing worktree (new branch 'workdir')
# HEAD is now at 6b8dab8 init
# Can't find Husky, skipping post-checkout hook
# You can reinstall it using 'npm install husky --save-dev' or delete this hook
cd  ../workdirs/workdir
npm i
cd - # back to "repo" folder
echo 'node_modules' >> .gitignore
git add .gitignore

# I expected this to error on the hook, but it didn't
git commit -m 'add gitignore'
