#!/bin/sh
yumdownloader unzip --resolve --destdir=deps
yumdownloader java --resolve --destdir=deps

rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yumdownloader mysql-community-server --resolve --destdir=deps

wget ftp://rpmfind.net/linux/fedora/linux/development/rawhide/x86_64/os/Packages/t/tomcat-8.0.23-2.fc23.noarch.rpm -O ./deps/tomcat-8.0.23-2.noarch.rpm

