Return-Path: <linux-wireless+bounces-35524-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPs2CKgO8WmXcQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35524-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:46:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F748B50C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FFD73069570
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C09A38BF75;
	Tue, 28 Apr 2026 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VdiWgwyQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC3E3815C6;
	Tue, 28 Apr 2026 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405330; cv=fail; b=Fr1x1EaECgK4AdwYnIROuMugWyVr4xIinvjnh7A5J5SCn2I8C22mhHi4OQTZbid+HDlrXCSToTmqmz/PFbKoNlpVgq4zVOypRGYpiM3ohMQCtLi0VYFcm2xbMBOx6P+LFCkrdpGw///EhQ8r2Qn7FjMPuiVaM/NJXG7wH2M5FpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405330; c=relaxed/simple;
	bh=RlRs2pX0FAkMQdf8gqc4txc2bZ+PxzsjearMroatKf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lij9+NXuAVSJWeJ4SPp+KDfhoeyORRGzGfhx+Fe402XcVtL2L7QKdW+9HBvipjSa0v8bGOuGXsy9OmWXSzw/8MP+7wotboNQv0gyO1cHH9Qcw3FcENYJeb2ttk42xY//0RJ/QgLmX8TKIJUpBqSfsLnWHviC8e9KCCeSQUBvXDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VdiWgwyQ; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkBRyZnn/1f8TyfTzOCOI8EewDhUItT2XxWEZl5J66PSZS0ialeiNAgC4wfiOYXjRRAE+LeMIrY2GfPmICEL650raImeNTX6vb9kJ6efZlGtwroTM1aMILwdf6kEBnMD143kjYO/CL98DM963UznF72LW8rfNRUkBOGa/T4ugVp8QgHcsMiN16bFqUEiGyTXSi2yIK8foUnxB17MTldrnoBUrmZXhuRdwsWfBsk0Ix6SoPwYdV0NP8ymP8dRdvj6v3yzmMDaObIslnC7ypTPaVZeFygcAko2noPiQS0Ym6x27JZ2VqaA8HvTodDjm2r9pc7Gv1mrghzPpQJEkKIYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pohgcI16lIH88jFUObaCtPZeiFC5TenPzwDvYAj66DU=;
 b=UwnPVawNzTPsIOreXrsx61TZhQ6HKk9S4pZPvGNEZMigr3Ldib3g8ol9PGJhdbbnwFeo3eq45tc0wZTCHtqXttBj9xN6gojmimBD53WGQ0XadoN/L0iZJ8OIm2hc+6cJQj966t6zD6kDF1iPEpW5RZEvTMJfnmmOio2u5XaAGU97L9FRvxgfkLGXbDG9G558+86riXrgCKxLLjcuQPaCdKwcvOQhc/SEDm9ZccwJQS3F7+TVVio5dV31+FIp9G15Y6e0sVVInQQhvDJ6qeJ1SL9pIwoouHCCLwbanZtA990LCiwD3zFCDY8ccWkGWxJbirF35bKa+1bFkM7THIiCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pohgcI16lIH88jFUObaCtPZeiFC5TenPzwDvYAj66DU=;
 b=VdiWgwyQbWo99YswnF2SEueHaM6PWQaya01jZqWNRXrqyMYUNIHJRh4xDAroLmpo3uiwqqa8mzWUMkl7aN4fvCgLeMWG4RhvL7k5qVCoNk1+BG2pJ5+MSWMprHA9iTr76eGeK8U4f2zS6+aZvk/BappdTp/NQb+hm6Iyd+MUklfuHJ5CHXIlJ2lURDSF22x+0owzedHEng5TAz1L6BN/GBKvCvDY24Ak8r0cErLR6FNhv6OGDOTodf+Lt6S2AOls1E3hTMO2XqNwXNayxCCjcMmKy3TMdgH0LJYqHHQ2t3f5/RPTqsM/sIaK+IDCTotkXBXy+eE8CuADjoqT9xXRGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 19:42:06 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:42:06 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 16/22] wifi: nxpwifi: add ethtool support for Wake-on-LAN
Date: Wed, 29 Apr 2026 03:40:15 +0800
Message-Id: <20260428194021.785252-17-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428194021.785252-1-jeff.chen_1@nxp.com>
References: <20260428194021.785252-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::33) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: da643fff-7ebf-4c76-2e63-08dea55e3a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	on+6U+AahSCylXjFSsESMM+kg0cmVoAA3dIRUqtvyO6sfy1DtkuI9iIcZG+s+vL6QpX/TSbit984LZU5zeAEf25brfEeeMPj4ZDgAqI42Dq4BD9TjRkBFnF6PL27fZOswfC34Ga8HOipA+xCgb0rpRrrl2evP9XAmEPss6BWyxI4hYk56L0JxgCAubHV/FGkPUAVeGUbcfavKWklvLiO3XIiHt9Dsdr+dPLOY1pD01EjDpBVs1A7kkZlsVVGf7WJAkFhLdNTNNgVrkFi43JAaBUITRK+cuaj5hCLxIQuw4mp3n87Rih16C85Cya8Jr6jZ82QIqx2C34IY9qmeYRMfDlFclY20LjZkitUqFDvPemqBGAA+G57JZdX9Ez9y/d1OaaBb+Vp5NJwXeaApUGoQeUYx73+caf486GarSGpdun1/iGF88L748tElPld87cxFOqCOl0WHOqt0Tv5yTXCuk+ksdWWSXBzXQNrt3mqzKTtE2/NAT93bzRNKPTx3nlAKUhltSx83DZSv7fJziNYMtORO1X8nlDiXaZQ20xS5Yx6NX2sCCWjMl0gam6WFMNHytku4ks9b/KQbBXkOzE1l9R95kOd6Kf23y8k+PQ0+xJhWvvnd5Rs6QfZh8FtTpmqvFId9XiP+/tRuiZkxvP1ipxqa+aK5ku//AZZqaOMNudhFe9UWTLt54cknhgVXyRN2hKdOA6XpnvAvCSkBuHKcIGks3dqBZoKwwrm40bpPXFcW5myRiL/ev4+kx9AF8WWDexphyUfu6W47Fcf0iV998y/3Z0O5CFhJjsdTlTP7uA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j4g9dgPxtdnD6O1Y1aDiPl31OaeF/37jufQQYY7mYZQVS5Mrbf4LIjqjMgGI?=
 =?us-ascii?Q?ASRZTToCN2d0IHh5wQEAfLuTpcsRL2Z1CSG4OEaQTb2Jn2xowmkHtiCiX3GR?=
 =?us-ascii?Q?LTChw/D69f0FBSkNu5BjavgwhCpVmjoRvzQXurm4F1k3g/Kf8l6sdbze6wL7?=
 =?us-ascii?Q?QW7zvrudBxVdh0GQ/ZxmWxvpCDM+QncPLrAKUNUMH4gAik38W++d9uDb4V47?=
 =?us-ascii?Q?yEZVnapM91apx2NyX9B7cqg/MIViKk0BorEQlZvkJxEOLHa4F5FvkEJhjooh?=
 =?us-ascii?Q?K0AF7/5lg0R12OABnm+fuiHI2+8lm96dVaOqUMKPX+gSUommXc/cFPR/SWII?=
 =?us-ascii?Q?TkhaIH9ipaoKTHrQ6nhbk2A4ZZv+KcqGrnGV0m7SfJgYAwUgbeQTkvaraZCR?=
 =?us-ascii?Q?dkpMFg0rOrwIGeQUMlLXSYfJ2nL/PASK4szb6tEhi+poWMlzX3nzfT6IenzN?=
 =?us-ascii?Q?bcAYGDNTN28I9jPiV2JRQFgSAzvtNV0tUvw7/ODPvqAb3m66px9nKpXCkSti?=
 =?us-ascii?Q?ip6ElJvOI4u9nuDE0lSnGmrhaPXv6TNj9LNb7L/w5rAH2B0B/xniHdT4q5/4?=
 =?us-ascii?Q?U5ecbGQw5nPSPOTrmsfKdNUDRw4YXEhqPUUAadxu4XzBFb4eAyZBsvp7Ktui?=
 =?us-ascii?Q?poxxQB8Yh221jCdBESEKzSmQ5HAqBA9gUYCjXH2nbPh0IYcPSyr0go7K7CGf?=
 =?us-ascii?Q?FuocDstoLepVJ4ZFqQfzYNAeB4FzVVyhBBSRv0JZh3/lNxMPR2ieiMZndLTP?=
 =?us-ascii?Q?wjuhRtXyGwU806QWpKXCWKfepjlJIHv0Lx/eaEIeEyn540/LMoBa6zIhBJN9?=
 =?us-ascii?Q?TN/jUakXkPAcXEFZuq+q9WX6vnLrKEhkunQl4Ub7u39QFD/FEqIOR/3HV80g?=
 =?us-ascii?Q?OtsusCwZPzRUfAJ2ONRR353VqAELlahrS97qTFrFX1Zq3HbcD8WaGbFQKTwj?=
 =?us-ascii?Q?We6E/17qGPN6Uzd6m6ciHFXo9/1HX/1Eg2xRwjotBIo7fkiqWg6kZaxGIn18?=
 =?us-ascii?Q?HLPMdd8UI5+UPLh9S3qRBHPwahfpvEGnCPZhjT45pINwzDWyq1/30JTEvHsz?=
 =?us-ascii?Q?r+03o6i4cV0DiB+CxGEva0jbY+tnlbtOX4VgdEoMdO4/mfq9JvqaP11YFkJt?=
 =?us-ascii?Q?j7jaUz2bMQ9kad8Z8CjAzRNy8y+EbvpB9Y25GSI/c82VEG0ld0Cix2Bi5osE?=
 =?us-ascii?Q?Y4u7Ms3Lxts9MB/7Xk9vjEH/Ey7FJ4LU/JajXRq8wswNz5SECoxbFIKS6qBU?=
 =?us-ascii?Q?3pAe8Q7ikSgp4ELZyPfL4mO46zbW4XsSNFHbJpNzDRRPWJmYPTYnmthJMCQb?=
 =?us-ascii?Q?vmIw26xySi9s1579rujRJgdGJOAyilyVnWlBo+kh4aanzhg14ZP37qdTWwf4?=
 =?us-ascii?Q?vBWVRmsFnQ/cps3iNFK9Bb7H1w4Q7qNT2nSfSVORYIhhEzpObUezbiG6ZXRU?=
 =?us-ascii?Q?tBWQkeyjF5pxSJ9BIiuKPL+kfKCLHleUHIZAFCM/bcQolOfJkIsG8p3vtHW3?=
 =?us-ascii?Q?lMR4SIkHwij/r4ExLKCygZKbMPdc0Ka1j2+VL6T/XVkf8khvKiSDTYnbR5Sa?=
 =?us-ascii?Q?OiNrr7859vfNS3vEIa9/wRGsYr275aDLZNAUBbCewHrRwpCQE70i4i8oju0B?=
 =?us-ascii?Q?Rm1im/fcQ94KRSa4UJ9UXz6VAaiNoyx9eAfweTi/0n0Pn/cY7WUmKu76SUVF?=
 =?us-ascii?Q?lQOcUmKAo0jEoYwPLP5KO7gQVuj3JBEroXBga6PfO48bAnKSU+fsXtGVkTer?=
 =?us-ascii?Q?oCpDotBqGg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da643fff-7ebf-4c76-2e63-08dea55e3a56
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:42:05.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SilBoLNPHN/bSovIqijbVUl1PtmWKoIN0DKQ9uQ8lJCkIF+AsBbM7fLY0NJ07BFgDFg5cBuwk3QJ0/jJuXfGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
X-Rspamd-Queue-Id: A42F748B50C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35524-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


