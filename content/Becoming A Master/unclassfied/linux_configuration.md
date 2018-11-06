```
netdata
  - sys monitor
  - Netdata是一个高度优化的Linux守护进程，它为Linux系统，应用程序，SNMP服务等提供实时的性能监测。

boot
  - grub2-mkconfig -o /boot/grub2/grub.cfg
  - efibootmgr -v

node.js
  gitbook
  calibre

maven3.5
    tar xzvf apache-maven-3.5.0-bin.tar.gz
    mv apache-maven-3.5.0 /opt
    make sure jdk newer than 1.8
    mvn -v:
        Apache Maven 3.5.0 (ff8f5e7444045639af65f6095c62210b5713f426; 2017-04-04T03:39:06+08:00)
        Maven home: /opt/apache-maven-3.5.0
        Java version: 1.8.0_121, vendor: Oracle Corporation
        Java home: /usr/lib64/jvm/java-1.8.0-openjdk-1.8.0/jre
        Default locale: en_US, platform encoding: ANSI_X3.4-1968
        OS name: "linux", version: "4.1.39-56-default", arch: "amd64", family: "unix"

gnuarmeclipse-plug-ins.git
    git clone --branch=master https://github.com/gnuarmeclipse/plug-ins.git gnuarmeclipse/plug-ins.git
    cd gnuarmeclipse/plug-ins.git
    mvn -Dtycho.localArtifacts=ignore clean install
    The result is a p2 repository, in ilg.gnuarmeclipse-repository/target/repository
    newer than Eclipse Mars.2

add user path
    .bashrc
        PATH=${PATH}:[user path here:user path here]; export PATH;
add library path
    /etc/ld.so.conf
    /etc/ld.so.conf.d/*.conf
        [add your so path here]
    run `ldconfig`

sar sysstat
    - 性能分析
    - opensuse: SystemTap
      - stap

xgcom
  - 串口调试
  - https://github.com/helight/xgcom.git
  - gtk2-devel
  - vte2-devel
  - 
gtk2-devel, libvte9, typelib-1_0-Gtk-2_0, vte2-devel, vte2-lang

Eclipse



grub site:
    wget --mirror [--convert-links] http://www.gnu.org/
    或短写参数：
    wget -m [-k] http://www.gnu.org
    --mirror或-m：镜像整个网站，它与“-r -l inf -N”这三个参数一起用效果相同
    --recursive或-r：以递归方式抓取
    --level=depth或-l depth：递归的深度，缺省最大值为5，0或inf表示无限多
    --timestamping或-N：时间戳，不知道有什么用
    --convert-links或-k：在全部下载完成之后，修改已下载页面中的链接，如果链接所指向的文件也下在本地了，就指向这个文件，否则，就指向http上原来的文件
    二. 其它有用的参数：
    --tries=number 或 -t number：指定连接失败时重试次数，0或inf表示无限重试，缺省值为20。但如果遇到“连接被拒绝”或“文件没找到(404)”之类的错误，则不重试
    --output-document=file或-O file：指定输出文件名。比如：wget http://xxx.com/index.html -O abc.htm 将以abc.htm保存文件
    --no-clobber或-nc：通常在遇到下下来的文件重名，wget将为后下的文件加上‘.1’，‘.2’等加以区分。如果用了这个参数，则一旦后下的文件将与先下的同名，将不再下载后下的文件而保留先下的不变
    --no-directories或-nd：保存文件时，即使原来不在一起的文件，也不创建文件夹，所有文件全放在当前目录下
    --page-requisites或-p：下载html文件时，把与它有关的图片，声音，脚本等相关文件一同下下来
    * 所有参数都可以根据需要灵活搭配，不是固定的
```
