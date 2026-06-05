Return-Path: <linux-wireless+bounces-37425-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OEwMFuf3ImqPfwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37425-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:23:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B435649B8E
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=kDF+RUwF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37425-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37425-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77CB030CE003
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C2A410D1A;
	Fri,  5 Jun 2026 16:14:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBEA406297;
	Fri,  5 Jun 2026 16:13:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676040; cv=fail; b=dBFM/mlZCY/1n7nDMcsIeysCUvnp/qTWl4bJeffM+0jZ9f8ojAOSIfqddSMJzhZivbCZwYvfYO2scKhn8JBa+or52C7fjAr/m4jTwOQ86fWPqNi+pwDHsXtruUuc1jrDYKc7UY9Y4/8X4cJHTMK5YjTrL6avSXqvBBiW3Po2nT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676040; c=relaxed/simple;
	bh=X4tyew27ss+8EV1AVc7ECrikE0pglw1ekcb4EyOJ5Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jStIxmER7xFV2RHyTJOOm3zZxUwuJFevenxQreQI9Z6VLuyacHsVsH+VDch7H0AkcG8cVTUnnndVU7u4Db8Wd811/L4SmHkQzTSdfKaejLU8Eecfnb9XuyIt4iwLBhIdv+HGFdNPAo2yupnFnYV+rcYMjrSkuRPu5ylt26Z/xLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kDF+RUwF; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP5uZTac/IwYXcwDU3PXCk44fOQ09qpB9Azlzdp5TztM7cu9/2yTmfsvSKAbT2P1gutH0RE5hSrTe2tE2wnOSn4w3UibxnVv34sbEdhbYRseRp9XqtkJf+I66qtJeubaJ+FMgKxEqAt2mk9E4/YAxhsAzHW6wIOmKqnZLwHvbJy7LGW9Z06mmUu78nid6umhiLH8fsqa72P/bTwUgyeqq1N3WJ+ZgsxwGD8UDOelFmb8znuRvDrjmgDtyunHrokWw6fnUSSkF1XKpVIx4Grp2fZKu9ySm0baHbiwjvuFlhSyWVQBE/ZQkRSUXL93XiUEU2yJTVN0UKYAorK2mktrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkDtWXVa4ZoeLDyWVEBqFikdsTP5c5iGpGdXY3YkmiI=;
 b=LnRiepqere5SUjoXQO/NH3iNDLgPjk/JSX39bL5p0rd3uMNzHpkZtiQN7j6ZZNT88QMp+ep45fY33umLGgBGczvrJ1cJMQkugV8d0midAxYmGqfijtvLEGpDNtAo+9gVrksstugmycCixNx8gmIjRWyeszMwDaK9PP+sTd39Q1/rT/+uFECmkYW9/3CRwhvni+s0KdCEgyDuhCIan2b2Qkkhq4WEYoaXi5V1wePMdWL9poYsYX7PQZjLaCo6bd483aYUIrsxN0X7xZe8fCgAHkm+on+SMcEk8vWDltknLqmd5/z2TXS3dKNk5tlh8AvkujoIzmVsFrIksqXa2zjPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkDtWXVa4ZoeLDyWVEBqFikdsTP5c5iGpGdXY3YkmiI=;
 b=kDF+RUwFLhKnWNnhG3Fbv5IIs+Gcdf1s83V7CvkT/FaJM2PCDAZ1R/tERZ7+fntyG9VYBiiM7fSmD89Mr12P3XBPc5eVOFoubQIG/tNtgwpJCc12WwjT8tLWT2pn9WAd7qXl7npPqbmnO4zr7sbhqUAUL+T4Xzdwd9rqdWBR8BN2v0OEultPqVXQzeCeiHT6Q4CCZfYWikg+qWkoeVGtM/iUNoAfTlA5fOm5I31YIRwW9KVdnihfa8KEj1oUO++q0nNZl7OOLBm1VZgJCkM+aBnt7vvJ+7OeJubvrHwkPMXxeKuDFug+Va8vS0+pTwqFYCNb2pdLqIcmMhL0pOtHVw==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:13:55 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:13:55 +0000
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
Subject: [PATCH v12 04/22] wifi: nxpwifi: add 802.11h (DFS/TPC) support
Date: Sat,  6 Jun 2026 00:13:17 +0800
Message-Id: <20260605161335.2415583-5-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f4335d2-ec10-4d09-578b-08dec31d7137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|11063799006|56012099006|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	VZnYUT6m9h/Du6rhDNAbtUbQd7Y7Mg/TL++23AhlEcBEay0e0il4RwV0qXsCQ4CsthPHGENEJZUo+8y4kAd4KhqlIZStQqTPBHTMUo/AbdmVgOmWEWgNZBY08jXzYtzvUWrT6aegdWrshrSjdwogw/Ofd1zTbzkBESacmA+XNSg5JCShbpacpidK7Tk7tYynoAEsuTNHjnSFx19ydplLFZcOT62lUAUwT1IsEofSXqFrqqhzulrHvt4vBW8ApUf2hngyQqLSRtOdgob+mm77jv8vPFEbshrO59HWYFUXsCFWGOwX/pgC9CIOlFXS+zXZTEE3phw995dUAQ6GH18ciWL33Hcj1NE2+AqB62z8VGnYs7r63kTXfdeLOfdAmYjDeZws3romfBwSFtdrCOos6Stzp7fMArPuqMUi0yyMpN4quwqxNvohYNPqhhMwdJ/PYESbsE49vth/bg95qTBooXokpqLRrgJKhAdguzG2jmI5LXwXs9UZJ+X/xOsagtVwFR4oQ8WpS7DTuNNEKdzfqkMltP7qioCRzRJEPP2QIACKevKP3hlKSWjiqIpyA34qYFnr5Ew/xRMzYXQBgLdRik8NhushEuUoTVheTED3/5khEs1uF4MlCN6PnbLL8eLo7LNRTcqEgUCirRCz0JYPuWoq7Mz8MPUVFdZvEorNmgK591NN0kKXpBRuGPWT/BU3V5vioL6QBBg6j339EqzLFGm3wJJW5lbc2HqvKzXEODAoO8DmlkC2f3yWP2BPAxs7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jhx39WjM+uCvQUIzu9Xzc87AhqeKy1UCrdDiK2yInjTtAcM1rdJM/Ez51KZF?=
 =?us-ascii?Q?1qaZ1ZiB9Gn3ch4ZIDI+Cyqqz6PVM4679AAgUQTUe9nPvqzKF0dU0ytNH4A4?=
 =?us-ascii?Q?QX/FAKBwwKYsx5G0QNTKXjWF54uofALUoIWUq2hIPzHHQs51xpQdBp/501i1?=
 =?us-ascii?Q?pJcYDF1FSRFWLQv2k08V3hceb3Td+JguD5vezGtr4cqt1nAYjb0JwyXr1Onl?=
 =?us-ascii?Q?36fZ2KnBvF1jPOKk/W9nlZlt7mBMFvWzBPb1fRYNxDRhcSVoSDZfDPpIiKoE?=
 =?us-ascii?Q?BUx6MJA+JWq7ngkWByP5GlqdjNxKsw5sg1P4ag+ZVuXoTq2Tv6R/adrbd1m2?=
 =?us-ascii?Q?QSjgnmVAzpR/HucTyocZv+bmCoPKn2OHd9lGvmo+a/rtx80bGImDk3dVSDB1?=
 =?us-ascii?Q?2W48+fnhGDKulcPBG0XKhrbX81ptSc+A4DlECPQVuKg5II9iyg0393+yhcdO?=
 =?us-ascii?Q?HlZFh5/65jRbCTLw9vB9Y6RbcSpS7pXIvHTQR4PXaIX/52MD1MR1Kbjlk5o0?=
 =?us-ascii?Q?YgXQWCmb393P8Qqw/cQghWg44PUwggnWBVVQRwSuLpKRopdACF8CUoDohJyk?=
 =?us-ascii?Q?KGLmYuTTf2DAXkeWOCWTrEAos0R741q825ppz3WjAagt615/bQrLtXOkLl7j?=
 =?us-ascii?Q?mU6gmI/R4RDgXBWQLNR/6tBQrg8ekCTOs/Jq8nQWRrgma48OORr0lGeHwcx+?=
 =?us-ascii?Q?xE9Vv4cknWAFerwDxO2BOqNquarwQnO3xpTcS7A1hFEp4BjcpMnnNHUd7wHZ?=
 =?us-ascii?Q?8uvbwtsmj4xtICaeyQ70z3brOKza8QS82twOF/V1/XX25V6j+lD5Xo07p3jf?=
 =?us-ascii?Q?uvmiqr5/JfK0CLpYYWq+wtsH429wujP0EDJ7cWy0i7QvC2wEGHoRdSF5A8kB?=
 =?us-ascii?Q?n5ILv0KIW8y9rIW5mQc/1Je5vqOIsIP//VZOMqBOrmKeyZPpFOk3sxmabjmx?=
 =?us-ascii?Q?vRP8XgYw+zhIQzl6SYwLqBQktBo4nPFvIQtJ3mlSaiIdscAD1Ko+ANYoMIE/?=
 =?us-ascii?Q?YYOlFWWumr+TKvMxyE0jBa15YQAGgdsDK+GX7N0QrmV1t0aduAcRU9NUsGEd?=
 =?us-ascii?Q?5Ix59qX2ZAy8Oevrpf+HDt2GRQkJVhBD6ZZKDpZi6Ktrxsfi9+9gBn+B5U2+?=
 =?us-ascii?Q?BlWLrahf+xXsBwWmD6KKBloOZRrc61WuhLV3ofYiivi7BxogUH+RANGZT9d9?=
 =?us-ascii?Q?tSF4gsUYrQGw7CszWXKYp5Ae95aNxfbFzyLQukIOm5BTUD6nYyj1kkyx2xQ2?=
 =?us-ascii?Q?OAINg6Uog6oVIhPWNvSUo9kO3srPhpOAZWMRoZ3gt++Xq1CXUs8pWC8IJX97?=
 =?us-ascii?Q?Lzpl16gDn2vFjI7RdeS2FxXpkqha+F2LYVeJ1sSPB64PvRt+3PGAYP2Oq0Ra?=
 =?us-ascii?Q?x+/wPo6+EwBr+nkl+j8+ogm/atpXKfb2XN9/ob2SfcwwoPlcHEH7wXGas7Ze?=
 =?us-ascii?Q?BGG22ALQaWmFtMgL3BmcXJ2ZzhZ0uOsHH1AGwyLSPIHy8+qsHPRy6EVaYkXd?=
 =?us-ascii?Q?gFnZLX7/65IVXWOmYvCq5wqR7biYLWSOLMbj7A52VYyULlultT3X2WKji5KD?=
 =?us-ascii?Q?cNffjHWVwbUSxfwM2yjHBJQZFnXTBNKwQnwsk5+uF1DsSBIUv5yqHHiazN7l?=
 =?us-ascii?Q?PejNxDcEcJ+aXhijVTOTfNgLX/Hvk/zdaBP1DEFyRAaQJrgoGD2OwhM7GBFd?=
 =?us-ascii?Q?w1khoUnZVO2CGKZBHCKjhOYpvrVsX0VJifCqnkM15igKDK9EPe8UIXhcw6qE?=
 =?us-ascii?Q?sNwG9gL2Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4335d2-ec10-4d09-578b-08dec31d7137
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:13:55.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTaIVmyJg+M3NPejKFe8NKxORzNNHiW53iHepUxSPRckwXB8uU4o+NSSfjQN2sOJdQFP+BHDg689WxjzH64wVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
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
	TAGGED_FROM(0.00)[bounces-37425-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B435649B8E

Add 802.11h support to enable Dynamic Frequency Selection (DFS) and
Transmit Power Control (TPC) for 5 GHz regulatory compliance.

Handle DFS Channel Availability Check (CAC), including start, timeout,
and abort flows, and process firmware radar reports via
HOST_CMD_CHAN_REPORT_REQUEST and related events. Support channel switch
operations with AP restart and beacon updates through cfg80211.

Implement TPC handling during association using the power capability and
local power constraint elements. Delegate radar detection to firmware,
while the driver constructs TLVs, handles events, and integrates with
cfg80211 for state changes and notifications.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 339 +++++++++++++++++++++++++
 1 file changed, 339 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..058c319ff910
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: 802.11h helpers
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "fw.h"
+#include "cfg80211.h"
+
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv)
+{
+	priv->state_11h.is_11h_enabled = true;
+	priv->state_11h.is_11h_active = false;
+}
+
+int nxpwifi_is_11h_active(struct nxpwifi_private *priv)
+{
+	return priv->state_11h.is_11h_active;
+}
+
+/* appends 11h info to a buffer while joining an infrastructure BSS */
+static void
+nxpwifi_11h_process_infra_join(struct nxpwifi_private *priv, u8 **buffer,
+			       struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_header *ie_header;
+	struct nxpwifi_ie_types_pwr_capability *cap;
+	struct nxpwifi_ie_types_local_pwr_constraint *constraint;
+	struct ieee80211_supported_band *sband;
+	u8 radio_type;
+	int i;
+
+	if (!buffer || !(*buffer))
+		return;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	cap = (struct nxpwifi_ie_types_pwr_capability *)*buffer;
+	cap->header.type = cpu_to_le16(WLAN_EID_PWR_CAPABILITY);
+	cap->header.len = cpu_to_le16(2);
+	cap->min_pwr = 0;
+	cap->max_pwr = 0;
+	*buffer += sizeof(*cap);
+
+	constraint = (struct nxpwifi_ie_types_local_pwr_constraint *)*buffer;
+	constraint->header.type = cpu_to_le16(WLAN_EID_PWR_CONSTRAINT);
+	constraint->header.len = cpu_to_le16(2);
+	constraint->chan = bss_desc->channel;
+	constraint->constraint = bss_desc->local_constraint;
+	*buffer += sizeof(*constraint);
+
+	ie_header = (struct nxpwifi_ie_types_header *)*buffer;
+	ie_header->type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+	ie_header->len  = cpu_to_le16(2 * sband->n_channels + 2);
+	*buffer += sizeof(*ie_header);
+	*(*buffer)++ = WLAN_EID_SUPPORTED_CHANNELS;
+	*(*buffer)++ = 2 * sband->n_channels;
+	for (i = 0; i < sband->n_channels; i++) {
+		u32 center_freq;
+
+		center_freq = sband->channels[i].center_freq;
+		*(*buffer)++ = ieee80211_frequency_to_channel(center_freq);
+		*(*buffer)++ = 1; /* one channel in the subband */
+	}
+}
+
+/* Enable or disable the 11h extensions in the firmware */
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag)
+{
+	u32 enable = flag;
+
+	/* enable master mode radar detection on AP interface */
+	if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) && enable)
+		enable |= NXPWIFI_MASTER_RADAR_DET_MASK;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				HOST_ACT_GEN_SET, DOT11H_I, &enable, true);
+}
+
+/*
+ * Process TLV buffer for a pending BSS join. Enable 11h in firmware when the
+ * network advertises spectrum management, and add required TLVs based on the
+ * BSS's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability bit */
+		nxpwifi_11h_activate(priv, true);
+		priv->state_11h.is_11h_active = true;
+		bss_desc->cap_info_bitmap |= WLAN_CAPABILITY_SPECTRUM_MGMT;
+		nxpwifi_11h_process_infra_join(priv, buffer, bss_desc);
+	} else {
+		/* Deactivate 11h functions in the firmware */
+		nxpwifi_11h_activate(priv, false);
+		priv->state_11h.is_11h_active = false;
+		bss_desc->cap_info_bitmap &= ~WLAN_CAPABILITY_SPECTRUM_MGMT;
+	}
+}
+
+/*
+ * DFS CAC work function. This delayed work emits CAC finished event for cfg80211
+ * if CAC was started earlier
+ */
+void nxpwifi_dfs_cac_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_cac_work);
+
+	chandef = priv->dfs_chandef;
+	if (priv->wdev.links[0].cac_started) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "CAC timer finished; No radar detected\n");
+		cfg80211_cac_event(priv->netdev, &chandef,
+				   NL80211_RADAR_CAC_FINISHED,
+				   GFP_KERNEL, 0);
+	}
+}
+
+/* prepares channel report request command to FW for starting radar detection */
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf)
+{
+	struct host_cmd_ds_chan_rpt_req *cr_req = &cmd->params.chan_rpt_req;
+	struct nxpwifi_radar_params *radar_params = (void *)data_buf;
+	u16 size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_CHAN_REPORT_REQUEST);
+	size = S_DS_GEN;
+
+	cr_req->chan_desc.start_freq = cpu_to_le16(NXPWIFI_A_BAND_START_FREQ);
+	nxpwifi_convert_chan_to_band_cfg(priv,
+					 &cr_req->chan_desc.band_cfg,
+					 radar_params->chandef);
+	cr_req->chan_desc.chan_num = radar_params->chandef->chan->hw_value;
+	cr_req->msec_dwell_time = cpu_to_le32(radar_params->cac_time_ms);
+	size += sizeof(*cr_req);
+
+	if (radar_params->cac_time_ms) {
+		struct nxpwifi_ie_types_chan_rpt_data *rpt;
+
+		rpt = (struct nxpwifi_ie_types_chan_rpt_data *)((u8 *)cmd + size);
+		rpt->header.type = cpu_to_le16(TLV_TYPE_CHANRPT_11H_BASIC);
+		rpt->header.len = cpu_to_le16(sizeof(u8));
+		rpt->meas_rpt_map = 1 << MEAS_RPT_MAP_RADAR_SHIFT_BIT;
+		size += sizeof(*rpt);
+
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "11h: issuing DFS Radar check for channel=%d\n",
+			    radar_params->chandef->chan->hw_value);
+	} else {
+		nxpwifi_dbg(priv->adapter, MSG, "cancelling CAC\n");
+	}
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef)
+{
+	struct nxpwifi_radar_params radar_params;
+
+	memset(&radar_params, 0, sizeof(struct nxpwifi_radar_params));
+	radar_params.chandef = chandef;
+	radar_params.cac_time_ms = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_CHAN_REPORT_REQUEST,
+				HOST_ACT_GEN_SET, 0, &radar_params, true);
+}
+
+/* Abort ongoing CAC when stopping AP operations or during unload */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+}
+
+/*
+ * handles channel report event from FW during CAC period. If radar is detected
+ * during CAC, driver indicates the same to cfg80211 and also cancels ongoing
+ * delayed work
+ */
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb)
+{
+	struct host_cmd_ds_chan_rpt_event *rpt_event;
+	struct nxpwifi_ie_types_chan_rpt_data *rpt;
+	u16 event_len, tlv_len;
+
+	rpt_event = (void *)(skb->data + sizeof(u32));
+	event_len = skb->len - (sizeof(struct host_cmd_ds_chan_rpt_event) +
+				sizeof(u32));
+
+	if (le32_to_cpu(rpt_event->result) != HOST_RESULT_OK) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Error in channel report event\n");
+		return -EINVAL;
+	}
+
+	while (event_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		rpt = (void *)&rpt_event->tlvbuf;
+		tlv_len = le16_to_cpu(rpt->header.len);
+
+		switch (le16_to_cpu(rpt->header.type)) {
+		case TLV_TYPE_CHANRPT_11H_BASIC:
+			if (rpt->meas_rpt_map & MEAS_RPT_MAP_RADAR_MASK) {
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "RADAR Detected on channel %d!\n",
+					    priv->dfs_chandef.chan->hw_value);
+
+				wiphy_delayed_work_cancel(priv->adapter->wiphy,
+							  &priv->dfs_cac_work);
+				cfg80211_cac_event(priv->netdev,
+						   &priv->dfs_chandef,
+						   NL80211_RADAR_CAC_ABORTED,
+						   GFP_KERNEL, 0);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
+			}
+			break;
+		default:
+			break;
+		}
+
+		event_len -= (tlv_len + sizeof(rpt->header));
+	}
+
+	return 0;
+}
+
+/* Handler for radar detected event from FW */
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
+
+	if (priv->wdev.links[0].cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+	}
+	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
+			     GFP_KERNEL);
+	nxpwifi_dbg(priv->adapter, MSG, "regdomain: %d\n",
+		    rdr_event->reg_domain);
+	nxpwifi_dbg(priv->adapter, MSG, "radar detection type: %d\n",
+		    rdr_event->det_type);
+
+	return 0;
+}
+
+/*
+ * work function for channel switch handling. takes care of updating new channel
+ * definitin to bss config structure, restart AP and indicate channel switch
+ * success to cfg80211
+ */
+void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_chan_sw_work);
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (nxpwifi_del_mgmt_ies(priv))
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
+
+	bss_cfg = &priv->bss_cfg;
+	if (!bss_cfg->beacon_period) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: AP already stopped\n");
+		return;
+	}
+
+	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+			     HOST_ACT_GEN_SET, 0, NULL, true)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (nxpwifi_cfg80211_change_beacon(adapter->wiphy, priv->netdev,
+					   &priv->ap_update_info)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
+	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
+
+	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Failed to start AP after channel switch\n");
+		return;
+	}
+
+	nxpwifi_dbg(adapter, MSG,
+		    "indicating channel switch completion to kernel\n");
+
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


