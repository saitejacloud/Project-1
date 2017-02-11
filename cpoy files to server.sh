scp -i keys/keys/merdep.non-prod -o PreferredAuthentications=publickey -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no PATH/FILE.py $USERNAME@$HOSTNAME:FILE.py
ssh -i keys/keys/merdep.non-prod -o PreferredAuthentications=publickey -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $USERNAME@$HOSTNAME "export TEMP_PATH=$TEMP_PATH && python FILE.py -p $TEMP_PATH"



