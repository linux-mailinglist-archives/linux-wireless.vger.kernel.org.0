Return-Path: <linux-wireless+bounces-32535-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PccFQ+YqWm7AgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32535-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:49:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0855F213D6C
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E71D130765C9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E88A3B5822;
	Thu,  5 Mar 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cmxnEW79"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332833B4EB9;
	Thu,  5 Mar 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721755; cv=fail; b=ZHcYw2Xg/LSklRrKnNbHL8RgS2zExxlJgko7W0960whgd6U07ZAUIHZa97dE7i6/f7nR7wwy8zpyGVN6mWixZJqsdBHPB7g4bwxnu+a3JTXI6TVxhyUIkWcOLroAuifM1EifLvLHCNfZ4wFFoM+W8FYQp1aYIMmeQsZd/nXW5rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721755; c=relaxed/simple;
	bh=RlRs2pX0FAkMQdf8gqc4txc2bZ+PxzsjearMroatKf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PF9u5T2QMXKZdsTgD5CEPmJFrkllEg+iAebf1rfu5m0ucbu5Ezf5SDTc1JUWIkGf882kMuiYkCqSsD3xcDPvC00Y1mVSSsfwp/xeO3urwVQgQlhiC/ZtP+9NAGFi65T+bVcy16Xodd7a4C4Z4YZi0LadEj9N2NT1r7GweBzPyyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cmxnEW79; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GV6j97n+toYWr9zprozIxx3LgYl4sivXVjFqxQ7q1kVMUCu8DsDGTc7UeOu2PT5LJGy+B6qsqaTZdhhmzXmjLJOrpmqnp62GOfVmRr1P/tTlYJOw6cu+S2drgrIzwJWUPUZRx1h3rfhf2IQAkdg5pXjkFrsHXL2cJx1uUNenhdbUc8+kwtMzPkLcm+G9fQ82r4l62RF032DTL8nCdi5I/C5k8KcRIwooYNLmsHvWH5m6MPfmA3z965ZhlaJ1CdTWzH9g8G4ROgoUZ1ExPKS7ZzT8WkD1/I0fNHJeI/TZFbehHcWn9U3+wvpfcUYqOreHKNPnyg36cP4DM4TH2JIdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pohgcI16lIH88jFUObaCtPZeiFC5TenPzwDvYAj66DU=;
 b=eGp0B0W5y5kKqWH5uaAJqobInmApqM9+2Jh78LQUReFXz9C/8nTZPBQ/+p9C+B152V5dbr6SdZJXak4Mm90PkwEMZo1BPGcV+ZQ5tbiG1EeYv+I+93S6QbEGb+7zR9jhyOAG/ZObCjqR13qA+pSlas++0xFyrBwpswvJCHxSGD4nGU90K/JzZq1FEwUlP4zZZaj/UPy0cpmzhiWCSs9GTOHSiJkQNPn3HMEiHAF+6sQ0wGBiLwiybXUlFXFlHqmAMYrFxYmPF1M9aYjvpYAGAZKLoUPwFp1HLVJOvGoDWQbiZg9BWZoJPShH0t102R7YnkUbSdIcdveLKNymERYtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pohgcI16lIH88jFUObaCtPZeiFC5TenPzwDvYAj66DU=;
 b=cmxnEW79tlCjrHl1pJIqTVTDjwsDJxpK/MyuWOqfqiPszRsT2IBZDol80Nr9pMFoaTS0Bwho06nln9IIFtsDnyYVqRZUz9D5xwLPCEkeTbhAwhAuJ6LGfsP2+nDQoXVSTY+lGWFh8PHd74fZvJhBvBQGjpEuf8zZpWPP34eFGHMQ2hl19qHQYr9pHe4NPIYsfYzDM49B+/ukPBn0KqHS86UU0e9p28w1vNFul41eXdR1nffajCtQuCPaNsHjEEUgTHS08rN+JxpNlWKRx+HOf1NhGoanAAuLw1K0CHl4+vAmdaN2K3K/iORVc6Wvwsr3qpDa9BaAQ1zsUc1BZWByAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by VI2PR04MB10145.eurprd04.prod.outlook.com (2603:10a6:800:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:42:30 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:42:28 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 15/21] wifi: nxpwifi: add ethtool support for Wake-on-LAN
Date: Thu,  5 Mar 2026 22:39:33 +0800
Message-Id: <20260305143939.3724868-16-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|VI2PR04MB10145:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d30cba-4645-48fd-b0e8-08de7ac56c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	FfxBe0ebFyL5SllhYdrIXuSC26xmZJo1HN9Hyt4W20PsBViBkmXNx/ASuI4jzikd15g2MLJh6bkRyYhUZSHbaeenKLQE7U8kCKTfzl1xaq8kxNEnmkPJVc/5p10MHXwsLYfOoscwDLLPe/SzUbszWMOFyw16gUkvmeSUNCP4S1EHGuKsvVnJsmvy9apiDvr7j4QZbOebnNEnRdaF3CPGmGiUnUEZrglDhZ+FuecIOFR3ErcWcatZ/nWACKgU4tLKUq1wfuqByQU0rNlvQmiQXazosKYgjgjeBezD1SeKxUtS3HiXPYO3eZRsvnP/KDImceR8hhSmIBVlWb00E1GQzTOVTXj2fFr7U76Z8HYUXN4MF8vILB/PaGGL3M/yTBBmmXO4Yc9sx5cS1669AkmuOO+z4b6aZU3O6u7ps1AwjKqqLtIzwjDHFyarOuOhS+ahc4psv3sIryyjAqoetnT2Avm7H2uJo52LSqo1hPraMZaYHu6ykCDPfq/T640qxFUMWrN1w/wsAOyEWpOjn+L463IKc8ZNu/84qhFWVGB3GvNoXqPSNfMrphh3PAqdYAXTZvKB2fi/mLgbficTgwzz6D0D7mvkd5US3fdy+NZ6kZoDdvjt7zBnAkc8IG/X1DZoSZ0WoI7SkZK115qX0pWPauUk3Ra0fivAMMYWNVdBpAkr/QMclCkdF+5zNEdJy9cVgMRm5g6WVt8FuQCgK4fC6SPt8IoabF0JAUdzSwQvaKQrsWCrjIrbpbi7pjKtPFRUrTZGWz8tGtZo4UDKDUC4sFZyleGE+KrgiecScQFuINk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/d6Ak1FQy67jkmCnxYXt+IG/8irkZSFT0TvSSprQcM4sqR/lWcuPUsml2F2R?=
 =?us-ascii?Q?ru/vHRXLohVAJ9hf819shCtuxMrLg7Vv8o6ci4GnSVOTndY8Y41+zUbj3Dn4?=
 =?us-ascii?Q?+oteAfFQOdn7vGJHR+xmE8ZH+WZN9uFGDcqsKdtzK2ocOlnDmFCzn7eaDtT8?=
 =?us-ascii?Q?QT+rO7uF2e9sbp0NOJQAfONpGzsR4F3CbgthPuQM/g+Fk+5A6ZRJmTogJOPn?=
 =?us-ascii?Q?bk5WmYeNsPk4D7ZX1EMT7/2/YSQiAmckE77vbjiPaa8stSUram9i6b7eJptM?=
 =?us-ascii?Q?0HBW2riT8vZ5XEL0TSzrIsr54RgWmOnF8Hdas9dFDO/vhgZrDJwcGDPB/RRo?=
 =?us-ascii?Q?PfabZCFqUcNFp8AlKtqq0lGyqYjSdxtyVlrI2XLJtng03aoZJrLw3r5mdJpU?=
 =?us-ascii?Q?8Bvno91LKEiYuLSnMVYFEGVgS8OFoc4gJri9AcaCCWK6tvAYV1SUfClxYDGb?=
 =?us-ascii?Q?+65SmluawAZ2GLj47rzl9FC/2udF1a1Tk6/EYm/QiXMYpUE85YXSJAYguyr3?=
 =?us-ascii?Q?NsITA58J8Om4GBme4dlCtH/0pwS2OoEGOGdumgkjPoatCVKjQKa5z9OIwXhH?=
 =?us-ascii?Q?JCJ/+EP9v/VNo4Nz2AKu5O12EgKzFqNy8McnZqYkBDRhql6Te8BrY63eWnMT?=
 =?us-ascii?Q?7soJa1/89/ZqtKB8aCJQc1cisyaGWxZgHd7s5L72aO6/n/31rUvllLlW9WYy?=
 =?us-ascii?Q?XeVK2rifiGSGZa5yapA8BamzCFDA80OtJdophpQMn4Ub/pgdSjV4Pb82Uc8H?=
 =?us-ascii?Q?xnZtyHZDR+55FH60JKrnxnYvgbrsfZYXKo1rVfMygQ7UODYjdrNDbVLWTiKd?=
 =?us-ascii?Q?muY9qPCuhGphhIQjumjfiqQCqYIzDnb0Pp1EMc+/xNOsYYwKJsaCPf6hSCOX?=
 =?us-ascii?Q?LAh+nxkZmGQaOy1XTUogDWE2P0qB7b25zsebuRMedRkI6FUYBwsCOKDtvHqX?=
 =?us-ascii?Q?aBK3eovxGzqOr2GWP9I0JmxetHY0V63L60ocdylv7NG6m9wPgU5mCU1QQyYH?=
 =?us-ascii?Q?n4YwnL3Pcy//aO92XzXUu+uv2BUNNBwc1w0M82aLHyAQmWwmK3ZK5H/vQknV?=
 =?us-ascii?Q?23ATSSN3CHRav0Ug2NkHgDgTxMg1MSALD2XJsiZuJ1H/qppdIg6uDr36NJUO?=
 =?us-ascii?Q?6l9SQYGDZ/pCeXAanzyO1eLvk5Bi4/iZvvEsFKDLA+qg51YBgX8TvMA3PLkC?=
 =?us-ascii?Q?MQHk2aXZjHxC+C7e/ZRKUXhfSbBpOyJskHj0dkrhS4vxJpFvH47jZFRXHSJm?=
 =?us-ascii?Q?g+schdT9LckT2cCpzIIjtHWmDfmZu5gp3s8r5ySgUFctPCQwV4zNjtnIaKW7?=
 =?us-ascii?Q?qA6UpcLb63gBCig8TV7pmakADyMHolrkjmPqNTo20bfHWh6MFUAxkEv64dD0?=
 =?us-ascii?Q?/t79zqU4PsKKSie8TKRNIuBJPNSFfihyh50cP7UqRgoxhliHljUVUOItd932?=
 =?us-ascii?Q?lizyPTrPTlRAi1Y1Ji56oUjo17GmWcqJDTkWVQLy8tBmMDv0n+efvoPZD2zx?=
 =?us-ascii?Q?uvQhbztqNh/tupEyt/f9GVO+q5THMF9skb3+DMaiJWliNRHYNnXNR+1yywxm?=
 =?us-ascii?Q?QYuSgnbZ11SLa8Ebfoh/gIoFCChG9Bnl7msNqoNYq2Qb35eV4vRrV2JUkmfm?=
 =?us-ascii?Q?AIR9pvxRJpXzFzPVxDIhE2HsAR5/pFAhOueEPDmQOOl22wrhjU1Lf9CAG034?=
 =?us-ascii?Q?TBZjxp4VBxfCxqz6B59VUm5IRiydx8EMnXWMlqeytlNHHzjirPN5AzTUOlT0?=
 =?us-ascii?Q?zKq17mFXvw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d30cba-4645-48fd-b0e8-08de7ac56c89
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:42:28.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N8uI01K2XQIV83LlcwrZdgN4W1Wrc+TFy0lc4wUvxgmBtboOZbojxUOvBkVBjewoPCNhKQSWtWZjvZT0yBGQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10145
X-Rspamd-Queue-Id: 0855F213D6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32535-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add basic ethtool Wake-on-LAN support for the nxpwifi driver. Implement
the get_wol and set_wol ethtool operations and map the standard ethtool
WoL flags to the driver's host-sleep configuration.

Support WAKE_UCAST, WAKE_MCAST, WAKE_BCAST, and WAKE_PHY to allow users
to query and configure Wake-on-LAN behavior using standard ethtool
interfaces.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/ethtool.c | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/ethtool.c b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
new file mode 100644
index 000000000000..aabb635afcf5
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: ethtool
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


