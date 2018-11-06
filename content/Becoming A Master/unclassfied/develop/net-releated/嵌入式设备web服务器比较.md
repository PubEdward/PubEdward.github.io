

现在在嵌入式设备中所使用的web服务器主要有：boa、thttpd、mini_httpd、shttpd、lighttpd、goaheand、appweb和apache等。

嵌入式设备web服务器比较
Boa

1.介绍

Boa诞生于1991年，作者Paul Philips。是开源的，应用很广泛，特别适合于嵌入式设备，网上流行程度很广。它的官方网站说boa是最受人喜爱的嵌入式web服务器。功能较为强 大，支持认证，cgi等。Boa 是一个单任务的HTTP SERVER，它不像传统的web服务器那样为每个访问连接开启一个进程，也不会为多个连接开启多个自身的拷贝。Boa对所有的活动的http连接在内部 进行处理，而且只为每个CGI连接（独立的进程）开启新的进程。因此，boa在同等硬件条件下显示出更快的速度。测试表明boa在Pentium 300MHZ下能够每秒钟处理几千次点击，在20 MHz 386/SX下能够每秒钟处理几十次点击访问。

Boa和thttpd等，与apache等高性能的web服务器主要区别是，它们一般是单进程的服务器，只有在完成一个用户请求后才能响应另一个用户的请求，无法并发响应，但这在嵌入式设备的应用场合里已经足够了。

Boa设计主要出于速度和安全，是指不被恶意用户暗中破坏，而不是指它有很好的访问控制和通信加密。可以添加SSL来保证数据传输中的保密和安全。

2.操作系统

All POSIX (Linux/BSD/UNIX-like OSes)

3.版本

从0.90到现在的最新发布版本0.94。最新发布版本0.94：boa-0.94.13.tar大小为120k，解压后为436k，编译之后的可执行代码在60k左右。最近开发版本：boa-0.94.14rc21

4.可执行程序的大小、内存需求情况

Boa有最少的资源需求。非常少的内存需求，能耗很小。 特别适合于嵌入式市场。含有gcc 2.95.3和 GNU libc 2.2.5的boa的二进制文件大小为61K（ 495K statically linked ）。使用库uClibc，boa变得更小（92K statically linked）。

有人曾做过测试：所用环境AMD Duron 700，384MB RAM, RealTek 8139，SiS900 chipset-based NICs ，LinkSys 10/100 hub，Linux 2.4，结果是：Boa的虚拟内存（VmSize）大小是1696kB，85％是库文件。虚拟内存数据（VmData size）大小是108kB。Boa每次连个并发连接消耗掉20kB的内存。

参考比较表：

Server

Stripped Binary Size

VmSize

External Libraries

Boa 0.94.13

61kB

1700kB

0

Apache 1.3.26

277kB

11,000kB

9

thttpd 2.20c

64kB

1800kB

0

5.功能、特点

l 支持HTTP/1.0(实验性的、有条件的支持HTTP/1.1)

l 支持CGI/1.1，编程语言除了C语言外，还支持Python, Perl, PHP，但对PHP没有直接支持，没有mod_perl, mod_snake/mod_python等。

l Boa支持HTTP认证，但不支持多用户认证。

l 它可以配置成SSL/HTTPS和 IPv6。

l 支持虚拟主机功能。

Boa服务器与其它服务器的不同：

为了追求速度和简单性，boa服务器在一些方面不同于一些流行的web服务器。

CGI程序的REMOTE_HOST环境变量没有设置

The REMOTE_HOST environment variable is not set for CGI programs, for reasons already described. This is easily worked around because the IP address is provided in the REMOTE_ADDR variable, so (if the CGI program actually cares) gethostbyaddr or a variant can be used.

Boa不具有ssi（server side includes）。

We don't like them, and they are too slow to parse. We will consider more efficient alternatives.

Boa不具有访问控制。

Boa will follow symbolic links, and serve any file that it can read. The expectation is that you will configure Boa to run as user "nobody", and only files configured world readable will come out.

没有chroot选项。

There is no option to run chrooted. If anybody wants this, and is willing to try out experimental code, contact the maintainers.

官方网站：www.boa.org
Thttpd

1.介绍

Thttpd是ACME公司设计的一款比较精巧的开源Web服务器。它的初衷是提供一款简单、小巧、易移植、快速和安全的HTTP服务器，而事实 上，Thttpd也正是这样一款服务器。它在Unix系统上运行的二进制代码程序，仅仅400k左右，在同类Web服务器中应该是相当精巧的。在可移植性 方面，它能够在几乎所有的Unix系统上和已知的操作系统上编译和运行。Thttpd在默认的状况下，仅运行于普通用户模式下，从而能够有效地杜绝非授权 的系统资源和数据的访问，同时通过扩展它也可以支持HTTPS、SSL和TLS安全协议。Thttpd尤为称道的是已经全面支持IPv6协议， 并且具有独特的Throttling功能，可以根据需要限制某些URL和URL组的服务输出量。此外，Thttpd全面支持HTTP 1.1协议（RFC 2616）、CGI 1.1、HTTP 基本验证（RFC2617）、虚拟主机及支持大部分的SSI（Server Side Include）功能，并能够采用PHP脚本语言进行服务器端CGI的编程。

thttpd是一个非常小巧的轻量级web server，它非常简单，对于并发请求不使用fork()来派生子进程处理，而是采用多路复用(Multiplex)技术来实现。因此效能很好。对于小 型web server而言，速度快似乎是一个代名词，通过官方站提供的Benchmark，可以这样认为：thttpd至少和主流的web server一样快，在高负载下更快，因为其资源占用小的缘故。Thttpd还有一个较为引人注目的特点：基于URL的文件流量限制，这对于下载的流量控 制而言是非常方便的。象Apache就必须使用插件实现，效率较thttpd低。Thttp是开源的。是用C语言编写的。使用的很多。

2.操作系统
Thttpd支持多种平台，如FreeBSD, SunOS, Solaris, BSD, Linux, OSF等。

3.版本

最新版本：thttpd-2.25b.tar 130kB，解压后497kB

4. 可执行程序的大小、内存需求情况

编译后的可执行的二进制文件为60kB左右，与boa差不多。版本已从1.90a发展到2.25b，

使用内存很少，没查到具体的数据。

5.特点、功能

thttpd中是一个简单,小型,轻便,快速和安全的http服务器.

特点：

简单：它能够支持HTTP/1.1协议标准，或者超过了最低水平
小巧：它具有非常少的运行时间，因为它不fork子进程来接受新请求，并且非常谨慎

的分配内存

便携：它能够在大部分的类Unix系统上运行，包括FreeBSD, SunOS 4, Solaris 2, BSD/OS, Linux, OSF等等
快速：它的速度要超过主流的Web服务器（Apache, NCSA, Netscape），在高负载情况下，它要快的多。
安全：它努力的保护主机不受到攻击，不中断服务器

thttpd，适合静态资源类的服务，比如图片、资源文件、静态HTML等等的应用，性能应该比较好，同时也适合简单的CGI应用的场合。

功能：

l 支持CGI1.1。

l 支持基本的认证功能。

l 支持Chroot功能

l 支持Throttling。

l 支持IPv6。

l 支持多虚拟主机功能。

l 支持自定义错误页。

l 支持标准日志记录。

l Thttpd处理了大量的信号，这些信号是通过标准的Unix kill(1) command发出的。

l 通过扩展它也可以支持HTTPS、SSL和TLS安全协议。

使用建议: 对于那些并发访问量中等，而又需要较强响应能力、并期望能够控制用户访问流量，而且有较高安全性需求的用户而言，thttpd Web服务器显然是一个比较好的选择。 thttpd目前的最新版本是2.2.5版。

下图为www.acme.com/software/thttpd网站对几种web server比较图。

嵌入式设备web服务器比较 各种服务器的比较：

· Software – 哪种web服务器

o Name

o Version

o Released – 什么时候发布的

o Active devel - 是否当前还在开发中。

· Features –一些关键服务器的特点

o Model - what kind of server it is. The models are:

§ fork - start a new process for each request.

§ pre-fork - pre-start a pool of processes which each handle multiple requests.

§ threads - use threads instead of processes.

§ Java threads - this version of the Java runtime uses "Green threads" instead of native threads, so it acts more like the select-based servers.

§ select - use non-blocking I/O and the select() system call to handle multiple requests in a single process, single thread.

从上面可以看到thttpd、boa都是使用select方式，apache使用的是pre-fork方式，由于apache是多进程方式，thttpd、boa是单进程方式，所使用的内存要远小于apache，且速度快于apache。

o Auto-conf （自动配置）- whether there's a script to automatically configure the build process for your OS.

o Basic auth （基本认证）- whether the server supports Basic Authentication, for password-protected web pages.

o Chroot - whether the server lets you use the chroot() system call to enhance security.

o Throttling - the ability to set bandwidth limits on certain pages, so they don't use more than their fair share of the server's resources.

· Size –各种服务器的大小

o Tar bytes - the uncompressed source tarchive size.

o Source files - how many source and header files.

o Source lines - how many lines in the source and header files.

o Exe - the executable size. For the compiled program this is size of the main executable file, stripped. For the Java servers it's the total size of the .class files or .zip files. For Roxen it's the size of the Pike interpreter.

· 基础测试系统。The benchmark test system is a 297MHz Ultra Sparc with 256MB RAM / 512MB swap running Solaris 2.6, otherwise totally quiescent. RLIMIT_NOFILE is 256 soft / 1024 hard, and v.v_maxup is 3941.

· RPS – 每秒响应请求次数。maximum requests per second. This is determined by running the test load at various parallel-request rates and finding the maximum response rate. See the graph below for the full data.

o Small files - the small-file test load consists of 1000 files, each 1KB long, requested randomly.

o CGI - the CGI test load consists of a trivial "hello world" C program. .

· Max users – 最大处理的用户数。This is determined by running the test load at various parallel-request rates and seeing when it starts screwing up. Typical screwups are running out of memory or processes, so that requests start timing out or getting refused.

o Large files - the large-file test load consists of 100 files, each 1MB long, requested randomly. Also, each connection is throttled to simulate a 33.6Kbps modem. Note that 1000 33.6Kbps connections is 3/4 of a T3.

上面的比较中，thttpd和boa都没有使用最新版本，boa的最新版本已经支持基本认证、自动配置等功能。Thttpd和boa的基本功能差不 多，可以互相替换。现在选用web服务器时，同时有boa和thttpd的情况下，选择使用boa的情况居多。我在一篇论文中提到一点，说：thttpd 在运行过程中所需要的资源要远大于boa，但没有验证过。

官方地址：http://www.acme.com/software/thttpd/
下载地址：http://www.acme.com/software/thttpd/thttpd-2.25b.tar.gz
Mini_httpd

1. 介绍

Mini_httpd是一个小型的HTTP服务器。开源，它的性能不强，但是它非常适合于中小访问量的站点。Mini_httpd和thttpd都是ACME Labs 开发的软件，功能没有thttpd强。

2. 操作系统

与thttpd相同。

3. 版本

发布的版本从1.00到1.19。最新发布的版本是version 1.19.tar 41kB,解压后为140kB。

4. 功能、特点

它实现了HTTP服务器的所有的基本功能，包括：

· 支持CGI功能

· 支持基本的验证功能

· 支持安全 .. 上级目录功能

· 支持通用的MIME类型

· 支持目录列表功能

· 支持使用 index.html, index.htm, index.cgi 作为首页

· 支持多个根目录的虚拟主机

· 支持标准日志记录

· 支持自定义错误页

· Trailing-slash redirection

· 它可以配置成SSL/HTTPS和 IPv6.

5.可执行文件大小、内存使用情况

编译后可能要小于boa、thttpd，内存使用可能小于boa、thttpd。Mini_httpd的功能，thttpd功能几乎都覆盖了。

mini_httpd 也是相对比较适合学习、实验使用，大体实现了一个Web Server的功能，支持静态页和CGI，能够用来放置一些个人简单的东西，不适宜投入生产使用。

官方地址：http://www.acme.com/software/thttpd/
下载地址：http://www.acme.com/software/mini_httpd/mini_httpd-1.19.tar.gz
Shttpd

1.介绍

Shttpd，开源。它是另一个轻量级的web server，具有比thttpd更丰富的功能特性，支持CGI, SSL, cookie, MD5认证, 还能嵌入(embedded)到现有的软件里。最有意思的是不需要配置文件！由于shttpd可以轻松嵌入其他程序里，因此shttpd是较为理想的 web server开发原形，开发人员可以基于shttpd开发出自己的webserver，官方网站上称shttpd如果使用 uclibc/dielibc(libc的简化子集)则开销将非常非常低。

2.操作系统

Windows, QNX, RTEMS, UNIX (*BSD, Solaris, Linux)。

3.版本

    它的最新版本是：shttpd-1.38.tar ，75kB，解压后为278kB。发布的版本从2004年的1.3到现在的2007年的1.38

4.功能、特点

l 小巧、快速、不膨胀、无需安装、简单的40KB的exe文件，随意运行

l 支持GET, POST, HEAD, PUT, DELETE 等方法

l 支持CGI, SSL, SSI, MD5验证, resumed download, aliases, inetd模式运行

l 标准日志格式

l 非常简单整洁的嵌入式API

l 对库dietlibc 支持友好，对uClibc (*)不友好。

l 容易定制运行在任意平台：Windows, QNX, RTEMS, UNIX (*BSD, Solaris, Linux)

不具有的功能：

virtual hosts, user home directorires, ACL (access control lists), traffic shaping, keep-alive connections, FCGI (Fast CGI) support.

5.可执行文件大小、内存使用情况

编译后的可执行的二进制文件为40kB左右.

网上查询结果是有关内容很少。使用范围不广。有网友对它的评论是：shttpd功能算是比较全的, 但在处理二进制数据时不够稳定, 时有异常. 有待观察。

官方网站：http://shttpd.sourceforge.net/
下载地址：http://sourceforge.net/project/showfiles.php?group_id=126090&package_id=137886
Lighttpd

1.介绍

Lighttpd是一个德国人领导的开源软件，历时只有三年。其根本的目的是提供一个专门针对高性能网站，安全、快速、兼容性好并且灵活的web server环境。具有非常低的内存开销，cpu占用率低，效能好，以及丰富的模块等特点。lighttpd 是众多OpenSource轻量级的web server中较为优秀的一个。支持FastCGI, CGI, Auth, 输出压缩(output compress), URL重写, Alias等重要功能，而Apache之所以流行，很大程度也是因为功能丰富，在lighttpd上很多功能都有相应的实现了，这点对于apache的用 户是非常重要的，因为迁移到lighttpd就必须面对这些问题。实用起来lighttpd确实非常不错，apache主要的问题是密集并发下，不断的 fork()和切换，以及较高（相对于 lighttpd而言）的内存占用，使系统的资源几尽枯竭。而lighttpd采用了Multiplex技术，代码经过优化，体积非常小，资源占用很低， 而且反应速度相当快。利用apache的rewrite技术，将繁重的cgi/fastcgi任务交给lighttpd来完成，充分利用两者的优点，现在 那台服务器的负载下降了一个数量级，而且反应速度也提高了一个甚至是2个数量级！lighttpd 适合静态资源类的服务，比如图片、资源文件、静态HTML等等的应用，性能应该比较好，同时也适合简单的CGI应用的场合，lighttpd可以很方便的 通过fastcgi支持php。

2.操作系统

    Unix、linux、Solaris、FreeBSD

3.版本

最新版本lighttpd-1.4.17.tar,783kB,解压后为3.48MB

4.功能、特点

下面是lighttpd官方网站给出的lighttpd特点，

l virtual hosts

l virtual directory listings

l URL-Rewriting, HTTP-Redirects

l automatic expiration of files

l Large File Support (64bit fileoffsets)

l Ranges (start-end, start-, -end, multiple ranges)

l on-the-fly output-compression with transparent caching

l deflate, gzip, bzip2

l authentication

l basic, digest

l backends: plain files, htpasswd, htdigest, ldap

l fast and secure application controlled downloads

l Server Side Includes

l User Tracking

l FastCGI, CGI, SSI

l PHP-Support:

l same speed as or faster than apache + mod_php4

l includes a utility to spawn FastCGI processes (neccesary for PHP 4.3.x)

l via FastCGI and CGI interface

l support Code Caches like Turckmm, APC or eaccelarator

l load-balanced FastCGI

l (one webserver distibutes request to multiple PHP-servers via FastCGI)

l Security features:

l chroot(), set UID, set GID

l protecting docroot

l strict HTTP-header parsing

5.可执行文件大小、内存使用情况

没有查到具体数据。

Lighttpd缺点就是bug比较多，软件并不稳定，而且文档太简略，有些功能需要你自己猜测才懂得怎么配置。尤其是使用内存，很难说清楚具体使 用量，一般在10－20M（繁忙站点），但有时候会突发到100多M，并稳定下来。不过相对apache的使用量，这个已经不算多。

lighttpd虽然是web服务器中的轻量级。但对于嵌入式web服务器来说还是较大的一个web服务器，功能较强。

有人评论lighttpd：lighttpd、apache 属重量级服务器, 成熟稳定, 体积较大, 在复杂的嵌入式应用上可选用.

    Lighttpd使用的不广泛，在google中搜索：嵌入式 lighttpd，结果几乎没有相关的内容。Lighttpd使用内存比其它小型嵌入式web服务器内存资源要多。毕竟它不是专为嵌入式设备开发的。
官方网站：www.lighttpd.net
Goahead

1.介绍

GoAhead Webserver是为嵌入式实时操作系统（RTOS）量身定制的Web服务器。它的目标也许不在于目前的WEB服务器市场，而是面向当嵌入式系统深入我 们的工作与生活的明天，那时，它也许会成为使用最广泛的WEB服务器。GoAhead Webserver构建在设备管理框架（Device Management Framework）之上，用户可以像标准的Web Services一样来部署自己的应用，不需要额外的编程。GoAhead Webserver支持SOAP客户端（Simple Object Access Protocol，简单对象访问协议），XML-RPC客户端，各种Web浏览器和单独的Flash客户端。GoAhead Webserver支持一种类ASP的服务器端脚本语言，其语法形式和微软的ASP语法基本相同（Active Server Page）。GoAhead Webserver是跨平台的服务器软件，可以稳定地运行在Windows，Linux和Mac OS X操作系统之上。GoAhead Webserver是开放源代码的，这意味着你可以随意修改Web服务器的功能。这款WEB服务器非常小巧，它的WIN CE版本编译后的大小还不到60k，它的输出通常也是面向一些小屏幕设备。在性能方面，使用一颗24MH z的68040处理器，它的响应速度为20次/秒，使用266MHz的Pentium处理器可以达到50次/秒的响应速度。

2.操作系统

Windows CE, Wind River VxWorks, Linux, Lynx, QNX,与Windows 95/98/NT

3版本

Goahead从2003年开始发布，最新的版本：webs218.tar ，827kB，解压后为2.28MB
4.功能、特点

· 很小的内存消耗

· 支持认证功能Digest Access Authentication (DAA)

· 支持安全的通信，例如SSL（安全的套接字层）

· 支持动态Web页面，如ASP页面

· 可以使用传统的C语言编程定制Web页面里的HTML标签

· 支持CGI（公共网关编程接口）

· 嵌入式的JavaScript脚本翻译器

· 独特的URL分析器

· 它基本上属于一个HTTP1.0标准的WEB服务器，对一些HTTP1.1的特性如（持久连接）也提供了支持。每秒65次connections

5.可执行文件大小、内存使用情况

内存需求60K，它的WIN CE版本编译后的大小还不到60k。

自 2004 年 2.18 版之后, GoAhead 官方不再对它免费许可的升级和支持,如果是学习和研究之用, 移植很方便, 不必关心太多; 如果商用, 那些已知的 bug 就必须手工去改，包括对 cgi 的支持, 对操作系统差异而引用的 bug，参考下这个 http://www.eybuild.com/develop/demoshow.htm ，这个就是用的 GoAhead。

GoAhead官方网站：http://webserver.goahead.com/
AppWeb

1.介绍

appWeb有两种许可，一种是GPL，免费的，另外一种是商业许可，有30天的试用期。免费的版本在http://www.appwebserver.org/ 下载，appWeb的商业版本由Mbedthis公司发布和维护，网址是http://www.mbedthis.com/。appweb 是下一代嵌入式web服务器，它天生是为嵌入式开发的，它的最初设计理念就是安全。Appweb是一个快速、低内存使用量、标准库、方便的服务器。与其它 嵌入式web服务器相比，appweb最大特点就是功能多和高度的安全保障。Appweb简单、方便、开源。

2.操作系统

Linux, Windows, Mac OSX , Solaris

3.版本

    Appweb最新版本是appweb-src-2.2.2 ，大小1.195MB，解压后6.22MB

4.功能、特点

AppWeb提供的一些关键好处：

l 低开发成本。支持cgi/1.1、javastript、esp、php(4and5)，加快开发进度。

l 最小的资源需求。一秒能响应3500个请求，非常迅速，并且紧凑（110KB）。

l 灵活的开发环境。Appweb高度模块化，可以根据需要取舍。

l 可靠性

具有的功能：

· 支持嵌入式JavaScript，esp，egi，cgi和php。.

· 容易使用。 大量的例子文档可用。

· 安全。支持SSL、认证。 Secure Socket Layer (SSL) including both client and server certificates. Digest and Basic Authentication. Sandbox directives to limit denial of service attacks.

· 模块化. Select only the features you need via dynamically loadable modules. Also supports granular source code compilation directives.

· 性能突出。. Fastest performance in its class. Over 3500 requests per second on a PC class device. Memory footprint from 110K. Code and web pages are fully ROMable.

· 符合标准. AppWeb supports HTTP/1.0, HTTP/1.1, CGI/1.1, SSL RFC 2246, HTTP RFC 2617

· 方便. AppWeb has been ported to Linux, Windows, Mac OSX and Solaris and support the following CPU architectures: ARM7, MIPS32, i386/X86, PowerPC and Sparc

Feature Overview

Dynamic Content

· Embedded Server Pages (ESP)

· Embedded JavaScript

· Embedded Gateway Interface (in-memory CGI)

· CGI/1.1

· PHP (4 and 5)

Embedded Server Pages

· Server-side JavaScripting

· Integrated session state management

· Scripted generation of HTML

· Extensible via new functions

· Manage client state-data via sessions

· Post-back paradigm. Same page for form and post logic

Security

· Secure Sockets Layer (SSL)

· Basic and Digest Authentication

· Directory and URL location based authorization

· Sandbox limits

· Access and access violation logging

Modularity

· Dynamic loading of modules

· Extensible URL handlers

· Extensible / replaceable authorization, SSL and script

Ease of Use

· Apache-style configuration file

· Debugging and trace logging

· Packaged installations for Linux and Windows

· Run as a service / daemon

Other Features

· HTTP server and client access program

· Named and IP based virtual hosts

· Listen on multiple ports

· Compile web pages and files into C code for execution from ROM

Standards

· HTTP/1.1

· CGI/1.1

· Apache configuration file compatibility

Performance

· Multithreaded with high performance thread pool 

· Request throughput (> 3,500 requests per second)

· Scales on multi-cpu systems

· Small memory footprint even under heavy load (from 400K)

Developer Features

· HTTP server and client libraries 

· Shared and static libraries supplied

· C and C++ APIs

· Operate single-threaded or multithreaded (Compile or run-time selectable)

· Easy, intuitive programming model

· Integrate with common event mechanism: Windows Messages, Unix select, dedicated thread

· Coding minimized as most features can be specified via the configuration file

· Cookbook of samples (cut and paste to get going)

· SMP safe

· Extensive debug trace logging

     O'Brien describes AppWeb as a "mini-Apache" in part because it features compatibility with Apache configuration syntax. "One of our customers was able to solve a problem using Apache documentation from the Internet," O'Brien notes. AppWeb is not based on the apache codebase, however. "It's a clean implementation," says O'Brien. "It's really hard to shrink something down."
嵌入式设备web服务器比较
AppWeb architecture

5.可执行文件大小、内存使用情况

    内存使用110KB， Small memory footprint even under heavy load (from 400K)。

官方网站http://www.appwebserver.org/

商业网站http://www.mbedthis.com/
Apache

最新的apache版本是httpd-2.2.4.tar，6.07MB，解压后为27.2MB，在嵌入式web服务器中很少使用，在网上搜索看到 有人在vxwork上用过apache，在其它方面没有，我认为，goahead、appweb具有丰富的功能，没有使用apache的必要。另一个原因 是因为apache是一个多进程web服务器，使用的内存很多。

由于apache的prefork工作模式有关。每个apache进程只能同时服务于一个http连接。这种模式好处在于每个进程不互相干扰，稳定 性好；缺点也建立在优点之上，就是占用资源多，即使每个进程只使用2M内存（如果使用了php，这点内存根本不够）,100的并发连接就用掉200M的内 存。
开发语言和开发工具

现在的嵌入式linux中CGI程序主要使用C语言。对于编写C语言的CGI程序，可以编写好程序之后，在linux操作系统下编译，用针对硬件平 台的linux的交叉编译工具编译就可以，写的html网页界面在记事本写即可。我以前写的CGI程序就是在此环境下写的。这也是最普遍的开发方法。

对于用C语言编写CGI程序还可以使用CSP/eybuild提供的平台库及其开发套件，它可以将CGI程序嵌入式到网页中，可以提高开发效率。传 统用C做CGI的方法是直接使用printf() 等标准I/O函数输出HTML代码，这样不但使得C程序和HTML程序交织的混乱不堪，还使得页面输出的流程控制变得非常复杂。CSP与之不同，它充分吸 取了ASP/JSP/PHP等以HTML/ XML为模板嵌入脚本语言优点，并充分融合C语言的语言特性。使得CSP的开发更快速、更高效，同时还大大提了最终代码的可读性和维护性。 CSP设计的最原始的初衷，就是要为嵌入式开发定制的一套类似 ASP/JSP/PHP的C语言开发工具。针对设备WEB开发CSP提供了丰富的平台库和开发工具，它们为设备系统的WEB交叉开发和移植提供了有力的支 持。通过交叉开发，可以在其它硬功件平台完全未准完毕的情况下进行高层软件的开发。这不仅能为产品开发有效地节约软硬件资源，还为WEB程序提供简单有效 地调试工具。

但缺点是，CSP/eybuild不是一个开源的项目，如果你是个人使用或出于学习、研究目的你可以从eybuild的官方站点http: //www.eybuild.com 免费下载，或发邮件到 eybuild@hotmail.com 免费索取。它的站点上可以下载针对x86、arm920T的CSP/eybuild开发平台，其它平台需要向网站上定购。如果你想在你的嵌入式设备的开发 板上试用或出于学习和研究目的，你也可把您目标板及编译环境的详细资料发给eybuild@hotmail.com，请求为你的目标板单独制作一份交叉编 译开发的CSP/eybuild平台。如果你想你的商用产品或项目中使用CSP/eybuild，你必须在CSP/eybuild的商用授权后才可使用。 商用授权后您将可以得到很好的技术支持和技术培训。关于商用授权的详细流程，可邮件至eybuild@hotmail.com 垂询。

用C语言编写CGI与其它语言编写CGI的比较：

C语言简洁紧凑，使用方便、灵活，对程序的语法结构要求不是很严，这就使得编程

人员在编程时具有很大的灵活性，可以设计出自己风格的程序。不像UNIX SHELL、Perl和TCL，C语言是一种编译语言，源程序代码要被系统的续译器翻译成机器能直接执行的二进制代码，因此用C语言编写的CGI程序的运 行速度要比用解释性语言编写的程序快。使用编泽语言的另一个好处是即使CGI执行程序陷入黑客之手，他们也无法像分析用解释性语言编写的CGI程序那样找 到程序中的漏洞。由于C语言最初是针对系统设计的，这使得C语言的字符串处理能力比较差，如果CGI程序需要对字符串进行一些复杂的操作，用C诺言实现起 来将比较麻烦，代码量也较多。现在网上用C语言编写的CGI程序仅次于Perl（Perl编写程序简单方便）。

嵌入式设备web服务器比较

CGI与JSP的比较：

Servlet是Java技术对CGI编程的回答。Servlet程序在服务器端运行，动态地生成Web页面。与传统的CGI和许多其他类似CGI 的技术相比，Java Servlet具有更高的效率，更容易使用，功能更强大，具有更好的可移植性，更节省投资。详细内容见备注。JSP是强于CGI，这也是现在CGI技术的 使用没有JSP使用多的原因。但现在嵌入式web服务器端程序开发，还是CGI较多。由于使用JSP技术，在嵌入式web服务器开发中很少使用，在网上没 有查到关于在嵌入式web服务器上应用的有关内容。

要实现阅读器的lmt，所需的CGI代码量估计不会很多，关键在于调试。
结论

    根据上面的分析，考虑到使用范围宽广程度，在小型服务器、不要求太强功能，推荐选用boa、thttpd，其实它们足可以满足大多数情况下的需求，也是使 用最广、可参考最多的嵌入式web服务器。如果要求强大的功能，支持javastript等，推荐选用goahead、appweb。
备注：

一个网友的个人意见：

boa 的功能比较齐全, 便对嵌入式应用很多功能就是冗余(如virtual host), 内存使用量较大些.
thttpd 功能较少, 实现简单. 内存使用量较少. 同时比较方便扩展.
shttpd 功能功能算是比较全的, 但在处理二进制数据时不够稳定, 时有异常. 有待观察.
light-httpd, apache 属重量级服务器, 成熟稳定, 体积较大, 在复杂的嵌入式应用上可选用.
goAhead 是个比较专用的 webserver, 大部分功能都在服务它自己提供的 goform 功能和 
          ASP/javascript 功能. 最后的 2.1.8 版仍有不少bug. (见下)
mini-httpd 与 thttpd 是同一家, 功能几乎完全一样.
boa 缺陷: 
   (1) 未提供 CGI 解析头处理.
可按这个地址方便修改. http://bbs.chinaunix.net/viewthread.php?tid=824840
   (2) 对 POST 数据使用临时文件缓冲, 对无法创临时文件的小系统系统, 需要手工改下这部代码.
很多人报告在移植时不能POST 数据, 都是这个原因.
   (3) ...
thttpd 缺陷:
   (1)  CGI1.1 标准支持不完整(不般影响不大), 未提供对协议要求的其它HTTP头处理, 
如:If-Modified-Since, Accept-Language等应用程序就收不到.
   (2) 直接使用 socket 到 CGI 应用的重定, 会导致提供大量 POST 数据时(如上传文件), 
        CGI应用不读完全部 POST 数据就无法向浏览器应答 bug
   (3) ...
goAhead 缺陷:
   (1) 专用, 如喜欢它提供的 goform和 asp 令论.
   (2) CGI 对二进制输出有很多 bug.
   (3) 为实现单一任务处理, 在很平台采用延时轮询接收队列, 处理效率不高.
   (4) 其它 bug 有不一罗列了, 移植时要一个个订下.
个人观点, 仅供参考.
Good Luck!

CGI, mod_perl, PHP, JSP性能比较

这是网上一篇关于CGI，mod_perl,PHP,JSP的性能比较的文章，从中可以看出它们的性能。

测试结果很大程度上依赖于机器的硬件/软件配置，并随配置变化而产生差异，因此：
本测试结果 *仅供参考*  
测试用硬件：
CPU: Intel PII 300(66x4.5)  
RAM: 192M  
HD: IBM 20G(2M cache)  
测试用软件：
OS: Slackware 7(自行编译的2.2.14核心)  
Web: Apache 1.3.12(标准模块按缺省配置，所有模块静态编译)  
PHP 4.0 RC1(加入了MySQL支持)  
mod_perl 1.23(缺省配置，未加EVERYTHING=1)  
ApacheJServ 1.1(缺省配置)  
JDK: JDK 1.2.2  
JSDK: JSDK 2  
JSP: GNUJSP 1.0.0  
JSP: GNUJSP 1.0.0  
本测试是用Apache自带的Apache Bench(ab)进行的，命令为：
/www/bin/ab -c 20 -n 1000 CGI/脚本URL  
此命令表示使用 20 个并发连接，进行 1000 次请求。所有测试均在本机进行，各种测试均反复进行5次，去掉最大最小值后取平均值。 我分别测试了C写的CGI、Perl写的CGI、用mod_perl执行的Perl CGI、PHP和JSP。
各种CGI/脚本均输出内容相似的简单页面，内容如下：
html  
body  
h1The xxxx Hello Program/h1  
p  
Hello xxxx World!  
/body  
/html  
测试结果(只取了最具代表性的 Requests per second 即每秒处理请求数这一项)  
CGI/脚本类型 每秒处理请求数
C CGI  128  
Perl CGI  69  
mod_perl  223  
PHP  237  
JSP  21  
测试结论： 

除了JSP之外，其它几种CGI/脚本的表现大致是正常的。Perl程序解释执行，作为
CGI运行时又需要另外fork进程，所以最慢；mod_perl和PHP都直接在httpd内部运行脚本，省掉了fork的消耗，所以快了很多；C程序 虽然本应最快，但作为CGI 运行时也是因为fork而使性能大打折扣。至于JSP...我想这个结果并不具有代表性。毕竟测试用机只有192M内存，用top看看，一个JAVA就占 了11M。况且测试用机本身是一台Web server，测试时还有好几十个httpd在跑不过不管怎么说，在配置较低的服务器上，跑PHP、mod_perl在性能上要好过JSP是肯定的。
附测试用程序：
C程序 hello.c  
#include stdio.h  
int main(void)  
{  
char s[] = "C CGI";  
printf ("Content-Type: text/html ");  
printf ("html "  
"body "  
"h1The C CGI Hello Program/h1 "  
"p "  
"Hello %s World! "  
"/body "  
"/html ", s);  
return 0;  
}  
用 gcc -o hello hello.c 编译，把 hello 放到 cgi-bin目录下。
Perl程序 hello.pl  
#!/usr/bin/perl  
#!/usr/bin/perl  
$s = "Perl CGI";  
print "Content-Type: text/html ";  
print <<DONE  
html  
body  
h1The Perl CGI Hello Program/h1  
p  
Hello $s World!  
/body  
/html  
DONE  
把hello.pl放到cgi-bin目录下，兼作Perl CGI和mod_perl 脚本测试用。
PHP文件 hello.php  
html  
body  
h1The PHP Hello Program/h1  
<? $s = "PHP"; ?>;  
p  
Hello <? echo $s ?>; World!  
/body  
/body  
/html  
JSP文件 hello.jsp  
html  
body  
h1The JSP Hello Program/h1  
p  
<% String s = "JSP"; %>;  
p  
Hello <%= s %>; World!  
/body  
/html

Java Servlet和JSP的技术概述以及比较

Java Servlet及其特点

Servlet是Java技术对CGI编程的回答。Servlet程序在服务器端运行，动态地生成Web页面。与传统的CGI和许多其他类似CGI 的技术相比，Java Servlet具有更高的效率，更容易使用，功能更强大，具有更好的可移植性，更节省投资（更重要的是， Servlet程序员收入要比Perl程序员高:-）：

高效:

在传统的CGI中，每个请求都要启动一个新的进程，如果CGI程序本身的执行时间较短，启动进程所需要的开销很可能反而超过实际执行时间。而在Servlet中，每个请求由一个轻量级的Java线程处理（而不是重量级的操作系统进程）。

在传统CGI中，如果有N个并发的对同一CGI程序的请求，则该CGI程序的代码在内存中重复装载了N次；而对于Servlet，处理请求的是N个 线程，只需要一份Servlet类代码。在性能优化方面，Servlet也比CGI有着更多的选择，比如缓冲以前的计算结果，保持数据库连接的活动，等 等。

方便:

Servlet提供了大量的实用工具例程，例如自动地解析和解码HTML表单数据、读取和设置HTTP头、处理Cookie、跟踪会话状态等。

功能强大:

在Servlet中，许多使用传统CGI程序很难完成的任务都可以轻松地完成。例如，Servlet能够直接和Web服务器交互，而普通的CGI程序不能。Servlet还能够在各个程序之间共享数据，使得数据库连接池之类的功能很容易实现。

可移植性好:

Servlet用Java编写，Servlet API具有完善的标准。因此，为I-Planet Enterprise Server写的Servlet无需任何实质上的改动即可移植到Apache、Microsoft IIS或者WebStar。几乎所有的主流服务器都直接或通过插件支持Servlet。

节省投资:

不仅有许多廉价甚至免费的Web服务器可供个人或小规模网站使用，而且对于现有的服务器，如果它不支持Servlet的话，要加上这部分功能也往往是免费的（或只需要极少的投资）。

JSP及其特点

JavaServer Pages（JSP）是一种实现普通静态HTML和动态HTML混合编码的技术，有关JSP基础概念的说明请参见《JSP技术简介 》。

许多由CGI程序生成的页面大部分仍旧是静态HTML，动态内容只在页面中有限的几个部分出现。但是包括Servlet在内的大多数CGI技术及其变种，总是通过程序生成整个页面。JSP使得我们可以分别创建这两个部分。例如，下面就是一个简单的JSP页面：

＜!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"＞

＜HTML＞

＜HEAD＞＜TITLE＞欢迎访问网上商店＜/TITLE＞＜/HEAD＞

＜BODY＞

＜H1＞欢迎＜/H1＞

＜SMALL＞欢迎,

＜!-- 首次访问的用户名字为"New User" --＞

＜% out.println(Utils.getUserNameFromCookie(request)); %＞

要设置帐号信息，请点击

＜A HREF=http://www.blue1000.com/article/"Account-Settings.HTML"＞这里＜/A＞＜/SMALL＞

＜P＞

页面的其余内容。.

＜/BODY＞＜/HTML＞

下面是JSP和其他类似或相关技术的一个简单比较：

JSP和Active Server Pages（ASP）相比

Microsoft的ASP是一种和JSP类似的技术。JSP和ASP相比具有两方面的优点。首先，动态部分用Java编写，而不是VB Script或其他Microsoft语言，不仅功能更强大而且更易于使用。第二，JSP应用可以移植到其他操作系统和非Microsoft的Web服务 器上。

JSP和纯Servlet相比

JSP并没有增加任何本质上不能用Servlet实现的功能。但是，在JSP中编写静态HTML更加方便，不必再用 println语句来输出每一行HTML代码。更重要的是，借助内容和外观的分离，页面制作中不同性质的任务可以方便地分开：比如，由页面设计专家进行 HTML设计，同时留出供Servlet程序员插入动态内容的空间。

JSP和服务器端包含（Server-Side Include，SSI）相比

SSI是一种受到广泛支持的在静态HTML中引入外部代码的技术。JSP在这方面的支持更为完善，因为它可以用Servlet而不是独立的程序来生成动态内容。另外，SSI实际上只用于简单的包含，而不是面向那些能够处理表单数据、访问数据库的“真正的”程序。

JSP和JavaScript相比

JavaScript能够在客户端动态地生成HTML。虽然JavaScript很有用，但它只能处理以客户端环境为基础的动态信息。除了 Cookie之外，HTTP状态和表单提交数据对JavaScript来说都是不可用的。另外，由于是在客户端运行，JavaScript不能访问服务器 端资源，比如数据库、目录信息等等。

Java很占内存吗？

使用Java平台进行嵌入式设备开发时，其对内在的使用量，会不会比使用原始语言如C/C++更大些呢？这取决于软件的复杂性。Java由于虚拟机和内库的原因，有可能会导致内存开销的增大。下面比较一下Java平台内存的占用情况（基于Sun的实现）：

CLDC（Connected Limited Device Configuration，运算功能有限、电力有限的嵌入式装置，如PDA 、手机等）：可工作于100K（RAM），JIT（Just In Time,即时编译技术）需要最大些。典型的部署要求500K-16M（RAM）。

CDC（Connected Device Configuration，运算能力相对较佳、并请在电力供应上相对比较充足的嵌入式装置，如冷气机、电冰箱等）：VM约为250K，JIT小于 300K，VM+JIT+基础类库约占2-2.5M。典型的部署要求：4M-32M。

当然，内存的占用量还取决于应用的大小及内在的使用情况。可以看出，其实Java平台不会占用太大的内存。但是，这只是问题的一半。另一半 是，Java代码最后部署时是以类文件来部署的，它主要是包括字节码和元数据。通过对CVM数据的分析，可以看出，字节码占据着大概30%的数据量。而采 用JIT编译的代码相对于字节码而言，可以发现，内存的占有量增加了，并有一个7-8倍的ARM指令集。由于，可以估计：

Java类转成字节码的速度≈1/30%≈3.3x；

原始语言转成字节码的速度≈7x。

这意味着，Java代码的内存使用量约为原始语言代码的一半。当然这只是非常粗略的估算，但却是合理的估算。

使用Java的JIT后，只有那些使用频率高的代码才会被编译。而在系统中只是偶然被执行的代码则采用解释来编译。同时，JIT尽量使被编译的代码 其内存占有量保持在一较小的范围内。对CVM（CDC所使用虚拟机），默认值为512K。而在一些较优秀的程序中，可以发现，其值为100K-300K。

这也就是说，使用Java编写的程序，只有使用频率比较高的代码才导致内存占用的增加。相反，使用C/C++编写的程序，整个代码都需要进行编译。 因此，不能说使用Java语言编写的程序占用的内存就会比使用C/C++编写的程序大。这决定于软件相对于平台代码的复杂度及大小。如果软件规模比较 大，Java平台所消耗的内存远小于Java类文件简洁性节约的内存，这种情况下，使用Java平台将有利于节约内存。如果软件的规模比较小，则Java 平台消耗的内存就比较明显了，可以考虑使用C/C++来开发，以节约内存。
