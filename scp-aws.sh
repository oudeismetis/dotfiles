
ssh -A -t -o ServerAliveInterval=55 -o StrictHostKeyChecking=no user@192.168.1.1

sed -i '' '/foo/bar/' ~/.ssh/known_hosts
scp -o ProxyCommand="ssh MIDDLE_SERVER nc IP_ADDRESS 22" /local/path/ IP_ADDRESS:/server/path/
