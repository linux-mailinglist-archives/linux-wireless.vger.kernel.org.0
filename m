Return-Path: <linux-wireless+bounces-29030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5202C63B3B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB183A4F9B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5E32C95E;
	Mon, 17 Nov 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hyRvlLs9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0B32C940;
	Mon, 17 Nov 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377327; cv=fail; b=EuK6Kodwx576huffgwIXhZyjVolTAB76uscpryfd0Bv7rdxhczleW7TKKizK9KsKK3o0yf6dzkHteGoagkN2DAMb7zqAHqQ2ayHU+q0HKi2ozk/1ssDdyKF3zRiLC8yGzCn66Iip0nCAjwvQoT5jtWaIXoQa0E8wHXOi7AW+q1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377327; c=relaxed/simple;
	bh=X920r6N+3LNe4OtKDA2lkjFkuKHQlmb51XZ8Ju07T+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awwZe8QQsvzq/XH+eUdvd3JBEGG65zKRXwjE9Kwy9ncpMyrm2x0tc/c4c5xIbzMHKZB8f5TtAG4wJ0umqsJQE1USM4PwG5PTku9KpPNJGsdeQkoKbDKSjC06erfqgShXA8fuLmZWedzXUxQbHpiS8Yc4jaJ+0Ixy1CZ075tgM58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hyRvlLs9; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hv42GBWeGS7NmyGHmyrnZM17TxpvOYIZKXWtpz4XoH0lrhOTkVnE7GBwgrkonHKbKHHUVRfz8psjgKXN14uqcEAtM8wtefWpd8KoFwmE78mk+LiapZ0aFCjG5LRVi0D5qsgaV8pnd6xoKNGIEO9//w22L1RwK7lRIeWNjvUY1AloesRQkTjopsWPjYQ2E+zZhCOiykR/4ZovIba/+FCHVZFpjfhEqw+xsOS5KALfL8Q2f+826Qzl/Dr2xZG2hvJTqUSR2Vv4hh8AVjrn0aDVgBuIyUGXUN3lv4WeKv8ndyHi1g+o4Zc0wRAjqpqPxcrkWK83gFN9o90CIBwn+eSlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=126WcTqRxtvLGTqLWGv5nnX2tiZEA/vuFyXKJlG5+A4=;
 b=xQSm+XwOCW9JrAYrSZLg3Tie68YRfGdjEqZu/mD+8UTDQAM7qnX+kROnvMc9/Zpooedod65xv7FIrxtJdMMf7glQ5Fxg+geelzqPhuXr0L0B9gCcgSRAx+xGZL9jjTMoppdDTx75UxdKa3sVgpKBoSI/IM8mu+rMALWDKLC2RfcsFMLnkMskey9SLzVYCKlHOseqUb/1Azqt7eTtODblqHV7UBcbJfFPZ94Tqcm55tA5dCN0gy1rx/ismTLiLa3UTJROw6XVSGhfSkVL2Bgi9IHfEajKzDmrF2hrbGygUF1lA4lJVnuLsn4QqvQtM6Li+nossNrdHmFnpQU/MGhF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=126WcTqRxtvLGTqLWGv5nnX2tiZEA/vuFyXKJlG5+A4=;
 b=hyRvlLs9eMPFQ38AzgnPYh7xtb64vpPp5rJEvWU+j708TFH6YhBJSJ0y4fabo/uns/QE3LWG0tKDWeiGzSaidMJ3K4z8HoCKPaE81CPCrPXGG/wcJom31k3Y1PqC48OB8ZMsi8fxpfus9AC0S/mBzClYML1ab0UREr52tGGKqQ7f+twA6CJuKupgpKyI40BhRJUvjnlbiEMEVW69Tzh0Gbg5MaFOX/8FmRxBtulGLECrsARnV323281aXiKCTP2roWJJhsoIUJGqjMLnFXMXe2pT8kw0Cd+NWag+DHUqdiLtcxuGruoA1BPLf5CjDinp4X0hHxZOH+iE3Rb11yEUfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB11542.eurprd04.prod.outlook.com (2603:10a6:150:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:01 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:01 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 04/22] wifi: nxpwifi: add support for 802.11h (DFS and TPC)
Date: Mon, 17 Nov 2025 19:00:28 +0800
Message-Id: <20251117110046.2810811-5-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB11542:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a3c0f9-1649-4f98-9ac5-08de25c8bbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TjCBifpSbNR8ofwMztkLfWLWbrRsWbb14ybQJVcG4cl8UOnqSU5wOS0ILNsr?=
 =?us-ascii?Q?o0HNgo2dYJL6Ti74aFvtniDBAtwRRR3ML15gF+Kg63PEDR1ay/WxYTyHtpd1?=
 =?us-ascii?Q?RZKjdB556IVYcihWmk6Z/IvmCYe6pyxLo7qL58bMOgapaUa12O4if9DkhDyD?=
 =?us-ascii?Q?GIUUo876R2hgr38Da7OaBcEMv7dTy2IFe5488gFKVmOo9eka4zKdsHB5Mfv1?=
 =?us-ascii?Q?xhzJXKN3cpptSAKF1J72V3+Jf5tcPuW5LryCVGa6tI6szDXVyRNdc8YmnVRt?=
 =?us-ascii?Q?O8JGJS24lPJ5DSUgKy6ij4EYydvvakkdkQr9/6+iKXCGKCj0PianaFIyn8O8?=
 =?us-ascii?Q?8llQARd0RZApzTZf8BWH/X7jLo7F1IiO4u8xN4ZK+tnFgG52sajpJBrPlPEP?=
 =?us-ascii?Q?lL7yoMHvSPFsbUd1xrBwXeuZWge8tMGBwexRJC/REtEofJnDlPmxoXpMl2kr?=
 =?us-ascii?Q?2GHuPD3Q55S/63JLMTvw/9qp4ywNHo1to3XssUAB52v+0jENiZF1I9qOHnP6?=
 =?us-ascii?Q?TcWrTo2xqlen7yHoyTMkUMBn/VrKVaqHt60/LtEZNd+gdIAXTdUBOYHTAyqr?=
 =?us-ascii?Q?TFzSFB/SPkbunEoPBIjOxudWDv971VYfboUFv56up0v/XmqHd0kV2H7iD6tR?=
 =?us-ascii?Q?5opVtNVhn0jOQiGCgB4rT9zuBUy78S/29MvTybqMCiZoZf4Z14ZVUzVpq1V6?=
 =?us-ascii?Q?LuuXRTb/tTSpnGCKgnRxH640iGbyrSosEZH+J6XtiyE5JS1Pkk0SthvHAzeQ?=
 =?us-ascii?Q?o8uOLQQ/2AZQb2dBP8NCZ7cdOjg6HWXHot/pfLCCeovTQrT4iw1RXnL5n4zb?=
 =?us-ascii?Q?A7zZFn2EqPDF0nDx2rpYldN7KSplHQHcFphiew9C8BpInyQuP2LZa92NHPJk?=
 =?us-ascii?Q?kn0AzknGaUpkGAs9Q1K96o9SN1exOkUul1uVFQPchG7rHfg34l4/jyh4i4Ud?=
 =?us-ascii?Q?T0ajUtQNN6jaqCFR4EE7sw2u0wh/togTlp5s84P2E4cC0E43+zkOhEFGznRV?=
 =?us-ascii?Q?7+F6rBl65jpcvdURDQ/n4HLlIvC6OgAJH6Iejf2GCMpqMx4zlSBJfLXfN+/h?=
 =?us-ascii?Q?TQiqqpIENaREl1ALbIqmt9/y9q0jhX1wj9OyYE/dGazUnzba65yU0onbl52j?=
 =?us-ascii?Q?2MrdovKkw4PGsXdUYmPK+cCoe8L4Oa397csPXhKHl27hlMBMaBRnV6fdNTob?=
 =?us-ascii?Q?Z9oSCJC1/K+V0xp8Ers+PHXQzv5QwzVjSezrOPw94jvd9FsB1WB9TuaXjGXC?=
 =?us-ascii?Q?LUtvrSTYQzhoAi06qWXBVSCBUFlcAb94Gp2Fl95SMfBXfuDzouYKlmjt3/tv?=
 =?us-ascii?Q?qSIZl31mpl7EJ8jqIzBbRREfz4FrnIFrRO7tCqCnGAyal1HdlnvLnRsEAi5W?=
 =?us-ascii?Q?NIK4DCSTOeEgUQzhtQqoVOEbg4RBlNkG1B5Zwb7mTUSnmeOexA1ij2WMNsQ9?=
 =?us-ascii?Q?UuwPcMwKwFdABrDQYp/oGVVrCds76JttXSMi3+CPg8urCdToPIOsEQscrNfq?=
 =?us-ascii?Q?pkI/XgNwmKxzA6nqGCOngauh4iZnK47omFFB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6kAZPoYmDXoShv4pO07upF/gYvehs/sz5qXG/qzRzXUixA2gZTnIjaMcL6xE?=
 =?us-ascii?Q?pAwK8ak+ufDyh8nLNosWpnhmKpKu/B4GZeCeHTeUaekoyoa+QYWxCQ5XkDsi?=
 =?us-ascii?Q?pay5FgJMW1OH+hqTNz8Jk86DD3Sc8WIZ0/gDTWGmT16xitDe06Btsd3Fc5m5?=
 =?us-ascii?Q?foUndRBy2mQqIma0XlmbQJLDOZcx0bhcQ1DOV9um4vJN4ZN1MLNJ5zXssiLK?=
 =?us-ascii?Q?LpJCKQC4Ok/OU5K8JET7kYen4Rq3UstSuZcojHK1vDyBJLWUECq2wKdHgRug?=
 =?us-ascii?Q?WUCi5e/U6/JwhdfGa3Rul3U8JfzENqSXJXbPg6Vjr+oikt5Yf8vpGdWp+QYS?=
 =?us-ascii?Q?OK3dVfuaq633F2uct+ZPaRmQb7nGBqtcficRDAZD4BT+Kn6kjHgelCYR4ZT6?=
 =?us-ascii?Q?xcjZ+Jy629AaLEOiSJaGHjLIRPZwrSCDmM6aHeKMYeuQQHegZyS5lAK/q54/?=
 =?us-ascii?Q?dMS5an36ylQ2qlK6tOft0QClVT7pCpMLW81g/NKYKJS7df10Ex+hFQrQmFQ2?=
 =?us-ascii?Q?1dCzsJRZdd2nxo+KLORXO6gtrUN3+p1pRsdd4T9iQXQR74wq0FesYsqIWwlk?=
 =?us-ascii?Q?b3nt+jLn9Bt/sMMpddZ889QiTnaqFX+bG7fj0NmEqnBugqwqSS3OEQKVPtGh?=
 =?us-ascii?Q?hO+Ii7CENGgRp/xa3gCgam8LlN/NsOvwM3/+6JcUU1HG0XxVo57wZBY0786s?=
 =?us-ascii?Q?5kGqEC9aclCN433y0mVQ3z+xy0C8ssZqTysEN2p2Ahj6FcAKbu47urWbkBzG?=
 =?us-ascii?Q?hXbW59jhhvLjq/ZYoYgJ8r5v/j1F5xi7I0l8U+cafZXm4ghxF3R4WV3+iYog?=
 =?us-ascii?Q?cTptkszAfZSa2XfxjEIxEiGqIJTLXG04+SbwqZJfuph0RCOB3MzNWw8WL60c?=
 =?us-ascii?Q?8UCnEIiKTKoAT+CG0FVXgDXR5v7/19RFp0T0TqfZaAwY3E6uwS5KdgJb8fJ9?=
 =?us-ascii?Q?S8wX6UN/NjbpVlfzAr9E8yp3CqiC/MYiTBoXDEBib9ExfbDF7VDhtK6PG7JQ?=
 =?us-ascii?Q?brrUKQMhO01yWlLCsUUiPVv3Fisvgox/OldfyC1l+SSv9dDjhL6urZAYs9Mp?=
 =?us-ascii?Q?3mUJP6bEeDa5RGq4rCg8jSMDAu9NOACq34/D3fJ81OBXDBUepmVEKKCTX3Zw?=
 =?us-ascii?Q?rfdqUjBxgmi46T0Cd+wb4jNAmLvMP26L0yJCWNcFWv1gfpp7hVsR3hMPkSoY?=
 =?us-ascii?Q?Ki5gDgQsLOtdKp39GkT/PECV0rTIWKz6WoSNjPU9zP7WqdWpkjg6OIQUMSLw?=
 =?us-ascii?Q?DhIPvQ/MH0DyYFSmPzrHgoBFP2uuPot/whT86WZaZF2f69D/LvIHW4ac5o3+?=
 =?us-ascii?Q?77xU4Hxk7k41CYU8oUySJouhri8p/g0OmjdrtYO5WnHYUxe+B4FykjJtPppJ?=
 =?us-ascii?Q?wFgGny5IGJLqKAoiaY2VB8Lt0q0e98MUKgg9OjF4+L/4qxOQ9GOq40cfUBA3?=
 =?us-ascii?Q?zyBkOwMD5LdgdW79TUCJvSccqnhO73QgYqow57f1iTzt/wHnvOUuvdhgb/Dx?=
 =?us-ascii?Q?EEWTm8du+p9z0aTNzP+4S2XdyC2Hs5dPd/eE7q/+TB5mbIDMlydcUBBvG6v5?=
 =?us-ascii?Q?Qmmv7fjWA4C4DuGhZG9W5rP/tKDVEbpvSf1Is1Ik?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a3c0f9-1649-4f98-9ac5-08de25c8bbb4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:01.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UF0V+0w+sDUW+pQoL9F6NuSvlZaFoJN/arTnzAXZmgGJN0Rr1iX7uj7RO2ON+ey3M+kqrZm0BvTUArbLiOZAMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11542

Introduce 802.11h functionality to the nxpwifi driver, enabling
Dynamic Frequency Selection (DFS) and Transmit Power Control (TPC)
features required for regulatory compliance in 5GHz bands.

- Adds logic to handle DFS CAC (Channel Availability Check) procedures,
  including radar detection, CAC timeout, and abort handling.
- Implements firmware interaction via HOST_CMD_CHAN_REPORT_REQUEST
  and radar event handling.
- Supports TPC through power capability and local power constraint IEs
  during association.
- Enables channel switch operations with AP restart and beacon updates.

Firmware is responsible for radar detection and reporting, while the
driver manages TLV construction, event handling, and cfg80211 integration.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 346 +++++++++++++++++++++++++
 1 file changed, 346 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..035aaa1a9a7e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11h
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
+inline int nxpwifi_is_11h_active(struct nxpwifi_private *priv)
+{
+	return priv->state_11h.is_11h_active;
+}
+
+/* This function appends 11h info to a buffer while joining an
+ * infrastructure BSS
+ */
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
+/* This functions processes TLV buffer for a pending BSS Join command.
+ *
+ * Activate 11h functionality in the firmware if the spectrum management
+ * capability bit is found in the network we are joining. Also, necessary
+ * TLVs are set based on requested network's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability
+		 * bit
+		 */
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
+/* This is DFS CAC work function.
+ * This delayed work emits CAC finished event for cfg80211 if
+ * CAC was started earlier.
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
+/* This function prepares channel report request command to FW for
+ * starting radar detection.
+ */
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
+/* This function is to abort ongoing CAC upon stopping AP operations
+ * or during unload.
+ */
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
+/* This function handles channel report event from FW during CAC period.
+ * If radar is detected during CAC, driver indicates the same to cfg80211
+ * and also cancels ongoing delayed work.
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
+/* Handler for radar detected event from FW.*/
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
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
+/* This is work function for channel switch handling.
+ * This function takes care of updating new channel definitin to
+ * bss config structure, restart AP and indicate channel switch success
+ * to cfg80211.
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


