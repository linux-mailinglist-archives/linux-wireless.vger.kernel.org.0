Return-Path: <linux-wireless+bounces-32529-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD9SDfyXqWlKAgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32529-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:49:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF736213D40
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A8E13079E17
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA93AA1AD;
	Thu,  5 Mar 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PtwSAuV4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3D3AA1BB;
	Thu,  5 Mar 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721739; cv=fail; b=vC5xOArQUK/y456mRuXiFafJYC6eQiac7kA1vJAG567Tj6vfHgpL3NWBthfmFNDvrNBvDwhakvkTYR3TIvTFBb78pEau3BnaEK9iP2YWKVTtm9trH4GvmzDlXHyf+Kl5zj22o6rmKG4E88w9IFtbBCc3NzEavyRuV7VyJ9FfciM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721739; c=relaxed/simple;
	bh=k6u6lA9QYvQ644Nt3S3rifHTqv3J7zNxMjk4SMyS5Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tI5lKn65GmFmIRDV/EHmCH2OWRZyylc55eyRGC1APM2hHtM1xpzsr7hpPyFFzCcfD6Ev16tgJCr6xDJ82d2a07CjOu5H7NeS/LSDUqP19XiuF95DI16aEwlMY+fbYjuULkgxgy6Jj6sIfA579UZqhG57klK/6ktqVUZqzlMCcGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PtwSAuV4; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTBMexMATAW3gzTidHqF9iKdnV2c+KLXQKehQJMS2ufD1L7Zho0cUx60AssNqMpAchcw/yZarZxFxWHZCNczAvjlR8BmpjTkX6bxrMqnoFh0IFj9j7o5bV0BIIw8dz/vhGyQHMUmbgyUx54+hSaCQ+FvScec3exuf7e5H+ucTKqy6Tkq2owwT2RUyslpUvcsIgVEEFt3SLswk2rcXX0bHq8g2QNBTYHyxGHVkKcixDvq7dVIdpIJCUnv0NYmQ/oViHWkYCxsb+Yw+hiu8FHcYmOr5tD6vtcj6wrxhltkLdlBWhdkV65PLXFJJ/Bp69cMRgYVOwSmEIbD46Sr+SRXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqUuVPu1I6xDYh9gd7f4BVIb1elpEunhPkFgkbQ5WgE=;
 b=P94+ZJMEjyi5Bbx3kj6PdFUy+fIbPYvHtmHRB2NKqaDjkGzIWTy+O8LxbaCLdI5657FzNwqtagxcYQny60ANfRglH3OwX+TZIY55T2WRhrJ7eqjYSYpRlSoPx4IvhbHtnffmAS//bVxS5IyCLC1kzLoXuCxDo+F6DBGwxh2Ca4SwRyfKPPZcO8rU0AUXk07Z7LA+ZHd7ioHG2BVvMWs1GB/Qr5DQxk4bDwgBCXC1/sV8mYO2ObCVcR7BmoQKgnjxQesCVNaeNPp7gCtTjKso1VWRZNrcl04M5zoGdzoWFD4El1H+0lESrzDMtTypbGijQ5XbjKOckD/aMlOkkgrTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqUuVPu1I6xDYh9gd7f4BVIb1elpEunhPkFgkbQ5WgE=;
 b=PtwSAuV44KpmR/wNeb/96JCJl4aEx9EMMVB/oGioi8SpXp0WXwfyZSs5Bg9ku0im3DQTFUK4BjfrXSDQN5tr/2K/bsIfDqiJB37UMZkSPcFWssY1mZZLYIgJRexpbm3NF+m6FqCKnLt22DdFbXRxyAen4E0V9AbG5Bfzgl4oaakT6lMOGQHx6HgVVXhiMFbw3HNMpce0RGpOHmz8Q0pyUry8vfSm3BmyosEdfghjfaqSy/30uPwhDOlj/eW0xHI4JRggTgFlPYCXODLzANCnKRSEk4T1FcAjInB1wMJjAMkC7EjbvCTbSfMXwbqXvq8Oj3oSAR1sMog+Rsvsld+ncg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:42:09 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:42:09 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 08/21] wifi: nxpwifi: add channel/frequency/power support
Date: Thu,  5 Mar 2026 22:39:26 +0800
Message-Id: <20260305143939.3724868-9-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e17e4c-646f-4711-fc67-08de7ac56135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	91KbDoVmSETG3YtzkWIFTNzl6AUvythGKfhqbb0Vrg0yingOooeSPNq7M94wX0t3TTVsytKEdSPupzt+bcBdhfR59paknHFSP60lawC4lIATCdq3Z+BYSrR+ZWr4nl6ThKX0OGaJe+3nvw6ghLmWvGhSqkmOcMzDUZsxgpVErVEfcBymhvQ8Txl2VtOmjUV54+qLJFd0sSZT4TWvPqiW+pRp7m2W3hthjWepZX4y2LYusn3D8Ul1hFYlIoFHPX0jotcjV6GjsCLR1StWYa6d1ZI4krLXm9YZ5HM9kJIbFdZp08zxt9zJ4R1NHPas7FidAgB+mMTsF3LNsNhZ/892H2nZsPPjUfYSPjraSPMZtd27A2bKL6Pc40smcuLNsIpa1K51xfOS86LDI6VUn1vk/+B1MMihsLD63FYc3BRhEdrjw1TQp5G8j8qVw4PT1kluU3C8RUq9/ykDNwgJBEdztjn/QU7yHShz2mb1qW/v1BCLjeiP7KeDUv7DsXAFWGC+6SHxM95CWi2Ni1ngtTjHkxRoiVtK6tzne35jTpRGJCmCm5Imrj1z8e4n81utLRnKCJ/p2KUk2slvnd1VnBHAeZQpMkwcpmujyovt7FpNU6fthW8rGRjd9ru/FgpR/r9OqWotU8kxH+GI9g80OK+Uof8Qlb+8yi2QltOM08mJDWWsTjuKuz4IOvmBMpsfb9/tQEo4BqxJGPIhd0q4MyPHSK6MbFVxKPfFCiWLg9JMIY8uxGpeYTGhnqk9digwbmSMMF+cbPyDXQ38MtUdBe+Z7itQi9kY03gFrLk5HGm7hHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qEoR254jo5TNpig9u9HQdNpd3t/cQRMIs0kxpSz2P4DElXn47Sb0dk2zXvlU?=
 =?us-ascii?Q?SQqu66O3jeVrT/KS6KSdKpjFc1rXEUt6jgrmtvhi68xSCmTTW40OGu0Ljub8?=
 =?us-ascii?Q?frFlsIdnDpI8o3gpTgvovcMt9i+vIaxaVGw0oyCleKuna9CUYh5FbLIfGyA/?=
 =?us-ascii?Q?CNoynJFxMMoIcO6eOoia2rd3bU2MkUDMC+oL+qstzmyqTPSoLH/GvAlx8XXP?=
 =?us-ascii?Q?A2k7xHVRa/haZUi93G/yiPM0pvkq97RHo3hlBvizRoDfWrXVd25bLBTGAPTw?=
 =?us-ascii?Q?Up3lWFPvqCN0a2sOQfINF01KCeFYXTlOOy58kSrYZQi+rzivyHWTGwdLX+AS?=
 =?us-ascii?Q?2MVABTa7GfYExrXLjjJdQBW3oTCy/ZhPK1MpUatB8QUFBDLBwpsJStIe7FM9?=
 =?us-ascii?Q?WDSHC+OLn1Uk99jJMxj/4bFUK/qvIpyu+JEVsqWk4/IfEoCTlTyGGiP0XxoP?=
 =?us-ascii?Q?M747Zp3HADf0faHTKHbp8sUbt2mwyF3BljuGcFH2COXIToCulUOeHFXSerIO?=
 =?us-ascii?Q?sUkWyU3lRZ3PPJjON90FLZ+k8AydCGJ+ngkguQhkLIuXZQGT7p+pPJEtrd7v?=
 =?us-ascii?Q?ZGC4YYvB23gSShcLQiNFRYm6zsZg0GcI7/q/V9N+EqNl5HtCkoCc6UpLACB/?=
 =?us-ascii?Q?VcapzH2Ibjr8/4x5Ibtc3gdfQ67vXZ316d0U6efTz8KKD37lhQhlTXvhPOB1?=
 =?us-ascii?Q?dLHSQoUuCF7q4WAXHOsl0VhVZeErChKGBbBrROHD1ULretgGpaaiYuYKIvX3?=
 =?us-ascii?Q?vgaVGDKKVrb2J8IdCFBw5Z4zFYW5vY3BKUVR8C1WOm6CvhYoTBHMpdp5JyWq?=
 =?us-ascii?Q?ZtFrdIjJ0iwCxoDbC52U9dj1Cbjmh1lVhrRxGEgNbwjDT7rRrSIslj47j+xG?=
 =?us-ascii?Q?YQHhdk57ytAnKJNBXjR/4A+djhdmgIXzEUIzW599t0IjtCto5aOCWV56JArd?=
 =?us-ascii?Q?baVJRQMgPioPWbJk6WFuqOnvKTTNjZgLkxW52/SvNfYMUMb9ndKmHYTG0sXp?=
 =?us-ascii?Q?3BTdxs73ouzymnyy2Zd8pGhBpQaztvY/KcLcgfLhFxovMdACien6Ba6Wlzet?=
 =?us-ascii?Q?l+0u9Tv7xqIWVskp8uC5N4j0I1PLlC9lP+02kE4sy+SMTj3hUkzS+acVDQdK?=
 =?us-ascii?Q?GZDffpHX4OEgDvsiVPO5M3wLi0deZjPyWZYwZ/6nqr04z8+qVmL4uLqCvpyk?=
 =?us-ascii?Q?wmeIm0HtzNevaoSw3/zcsE8xCHdPQpg9aQ0aZSkIJj8ppPsqNsqqjEh8oQVm?=
 =?us-ascii?Q?EBLw+GLlcHm0pK0ss4H3h14RR571gryUJYA4+ARMc5JzG6tx73XrtrrgUf+O?=
 =?us-ascii?Q?qw4ty/fedBNSrDwLf86CzPuuld3d/2n7b9PGOgUlM9GNOGv+2GDtQkjo5Kv6?=
 =?us-ascii?Q?eUB4cZDxJoTztEBxm4OOiLOTYWXXuGIieYtiLPeOdgtTKhnxY8D2yQI4bx3J?=
 =?us-ascii?Q?xjiz5/elwFFWq47M5FRqO/8T1WlbIoRLnm4RljKCXBUVKOxIZ4icgZIKTk4v?=
 =?us-ascii?Q?jtElTZBlgZiGrcSjeCRhQ+3hzlX/72QMghUeOZ6nKEcJhxgMS4Sg7ACCOtw8?=
 =?us-ascii?Q?vyP9LJ2BTkpo3j7QxRm6njiHUmVSWd1zs3pWdyhtDZvQHcB1JUswPcJ+hqaZ?=
 =?us-ascii?Q?5vrhFurIIJ4xc7q07IL68mYNJjIWhcGJu3LNk+ZmCNOdIfL0JdYdYCe0/5hs?=
 =?us-ascii?Q?fOF/0uZDqPdG29GGLyAJ5hf0aHdDVsg4CWNXIvtPifiWDz3BjYS3qlkbcKYw?=
 =?us-ascii?Q?a2N58kXisA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e17e4c-646f-4711-fc67-08de7ac56135
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:42:09.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUzc94W+dA9rxGYAKDA2LSOC3lz16+b6F2tP/gNr024OKWPmHwzoWpRGM5S4vfsu0osm63lgbPIY84c3YaosDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313
X-Rspamd-Queue-Id: DF736213D40
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32529-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add cfp.c to provide channel, frequency, and power utilities for the
nxpwifi driver.

Define supported data rates for 802.11a/b/g/n/ac and implement helpers
for converting between rate values and rate indices for legacy, HT, and
VHT formats. Add region-code-to-country mapping to support 802.11d
operation.

Provide utility functions for determining supported and active data
rates, mapping channel/frequency/power (CFP) triplets, adjusting RX rate
indices, and extracting rate information from cfg80211 scan requests.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfp.c | 458 +++++++++++++++++++++++++
 1 file changed, 458 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfp.c b/drivers/net/wireless/nxp/nxpwifi/cfp.c
new file mode 100644
index 000000000000..e4adbeb6a09c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfp.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: Channel, Frequency and Power
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cfg80211.h"
+
+/* 100mW */
+#define NXPWIFI_TX_PWR_DEFAULT         20
+/* 100mW */
+#define NXPWIFI_TX_PWR_US_DEFAULT      20
+/* 50mW */
+#define NXPWIFI_TX_PWR_JP_DEFAULT      16
+/* 100mW */
+#define NXPWIFI_TX_PWR_FR_100MW        20
+/* 10mW */
+#define NXPWIFI_TX_PWR_FR_10MW         10
+/* 100mW */
+#define NXPWIFI_TX_PWR_EMEA_DEFAULT    20
+
+static u8 supported_rates_a[A_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0xb0, 0x48, 0x60, 0x6c, 0 };
+static u16 nxpwifi_data_rates[NXPWIFI_SUPPORTED_RATES_EXT] = { 0x02, 0x04,
+					0x0B, 0x16, 0x00, 0x0C, 0x12, 0x18,
+					0x24, 0x30, 0x48, 0x60, 0x6C, 0x90,
+					0x0D, 0x1A, 0x27, 0x34, 0x4E, 0x68,
+					0x75, 0x82, 0x0C, 0x1B, 0x36, 0x51,
+					0x6C, 0xA2, 0xD8, 0xF3, 0x10E, 0x00 };
+
+static u8 supported_rates_b[B_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x16, 0 };
+
+static u8 supported_rates_g[G_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0x30, 0x48, 0x60, 0x6c, 0 };
+
+static u8 supported_rates_bg[BG_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x0c,
+					0x12, 0x16, 0x18, 0x24, 0x30, 0x48,
+					0x60, 0x6c, 0 };
+
+u16 region_code_index[NXPWIFI_MAX_REGION_CODE] = { 0x00, 0x10, 0x20, 0x30,
+						0x31, 0x32, 0x40, 0x41, 0x50 };
+
+/* mcs_rate: first 8 entries for 1x1; all 16 for 2x2. */
+static const u16 mcs_rate[4][16] = {
+	/* LGI 40M */
+	{ 0x1b, 0x36, 0x51, 0x6c, 0xa2, 0xd8, 0xf3, 0x10e,
+	  0x36, 0x6c, 0xa2, 0xd8, 0x144, 0x1b0, 0x1e6, 0x21c },
+
+	/* SGI 40M */
+	{ 0x1e, 0x3c, 0x5a, 0x78, 0xb4, 0xf0, 0x10e, 0x12c,
+	  0x3c, 0x78, 0xb4, 0xf0, 0x168, 0x1e0, 0x21c, 0x258 },
+
+	/* LGI 20M */
+	{ 0x0d, 0x1a, 0x27, 0x34, 0x4e, 0x68, 0x75, 0x82,
+	  0x1a, 0x34, 0x4e, 0x68, 0x9c, 0xd0, 0xea, 0x104 },
+
+	/* SGI 20M */
+	{ 0x0e, 0x1c, 0x2b, 0x39, 0x56, 0x73, 0x82, 0x90,
+	  0x1c, 0x39, 0x56, 0x73, 0xad, 0xe7, 0x104, 0x120 }
+};
+
+/* AC rates */
+static const u16 ac_mcs_rate_nss1[8][10] = {
+	/* LG 160M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 160M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 80M */
+	{ 0x3B, 0x75, 0xB0, 0xEA, 0x15F, 0x1D4, 0x20F,
+	  0x249, 0x2BE, 0x30C },
+
+	/* SG 80M */
+	{ 0x41, 0x82, 0xC3, 0x104, 0x186, 0x208, 0x249,
+	  0x28A, 0x30C, 0x363 },
+
+	/* LG 40M */
+	{ 0x1B, 0x36, 0x51, 0x6C, 0xA2, 0xD8, 0xF3,
+	  0x10E, 0x144, 0x168 },
+
+	/* SG 40M */
+	{ 0x1E, 0x3C, 0x5A, 0x78, 0xB4, 0xF0, 0x10E,
+	  0x12C, 0x168, 0x190 },
+
+	/* LG 20M */
+	{ 0xD, 0x1A, 0x27, 0x34, 0x4E, 0x68, 0x75, 0x82, 0x9C, 0x00 },
+
+	/* SG 20M */
+	{ 0xF, 0x1D, 0x2C, 0x3A, 0x57, 0x74, 0x82, 0x91, 0xAE, 0x00 },
+};
+
+/* NSS2 note: the value in the table is 2 multiplier of the actual rate */
+static const u16 ac_mcs_rate_nss2[8][10] = {
+	/* LG 160M */
+	{ 0xEA, 0x1D4, 0x2BE, 0x3A8, 0x57C, 0x750, 0x83A,
+	  0x924, 0xAF8, 0xC30 },
+
+	/* SG 160M */
+	{ 0x104, 0x208, 0x30C, 0x410, 0x618, 0x820, 0x924,
+	  0xA28, 0xC30, 0xD8B },
+
+	/* LG 80M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 80M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 40M */
+	{ 0x36, 0x6C, 0xA2, 0xD8, 0x144, 0x1B0, 0x1E6,
+	  0x21C, 0x288, 0x2D0 },
+
+	/* SG 40M */
+	{ 0x3C, 0x78, 0xB4, 0xF0, 0x168, 0x1E0, 0x21C,
+	  0x258, 0x2D0, 0x320 },
+
+	/* LG 20M */
+	{ 0x1A, 0x34, 0x4A, 0x68, 0x9C, 0xD0, 0xEA, 0x104,
+	  0x138, 0x00 },
+
+	/* SG 20M */
+	{ 0x1D, 0x3A, 0x57, 0x74, 0xAE, 0xE6, 0x104, 0x121,
+	  0x15B, 0x00 },
+};
+
+struct region_code_mapping {
+	u8 code;
+	u8 region[IEEE80211_COUNTRY_STRING_LEN];
+};
+
+static struct region_code_mapping region_code_mapping_t[] = {
+	{ 0x10, "US " }, /* US FCC */
+	{ 0x20, "CA " }, /* IC Canada */
+	{ 0x30, "FR " }, /* France */
+	{ 0x31, "ES " }, /* Spain */
+	{ 0x32, "FR " }, /* France */
+	{ 0x40, "JP " }, /* Japan */
+	{ 0x41, "JP " }, /* Japan */
+	{ 0x50, "CN " }, /* China */
+};
+
+/* Convert 11d country code to region string. */
+u8 *nxpwifi_11d_code_2_region(u8 code)
+{
+	u8 i;
+
+	/* Look for code in mapping table */
+	for (i = 0; i < ARRAY_SIZE(region_code_mapping_t); i++)
+		if (region_code_mapping_t[i].code == code)
+			return region_code_mapping_t[i].region;
+
+	return NULL;
+}
+
+/* Map supported rate index to AC/VHT data rate. */
+u32 nxpwifi_index_to_acs_data_rate(struct nxpwifi_private *priv,
+				   u8 index, u8 ht_info)
+{
+	u32 rate = 0;
+	u8 mcs_index = 0;
+	u8 bw = 0;
+	u8 gi = 0;
+
+	if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_VHT) {
+		mcs_index = min(index & 0xF, 9);
+
+		/* 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if ((index >> 4) == 1)	/* NSS = 2 */
+			rate = ac_mcs_rate_nss2[2 * (3 - bw) + gi][mcs_index];
+		else			/* NSS = 1 */
+			rate = ac_mcs_rate_nss1[2 * (3 - bw) + gi][mcs_index];
+	} else if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_HT) {
+		/* 20M: bw=0, 40M: bw=1 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (gi == 1)
+				rate = 0x0D;    /* MCS 32 SGI rate */
+			else
+				rate = 0x0C;    /* MCS 32 LGI rate */
+		} else if (index < 16) {
+			if (bw == 1 || bw == 0)
+				rate = mcs_rate[2 * (1 - bw) + gi][index];
+			else
+				rate = nxpwifi_data_rates[0];
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		/* 11n non-HT rates */
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+
+	return rate;
+}
+
+/* Map supported rate index to data rate. */
+u32 nxpwifi_index_to_data_rate(struct nxpwifi_private *priv,
+			       u8 index, u8 ht_info)
+{
+	u32 mcs_num_supp =
+		(priv->adapter->user_dev_mcs_support == HT_STREAM_2X2) ? 16 : 8;
+	u32 rate;
+
+	if (priv->adapter->is_hw_11ac_capable)
+		return nxpwifi_index_to_acs_data_rate(priv, index, ht_info);
+
+	if (ht_info & BIT(0)) {
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (ht_info & BIT(2))
+				rate = 0x0D;	/* MCS 32 SGI rate */
+			else
+				rate = 0x0C;	/* MCS 32 LGI rate */
+		} else if (index < mcs_num_supp) {
+			if (ht_info & BIT(1)) {
+				if (ht_info & BIT(2))
+					/* SGI, 40M */
+					rate = mcs_rate[1][index];
+				else
+					/* LGI, 40M */
+					rate = mcs_rate[0][index];
+			} else {
+				if (ht_info & BIT(2))
+					/* SGI, 20M */
+					rate = mcs_rate[3][index];
+				else
+					/* LGI, 20M */
+					rate = mcs_rate[2][index];
+			}
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+	return rate;
+}
+
+/* Return current active data rates (depends on connection). */
+u32 nxpwifi_get_active_data_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	if (!priv->media_connected)
+		return nxpwifi_get_supported_rates(priv, rates);
+	else
+		return nxpwifi_copy_rates(rates, 0,
+					  priv->curr_bss_params.data_rates,
+					  priv->curr_bss_params.num_of_rates);
+}
+
+/* Find Channel/Frequency/Power by band and channel or frequency. */
+struct nxpwifi_chan_freq_power *
+nxpwifi_get_cfp(struct nxpwifi_private *priv, u8 band, u16 channel, u32 freq)
+{
+	struct nxpwifi_chan_freq_power *cfp = NULL;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch = NULL;
+	int i;
+
+	if (!channel && !freq)
+		return cfp;
+
+	if (nxpwifi_band_to_radio_type(band) == HOST_SCAN_RADIO_TYPE_BG)
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_2GHZ];
+	else
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_5GHZ];
+
+	if (!sband) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: cannot find cfp by band %d\n",
+			    __func__, band);
+		return cfp;
+	}
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		if (ch->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		if (freq) {
+			if (ch->center_freq == freq)
+				break;
+		} else {
+			/* Find by valid channel. */
+			if (ch->hw_value == channel ||
+			    channel == FIRST_VALID_CHANNEL)
+				break;
+		}
+	}
+	if (i == sband->n_channels) {
+		nxpwifi_dbg(priv->adapter, WARN,
+			    "%s: cannot find cfp by band %d\t"
+			    "& channel=%d freq=%d\n",
+			    __func__, band, channel, freq);
+	} else {
+		if (!ch)
+			return cfp;
+
+		priv->cfp.channel = ch->hw_value;
+		priv->cfp.freq = ch->center_freq;
+		priv->cfp.max_tx_power = ch->max_power;
+		cfp = &priv->cfp;
+	}
+
+	return cfp;
+}
+
+/* Return true if data rate is set to auto. */
+u8
+nxpwifi_is_rate_auto(struct nxpwifi_private *priv)
+{
+	u32 i;
+	int rate_num = 0;
+
+	for (i = 0; i < ARRAY_SIZE(priv->bitmap_rates); i++)
+		if (priv->bitmap_rates[i])
+			rate_num++;
+
+	if (rate_num > 1)
+		return true;
+	else
+		return false;
+}
+
+/* Extract supported rates from cfg80211_scan_request bitmask. */
+u32 nxpwifi_get_rates_from_cfg80211(struct nxpwifi_private *priv,
+				    u8 *rates, u8 radio_type)
+{
+	struct wiphy *wiphy = priv->adapter->wiphy;
+	struct cfg80211_scan_request *request = priv->scan_request;
+	u32 num_rates, rate_mask;
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	if (radio_type) {
+		sband = wiphy->bands[NL80211_BAND_5GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_5GHZ];
+	} else {
+		sband = wiphy->bands[NL80211_BAND_2GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_2GHZ];
+	}
+
+	num_rates = 0;
+	for (i = 0; i < sband->n_bitrates; i++) {
+		if ((BIT(i) & rate_mask) == 0)
+			continue; /* skip rate */
+		rates[num_rates++] = (u8)(sband->bitrates[i].bitrate / 5);
+	}
+
+	return num_rates;
+}
+
+/* Convert config_bands to B/G/A band */
+static u16 nxpwifi_convert_config_bands(u16 config_bands)
+{
+	u16 bands = 0;
+
+	if (config_bands & BAND_B)
+		bands |= BAND_B;
+	if (config_bands & BAND_G || config_bands & BAND_GN ||
+	    config_bands & BAND_GAC || config_bands & BAND_GAX)
+		bands |= BAND_G;
+	if (config_bands & BAND_A || config_bands & BAND_AN ||
+	    config_bands & BAND_AAC || config_bands & BAND_AAX)
+		bands |= BAND_A;
+
+	return bands;
+}
+
+/* Get supported rates in infrastructure (STA/P2P client) mode. */
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 k = 0;
+	u16 bands = 0;
+
+	bands = nxpwifi_convert_config_bands(adapter->fw_bands);
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		if (bands == BAND_B) {
+			/* B only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_b\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_b,
+					       sizeof(supported_rates_b));
+		} else if (bands == BAND_G) {
+			/* G only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_g\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_g,
+					       sizeof(supported_rates_g));
+		} else if (bands & (BAND_B | BAND_G)) {
+			/* BG only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_bg\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_bg,
+					       sizeof(supported_rates_bg));
+		} else if (bands & BAND_A) {
+			/* support A */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+		}
+	}
+
+	return k;
+}
+
+u8 nxpwifi_adjust_data_rate(struct nxpwifi_private *priv,
+			    u8 rx_rate, u8 rate_info)
+{
+	u8 rate_index = 0;
+
+	/* HT40 */
+	if ((rate_info & BIT(0)) && (rate_info & BIT(1)))
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 +
+			     NXPWIFI_BW20_MCS_NUM + rx_rate;
+	else if (rate_info & BIT(0)) /* HT20 */
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 + rx_rate;
+	else
+		rate_index = (rx_rate > NXPWIFI_RATE_INDEX_OFDM0) ?
+			      rx_rate - 1 : rx_rate;
+
+	if (rate_index >= NXPWIFI_MAX_AC_RX_RATES)
+		rate_index = NXPWIFI_MAX_AC_RX_RATES - 1;
+
+	return rate_index;
+}
-- 
2.34.1


