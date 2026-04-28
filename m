Return-Path: <linux-wireless+bounces-35522-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGpOCakN8Wn1cAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35522-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:42:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2F48B41B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E716E3015FE0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072F38D69D;
	Tue, 28 Apr 2026 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JJHTUF6G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D138D69B;
	Tue, 28 Apr 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405320; cv=fail; b=EJCbib4l1BEmfQeT+Pgon++RGbnjlKbFzj7t/WiwgXZ88E5/wRgdoAERBdspMs8jPCurhCzBy/NrmpsheJSDI2Q3L5eqvgT48dd+h+4Z8+B3FcbgHQOZBYiQhPJGTGJGEdDnEtq7n/mICDD46LvfouYb4DErw4d07l5R5ssNoKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405320; c=relaxed/simple;
	bh=k6u6lA9QYvQ644Nt3S3rifHTqv3J7zNxMjk4SMyS5Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWocnIYmh2TLccc2zzkexxrCmMNYV2x2+1dZ1kqizKuqqG5GCvALSUXqKQQQWyQjlwshKm68op8TSRIa9pOnBVek7za1UBKWLy/MnlfZBshQ4zpqw0fi9MBQdAF3lwdE0983W2Je0iunQQDq0noz8uqGDYSgxOy/r99DdUJdROk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JJHTUF6G; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwoVk4JAgfGTlJkkllrQUhlbWCKHGP33Ak34NGGW6Dhda1TPDPT4gViHkUolzntSEgQJt5PyE2LfCpDITMH2pX8HcjV47giNK0dfWdYNEPadsoJ0F/lWvoETOslvvtSCUB5y3CfQl5b3220zNa4rieVKxSyr1uGEJrlI/pS5dF6TtoEGnAmEJsTWQ/IZFP+D/PWVJc56bCWv7qRjh3T0UpV8hQneeQOqj+anxxYwkHlsF2b0yflcmln9ixuKZwThvDaWbcVWdTStqeL8zhGFXANDLcQco2QuG3gvn2hcxUzjAnZ3Z/2fAJqT2Nm3Nwqo0LQv1oZ9CGbvw9jKcVcUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqUuVPu1I6xDYh9gd7f4BVIb1elpEunhPkFgkbQ5WgE=;
 b=DABM0vMdVxQ6B+LeBxDT5uKVwSp+XsSeIEp4Mlc42/k+AJ1GLoVHiKsaq7E13GlxRY1seq39UqZ2G6SNzHYbaMsCo5LUsAsYx0E0SIquY9adtsK3L/2E2ua5OfU4HqyyF/AQyMNJ2GRXPh926FLsUT4/LR0PQZ+rO5qGFxM5QoEMX+voWGETBExnFu09+fpR3EwqHYxhuIeAD7uX/9MA9CVj/SVrljvuu+KS6cTQTpA2Fy9YQc3wR2bV3uWkPRXM7BGmGQKoAAScmrwIOv/iJ1AIIqwFahJiepwVxQBq/ZsflKf5cROw//7CPuEIo49TzmHUEItknBDaRKHiAFI7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqUuVPu1I6xDYh9gd7f4BVIb1elpEunhPkFgkbQ5WgE=;
 b=JJHTUF6GCVPl7mufz/CFmBqfAu4GnVrJM3qEA7ZxlFGTqBgdkmcSW+iNdRm0Ux+Tg/HKw3xUlymdVpNrjgjTRsXj0/Wn/JMrIF6F8OPVTQULnWeUecqK9uZYmfUTEShZCpchSCHfbjQpQeIuy0Ps5aiAgYxuI73bXwlgfF5Kb5nGspMv1D65ExzeBaq8e74oQixfce2aXLeP6ds8WL/+kMHmwzayKAvL8HdnhO5WEybaFKFuNjYjunWmyGJM0A7aaSZ2kILUf9wpuVfqyPh3iHaITT/kBAz2thJhitaSQIdQR781HQKuMmUQnMulton6QAT93gL6Mzcbkqw0pfR2aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS5PR04MB11371.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 19:41:46 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:41:46 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 09/22] wifi: nxpwifi: add channel/frequency/power (cfp) support
Date: Wed, 29 Apr 2026 03:40:08 +0800
Message-Id: <20260428194021.785252-10-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS5PR04MB11371:EE_
X-MS-Office365-Filtering-Correlation-Id: bc143809-3c97-4cbf-6e8b-08dea55e2e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	FNEtg3mQ+GLkFd5nzNisK+UwqoQzy3JYqXg0tNawgwobESgf7CjIiV+XR9r7jIP4nUbY/pFtL+1oUo0dvgp3oZDpHuQh4OgrlYo53Uj98XpoY7pxhz6VxIoZ+glbb/dAUMvMa1M+pb4his+QVFrip3ZPaQUfE5ejK9ia3mwE9iWLB3MkIlyuqIJwss3G5E5dNP+tFScORu8XloCCMGfpxF4Kcy1YDdOwrle8/4YWCU481Ni0XOiKMybb7kH8cB1xd+Gbo4NuC3Xszd6t65iijzsrfokQJdNREhEk7Hgi2yOkxMJqZ3dgxZXmipsOeE44nsLT3kjJiORv2uN4ALsheBFX2+H861t2Zets5RXMkVJCUlWsiRaIwqC/UfEiu+BXcUbfG2zNy+oh8CzVcj3Tt4et1zJqD9LJLHOR7Mi/m447Ce0bBKts3SwxmltUE/pzSLedh0uQKAME1o5uWXj3xzWrf7DShIK91R94OS7lyBcMLKXecz/kXC1dD4xCtwqx1VmIY2gitrmOJQCS4xZ9g10v6ENN3/lzDgzv8GVAx0Gp05ZoS59L/GIweZDUiGEZUsXyhq4xP51c0ZCWpXVmQj+YzVPPvWMlt1Fh3xAka/gKgLItr2R9O0GOUnAdxXCPtYYTsUsbk7U+bgRFm+5tN4XqOP2NA58UBxyiS91BpoSw1TSVH/fM3miWKTk0099n1SrmmCTRx9Ko7ILlPHYUCnw2/IcLJu+gNHD5cp0YPLuU88+UVAtL6ZHiMdlgiW2+iBGPiKwoArAwrtgycJ/sJawuYtikfVwoHx6DCOfX+38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+gmnWJfDEUhCJWYxZ4LEODoCZd+lo3MRWaBu4KLZ5O+qXButHO0wdI1ijpa?=
 =?us-ascii?Q?3jfMB5hZR8ZeE3Ijfq4kG71INR5DCnPzCnAWoeigGs2XHUcjWE+iIg/yqtyq?=
 =?us-ascii?Q?HfNb6DQB+ra1ccQVMqCUEoXo9vWWicOHi7fdJXyJjVV6QIko9BWsXpTyBvov?=
 =?us-ascii?Q?f3vdC4I4O+t+8G9dlrMeddVFvKgA7/Yw6ACVz/ybDlcrmn7vVsRsIOBAeXJw?=
 =?us-ascii?Q?+R4Jqlq2vDyr+l+3SR8BrqDgPXecAVqIYWkCJeiyHthGeHwq1n6QiFTZJLyd?=
 =?us-ascii?Q?yP/F0vxoFB7f0SoWPUSi/tm1fuTKZ6DtNH8gQznlUl2GoJkQ2wVrRqLt5ZPy?=
 =?us-ascii?Q?JwJd2Eb0rM8sLypX87evzsaIXTg+PO5diV3U9FxNpqfdF0E6eWhy0oMyaGmu?=
 =?us-ascii?Q?rSrv5dPmChLJifR8z0/OdTGLdxyTUYr30c344J7vJiNyOiX8kZC/fwSZx10q?=
 =?us-ascii?Q?3xkExkaL1XCVLAqpUtjk0tln65TTo6aoPD/2S0lqGD6m7cHQ6xefWqYLlHxg?=
 =?us-ascii?Q?QQFEp+M3SKZ4NTBXln3VFZFzHuzIbJyRVP8vbOnMrhALxv0KRzo84mNiMDeL?=
 =?us-ascii?Q?vPgq1zDkMtJJsunrsZBplQiVOzNgx5KTDzqbyW1/1WC/Wa1Bdrfv+gjW6K0b?=
 =?us-ascii?Q?Hfx0hG8zGc7M+vNrNh/0BCqSIGrSfYB4ONhrjzspa23F3rKPOWz1aVYdxNXZ?=
 =?us-ascii?Q?hyKyqGdWLfxAKuAlT8L4WmWKRUwK+8XQYi1J2B2g4paH/hq9/70JgYVA1iSf?=
 =?us-ascii?Q?1MdNp0za6jz4fv7Xlpj7MK97ZqP0Ifh3zoA23YBZ83zERnhywU+l+e586lpw?=
 =?us-ascii?Q?gSl+2tGcw5fBkjxJFpGpqd1VWrm0AdzMk6qojZpG5MBAWPEPrcQWi0nZNw8p?=
 =?us-ascii?Q?+PixBQc+r+/yXTsYo8Q09L/U9foJdaTZKPgzzWRwauEagmNXjgMuojmO6+GY?=
 =?us-ascii?Q?FLPzbpY08g5CiykIeoBhX5Dr8+4EvJmj7GTcuakdAoFLK06zKlA6PRAxBbnz?=
 =?us-ascii?Q?BfNE7DO00TcX4XF/rwznM/wKi2kaWOcTxrdvtNS1LJzSMXqWhvIWnSJvDR6z?=
 =?us-ascii?Q?GbGDg/vV+h4M2BSYoL9v3I/9FyJBQfqf0J3ApC+aCnYqm6Rv0E797d0kBImu?=
 =?us-ascii?Q?luoV5miHx7sdGCkczwSxxilBqS6RWFjckmIGgHW0xfKBpMTNCXb0HWP4F4PV?=
 =?us-ascii?Q?i4CyvY3b10JVWKrXUJP4ovSS8tLh9CN8Kq8qCiciZ1SmFg5/P58Y8xZBEwXl?=
 =?us-ascii?Q?toHnnB6Px+lKSEvDgRH5Q+WDqeTPhzDHllD98qqK/zySHCTQh76ntv/iPQkK?=
 =?us-ascii?Q?+djttiXCVvF3s3nEs3c0FbSS49x6c+sAI53JbUI42Ks6k0V0/SZclSfbH6e9?=
 =?us-ascii?Q?Ez2CYsfJj4orq099XKdPNDjk7/yr8tXGTG8xYh8i/X/le6Aq+5xCrBhFts0D?=
 =?us-ascii?Q?vWpBE+6F0DIz1Qdj+8aGA9yikSwYIoubxiM7WwBUC1QZy3S7XmNb/CwUpQHJ?=
 =?us-ascii?Q?xklZPeB3ytYAWKMtG8HEqOIaeFkKdgG+znfjtDxYGJ0Earl0vB/0Wt60am/3?=
 =?us-ascii?Q?SpNwVH2yZos6FFIABhOp1Suh0XuPU2+JgxSCqe+TMsgZ9C5kMf92YLLKJIQ3?=
 =?us-ascii?Q?Q5aZFIJy+ONKpOt3RRy4PPPQhCW4XMNiYDFtoXMLRu9bBPra2sIsEJ6WflBD?=
 =?us-ascii?Q?qbsQF+LbtdpsoR9UM/TbuCHynnEvYOi6v+lMFjquTPAnDFA8uqhDUNH2PCkk?=
 =?us-ascii?Q?JOexPqWdgg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc143809-3c97-4cbf-6e8b-08dea55e2e65
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:41:46.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QJ8qGrA7byPb2466ZIxm3YLS9S/tryX9CbKO5iWJki3W/SJkRuoE/vhB4MiIWEmn2n5PZKqpEwnj+t9l79CDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11371
X-Rspamd-Queue-Id: 43B2F48B41B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35522-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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


