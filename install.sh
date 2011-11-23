#!/bin/bash
#
#----------------------------------------
#
#         快车安装脚本
#
#	1,自动检测libexpat
#	2,创建启动菜单	
#
#	by: netman@flashget  2010-07-21
#----------------------------------------

# 文件说明：
#
#flashget-1.0.2-+-flashget			主程序
#			    |-flashget.desktop  用于创建启动图表
#				|-flashget.png		Logo
#				|-install.sh		安装脚本
#				|-README			You get it
#


#######    检查 libexpat.so.0      ############
aexpat=`ldconfig -v 2>/dev/null|grep libexpat.so.0`
if [ -z  "$aexpat" ]
then
    slib=`whereis libexpat.so.|awk {'print $2'}`
    if [ ! -z "$slib" ];then
	mach=`uname -m`
	if [ ${mach} = "x86_64" ];then
		ln -s /lib32/libexpat.so /usr/lib32/libexpat.so.0 2>/dev/null
	else
        	ln -s $slib /usr/lib/libexpat.so.0 2>/dev/null
	fi        
        ldconfig 2>/dev/null
	echo "Make a link for libexpat.so.0"
    else
        echo "Not Found libexpat.so"
    fi
fi


#######    安装  flashget         ############
if [ ! -x /usr/share/flashget ];then
	mkdir -p /usr/share/flashget
fi

# 这个是为了在PATH里面可以找到flashget
echo  -e  '#''!'"/bin/sh""\n""/usr/share/flashget/flashget "'"$@'\""" >/usr/bin/flashget
chmod a+x /usr/bin/flashget
install flashget /usr/share/flashget/flashget
install flashget.png /usr/share/flashget/flashget.png

if [ -x /usr/share/applications/ ];then
	install flashget.desktop /usr/share/applications/flashget.desktop
else
	install flashget.desktop /usr/share/applnk/Internet/flashget.desktop
fi

echo "install flashget to /usr/bin: yes"
echo "Welcome to FlashGet Network and enjoy yourself."