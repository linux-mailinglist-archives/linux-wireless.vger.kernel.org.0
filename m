Return-Path: <linux-wireless+bounces-37423-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fk+EMB77ImpBgAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37423-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:36:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C5649D57
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:36:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="g5/M3QWe";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37423-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37423-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 559EF30C2086
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96033BE628;
	Fri,  5 Jun 2026 16:13:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01553EE1E4;
	Fri,  5 Jun 2026 16:13:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676035; cv=fail; b=DeSr9wm9k6T++3GhWgPn0T3I3s2rfMNJqCpzO2LgGQzX5/bvVGHVPjZvEIYyPz7vMuzyQies0+ia2BDLztp0CCTf2hg2xcIw7fO34v9EyUvL6AdnJRljBO9bLY3vcQj99vn1ETk4+eo5Dk3DJDdaG0vaUqGRAgGxNhqxlwASR/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676035; c=relaxed/simple;
	bh=6ooA/Jd0hZ2M690fe3iUH3BPL9FuRPNq+3/spwnWmLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4aNThyN6HUg2v9ldIGaQTrrJ39vs7gvfgtI8ue/U3ywytFbxlnM+bV6M47EK8SAkQnegisbusKPia3z7FdXhwPYemzOQNGEVLzmAx34MKN0m/FKAqNnAjnmFiSJVbYFD8I6Zbj7m7+/uAmtI5fLaSFk6WQCTSV+BfVRnrN9ASM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g5/M3QWe; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQD7ZWI/M/+KzPOAkTVvjhftbGDs7j520c3yKgZtyLbBbvqhUw0TXyiOjLES9L/Zg3DB39kwS0pV7hlbtXWUbN/3PhMyMAoEOiShxw/rJCXPIUXXXc+CfiRyI4n0mewwm+dqKP0jaI4SYtGKRl1vbFN9TDECe8xE4NoDCh38FQZ+r6THrZQoBl5A1DNfqxj9vr7RL8GiYAuv2fL75fD/DLgbyERHE/dbVkUypWvREN2EiSYyjOIsn7soKjwEqx2WoHCX4H0BWgHJc7hbh1xFGjcW+AMM/bdfyfreN7ie8itICCZAIu0omfLS6OzMTwDib+KQQ4ggYP1bUtcioypdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MvYR4wpJpDTeZR9rFdvYyKRpJeqrlf0p6o+rhg6ROM=;
 b=rlxl9R06rKPmpj5qiozR9Vsc5z6ZKBx744OQVhFivnadaj0RbO0yg0QKwdXFfeFKIfJl11dqE7TJsOXuNTHdqsgp90YshXqUGtaYU/mnY1b+G0WN0KpiUu4pPQ6BDV+KknRY3AZ2dUEIxaDNiKtqM7FK/EhANiPCAN+Jk6C1dfZ84bTPlvHTgaiePbqG8kcelVF84qPB8ScX3PtkQVPgPCAO77voa33ww4T3C8ihfla6ut5W9I+ZHfyoX8+xqp7T6KcSKpU3Su316kXyJlfx7LvRvxInXhp5I6NkyJiNmANP07Fui7hXLFX+hkzzghl42G88SBXVJ2SDVZhg8cvRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MvYR4wpJpDTeZR9rFdvYyKRpJeqrlf0p6o+rhg6ROM=;
 b=g5/M3QWeg/yvUY/hO+F6wNDv9Rv+t9A4vcWez8n838zrMb+v8eTK1nGPSSEa1Ufl8K+YAhhvcYfBUa1U+IPO1ldxNnYt9PbnVj42onym45xlm1+fjnGQCnS0v7Wfy3Xrpbao+I+wvjq0Y8C77aQqXe9A+gNKWkmtv1/3Gz6SefAJIQlZ43hdnDFtytx9bNeIhNuJ9Cq+F4YJDqarSDKuiDSGB76RzTVkn99jO9EM9DuxFFReAE9n55JRtAfZgFtAO71ywn7LOsyhddKVqLciKdI5AuTk73S6ojJA1XTTunbO3MRht766+p7N3Lti1R6Qw/f23IYgTFBtJ+DHHYfYkA==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:13:49 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:13:49 +0000
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
Subject: [PATCH v12 02/22] wifi: nxpwifi: add initial 802.11ac support for STA and AP modes
Date: Sat,  6 Jun 2026 00:13:15 +0800
Message-Id: <20260605161335.2415583-3-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e14c9c-9a6d-4fe7-86d1-08dec31d6da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007|38350700014;
X-Microsoft-Antispam-Message-Info:
	bfKSlV9C3m2RQHGWvZkzEUzAMkZ3vxgHb8h7ZlLuSvEQfJPMi8lltx4tPq3qhZYutdLk6u+JecPCoZ0rBaoeBwUNkjL7lnHLkdbmbI+x3vQ+uqIIqs2HTSavNCgJy/O61p461pw23qh8mz+/BhsZVJndXc/sjUzGI4iWRxQ9g7ne8sO3aan4Z8YMOgqDsubVAVE8AmsN7JAPkE68BiUOG8qpucdGKmwgOHNFjT+lKNSTNDuxtD9wQsxwAF77L/uIv3J60naFCRmM6ekly4tVkOq4vG0S6jeX1qqvmw+8qnM8mth/xIZ21pNj9DzdMMDTtmUWwvAlcZwRewNGxYwJ04TT+tl7/hreIITYtvqfg1FcRxRL9yYr9Om5vlgVXgqvrTCd/TfTnaJ1rI/hEdOawp99dUVESrZEmwEc3R8Gle82U1EXvVaNe07Bx1AD6oUXLwCcEEeoFqr7e4M9bsSH7WZP7fFnJcZhHUEXSzE552eFl5kLMqgWY6VeZup/ftE0GnzkDgF5L7aaXFDaCjFpobJP2iVHdH2Q47l6X9u8jr6GaJyDouINMYuQitVQI4E9RR4jcGnv9gU3NI1tYhomAXDcshgwadky7Z+Z8xVTITJAOpo4AcD7d5izRMvSvhSQnyJj24Pj1ie5Dz+6ob12zeAQkizwaiY0V63FB4SG++qBr53VxOnkl68lBtdN7TCwoW4LezRmO/5/uIttaktbA1lXpVM2fKbJh1lbHu80NnpkfrVYWbPIQL2CDxqgfWRV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?scQLKKHa3BxjkaTNQ2ChEJ8YdXYX3B8ItE9egVbAR6TckSCfU+xA1XLdIjkW?=
 =?us-ascii?Q?LYyiJWSi01Ifb6YH9eJiGhripHuGxuC5ZTFHFERROpBzaAnFJJUTEwaDHAAD?=
 =?us-ascii?Q?4+oJ6jQ8A04lCvWW00Iyq40WS+AjYlu6ae+lRBLZCYgWkVJcJrKQMa+QYDv4?=
 =?us-ascii?Q?T44kSdBpVoHH6ArZkXfo2LEh5cKMSrnIazT14KqITFd8ekGZYQuI7RyHof0Y?=
 =?us-ascii?Q?DOOyRjMIaAVWncXkHSerh2Ghr5PqlduaHj1hsM05pYZ/9EFEpsJ8vwfu9Tfr?=
 =?us-ascii?Q?4R1kroKxOtKL5PNhMfeWYPnAdv4Mpm11ZVUarfynVf1xINNonOSI96UWYFU8?=
 =?us-ascii?Q?LaX/9KH7mwuSdlej+9kSo6GAzFEgSAcQ6DFFNSab5c8Z7V5Oxu1n3FOekNQi?=
 =?us-ascii?Q?eS4Vebx/GuFSbE4JMGvNvkbm4FXG0x5DdyIUuUk2gyZOSH7LHqqteWIsCQOL?=
 =?us-ascii?Q?NKfjlZrntnFY4H+SKJmjAml80AQ9FvfsK8xQ9diuyCvSyed/kF/2rArfo3p9?=
 =?us-ascii?Q?CKwHLLIhcLe8+Za3CfTOkhMgx7fDT7ckyf2P8ePi1JS8CfCmBAICrM9YG/e8?=
 =?us-ascii?Q?y7q+kQkjpq5qYmXHIG011m6oPUi+oYOrJKx6rD+Vxi6frczCpvcPL2kvjcCQ?=
 =?us-ascii?Q?fkijikoiJovKAy46wAe4d7cqQL3ThI3UKq/x93s4X9iWZPFcx+VnlU2CjrOV?=
 =?us-ascii?Q?wqRmVF6wp3gZt5Q/b/CdoZ9JGfVP1tikGso1Eu0Z5ZeO6O4FESeC/0Rampkl?=
 =?us-ascii?Q?o0BDwT0ZuoB1xtQtqDOgMFjcgyNto+1KLf8Fkhyx/hVsbsQyQ6A2CKaWG/7b?=
 =?us-ascii?Q?hQ6E5BKF7E8V3R8iHFam/3TIjqa7v7olb+LaNeqF72NY9x3qxzuCCd9ktCSQ?=
 =?us-ascii?Q?Tuj44+3hj/BLbmfLcUpT5AkUGVkeiWB/I/w3ghZSgMKag9dklEnFdZTs1UGO?=
 =?us-ascii?Q?lpDvWH2VoD7NglAJ6MIONdnR5OGbF7tYRG78srkAXzyFmSYxV6oVDUgn355O?=
 =?us-ascii?Q?K3oVtM8WovmYsWCR9AWnzTOcsCluF7taemZlOSBrZWtLL/muGb03ZtUTwoZO?=
 =?us-ascii?Q?EU0SnIHYqJ3jKtwUC3gd+amVYpxOpBHML1KxttDMjPrsjJLbmxcBrDqsrLvl?=
 =?us-ascii?Q?WgWOCfKh5wxRQbmE+pwS0rdZSBwEbFCyQQ2LgoLtsy6R/QkslwwSMZg70M3e?=
 =?us-ascii?Q?BeAs8SYOu0+Jy13LgrQ4QLtqud3K0tOhcu8fJkNk3DPBI1o5jtfF1zGme2G1?=
 =?us-ascii?Q?I0TwN9DViHUGUWULQLViErmH8WGPNAIUf3nNRXP1hDu1bPQeuR8dqs9C3kc4?=
 =?us-ascii?Q?ufRDqyBvjs6OHToE5wgUrunbUk/GrByHo+A1iBRjqYTVOMawotmi8eIWmW8I?=
 =?us-ascii?Q?DpTv37362O1gLif/j+R6xbFGuLVeBAIp/JhUmq5cPUdrzPFsfQanBwJ5YMeW?=
 =?us-ascii?Q?FOe+dVm042QneV81uuKPhA+1UyfmgLm5iv8R/E4jBxUgtrwyXdnSIpOV9pNN?=
 =?us-ascii?Q?+gUQCYXcJZ8jK3FEpJgIVfzpEFMaqP50ZDAwMb9XP5xF3LTS/yEFHhDbxKLn?=
 =?us-ascii?Q?jZvvN7vHY+1NYSNR4dlpCg8UWlBuEMlnZO8JuvYeFs6APZB3zErgjJIrtEsJ?=
 =?us-ascii?Q?1iBA0zjaDmAIxy6XnpyLYRZBrChgBNT4vPbtv7YDZclEj5kG/rqu1sd57niv?=
 =?us-ascii?Q?XBgNS21rDuYA7DVqApxUrvv0nqxK7P24tLs1XIYrg9slWL7CLLAlrJp9uIfl?=
 =?us-ascii?Q?OKInSx3hYg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e14c9c-9a6d-4fe7-86d1-08dec31d6da8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:13:49.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8i3fMRekR1NlSCi2TruBMcoxI3EkzQQZCh8q+zLbTHbuAuHoprrrhr2uTd4+skUDZkDem3bYN7+AGxXdPPrOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37423-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B0C5649D57

Add initial 802.11ac support for both station and AP roles, enabling
VHT capability negotiation and configuration through firmware assisted
commands.

For station mode, convert VHT elements from cfg80211 into firmware TLVs
and append them to HOST_CMD_802_11_ASSOCIATE. For AP mode, convert
VHT elements into parameters for HOST_CMD_11AC_CFG and pass them to the
firmware for configuration.

Handle VHT capabilities, VHT operation, and operating mode notification
elements to allow proper setup of 802.11ac features.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 280 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  33 +++
 2 files changed, 313 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..117d06c35401
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi 802.11ac helpers
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ac.h"
+
+/* Map VHT MCS/NSS to highest data rate (Mbps), long GI. */
+static const u16 max_rate_lgi_80MHZ[8][3] = {
+	{0x124, 0x15F, 0x186},	/* NSS = 1 */
+	{0x249, 0x2BE, 0x30C},  /* NSS = 2 */
+	{0x36D, 0x41D, 0x492},  /* NSS = 3 */
+	{0x492, 0x57C, 0x618},  /* NSS = 4 */
+	{0x5B6, 0x6DB, 0x79E},  /* NSS = 5 */
+	{0x6DB, 0x83A, 0x0},    /* NSS = 6 */
+	{0x7FF, 0x999, 0xAAA},  /* NSS = 7 */
+	{0x924, 0xAF8, 0xC30}   /* NSS = 8 */
+};
+
+static const u16 max_rate_lgi_160MHZ[8][3] = {
+	{0x249, 0x2BE, 0x30C},   /* NSS = 1 */
+	{0x492, 0x57C, 0x618},   /* NSS = 2 */
+	{0x6DB, 0x83A, 0x0},     /* NSS = 3 */
+	{0x924, 0xAF8, 0xC30},   /* NSS = 4 */
+	{0xB6D, 0xDB6, 0xF3C},   /* NSS = 5 */
+	{0xDB6, 0x1074, 0x1248}, /* NSS = 6 */
+	{0xFFF, 0x1332, 0x1554}, /* NSS = 7 */
+	{0x1248, 0x15F0, 0x1860} /* NSS = 8 */
+};
+
+/* Convert 2-bit MCS map to highest long-GI VHT data rate. */
+static u16
+nxpwifi_convert_mcsmap_to_maxrate(struct nxpwifi_private *priv,
+				  u16 bands, u16 mcs_map)
+{
+	u8 i, nss, mcs;
+	u16 max_rate = 0;
+	u32 usr_vht_cap_info = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_AAC)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* Find max supported NSS. */
+	nss = 1;
+	for (i = 1; i <= 8; i++) {
+		mcs = GET_VHTNSSMCS(mcs_map, i);
+		if (mcs < IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			nss = i;
+	}
+	mcs = GET_VHTNSSMCS(mcs_map, nss);
+
+	/* If not supported, fall back to 0-9. */
+	if (mcs == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		mcs = IEEE80211_VHT_MCS_SUPPORT_0_9;
+
+	if (u32_get_bits(usr_vht_cap_info, IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK)) {
+		/* Support 160 MHz. */
+		max_rate = max_rate_lgi_160MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 not supported in NSS6. */
+			max_rate = max_rate_lgi_160MHZ[nss - 1][mcs - 1];
+	} else {
+		max_rate = max_rate_lgi_80MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 not supported in NSS3. */
+			max_rate = max_rate_lgi_80MHZ[nss - 1][mcs - 1];
+	}
+
+	return max_rate;
+}
+
+static void
+nxpwifi_fill_vht_cap_info(struct nxpwifi_private *priv,
+			  struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_A)
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_a);
+	else
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_bg);
+}
+
+void
+nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			 struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 mcs_map_user, mcs_map_resp, mcs_map_result;
+	u16 mcs_user, mcs_resp, nss, tmp;
+
+	/* Fill VHT capability info. */
+	nxpwifi_fill_vht_cap_info(priv, vht_cap, bands);
+
+	/* RX MCS set: min(user, AP). */
+	mcs_map_user = GET_DEVRXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.rx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.rx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.rx_highest = cpu_to_le16(tmp);
+
+	/* TX MCS set: min(user, AP). */
+	mcs_map_user = GET_DEVTXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.tx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.tx_highest = cpu_to_le16(tmp);
+}
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_vhtcap *vht_cap;
+	struct nxpwifi_ie_types_oper_mode_ntf *oper_ntf;
+	struct ieee_types_oper_mode_ntf *ieee_oper_ntf;
+	struct nxpwifi_ie_types_vht_oper *vht_op;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 supp_chwd_set;
+	u32 usr_vht_cap_info;
+	int ret_len = 0;
+
+	if (bss_desc->bss_band & BAND_A)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* VHT Capabilities element. */
+	if (bss_desc->bcn_vht_cap) {
+		vht_cap = (struct nxpwifi_ie_types_vhtcap *)*buffer;
+		memset(vht_cap, 0, sizeof(*vht_cap));
+		vht_cap->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		vht_cap->header.len  =
+			cpu_to_le16(sizeof(struct ieee80211_vht_cap));
+		memcpy((u8 *)vht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_vht_cap,
+		       le16_to_cpu(vht_cap->header.len));
+
+		nxpwifi_fill_vht_cap_tlv(priv, &vht_cap->vht_cap,
+					 bss_desc->bss_band);
+		*buffer += sizeof(*vht_cap);
+		ret_len += sizeof(*vht_cap);
+	}
+
+	/* VHT Operation element. */
+	if (bss_desc->bcn_vht_oper) {
+		if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+			vht_op = (struct nxpwifi_ie_types_vht_oper *)*buffer;
+			memset(vht_op, 0, sizeof(*vht_op));
+			vht_op->header.type =
+				cpu_to_le16(WLAN_EID_VHT_OPERATION);
+			vht_op->header.len  = cpu_to_le16(sizeof(*vht_op) -
+				sizeof(struct nxpwifi_ie_types_header));
+			memcpy((u8 *)vht_op +
+				sizeof(struct nxpwifi_ie_types_header),
+			       (u8 *)bss_desc->bcn_vht_oper,
+			       le16_to_cpu(vht_op->header.len));
+
+			/* Negotiate channel width; keep peer's center freq. */
+			supp_chwd_set = u32_get_bits(usr_vht_cap_info,
+						     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK);
+
+			switch (supp_chwd_set) {
+			case 0:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 1:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_160MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 2:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80P80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			default:
+				vht_op->chan_width =
+				     IEEE80211_VHT_CHANWIDTH_USE_HT;
+				break;
+			}
+
+			*buffer += sizeof(*vht_op);
+			ret_len += sizeof(*vht_op);
+		}
+	}
+
+	/* Operating Mode Notification element. */
+	if (bss_desc->oper_mode) {
+		ieee_oper_ntf = bss_desc->oper_mode;
+		oper_ntf = (void *)*buffer;
+		memset(oper_ntf, 0, sizeof(*oper_ntf));
+		oper_ntf->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		oper_ntf->header.len = cpu_to_le16(sizeof(u8));
+		oper_ntf->oper_mode = ieee_oper_ntf->oper_mode;
+		*buffer += sizeof(*oper_ntf);
+		ret_len += sizeof(*oper_ntf);
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg)
+{
+	struct host_cmd_11ac_vht_cfg *vhtcfg = &cmd->params.vht_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AC_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_11ac_vht_cfg) +
+				S_DS_GEN);
+	vhtcfg->action = cpu_to_le16(cmd_action);
+	vhtcfg->band_config = cfg->band_config;
+	vhtcfg->misc_config = cfg->misc_config;
+	vhtcfg->cap_info = cpu_to_le32(cfg->cap_info);
+	vhtcfg->mcs_tx_set = cpu_to_le32(cfg->mcs_tx_set);
+	vhtcfg->mcs_rx_set = cpu_to_le32(cfg->mcs_rx_set);
+
+	return 0;
+}
+
+/* Initialize BlockAck parameters for 11ac. */
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE;
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.h b/drivers/net/wireless/nxp/nxpwifi/11ac.h
new file mode 100644
index 000000000000..edc01b35d5b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: 802.11ac (VHT) definitions
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AC_H_
+#define _NXPWIFI_11AC_H_
+
+#define VHT_CFG_2GHZ BIT(0)
+#define VHT_CFG_5GHZ BIT(1)
+
+enum vht_cfg_misc_config {
+	VHT_CAP_TX_OPERATION = 1,
+	VHT_CAP_ASSOCIATION,
+	VHT_CAP_UAP_ONLY
+};
+
+#define DEFAULT_VHT_MCS_SET 0xfffe
+#define DISABLE_VHT_MCS_SET 0xffff
+
+#define VHT_BW_80_160_80P80 BIT(2)
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg);
+void nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			      struct ieee80211_vht_cap *vht_cap, u16 bands);
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


