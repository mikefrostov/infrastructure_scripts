for i in 'cat my_hosts_list'
do
sshpass -p 'server_password' ssh-copy-id admin@${i}
done
