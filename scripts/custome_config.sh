#!/bin/bash

sed -i -e '/CONFIG_MAKE_TOOLCHAIN=y/d' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_IB=y/# CONFIG_IB is not set/g' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_SDK=y/# CONFIG_SDK is not set/g' configs/rockchip/01-nanopi

#移除aria2

# sed -i -e 's/CONFIG_PACKAGE_luci-app-aria2=y/CONFIG_PACKAGE_luci-app-aria2 is not set/g' configs/rockchip/01-nanopi

# sed -i '/CONFIG_PACKAGE_luci-app-aria2=y/d' configs/rockchip/01-nanopi
# sed -i '/CONFIG_PACKAGE_aria2=y/d' configs/rockchip/01-nanopi

#移除adblock
# sed -i -e 's/CONFIG_PACKAGE_luci-app-adblock=y/CONFIG_PACKAGE_luci-app-adblock is not set/g' configs/rockchip/01-nanopi
# sed -i '/CONFIG_PACKAGE_luci-app-adblock=y/d' configs/rockchip/01-nanopi

#移除hd-idle
# sed -i -e 's/CCONFIG_PACKAGE_luci-app-hd-idle=y/CONFIG_PACKAGE_luci-app-hd-idle is not set/g' configs/rockchip/01-nanopi
# sed -i '/CONFIG_PACKAGE_hd-idle=y/d' configs/rockchip/01-nanopi
# sed -i '/CONFIG_PACKAGE_luci-app-hd-idle=y/d' configs/rockchip/01-nanopi

#移除minidlna
# sed -i -e 's/CONFIG_PACKAGE_luci-app-minidlna=y/CONFIG_PACKAGE_luci-app-minidlna is not set/g' configs/rockchip/01-nanopi
# sed -i '/CONFIG_PACKAGE_luci-app-minidlna=y/d' configs/rockchip/01-nanopi
# sed -i '/CONFIG_PACKAGE_minidlna=y/d' configs/rockchip/01-nanopi

#移除watchcat
# sed -i -e 's/CONFIG_PACKAGE_watchcat=y/CONFIG_PACKAGE_watchcat is not set/g' configs/rockchip/01-nanopi
# sed -i '/CONFIG_PACKAGE_watchcat=y/d' configs/rockchip/01-nanopi
# sed -i '/CONFIG_PACKAGE_luci-app-watchcat=y/d' configs/rockchip/01-nanopi
