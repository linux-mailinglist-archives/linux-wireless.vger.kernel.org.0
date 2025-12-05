Return-Path: <linux-wireless+bounces-29520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D08CA64C6
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 08:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D3C3188E21
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 06:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564B2F60A5;
	Fri,  5 Dec 2025 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Benh31o6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121F2F5A0C;
	Fri,  5 Dec 2025 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917881; cv=fail; b=tc1wPIICSxKJnX8AZnuOmiZ5iEU/ADijipk2tHoEBe70wRhBc6ZD7vlPnbgGos1nu2sYiot/xAA7jrf/S8aGbwWku+3+tRudHfHIeOA1yti/G9QjP5E6LrkldSCj2InLv/+9t0vMRckPVtXNHO78/QZXG85eiywde/EA8Eot9x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917881; c=relaxed/simple;
	bh=+KuFrIoK+JKid0GiEO4Fq6Navp1oBhyJjH+iKBLjkrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvssAs8p6YfibwmmBl9d3NI5tC4rfNp2f77yYviyvj6n0qM7HqTx5StQ6V1VHV48TZWtBQahgc23EM4zkujE1piNN8XUR9B9yfYRpnfqbzvA8kU5FMC8yZUu7BuQRg0GS0n0mrIsDFw397u2XGSrknQoSPxdv2IazJZIs07igOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Benh31o6; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIM/x2wa75/M6+Fq8AqEiOTek8HrAnDz0Mg8mVot42FY61I3DWKBTXeDdWCYQ94vlPrhTScuPPvPITKs74UqWj+GvcP5DIwfW9ImMIdI0wF6YPOusBnhMe3Un63Er4zYKbOK/dY8wBcnnzAvMr7Rqaunmt5nWQuUX934FLDANjSf/Yfuq2+peQ34ZwC6TpatiXXuB1H6Z2H5woqduFWWU5ygV5CcjTIj01BmLc945s6DhnyweimgVaxB0xyGd6N/yDkrxdErQeUyxmMXEBY6my1geY5Jr5cj42mRJWHa7B1i8CQlWfbpDZAN5v9gtf07RfGr+OhXRNU1FaQxG7kzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwatvWvI1AHlLVit5qiu24zp44U2wVWQ80MdufUlSxo=;
 b=KwJj0vMcLm8iszSriz25C2eNRrvdmevgtZX13qJ+xBN2LRnMx93lzFTDbkn4FjljPJsHMFeYRkdfLYFK/qqepHobFBvhgKejSkQcllbaSCYndw4o9UuK+gGG38dOt3Rd7f5CQw1NWIdpiNpyibwUM5gIXLiiLXcHBbotZQ3Tc6wRWP4X/s6OH/MWCLnu6G8EVXqJFurbFey1pFSe7WhMLVkQZ9PlVdReTtdq+SZp/gQ8FzCwfchnkiqNS3QUFFXRIVqYwnlTFKviSV2NNW/pNS+juSIWPegkwOuBUdBUo3T+EOWXRbzyak5RuZ7l+1JWeAydzLT7wryVVR7/vlpTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwatvWvI1AHlLVit5qiu24zp44U2wVWQ80MdufUlSxo=;
 b=Benh31o6DCtDHiMOBMU7YOT9u1gOKhI7gRkJbCu07iNNDB9HqlZedQarLK5OeDHLwHgQM7wD1ZZJsvabRbj7zIEM5rFqJk29UqppTCEteb6BG7a+bazJPoh+7ahONayebvxOgFyUMI9I1moYaKlqv+GOks063yyRxmUxbvSCY+CSv+37jl9qQQ7Oz5QK5pJ/OK0eS4GH2P9NBtQXkPloYGCUU1NLyCQ1Op4B9Cmwlz0NHERGtWHbj1+hbk/qiH6XErAOpw4jlwn+FmTMgWlSZMOsDm2Uor2yHvR5qfFu8yKrm4qUn+5+PCY51V0rm2QMmV6pqGL2DR4ZVlJPi3+lWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:57:47 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 06:57:47 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v8 15/22] wifi: nxpwifi: add ethtool support for Wake-on-LAN
Date: Fri,  5 Dec 2025 14:55:38 +0800
Message-Id: <20251205065545.3325032-16-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c744b89-1a73-4abc-b637-08de33cb992c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5cSRFfBWPWTCfdCufaU8+XAQtuPPF3fPkGEohxCfO9popgNEp6pW/UGPOGhs?=
 =?us-ascii?Q?kXp+A6EKoYma2Z2817jXEV31iz49GVPGGZCyYfemzVkH6hSFyEGzroPV7nok?=
 =?us-ascii?Q?B1KtawtKxfq2vVLthNHwR2jIcgYbEXL5DnxNXTE8o5CZXSiljB9/aB0OM8EL?=
 =?us-ascii?Q?+96pM1wpABuD7mQzZEsQ4xTLtXJYA3iNwavdhb9QD6tni7ebowMbvgrimxW2?=
 =?us-ascii?Q?I1w0aZ8Qj2e2HO7Uq3d0qU2E1MgcRRGh5/htiGRI1cG+PBWNOO4hYq6oczte?=
 =?us-ascii?Q?8L7wi8dTBQpNiTYD3kHR/eJq7Z47tYGBqHIwjT106s4p/YagEEpufFPf9Nfi?=
 =?us-ascii?Q?JY8kiq8Kc7Jz58K00K7n0KqvXPUWlHt2pq4WX1o/+neb3rM49oATLe0F/TV9?=
 =?us-ascii?Q?GEFP8v5WnkycK8yjEsFrj5WefahfpKOZ3s7UUFEnWmB0jOkf6+wFHe8Hf5Ma?=
 =?us-ascii?Q?O0FPphYi8XVfjq9TH7zt7mbbdV5A6HSl7vZSUA5c7gH7fQlpx639M19dEC5e?=
 =?us-ascii?Q?+qwvGIlBEP9/DDj0w+FT1uYa7eQT4PWJzUlNEtWLmTxbRrlw63uuStNJ1WrH?=
 =?us-ascii?Q?gAkcKRz2MBoFt1JYn3LikfkkD1WZcly8eNjmdTZtJSV5MAlmc0TTDxPaad58?=
 =?us-ascii?Q?mtUr9quLI1aA0ybXm0f36kLmEjlnoHL327PE7HRYf2gu3iHzZBSf8ACFTIW2?=
 =?us-ascii?Q?FtvnbExEXtZgH1ilPt3Iml8A2LTNMh5Ho2vbJT0zAQQW75iWonZZq/RSewcS?=
 =?us-ascii?Q?W569tu3T7V/YLeFF3AKpY32QvZDi4yQlHUq2bix7YKl2mlMoLfvF76l5xBUN?=
 =?us-ascii?Q?imVCryeJNWSVNuE/u3a5JKHsFcm9XdvQd5Q2uxPuhbaq+6NnOqxlXstZKu8c?=
 =?us-ascii?Q?EUWEduS0ru1SZVbzvQZLRfQ0djqbJ2yj8AKWKwjxoyPtDpjpA21BF/hpeXUF?=
 =?us-ascii?Q?sQMfYvK45pbtlErvt1TqhHZEdFfRtI5letsSxpc+RtOT7bxPqKPNEdWO+nOS?=
 =?us-ascii?Q?fNBIn1pIY5y2wmZQuXCO6cuIzYKVyfkLJm5nKBnd5xR3mrwtDqaf6I5rqXwq?=
 =?us-ascii?Q?JodCBWKIKb/MR+3vMITJOBOgx9Qx0ckmxqI0PmL2tPwnBRX4VDORyNFFhZDS?=
 =?us-ascii?Q?gRChXOKW7jCT1dKFBkhhzaix1qbJFfjwCXJtXrZINSpz2NrwWHeT2MJmXwW6?=
 =?us-ascii?Q?J+Fima63E/LqKIV6TGzWzcprO5NCMeIXbR1eelC3syYPKnquwb9wGFn3pPFu?=
 =?us-ascii?Q?eGIoW5GjUzGJ3bbtgIBERgOBDM98eQNIqcPVOpdm6j6jCtiGRxkffkQztblx?=
 =?us-ascii?Q?qy2MJ8SvTHEou9lPGWLtP/zzpCHqXrHtP5NCH9VHjn6X9I7x4oiKs5urKPVL?=
 =?us-ascii?Q?34nkmsCXgIzQJn4oXWb1pnk3IGg2X9AybdraQFaJ20sMQZUDmsrzoUsVO698?=
 =?us-ascii?Q?Y38RnVchq7goDPXKwDqiC82xeE0LVBp702IOd+uBf9+IJa/hVypCYI7s89KL?=
 =?us-ascii?Q?8IEh+WOfe16PnthLGYDd/LLdVTFcx3WzWyv3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vYfQqSgtHh70PCcv2JfzwUuOVAh80wBYziXeVIdaEHStEH9KZ1qLBnHen9Rb?=
 =?us-ascii?Q?AhHTBIM4RuvYml9JDd+a1CNk5A8EUqcOu6Kn0Lsrh9e2NvPtEIXvIfgi/0Ag?=
 =?us-ascii?Q?bO9Oy2SeiL1i/OEjWDf3P/PW0Beem6A5ttx2TirD03P6VWs8GTxu5uuTFZla?=
 =?us-ascii?Q?T2xN0M0eL3DybrjrMKslU5uE4HXkUiUKZJR0UrUg7NU+66Mt9BKLRbPIbtm1?=
 =?us-ascii?Q?km4eJaUt/x0/Y74dD+knOXXVGgX2Cu8fQ/2VL5gWVfjszD7ZNVmzihFAVWeB?=
 =?us-ascii?Q?jq5wwGj1oaqEhFvu8Sbpmtwv2EVVOtz62dV1OpPGp1VzoAPRMEf9wetg+ulC?=
 =?us-ascii?Q?8cTt1oaNp1/9cvvb55BHoq9p0jK729xsc0G0xwuMlI+4/F2gnPQWDsRdWidu?=
 =?us-ascii?Q?VEHt8X6AU8Kx1TUQrY7a55oUmKYItTs//VnXzd69VVvZMbIqxTBJEaego1sZ?=
 =?us-ascii?Q?YF13oAHV4C6CbCXXKuFSlTKS7FmgiUprJSPuiIRUOxFhulrX/JTY+QklUe9p?=
 =?us-ascii?Q?4uCbV0SgjNRFOh8qyCwN1JVx8hlNbjRr6CTFG4Qj/wsTNFwQ/KrFLsb4mZeu?=
 =?us-ascii?Q?5AKAozI3DN2ZdiWRhTpqm/T6kxf/DHMJOIkxDU2+EQ64RpZqtN0CYncVbkd/?=
 =?us-ascii?Q?Q5w+oJjt/x81RaVk4V/3h8IUPmUdAMwHC5kd9JDH21VSOXMhfSOw42bLYp7A?=
 =?us-ascii?Q?EhLygUSXuriMhQE+Zt1ul6kC/N5JZHPtewsJ4DK0hg5rlk8S2q1A4QRN5oAt?=
 =?us-ascii?Q?rm6XK/rAG/AFb7CKtNxJVKX1Ryqd5ZgU/b2fmsCfUXkWhc+7eUMJJJhPag8h?=
 =?us-ascii?Q?aU9Gv8wKuiQHtD7cDlJ/INMXTQzBNAdnYSAsLTBwTAc5NCxuMBq6fO4aUcuY?=
 =?us-ascii?Q?4Iqnjw9SrNJJfRzS+JoWs+AN+TphbAh85rNDH3NVmUrS23iRFXMlXmheO6Zo?=
 =?us-ascii?Q?yQT57l/QkVhqmAfv9o5G+TejbnAHR6uAWP4yJ4zQ8o0s9QjKk45z73Ck2Oi5?=
 =?us-ascii?Q?kyuekOyAle5IgZRkFp7+2JWwqZGF3bRyX/9PkStzev6lBr7WXFkgRcwL75MQ?=
 =?us-ascii?Q?vZXHYPtCqx+rtiEZNrPngrfjzUWRb/DpzNskEHE/1XTmSZbXB1I9nJkII+3d?=
 =?us-ascii?Q?fGGUQVwB2qnGzy4Jj2erTa7Sv2rijeK9JdGV2USFB68QjgDPBPmWRvs9bprp?=
 =?us-ascii?Q?5Wv6l6ckfB+D03Wnn7r7BHWVYbgeUBqYVC3WbweOaDZCjz6lCbDyPFZ0GFHm?=
 =?us-ascii?Q?p/L6ILDlQ0QrK6d3Z8c6G8ZI8lXByQnqn1Dk5/28GaoTlMz3itHlwXhf6sFf?=
 =?us-ascii?Q?9awrxFZ92BrfoZceg1nBAgAgJLjHhXPKenGcZRPfCyfgMffPAAM/8ae72EE3?=
 =?us-ascii?Q?LnARKdLlvhTm7eQBLQtpCn+4xKJmmtEV8WBzl2gWZirGj8cqYrSWp55lh2sj?=
 =?us-ascii?Q?XeKw/a58Kf9PegKGakQsSetg0+Tk/AbT+AyWkcYaMzOUZ57cz2LslYrugw02?=
 =?us-ascii?Q?kqUr76JBrAQmtbLcmHTWsK3KVhqfmhisHNTyzC+K/8Jy28cgFQjQNuqQBq4Y?=
 =?us-ascii?Q?T04EjwiWOoHIsuGg4loUZfuT6OhCK4mghM0VsOa4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c744b89-1a73-4abc-b637-08de33cb992c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:57:47.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQhJcl3cLM3wpZeWlWOk1o6hunVBw79uQFscgDOchAH/lfNF+zAK8hPFgdTlrPeFrwN5mrVDNhka6gmLZS2hzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

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


