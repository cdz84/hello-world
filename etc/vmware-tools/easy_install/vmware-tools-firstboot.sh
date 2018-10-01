#!/bin/bash
echo
cat <<NESTEDEOF
************************************************
************************************************
            VMware Easy Install

  PLEASE WAIT! VMware Tools is currently being 
  installed on your system.  A login prompt will
  appear once this task completes.

************************************************
************************************************
NESTEDEOF
if [ -x /usr/sbin/getenforce ]; then oldenforce=$(/usr/sbin/getenforce); /usr/sbin/setenforce permissive || true; fi
mkdir -p /tmp/vmware-toolsmnt0
for i in hda sr0 scd0; do mount -t iso9660 /dev/$i /tmp/vmware-toolsmnt0 && break; done
cp -a /tmp/vmware-toolsmnt0 /opt/vmware-tools-installer
chmod 755 /opt/vmware-tools-installer
cd /opt/vmware-tools-installer
mv upgra32 vmware-tools-upgrader-32
mv upgra64 vmware-tools-upgrader-64
mv upgrade.sh run_upgrader.sh
chmod +x /opt/vmware-tools-installer/*upgr*
umount /tmp/vmware-toolsmnt0
rmdir /tmp/vmware-toolsmnt0
if [ -x /usr/bin/rhgb-client ]; then /usr/bin/rhgb-client --quit; fi
cd /opt/vmware-tools-installer
for s in sr0 sr1; do eject -s /dev/$s; done
./run_upgrader.sh
rm -rf /opt/vmware-tools-installer
if [ -f /boot/grub/menu.lst.bak ]; then mv /boot/grub/menu.lst.bak /boot/grub/menu.lst; fi
if [ -f /boot/grub/grub.conf.bak ]; then mv /boot/grub/grub.conf.bak /boot/grub/grub.conf; fi
if [ -f /boot/grub2/grub.conf.bak ]; then mv /boot/grub2/grub.conf.bak /boot/grub2/grub.conf; fi
if [ -f /boot/grub2/grub.cfg.bak ]; then mv /boot/grub2/grub.cfg.bak /boot/grub2/grub.cfg; fi
if [ -x /usr/sbin/getenforce ]; then /usr/sbin/setenforce $oldenforce || true; fi
systemctl disable /etc/vmware-tools/easy_install/vmware-tools-firstboot.service
