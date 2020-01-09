Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF96E1359EB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 14:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgAINSl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 08:18:41 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:55608 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729409AbgAINSl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 08:18:41 -0500
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 009DB44W029584
        for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2020 06:18:40 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by m0059812.ppops.net with ESMTP id 2xap4wwh0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 06:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7rvKrWWICqWBOJ1k5pdPXfRkzRM6O5wRHy223DuMBj56XcR7U9cDd18kS6V+3sLFuW43u/kkpfOgzhx7VX4YgJ1fR6cSfOjFMAqHvytOyyVCLw+qhhHlwOBP+EuNyiIFtV8pRoFtJh8e2q35YittKH/68/MpBkUCkhFZdZgHP8eFlkzr2HdhaHE2sTVZaYQm/gxQdc8Jc5Nn/ciRMmgesf7bTHKNv4/ARqbxPxvj1b85eu0tF7Jyua9gawrYq9POJw29h7QMcUKgb9s9yjO+Nf3Mba+PThO905LMExt9rvEpoSh70J8c6mQEVCe3KHiZZNJfo28fevvoZyek4iYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+Jp9R3qbfufuV5VwJAqdBD6AxcN9yiBz26CK2osK+U=;
 b=YT60DNcfGPF24uFsPZ+LK0hBW4tFiTEyKEp+lrv1IeEXVx0mUWX1b4Fnh4zJFOVYWDZFW/I48zJryElJmHLi/h0U7vO6JNITr7ajqAH4xZCwkPrvo/SS9LGTHf1bTkffZI+Bgb+Nupb+nwLGTG2iISUdj1YiCId4lFDwE7WM5YhTtybLNhy+GW87ABCmIi46gwYvvNKpICzZZaBpQfykC590nR1l40L527FTrO9oVWwjgd2wZMRdshrOS7jG2QhpM4mKrKEYVyi/qguRyRZ0g0pMUHiLj9C0lTgDq7OQ4fm+X7835uqhgnjV7GsiULcceDbx33fmi9vIL78yqpyriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+Jp9R3qbfufuV5VwJAqdBD6AxcN9yiBz26CK2osK+U=;
 b=REcryo3G0Oi3raYmxhWCQcwmNY0wBxchSUhCpXY2zTdsYdIyXxANLJWsknYigvPmkulLmoYswCbldEp3o47R/1HVadNJd9WzkWo6eEtWAxFYdFxphwgAjh97q46KBXh9408smdKrfc9MoC7ZBvAHTdMqHYiwS7H+9E6C9lrvb7I=
Received: from DM6PR05MB4284.namprd05.prod.outlook.com (20.176.78.21) by
 DM6PR05MB6492.namprd05.prod.outlook.com (20.178.226.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Thu, 9 Jan 2020 13:18:39 +0000
Received: from DM6PR05MB4284.namprd05.prod.outlook.com
 ([fe80::fc8f:de9a:ce53:81b0]) by DM6PR05MB4284.namprd05.prod.outlook.com
 ([fe80::fc8f:de9a:ce53:81b0%6]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 13:18:39 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4637.namprd05.prod.outlook.com (52.135.114.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Thu, 9 Jan 2020 13:18:07 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 13:18:07 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 1/5] qtnfmac: cleanup slave_radar access function
Date:   Thu,  9 Jan 2020 16:17:51 +0300
Message-ID: <20200109131755.7729-2-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
References: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0901CA0053.eurprd09.prod.outlook.com
 (2603:10a6:3:45::21) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0901CA0053.eurprd09.prod.outlook.com (2603:10a6:3:45::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 13:18:05 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c70f3ffd-c755-4e48-3a8b-08d795065daa
X-MS-TrafficTypeDiagnostic: SN6PR05MB4637:|DM6PR05MB6492:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR05MB463761866677F5057403A6B9A3390@SN6PR05MB4637.namprd05.prod.outlook.com>
X-Moderation-Data: 1/9/2020 1:18:37 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(6486002)(6666004)(478600001)(7696005)(86362001)(54906003)(52116002)(6916009)(8936002)(8676002)(4326008)(2906002)(186003)(26005)(16526019)(66476007)(66556008)(66946007)(81156014)(81166006)(107886003)(2616005)(5660300002)(36756003)(103116003)(1076003)(316002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB6492;H:DM6PR05MB4284.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yh6F0HaATPcMo+EsHbG1BhcyRxYgfyFAq+DmvXgMXKKH+SBi838I6t8ISBhlVjOnh4yCoEhaPorgaEBcNgG8JAQhWXmmU+TrBWk+7e1u7gEXPCmsM/pM06X4O6qQiXr17cEWiMJkdUOIRmiVzyYlHuxPkhBm/IuqkWYsV5+/7LGbhp99ADsvz+nMLR09Wd049f89GyWgz3dhUON+HOg09vc2qF0W3Gvv7DIU8iX7ZOo/bIde4JI/PC40UiAKuIHFAAAefTH4b8izoTjwjsAGO/+LReLMZM0fgbCceJE6RnhjFKdRbqy7F3TELQqnthwzbURGSbcDQ+mCxVnh2TzwGVV+DbT+aaZQJ1VkPihLSVYVbbRPILPlsF4R45EctwuN+3avvxOcXOi8p3/sCnEDo6ppYaUUNOItE/V5hEDXyHiMb+hHf8cpTwZq6zvvBijL
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70f3ffd-c755-4e48-3a8b-08d795065daa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNn7ZfmKmTIcl3ncs2kiyVh3hlqJ59BCPxrPY9BXGhuhQ3lNfly25GoZ2/zZj/t/cVu+i2rmGB1G0/HoT17/rmrdt7rQKE9E/Jaz7amC8UPnBE+ta/8yGCVaDE4tcjAK0uWzpbo9OKTdOs6MSkzb+zsVGd84X/zAA6u2lt6EKfG9F7yTFJWgz+8vkDbXhJyeKnOP7wF96oIPAIFrrCYXqf1QwjNlaCKtnT6q5tT5kBg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 13:18:39.3212
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6492
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=3 clxscore=1015
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090117
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently this parameter is global, it is not specific to mac.
So this function does not need any input parameters.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c     | 10 +++++-----
 drivers/net/wireless/quantenna/qtnfmac/core.h     |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 59d089e092f9..25a9b512b8ce 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -1056,7 +1056,7 @@ static void qtnf_cfg80211_reg_notifier(struct wiphy *wiphy,
 	pr_debug("MAC%u: initiator=%d alpha=%c%c\n", mac->macid, req->initiator,
 		 req->alpha2[0], req->alpha2[1]);
 
-	ret = qtnf_cmd_reg_notify(mac, req, qtnf_mac_slave_radar_get(wiphy));
+	ret = qtnf_cmd_reg_notify(mac, req, qtnf_slave_radar_get());
 	if (ret) {
 		pr_err("MAC%u: failed to update region to %c%c: %d\n",
 		       mac->macid, req->alpha2[0], req->alpha2[1], ret);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 5fb598389487..3e6362d06bd4 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -23,6 +23,11 @@ MODULE_PARM_DESC(slave_radar, "set 0 to disable radar detection in slave mode");
 
 static struct dentry *qtnf_debugfs_dir;
 
+bool qtnf_slave_radar_get(void)
+{
+	return slave_radar;
+}
+
 struct qtnf_wmac *qtnf_core_get_mac(const struct qtnf_bus *bus, u8 macid)
 {
 	struct qtnf_wmac *mac = NULL;
@@ -456,11 +461,6 @@ static struct qtnf_wmac *qtnf_core_mac_alloc(struct qtnf_bus *bus,
 	return mac;
 }
 
-bool qtnf_mac_slave_radar_get(struct wiphy *wiphy)
-{
-	return slave_radar;
-}
-
 static const struct ethtool_ops qtnf_ethtool_ops = {
 	.get_drvinfo = cfg80211_get_drvinfo,
 };
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
index 116ec16aa15b..949219c6cb8c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -133,7 +133,7 @@ struct qtnf_vif *qtnf_mac_get_free_vif(struct qtnf_wmac *mac);
 struct qtnf_vif *qtnf_mac_get_base_vif(struct qtnf_wmac *mac);
 void qtnf_mac_iface_comb_free(struct qtnf_wmac *mac);
 void qtnf_mac_ext_caps_free(struct qtnf_wmac *mac);
-bool qtnf_mac_slave_radar_get(struct wiphy *wiphy);
+bool qtnf_slave_radar_get(void);
 struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *bus);
 int qtnf_core_net_attach(struct qtnf_wmac *mac, struct qtnf_vif *priv,
 			 const char *name, unsigned char name_assign_type);
-- 
2.11.0

