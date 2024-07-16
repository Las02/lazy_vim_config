cat .err | tac | grep File | head -n1 | awk '{printf "%s |%s| Error", $2, $4}' | sed 's/"//g' | sed "s/,//g" >.err.formatted
