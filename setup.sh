#!/bin/sh
#
# Run . ./a/setup.sh to create the aliases
#
#git clone https://github.com/qaza3/a.git

# Ensure scripts are executable
find . -name '*.bash' -exec chmod 700 {} \;

clear

for i in {01..18}; do
    idx=${i#0}
    # 1. Removed space from "Q$i *" to match "Q$i-Name"
    # 2. Quoted $target to handle potential spaces in folder names
    target=$(find ~/a/ -maxdepth 1 -type d -name "Q$i*" | head -n 1)
    
    if [ -n "$target" ]; then
        # Map aliases directly to the discovered path
        alias q$idx="clear; cat \"$target/Questions.bash\""
        alias s$idx="\"$target/LabSetUp.bash\""
        alias sol$idx="clear; cat \"$target/SolutionNotes.bash\""
        
        echo "Aliases created for $target"
    else
        echo "Warning: Q$i not found in ./a/"
    fi
done

alias ql='. ~/a/setup.sh'

echo '--'
echo '-- q1   - show qestion 1'
echo '-- s1   - setup question 1'
echo '-- sol1 - show solution question 1'
echo '-- -- replace "1" with the question number you want, question numbers are 1-17'
echo '-- ql   - show question list'
echo '--'
echo '-- Desktop setup'
echo '--   Open terminal, edit -> preferences -> clipboard -> automatically copy selection'
echo '--   Open terminal, view, zoom out (zoom out one to see longer command line)'
echo '--   Double click INFO on desktop -> file -> new (for notepad work area)'
echo '--'
