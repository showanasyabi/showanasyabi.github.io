# 0) See what's going on (optional)
test -f .gitmodules && cat .gitmodules || echo "No .gitmodules file"
ls -la mywebpage/.git || echo "no mywebpage/.git"

# 1) Unstage the submodule entry from git (keeps files on disk)
git rm --cached mywebpage

# 2) Remove the submodule metadata directory
rm -rf .git/modules/mywebpage

# 3) If a .gitmodules file exists, remove the section for mywebpage (or delete the file if it's only that submodule)
git config -f .gitmodules --remove-section submodule.mywebpage 2>/dev/null || true
# If .gitmodules is now empty, you can remove it:
[ -s .gitmodules ] || rm -f .gitmodules

# 4) If the nested folder has its own .git (this makes it a submodule), delete it so it becomes a normal folder
# Sometimes it's a file pointing to ../.git/modules/...
rm -rf mywebpage/.git

# 5) Commit the cleanup and push
git add -A
git commit -m "Remove stray submodule 'mywebpage' and make it a normal folder"
git push
