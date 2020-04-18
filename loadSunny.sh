#!/bin/sh -e
### BEGIN INIT INFO
# Provides:          ngrok.cc
# Required-Start:    $network $remote_fs $local_fs
# Required-Stop:     $network $remote_fs $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: autostartup of ngrok for Linux
### END INIT INFO

NAME=sunny
DAEMON=/usr/local/bin/$NAME
PIDFILE=/var/run/$NAME.pid

[ -x "$DAEMON" ] || exit 0

case "$1" in
  start)
      if [ -f $PIDFILE ]; then
        echo "$NAME already running..."
        echo -e "\033[1;35mStart Fail\033[0m"
      else
        echo "Starting $NAME..."
        start-stop-daemon -S -p $PIDFILE -m -b -o -q -x $DAEMON -- clientid 48ed82d5a0bf97f9|| return 2
        echo -e "\033[1;32mStart Success\033[0m"
    fi
    ;;
  stop)
        echo "Stoping $NAME..."
        start-stop-daemon -K -p $PIDFILE -s TERM -o -q || return 2
        rm -rf $PIDFILE
        echo -e "\033[1;32mStop Success\033[0m"
    ;;
  restart)
    $0 stop && sleep 2 && $0 start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
    ;;
esac
exit 0