ip addr add 192.168.42.129 dev br0 gateway 192.168.42.128 broadcast 192.168.42.255
ens3: inet 192.168.42.64 netmask 255.255.255.0 broadcast 192.168.42.255

身为一个小小弱菜，却有个不安分的心，不停的尝试发行版，Arch应该是在7月多去掉了AIF安装框架，安装过程相对就比较麻烦了，不过还好它wiki是相当的全面，网上还有很多资料可以参考
下载镜像烧进U盘就不多说了，主菜单选择 "Boot Arch Linux" 并按回车，系统将加载并给出登录提示，自动以 'root' 登录。系统默认使用美式键盘映射。

网络连接
archlinux安装是特别依赖网络的，没有网络安装的话就X疼了。 安装程序会自动执行dhcpcd建立连接，可以试试ping一下百度什么的，不行的话用以下方法手动配置
如果是有线连接：
激活接口：

# ip link set eth0 up

添加ip地址：

# ip addr add <ip 地址>/<子网掩码> dev <接口名>

用类似下面的命令添加网关，ip 地址替换为实际的网关地址：

# ip route add default via <ip 地址>

编辑/etc/resolv.conf 如下, 替换你的DNS服务器IP地址和本地域名:

# nano /etc/resolv.conf
 nameserver 61.23.173.5
 nameserver 61.95.849.8
 search example.com

如果是无线网络：
下面的示例中使用 wlan0 作为接口，linksys 作为 ESSID。请根据实际情况修改。
确定网络接口：

# lspci | grep -i net

用 iwconfig 确定 udev 已经载入驱动，而且驱动程序创建了可用的无线内核接口：
输出和下面不相似表示驱动没有载入，需要自己加入

#iwconfig
lo no wireless extensions.
eth0 no wireless extensions.
wlan0    unassociated  ESSID:""
         Mode:Managed  Channel=0  Access Point: Not-Associated
         Bit Rate:0 kb/s   Tx-Power=20 dBm   Sensitivity=8/0
         Retry limit:7   RTS thr:off   Fragment thr:off
         Power Management:off
         Link Quality:0  Signal level:0  Noise level:0
         Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
         Tx excessive retries:0  Invalid misc:0   Missed beacon:0

wlan0 为可用接口。
启用接口：

# ip link set wlan0 up

在安装 Archlinux 时,无线网络驱动和工具已经包含在 base 组中。请确保为无线网卡安装正确的驱动。通常在初始化的光盘系统和新装的系统中，Udev 会加载合适的驱动,并创建无线网络接口。如果在安装 Archlinux 系统的时候没有配置无线网卡,请确保下列所需的软件包已经通过 pacman 安装完毕(驱动,必须的固件, wireless_tools，iw，wpa_supplicant
然后使用netcfg提供的 wifi-menu 连接到网络：

# wifi-menu wlan0

如果是需要拨号上网的 可选择pppoe

分区
现在的arch有三种分区工具，如果你是GPT分区表的话可以选择cgdisk，mbr选择cfdisk，gparted则是两者都支持。

弱菜君用的mbr分区表

# cfdisk /dev/sda

然后根据需求分区
分区之后，还需要用 mkfs 将分区格式化为选定的文件系统，我使用的是ext4文件系统

# mkfs.ext4 /dev/sda1
# mkfs.ext4 /dev/sda2

刷新一下分区表(如果变动比较大要在格式化之前刷新一下分区表)

# partprobe /dev/sda

挂载分区
要检查当前磁盘的标识符和布局：

 # lsblk /dev/sda

先挂载根分区到/mnt.

# mount /dev/sda1 /mnt
# ls /mnt

格式化完应该就一个lost+found

然后挂载/home分区和其余单独分区(/boot, /var 等)。
然后在 /mnt 中创建 home 目录并挂载分区：

# mkswap /dev/sdaX && swapon /dev/sdaX ##分区格式化为swap,并且创造swap分区
# mount /dev/sdaX /mnt ##挂载/分区到/mnt上
# mkdir /mnt/home && mount /dev/sdaY /mnt/home ##创建home文件,并且将Y分区挂载到上面

编辑源列表
把163的源放在最前面

# nano /etc/pacman.d/mirrorlist
Server = http://mirrors.163.com/archlinux/$repo/os/$arch

然后升级文件列表

pacman -Syy
#nano /etc/pacman.conf

[options]
前面的选项改成这样

RootDir = /mnt
DBPath = /mnt/var/lib/pacman/
CacheDir = /mnt/var/cache/pacman/pkg/
LogFile = /mnt/var/log/pacman.log
GPGDir = /mnt/etc/pacman.d/gnupg/
SigLevel = Never

后面
core、extra、community
的SigLevel = PackageRequired之前加#注释掉

使用 pacstrap 脚本安装基本系统：

# pacstrap /mnt base base-devel

无线的同时安装以下软件包，否则chroot后上不了网

#pacstrp /mnt wireless_tools wpa_supplicant wpa_actiond dialog

生成fstab

#genfstab -p /mnt >> /mnt/etc/fstab

Chroot到新系统

#arch-chroot /mnt

配置系统

#vi /etc/locale.gen

选择你需要的本地化类型，移除前面的#即可

en_US.UTF-8 UTF-8
en_GB.UTF-8 UTF-8
zh_CN.GB18030 GB18030
zh_CN.GBK GBK
zh_CN.UTF-8 UTF-8
zh_CN GB2312

然后运行

# locale-gen

locale.conf 文件默认不存在，一般设置LANG就行了，它是其它设置的默认值。

LANG=zh_CN.UTF-8
LC_TIME=en_GB.UTF-8

时区
编辑文件 /etc/timezone
Asia/Shanghai
同时，将/etc/localtime 软链接到 /usr/share/zoneinfo/Zone/SubZone.其中 Zone 和 Subzone 替换为所在时区

# ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

硬件时间
在 /etc/adjtime 中设置，默认、推荐的设置为UTC
可用以下命令自动生成
# hwclock --systohc --localtime
NTPd是使用网络时间协议将 GNU/Linux 系统的软件时钟与 Internet 时间服务器同步的最常见的方法
安装ntp

pacman -S ntp

想要仅仅同步时钟一次，不想启动守护进程的话，运行：

# ntpd -qg
# hwclock -s

内核模块
一般情况下 udev 会自动加载需要的模块，大部分用户都不需要手动修改。这里只需要加入真正需要的模块。
/etc/modules-load.d/中保存内核启动时加入模块的配置文件。每个配置文件已/etc/modules-load.d/.conf的格式命名。配置文件中包含需要装入的内核列表，每个一行。空行和以 # 或 ; 开头的行直接被忽略。比如

/etc/modules-load.d/virtio-net.conf
# Load virtio-net.ko at boot
virtio-net

注意：新版本arch使用systemd系统和服务管理器。systemd 是 Linux 下的一款系统和服务管理器，兼容 SysV 和 LSB 的启动脚本。systemd的特性有：支持并行化任务；同时采用 socket 式与 D-Bus 总线式激活服务；按需启动守护进程（daemon）；利用 Linux 的 cgroups 监视进程；支持快照和系统恢复；维护挂载点；各服务间基于依赖关系进行精密控制。systemd 完全可以替代 Arch 默认的 sysvinit 启动系统。

系统默认安装systemd。建议所有系统都使用 systemd 的配置文件。
启用 net-auto-wireless 服务

# systemctl enable net-auto-wireless.service

Make sure that the correct wireless interface (usually wlan0) is set in /etc/conf.d/netcfg:

# nano /etc/conf.d/netcfg
WIRELESS_INTERFACE="wlan0"

设置主机名

/etc/hostname
myhostname

设置 Root 密码并创建一般用户

# passwd
# useradd -m -g users -s /bin/bash archie
# passwd archie

安装配置启动加载器
BIOS 系统由三个供选择 - Syslinux, GRUB, 和 LILO. 按个人喜好选择一个引导
syslinux

# pacman -S syslinux
# syslinux-install_update -iam

编辑 /boot/syslinux/syslinux.cfg，将 / 指向正确的根分区，这是必须的，否则 Arch 启动不起来。将"sda3"修改为实际的根分区。同样，修改LABEL archfallback.

# nano /boot/syslinux/syslinux.cfg
...
LABEL arch
 ...
 APPEND root=/dev/sda3 ro
如果你有windows系统，将 windows启动项目前的#删除。

grub 我是用的grub
安装到 BIOS 主板系统：

# pacman -S grub-bios
# grub-install --target=i386-pc --recheck /dev/sda
# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

虽然手动配置grub.cfg完全可以工作，建议自动生成这个文件。
要搜索硬盘上安装的其它操作系统，请先用 # pacman -S os-prober 安装 os-prober。

# grub-mkconfig -o /boot/grub/grub.cfg

安装桌面
pacman -S lxde或者pacman -S gnome-core
这个自己选择，kde、gnome、lxde或者可以选用openbox、awesome等WM

安装完成后, 复制/etc/xdg/openbox里的3个文件到 ~/.config/openbox :
menu.xml rc.xml autostart
也可以运行以下命令

mkdir -p ~/.config/openbox
cp /etc/xdg/openbox/menu.xml /etc/xdg/openbox/rc.xml /etc/xdg/openbox/autostart ~/.config/openbox

设置开机自动启动的程序
用你喜欢的编辑器打开/etc/xdg/lxsession/LXDE/autostart，然后在其中添加你要开机自动启动的程序，就像这样：

@xscreensaver -no-splash
@lxpanel --profile LXDE
@pcmanfm -d
@fcitx
@xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &

启动桌面环境

使用登录管理器
通过启动登录管理器（或称显示管理器），即可进行图形界面登录。目前，Arch 提供了 GDM、KDM、SLiM、XDM 和 LXDM 的 systemd 服务文件。以 KDM 为例，配置开机启动：

# systemctl enable lxdm.service

执行上述命令后，登录管理器应当能正常工作了。

启动速度优化
systemd 自己实现了一个 readahead，可以用来提高开机效率。不过，效果会因内核版本和硬件情况而不同（极端的还会变慢）。开启 readahead：

# systemctl enable systemd-readahead-collect.service systemd-readahead-replay.service

要知道，readahead 的超级牛力只有在重启几次后才会显现。

安装显卡驱动
如果是nvidia的显卡，首先安装yaourt

最简单安装Yaourt的方式是添加Yaourt源至 /etc/pacman.conf:

[archlinuxfr]
Server = http://repo.archlinux.fr/$arch
或者
 [archlinuxfr]
 Server = http://repo-fr.archlinuxcn.org/$arch
同步并安装：
# pacman -Syu yaourt

安装nvidia-all脚本

yaourt -S nvidia-all

假如使用的是最新的显卡，也许需要使用AUR上的驱动nvidia-beta和nvidia-utils-beta，因为稳定版的驱动不支持一些新引入的特性。
安装的时候，如果 pacman 询问您移除 libgl 并且因为依赖无法移除，可以使用 # pacman -Rdd libgl 移除 libgl.
自动配置nvidia,创建一个基本的配置文件/etc/X11/xorg.conf

#nvidia-xconfig

编辑/etc/X11/xorg.conf ：
关闭启动时的Logo
添加"NoLogo"选项到Device节里：

Option "NoLogo" "1"

启用硬件加速
注意: 从97.46.xx版本开始RenderAccel就已经被默认启用。
添加"RenderAccel"选项在Device节下面：

Option "RenderAccel" "1"

32位应用程序无法启动

在64位系统下，安装lib32-nvidia-utils对应相同版本的64位驱动可以修复这个问题。

笔记本触摸板驱动

笔记本(或触摸屏)用户需要 synaptics 软件包以支持触摸板/触摸屏：
# pacman -S xf86-input-synaptics

中文化与安装字体
除了设置好locale，还需要安装中文字体。
常用的免费（GPL或兼容版权）中文字体有：

wqy-bitmapfont
wqy-zenhei
ttf-arphic-ukai
ttf-arphic-uming
ttf-fireflysung
wqy-microhei（AUR中）
wqy-microhei-lite（AUR中）

系统字体将默认安装到/usr/share/fonts。
也可以手动安装字体，将字体复制到 /usr/share/fonts，进入/usr/share/fonts，执行 fc-cache -fv

更新系统
更新前，请阅读 新闻 (或者 通告邮件列表)。开发者通常会针对已知问题提供需要配置和修改的重要信息。在升级前访问这些页面是个好习惯。
同步、刷新、升级整个系统：

# pacman -Syu

卸载分区并重启系统
如果还在 chroot 环境，先用 exit 命令退出系统：

# exit

卸载/mnt中挂载的系统：

# umount /mnt/{boot,home,}

重启：

# reboot

硬盘里有ntfs分区的需要挂载，编辑/etc/fstab

首先在/mnt创建挂载到的文件夹

$sudo mkdir /mnt/winc /mnt/wind /mnt/wine

安装ntfs-3g

$sudo pacman -S ntfs-3g

编辑 fstab

$sudo leafpad /etc/fstab

添加如下类似文件，自己修改

/dev/sda1 /media/winc ntfs defaults,iocharset=utf8 0 0
/dev/sda5 /media/wind ntfs defaults,iocharset=utf8 0 0
/dev/sda6 /media/wine ntfs defaults,iocharset=utf8 0 0

下面是lxde的简易配置
没有快捷键真不爽，所以首先设置它
网上都是说rc.xml用于设置快捷键，但是很奇怪，我发现登录后，快捷键没生效，不过如果运行了fusion-icon，点击一下reload window manager，快捷键就能生效
继续研究发现，~/.config/openbox下还有一个lxde-rc.xml文件，这里也可以设置快捷键，和上面相反，这里的设置在登录后直接就能用，但reload wm后就不能用了。
所以办法是，对两个文件都设置，格式如下：

     <keybind key="F9">
          <action name="Execute">
            <execute>gnome-terminal -x mocp</execute>
          </action>
        </keybind>

其中第一行是要设置的快捷键，第三行是相应的命令，把它放在 和之间。
LXDE下我找不到调节音量的东东，所以把音量调节绑定到快捷键了：

    <!-- 音量調節 -->
    <keybind key="C-KP_3">
    <action name="Execute">
    <command>amixer -q set Master 3%-</command>
    </action>
    </keybind>
    <keybind key="C-KP_9">
    <action name="Execute">
    <command>amixer -q set Master unmute 3%+</command>
    </action>
    </keybind>

接下来设置一下字体DPI，默认的太小了,改为96：

$ echo Xft.dpi:96 >> ~/.Xresources

如果使用startx启动Openbox的话，要在.xinitrc的开始处添加一行：

xrdb -merge ~/.Xresources

其它设置可以用obconf，LXDE会继承gnome的一些东西，比如登录时自动运行的程序，在/.config/autostart目录下。
主题之类的可以在“程序菜单-首选项-外观”那里设置

#编辑~/.xprofile，使fcitx自启动

#!/bin/sh
LANG=zh_CN.UTF-8
export XMODIFIERS="@im=fcitx"
fcitx &

接下来就是使用sudo，自动挂载U盘，配置vim zsh 看个人需要了。
到这里弱菜君的安装笔记就算是结束了，Arch采用systemed，表示很不习惯，也不是很经常用，也没有用过逆天的aur，现在不怎么进Arch了，主要用Debian，寒假准备最后换成Gentoo后稳定下来。