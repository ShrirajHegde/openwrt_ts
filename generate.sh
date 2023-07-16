wget -c https://downloads.openwrt.org/releases/22.03.5/packages/mips_24kc/packages/tailscale_1.32.3-1_mips_24kc.ipk
wget -c https://downloads.openwrt.org/releases/22.03.5/packages/mips_24kc/packages/tailscaled_1.32.3-1_mips_24kc.ipk

tar zxpvf tailscaled_1.32.3-1_mips_24kc.ipk
tar zxvf data.tar.gz
mv usr/sbin/tailscaled .


tar zxpvf tailscale_1.32.3-1_mips_24kc.ipk
tar zxvf data.tar.gz
mv usr/sbin/tailscale .

rm *.gz debian-binary *.ipk

rm -rf usr lib etc

upx tailscale --lzma
upx tailscaled --lzma
