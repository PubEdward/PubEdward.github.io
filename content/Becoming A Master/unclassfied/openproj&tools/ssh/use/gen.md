1.一般我们常用如下命令来生成ssh公匙和私匙。

ssh-keygen  -t dsa –C user.email –f  ~/.ssh/user.email

1> -t dsa 采用das加密方式的公匙/私匙对，初了das还有ras方式。

2>-C user.email 对这个公匙/私匙对的一个注释和说明，一般用个人邮件代替。

3> -f 指定key file的文件名和路径。

如果没有特别说明，公匙/私匙对会存放在.ssh目录下

---

```
Host github.com
    User git
    IdentityFile ~/.ssh/github_rsa

Host code.csdn.net
    User git
    IdentityFile ~/.ssh/id_rsa
```
    

---

解决本地多个ssh key问题

有的时候，不仅github使用ssh key，工作项目或者其他云平台可能也需要使用ssh key来认证，如果每次都覆盖了原来的id_rsa文件，那么之前的认证就会失效。这个问题我们可以通过在~/.ssh目录下增加config文件来解决。

下面以配置搜狐云平台的ssh key为例。
1. 第一步依然是配置git用户名和邮箱

git config user.name "用户名"
git config user.email "邮箱"

2. 生成ssh key时同时指定保存的文件名

ssh-keygen -t rsa -f ~/.ssh/id_rsa.sohu -C "email"

上面的id_rsa.sohu就是我们指定的文件名，这时~/.ssh目录下会多出id_rsa.sohu和id_rsa.sohu.pub两个文件，id_rsa.sohu.pub里保存的就是我们要使用的key。
3. 新增并配置config文件
添加config文件

如果config文件不存在，先添加；存在则直接修改

touch ~/.ssh/config

在config文件里添加如下内容(User表示你的用户名)

Host *.cloudscape.sohu.com
    IdentityFile ~/.ssh/id_rsa.sohu
    User test
