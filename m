Return-Path: <linux-wireless+bounces-37432-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l0oYEqH7ImpTgAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37432-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:38:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA678649D8E
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:38:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=oMql3ZDU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37432-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37432-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC6F310A95B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840B4F798F;
	Fri,  5 Jun 2026 16:14:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C64F7981;
	Fri,  5 Jun 2026 16:14:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676075; cv=fail; b=WdhOfF1kSJqvSq/rmD5eOFVMXHNZ9itXT/8t/zSldAIlxEbZE2O3lHNYw4JH7EEFEuu7JI0hE8xeGa6H5WgjbhzHy8Yc3Yw1UCMnehwght4HHGfOkOArHgmXHyPnPYgUSe/3j9kQW1DtF/Kketdt86o5uPd+pBc82wXwPsj7+Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676075; c=relaxed/simple;
	bh=RlRs2pX0FAkMQdf8gqc4txc2bZ+PxzsjearMroatKf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ofIlw/kkzGqknvGTBje2uN9xLejeyDXW3/CMmEXPwV3hJSQB8tSR1kSmGAH4wsKwlQgmvKuBgTYheRrcZ8ik4AZRr3E12slXM6yHypBBx5sARCKYO4y5wVkJwXG7pWEaBHwEyWunoFM8Vt67oAWMgmGh150uAAjoqgqWW+0qGeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oMql3ZDU; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn3JjwHFRSKk68PVWvN5OGs3/SaXcdMvSHcWcPKfEHgg00MNqQ2UCk1Sw0e49QLgDzZ+TYkAP3Q0ZDwtlhjZaDMMfjr5aAOkJdhcDRpdwiLPsyyMHOqiVDTFFc/xibXoUOgpjz1Ez1JNlJoympYhB3rUmuING1RtRAdnWLzn/XXjc5kEP18pTWNtCq3pfd6sElgV0S6hldStfboz0UXIj/uW0RNU5w/A901R0rTchoxDUdTdWodRwyY6Ta5/pFaQc4BkowvhcRiUq41O1ztQP8UPPOTsiKoXp1R5PXgaLtoVsVupcOVmJEN6HTFIFRXaeUD8QYsVHzUEFNNXMBuRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pohgcI16lIH88jFUObaCtPZeiFC5TenPzwDvYAj66DU=;
 b=f3+OUX8SAJy0bpIXVN9sysaq6GTGQa3TnFToI7XzR+464arUL2YrgwXuHpi9KgmIQQ1dsPegjnmWSlKHuXEAD1bu+IzRKp628IywG24s9nlAM2VlioQcUHWAuB5SWPVTjgJGxi1dPnPdQ+Ano2FG/7yzalaMwVlISHqzhuL8TxvDjealS9GIAe4fNkhLHU7mSneSpsiBGBxvHX0PRHlA8Yj3X1xYArEMT3Muehcii93ZnVa40CfvVT75RVqdw+k9lSwoK7TbTlAtoA7r1CXDArxMOTs8pXaLi0zuIUAUExN+rnjvY1DwjsTJgeAAFOrNu7shJFyWalNyAqJFJla/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pohgcI16lIH88jFUObaCtPZeiFC5TenPzwDvYAj66DU=;
 b=oMql3ZDUYf142dROcvbDLLJKiq1RzTwqMPWwlE8/RWY8ym3X2a8TfR+GP6ruiqEM0PFHQhqE1rsSTFdKaC5aMSIkN/YHofqb60M9k0jZoQarl3ytbVNMx1QWlSUrmPUMTVewIV094ZYbvbJvGCQ+tWN63mPw9iSXqyafS8MQo5CETYReAXXnqsmCmN7q7mg7ZjntLHC4+U9YH7d4WlhnAXpGx5+nTP5EXFFgwzQrehkWsYfelzzb/e7M9UNrd6BkPEs+Zi3ZF4hsjaJ6rLXPk031GMLwxFdU+aZEggHrlwpzu86sYp5OqwaziDMITJna6Yc5THPWsmjB1ghI9ZyZ/A==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by DU0PR04MB9225.eurprd04.prod.outlook.com (2603:10a6:10:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:14:30 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:14:30 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	ulf.hansson@linaro.org,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v12 15/22] wifi: nxpwifi: add ethtool support for Wake-on-LAN
Date: Sat,  6 Jun 2026 00:13:28 +0800
Message-Id: <20260605161335.2415583-16-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|DU0PR04MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: a16ae472-188b-4151-dd75-08dec31d8510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kK4wjAjo+3YGRJjAUNTfC9g37DfnkOHDmhIXdi7hNkF6m6D8Udc/LfCB44bSuSDVYvutnm4eUeLHgY1auaNB03uAZp5jvKqqVhuLA74Ez9FcSovhf5oQNqkFovy/DzccmAUbVLP3R5DQHVVNOzfK4oCarwB8cmF/jVkAdi+1IE1SGMJnTirJk4gi2LxyAlLnv+nttCWhyK3198saF3Di/v4YW8tstMVBfG0csEKWR2pnQ7D7GrhOC/CGProbpIsPRWltQRcE981Fl11AzWb5go/JZzyW1pjXKLcLFxHNhPO8bG6P42DdZCx2iy8c1vDAu5KFibwbqzEjb8NjQRIATkJXb9xM4kYr+ci0QeMeuDEiigBIf1JNW0pEwGAb0rotUnJiPrhOn6OnoqqS0d3m3+l4rdO1YoZiH/ZCeFWbn3UZ7DtLxjlQqAlevHGhSwjXOS8WWf4dOmVXNnviiG56i8HuW+zUKlHuepWLK3Ba/gci3dmIH1PQsxp/p5Yt5/Tc4nQlURcO+qikYG7HbSCtAQwg0BE/xUrfDO3Lq6EM6prknscVJiORLmAAFQe+ISft7SHg3/ltiMfEBRjR9zXqX5AUyMQmQs7KsToPKq8IXDZgD4GtOm56owtCiwn95uTOgdailMAioBfEINLe8OYdKEIOKlmCyVVqBVocjjXsWaX9ylM7HuriH3D+41EtEgTRYuNxVjTqsmBCJGUznIRjeRFLpzaKLB9U3qQvAIYxVmuU6Zo6m/mrgrAXLkLKwVpt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HeuSieQMvAlpZ7thg/+0Qz5lo/p5LaLZcKFcCtwNRhRsgu6DtpBYLbk1Nbz5?=
 =?us-ascii?Q?0dmBANG0oROEyzdPMqG0/MC43Xav0tevlu+GyAdR3WkG2IV4rQv8miAa7iOt?=
 =?us-ascii?Q?K54FVXI7zr6b8JJnjGiLUq+WZALqTwj4ZEe8MLaMsgip2eAZ4XkdqmecaIK4?=
 =?us-ascii?Q?Be3pikbtS60uaEVlhVFINo6KBRIXv8MC9WSJS3x5UVTh175HLyuhU0MNvzGg?=
 =?us-ascii?Q?H2V0cB7KNDQ5X7KJiszDIKkSqqMRb3QbQc4AIxRs93o88l1woaVfk8jSovSV?=
 =?us-ascii?Q?Q6u0xmJQlOD7R50DeBn/hXhVpRV190mxYy0imRr9eJqQBEvv548bUYjS9FWY?=
 =?us-ascii?Q?gUgquLMcEXnV8mGra2XZv1uM7zkzFesr/G+SYKeIb+olGDUDyz2fmEeD6A7o?=
 =?us-ascii?Q?XlUHohDuYNA3Q4NVLr80eIqnJq3vKlAZ1lFomYwXs5jA9dB8uHlH2xdR7+Ow?=
 =?us-ascii?Q?Qq/zgkWAw9p9jTfogWOFgj1a127zcG6ZapNUTknzkRvKRdy9bWbO4YH2Zq/L?=
 =?us-ascii?Q?HZsCZw6ox2+Rxf4dEaECQlq5FKaU2dNGL1bCGJ+9RbaLeNiSXxcPLot+MdB1?=
 =?us-ascii?Q?XDVSR+Y2akzfzks1GRbgQgPeiz1mrXOqXAPz31Uad/i0U1nyFft0SgEbc6p2?=
 =?us-ascii?Q?QY7fyVaRcW2qepDYXWdFHNHAVkyo069gQf7x9gJ4HfMoqMyGG6NQukQuqScV?=
 =?us-ascii?Q?8sIxNKMBGHs37aEeVIqBdCLq61VOCL2qnaYBZaz4OWB8invPaRp1SHFpmVbN?=
 =?us-ascii?Q?SshM4PSePp65XpF7pXEklo1O0ryheMD1+YbJpUP6EfksZ+ziWkwemTmoYC2w?=
 =?us-ascii?Q?lnxVKVUPw0759uQjaYnIn31T4L6+swrcekYJsOARVwJqMcB99RWHlK7u3w7Q?=
 =?us-ascii?Q?EvEfE3B2eqFfOPuIWbQ6FFhWqzJ1FGaSqXDakzcnn02JmszM0YClB8mgpCRK?=
 =?us-ascii?Q?08CcP0bAkxEOUM+FZJze/yLR4fLeG84+FL/ldWUp3mWIJUWRzzLPhBAbfJsc?=
 =?us-ascii?Q?uD3+c6e39lU6R9E0EJbMCiO5MWo10hCWDWMUz+h2dDY6x0cFu2U0Mz4lY5B7?=
 =?us-ascii?Q?lCyFWeCOixDy3uMIvZrP2KLpy37OrfX0gSxKJp01QKPfr+I4AVnT0hwwZ8Lm?=
 =?us-ascii?Q?RiQCZCuOFOjSZUGQG5taN8+DA4r2DramU7vU57ULgMrDCER/8Jl656im6+QG?=
 =?us-ascii?Q?jhzo+CZ2bVycHXlafyKFkgGekeIKSzUGQZEaiiX4WSzbdc4D4KQWj1dRiZgX?=
 =?us-ascii?Q?GZJZta3KlHhbqjq9HWpOZANQ5Os4/ZcJd5NkzwE5vNR1igTigFXIIyQ7+tig?=
 =?us-ascii?Q?HiXjU0E9e5AZrrMAPgyR5GOD3nRR4yFFQs5lyRUmAUVy4xkXfAesoINx5K/L?=
 =?us-ascii?Q?0Ffu1vWaL73ejcdKwEUwTbKGww1I1I0bJLLnPyTL7vLRCY6WI5wSiUfyLr91?=
 =?us-ascii?Q?ik7R3dcaBhjm7SvZLuVgN+HbG0EkoQYRst/ERLqksJr1Ywv0xEZfgk6chqFL?=
 =?us-ascii?Q?9HMFnhKnx1sktpvgI0tC6PeclG1ShF6Kzw+doepC5NF7jhw9v31GUeK7BNm+?=
 =?us-ascii?Q?GCKLXS5LNZVLulvZw1HmOXfqzIgo8sBdUZRT6dTDsHU3q01+6cu02/DHzPE6?=
 =?us-ascii?Q?5Lem1ZJXDKo77e8RNAanZ2SaJJ+D6b0J6y/BWeiByOXaJl4s4zWl1AZL8Cr9?=
 =?us-ascii?Q?yhZTI6pnBT1oqzd5XyDNl3JnL4V7aEWf1uFjVayYQivwFqOH90EkcSqB929F?=
 =?us-ascii?Q?ohzSOs7tGQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16ae472-188b-4151-dd75-08dec31d8510
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:14:30.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHnDk7YxwWLaAOnWoRDlGF0X4BW+u2WFOFxCjUZRvxrG0HUeSHYMcCzdY6EoXxkv1xV/0irjTash7oo6423ytw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9225
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37432-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA678649D8E

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


