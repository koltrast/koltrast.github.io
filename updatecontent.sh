git checkout build -- docs/ &&
rm -rf *.txt *.html blog
git mv -f docs/* . &&
rm -r docs && git add . &&
git commit -m "updated content"
