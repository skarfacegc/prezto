_subl_reattach_extra=''
# add reattach-to-user-namspace if under OSX
if [[ -n $(type reattach-to-user-namspace) ]]; then
   _subl_reattach_extra=$(which reattach-to-user-namespace)
fi

    
# Open the specified file and/or directory in a new window
alias subl='$_subl_reattach_extra /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n'

# Add the specified file and/or directory to the current winsow
alias subla='subl -a'


# load a project
alias sublp="subl --project"
