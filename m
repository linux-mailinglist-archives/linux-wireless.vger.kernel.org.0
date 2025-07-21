Return-Path: <linux-wireless+bounces-25730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB9B0BCA5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E204B17197E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06628287243;
	Mon, 21 Jul 2025 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvTtjQhz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D342868B4;
	Mon, 21 Jul 2025 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079522; cv=fail; b=KJNVSEMbv5l4MsVfgH+WyNdgCwAgN5oHly31+En8HBdfQLVdcqQvi61PVgjv0aLKOVk7wIEQqDNp5y5ohzNvuljxG/otigtbaoyze7Jbd4vdxz+0l+PeO8kac7qjHXD7QKRwLgTkzIsk28kplGEBMllzuC/K/RkObXRcYrPVOHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079522; c=relaxed/simple;
	bh=TrtBGMianyTto3Fy5B2Uot/t7tfNntHhvKPbGguM4KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xz883Qb+HACOT4acogSCGdeC+s8JPajuqDjqZIJf2HQFEC1mwkE74Ql8QugxYytqmzkn4Vtvij/HcpXM7IvNGyP/ibw/WW0iIFkN9sGhBrAfqXmleNm0Yxb7B8udqM6xMgDJaT1e7dgHhZk34ZGyBkRgO8L15SjRkc/7dkG15vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvTtjQhz; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecD73pyKrVhLWphwSq6ttNS8JZy7ArNggV7XKSmGA0+Qb2yMi5IWdKw3PEZBAZgwECzkIrDhNHowfwyaS5k/knDfFm8tigYLUZ8/yirxR4V7Yd3HuTMR+h5fwWlSO5fLDyWfLbL1A2sVvUyQvu0pHovT42RytdLK5FOdoa68uOTMDdY0WXFdIzOPMQqHB3Wzwm0HeiA9jfe1XN2ZchqSWiEnMCSg3bcdt67ZJgqnQGLvo0lSyukbXiz1EZcAOyrRnmVpsv5G7uCqD/IBSwIO6brksJ7/7GHdinhx/6SDubm87nuDsXCR3R+HTupYJz3MkPyimzHYCB/DJytmGSNz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2tSrewRU5pFIYo0HCyT5LfkTqEyZxGDRrRr/nJ3mGs=;
 b=Levt6LkKAz7hxFU1ZGS2uZACVgV+27beWLIQUsKntf9LLD9gM4zbUyFD8doG11gHbkwVyKjR35ZPkaUS1ZVbdcvwmf+94+xnmEG4YwJi8LCeGI4W/sUcYAeLgDUzKhH2jB8A2SJrq6NJ2PKNsJO4ZPpyWqtli3jNhMjA8JbpL8vXP2AJY8Aqt92u2W3KSFvrlWROhLsU8KjYMMNM+8++3xu8FrGQ6adA2gvgOwJ01nao7M/g74n0qLNOeRYVLvlFgLphwk/BoOh2l8b4t+DHdE7EmkWwlBKlDs36yPQKoW4sbztnPzoqKM+WaVyRZt8yyI//SXsviEe0YKmN0NA9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2tSrewRU5pFIYo0HCyT5LfkTqEyZxGDRrRr/nJ3mGs=;
 b=JvTtjQhz1GWzw5dPlCqsUvS1tuV6BPQqqx96gnMN1nrEO1vYfXEts1wqiZ2ivo33VwaLT5OfbBnEGiljEImRtkOhcAvrLRvPlVy1/chVHycc4zlwWpwfqxdvbNyYcknYiTveMgGs5tH/DYZ6uJILFWSGKwS45XQorwRyZ3De+M+jGQCa8/UEF31XFXupHO+I2HmgGqQNfRwpVQ6sY0/I78XXJ7jTU6cf417IrqCce+Zclqqeip5eoVNZbe0GhHyVBzMJo9e/rvFTq3OgSuLHN/3vgDeN+2ETu3VNJSTfYOaKC2cn+mowR8mZSFxotzEP1LQaShgQehTsqW3p8Noa6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:31:54 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:31:54 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com,
	jeff.chen_1@nxp.com,
	brian.hsu@nxp.com
Subject: [PATCH v4 15/22] wifi: nxpwifi: add ethtool.c
Date: Mon, 21 Jul 2025 14:26:34 +0800
Message-Id: <20250721062641.2001796-16-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
References: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|AM8PR04MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd7ac85-1e6d-4e09-d0cd-08ddc82048d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bTl4IdKDMwgO6KKBgtFtGzmp6uzqKR/7UIFO4nZC0J/HpMyrqnW+hIJj/PEz?=
 =?us-ascii?Q?liGiEH2gdpkLMhmVygAunWUuLK24o2un4v7uIH+ysL74oPHt4A5prT2NAtoE?=
 =?us-ascii?Q?DqZQSIEMn53ILPRi38O4PEVhEADDvPWaTt9KRhU8KqJKXRvcatf+tqlcOqIr?=
 =?us-ascii?Q?prat/mxFADXQbHy6armi7JntkK35Prlv2loLKZf7xdy/PGMQ7SSwDYfOIm3C?=
 =?us-ascii?Q?M5KhpAfJo3NU4qekgGVGq2HagICsmxx+8azBfswDYYlYQflxOt5pz7ApSsJS?=
 =?us-ascii?Q?Rpewgzr6u6b/LPB5DyqqB9oll2ZZa6QJetflsqFky5CDRCxm3bho6hSEEF9Q?=
 =?us-ascii?Q?qrQTVyoUGlA95B9ecIJoHjNQf0/WIB60rSd1J6bE4qS9kT7EEE4H86UCYmCB?=
 =?us-ascii?Q?oKKnf3BE+KYSg+czII321d5COblLfDHwUeYSrCCeXPOXyuDJ5HyvXJPm1zfx?=
 =?us-ascii?Q?EwyqRrplkjno5Gh5HPGiiWWvz/+dOEGl5teCV9ypiWkviPD2vJau0vztj6fR?=
 =?us-ascii?Q?qqI6KeUmhkYDZOIdO8ur45g6kKsBzAplzNKwEfX+O8dWQGktOIASlyrB7Sj0?=
 =?us-ascii?Q?K3NCU0DCZ1ptfe6zZE5E4qxHwVy6o888qnifA48BB4ny9Fl7d+M1imxmfavZ?=
 =?us-ascii?Q?Bzu7rRIZT8YvbHpNm8jDjvEhmLhXB0rncs/1cAbU42idsT5M8mz/lpv6DQPI?=
 =?us-ascii?Q?r1cLLh+k8PvbuYicGCCa+tOvTMlEZF85WNmHWimrGX462k54LvWh8Sk8Sr6v?=
 =?us-ascii?Q?bT8scnBefd/IMhIY/nQqCtZrwKk8YW3Q6vGVBebNKgCkQEJQySzxWMFL1BTI?=
 =?us-ascii?Q?H8iyOa411IE00esFhWCHzQuWQkqnijxkJnnIrI57A2ygKSMVef5FF8RjMo0t?=
 =?us-ascii?Q?DWCIiD7MnnByYiF6BA+nnH1fvsS3atTY56suGwwIt1nGm+to73vrpfbmrHUS?=
 =?us-ascii?Q?lbh3lIT+HRcKrgJrRkqJrpFT59yk98MZx4U6U8JCcLR0d+HpvX4nG22ouLhZ?=
 =?us-ascii?Q?emETOTBBMnzOQVNKWoniwWT+x+NByASesYQZudlZCCy8g29r7LhVy4rC0bn5?=
 =?us-ascii?Q?Pw+UwX84V4tKvmFo1MXIGueAKpDs/n/lvm3O2s50/x1db5pJ5AyeRSjuVOUv?=
 =?us-ascii?Q?AZpVObei5vk0RZib4igh4IGjLhNbdww7qI7niiP3YfGoWd9yaaUEwLiteMPJ?=
 =?us-ascii?Q?Rj8xTw4rO6L0fbOP21p20+MWS0hhbLq2EGdciAWXvwMMz95dHv8uf30OiVev?=
 =?us-ascii?Q?hGoCzI6EjFxkTjnN43/8IGRxRKb3O4AKKBunOhV/gpLTK9sGI/nqFrzZWDk0?=
 =?us-ascii?Q?hjcuUgRSahTUCQEANF+90xk+JaEIembKBi5YMniD+nWZv9w44/j5Vb9/ORLq?=
 =?us-ascii?Q?jStaKLQv8f+T94jNxXa9XnHwnvDIiavUBO8h/jSjBLHFIC2OhjwKZn7HQB+s?=
 =?us-ascii?Q?hOX8RLwkAKQ2wdh5j119otdvNR0F7ySpx/sDsFYFwQTQRErYRNdOAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NJFSu47RN1VRx1GFoQ3bLS2uUGnrJWxy9fw2sOpY9h/+eeDOcKPrI3Xn0FS?=
 =?us-ascii?Q?/lhDP8c4M+oLSJAXj1E/07DCyYJEIa23IP5YMBXfxh67wYjheJ+cYZC8x7Bk?=
 =?us-ascii?Q?dm48Ppogdc1vVxnjHgXl0ODboAU41L0B6c/Hg5e5fY41mPcGDyYIezkdEUC0?=
 =?us-ascii?Q?MXrgAQqSz7gmMxEQMZqwSqGtG4VSWbmCb6tVGrSj8LUjbioK2oUgNGjElmRA?=
 =?us-ascii?Q?TN7r0ZIBNa1my6JoDYVERTm173QZUNa/jL5ODdiVenOi27fFxrqFub8V7u/F?=
 =?us-ascii?Q?Xv2jBti/gUUA++RIigVgab8tcHZ1u9wl0lc8nxFKxozd9FeStutbEURswtHB?=
 =?us-ascii?Q?BPaKV2DLzZw+bG/U/OZ5ysxhrjOoLzs+g/v6wQz6Iw9KmEXR6qV8H64LdwD6?=
 =?us-ascii?Q?DWBSNmqIvDFR3PLVK532CBzqkzSaAKAS+OpA+J1KFKxoLZA87Ifck9FwQV32?=
 =?us-ascii?Q?g80GvEzzk1qDsz78VbV8KgkMQXrUVN+GhAaQ3qdiz6kMRqDzvZDfBU7YodBb?=
 =?us-ascii?Q?wv/0HrHbz70CnklZhRSSCKj2bsaTLQBUIuCARrVb0uH2aYaVCtRlFvQy/M03?=
 =?us-ascii?Q?YbBs1tJbHz6lLiD9ioXMeERVtPgw+pLTeuuIzBVNwmhG49+Q/rqp3C6gXJ9c?=
 =?us-ascii?Q?NOUCfFGHeocu0kmEPp5GT81HB63ZdxqY5Dha515JuF/zJ0NsdIyXePIB1Rug?=
 =?us-ascii?Q?m8eEIM81gGzhWV92tyUNfRv8qUUbNmddomtbHisK+Af1oL0fSJDzPG7IWonX?=
 =?us-ascii?Q?KVQDxFL/2NY35ijaEqId+2k1FyqVwKw6MvyvTlH5Q9cbPdCtv59eWiunDEAF?=
 =?us-ascii?Q?QURNPRFAmyNK2qAoB5wfT6XUKlDkEcWXykvlURMOmzkbIIZStvKFIU89UqTb?=
 =?us-ascii?Q?YDHYxUNdS4mHK8oyQLo4cyTSdMEl1vYNLL0JVXM5/iL4tWQFv8bYn1h3fY0Z?=
 =?us-ascii?Q?++gIC8dAzYAi95s74JIFDbz3WO1zRtBf0Iit3RjRrk0JfKcSHh3vLO1Eps8B?=
 =?us-ascii?Q?EoJynTL2qaoEC4OIvjDHvMIhh4usqnboM9tv1SjWPR9R6u95FO6/oOI1jvMt?=
 =?us-ascii?Q?oRIHOB1RJ1JTFOhYPmWvCaC7/HR/i/SbXRDeGeuy6fYwPJgN+j2ZpmCn1jU4?=
 =?us-ascii?Q?+S8hsH5ZAzKGkSpDj9o1KqZ9ahqfb5KAdekm1dtmIpmpFO26Ggg8c3OGzKhH?=
 =?us-ascii?Q?HL4K3PQ4Ez/jnPT4YSybXgQfnjTmcSKGtVbK+S7HfIcsVdIJDKJnHMdvt1LT?=
 =?us-ascii?Q?DBp/FxQaykvvxzPpng2htYKKojiwc+Udr6ntotUVcxeBajdcxNSAGExlcruD?=
 =?us-ascii?Q?RRsTXodBcINlL53U/9+DbcKmD4R/9bFincdxAjglSlJS4Gbyt5Wg6fE41tlJ?=
 =?us-ascii?Q?/wAVVcjAH6CpQCQreyM4l13e7VK53d7dZ4t2aFiylhpsZ/eD+UcJPWt+Eren?=
 =?us-ascii?Q?vGumqoASHpujaKqwstkfSpeznwwAL62ITdKsdff99Evfn5k+1xQ6aeNP9JwN?=
 =?us-ascii?Q?yXjZje7Ghlxz9juhxcRDHhMr34vosjdoY8tJ9HUMWfWa8HT9YAflwh0ywmfm?=
 =?us-ascii?Q?hOlqXJZWi+ELmTz3CYqt54tSB3H6MhIZ/XdCULv4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd7ac85-1e6d-4e09-d0cd-08ddc82048d7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:31:54.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhSFtiZGFZxV8toAmV+b9ZejqarAnnFSJiTWGFzlfWQtVO0oSUf44zvroyzvgkVoRfeDtxM6pVe5georEwSgFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780

Implement functions related to Wake-on-Lan.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
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


