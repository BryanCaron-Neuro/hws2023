#!/bin/bash
command="["
for elem in "$@"
do
    command+="\"${elem}\","
done
command=${command::-1}
command+="]"

echo "running command $command"

python -c "import pty; pty.spawn(${command})"

