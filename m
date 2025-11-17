Return-Path: <linux-wireless+bounces-29039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E82C63B72
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 628EE4E824D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5332F742;
	Mon, 17 Nov 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/0J7AGb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3032A3DE;
	Mon, 17 Nov 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377367; cv=fail; b=EUy1ZP4Qg/c6PlztmPb4uPXNjebLPEassXdsKEAStu62xfj/NGNILA5hpaKxpNHyXcxNB2wxs9DdxkLbI2qKszo5nibi7jRpx6uHqVyV73hDxGNT7I5AnumD051mhpt5Zd/G9d9I736zPdfCbIu0VAsYf4OemLu0GDGSprDcDS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377367; c=relaxed/simple;
	bh=+KuFrIoK+JKid0GiEO4Fq6Navp1oBhyJjH+iKBLjkrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j7jsjCGX779DzVVsC2g6w3tu5CuaM0gWrq0h3e80AysgqtVuRmvJEx6nET/V4ZAXMK5WvFZS0LZOipPEr68LefRYFBvXu6Il8uDEtl91Dn39bU0+Y0fbhaNGghIQruhDCjNbzMcJSiZ2cPanfaWz+k07QtnvuTHzqzQIPQClIV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K/0J7AGb; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvM/OTIk1VyuS1Xic1/k4EEWpRhza9/XhYCXFbed1kUeP6R9wVncUBLOw2BGgNPe7Q1pngagTmGS06majLilpcDOBVeO9udv5mxcu9E2v39WWP2uxOi3dwhuehATy9q/uV1yJGBNdsfEr56xGPXyrGc9T9/9flJhBj0Q3KC7IvNNpeOB9hDtnEUNpgMyv/NrF76iWfMGQY+ghaDA6A5gdSVtNBgfsMWshvzACdXyYbv3uGbr2vhXEThuJ2BseUVPRuOBuGQIrlN98WfyekEfbdZ3Upt9wLzonBW4WIgxi4DqkiThNMnNDFWy+Nrl4LB74/IbNIaKHEYxRmgtUmEsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwatvWvI1AHlLVit5qiu24zp44U2wVWQ80MdufUlSxo=;
 b=vhqqjDWQE7KottOQM1sKXqNME25jnuTOgclZai5wjx1272cKYpdrN7vX1Mj2LJMjJoM/fU4taJ93AtBXl2GFAYVkwo3QeQuQvALvDACG2OWaBYMMJx9n903SKW3Va8p5IMP3D2YB750t/sl7Qzq7OWqm/2dPu4yOoiewx0Z+mqlpOYNmq7IMYYAYJB/a4BsFivdgnqqnpDH2npjL0Pou8fg9ELU7LpJE33Z/+GKWQfBIhQpa9tTqkPCFQifIg40/quiCPVCpczuwIW78nBzO7mP84417GZwmKFgdo0LcqAu27zifHCbbVObpwkXou4FnjB92vkD4LzlR276C9m/Wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwatvWvI1AHlLVit5qiu24zp44U2wVWQ80MdufUlSxo=;
 b=K/0J7AGbL5UXhF+ywtanU4UmE23QmvdSEWD0g62WtLzH4uwQGR6Mt/T0D+6ka59ELcuBnM5kzORJqrOekJkwPd3k91LMwwz40JOH/kkjfT//xR0y+6b2RFsZS69p+7kAeWpJA/Qxkk4MItdevIiuSto4XE5L3kLxjYKO8oUtyOCV2ScnZq8XCiykaGESMKlO/qawayGlFkaUxjSWpRXXcRHkpX8aXKFWUJcJaVfUkhkjhWIgUB3ktK3/9D+wmr2BR1CI+rc4qQjwIGr75AUEoTEWNK/jM7dsyMMN2ZbsXeELtWLaH2+yDvdPeaC+PYzMHBtDAxFyInB6Q3RdYNlB8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS1PR04MB9309.eurprd04.prod.outlook.com (2603:10a6:20b:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:37 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:37 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 15/22] wifi: nxpwifi: add ethtool support for Wake-on-LAN
Date: Mon, 17 Nov 2025 19:00:39 +0800
Message-Id: <20251117110046.2810811-16-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS1PR04MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3275fb58-6e69-415c-b33f-08de25c8d15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQwG58YYCYnPWWEA9AwsUL7B8NMPa6fa8RxtodFkXihe8ib0CJEbDNYoU9pc?=
 =?us-ascii?Q?70PmW0JTDwUfdi3L6wmVF6jQgbIfA7tbgq2BLz3sUqz+HExDOTY/qpbCDz9t?=
 =?us-ascii?Q?mLAevCo41jHIgrO0s8hjvkRr5Al4ADFNsltu2vC7oIGkZ1FBp5zlZWk7AuCy?=
 =?us-ascii?Q?roR0HJSmQ7zqNs5mhYUQ4ZKehHwSIcXcRkPLgeopTz89sfLeMuSo+WZPqVDs?=
 =?us-ascii?Q?Qb0bf1UKaPYIqk+JDfupMnbrG3mHtb/Haa7iqY8xUPMWwDcDFUehfsrK004V?=
 =?us-ascii?Q?eWgiGvU3/WufaIqQyKP/IDk7vuurqB6o5hL1dGt1DxAVzENQGRPS3lhldXyp?=
 =?us-ascii?Q?6w39FThtkjk/4iSDWEoW+yh1/rUKHOSku7aS0CO7U2NugYkOH3olTUe+GP4T?=
 =?us-ascii?Q?i2CNbpd9GDC6PAx8Fby22ndOfiZEyFGmCYWBQV5GnEE8nSiSC9nVegyg4ZWz?=
 =?us-ascii?Q?5O2VkKfU6iEbVDaKG3DlJQtdXHD2CHBtzKH9Qd0AWomn/H8IeJPM/EHTvXQz?=
 =?us-ascii?Q?4VC79Nkb2dIgwIUtyFykz/oyG+ZAcibrxg7IjtGsPLNFwUP5EIAO1S0t4iwa?=
 =?us-ascii?Q?R+JkoeNAJHgfH4TDAqzYNdKYYrI0tnHyXpyuQyrlXajycjv7Ccz0cbg+bkOP?=
 =?us-ascii?Q?LN3FdhIcD10is2sNKKclTzKUeOc3zQ1M5cWk0Zwf8czqUq/vuTa1+vFYJ/i1?=
 =?us-ascii?Q?GQtr3hJHJtkF/N38uiAXXrfV4pOniSRh488118W77bCNf8gakDamL7Cl3APA?=
 =?us-ascii?Q?WzAcRoOkdNaFEXHnF0jaqMM3Ctu374A0sn4LEgZA2mjy0LUTCG58NEDgkHQ4?=
 =?us-ascii?Q?DyEZwAE8f85BsLy6aSjFIAQhJn/Q+4T3Z/E2bYXK2+7dZIR7LJidwX8f1p0W?=
 =?us-ascii?Q?85EckqjRMwBqYeBjK4soXz9zlgijrKGw03OwGLRPjqo+maH39lCSFnlVj4/x?=
 =?us-ascii?Q?JjAvJD5aUE+q81gKcWua+JQ00o1sy1xmS34WosTRRxFRi1KU3LQSorUn4Nvk?=
 =?us-ascii?Q?AaXEY09uzKsVFzd9EJ3IGqcOt/juSIWq2twOpoEGzx++J0BB2fJxEIjoFUyM?=
 =?us-ascii?Q?v1Dx/ahCaqsZhqdEjatu5P5QFalzd13NO2tBAYzlETF3OxvTo80WPIEy7hUa?=
 =?us-ascii?Q?A7GTxbHub//TmrTjPr1doewAcERHM/pH7NwW0eSG/KKs6joLsqty0fdJfsOp?=
 =?us-ascii?Q?xDHNmyDqhtDjdj3CFzJPiI0wf4d/krPjxqw9SWpfzgkObpyFxjbq42SbAnKW?=
 =?us-ascii?Q?YiEYyoXMxyRfvWzjA1WF39Tnyqehx4a1xfpu4aVcxwmH2y86F0ROFBCwILpC?=
 =?us-ascii?Q?zuX40U3+VEeRAMpl9DaxiBJMz5IzPOZgtECierNYqfkpmswCFXFBon+49pIp?=
 =?us-ascii?Q?GLUMiGIQeE5tkudRHceLZsIuQJAR4Q2MjeF6rqxfvAnB7q2cVo1meytJeNQT?=
 =?us-ascii?Q?C+Lba0IqV9NErGOFAKMxTDOT2vJ0TTUZxTNw/1wGt1flYmGRaZejzj6zT0Qa?=
 =?us-ascii?Q?P+ZmifOZlNWo8f2z8wyfYVDY0SlCyiIAv1Xl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kp7zrK/Yk1ZAIGO8B0Gn7PfKVT5cwN7J/yJuBfM8xWQSbexg6tFHojMu3CiD?=
 =?us-ascii?Q?IWmrfduvEg5Yc04um7yRHqiy7/25ivS8pJSC832bBT8Nbp/KqoESk0JqyBHs?=
 =?us-ascii?Q?dpxLnqMTysVvWhAvE0PMSYQPQyXqFUnb5mAyHxFShPTvp8DzFOCMNXdFdofy?=
 =?us-ascii?Q?P5Kro9eA0lrjyu0rw+2Dcz3ion+rQx/Of536CmjLxAxOWPAhFv0ToyO2J0zA?=
 =?us-ascii?Q?/Qw1GfTD6tVlT0S8uUOMuowcQcl9o1TF0UrofRUVA7DnN3bXaxxZuKLOWyyc?=
 =?us-ascii?Q?3QiwVwq5N68kbwhIG1Z9rJamLaAO+H9s8VmgEWuyJHl3rmqLWTxDS1VR2dIF?=
 =?us-ascii?Q?Tsf0pRIGeNOUDPoZLSOkM1zMzphw1Kzb263S3hMQxf1lPVqHiGpL+EQ7zVJ7?=
 =?us-ascii?Q?0S53tnKgjDBkPbVhe3PX8UAJwaHGVmTRqMZy6adxkPTa/sRxgMti7/VNfk4C?=
 =?us-ascii?Q?qOSI80Y3T5mHzuGnw/ySGAJ5YDroYI9DaHS/pBQugx6wUlUXzt41VsPCYG3U?=
 =?us-ascii?Q?0Wr1Aq1b2/6Ua4updck2gEJWWf6KvtKaS+7o+HfCpLVqX9XQ/lT46QtYmU4D?=
 =?us-ascii?Q?2gGGAdtHx/JmK5XbjdCKzR7kEQB6fnyayvrp0dO16xVB8CvCwKYzdgT/Yswb?=
 =?us-ascii?Q?ns/96Cy7IvT4/WiO7h3C5Mt0HcCPdhLDWiJErpiag6PgOCJRJtckcdZ+DdN/?=
 =?us-ascii?Q?5PIKDdQcbidRaA1pfpbX8KFQPc0n8rV/XM8cXRuyD0CoC0Fl8SdPUwUB6Uu7?=
 =?us-ascii?Q?d9SlXFmc+xRDpjXfOWDzJlMFzQlq7o3YR2a9JELfYlvIy1TvciEUNtH8vTQR?=
 =?us-ascii?Q?I5SAubldM9RbTt35U130OeaD/5E5WbPhLnG/gzGvuhU7zTdoZBVFLoJmN0lX?=
 =?us-ascii?Q?mwi8XcH9Tuzn7F4iGioejDoIGef3a2xDSO5hD1FqDVQUacV2xlEuxOpkdox6?=
 =?us-ascii?Q?CV0f6k/VjVXfqbzWwUdp3Ca7iwPSbIrsQFxq2dl38fHY9YVWHxqdZyweSP1t?=
 =?us-ascii?Q?68QUAEA15U1xD+SCN2LVC50Z1fB4C0sJTG9OLZa1qQGzDu9FcEHtIpcqGVw4?=
 =?us-ascii?Q?OYBf0fooyu7J/toePlnUbGC4tjnVyDtgL0vqBdbziKdxYHLYJr5aMdm0vzvt?=
 =?us-ascii?Q?FildB3xnmnjjCqUf6YMfhdPjxMD0gQwC/wCw9XZNBXbVRPu2POTcHnk8eYOG?=
 =?us-ascii?Q?+5Vda4Zd+KF3qJzWuOtHl6imMM9yb0coXaLsNtImzaLHDeE65bgLneOaOpmV?=
 =?us-ascii?Q?F3soKem8uuMOZreWZ6GhsEsQdte/+AvgEkbIVi7XqPTzhQM6vU39ef4ELZj5?=
 =?us-ascii?Q?uUIN4nIwCgjiiL9w+YCCKl9tgeVxgl0S18uVRsaaReCRdCYh9zCQub+aFQ1+?=
 =?us-ascii?Q?w6cdbedJ0WzlZVQddrpnrsVPA4mP+oKi2UTnah5lwmYLSlKdegiToFZ0jEBh?=
 =?us-ascii?Q?Z/qap/URlSjB504T9f68mLbh9FwfJiQ9bbKqvmIjBKHqBvGzeYdHVNofsHMt?=
 =?us-ascii?Q?q1xYitT17S4BCoc83YyQL6XecP6FgNx4lbPQUX50QBSugRTs509naUA1k855?=
 =?us-ascii?Q?SbB97601m6vRFT8tIjE7Oex2TUBVUTdIVNz7sFO1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3275fb58-6e69-415c-b33f-08de25c8d15d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:37.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEfqu9B9gAXvByd0ST7oU3a8Hr8MaQqd7KrIgHaI71tzyH0vuAjVBGKfIoKtrJD6fbhCouOrvdh7wvbkYnVZPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9309

This patch adds basic ethtool support to the nxpwifi driver, specifically
implementing Wake-on-LAN (WoL) configuration via ethtool.

Supported WoL options:
- WAKE_UCAST
- WAKE_MCAST
- WAKE_BCAST
- WAKE_PHY

The ethtool ops `get_wol` and `set_wol` are implemented to map ethtool
WoL flags to the driver's internal host sleep configuration.

This enables users to query and configure WoL behavior using standard
ethtool commands.

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


