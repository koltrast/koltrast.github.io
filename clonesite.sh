git checkout build -- site &&
git checkout build -- docs &&
rm -f site/blog/mk-blog &&
sed -i 's+koltrast.github.io+koltrast.neocities.org+g' site/blog/blog.xml &

