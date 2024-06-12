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

# {{ Add passwall
(cd friendlywrt && {
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "feeds.conf.default"
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> "feeds.conf.default"
})

echo "CONFIG_FEED_passwall_packages=y" >> configs/rockchip/01-nanopi
echo "CONFIG_FEED_passwall=y" >> configs/rockchip/01-nanopi

echo "CONFIG_PACKAGE_luci-i18n-passwall-zh-cn=y" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> configs/rockchip/01-nanopi

echo "# CONFIG_PACKAGE_luci-app-passwall_Iptables_Transparent_Proxy is not set" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_Nftables_Transparent_Proxy=y" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Haproxy=y" >> configs/rockchip/01-nanopi
echo "# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Hysteria is not set" >> configs/rockchip/01-nanopi
echo "# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_NaiveProxy is not set" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Libev_Client=y" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Libev_Server=y" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Client=y" >> configs/rockchip/01-nanopi
echo "# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Server is not set" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_Libev_Client=y" >> configs/rockchip/01-nanopi
echo "# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_Libev_Server is not set" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Simple_Obfs=y" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_Plus=y" >> configs/rockchip/01-nanopi
echo "# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_tuic_client is not set" >> configs/rockchip/01-nanopi
echo "# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Geodata is not set" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Plugin=y" >> configs/rockchip/01-nanopi
echo "CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y" >> configs/rockchip/01-nanopi
echo "# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray_Plugin is not set" >> configs/rockchip/01-nanopi

# echo "-------------------CONFIG_PACKAGE_luci-app-passwall=y"

# echo "CONFIG_PACKAGE_luci-app-passwall=y" >> configs/rockchip/01-nanopi

sed -i -e '/boardname=/r /tmp/appendtext.txt' friendlywrt/target/linux/rockchip/armv8/base-files/root/setup.sh
#修改hostname
sed -i -e 's/HOSTNAME="FriendlyWrt"/HOSTNAME="Gwrt"/g' friendlywrt/target/linux/rockchip/armv8/base-files/root/setup.sh




# }}
