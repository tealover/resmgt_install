#!/bin/bash
MYSQL_HOSTNAME=172.16.71.248
MYSQL_PORT=3306
MYSQL_DATABASE=c2cloud-res
MYSQL_USERNAME=c2cloud_res
MYSQL_PASSWORD="90io()IO"

OPENSTACK_ENDPOINT=http://172.16.71.205:5000/v2.0
OPENSTACK_VNC=http://172.16.71.205:6080
VCENTER_ADDRESS=172.16.71.201
VCENTER_USERNAME=root
VCENTER_PASSWORD=vmware

export CATALINA_HOME=/opt/apache-tomcat-8.0.15

dt=`date '+%Y%m%d-%H%M%S'`
logfile="install_$dt.log"

c2_config_file="/opt/apache-tomcat-8.0.15/webapps/c2cloud-res/WEB-INF/classes/c2-config.properties"
xmlfile="/opt/apache-tomcat-8.0.15/webapps/c2cloud-res/WEB-INF/c2/conf/datasource.xml"
url="jdbc:mysql:\\/\\/"$MYSQL_HOSTNAME":"$MYSQL_PORT"\\/"$MYSQL_DATABASE"?useUnicode=true\&amp;characterEncoding=UTF-8\&amp;zeroDateTimeBehavior=convertToNull"



function add_hostname() {
    localip=`ifconfig | grep -v 127.0.0.1 | grep inet | grep -v inet6 | awk '{print $2}' | sed 's/addr://'`
    hostname=`hostname`
    sed -i "/.* $hostname/d" /etc/hosts
    echo "$localip $hostname" >> /etc/hosts
}

function pre_install() {
    yum install -y net-tools | tee -a $logfile 
    yum install -y unzip | tee -a $logfile
    add_hostname
}

function modify_configfile() {
    sed -i "s#^$1=.*#$1=$2#" $c2_config_file
}

function modify_xml() {
   sed -i 's/<'"$1"\>'.*</<'"$1"'\>'"$2"'</g' $xmlfile
}

function install_mysql() {
    echo "bengin to install mysql..."
    yum -y install mysql-community-server | tee -a $logfile
    
    echo "end to install mysql..."
}

function install_tomcat() {
    echo "bengin to install tomcat..."
    tar -zxf ./resmgt/apache-tomcat-8.0.15.tar.gz -C /opt | tee -a $logfile
    echo "end to install mysql..."
}

function install_java() {
    echo "bengin to install java1.7 ..."
    yum install -y java| tee -a $logfile
    echo "end to install java1.7 ..."
}

function install_resmgt() {
    unzip ./resmgt/c2-cloud-resource-console-2.1.0-SNAPSHOT.war -d /opt/apache-tomcat-8.0.15/webapps/c2cloud-res
    modify_configfile "c2.cloud.res.openstack.identity.endpoint" $OPENSTACK_ENDPOINT
    modify_configfile "c2.cloud.res.openstack.identity.vnc" $OPENSTACK_VNC
    modify_configfile "c2.cloud.res.vmware.vim25.vCenterAddress" $VCENTER_ADDRESS
    modify_configfile "c2.cloud.res.vmware.vim25.vCenterUserName" $VCENTER_USERNAME
    modify_configfile "c2.cloud.res.vmware.vim25.vCenterPassword" $VCENTER_PASSWORD
    
    modify_xml password $MYSQL_PASSWORD
    modify_xml username $MYSQL_USERNAME
    modify_xml url "$url"
}

function init_mysql() {
    cp -f ./resmgt/config/my.cnf /etc/
    cp -f ./resmgt/config/c2cloud-res-initdb.sql /etc
}

# Modify openstack configurations
function post_install() {
    echo "finished to install c2cloud resource mananger platform..."
    echo "start mysqld server..."
    systemctl enable mysqld
    service mysqld start
    
    sh $CATALINA_HOME/bin/startup.sh
    
}

pre_install
install_java
install_mysql
install_tomcat
install_resmgt
init_mysql
post_install