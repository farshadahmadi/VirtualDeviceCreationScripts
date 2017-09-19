rm ~/.forever/forever.log
rm out.log
rm err.log
forever start --uid "vd"  -l forever.log -o out.log -e err.log manager_server.js
