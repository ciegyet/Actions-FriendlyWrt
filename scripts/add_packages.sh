#!/bin/bash

# {{ Add luci-app-diskman
(cd friendlywrt && {
    mkdir -p package/luci-app-diskman
    wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/applications/luci-app-diskman/Makefile -O package/luci-app-diskman/Makefile
    mkdir -p package/parted
    wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/parted/Makefile
})
cat >> configs/rockchip/01-nanopi <<EOL
CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_btrfs_progs=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_lsblk=y
CONFIG_PACKAGE_smartmontools=y
EOL
# }}

# {{ Add luci-theme-argon
(cd friendlywrt/package && {
    [ -d luci-theme-argon ] && rm -rf luci-theme-argon
    git clone https://github.com/jerrykuku/luci-theme-argon.git --depth 1 -b master
})
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> configs/rockchip/01-nanopi
sed -i -e 's/function init_theme/function old_init_theme/g' friendlywrt/target/linux/rockchip/armv8/base-files/root/setup.sh

cat > /tmp/appendtext.txt <<EOL
function init_theme() {
    if uci get luci.themes.Argon >/dev/null 2>&1; then
        uci set luci.main.mediaurlbase="/luci-static/argon"
        uci commit luci
    fi
}
EOL
sed -i -e '/boardname=/r /tmp/appendtext.txt' friendlywrt/target/linux/rockchip/armv8/base-files/root/setup.sh

#修改hostname
sed -i -e 's/HOSTNAME="FriendlyWrt"/HOSTNAME="Gwrt"/g' friendlywrt/target/linux/rockchip/armv8/base-files/root/setup.sh

#移除aria2
sed -i '/CONFIG_PACKAGE_luci-app-aria2=y/d' configs/rockchip/01-nanopi
sed -i '/CONFIG_PACKAGE_aria2=y/d' configs/rockchip/01-nanopi

#移除adblock
sed -i '/CONFIG_PACKAGE_luci-app-adblock=y/d' configs/rockchip/01-nanopi

#移除hd-idle
sed -i '/CONFIG_PACKAGE_hd-idle=y/d' configs/rockchip/01-nanopi
sed -i '/CONFIG_PACKAGE_luci-app-hd-idle=y/d' configs/rockchip/01-nanopi

#移除minidlna
sed -i '/CONFIG_PACKAGE_luci-app-minidlna=y/d' configs/rockchip/01-nanopi
sed -i '/CONFIG_PACKAGE_minidlna=y/d' configs/rockchip/01-nanopi

#移除watchcat
sed -i '/CONFIG_PACKAGE_watchcat=y/d' configs/rockchip/01-nanopi
sed -i '/CONFIG_PACKAGE_luci-app-watchcat=y/d' configs/rockchip/01-nanopi


# }}
