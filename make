#!/bin/sh -e
#
# Simple static site builder


cat <<EOF > /tmp/meow
<!doctype html>
<title>&rarr; koltrast</title>
<meta charset=utf-8>
<meta name=Koltrast is one of the alias of the French artist Aurélien Mt. …">
<style>
body{text-align:center;overflow-y:scroll;font:calc(0.50em + 1vmin) monospace}pre
pre{text-align:left;display:inline-block}
img{max-width:57ch;display:block;height:auto;width:100%}
@media(prefers-color-scheme:dark){body{background:#000;color:#fff}a{color:#6CF}}
</style>
<pre>

<a href=/><b>&rarr; KOLTRAST</b></a>  <a href=/news>News</a>  <a href=/artworks>Artworks</a>  <a href=/writings>Writings</a>  <a href=https://github.com/koltrast>Repository</a>  <a href=/blog>Blog</a>  <a href=/about>About</a> 
———————————————————————————————————————————————————————————————————————————————
   ___      ___      ___   ___      ___      ___      ___     ___          
  /\__\    /\  \    /\__\ /\  \    /\  \    /\  \    /\  \   /\  \\         
 /:/ _/_  /::\  \  /:/  / \:\  \  /::\  \  /::\  \  /::\  \  \:\  \\        
/::-"\__\/:/\:\__\/:/__/  /::\__\/::\:\__\/::\:\__\/\:\:\__\ /::\__\\       
\;:;-",-"\:\/:/  /\:\  \ /:/\/__/\;:::/  /\/\::/  /\:\:\/__//:/\/__/        
 |:|  |   \::/  /  \:\__\\\/__/    |:\/__/   /:/  /  \::/  / \/__/           
  \|__|    \/__/    \/__/          \|__|    \/__/    \/__/      .GITHUB.IO  
———————————————————————————————————————————————————————————————————————————————

<pre>
%%CONTENT%%

_______________________________________________________________________________
(ɔ) - 2017-2020 - CC BY-NC-ND - by koltrast


<!-- <a href="%%SOURCE%%">View page source</a> -->


</pre></pre>
EOF

rm    -f  docs/*.txt docs/*.html
mkdir -p  docs
cd        docs

# Iterate over each file in the source tree under /site/.
(cd ../si*; find . -type f -a -not -path \*/\.\* -a -not -path ./templates/\*) |

while read -r page; do
    mkdir -p "${page%/*}"

    case $page in
        *.txt)
            sed -E "s|([^=][^\'\"])(https[:]//[^ )]*)|\1<a href='\2'>\2</a>|g" \
                "../site/$page" |

            sed -E "s|^(https[:]//[^ )]{50})([^ )]*)|<a href='\0'>\1</a>|g" |

            sed '/%%CONTENT%%/r /dev/stdin' /tmp/meow |
            sed '/%%CONTENT%%/d' |

            sed "s	%%SOURCE%%	/${page##./}	" \
                > "${page%%.txt}.html"

            ln -f "../site/$page" "$page"

            printf '%s\n' "CC $page"
        ;;

        # Copy over any images or non-txt files.
        *)
            cp "../site/$page" "$page"

            printf '%s\n' "CP $page"
        ;;
    esac
done

