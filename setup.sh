#!/bin/sh
#
# Run . ./a/setup.sh to create the aliases
#
#git clone https://github.com/qaza3/a.git

# Ensure scripts are executable
find . -name '*.bash' -exec chmod 700 {} \;

for i in {01..17}; do
    # 1. Removed space from "Q$i *" to match "Q$i-Name"
    # 2. Quoted $target to handle potential spaces in folder names
    target=$(find ./a/ -maxdepth 1 -type d -name "Q$i*" | head -n 1)
    
    if [ -n "$target" ]; then
        # Map aliases directly to the discovered path
        alias q$i="clear; cat \"$target/Questions.bash\""
        alias s$i="\"$target/LabSetUp.bash\""
        alias sol$i="\"$target/SolutionNotes.bash\""
        
        echo "Aliases created for $target"
    else
        echo "Warning: Q$i not found in ./a/"
    fi
done
