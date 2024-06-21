Return-Path: <linux-wireless+bounces-9381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF162911D89
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3968F1F20CA6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248117084D;
	Fri, 21 Jun 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TLrRkJsr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2076.outbound.protection.outlook.com [40.107.7.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAD170833;
	Fri, 21 Jun 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956416; cv=fail; b=UPn2pGpVJ8x2LhnaXCfkKB2OHNFIVPGa96qZLP+F2jlMgL7G3mRUgbgj0+EfQ+sL+dCAIeipFWSMMC5WPydtyCWgT7LFDwRYC9R06weypBzjwtAYQPImpDtlRsinjEyyjwkH7oPWBuZJQaGUpxXnCtjGufD81V2NXBI2LBaZx7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956416; c=relaxed/simple;
	bh=C2PJC2GYMQd+svoclbtT5F6+/rEcoiBzzYvpkip8W+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AegMjksf89Sscqafk4z7r3hr5582I4aomI1Y3qMy3qnyhUf2NxGkxKG3c1gT51C+O0ATSGjgkvsex5ms3wkBNVM9y17eCm7jl7313X8kdhdTuoYT8gPnc0vEsCmTfl7QebIzVakfoWiGDUiXFzc6yNuPUvnYfJ0HzuDrkyf/p5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TLrRkJsr; arc=fail smtp.client-ip=40.107.7.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQLgTVxzZkUbUPcYu2sZquujhqbxT1I9R+u8T9ohEoDruAg15qGWLPuoOessxiwa/f69H+imgj8HJQkg5o7BK821rz67hvj7C1H4o3cM7yEvJha2oUcObjzS7m9bTMw8VNILvBJZgjTBmMqo+RpF54G7ps3foY4kfGcyr5lHnuS96T9DeV/KQ75SvpQX6QDO/m0UbPpN4wXc3y376IKN7aHWFML6IOs45OxNtaPSSzXLKKNzp8HsRni5eJjOBBWGgrwpCXFoppi7xHHobJVYo5m6PhmM4DOtWI8eknc41I9zJhh6SkSvcx2BwIKb7IMPthEMVoLmmAsdjw1I9QqUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfz0pAV1vC5xkzeShdbYbimiHZAN473eBr+M6CSIn98=;
 b=MmFylhqAuWbigf+yRunzjSqUMlsG97B6eDS+LOyJwt8x7wsIUMq71M7IbSNDGbVKa3/Be2g2BKFwhIxJ2R4/6j8VoA9wxx86AARVnOc1LItJP40kQYDpn7cEbPLoTm7tfvOsMYaUWj9ZUDyqUGEXZbBnM+aa9/C6iSZ7j+XG53iOHEVWGcMQDBc1uc8coGHp9cO0XIa+Nlsk/0ti9ku2RLJiqarZ4GRbAXCMmn/OjvHAcK0J04gcjpqjucVOSQrjWQJm0boWFzEsBt7T5IzNIccK4fNTW1tdnBl+3SsrTXEmOLiCQeZpojPHvheQunArzTUCL/KtCcUxz1bkWG3bNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfz0pAV1vC5xkzeShdbYbimiHZAN473eBr+M6CSIn98=;
 b=TLrRkJsrq5TBJxQsRVKSlhaZXGxCmynxvWsaYGuTrga1j4ChLrTFVM5agCOPD4V6F4Qjar9fNvbR1jbhgy6lL8Li7g2IcfO4ygrh1eLK7KdEcKY91lRa6XlYtwjB2PCs/6ZhDYYufLz/ucWE9XkyKd6thXVr2MiqNwVhVeinkHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:53:31 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:31 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 17/43] wifi: nxpwifi: add ethtool.c
Date: Fri, 21 Jun 2024 15:51:42 +0800
Message-Id: <20240621075208.513497-18-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 833531df-6d99-487b-5c81-08dc91c73d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lP4tL8APz/amCKjnldZNBxavbhY8sfglzOfjr4cLhLnkxkBs6Ggjjk51XGhk?=
 =?us-ascii?Q?E3Lja8j3WRJPD/zDkNjyzANI3NGC/S6dtoct7FTATliCHkOl6B0yetRJatAz?=
 =?us-ascii?Q?Vt8cgOv4+PhALC4wgfmcpRZVYUQ/mC0j2spIhxH+10pd1B8BiMQevXz4SDvZ?=
 =?us-ascii?Q?1GoGhxvdNXSSSznkNCUtBPMFhTSiMiaoIQwz3Sy4diruguavTweB2jf/S2Np?=
 =?us-ascii?Q?8+eg4t8v8bKIEz/TB8965VPJ5DyK6PA0FO0pCY0rrGqSje7RAd6GNw8bUeDk?=
 =?us-ascii?Q?HCeAX5KlXW0q5kVwFcL83FgpvD2CZmCFQkvjmU2V1BnYADrmNmoP/+N8Yzfw?=
 =?us-ascii?Q?0qg0ZTr+7IadTHSJirMWYJnZnf0chKCsSTCC241RWNvudfodmb/c7DQMQQKJ?=
 =?us-ascii?Q?fajrpoJssSwJ7TL+/rKTNksCcZ/xT1wnuqUU4mvkxDTwb9gFvAeBEYtXfDPc?=
 =?us-ascii?Q?Ced9zYvsOastIAS9UAu6cK+k2WmnfaJHBi1XzEpFG96kFztAFl+E5G7bprpd?=
 =?us-ascii?Q?CcunF2Aw1uA4JozPie3ZKKRZQOxZvB7qQLZAmlItKT2lsrwrCSR1s+uES7Fd?=
 =?us-ascii?Q?hQEn1FZrjKsetSkGVoyOFEtTXks9lBX8Z8Xuw59IoMIipb9Q/yxm496Zkn1O?=
 =?us-ascii?Q?VdQV31yH/ByeHfuHnymJVFaT9VIceTyItQPFKimA+Sq6zIbfuHYMoSf20b9X?=
 =?us-ascii?Q?jRqDZKY4euE3AuPIh9a3OLOQ/xDjHatHoG3AQLjjFK8XSgF6NiTXOrJqd2jn?=
 =?us-ascii?Q?NUIlqF+bjF0J5cSxsHl7Ic5AYWkM9KOLV22ZXiNBFAKfkY+IhHzCst6+I/Xv?=
 =?us-ascii?Q?WRvOFJoPIBF/urcekyCkWs2CbVQWOfNgcXvjNV7d/M+C16xMWE0o8Qpun0H9?=
 =?us-ascii?Q?X5CuqgBL6Kkh8GJpnDZi0fl3c59d0b9WZcx9oRItnhsGfKKyRG7BVEW9AGdU?=
 =?us-ascii?Q?dC1Asb+Tv3v+a++oHrHNGZkNxZ0Kng5jkystTMQqawjdm/Nt5Rd7MzIz26dZ?=
 =?us-ascii?Q?8R+Y6Vb8z5VXrQ/xFOQ+2fSG5/rxu6zIKbeAq+dQX5TllkG6hsgXcGEgFrO5?=
 =?us-ascii?Q?2FSL32se43zKrZsUDFqLLlzdJmGF8EYlJqKtvSz8jf1yAiTzglEFJjNd6Bjn?=
 =?us-ascii?Q?Yb2kvvv4tkCZMS9qGwc7ej+nqSSYITZohiQgpIB1sifnPuKJj9WmNewERTTR?=
 =?us-ascii?Q?JeOrGLgmjRT+cYYiilCiW7KW7+uZwGj9is9LjNWo1np0ZfScWzKcyCVs5Aov?=
 =?us-ascii?Q?F5VgeJQ5KLgFsDTJml1LVtfNdLA5dwFS6oSyJvEjjeF8pxRZN//60w1vIMJO?=
 =?us-ascii?Q?klFuMcxfcoWma0x6sfzeG1x8dvkKkKGnPXxJwyDbGSywElDuNBg+FKfo+rvn?=
 =?us-ascii?Q?t6b4tY8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ivdIee2nXl85rExFz6ImmGJmuup8ANm2RBaF9T1RIPdpianYKONZd0W8l5eT?=
 =?us-ascii?Q?YN7LGTTQkdlL63FiL8oOYHAC17aM4xfkhpHbwuMxMMe7BjOpaXunnVBEGvMG?=
 =?us-ascii?Q?Ki5GvQuWLZjunPyXFzrWXx/fofWgsTiuGEG5QGo4ei9bzAPkogBKdkZ0WzZC?=
 =?us-ascii?Q?jiDEByGLbFB3lLBf3iUVTI9SHXpyCD2fUj3xl/zgywEXu6BXfCK9U0A2sgHQ?=
 =?us-ascii?Q?jfJHtFMp/5LXbgMe9lj/R4pB4IIKswaPWm6bBtthwr8NgSJiEjKq1SbLvYVJ?=
 =?us-ascii?Q?9cg5Nx2wsrdzz6aafd8nNi1ZXJS8IwMSYptw0B1JtSshDLQiy8+wwVachV6M?=
 =?us-ascii?Q?ij6rOnYywHgwaGABngFM6zK9E4fmgvEyoos7b8uqE/GszD+FFdrV4u1HLolc?=
 =?us-ascii?Q?yNjTLesA+oRt4Dkoe3p4AetSZY3rN1wm4KC0w2PNdoSFOtxQX4XXo+Cnuw2+?=
 =?us-ascii?Q?Jw8+5UZ9Ha1WwUqecl2dWzWS3e47IXLUWBGGCjdF8+/c/fmS6NxoYDfWFGGO?=
 =?us-ascii?Q?IW71fcmckm5r1WhM6L8WkoOsghvLaxKkfPutVqSe0QxfR7PWdeIWZ7L+icVl?=
 =?us-ascii?Q?JGz+AqyIiBnrX7SEIibqYmMLbMIezAyJb4dkTaWZ+JHTzDuCVfw7wkVV9AZF?=
 =?us-ascii?Q?Ie7YI7l6DAhvWqvP4mgzGlgq6znICCcCdQTb05/Nd7oSD/KwEsmPU1bM9YUf?=
 =?us-ascii?Q?1uH6+DWFsAm57VT/QvPd3PEH1j40PFmN2TkYQM/V3aciOIY7J6P5rj2L2+fp?=
 =?us-ascii?Q?/RVxxd/BzsSk2RUnQnJDtsjhPrLKRlquPj/lnwK7Vl+JqLMexp86hc12I1G8?=
 =?us-ascii?Q?LvAwf8egdeYB/bfWTz2W6L7Zk3sn74Qh/hPGdctphtE77t3cpr1J11aJsNjD?=
 =?us-ascii?Q?nNVcmNgyhhxlhh/UKSwoXimTyqa0kUyhg0U4EadOE9RU5dbGxSGJZvJdkN7l?=
 =?us-ascii?Q?5drPewxxX7cNqAy5Fw0WFQgPjfFquNrjFMAlFVfkD2fKkmJY19mgAmv1wkSx?=
 =?us-ascii?Q?NAeYNyNxTgYVSsvg7Spxr1btFjtf1TVL7cue6wfUxgUnM5a+i5P7ct5JZmRJ?=
 =?us-ascii?Q?/m1SrCPuTt66z0IbRTuMzCL54WkHgrNeOhu9g+9pPfzWYzGhT1uTbyy6HZID?=
 =?us-ascii?Q?Pye1GrFJQbEjGuKkK3BEmXX3JsLK1sOvJjKDlg54dqvAIyb/qcz/B1CkUcXm?=
 =?us-ascii?Q?IhAvD5I7GtGrpmmFOftIaSLw9Hmbfi5E4uunQ/ICl9lBXhmXjMK9z9dAKXp1?=
 =?us-ascii?Q?vCawYUUxLxFpdU9NygKc4sSHwzNLf8XioOg4L2eXla15JVV2HHygx38hNIcy?=
 =?us-ascii?Q?BxmR1nddD416RPIwPl04QVJfvt5bEy7iaWZcix34ATbC0SIa29lK+mScsS6B?=
 =?us-ascii?Q?ST8llwEJXNr2/6lrNsLHRBUN3L/o0qR3doPd9LomM58xgXsve2+abuHScQQG?=
 =?us-ascii?Q?lHlq6ULtLSbMkeJcU+AhWPgaXpme4qyJO3WhWJ5LpWLPd/2rPBwmWmvt435I?=
 =?us-ascii?Q?nkF4YSd8XjuKKmtd3gDv85GVdVR61LZGHjtmmR0bi5eY6y/tduFgwEMQVZcS?=
 =?us-ascii?Q?pHIOWjWHGHgSCRvUPB7V/XBxGiExVwvfFAjYYBRI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833531df-6d99-487b-5c81-08dc91c73d9f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:31.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzE9W234d1pORXistFJf0Vfi9rPILrO62GQ/8DdZqBJ3PToN14+f2AsP+0jISrf/CvzQtFA6xFyR0SJY8LzRuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/ethtool.c | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/ethtool.c b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
new file mode 100644
index 000000000000..6cefa6e6f5b3
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: ethtool
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+
+static void nxpwifi_ethtool_get_wol(struct net_device *dev,
+				    struct ethtool_wolinfo *wol)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	u32 conditions = le32_to_cpu(priv->adapter->hs_cfg.conditions);
+
+	wol->supported = WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_PHY;
+
+	if (conditions == HS_CFG_COND_DEF)
+		return;
+
+	if (conditions & HS_CFG_COND_UNICAST_DATA)
+		wol->wolopts |= WAKE_UCAST;
+	if (conditions & HS_CFG_COND_MULTICAST_DATA)
+		wol->wolopts |= WAKE_MCAST;
+	if (conditions & HS_CFG_COND_BROADCAST_DATA)
+		wol->wolopts |= WAKE_BCAST;
+	if (conditions & HS_CFG_COND_MAC_EVENT)
+		wol->wolopts |= WAKE_PHY;
+}
+
+static int nxpwifi_ethtool_set_wol(struct net_device *dev,
+				   struct ethtool_wolinfo *wol)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	u32 conditions = 0;
+
+	if (wol->wolopts & ~(WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_PHY))
+		return -EOPNOTSUPP;
+
+	if (wol->wolopts & WAKE_UCAST)
+		conditions |= HS_CFG_COND_UNICAST_DATA;
+	if (wol->wolopts & WAKE_MCAST)
+		conditions |= HS_CFG_COND_MULTICAST_DATA;
+	if (wol->wolopts & WAKE_BCAST)
+		conditions |= HS_CFG_COND_BROADCAST_DATA;
+	if (wol->wolopts & WAKE_PHY)
+		conditions |= HS_CFG_COND_MAC_EVENT;
+	if (wol->wolopts == 0)
+		conditions |= HS_CFG_COND_DEF;
+	priv->adapter->hs_cfg.conditions = cpu_to_le32(conditions);
+
+	return 0;
+}
+
+const struct ethtool_ops nxpwifi_ethtool_ops = {
+	.get_wol = nxpwifi_ethtool_get_wol,
+	.set_wol = nxpwifi_ethtool_set_wol,
+};
-- 
2.34.1


