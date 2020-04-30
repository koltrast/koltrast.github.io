git checkout build -- site &&
git checkout build -- docs &&
mv site/404.txt site/not_found.txt
rm -f site/blog/mk-blog &&
sed -i 's+koltrast.github.io+koltrast.neocities.org+g' site/blog/blog.xml &

