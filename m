Return-Path: <linux-wireless+bounces-35528-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHTXFzsO8Wn1cAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35528-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:44:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F448B4BD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05546309991D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3703859EB;
	Tue, 28 Apr 2026 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mnYPjlOb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91C396D38;
	Tue, 28 Apr 2026 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405339; cv=fail; b=EEesaFeJZ2YvOHVR8D6w5f8rA74SZFafPk8hTpL4ElysPYkw1ynGH88w1xM1BReSvpsYHQ24aDSQPEPNC0p89T+mW+YGCmjZHeF1GeI9Joa/ZMBlVZ3SbpwbTEEJf9tcOnJZAK26uOrJIv6M6IVwNk8Hbq+TmHv/f3Q+KqEhgjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405339; c=relaxed/simple;
	bh=9XucLyAFRvVgb/NJU1+eGW/6xnhFeRVmrQCSf2BlEQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTRkXPKSjaSauIp2olfKTnhvkTEsLuUkHywKyQWCu9ToTYD7UzS3wgmAegsZqtajjXqg6Ian0s0Nj6W/znVHj/piE409boad2KtBkR8aPSjZv4A/GnlL2cHiVF5ImbXT2vlpwiasgyxEqbafU01ibBXKIDQqjnRcSGBxuhpiP+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mnYPjlOb; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=holwedsHOJyYgV1Sg2bnZcj5cdJzwGH1APUxQZahGJFMqJzMg7aqo0iTMODcvb62p46BL43zS3DmMqcnNv6PGzqpHvjl8cZuobMS7ru1oH2zGzE6Bo3ley3AJQNMjLCBKRPNrEIGUXWGIwwuxGBP8L8sT0dZ406/AzRxuouPJqEU71R8UbDivDNg5S0owsQJU7CGp46ITwIqdU13cxgKewyQ5Lfjv9vn7EcJkUvn58JCIzoSnmEmitdRJe4qwAkCYj7EjxZdYrlhD+0SAC/4m7WvOoqo+EDFffU4zpq5TDYBz72cTwfJMZuxJWX1H2QPQ/8ZdsEaNEkli4+d7h1smg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3HgdR2deMPEUAufF5kb8RGXpSr1HW40SPUNoLw0l6I=;
 b=H6Gaqi79oh24+G8DvxfoohBCIC4cLDw5+N1qEJS9IewRvOQq9rHIG47eT/FKeBPiYgHnwOcrlqEra1+rP9EUtTcoG/wV292lc1A0AhZThO10GtQPpRKVw4nPX7ZyGJOFktSFmsSmc7DI7EzEOmhwmXaSjDc27jAnigiZ+pbctkBP5xVjMZk9aJxlHEIU8sXRS/ib90W9u0lQIO4ORJBCaPRAxqjqXvEEMJigW+U+WU/Nr0z8tuPXi6du0pajSQ+Ku+vOnypA/FLdB56awwuZe0eDFZXSBEjVmkfeq1BcjXqStjWU9IWJP2wj0ZoJw4dfEw1slRd8JzT1JfkCiR6GNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3HgdR2deMPEUAufF5kb8RGXpSr1HW40SPUNoLw0l6I=;
 b=mnYPjlObRZb0b3vOwoAjowTxMVND1Ytj3L5gUoQca6gpjQd3mb82v29jtaqj4j9ICUFNdFOMFCsf3/K6AEaguJxQnQDPXrVUbS4JmSsgxNJZ75z8YaW+9GN9QGLBj5v9BPsrPS6zk9GLhcWawIGh1r2reVIjTmWvjHK2Ts6hlQUfk6N3CSL27Op1BflB3ZkkWruQkV2q1e1D7whYRyKkM5WGf+ND7h1ZSjWkQQrMblxShMqYssiZwN7BORJPLSc1zI/J0sSYEfI1kz7hvOoL08acLeJszw14cb/TZ9OzFkyIPlkFWuMuI4cYqHo7XP2yrfW52DIZ/FuS9aX9DqIXXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 19:42:11 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:42:11 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 18/22] wifi: nxpwifi: add driver initialization and shutdown support
Date: Wed, 29 Apr 2026 03:40:17 +0800
Message-Id: <20260428194021.785252-19-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 389f8ed6-f7e4-45a7-fc62-08dea55e3dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	n/Naj/BvRgKIyljKKzRE8umPADuQ/EQ3XdJ3XZS6w2uMshPh07r50J6sE/7lrnG2rVzXlmMmvDwg71m7YJoVEP6FDE+hm5ZScRWXEzVskMcHlc7jtHI7+WswVuSK8eXpaebEteGYDeHA4c40bMRXpgvzRzljOZn9oV9W/d+jEaQ1C5MDSwtZNMteBKZZp8DjGLnbjUUPzhWSWl0CORfYqMYQPXSoErWfvRTxlYzeO3ms4OzlTiNjPhBUbnDj7ap9rGyvmUQuHmRuof5EErGoXidOzhrhHYC+q8pLppnyjX1HLPDjP4OUAoPdQTy8NGYucN8UMeMgWqNdm16oO3ZRpAjG41lbKQEgNID03jfHqDRpiQG0tSd6612po2nOOGpy7pVfDMmjnqoAosScWBAtEnwe7ZVi1TFJbtNZKVnNoW7gKKyJrPDmrC5seitIFdfOXBqH0asbUXNjHuCUSW1O6n9RO2qOl5979lh4XbwbTdfmfmK9Hcw7sbfdmrOQGr4odmHzCUlfBCRy48zP6kc5UOP9YNCPdnVCN4Ge/c61Lz1qxXx7S1G5XFC3tqqBpoiVLNjzVoeTnRBwXTlMqLd8s4QGD2W7mbdECPv80uQrZdAgJz/zgj0CwGi/kUoFh/BEdIHZBKgD0d3GLbAA5GHIkh3L9VlAn9IJvyTj2OFHzbhujTK0J2qG1SikFiqZw3G4pZdrsHWdDNieoUuLGJmDCWNVFh6CmDrFVO5vxfz+O2OXNJom007Ol7IOjBYKcAa1MW/8nEYTbosfh/gABrJE+aCemOyh3K1A6QV1Nj/LJQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ssGMw82Irrje+YaFdaGi/5SCu3JgTUf1Ka2tKvO/ipqIgaPJRWo+DIM1JwA?=
 =?us-ascii?Q?AEwwuOOpaWzb4KDY627KZx0yJ6zvzWBtJ3whCPwiMsTRIE5Nw2poWsepaLyA?=
 =?us-ascii?Q?Q7dXUK0G3mi7+iJIXBkc0dz7YWpEhsQnWIBmVZt/iGYTP3DaS9MOpdADxlgk?=
 =?us-ascii?Q?Dlxg38akj0i/Idvjfb0p60AaKBTFvyNabY8CrVY6ifdIi9/3lsV0wqT3nEPz?=
 =?us-ascii?Q?5DAQXPPhr2gfNWOhQsTuu1e5n1uByu/MWhWxbDuLNjt5CzcmpBab6BuPGIMm?=
 =?us-ascii?Q?4IPq54QTCU4DKLVcuzti1n/BoaSYZiahQTxsAEsWh9yrjrgRLtkKWKzA3iXc?=
 =?us-ascii?Q?Xak1iir1YrCqBu0+lf6DfMEMIYSS7P4PWe8L7w5vwXBRP91XAoymPKEBlooo?=
 =?us-ascii?Q?k/tNUxPGWGzVMNuuVnHu1/w8cYZB8tD9YNW4/hsL+JMoJZ8Jt+l157RtL1fS?=
 =?us-ascii?Q?bIgjl/KkHT+vW5xCm03fHZ0ZTpF/lkJxo5gLHNJtN0H6HgjDsXzrmQ8X29CO?=
 =?us-ascii?Q?s8X92PSsYDZn/0vYSbqsZxip3IV5uGyaIyV2A/TEnNE/mNjkgnYaO+uO7dXQ?=
 =?us-ascii?Q?2qJmL7wd+iXMfAnPZ766aKGaCh6HxNdZc97NYlD8zL3b4rARyLdgJiYT+GTn?=
 =?us-ascii?Q?XlgXJ9uElbvO4U+FRGPZVkVLeZlxKj9kXehmm0WZh5SYM+MJbRwmlN0kxwKV?=
 =?us-ascii?Q?cqD+XzhlaQgo2FSBhxKRab8Ga/06lVWCO3b8eeiTsqPIkYWvIvhl7fTMwdfi?=
 =?us-ascii?Q?1FfwFUPeGFIxb+NoIkX4UGNW8lY8KzFQ/IvzOLVB6tWGwgp6eIEno/PoABf6?=
 =?us-ascii?Q?r3/08TD/q8jNb3lhUyU2QXxn2r7/jq2mhPmNW7Yejr8x9xisfxBVIAAByHlQ?=
 =?us-ascii?Q?u9Cp8AMC6vdxtdp9jokrTX84+suvsVxTQOqcFFWADtFmwoKOPt7+9PpBAWNN?=
 =?us-ascii?Q?YDy/GUPLu1NcMpHqcPfui9fdr35X7pV320qo7IsT3UvXTfOWPZwxTmDlQsWu?=
 =?us-ascii?Q?EVFmiL9VxiS2PEJuSu8z+mRzw+2BJACnjuJIkO2tjXqHGP8Zef/EhXne/pRx?=
 =?us-ascii?Q?aXcAtcCaROla2C2K2mlu1weVF6K3C0BbgtxMxel+mTlPew63P16WRixbTL2t?=
 =?us-ascii?Q?RoQk6HDkuc1DnDgrlCt2eYD+R5HfHSfM/w09fijP5JP0kaxKbMfNxI9mfepP?=
 =?us-ascii?Q?T6e4y3kfOakGYUHQGJSBGeuZySRNT+TKxcDeT5vhZlHJRoSxWoHMzsbAKARY?=
 =?us-ascii?Q?5c0oWIiWmupzcPfDy0wmcrmSXdUC8gt/WuafcdFugcyr5IuA7L+x0vf3AoAY?=
 =?us-ascii?Q?k9I5ZEwvJ8LCjCFKk+ln6ILGArFsWJQDQFZoP7O/vXiBeA4Dcz+7cPuDOZCe?=
 =?us-ascii?Q?aUMQD/kfMNrKu6/hwh04BX7ynBhg0sn7DRJe2uiiR+cMIwr94VI3L8jcP5gq?=
 =?us-ascii?Q?VXk4SOWP0BLH3m4rUjg1XWQsOPJbcBLZycptP36JAUm7jD6/QFYP9Rf7q9F/?=
 =?us-ascii?Q?TBBjSokMvCNVLdEPT7sv7WmM/zH2KGsnsCx/7wfy44czKs3ddGNLNYmvdCwE?=
 =?us-ascii?Q?GDE0g4vrCQcIASxsERe6U7XYGL6nmEVMrxoZyvEiITCnPtLDFre6CQX+yG2d?=
 =?us-ascii?Q?Iy2fHAirXK5XaIlJEVx4N0Q5OUI07wMBcsAN2J9XE9S6ei1Xdv1JPQjeqJG7?=
 =?us-ascii?Q?pnMcuHoG7k5PvLgvGrTOtc4b0hqv+L5tfOi1CHQbkrJxi4AQk++Y0Ev3ZrzC?=
 =?us-ascii?Q?umjrBBc6pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389f8ed6-f7e4-45a7-fc62-08dea55e3dac
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:42:11.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ppk1bzPGEmXpqBkv3AiQ9HOuEgxGOh8N4Q7l+rY9OYj9xMr8bRdMZ9FqTmJHLq39/0xbBItqE5rKfR0vKS88g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
X-Rspamd-Queue-Id: 005F448B4BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35528-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add initialization and shutdown logic for the nxpwifi driver, including
setup of adapter and private structures, firmware download, and resource
cleanup.

Initialize adapter and private structures with default values, allocate
command buffers, queues, and timers, and configure BSS priority tables for
multi-interface coordination. Implement the firmware download and
initialization sequence, and provide shutdown and cleanup routines for safe
driver removal.

Add helpers for managing netdev queues and synchronization primitives to
ensure proper resource management across the driver lifecycle.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/init.c | 607 ++++++++++++++++++++++++
 1 file changed, 607 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/init.c b/drivers/net/wireless/nxp/nxpwifi/init.c
new file mode 100644
index 000000000000..eb8510265b40
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/init.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: HW/FW initialization
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+
+/* Add a BSS priority node to the adapter list. */
+static int nxpwifi_add_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bss_prio;
+	struct nxpwifi_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
+
+	bss_prio = kzalloc_obj(*bss_prio, GFP_KERNEL);
+	if (!bss_prio)
+		return -ENOMEM;
+
+	bss_prio->priv = priv;
+	INIT_LIST_HEAD(&bss_prio->list);
+
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+	list_add_tail(&bss_prio->list, &tbl[priv->bss_priority].bss_prio_head);
+	spin_unlock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+
+	return 0;
+}
+
+static void wakeup_timer_fn(struct timer_list *t)
+{
+	struct nxpwifi_adapter *adapter = timer_container_of(adapter, t, wakeup_timer);
+
+	nxpwifi_dbg(adapter, ERROR, "Firmware wakeup failed\n");
+	adapter->hw_status = NXPWIFI_HW_STATUS_RESET;
+	nxpwifi_cancel_all_pending_cmd(adapter);
+
+	if (adapter->if_ops.card_reset)
+		adapter->if_ops.card_reset(adapter);
+}
+
+/* Initialize priv defaults and lists. */
+int nxpwifi_init_priv(struct nxpwifi_private *priv)
+{
+	u32 i;
+
+	priv->media_connected = false;
+	eth_broadcast_addr(priv->curr_addr);
+	priv->port_open = false;
+	priv->usb_port = NXPWIFI_USB_EP_DATA;
+	priv->pkt_tx_ctrl = 0;
+	priv->bss_mode = NL80211_IFTYPE_UNSPECIFIED;
+	priv->data_rate = 0;	/* Initially indicate the rate as auto */
+	priv->is_data_rate_auto = true;
+	priv->bcn_avg_factor = DEFAULT_BCN_AVG_FACTOR;
+	priv->data_avg_factor = DEFAULT_DATA_AVG_FACTOR;
+
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+
+	priv->sec_info.wep_enabled = 0;
+	priv->sec_info.authentication_mode = NL80211_AUTHTYPE_OPEN_SYSTEM;
+	priv->sec_info.encryption_mode = 0;
+	for (i = 0; i < ARRAY_SIZE(priv->wep_key); i++)
+		memset(&priv->wep_key[i], 0, sizeof(struct nxpwifi_wep_key));
+	priv->wep_key_curr_index = 0;
+	priv->curr_pkt_filter = HOST_ACT_MAC_DYNAMIC_BW_ENABLE |
+				HOST_ACT_MAC_RX_ON | HOST_ACT_MAC_TX_ON |
+				HOST_ACT_MAC_ETHERNETII_ENABLE;
+
+	priv->beacon_period = 100; /* beacon interval */
+	priv->attempted_bss_desc = NULL;
+	memset(&priv->curr_bss_params, 0, sizeof(priv->curr_bss_params));
+	priv->listen_interval = NXPWIFI_DEFAULT_LISTEN_INTERVAL;
+
+	memset(&priv->prev_ssid, 0, sizeof(priv->prev_ssid));
+	memset(&priv->prev_bssid, 0, sizeof(priv->prev_bssid));
+	memset(&priv->assoc_rsp_buf, 0, sizeof(priv->assoc_rsp_buf));
+	priv->assoc_rsp_size = 0;
+	priv->atim_window = 0;
+	priv->tx_power_level = 0;
+	priv->max_tx_power_level = 0;
+	priv->min_tx_power_level = 0;
+	priv->tx_ant = 0;
+	priv->rx_ant = 0;
+	priv->tx_rate = 0;
+	priv->rxpd_htinfo = 0;
+	priv->rxpd_rate = 0;
+	priv->rate_bitmap = 0;
+	priv->data_rssi_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->data_nf_last = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+	priv->bcn_nf_last = 0;
+	memset(&priv->wpa_ie, 0, sizeof(priv->wpa_ie));
+	memset(&priv->aes_key, 0, sizeof(priv->aes_key));
+	priv->wpa_ie_len = 0;
+	priv->wpa_is_gtk_set = false;
+
+	memset(&priv->assoc_tlv_buf, 0, sizeof(priv->assoc_tlv_buf));
+	priv->assoc_tlv_buf_len = 0;
+	memset(&priv->wps, 0, sizeof(priv->wps));
+	memset(&priv->gen_ie_buf, 0, sizeof(priv->gen_ie_buf));
+	priv->gen_ie_buf_len = 0;
+	memset(priv->vs_ie, 0, sizeof(priv->vs_ie));
+
+	priv->wmm_required = true;
+	priv->wmm_enabled = false;
+	priv->wmm_qosinfo = 0;
+	priv->curr_bcn_buf = NULL;
+	priv->curr_bcn_size = 0;
+	priv->wps_ie = NULL;
+	priv->wps_ie_len = 0;
+	priv->ap_11n_enabled = 0;
+	memset(&priv->roc_cfg, 0, sizeof(priv->roc_cfg));
+
+	priv->scan_block = false;
+
+	priv->csa_chan = 0;
+	priv->csa_expire_time = 0;
+	priv->del_list_idx = 0;
+	priv->hs2_enabled = false;
+	memcpy(priv->tos_to_tid_inv, tos_to_tid_inv, MAX_NUM_TID);
+
+	nxpwifi_init_11h_params(priv);
+
+	return nxpwifi_add_bss_prio_tbl(priv);
+}
+
+/* Allocate command buffer and sleep-confirm skb. */
+static int nxpwifi_allocate_adapter(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+
+	/* Allocate command buffer */
+	ret = nxpwifi_alloc_cmd_buffer(adapter);
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc cmd buffer\n",
+			    __func__);
+		return ret;
+	}
+
+	adapter->sleep_cfm =
+		dev_alloc_skb(sizeof(struct nxpwifi_opt_sleep_confirm)
+			      + INTF_HEADER_LEN);
+
+	if (!adapter->sleep_cfm) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc sleep cfm\t"
+			    " cmd buffer\n", __func__);
+		return -ENOMEM;
+	}
+	skb_reserve(adapter->sleep_cfm, INTF_HEADER_LEN);
+
+	return 0;
+}
+
+/* Initialize adapter defaults and WMM parameters. */
+static void nxpwifi_init_adapter(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_opt_sleep_confirm *sleep_cfm_buf = NULL;
+
+	skb_put(adapter->sleep_cfm, sizeof(struct nxpwifi_opt_sleep_confirm));
+
+	adapter->cmd_sent = false;
+	adapter->data_sent = true;
+
+	adapter->intf_hdr_len = INTF_HEADER_LEN;
+
+	adapter->cmd_resp_received = false;
+	adapter->event_received = false;
+	adapter->data_received = false;
+	adapter->assoc_resp_received = false;
+	adapter->priv_link_lost = NULL;
+	adapter->host_mlme_link_lost = false;
+
+	clear_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_CAM;
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->need_to_wakeup = false;
+
+	adapter->scan_mode = HOST_BSS_MODE_ANY;
+	adapter->specific_scan_time = NXPWIFI_SPECIFIC_SCAN_CHAN_TIME;
+	adapter->active_scan_time = NXPWIFI_ACTIVE_SCAN_CHAN_TIME;
+	adapter->passive_scan_time = NXPWIFI_PASSIVE_SCAN_CHAN_TIME;
+	adapter->scan_chan_gap_time = NXPWIFI_DEF_SCAN_CHAN_GAP_TIME;
+
+	adapter->scan_probes = 1;
+
+	adapter->multiple_dtim = 1;
+
+	/* default value in firmware will be used */
+	adapter->local_listen_interval = 0;
+
+	adapter->is_deep_sleep = false;
+
+	adapter->delay_null_pkt = false;
+	adapter->delay_to_ps = 1000;
+	adapter->enhanced_ps_mode = PS_MODE_AUTO;
+
+	/* Disable NULL Pkg generation by default */
+	adapter->gen_null_pkt = false;
+	/* Disable pps/uapsd mode by default */
+	adapter->pps_uapsd_mode = false;
+	adapter->pm_wakeup_card_req = false;
+
+	adapter->pm_wakeup_fw_try = false;
+
+	adapter->curr_tx_buf_size = NXPWIFI_TX_DATA_BUF_SIZE_2K;
+
+	clear_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags);
+	adapter->hs_cfg.conditions = cpu_to_le32(HS_CFG_COND_DEF);
+	adapter->hs_cfg.gpio = HS_CFG_GPIO_DEF;
+	adapter->hs_cfg.gap = HS_CFG_GAP_DEF;
+	adapter->hs_activated = false;
+
+	memset(adapter->event_body, 0, sizeof(adapter->event_body));
+	adapter->hw_dot_11n_dev_cap = 0;
+	adapter->hw_dev_mcs_support = 0;
+	adapter->sec_chan_offset = 0;
+
+	nxpwifi_wmm_init(adapter);
+	atomic_set(&adapter->tx_hw_pending, 0);
+
+	sleep_cfm_buf = (struct nxpwifi_opt_sleep_confirm *)
+					adapter->sleep_cfm->data;
+	memset(sleep_cfm_buf, 0, adapter->sleep_cfm->len);
+	sleep_cfm_buf->command = cpu_to_le16(HOST_CMD_802_11_PS_MODE_ENH);
+	sleep_cfm_buf->size = cpu_to_le16(adapter->sleep_cfm->len);
+	sleep_cfm_buf->result = 0;
+	sleep_cfm_buf->action = cpu_to_le16(SLEEP_CONFIRM);
+	sleep_cfm_buf->resp_ctrl = cpu_to_le16(RESP_NEEDED);
+
+	memset(&adapter->sleep_period, 0, sizeof(adapter->sleep_period));
+	adapter->tx_lock_flag = false;
+	adapter->null_pkt_interval = 0;
+	adapter->fw_bands = 0;
+	adapter->fw_release_number = 0;
+	adapter->fw_cap_info = 0;
+	memset(&adapter->upld_buf, 0, sizeof(adapter->upld_buf));
+	adapter->event_cause = 0;
+	adapter->region_code = 0;
+	adapter->bcn_miss_time_out = DEFAULT_BCN_MISS_TIMEOUT;
+	memset(&adapter->arp_filter, 0, sizeof(adapter->arp_filter));
+	adapter->arp_filter_size = 0;
+	adapter->max_mgmt_ie_index = MAX_MGMT_IE_INDEX;
+	adapter->key_api_major_ver = 0;
+	adapter->key_api_minor_ver = 0;
+	eth_broadcast_addr(adapter->perm_addr);
+	adapter->iface_limit.sta_intf = NXPWIFI_MAX_STA_NUM;
+	adapter->iface_limit.uap_intf = NXPWIFI_MAX_UAP_NUM;
+	adapter->active_scan_triggered = false;
+	timer_setup(&adapter->wakeup_timer, wakeup_timer_fn, 0);
+	adapter->devdump_len = 0;
+	memset(&adapter->vdll_ctrl, 0, sizeof(adapter->vdll_ctrl));
+	adapter->vdll_ctrl.skb = dev_alloc_skb(NXPWIFI_SIZE_OF_CMD_BUFFER);
+	atomic_set(&adapter->iface_changing, 0);
+}
+
+/* Update trans_start for each Tx queue. */
+void nxpwifi_set_trans_start(struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++)
+		txq_trans_cond_update(netdev_get_tx_queue(dev, i));
+
+	netif_trans_update(dev);
+}
+
+/* Wake all netdev Tx queues. */
+void nxpwifi_wake_up_net_dev_queue(struct net_device *netdev,
+				   struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_wake_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* Stop all netdev Tx queues. */
+void nxpwifi_stop_net_dev_queue(struct net_device *netdev,
+				struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_stop_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* Invalidate list heads. */
+static void nxpwifi_invalidate_lists(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	list_del(&adapter->cmd_free_q);
+	list_del(&adapter->cmd_pending_q);
+	list_del(&adapter->scan_pending_q);
+
+	for (i = 0; i < adapter->priv_num; i++)
+		list_del(&adapter->bss_prio_tbl[i].bss_prio_head);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j) {
+			list_del(&priv->wmm.tid_tbl_ptr[j].ra_list);
+			list_del(&priv->tx_ba_stream_tbl_ptr[j]);
+			list_del(&priv->rx_reorder_tbl_ptr[j]);
+		}
+		list_del(&priv->sta_list);
+	}
+}
+
+/* Cancel pending work, stop timers, and free adapter buffers. */
+static void
+nxpwifi_adapter_cleanup(struct nxpwifi_adapter *adapter)
+{
+	timer_delete(&adapter->wakeup_timer);
+	nxpwifi_cancel_all_pending_cmd(adapter);
+	wake_up_interruptible(&adapter->cmd_wait_q.wait);
+	wake_up_interruptible(&adapter->hs_activate_wait_q);
+	if (adapter->vdll_ctrl.vdll_mem) {
+		vfree(adapter->vdll_ctrl.vdll_mem);
+		adapter->vdll_ctrl.vdll_mem = NULL;
+		adapter->vdll_ctrl.vdll_len = 0;
+	}
+	if (adapter->vdll_ctrl.skb) {
+		dev_kfree_skb_any(adapter->vdll_ctrl.skb);
+		adapter->vdll_ctrl.skb = NULL;
+	}
+}
+
+void nxpwifi_free_cmd_buffers(struct nxpwifi_adapter *adapter)
+{
+	nxpwifi_invalidate_lists(adapter);
+
+	/* Free command buffer */
+	nxpwifi_dbg(adapter, INFO, "info: free cmd buffer\n");
+	nxpwifi_free_cmd_buffer(adapter);
+
+	if (adapter->sleep_cfm)
+		dev_kfree_skb_any(adapter->sleep_cfm);
+}
+
+/* Initialize locks and list heads. */
+void nxpwifi_init_lock_list(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	spin_lock_init(&adapter->int_lock);
+	spin_lock_init(&adapter->nxpwifi_cmd_lock);
+	spin_lock_init(&adapter->queue_lock);
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		spin_lock_init(&priv->wmm.ra_list_spinlock);
+		spin_lock_init(&priv->curr_bcn_buf_lock);
+		spin_lock_init(&priv->sta_list_spinlock);
+	}
+
+	/* Initialize cmd_free_q */
+	INIT_LIST_HEAD(&adapter->cmd_free_q);
+	/* Initialize cmd_pending_q */
+	INIT_LIST_HEAD(&adapter->cmd_pending_q);
+	/* Initialize scan_pending_q */
+	INIT_LIST_HEAD(&adapter->scan_pending_q);
+
+	spin_lock_init(&adapter->cmd_free_q_lock);
+	spin_lock_init(&adapter->cmd_pending_q_lock);
+	spin_lock_init(&adapter->scan_pending_q_lock);
+
+	skb_queue_head_init(&adapter->rx_mlme_q);
+	skb_queue_head_init(&adapter->rx_data_q);
+	skb_queue_head_init(&adapter->tx_data_q);
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		INIT_LIST_HEAD(&adapter->bss_prio_tbl[i].bss_prio_head);
+		spin_lock_init(&adapter->bss_prio_tbl[i].bss_prio_lock);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j) {
+			INIT_LIST_HEAD(&priv->wmm.tid_tbl_ptr[j].ra_list);
+			INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr[j]);
+			INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr[j]);
+			spin_lock_init(&priv->tx_ba_stream_tbl_lock[j]);
+			spin_lock_init(&priv->rx_reorder_tbl_lock[j]);
+		}
+		INIT_LIST_HEAD(&priv->sta_list);
+		skb_queue_head_init(&priv->bypass_txq);
+
+		spin_lock_init(&priv->ack_status_lock);
+		xa_init_flags(&priv->ack_status_frames, XA_FLAGS_ALLOC);
+	}
+}
+
+/* Init firmware: alloc resources, init adapter/privs, send STA init. */
+int nxpwifi_init_fw(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+	struct nxpwifi_private *priv;
+	u8 i;
+	bool first_sta = true;
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	/* Allocate memory for member of adapter structure */
+	ret = nxpwifi_allocate_adapter(adapter);
+	if (ret)
+		return ret;
+
+	/* Initialize adapter structure */
+	nxpwifi_init_adapter(adapter);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		/* Initialize private structure */
+		ret = nxpwifi_init_priv(priv);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		ret = nxpwifi_sta_init_cmd(adapter->priv[i],
+					   first_sta, true);
+		if (ret)
+			return ret;
+
+		first_sta = false;
+	}
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	WARN_ON(!list_empty(&adapter->cmd_pending_q));
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+	adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+
+	return 0;
+}
+
+/* Remove all BSS priority nodes for this priv. */
+static void nxpwifi_delete_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	int i;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bssprio_node, *tmp_node;
+	struct list_head *head;
+	spinlock_t *lock; /* bss priority lock */
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		head = &adapter->bss_prio_tbl[i].bss_prio_head;
+		lock = &adapter->bss_prio_tbl[i].bss_prio_lock;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: delete BSS priority table,\t"
+			    "bss_type = %d, bss_num = %d, i = %d,\t"
+			    "head = %p\n",
+			    priv->bss_type, priv->bss_num, i, head);
+
+		{
+			spin_lock_bh(lock);
+			list_for_each_entry_safe(bssprio_node, tmp_node, head,
+						 list) {
+				if (bssprio_node->priv == priv) {
+					nxpwifi_dbg(adapter, INFO,
+						    "info: Delete\t"
+						    "node %p, next = %p\n",
+						    bssprio_node, tmp_node);
+					list_del(&bssprio_node->list);
+					kfree(bssprio_node);
+				}
+			}
+			spin_unlock_bh(lock);
+		}
+	}
+}
+
+/* Free per-priv resources and BSS priority entries. */
+void nxpwifi_free_priv(struct nxpwifi_private *priv)
+{
+	nxpwifi_clean_txrx(priv);
+	nxpwifi_delete_bss_prio_tbl(priv);
+	nxpwifi_free_curr_bcn(priv);
+}
+
+/* Shutdown driver: stop work, drain queues, free resources. */
+void
+nxpwifi_shutdown_drv(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i;
+	struct sk_buff *skb;
+
+	/* nxpwifi already shutdown */
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_NOT_READY)
+		return;
+
+	/* cancel current command */
+	if (adapter->curr_cmd) {
+		nxpwifi_dbg(adapter, WARN,
+			    "curr_cmd is still in processing\n");
+		timer_delete_sync(&adapter->cmd_timer);
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+		adapter->curr_cmd = NULL;
+	}
+
+	/* shut down nxpwifi */
+	nxpwifi_dbg(adapter, MSG,
+		    "info: shutdown nxpwifi...\n");
+
+	/* Clean up Tx/Rx queues and delete BSS priority table */
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		nxpwifi_abort_cac(priv);
+		nxpwifi_free_priv(priv);
+	}
+
+	atomic_set(&adapter->tx_queued, 0);
+	while ((skb = skb_dequeue(&adapter->tx_data_q)))
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+
+	while ((skb = skb_dequeue(&adapter->rx_mlme_q)))
+		dev_kfree_skb_any(skb);
+
+	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
+		struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+
+		atomic_dec(&adapter->rx_pending);
+		priv = adapter->priv[rx_info->bss_num];
+		if (priv)
+			priv->stats.rx_dropped++;
+
+		dev_kfree_skb_any(skb);
+	}
+
+	nxpwifi_adapter_cleanup(adapter);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_NOT_READY;
+}
+
+/* Download FW if needed; check winner and wait until ready. */
+int nxpwifi_dnld_fw(struct nxpwifi_adapter *adapter,
+		    struct nxpwifi_fw_image *pmfw)
+{
+	int ret;
+	u32 poll_num = 1;
+
+	/* check if firmware is already running */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (!ret) {
+		nxpwifi_dbg(adapter, MSG,
+			    "WLAN FW already running! Skip FW dnld\n");
+		return 0;
+	}
+
+	/* check if we are the winner for downloading FW */
+	if (adapter->if_ops.check_winner_status) {
+		adapter->winner = 0;
+		ret = adapter->if_ops.check_winner_status(adapter);
+
+		poll_num = MAX_FIRMWARE_POLL_TRIES;
+		if (ret) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN read winner status failed!\n");
+			return ret;
+		}
+
+		if (!adapter->winner) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN is not the winner! Skip FW dnld\n");
+			goto poll_fw;
+		}
+	}
+
+	if (pmfw) {
+		/* Download firmware with helper */
+		ret = adapter->if_ops.prog_fw(adapter, pmfw);
+		if (ret) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "prog_fw failed ret=%#x\n", ret);
+			return ret;
+		}
+	}
+
+poll_fw:
+	/* Check if the firmware is downloaded successfully or not */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (ret)
+		nxpwifi_dbg(adapter, ERROR,
+			    "FW failed to be active in time\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_dnld_fw);
-- 
2.34.1


