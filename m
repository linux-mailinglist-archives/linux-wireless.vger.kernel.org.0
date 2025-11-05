Return-Path: <linux-wireless+bounces-28582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC88C35386
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A38004FAB93
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49B30DEBD;
	Wed,  5 Nov 2025 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l4vqtVjL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48430E0C2;
	Wed,  5 Nov 2025 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339755; cv=fail; b=MlXh1Utn2fB/KCwhvZCbST8wnvT54orZ5sAcamL0PBK7V8l4jLLA2RgLgDmL4kfUJTXk4y23iUp7HhfY/HTU0i/D6jcVINkWspPIuIV/Z+ZgxoaqYvkAKLuffc38vc+ypcTl84gjKxVvRYQpig6Pyy14cMiMZontc455cZP9bBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339755; c=relaxed/simple;
	bh=X920r6N+3LNe4OtKDA2lkjFkuKHQlmb51XZ8Ju07T+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLYkiv+DH9ZGVX8k350uem/8+245Oq0AsGEHuZFzy+UKVOcMEG0YQ6KJ0dqhtYCMXgNHTmXbBZwccWsiix22vK/LCa2WrpYmf+72tEacJbz7GRubyQYAIAhFxh7oz4zdwFHO6moz8UEGzcb7GxPfbvdZUPohoXAJM5u3DBzCCHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l4vqtVjL; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzuN27rWl3eaY6VKRlRNrSmtK76XHOBN8Gc3aaChpT4zhjOa8PjDwSR4b68jaKbK+grVJpsDHdHhCaHP8gkhDhZ2PL5Lbux7vIFFjS1FH2VNl2A0USB3tk1/D6ia9JKT6ehr7UHe4My84wj9ny4HicMMxn6N5xo7j7zG2ITKollw4oOLwrwIYqybptJHXUMxv7N2qNREg306zNovUzF82GkLEWHbNQgv45gOa9ZC/CNHV2ThNvAsQkXPbNHuAYRGwUMOMzM8BzXKIyQ1DJ44qLnBPl2NtCTwBFVGwKHQ0L/WvoVvO5Y+3VoQar+fQrFfjFohWIIzkp+Oqb4Mn6ZOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=126WcTqRxtvLGTqLWGv5nnX2tiZEA/vuFyXKJlG5+A4=;
 b=q/q6CG9i8hzkz31REknbYuIO9DqfsEIGp1Kp9b+Q44jS7wNY0w4YWC7Qnqpj0616SnLcJHIRHoABY3g96nGWfIzvc7SVM9XiR5HHDS0tncCez47njCxhQPxQAFE/yCRCvHN9hW+51TDBH6iY7N3gApBI0rCB/BGMlb8u8WtlA6QsVyYSn54EyTxfhkBICqeQfAqj7iwH/zYK//Wp0ArXvNZTtm5IWOkXLZ/3iVGuUi/R+OCxqeVdBHuh35IEwr2A6bc7sbtAwYnJBXvcwQ+hLqT7bp63DiFrGiAaRCMGOXs6U+Ft4nyPO2jdh0TIpXfoo+mFmQ41Rer78BbbCWGc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=126WcTqRxtvLGTqLWGv5nnX2tiZEA/vuFyXKJlG5+A4=;
 b=l4vqtVjLWil/kG0YzdbInzWa+mfrMOIYL1+45wtuDBT+YNixJD++aqXFWsU48tLqroaourwN4Jq9b5x5N+K/o1OgY5a4gNEz+OjjPjcoFDNfodYWZ8d+gLKQLOYbfuH9OcGLOPsMQZDkQQGx3GIndH1yJv0TWTHhT8p8tyjPNauNTCpB7Ke57a3zQnYt8qd/t0/SIN3fBlp9WLh/q7d9PYcObGKVpNimdd+TXm5V/+MObnVHgVYaRHZlqGAnOv4SVcZThfXGsJn943gOVDr+T8deykm9Tf3/sSJzsWKP28iYuk/iLhTNR0ernjvgsb+BkAGJccgYrYn0kTE656l+BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA4PR04MB9293.eurprd04.prod.outlook.com (2603:10a6:102:2a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 10:49:08 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:08 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 04/22] wifi: nxpwifi: add support for 802.11h (DFS and TPC)
Date: Wed,  5 Nov 2025 18:47:26 +0800
Message-Id: <20251105104744.2401992-5-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA4PR04MB9293:EE_
X-MS-Office365-Filtering-Correlation-Id: 5079e0f5-3aa5-440d-3c1c-08de1c58f206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NTTn7OO9WejQtLT/Rz1aMllJt+Jt/LL3PNO578TKY2g2s/mgGTJhaGQjHQj?=
 =?us-ascii?Q?t0UHo+rMBwUM71bZimFB2iBg6u0L97pXVqgdjyvXdfRXGc3kxlCoFtGXmxzw?=
 =?us-ascii?Q?KJy+gSc7Bsg9ATg1s7UcRt7Sw+xl0j4k4Ul/8ExT9cksezUpm89KfFs57yJT?=
 =?us-ascii?Q?9rtWw+lxELM6meaFSqlGZm0lfNqfL9E6CJIR3L58p18K5Nf0QD/EzDjDNVol?=
 =?us-ascii?Q?W6OMAXTRQTQ9UczujoY4CDfylB/RD1ZRakrixdTx4ZVqixjhpXd2WBhYW8I7?=
 =?us-ascii?Q?1uWPJj/Kv5syGh0ndsbX8jtfmBeAGXIk9ViSYJtT4fzWAmuYejZ8XdCmKgYu?=
 =?us-ascii?Q?x6RdpeMb2rchk75kkkfSdthv2x7ZxpyYWjfdgAanu71wutLGQHfGa92Q5oL6?=
 =?us-ascii?Q?4NLxqbRqb+ONy4tutAxTjdkMV8MLcj72dPAjxymlr0YVh+Q9SimSnxMnMMty?=
 =?us-ascii?Q?P6eSd8LU10tHpvopUlG6g/sQUA+ilAhHXwcTZjiZ4IOutovD5aHwUlSpwzXF?=
 =?us-ascii?Q?T9r4wK69pwbe9y1KBM92xM8KLH7yxOpwLFAq9hbS6ftt4MboQ0hp6EmnuSJ5?=
 =?us-ascii?Q?p22x6Gfoza3SeDmywIIni0pO0C82+lKcRQNxlBlr9H1UwZAnJngn+fQLxeQe?=
 =?us-ascii?Q?k62LEHhQ3+c3el1yltViTGzKNTFdBjZ808+At874MHEagM9TIPmYvgTygz+b?=
 =?us-ascii?Q?70tSrcBYY5Ly9iFRtJU9U6mZq4toVzfkXdbuNwSHsqERa4wjK/ADICzCHpXD?=
 =?us-ascii?Q?H1LaYGqMFComEy1pmTskuIR1YpnUcqOcmYGLCMjzs5/FGdqepylI4O7A48Cs?=
 =?us-ascii?Q?OTQFaHoJf4TEf4Z02xXM7VrNUBvnlpaeWNOPaI8M1kySdI59vM/ff4UruBSj?=
 =?us-ascii?Q?AACyBst9sHi++TgB90TvZdSN2ral253eu4aH0wYqh9n9SSMe2eAH61Y2RYSu?=
 =?us-ascii?Q?tbbdZliEh/NepFMSXXvEr/GYDQYzbNcfezw1oPzVZZKIxAIMwiB5IuxrlyxV?=
 =?us-ascii?Q?m/Qsm7Xlo0ZvTBbzgc1bRCol0XOSoa88VpZ2rVtK1qp/0bzJFlb9XOLisK9h?=
 =?us-ascii?Q?SRJL/EhbPVzQjphBHIqUMGD0adtwJFcpLYzO7lwspJQcmN8CnVosVEVWB/c2?=
 =?us-ascii?Q?EIcVjzkIXTzj1TQmXQLMV/Rv8LzgMMajoBv5I8OReRczN92S8Z/NHTNCa7w4?=
 =?us-ascii?Q?9sFAZ3EEwuGY2+s7bXEj+osKA0z0WBk4urGr37qxvugk8cfvzOnhRfa/8x2+?=
 =?us-ascii?Q?WGFpzzO5NMvREdqX9yL//oeKJ1C/XvwSW3R7Zl1+Oi3q4kJ7sFvLp35eo82j?=
 =?us-ascii?Q?U3CckDpZNWnr5XIlTl29S4CMBVwJlfcIf1Mf0+nXHuY/RMS2YOiwZnr+qU0i?=
 =?us-ascii?Q?I4axENFJMhQ9p2Jx1tb22TzqCky+zj4JG8CWk/kDXy7vRk0RzgI3ppTlGwYJ?=
 =?us-ascii?Q?5HCk+vZLCQIjiTo2dVarB+1ctTH31W4spCUS2pyvUavDer0mWV/qCCAKDHWw?=
 =?us-ascii?Q?AgC7NtLGLkBbfIauv8bzM5pzP7z2IdKyqnhW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+C8fmf9o5JXgKLeVCZuwVNkpad//C0aCtFaRFsUYVSG+kuspmLy6r2pXzSd?=
 =?us-ascii?Q?ANTSspa8keosLpj7tsx0nuoQTjiN1ykgt/FX7AFd9sEk/ZawKhqE2OhK+4cc?=
 =?us-ascii?Q?CrNFr2wAB4+qMY+hp/x2yy1tFOwkcPxy9wax1D70a6FPoljCSRryUSa+ePrD?=
 =?us-ascii?Q?LN3FyGzea6XGpxeGaTbFL1vmS0MP4SGlQY/fMmkW2ZR18n4P2zXOU0tHaPNO?=
 =?us-ascii?Q?KKLSnPliQNQxllFQi99SYAu+Z+63C+Ahu/KxTp4ny1+MEvAqODmHumLKGwrE?=
 =?us-ascii?Q?4mDtPUAYRE7Yt7EiBxH5mzzXvaoiUDtnVel3LTmrJgFudHp7X389lEHVEgGt?=
 =?us-ascii?Q?EffvdG2GH8GwgDc/CxPVnZR+YbVS7/1SbvaYeniL4JHLCX8zrC/u8mK7ALfD?=
 =?us-ascii?Q?ryVrnQ94RwfL3NcAbjQygHiqk+rmO09OBBUJtQFGqy3HGybZS9KMawNS6az7?=
 =?us-ascii?Q?s+/y8Gir55tn3Z7cpCZ0oEhShR7tWCQIc8ilNYckueVfVcFs7lvowqjWiPml?=
 =?us-ascii?Q?24jSebqRKdamzTMYY/8uR4sKwfzdaRc19hqDF/yIpqjF2AfECECidiSE3tQX?=
 =?us-ascii?Q?0xsxE3G+irk6Q6EL1GXzcrvuJIprCE+tdh/iVyTEUCVuiWnUCSzrMeYka43J?=
 =?us-ascii?Q?lgRwqrFrVDizutOsKSWR0MCgmF0HMvoHrHRi7KvXVomZ3m6GsF2lSAZ7bQeG?=
 =?us-ascii?Q?5Yy9uWyIDcGceTOa/nDXZPMnvK3p0BomIeAnTWbdjw4Spc0aOmh9CI/P3XXf?=
 =?us-ascii?Q?WsSkcM4yTeqMow9U1eWtL6hw9mQVNr378sTMsE6mEDGiHdSsBbQa8f0fP+PE?=
 =?us-ascii?Q?qQbI418hXBQf8gh+cSYNgsl14gdct4OwxLHXUXZLaPPj92YNYirnl3QbTgtv?=
 =?us-ascii?Q?kollX5NVddBPuq+bAGJdQmJd5MYQUOiseibRDjNG9tYjbVCgU2izk3zJSSRU?=
 =?us-ascii?Q?wVHQTAIXW9hN5ruDX1XPsD0lv1UUubw7dAoN2TK2XyPnLsbu7GOhHuBAqUlx?=
 =?us-ascii?Q?EMVI3HkDiqOGe/HNs9iKwXRbqBQOgellYxQ7sNHGByo2Rn5H5M7N/GJith4w?=
 =?us-ascii?Q?sy8TOcxOe5J96IkovSvhDpajUfJ9nvYCeGiX9tjO3oKVZADg4aF4ozsbEelA?=
 =?us-ascii?Q?xjwz6CfJaFDFJcOYRnSA8K6DDkKi9PpkTg/DgoS4u2NgTLG5X2Iuyn0vMNha?=
 =?us-ascii?Q?TeJ3ZEmC8ZSCJp6NETbkoInonCZKAtZnfDnvvGDIyRD7spDX/pMB/0Rh5yEW?=
 =?us-ascii?Q?WkInFXGFtSMrnogh6mGvYHlit0y6PlZr28cLlVXB0s1Lbn57+jYnunqr+L+6?=
 =?us-ascii?Q?YSeMkdxTyGBwZkVxQ+Oyi5k7eIyW3P6qLi7M1LVKTguIsacHmYWQrCbBBeRb?=
 =?us-ascii?Q?ys7nrPa/5gP7jjDaIsoOx8pvO5xZsTOWQjTBsFQrnaneoUv7a7i89itQsz/f?=
 =?us-ascii?Q?bGGIPYxjPQS1aiTkFG7E6RKcse6cSWmsq0E2vCIMenW767EI/e6A8ZSEh3OQ?=
 =?us-ascii?Q?1bqb4xboWXQ2K2NORSdLsa4f9Iw7YTLGR+q3jUBWrvvk7eJ+Q5C0X9e5QEH7?=
 =?us-ascii?Q?wGlShIXtqm5N6W1FPlIj0n4UVBZ67FVmvhLsZFl4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5079e0f5-3aa5-440d-3c1c-08de1c58f206
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:07.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 567+oJm1To9EyW//lIQP7eq4bydl8zVYw6HNSaXYMHYVwTsfq/a+OKvIEnV3wwV2HKOXA1mk22R0pNE11bWnrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9293

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


