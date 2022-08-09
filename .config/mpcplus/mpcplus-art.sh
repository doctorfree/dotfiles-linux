#!/bin/bash
#
# mpcplus-tmux - run the mpcplus MPD client, spectrum visualizer,
#                and display album cover art in a tmux session

SESSION=musicplayerplus

if [ -f ${HOME}/.config/mpcplus/config ]
then
  MPCDIR=".config/mpcplus"
else
  if [ -f ${HOME}/.mpcplus/config ]
  then
    MPCDIR=".mpcplus"
  else
    mppinit
    MPCDIR=".config/mpcplus"
  fi
fi

usage() {
  printf "\nUsage: mpcplus-tmux [-a] [-f] [-g] [-p script] [-r] [-u]"
  printf "\nWhere:"
  printf "\n\t-a indicates display album cover art"
  printf "\n\t-f indicates we have been invoked from a fullscreen window"
  printf "\n\t-g indicates do not use gradient colors for spectrum visualizer"
  printf "\n\t-p script specifies an asciimatics script to run"
  printf " in the visualizer pane"
  printf "\n\t-r indicates record tmux session with asciinema"
  printf "\n\t-u displays this usage message and exits\n"
  printf "\nDefaults: cover art disabled, ascii art disabled, recording disabled"
  printf "\nThis run:"
  if [ "${ART}" ]
  then
    printf "\n\tcover art enabled"
  else
    printf "\n\tcover art disabled"
  fi
  if [ "${PYART}" ]
  then
    printf "\n\tascii art enabled"
  else
    printf "\n\tascii art disabled"
  fi
  if [ "${RECORD}" ]
  then
    printf "\n\trecording enabled"
  else
    printf "\n\trecording disabled"
  fi
  printf "\nType 'man mpcplus-tmux' for detailed usage info on mpcplus-tmux"
  printf "\nType 'man mpcplus' for detailed usage info on the mpcplus MPD client\n"
  exit 1
}

ART=
ART_WIDTH=22
ART_HEIGHT=42
ALBUM_COVER="${HOME}/${MPCDIR}/album_cover.sh"
PYART=
RECORD=
USE_GRAD=1
USAGE=
while getopts "afgp:ru" flag; do
    case $flag in
        a)
          have_uebz=`type -p ueberzug`
          [ "${have_uebz}" ] && ART=1
          ;;
        f)
          ART_WIDTH=10
          ART_HEIGHT=35
          ALBUM_COVER="${HOME}/${MPCDIR}/album_cover.sh -f"
          ;;
        g)
          USE_GRAD=
          ;;
        p)
          PYART=${OPTARG}
          ;;
        r)
          have_nema=`type -p asciinema`
          [ "${have_nema}" ] && RECORD=1
          ;;
        u)
          USAGE=1
          ;;
    esac
done
shift $(( OPTIND - 1 ))

# If both ART and PYART have been specified, disable ART and use PYART
# [ "${ART}" ] && [ "${PYART}" ] && ART=

[ "${USAGE}" ] && usage

COVER="${HOME}/${MPCDIR}/album_cover.png"
[ -f ${COVER} ] || cp ${HOME}/${MPCDIR}/default_cover.png ${COVER}

tmux new-session -d -x "$(tput cols)" -y "$(tput lines)" -s ${SESSION}
tmux set -g status off

tmux send-keys "stty -echo" C-m
tmux send-keys "tput civis -- invisible" C-m
tmux send-keys "export PS1=''" C-m
tmux send-keys "clear" C-m
[ "${ART}" ] && tmux send-keys "${ALBUM_COVER}" C-m

tmux split-window -v -p $((100 - ART_HEIGHT))
tmux select-pane -t 2
if [ "${ART}" ]
then
  tmux send-keys "mpcplus --config=${HOME}/${MPCDIR}/config-art.conf; exit" C-m
else
  tmux send-keys "mpcplus; exit" C-m
fi

tmux select-pane -t 1
[ "${ART}" ] && tmux split-window -h -p $((100 - ART_WIDTH))

if [ "${PYART}" ]
then
  have_pyart=`type -p mpp${PYART}`
  [ "${have_pyart}" ] && PYART="mpp${PYART}"
  tmux send-keys "${PYART}; exit" C-m
else
  if [ "${USE_GRAD}" ]
  then
    tmux send-keys "mppcava; exit" C-m
  else
    tmux send-keys "mppcava -p ${HOME}/.config/mppcava/config-tmux; exit" C-m
  fi
fi

if [ "${ART}" ]
then
# tmux resize-pane -t 0 -x "${ART_WIDTH}\%" -y "${ART_HEIGHT}\%"
# tmux set-hook client-resized "resize-pane -t 0 -x \"${ART_WIDTH}\\\%\" -y \"${ART_HEIGHT}\\\%\""
  tmux select-pane -t 3
else
# tmux resize-pane -t 0 -x "100\%" -y "${ART_HEIGHT}\%"
# tmux set-hook client-resized "resize-pane -t 0 -x \"100\\\%\" -y \"${ART_HEIGHT}\\\%\""
  tmux select-pane -t 2
fi

tmux new-window "fzmp -a"

tmux select-window -t ${SESSION}:1

if [ "${RECORD}" ]
then
  tmux d
  VID_DIR=$HOME/Videos
  [ -d ${VID_DIR} ] || mkdir ${VID_DIR}
  REC_DIR=${VID_DIR}/asciinema
  [ -d ${REC_DIR} ] || mkdir ${REC_DIR}
  echo "Recording this mpplus session with asciinema"
  asciinema rec --command "tmux attach -t ${SESSION}" ${REC_DIR}/${SESSION}-$(date +%F--%H%M).cast
else
  tmux a #
fi
