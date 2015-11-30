#!/bin/zsh                                                                                                   

SESSIONNAME=$1

if [[ $# != 0 && -d "$SESSIONNAME" ]]; then
  printf '%s%s\n' "Initializing session: " "$SESSIONNAME"

  tmux has-session -t $SESSIONNAME &> /dev/null

  if [ $? != 0 ]; then
    tmux new-session -s $SESSIONNAME -n script -d
    # Create 3 panes. Each will be in the project's dir.
    # First pane will have vim and nerdtree open
    tmux send-keys -t $SESSIONNAME "cd $SESSIONNAME" C-m
    tmux split-window -h
    tmux send-keys -t $SESSIONNAME "cd $SESSIONNAME" C-m
    tmux split-window -v
    tmux send-keys -t $SESSIONNAME "cd $SESSIONNAME" C-m
    tmux select-pane -t 0
    tmux send-keys -t $SESSIONNAME "vim" C-m
    tmux send-keys -t $SESSIONNAME ":NERDTree" C-m
  fi

  tmux attach -t $SESSIONNAME
else
  printf '%s\n' "Need pass the name of a folder 'new-tmux.sh <folder-name>'"
fi
