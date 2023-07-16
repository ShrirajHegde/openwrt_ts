### opkg update && opkg install kmod-tun iptables kmod-ipt-nat && reboot

mkdir -p /tmp/usr/sbin/

cd /tmp
while true;do
wget -c https://downloads.openwrt.org/releases/22.03.5/packages/mips_24kc/packages/tailscale_1.32.3-1_mips_24kc.ipk && \
wget -c https://downloads.openwrt.org/releases/22.03.5/packages/mips_24kc/packages/tailscaled_1.32.3-1_mips_24kc.ipk && break
opkg install -d ram /tmp/*.ipk
#wget -c https://raw.githubusercontent.com/ShrirajHegde/openwrt_ts/main/tailscaled -O /tmp/usr/sbin/tailscaled && \
#wget -c https://raw.githubusercontent.com/ShrirajHegde/openwrt_ts/main/tailscale -O /tmp/usr/sbin/tailscale && break || sleep 5 \ 
done

rm /usr/sbin/tailscale /usr/sbin/tailscaled || true

ln -s /tmp/usr/sbin/tailscale /usr/sbin/tailscale && chmod +x /usr/sbin/tailscale
ln -s /tmp/usr/sbin/tailscaled /usr/sbin/tailscaled && chmod +x /usr/sbin/tailscaled

mkdir -p /var/lib/tailscale/
mkdir -p /etc/tailscale/

rm /var/lib/tailscale/tailscaled.state || true
ln -s /etc/tailscale/tailscaled.state /var/lib/tailscale/tailscaled.state 

(/usr/sbin/tailscaled >/dev/null 2>&1 )&


