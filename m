Return-Path: <linux-wireless+bounces-13300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E6989AAE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2531C21324
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03E9183CB7;
	Mon, 30 Sep 2024 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BHXsJF4I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B49183CCA;
	Mon, 30 Sep 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678319; cv=fail; b=kA+z+oW+vG7oEIOLHroB7DDJgvzcnSIWk2nkWLPDlp+yxnQc0UaWi6UU91LMKzFPXGiY68BZlnrVPPjoLye9xoX62Vc211uQMpntXnLxBviaQhJQndeDaAei8uad5zTv3bM1+ZgiMHdeDWvCi3fbUX4+Zt/PDf48F7yHIaVb4rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678319; c=relaxed/simple;
	bh=MqXLYPCMV1eqb2mw4jj/tGIok272B1ZFiqy1ovw1R0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VewtJMkHosbw9duOie8HBhZF7/N4AhjhOteHk23qzJa0asqQ/MYpKPPp39ktb6qJBJoWC5YenDA3CQUQb5di/qt0YgovC+9KoUOQT4rRPotHG+fuZTNYLHKkQJsq0GMBk76OgAVubaPHjx97GQXgCjO5V83HEyfywznU+fYwSWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BHXsJF4I; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gn0J+cTyHSvWajHo2QVFQ6UK919qDVPNnGdVASJNkkSla5qYUXUXt6iN5sYWpoBuB3NHiavPRSfD7Ntbg33Bp8xysEJrzPFVifI8aFQKO7JxQ1g8/RusBi4j7nlsNYMzRzZTG4xiyljZ65Fu1p1oqTNnt93ED96l6b7RyIYMjUWu1JhKquDwBNFN5ec+wFDV4EkQo8FfZP85zBVahIg1sNR1SKqKhNyY7OdL33nG1KbdsgzBPQXxICoZAHhjCRnbztLP8W3WrR6Xj+JHkt0nUEjYN5sUTinuZsO5R5XRc8Hj6DXwqiF8uRMRLWOJcmyA155h95Fggb20PthpYbbuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+b7b3Yp4o7k6ymtI9MtYerGLM1PxttDiaDliLQLklw=;
 b=HM+XgdLOZjYLuBELKS9jkJaKjuOGJPhc3e1cT9npWIBDHbk1uNLai5LKjxCmqHSRKCCp7YIG3nKamBBMKOh3g9fTqhuNTiFS7h8t5532fbHq9NgeC5r9kGX9mmm1Z/8oTJ2e1pXCuXgN3kdXSLzwmCOs+wWHxEaHjL7Gsr1KmLMn9LEWwM51F9aNgVJTXoZt0OnQ1vI7JUqw+vmXo3M1IAoDwEuusqiKLJBa3/KlcHqo0KCw6QyJ2DQkAFrnNxBTKERrDIh3QEZTFhAaWF0KQqLgkI0vyPL5laE9jOCDDgOGbunO9ahpTdaUxAdzY+6lmGneBUg6WZt2LoClX+8tSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+b7b3Yp4o7k6ymtI9MtYerGLM1PxttDiaDliLQLklw=;
 b=BHXsJF4Ih7tBHccywHeUI4DHDb40mUFL51aMuXWg42sssu+REa94l8165KH1iF2ZGlasDtSuBl3Egydvb7bBbgxlBH1mya2K41N3kg10fSVbFzG0TMeQ6hFzelkZPFClOPk968dfEAcPG477ryBZDcURCfN6GP5kUxCHOEb6rMCQcdU5BswFqdTzt1eTzpJff5ScPtA04FnsKgQEgLtu0U993bCf4jgLz0xY+eodCytiyshrRqVl0v0jVhBkCc0Dz7o11RIHg1d9ZYsAWXR0L7DANz5ZwzRzG1Szq8zyB6upP/ZYRYzicMRSuGOqBI6f8Jayyk5lmBzEurrdd5Oh+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 06:38:15 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:38:15 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 15/22] wifi: nxpwifi: add ethtool.c
Date: Mon, 30 Sep 2024 14:36:54 +0800
Message-Id: <20240930063701.2566520-16-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 30926ae4-2491-4d0d-a2eb-08dce11a7613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BuQUd5EigYQdIXmEtyVjoY9HGI+CcO5GfC9/Cdcrf69AF5ogqGBMiXA0E1bp?=
 =?us-ascii?Q?uRt5o6Mw4a6lS+qK7m4DicvqGm+3DLHJzAcd/qJEvcdfXJz6ZI5TSCLO9h3R?=
 =?us-ascii?Q?gkIKpsymCTHMQSnb2js3hXL/LG50KuV2/TLRrqxi61netGNXSmMxY7W3tqfB?=
 =?us-ascii?Q?/rB+5zvLSQRtMZWV3v4sioyk34AO4r+GPCQgIHddQ8Pk4nwT5rKROS6DbVn9?=
 =?us-ascii?Q?Z3LL+vFvGyKPZoxIXm5gzNeZMJ1pTefEChN8tQ3aD7YvV+BPxbzIVhVZ26Z7?=
 =?us-ascii?Q?Yy4to/dwlq6tchdB8DyaTI1qB5JjRGfhu7SplB/WXkM2qkTggFQlogmDbdTi?=
 =?us-ascii?Q?oM3XBC8vOydwtUdReFOJD7jUX9sZx0G3Ivw48gTl5cNkzrBcvau809J8DkKW?=
 =?us-ascii?Q?bO+1G+QO/Jhwvpg4iZs+eMK+FxB7fPQmTit5b90uwoO7oMThHIZOsBfMrzhX?=
 =?us-ascii?Q?YqHWajvkpyPtOijkwxDTgLXHVWMyNHvRcNBEhM2KBeL2Q0XeWjvW8+CmXfQU?=
 =?us-ascii?Q?fci/VXPxQZ1bfL00NQ7kQu0jvJrmi9p/F1jUnrl9RXEkB/47+655BPlWIuPl?=
 =?us-ascii?Q?zX6jK1tRncycZ8u8y88DgDctgL7TxWbc2Hq1zZ8UVTUQW5W6yW2LR6OG6fft?=
 =?us-ascii?Q?TMYYwfb0b7HYk4RWJiBjGbtVQjJ/BoR877u8r1jLmI4kQnJ2OnwybvmOJH8c?=
 =?us-ascii?Q?mx/a9ZmKTXsdOZiv4r1vczoSVUmuWetm+B59pEsfm9+oC5+vx71WNHCSn1f0?=
 =?us-ascii?Q?fZR+M43QYGlQYg02Cn1aRfFX94f7WrPAHMwPDq9b2WSlIn2wc69+6MzStpLc?=
 =?us-ascii?Q?usY2N+JpHhsxKkwdZFddWqFVkem0mDQ+pYkWQZ49BnI6NujoUrpbYQLDHsf3?=
 =?us-ascii?Q?olgp+QuNu4fsNbvbHIpxidqFQiWc02PVwEq9aydncL9z0Y+THj5xPVqTlEPS?=
 =?us-ascii?Q?P7xMM3l1xrGSv59hsc9ETjn35TN79WnGvf6xSP53b8WokiB6g5KOhkwC8zQ8?=
 =?us-ascii?Q?yjfWD/G4IkfjYR9Dv/y9AH1/mcoZvcJ52m3ls/JKEm98+JVqt8MelJzr1hy3?=
 =?us-ascii?Q?vFi896mEfHGQCFD8nKT4HNXCBSlnfSndbqs1n5A9mKpXfV5+sZPI3qol3wSQ?=
 =?us-ascii?Q?haFQrIEnDfe8GYGK8ZYXGDE6tllX+Fds57hZvGs9xNHQd617cPMjD79cwg3F?=
 =?us-ascii?Q?CaMmgSK8xyzMsQITH2RXP4iRz7yh8IJXzR941h+FOlRIzvBIFQP9Stb8izdA?=
 =?us-ascii?Q?gQ4EEhyeoZdo23/n0WGmvmuGuFvAjxnro0vQYBiC10GsWhtvEsLO6ZdB6NAJ?=
 =?us-ascii?Q?39qq2IjgWesHr+81X6e9BpiQWRfZ+XP6yAfUzCSvcSzQjF+E25lHitSWwYBr?=
 =?us-ascii?Q?naXQPykDNsiWQCsoVih8mnfvy1iaApMFO2Kie4fpzsqg8s+V1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xtO8/xJ0Lqkgs6YqHS1bK/gL4XBoyTC0eRIPtve7rtBqSfBzjV6cYfGfzkWG?=
 =?us-ascii?Q?Qx17+CSqgbq1kp9CyLE7Fx1HsHkiwOJa3q6wT07juABIfKYbnAcYezRu3NyQ?=
 =?us-ascii?Q?3uyFEHHM2EKBImBOQbyBJXsRov+mXb1zJtg3kzp5J+GWqLryEFDeGeOt98zr?=
 =?us-ascii?Q?OUkzhV6GxVCzsVoIZQbf5Tn3t1ZbM/yMWqBxs5j9QNA8WptVkoqR7doU5bis?=
 =?us-ascii?Q?ibK8FoAgpbCgq8KKZR/fOJ5hNA+EMWoqqBEd5eikcZ/HhWhDipYvxtQc+6XG?=
 =?us-ascii?Q?P8IdJvS+f9dXB2SvM7veiOhMvCvtk5xbteMM/0rF+il3RcOidrBIFq+75vWz?=
 =?us-ascii?Q?V3CGQp5hyAEBpVboQ23OCEANoX06mADtqpkAAQn5tbaMpE9SO96YCW7dv7f7?=
 =?us-ascii?Q?Wf29KoVdImNnZDKa2BHBys8+SrHwePi5I+INyQipYzrZ89qXzM18IaZHkFuA?=
 =?us-ascii?Q?k4jF81fY3Z7uc/MIKpIXai/CwVf0l2tsOnJz4gb/k6WrxywZS0buYnAmlk98?=
 =?us-ascii?Q?3isd9UKeHnpEEspSpbd8kKQ9FED39g8fnhyBwen2iGPjcy2UcxFGZDh0vVE3?=
 =?us-ascii?Q?C+rzP21kXRzQDhGtGrsqB/+H7lmQNZVPSFGtNXK08wIpgah5SVdMUtvaebK3?=
 =?us-ascii?Q?Mg5EmPtXoAy8+H9EW3+LyWS/5eHsgkrHBRbPOzI0J1AWqYuJmUUJ4l648k34?=
 =?us-ascii?Q?NSEP8GuG3Fjdjxb1kzD/XjNt4R5J/WQ3Plrjef3VuYX22gmpVA3rQXS/3H1i?=
 =?us-ascii?Q?ZQeJlmpEOxkVw0l9/Ua9qkzx5sUHrVN5zVX7JvPvu6g/ynzwas1T59lawlKa?=
 =?us-ascii?Q?7xvzk1O92KkPSrK8PgvSeiXhXUNcS45PlexEgg4pwnDxBBlSvoU0AKnj3P+M?=
 =?us-ascii?Q?ofXUN0TImVZNKnWaPCwcTNM9trMDXy1byejZF1K7FMBX3wG1YYEaNc6rkfc/?=
 =?us-ascii?Q?WJWKBZnVzXm6m8b96hpASVOkmeZatHWqXrJea5hCtZwZtl2rDWqg6M6wCYE6?=
 =?us-ascii?Q?7st3ryLZ57OjWszgAZddMpBWu0jP1kbw/SEadsUSDy+HbPy8QJmpKad0dyB5?=
 =?us-ascii?Q?jSc33Dz30s6d8C1SFwDGUuq3mh4q+ZNUPaYvxX37Rif3CWYVwfLu3C+ccrxc?=
 =?us-ascii?Q?ZXYEhzvTN3ZDTuqdE6dOz7GRzyYmSI/zYKqH+MLPOKSoEcC25sioKwdk5fzF?=
 =?us-ascii?Q?cJMRGwbQrz1fZmgh00BAp9rcJsPT0oRP4k4/wXBibnCGHk7s75+/lnlgFGq9?=
 =?us-ascii?Q?inLMIf6vr9qeZTY21IoVVFEEF9IIf77k/NtY2X1GNIhGUxhc/vIn039Gu9fy?=
 =?us-ascii?Q?Lx9O/vqOk/TXOlbAnm3iauxUNpQFtV4pZoiSLjlfIcSx8rlAgkmBF9G4YlYO?=
 =?us-ascii?Q?8VWQYkG75YdPvyfbrNA7GNvv7HKR/N4GJwwqy3+SJF0kvW2cDprGimTOfjJv?=
 =?us-ascii?Q?8+A2gFavvAV9cASrcfFLpKCfCwuWkiB9dbnCjLUScUnyK7SmYN+/vftZjlr3?=
 =?us-ascii?Q?ZGrD0TfWR2+g7obXv8xpi/0oCJApDKwon7bXua69dgzrocVgSCnqldMwfFK/?=
 =?us-ascii?Q?8K2V0Z5HYftIjWB1GoQ3+jKYFPB6jRtVWDZAg825?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30926ae4-2491-4d0d-a2eb-08dce11a7613
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:38:14.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntZYngbPOE1+aXGHfiWcyZVFPxCHxFqvgQzWjUS537jZMAmiNv4OmvH0SPKTP7Gb4WQWHr7nqId1980O348NMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

Implement functions related to Wake-on-Lan.

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


