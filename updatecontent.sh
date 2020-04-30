

git checkout build -- docs/ && 
git mv docs/* . &&
rm -r docs && git add . &&
git commit -m "updated content"
