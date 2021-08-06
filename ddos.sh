# 根据 netstat -antulp 的ip连接数自动生成firewall规则
echo ------------------------------------------------------
netstat -ant  awk '{print $5}' | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]' | sort | uniq -c | sort -n | tail -10
echo ------------------------------------------------------

# 本机ip
self_ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
# 系统默认IP
default_white_ip_list=('0.0.0.0' '127.0.0.1' 'localhost' $self_ip)
# 自定义白名单
custom_white_ip_list=('119.28.131.173')
# 合并后的白名单
white_ip_list=(${default_white_ip_list[@]} ${custom_white_ip_list[@]})

# 查找前10个最多连接的ip
iplist=`netstat -ant  awk '{print $5}' | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]' | sort | uniq -c | sort -n | tail -10 | awk '{print $2}'`


echo "复制前请检查IP地址, 避免冲突"
echo

for ip in $iplist
do
	if [[ ! "${white_ip_list[@]}" =~ "${ip}" ]]; then
		echo "firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address="$ip" drop'"
	fi
done

echo
echo "firewall-cmd --reload"

echo ------------------------------------------------------
