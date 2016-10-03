#!/bin/bash

  echo `date +%s | sha256sum | base64 | head -c 32 ; echo` > registry_auth

if [ ! -f ca.key ]; then
  type openssl >/dev/null 2>&1 || { echo >&2 "OpenSSL is required on your local machine to generate the CA."; exit 1; }

  if [ ! -f registry_auth ]; then
      echo "`pwd`/htaccess could not be found. Please create it, or re-run the script."; exit 1
  else
    echo "Generating CA certificate in `pwd`/ca.crt..." && \
    openssl genrsa -out ca.key 2048 && openssl req -subj "/C=US/ST=NY/L=Flavortown/O=Guy Fieri/OU=Development CA" -config /usr/lib/ssl/openssl.cnf -new -key ca.key -x509 -days 1825 -out ca.crt
  fi
else
  echo -e "Doing nothing; you've already got a CA cert, ya dingus.\n"
  echo "
                                                                                                                                                   dddddddd
hhhhhhh                              hhhhhhh                                                    tttt                           lllllll             d::::::d                                                                !!!
h:::::h                              h:::::h                                                 ttt:::t                           l:::::l             d::::::d                                                               !!:!!
h:::::h                              h:::::h                                                 t:::::t                           l:::::l             d::::::d                                                               !:::!
h:::::h                              h:::::h                                                 t:::::t                           l:::::l             d:::::d                                                                !:::!
 h::::h hhhhh         aaaaaaaaaaaaa   h::::h hhhhh         aaaaaaaaaaaaa               ttttttt:::::ttttttt       ooooooooooo    l::::l     ddddddddd:::::d      yyyyyyy           yyyyyyy ooooooooooo   uuuuuu    uuuuuu  !:::!
 h::::hh:::::hhh      a::::::::::::a  h::::hh:::::hhh      a::::::::::::a              t:::::::::::::::::t     oo:::::::::::oo  l::::l   dd::::::::::::::d       y:::::y         y:::::yoo:::::::::::oo u::::u    u::::u  !:::!
 h::::::::::::::hh    aaaaaaaaa:::::a h::::::::::::::hh    aaaaaaaaa:::::a             t:::::::::::::::::t    o:::::::::::::::o l::::l  d::::::::::::::::d        y:::::y       y:::::yo:::::::::::::::ou::::u    u::::u  !:::!
 h:::::::hhh::::::h            a::::a h:::::::hhh::::::h            a::::a             tttttt:::::::tttttt    o:::::ooooo:::::o l::::l d:::::::ddddd:::::d         y:::::y     y:::::y o:::::ooooo:::::ou::::u    u::::u  !:::!
 h::::::h   h::::::h    aaaaaaa:::::a h::::::h   h::::::h    aaaaaaa:::::a                   t:::::t          o::::o     o::::o l::::l d::::::d    d:::::d          y:::::y   y:::::y  o::::o     o::::ou::::u    u::::u  !:::!
 h:::::h     h:::::h  aa::::::::::::a h:::::h     h:::::h  aa::::::::::::a                   t:::::t          o::::o     o::::o l::::l d:::::d     d:::::d           y:::::y y:::::y   o::::o     o::::ou::::u    u::::u  !:::!
 h:::::h     h:::::h a::::aaaa::::::a h:::::h     h:::::h a::::aaaa::::::a                   t:::::t          o::::o     o::::o l::::l d:::::d     d:::::d            y:::::y:::::y    o::::o     o::::ou::::u    u::::u  !!:!!
 h:::::h     h:::::ha::::a    a:::::a h:::::h     h:::::ha::::a    a:::::a                   t:::::t    tttttto::::o     o::::o l::::l d:::::d     d:::::d             y:::::::::y     o::::o     o::::ou:::::uuuu:::::u   !!!
 h:::::h     h:::::ha::::a    a:::::a h:::::h     h:::::ha::::a    a:::::a  ,,,,,,           t::::::tttt:::::to:::::ooooo:::::ol::::::ld::::::ddddd::::::dd             y:::::::y      o:::::ooooo:::::ou:::::::::::::::uu
 h:::::h     h:::::ha:::::aaaa::::::a h:::::h     h:::::ha:::::aaaa::::::a  ,::::,           tt::::::::::::::to:::::::::::::::ol::::::l d:::::::::::::::::d              y:::::y       o:::::::::::::::o u:::::::::::::::u !!!
 h:::::h     h:::::h a::::::::::aa:::ah:::::h     h:::::h a::::::::::aa:::a ,::::,             tt:::::::::::tt oo:::::::::::oo l::::::l  d:::::::::ddd::::d             y:::::y         oo:::::::::::oo   uu::::::::uu:::u!!:!!
 hhhhhhh     hhhhhhh  aaaaaaaaaa  aaaahhhhhhh     hhhhhhh  aaaaaaaaaa  aaaa ,:::,,               ttttttttttt     ooooooooooo   llllllll   ddddddddd   ddddd            y:::::y            ooooooooooo       uuuuuuuu  uuuu !!!
                                                                           ,:::,                                                                                      y:::::y
                                                                           ,,,,                                                                                      y:::::y
                                                                                                                                                                    y:::::y
                                                                                                                                                                   y:::::y
                                                                                                                                                                  yyyyyyy

                                                                                                                                                                                                                               "
fi
