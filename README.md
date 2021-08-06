# ddos
auto generate firewall rules by 'netstat -antulp'


#how to use 
```sh
[root@VM_77_147_centos ~]# sh ddos.sh 
------------------------------------------------------
      1 162.0.208.1
      1 36.99.136.1
      1 61.135.15.1
      1 66.249.68.1
      2 113.116.74.1
      2 120.41.45.1
      6 0.0.0.0
     14 10.144.77.1
     42 127.0.0.1
------------------------------------------------------
复制前请检查IP地址, 避免冲突

firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=162.0.208.1 drop'
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=36.99.136.1 drop'
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=61.135.15.1 drop'
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=66.249.68.1 drop'
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=113.116.74.1 drop'
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=120.41.45.1 drop'

firewall-cmd --reload
------------------------------------------------------
```
