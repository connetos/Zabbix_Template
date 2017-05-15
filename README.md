
# Zabbix监控交换机

Zabbix是一个企业级的、开源的、分布式的监控套件。可以实时监控交换机的系统、网络和服务状况。在Zabbix Server上导入云启提供的监控模板和shell脚本后可以监控ConnetOS交换机。

###一、Zabbix Server配置


####1. 导入监控模板

通过Web浏览器登录Zabbix的控制平台，进入导入模板的界面，Configuration->Templates->Import。

选中本地的模板文件ConnetOS\_Zabbix\_Template.xml，点击Import。

设置SNMP Community宏，Administration->General->Macros此处的配置要与交换机中的community保持一样。

####2. 导入监控脚本

Zabbix需要外部shell脚本实现对交换机内存的监控，登录安装Zabbix Server的服务器，进入Zabbix执行外部脚本的目录/usr/lib/zabbix/externalscripts，该目录可以通过Zabbix Server的配置文件zabbix\_server.conf找到。

将附件中的ConnetOS\_Zabbix\_Script.sh复制到usr/lib/zabbix/externalscripts/中，并更改权限为777.

```
$ sudo cp ConnetOS_Zabbix_Script.sh /usr/lib/zabbix/externalscripts/
$ sudo chmod 777 /usr/lib/zabbix/externalscripts/ConnetOS_Zabbix_Script.sh
```


####3. 创建Hosts
打开创建主机界面，Configuration->Hosts->Create host。
1） Host name 主机名称，最好与交换机名称一致，可再带上交换机的IP。
2） Group 选择交换机所属的群组Switch。
3） Agent interfaces 填写交换机的IP。
4） SNMP interfaces 填写交换机的IP。5） 选择Host选择旁边的Templates选项为主机选择所属的模板。6） 点击Select进入到模板选择界面。7） Group 这里选择之前建立的Switch Templates。
8） 选择主机所属的模板，点击Select返回Host的Templates界面。9） 再次执行第6步的操作添加Linux模板，这次选择Templates的Group。选择Template OS Linux的模板之后点击Select。10） 点击Add，确定增加这个模板给到这个Host，这一步很重要。11） 确定Linked templates里面有我们刚才选择的模板之后，点击Add，创建完成。 创建完成后主机会自动建立模板中创建好的Item。Availablity这一栏中的SNMP是绿色的，表示通过SNMP监控成功，不成功则为红色。


###二、ConnetOS交换机配置


登录C1020交换机，进入CLI之后做如下配置：```ConnetOS>ConnetOS> configureConnetOS# set protocols snmp community publicConnetOS# commit
```
这样就开启了SNMP功能。


##三、 Zabbix监控交换机安装前面的步骤连接好交换机之后，Zabbix Server通过Zabbix Agent和SNMP获取到交换机的系统和网络流量状况。可以通过Zabbix提供的绘图工具实时展示网络负载状况，可以设置告警阈值进行告警，可以通过邮件或弹窗等多种方式提供告警信息。
查看采集项的最新数据，Monitoring-> Latest data。
查看采集项的绘图，Monitoring-> Graphs。


