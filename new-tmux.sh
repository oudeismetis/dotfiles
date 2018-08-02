#!/bin/zsh                                                                                                   

SESSIONNAME=$1
if [[ $# == 2 ]]; then
  lang=$2
fi

if [[ $# != 0 && -d "$SESSIONNAME" ]]; then
  printf '%s%s\n' "Initializing session: " "$SESSIONNAME"

  tmux has-session -t $SESSIONNAME &> /dev/null

  if [ $? != 0 ]; then
    tmux new-session -s $SESSIONNAME -n script -d
    # Create 3 panes. Each will be in the project's dir.
    # First pane will have vim and nerdtree open
    tmux send-keys -t $SESSIONNAME "cd $SESSIONNAME" C-m
    if [ ${lang+x} ]; then
      echo "Installing pipenv..."
      sleep 2
      tmux send-keys -t $SESSIONNAME "pipenv install --dev --python 3.6" C-m
      # Would be nice if we could user tmux wait-for here. But pipenv install is async
      # The following hack basically does the same thing
      echo "Waiting for pipenv install..."
      sleep 15
      tmux capture-pane -t $SESSIONNAME:0
      old_buffer=""
      new_buffer=$(tmux show-buffer)
      while [[ "$old_buffer" != "$new_buffer" ]] ; do
        sleep 15
        diff <(echo "$old_buffer" ) <(echo "$new_buffer")
        old_buffer=$new_buffer
        tmux capture-pane -t $SESSIONNAME:0
        new_buffer=$(tmux show-buffer)
      done
      # On with the show
      tmux send-keys -t $SESSIONNAME "pipenv shell" C-m
      sleep 2
      tmux send-keys -t $SESSIONNAME "pip install pylama" C-m
    fi
    tmux send-keys -t $SESSIONNAME "vim" C-m
    tmux send-keys -t $SESSIONNAME ":NERDTree" C-m
    tmux split-window -h
    tmux resize-pane -R -t 0 20 C-m
    tmux send-keys -t $SESSIONNAME "cd $SESSIONNAME" C-m
    if [ ${lang+x} ]; then
      tmux send-keys -t $SESSIONNAME "pipenv shell" C-m
    fi
    tmux split-window -v
    tmux send-keys -t $SESSIONNAME "cd $SESSIONNAME" C-m
    if [ ${lang+x} ]; then
      tmux send-keys -t $SESSIONNAME "pipenv shell" C-m
    fi
    tmux select-pane -t 0
  fi

  tmux attach -t $SESSIONNAME
else
  printf '%s\n' "Need pass the name of a folder 'new-tmux.sh <folder-name>'"
fi
