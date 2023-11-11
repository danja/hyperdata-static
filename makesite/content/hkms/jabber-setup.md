
systemctl status ejabberd

/opt/ejabberd/conf/

nano ejabberd.yml

ejabberdctl change_password admin localhost Rainy_432

ejabberdctl register admin localhost Rainy_432

ejabberdctl register admin hyperdata.it Rainy_432

ejabberdctl register alice hyperdata.it Muddy_432

ejabberdctl register bob hyperdata.it Muddy_432

ejabberdctl register chris hyperdata.it Muddy_432

ejabberdctl register danbri hyperdata.it Muddy_432
ejabberdctl register danja hyperdata.it Muddy_432
ejabberdctl register mari hyperdata.it catlady
ejabberdctl register dogbot hyperdata.it doggy

alice@hyperdata.it Muddy_432
bob, chris, same password.

client app dino-lm

Certificate is saved at: /etc/letsencrypt/live/xmpp.hyperdata.it/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/xmpp.hyperdata.it/privkey.pem
This certificate expires on 2024-01-21.

ejabberdctl create_room shed hyperdata.it hyperdata.it

ejabberdctl create-room shed conference.hyperdata.it hyperdata.it

ejabberdctl create-room public shed.conference.hyperdata.it shed.hyperdata.it

ejabberdctl send_direct_invitation room_name muc_service password reason jid1[:jid2]

ejabberdctl send_direct_invitation shed hyperdata.it none none alice:bob:chris

ejabberdctl create_room room_name muc_service xmpp_domain

THIS

root@localhost:/opt/ejabberd/conf# ejabberdctl create-room shed conference.hyperdata.it hyperdata.it

ejabberdctl create-room outhouse conference.hyperdata.it hyperdata.it

to list:
root@localhost:/opt/ejabberd/conf# ejabberdctl muc_online_rooms global
shed@conference.hyperdata.it
root@localhost:/opt/ejabberd/conf#

Ok, that took a lot longer than it should have. Something not quite right with how I was configuring proxy+certs to use the webadmin. Given up on that for now, but it looks like ssh-ing in and doing the commands on the server worked.  
I've created 5 users :

alice@hyperdata.it Muddy_432
bob, chris, danbri, danja - same password.

two muc rooms : shed@conference.hyperdata.it, outhouse@conference.hyperdata.it
