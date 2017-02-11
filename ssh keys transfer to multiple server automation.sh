!/bin/bash
 
# read the options
TEMP=`getopt -o k:,s: --long keyfile:,serverlist: -n 'copy-ssh.sh' -- "$@"`
eval set -- "$TEMP"
 
# extract options and their arguments into variables.
while true ; do
    case "$1" in
        -k|--keyfile)
            case "$2" in
                *) keyfile=$2 ; shift 2 ;;
            esac ;;
        -s|--serverlist)
            case "$2" in
                *) serverlist=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done
 
IFS=$'\n'
 
for server_record in $(cat ${serverlist})
do
	server_name=$(echo ${server_record} | awk -F" " '{print $1}')
	serviceaccount=$(echo ${server_record} | awk -F" " '{print $NF}')
	# Transfer the public Key to the target server
	echo "Setting up ssh key for ${server_name} (Account : ${serviceaccount})"
	scp ${keyfile} ${serviceaccount}@${server_name}:/tmp/key.pub
	ssh ${serviceaccount}@${server_name} cat /tmp/key.pub ~/.ssh/authorized_keys; rm -f /tmp/key.pub
done
 
	
