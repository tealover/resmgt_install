GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE mysql.user SET Password=PASSWORD('90io()IO') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;

CREATE database `c2cloud-res` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER `c2cloud_res`@'%' IDENTIFIED BY '90io()IO';
GRANT ALL PRIVILEGES ON `c2cloud-res`.* TO `c2cloud_res`;
FLUSH PRIVILEGES;

use `c2cloud-res`;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for td_c2_file_metadata
-- ----------------------------
DROP TABLE IF EXISTS `td_c2_file_metadata`;
CREATE TABLE `td_c2_file_metadata` (
  `id_` char(22) NOT NULL,
  `visit_count` int(11) DEFAULT NULL,
  `fileid` char(22) NOT NULL,
  `name` varchar(256) NOT NULL,
  `mimetype` varchar(128) NOT NULL,
  `filesize` double(30,0) NOT NULL,
  `digest` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for td_mc_menu
-- ----------------------------
DROP TABLE IF EXISTS `td_mc_menu`;
CREATE TABLE `td_mc_menu` (
  `ID` char(22) NOT NULL,
  `SERIAL` int(11) DEFAULT NULL,
  `PARENTID` char(22) DEFAULT NULL,
  `NAME` varchar(64) DEFAULT NULL,
  `HREF` varchar(512) DEFAULT NULL,
  `CREATED_BY` varchar(64) NOT NULL COMMENT '创建者',
  `CREATED_AT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `UPDATED_BY` varchar(64) DEFAULT NULL COMMENT '更新者',
  `UPDATED_AT` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `ICON` varchar(22) DEFAULT NULL,
  `ISMENU` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_6` (`PARENTID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for td_mc_role
-- ----------------------------
DROP TABLE IF EXISTS `td_mc_role`;
CREATE TABLE `td_mc_role` (
  `ID` char(22) NOT NULL,
  `NAME` varchar(64) DEFAULT NULL,
  `CODE` varchar(64) DEFAULT NULL,
  `Flag` char(1) DEFAULT '0',
  `CREATED_BY` varchar(64) NOT NULL COMMENT '创建者',
  `CREATED_AT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `UPDATED_BY` varchar(64) DEFAULT NULL COMMENT '更新者',
  `UPDATED_AT` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for td_mc_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `td_mc_role_menu`;
CREATE TABLE `td_mc_role_menu` (
  `ROLE_ID` char(22) NOT NULL,
  `MENU_ID` char(22) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`MENU_ID`),
  KEY `FK_Reference_5` (`MENU_ID`) USING BTREE,
  CONSTRAINT `td_mc_role_menu_ibfk_1` FOREIGN KEY (`ROLE_ID`) REFERENCES `td_mc_role` (`ID`),
  CONSTRAINT `td_mc_role_menu_ibfk_2` FOREIGN KEY (`MENU_ID`) REFERENCES `td_mc_menu` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for td_mc_user_role
-- ----------------------------
DROP TABLE IF EXISTS `td_mc_user_role`;
CREATE TABLE `td_mc_user_role` (
  `ID` varchar(50) NOT NULL,
  `USERID` varchar(50) DEFAULT NULL COMMENT '用户id',
  `ROLEID` varchar(22) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_54` (`ROLEID`) USING BTREE,
  KEY `FK_Reference_55` (`USERID`) USING BTREE,
  CONSTRAINT `td_mc_user_role_ibfk_1` FOREIGN KEY (`ROLEID`) REFERENCES `td_mc_role` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关联表; InnoDB free: 4096 kB; (`ROLEID`) REFE';

-- ----------------------------
-- Table structure for td_res_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `td_res_sys_log`;
CREATE TABLE `td_res_sys_log` (
  `id` varchar(22) NOT NULL COMMENT '主键',
  `log_type` varchar(100) NOT NULL COMMENT '类型',
  `log_level` int(11) NOT NULL COMMENT '级别',
  `log_title` varchar(200) NOT NULL COMMENT '标题',
  `log_content` text COMMENT '内容',
  `oper_time` datetime NOT NULL COMMENT '时间',
  `oper_user_id` varchar(22) NOT NULL COMMENT '用户id',
  `oper_user_name` varchar(100) NOT NULL COMMENT '用户名',
  `oper_ip` varchar(15) DEFAULT NULL COMMENT '操作IP',
  `oper_status` int(11) NOT NULL COMMENT '结果',
  `oper_error_cause` varchar(200) DEFAULT NULL COMMENT '失败原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志';

-- ----------------------------
-- Table structure for td_res_sys_task
-- ----------------------------
DROP TABLE IF EXISTS `td_res_sys_task`;
CREATE TABLE `td_res_sys_task` (
  `id` varchar(22) NOT NULL COMMENT '主键',
  `task_res_id` varchar(100) NOT NULL COMMENT '任务资源ID',
  `task_type` varchar(100) NOT NULL COMMENT '任务类型',
  `target_name` varchar(500) NOT NULL COMMENT '对象名称',
  `target_url` varchar(500) DEFAULT NULL COMMENT '对象路径',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `task_status` int(11) NOT NULL COMMENT '状态',
  `task_description` varchar(3000) DEFAULT NULL COMMENT '任务描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务管理';

-- ----------------------------
-- Table structure for td_sys_organization
-- ----------------------------
DROP TABLE IF EXISTS `td_sys_organization`;
CREATE TABLE `td_sys_organization` (
  `orgid` varchar(50) NOT NULL COMMENT '机构ID',
  `orgsn` decimal(10,0) DEFAULT '999' COMMENT '机构排序ID',
  `orgname` varchar(40) NOT NULL COMMENT '机构名称',
  `orgshowname` varchar(100) NOT NULL COMMENT '机构显示名称',
  `parentid` varchar(100) NOT NULL COMMENT '父机构ID',
  `path` varchar(1000) DEFAULT NULL COMMENT '路径',
  `layer` varchar(200) DEFAULT NULL COMMENT '层（阶次）',
  `children` varchar(1000) DEFAULT NULL COMMENT '子机构',
  `code` varchar(100) DEFAULT NULL COMMENT '机构代号',
  `jp` varchar(40) DEFAULT NULL COMMENT '简拼',
  `qp` varchar(40) DEFAULT NULL COMMENT '全拼',
  `creatingtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(100) DEFAULT '1' COMMENT '创建人',
  `orgnumber` varchar(100) DEFAULT NULL COMMENT '机构编号',
  `orgdesc` varchar(300) DEFAULT NULL COMMENT '机构描述',
  `chargeorgid` varchar(50) DEFAULT NULL COMMENT '主管机构',
  `orglevel` varchar(1) DEFAULT '1' COMMENT '机构行政级别，1：省级，2：市州级，3：县区级，4：科所级',
  `orgxzqm` varchar(12) DEFAULT NULL COMMENT '行政区码',
  `isdirectlyparty` varchar(1) DEFAULT '0' COMMENT '是否直属局 0-不是，缺省值 1-是',
  `isforeignparty` varchar(1) DEFAULT '0' COMMENT '是否涉外局 0-不是，缺省值 1-是',
  `isjichaparty` varchar(1) DEFAULT '0' COMMENT '是否稽查局 0-不是，缺省值 1-是',
  `isdirectguanhu` varchar(1) DEFAULT '0' COMMENT '是否直接管户单位 0-不是，缺省值 1-是',
  `remark1` varchar(100) DEFAULT NULL COMMENT '备用字段1',
  `remark2` varchar(100) DEFAULT NULL COMMENT '备用字段2',
  `remark3` varchar(100) DEFAULT NULL COMMENT '备用字段3',
  `remark4` varchar(100) DEFAULT NULL COMMENT '备用字段4',
  `remark5` varchar(100) DEFAULT NULL COMMENT '备用字段5',
  `remark6` varchar(100) DEFAULT NULL COMMENT '备用字段6',
  `remark7` varchar(100) DEFAULT NULL COMMENT '备用字段7',
  `remark8` varchar(100) DEFAULT NULL COMMENT '备用字段8',
  `remark9` varchar(100) DEFAULT NULL COMMENT '备用字段9',
  `remark10` varchar(100) DEFAULT NULL COMMENT '备用字段10',
  `istenant` varchar(1) DEFAULT NULL COMMENT '是否租户 缺省值0-不是， 1-是',
  PRIMARY KEY (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构信息表';

-- ----------------------------
-- Table structure for td_sys_orguser
-- ----------------------------
DROP TABLE IF EXISTS `td_sys_orguser`;
CREATE TABLE `td_sys_orguser` (
  `id` varchar(50) NOT NULL COMMENT '用户实例ID',
  `userid` varchar(50) NOT NULL COMMENT '用户ID',
  `orgid` varchar(50) DEFAULT NULL COMMENT '活动范围ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构用户关联表';

-- ----------------------------
-- Table structure for td_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `td_sys_user`;
CREATE TABLE `td_sys_user` (
  `userid` varchar(50) NOT NULL COMMENT '用户ID',
  `username` varchar(200) NOT NULL COMMENT '用户帐号',
  `userpassword` varchar(128) NOT NULL COMMENT '用户密码',
  `userrealname` varchar(100) DEFAULT NULL COMMENT '用户实名',
  `userpinyin` varchar(100) DEFAULT NULL COMMENT '拼音',
  `usersex` varchar(100) DEFAULT NULL COMMENT '性别',
  `userhometel` varchar(100) DEFAULT NULL COMMENT '家庭电话',
  `userworktel` varchar(100) DEFAULT NULL COMMENT '公司电话',
  `userworkaddress` varchar(100) DEFAULT NULL COMMENT '公司地址',
  `usermobiletel1` varchar(100) DEFAULT NULL COMMENT '手机1',
  `usermobiletel2` varchar(100) DEFAULT NULL COMMENT '手机2',
  `userfax` varchar(100) DEFAULT NULL COMMENT '传真',
  `useroicq` varchar(100) DEFAULT NULL COMMENT 'OICQ',
  `userregdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册日期',
  `userbirthday` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '生日',
  `useremail` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `useraddress` varchar(200) DEFAULT NULL COMMENT '住址',
  `userpostalcode` varchar(10) DEFAULT NULL COMMENT '邮编',
  `useridcard` varchar(50) DEFAULT NULL COMMENT '身份证',
  `userisvalid` decimal(10,0) DEFAULT NULL COMMENT '是否使用',
  `userlogincount` decimal(10,0) DEFAULT NULL COMMENT '登陆次数',
  `usertype` varchar(100) DEFAULT NULL COMMENT '用户类型',
  `pasttime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '过期时间',
  `dredgetime` varchar(50) DEFAULT NULL COMMENT '开通时间',
  `lastlogindate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '用户最后登录时间',
  `worklength` varchar(50) DEFAULT NULL COMMENT '工作年限',
  `politics` varchar(100) DEFAULT NULL COMMENT '政治面貌',
  `loginip` varchar(15) DEFAULT NULL COMMENT '登录IP',
  `certsn` varchar(50) DEFAULT NULL COMMENT '证书key的唯一标识',
  `usersn` decimal(10,0) DEFAULT '999' COMMENT '用户排序号',
  `remark1` varchar(100) DEFAULT NULL COMMENT '备用字段1',
  `remark2` varchar(100) DEFAULT NULL COMMENT '备用字段2',
  `remark3` varchar(100) DEFAULT NULL COMMENT '备用字段3',
  `remark4` varchar(100) DEFAULT NULL COMMENT '备用字段4',
  `remark5` varchar(100) DEFAULT NULL COMMENT '备用字段5',
  `remark6` varchar(100) DEFAULT NULL COMMENT '备用字段6',
  `remark7` varchar(100) DEFAULT NULL COMMENT '备用字段7',
  `remark8` varchar(100) DEFAULT NULL COMMENT '备用字段8',
  `remark9` varchar(100) DEFAULT NULL COMMENT '备用字段9',
  `remark10` varchar(100) DEFAULT NULL COMMENT '备用字段10',
  `isadmin` decimal(1,0) DEFAULT NULL COMMENT '是否管理员 缺省值0-不是， 1-是',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';




-- ----------------------------
-- Records of td_mc_role
-- ----------------------------
INSERT INTO `td_mc_role` VALUES ('2', '资源管理员', 'resource_managers', '2', 'c2', '2015-06-09 09:47:35', null, '0000-00-00 00:00:00');


-- ----------------------------
-- Records of td_mc_menu
-- ----------------------------
INSERT INTO `td_mc_menu` VALUES ('3hT6Ve9ZT4O1QUV2by7mmQ', '0', '3WkMOcSXQpSoaJwdgYDEpQ', '主机与集群', '#/f/environments_cluster', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('3NGxAlYaTyy0l0qRfExZzQ', '1', 'R-9DXCDfSkeHeOq_QltE4g', '网络', '#/f/project_network_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('3sHFNVrYSyeZH0k50CbBoQ', '3', 'xqr1c7t0Q9OJjz7o0fo_aQ', '存储资源', '#/f/project_volume_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', 'fa-database', '1');
INSERT INTO `td_mc_menu` VALUES ('3WkMOcSXQpSoaJwdgYDEpQ', '4', 'xqr1c7t0Q9OJjz7o0fo_aQ', '基础环境', '#/f/environments_cluster', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', 'fa-bank', '1');
INSERT INTO `td_mc_menu` VALUES ('7deeulH9RfSbQ7RRNA_yvg', '9', 'xqr1c7t0Q9OJjz7o0fo_aQ', '操作日志', '#/f/log_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', 'fa-info-circle', '1');
INSERT INTO `td_mc_menu` VALUES ('H_4wyd5XSnSlctL-iLWU8A', '3', 'yn9MeYcESEK3xwJkCi_ecw', '机构用户管理', '#/f/orguser_list', 'admin', '2015-06-18 18:39:29', null, '2014-09-12 10:25:11', 'fa-group', '1');
INSERT INTO `td_mc_menu` VALUES ('khjWn0kvQie9w3KIzuB3gA', '8', 'obveLsd0SRW8sTn_nqzSfA', '云硬盘', '#/f/admin_volume_list', 'admin', '2015-06-18 18:40:11', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('LuWlwTOKQY6Cv25zwj066g', '2', 'obveLsd0SRW8sTn_nqzSfA', '云主机', '#/f/admin_instance_list', 'admin', '2015-06-18 18:40:13', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('Mj7t2HRxSBeLjv1SFDJIDw', '8', 'xqr1c7t0Q9OJjz7o0fo_aQ', '任务中心', '#/f/res_task_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', 'fa-tasks', '1');
INSERT INTO `td_mc_menu` VALUES ('obveLsd0SRW8sTn_nqzSfA', '7', 'xqr1c7t0Q9OJjz7o0fo_aQ', '资源设置', '#/f/flavor_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', 'fa-cogs', '1');
INSERT INTO `td_mc_menu` VALUES ('P9zeO802RfyHr_eTr8teFw', '5', 'xqr1c7t0Q9OJjz7o0fo_aQ', '系统设置', '#/f/orguser_list', 'c2', '2014-09-12 15:11:58', null, '2014-09-12 10:25:11', 'fa-gear', '0');
INSERT INTO `td_mc_menu` VALUES ('PdkZbwH5RZyrvIdBbX_kWA', '1', 'obveLsd0SRW8sTn_nqzSfA', '云主机配置', '#/f/flavor_list', 'admin', '2015-06-18 18:40:14', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('pIvJAHbwT6yj6LaH-NlqlA', '6', 'yn9MeYcESEK3xwJkCi_ecw', '角色权限', '#/f/role_list', 'c2', '2015-06-18 18:39:30', null, '2014-09-12 10:25:11', 'fa-compass', '1');
INSERT INTO `td_mc_menu` VALUES ('R-9DXCDfSkeHeOq_QltE4g', '2', 'xqr1c7t0Q9OJjz7o0fo_aQ', '网络资源', '#/f/project_network_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', 'fa-chain', '1');
INSERT INTO `td_mc_menu` VALUES ('RJ5RyiBnSHqZ7scd0w-8Kg', '1', '3WkMOcSXQpSoaJwdgYDEpQ', '数据存储', '#/f/environments_datastore', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('RlyBPzjYQP-0tb0C542HYg', null, 'pIvJAHbwT6yj6LaH-NlqlA', '分配菜单', '#/f/assign_menu', 'admin', '2014-09-12 15:12:00', null, '2014-09-12 10:25:11', '', '0');
INSERT INTO `td_mc_menu` VALUES ('s3KZvOnLSHW4AlMwH9lP8w', '0', 'R-9DXCDfSkeHeOq_QltE4g', '拓扑', '#/f/topologys', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('sLkamQmbSYetrT-VGp6Cyg', '1', 'vuNf8ZUhQWqnrXz_z1DnqQ', '云主机', '#/f/project_instance_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('sQ3kZtvsT1---6WTq8WonA', '2', 'P9zeO802RfyHr_eTr8teFw', '资源', '#/f/flavor_list', 'admin', '2014-09-12 15:11:58', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('vCcWFqieTB-FP9tqEt8ErA', '2', 'vuNf8ZUhQWqnrXz_z1DnqQ', '镜像', '#/f/project_image_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('vJLsq-KXQ5qlt_UadsQUrA', '0', 'obveLsd0SRW8sTn_nqzSfA', '云主机管理器', '#/f/admin_hypervisors_list', 'admin', '2015-06-18 18:40:16', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('Vop_CWTJRdqI6CqC3lALOQ', '6', 'obveLsd0SRW8sTn_nqzSfA', '网络', '#/f/admin_network_list', 'admin', '2015-06-18 18:40:17', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('vuNf8ZUhQWqnrXz_z1DnqQ', '1', 'xqr1c7t0Q9OJjz7o0fo_aQ', '计算资源', '#/f/project_instance_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', 'fa-desktop', '1');
INSERT INTO `td_mc_menu` VALUES ('xqr1c7t0Q9OJjz7o0fo_aQ', null, '0', '菜单', null, 'ly', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('XVZHHpdFQ9qEOX649CQe9A', '7', 'yn9MeYcESEK3xwJkCi_ecw', '菜单管理', '#/f/menu_list', 'admin', '2015-06-18 18:39:35', null, '2014-09-12 10:25:11', 'fa-bars', '1');
INSERT INTO `td_mc_menu` VALUES ('Y7OWczUDQu2wsYKuArcVBQ', '1', 'P9zeO802RfyHr_eTr8teFw', '权限', '#/f/orguser_list', 'admin', '2014-09-12 15:11:58', null, '2014-09-12 10:25:11', 'fa-users', '1');
INSERT INTO `td_mc_menu` VALUES ('yn9MeYcESEK3xwJkCi_ecw', '6', 'xqr1c7t0Q9OJjz7o0fo_aQ', '权限设置', '#/f/orguser_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', 'fa-users', '1');
INSERT INTO `td_mc_menu` VALUES ('Z1-9MmI1TOqTb0-sneBTjA', '7', 'obveLsd0SRW8sTn_nqzSfA', '浮动IP', '#/f/admin_floatIp_list', 'admin', '2015-06-18 18:40:19', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('ZcGQqpAKQw26LLbrKoE8TQ', '3', 'obveLsd0SRW8sTn_nqzSfA', '镜像', '#/f/admin_image_list', 'admin', '2015-06-18 18:40:21', null, '2014-09-12 10:25:11', null, '1');
INSERT INTO `td_mc_menu` VALUES ('zKMppyxcRve00Nlsozc6-g', '2', 'R-9DXCDfSkeHeOq_QltE4g', '浮动IP', '#/f/project_floatIp_list', 'admin', '2014-09-15 11:08:59', null, '2014-09-12 10:25:11', null, '1');


-- ----------------------------
-- Records of td_mc_role_menu
-- ----------------------------
INSERT INTO `td_mc_role_menu` VALUES ('2', '3NGxAlYaTyy0l0qRfExZzQ');
INSERT INTO `td_mc_role_menu` VALUES ('2', '3sHFNVrYSyeZH0k50CbBoQ');
INSERT INTO `td_mc_role_menu` VALUES ('2', 'R-9DXCDfSkeHeOq_QltE4g');
INSERT INTO `td_mc_role_menu` VALUES ('2', 's3KZvOnLSHW4AlMwH9lP8w');
INSERT INTO `td_mc_role_menu` VALUES ('2', 'sLkamQmbSYetrT-VGp6Cyg');
INSERT INTO `td_mc_role_menu` VALUES ('2', 'vCcWFqieTB-FP9tqEt8ErA');
INSERT INTO `td_mc_role_menu` VALUES ('2', 'vuNf8ZUhQWqnrXz_z1DnqQ');
INSERT INTO `td_mc_role_menu` VALUES ('2', 'xqr1c7t0Q9OJjz7o0fo_aQ');
INSERT INTO `td_mc_role_menu` VALUES ('2', 'zKMppyxcRve00Nlsozc6-g');