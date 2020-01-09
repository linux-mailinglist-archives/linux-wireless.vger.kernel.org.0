Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3A1359F2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 14:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgAINSv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 08:18:51 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:62328 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730916AbgAINSv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 08:18:51 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009DBsdC028958
        for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2020 06:18:50 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xarvjwv1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 06:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1HWQGmBh/omsCWA8AyRYab+p+5JMijlj3HcJaoiUeZaVOCAo4Aj0017CIWZ2xOeiUJxgM1GwoxwyGfuFJFlVHdruqzB9PiHCvWvxumTPYEaxU+2y2ClWpEbjMMDrVpzyX2k47/+/GENRmWqq89YVDOPHcFl3smLnMHlaOykG3pVojckqkBXY1Z0DkVvsxce7fQ+u4A8vKMINSPC1MUWQj7hbESSS6EqjyhgjEm9RGsQd5npiZ4a3Q3ym5O945s3BE+D+p6GGVYiCfojGKigUqb2LhQqC1sy5yUQq+JIxrL8GuPdwsZGpPXEmL5/A2zvB5BpZs87FFeLirvyda2Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FxAFLoJ6hwH7o9cn1/VHDMXcHffe+D+qoEELideN7o=;
 b=LNiiZ77D4Yw7+qNLux12j1i1IVHjrK/h+lRMk8QxhPsqEB8EGOoddRVgfg7xySZxhF/RIsLz33C569iaiLXb4lciCWDdcAIDDK4Dwc8CUMWBaIQ7ZvvlsWaXv8KRO6p+kFiUoqb5eSVSijDOBbybS5qgX4X3xUUIWJPDJhpin3+uF8gNvFptxTw/K6hogjYJBwYBxu3M3tf/v4q2nv6nNdsyd2wjvTMSvyAybFch4aKYHQbRMDiEt2gLnLYr7x6uBezq+8z9b3DQq5Zok4GkrXtw82lcZDjoogCs+LeZ7vwl7W64wPwoUMX3T5928cVYM3xR/wjOee9iMhyXA9Wkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FxAFLoJ6hwH7o9cn1/VHDMXcHffe+D+qoEELideN7o=;
 b=GsaIcsIpvWNrss3/mf1cyLM8ySJu9ZZjYVX6uIBmtfoCNMaf3fHW1UShE0jgkYgWwC5PMXHZnLXKZ0sAqgiJhZ3kvwlypEXvVTvpUya36oXJOgh+3QlCrSF/0/Y03cSzl8KqLBTIVPJ80oAKekjR7wmIb1Cv/CazLJv8Yf4nZjU=
Received: from SN6PR05MB5519.namprd05.prod.outlook.com (52.135.108.218) by
 SN6PR05MB4861.namprd05.prod.outlook.com (52.135.115.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Thu, 9 Jan 2020 13:18:48 +0000
Received: from SN6PR05MB5519.namprd05.prod.outlook.com
 ([fe80::550c:3a2f:f56:2d3e]) by SN6PR05MB5519.namprd05.prod.outlook.com
 ([fe80::550c:3a2f:f56:2d3e%7]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 13:18:47 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4637.namprd05.prod.outlook.com (52.135.114.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Thu, 9 Jan 2020 13:18:08 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 13:18:08 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 2/5] qtnfmac: add module param to configure DFS offload
Date:   Thu,  9 Jan 2020 16:17:52 +0300
Message-ID: <20200109131755.7729-3-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
References: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0901CA0053.eurprd09.prod.outlook.com
 (2603:10a6:3:45::21) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0901CA0053.eurprd09.prod.outlook.com (2603:10a6:3:45::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 13:18:07 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48b15745-1769-4268-d139-08d795065ea2
X-MS-TrafficTypeDiagnostic: SN6PR05MB4637:|SN6PR05MB4861:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR05MB4637260C22D73B4A6A5CCC7BA3390@SN6PR05MB4637.namprd05.prod.outlook.com>
X-Moderation-Data: 1/9/2020 1:18:43 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39850400004)(396003)(376002)(346002)(189003)(199004)(956004)(2616005)(36756003)(26005)(86362001)(52116002)(186003)(6486002)(16526019)(7696005)(6916009)(4326008)(66556008)(1076003)(478600001)(66946007)(66476007)(2906002)(107886003)(5660300002)(8936002)(316002)(8676002)(81166006)(81156014)(103116003)(54906003)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4861;H:SN6PR05MB5519.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8DUqmhxnwgbW8DbI80LZvhOswot9S7EOWi7hCxXPfVmPg3rvm5nxkwxY8xrjBiaIqYr1MLt77m8LlaAAvi4DuVHk7hbuzDFqHwv4pI1QeR8y3nB/LAqBw4RVMlgBcLWnJhFypKLwZ5UmYNR4CV60rf3DlgOm1+lavCN4ZG0QSfRa0Fbp31encA9z1Q8JihtCIZJylpUpv8BtlIgrUj+CSNMVfmbjMPTZguYZS+7YpYoAXeWuQ3uOewiVwlTTu3NRDOg26o/P94SHLBiA81WNGO/nsvmjdsZalYaa4GNuUYCgKHTQlyv9CLnsBff6HviiaWWmM80T+QiR3uQZESuNkmYwwQe/bNnGALfdzizGk2QmMGaViAWeJwL5EflDNNWeO2nexpOCCoLTjZrcQh51fF4/vQ69YUR1CzTLKXcB6rDmGXDvTRbQFi4tkfpC3rF
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b15745-1769-4268-d139-08d795065ea2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bhcV5uMfoVhdbnSX73R2JQWz47u0Ba4xbp+ssZGZE2LLgMcTUl1+HYwbPdZi8rvs5VkSgiEajM/qTspix353tfrrdNhp3GZs/yqrQr2EKRxF51x78QsTFy/taY/8Olz9TjVqmOKh4h1p8HRZBh6Svn1fbaurs6TmXjNUBxGoJ4nid44/P13acLnzG7O6RWqWA0bJxD6s89B3kOW2+dkoA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 13:18:47.8158
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4861
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=3
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090117
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware may support DFS offload. However the final decision on whether
to use it or not should be up to the user. So even if firmware supports
DFS offload, it should be enabled only if user explicitly requests it.
For this purpose introduce kernel param dfs_offload which is disabled
by default.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c | 9 ++++++---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 3 ++-
 drivers/net/wireless/quantenna/qtnfmac/commands.h | 2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c     | 9 +++++++++
 drivers/net/wireless/quantenna/qtnfmac/core.h     | 1 +
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 5 +++--
 6 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 25a9b512b8ce..8849faa5bc10 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -1056,7 +1056,8 @@ static void qtnf_cfg80211_reg_notifier(struct wiphy *wiphy,
 	pr_debug("MAC%u: initiator=%d alpha=%c%c\n", mac->macid, req->initiator,
 		 req->alpha2[0], req->alpha2[1]);
 
-	ret = qtnf_cmd_reg_notify(mac, req, qtnf_slave_radar_get());
+	ret = qtnf_cmd_reg_notify(mac, req, qtnf_slave_radar_get(),
+				  qtnf_dfs_offload_get());
 	if (ret) {
 		pr_err("MAC%u: failed to update region to %c%c: %d\n",
 		       mac->macid, req->alpha2[0], req->alpha2[1], ret);
@@ -1078,7 +1079,8 @@ struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *bus)
 {
 	struct wiphy *wiphy;
 
-	if (bus->hw_info.hw_capab & QLINK_HW_CAPAB_DFS_OFFLOAD)
+	if (qtnf_dfs_offload_get() &&
+	    (bus->hw_info.hw_capab & QLINK_HW_CAPAB_DFS_OFFLOAD))
 		qtn_cfg80211_ops.start_radar_detection = NULL;
 
 	if (!(bus->hw_info.hw_capab & QLINK_HW_CAPAB_PWR_MGMT))
@@ -1163,7 +1165,8 @@ int qtnf_wiphy_register(struct qtnf_hw_info *hw_info, struct qtnf_wmac *mac)
 			WIPHY_FLAG_NETNS_OK;
 	wiphy->flags &= ~WIPHY_FLAG_PS_ON_BY_DEFAULT;
 
-	if (hw_info->hw_capab & QLINK_HW_CAPAB_DFS_OFFLOAD)
+	if (qtnf_dfs_offload_get() &&
+	    (hw_info->hw_capab & QLINK_HW_CAPAB_DFS_OFFLOAD))
 		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD);
 
 	if (hw_info->hw_capab & QLINK_HW_CAPAB_SCAN_DWELL)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index 548f6ff6d0f2..fbeff01f902a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -2454,7 +2454,7 @@ int qtnf_cmd_send_updown_intf(struct qtnf_vif *vif, bool up)
 }
 
 int qtnf_cmd_reg_notify(struct qtnf_wmac *mac, struct regulatory_request *req,
-			bool slave_radar)
+			bool slave_radar, bool dfs_offload)
 {
 	struct wiphy *wiphy = priv_to_wiphy(mac);
 	struct qtnf_bus *bus = mac->bus;
@@ -2517,6 +2517,7 @@ int qtnf_cmd_reg_notify(struct qtnf_wmac *mac, struct regulatory_request *req,
 	}
 
 	cmd->slave_radar = slave_radar;
+	cmd->dfs_offload = dfs_offload;
 	cmd->num_channels = 0;
 
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.h b/drivers/net/wireless/quantenna/qtnfmac/commands.h
index 761755bf9ede..ab273257b078 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.h
@@ -58,7 +58,7 @@ int qtnf_cmd_send_disconnect(struct qtnf_vif *vif,
 int qtnf_cmd_send_updown_intf(struct qtnf_vif *vif,
 			      bool up);
 int qtnf_cmd_reg_notify(struct qtnf_wmac *mac, struct regulatory_request *req,
-			bool slave_radar);
+			bool slave_radar, bool dfs_offload);
 int qtnf_cmd_get_chan_stats(struct qtnf_wmac *mac, u16 channel,
 			    struct qtnf_chan_stats *stats);
 int qtnf_cmd_send_chan_switch(struct qtnf_vif *vif,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 3e6362d06bd4..9bd4c8f98308 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -21,6 +21,10 @@ static bool slave_radar = true;
 module_param(slave_radar, bool, 0644);
 MODULE_PARM_DESC(slave_radar, "set 0 to disable radar detection in slave mode");
 
+static bool dfs_offload;
+module_param(dfs_offload, bool, 0644);
+MODULE_PARM_DESC(dfs_offload, "set 1 to enable DFS offload to firmware");
+
 static struct dentry *qtnf_debugfs_dir;
 
 bool qtnf_slave_radar_get(void)
@@ -28,6 +32,11 @@ bool qtnf_slave_radar_get(void)
 	return slave_radar;
 }
 
+bool qtnf_dfs_offload_get(void)
+{
+	return dfs_offload;
+}
+
 struct qtnf_wmac *qtnf_core_get_mac(const struct qtnf_bus *bus, u8 macid)
 {
 	struct qtnf_wmac *mac = NULL;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
index 949219c6cb8c..d715e1cd0006 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -134,6 +134,7 @@ struct qtnf_vif *qtnf_mac_get_base_vif(struct qtnf_wmac *mac);
 void qtnf_mac_iface_comb_free(struct qtnf_wmac *mac);
 void qtnf_mac_ext_caps_free(struct qtnf_wmac *mac);
 bool qtnf_slave_radar_get(void);
+bool qtnf_dfs_offload_get(void);
 struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *bus);
 int qtnf_core_net_attach(struct qtnf_wmac *mac, struct qtnf_vif *priv,
 			 const char *name, unsigned char name_assign_type);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
index 75527f1bb306..799c622a160d 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -596,8 +596,9 @@ enum qlink_user_reg_hint_type {
  *	of &enum qlink_user_reg_hint_type.
  * @num_channels: number of &struct qlink_tlv_channel in a variable portion of a
  *	payload.
- * @slave_radar: whether slave device should enable radar detection.
  * @dfs_region: one of &enum qlink_dfs_regions.
+ * @slave_radar: whether slave device should enable radar detection.
+ * @dfs_offload: enable or disable DFS offload to firmware.
  * @info: variable portion of regulatory notifier callback.
  */
 struct qlink_cmd_reg_notify {
@@ -608,7 +609,7 @@ struct qlink_cmd_reg_notify {
 	u8 num_channels;
 	u8 dfs_region;
 	u8 slave_radar;
-	u8 rsvd[1];
+	u8 dfs_offload;
 	u8 info[0];
 } __packed;
 
-- 
2.11.0

