Return-Path: <linux-wireless+bounces-28592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA8C353ED
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E34214F19B1
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9E30E836;
	Wed,  5 Nov 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KcUmkoeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03530E0F1;
	Wed,  5 Nov 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339802; cv=fail; b=PibZnSGnawuaj7rXrVvFk8FDvlXIuZbeEKN9BgA4wicKTxvRXXACI+YNWmwdzv9OZOosDnwBmFdS/reHBzb0OvgUmFyKNeBAZ+IFl2VMZLJNVvAWJ1if71M42SUiCn2+JRgrcfDvm5E/VMKYbbzUYcXTUNJFDEKfsuDHmiq7hOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339802; c=relaxed/simple;
	bh=OVLY7UHQb4JuGyBdZXomVtNiLz8FYxp6BMB7mYEhM30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGQnpe05V3cmKaVOXiPN1NSn3Ly30rtfviGZ32Bmn7QmXSdAGOxhdnuOmQN5kuPgc6Ur/BBR28Rw2ySPa3asyI9g3pcTcPj5uQ9r6+Fg/tN/7H1DEBh4iXyM+I5VvYMrlYxR+BBIXKzh0gRC3JxqUlxIgZd90i8489qYgWWuzMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KcUmkoeh; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBlDp9wT5kdHs2sV8T9s5G9EbYrGEMgoygivACCdZnIrUaDuekwx+hXDizIZ5z9O3rBuAZh1S9qw+qicjqXBHTlejAK5wvO7fTvSvczIC3VW8QmMQFpR2oR3dCSBLQ0qaVS6uAgZ1OQ0SFUJN4Xzrs8tE/66AEheDlSXSnWqExVCVq2kbN89NjKoOSgYhZZlMhpreTyBBb/QuJh6CaSBezjZX0KyN3s0lEl2DAHgPKremWk6ZDU1OxqdeZuZGP4R14+lybc7EstHyG01fGwI29IaDmW+ZXvUQZLq4mib1YHv6ZzFeG2lCxGfjSOQ5DB3mIl0Y409l5ytg6fm5Y2efw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQDnTgcYoHq2dSQY7YSKKI8iO38VIP4BsIbf1Xxs1xM=;
 b=xfLTdOVYMNST4+MVAxmbBAAmRQdjGtcYdCS8eEqPBcsNPzBrdq8e/V2zTBYSzV0WYQ+Uprc9KIv82GcK/5rH73PRogrYN66tZZRA7U/FNvjC2KV6ujyNbLjWN8/hV0i7kEAQyu2YeaDt+brKHm0+58iTtz76U2ED0xydS14DHVVs/J3+HFeh6sxVVTtZoiB78UaWIKqU8eQUPkO00yvCtTSdmOxVZDQ0CY660/30u3P6e5tYUJXCLyF5UPj5b5MpvbaV9+OtvsBv7tSRosePb3MFssbkBnm9hHgVq40mKAZ+qQaMMMv0TXgXifu2OGum5M/CX+HJXo7/6DAfdJKtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQDnTgcYoHq2dSQY7YSKKI8iO38VIP4BsIbf1Xxs1xM=;
 b=KcUmkoehrE71J4ftuR+tqI4bqPYQLoz14+Ua6R0WOx/I7kwiGg4Ld+RLfFjZdcSIf/gGLWo0u40kkQxkyCpBfwG0+jxkAJiFfPpzml6S81aO5251SAMjI9kBnJJXggc6igbLKoEcoTKKUaqCr9aeMmmLBWa/mNrtFa8V9KeoOE1hTOdHHwI3JJHFGMgZ2wELpd7y0pje8G+9LKxdbIG45/RNWLDlr9w8OGxB/U1oTDSsIR50szfJpYHeYiS8Pf9N7fyVTEeZEzG9a3snZ66zyi75utRiaDqR4ekyo1mC5n84MrWxOQRqnt0ByjUcgkoCBvwghxiWtffnfB/As34+sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 10:49:42 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:42 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 14/22] wifi: nxpwifi: add debugfs support for diagnostics and testing
Date: Wed,  5 Nov 2025 18:47:36 +0800
Message-Id: <20251105104744.2401992-15-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA1PR04MB10770:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe3e6c6-ee2a-41ab-ead0-08de1c5906d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BZSGbaKWozmgzS89MNpCjW75yv122pnZRfTfogkBVvyh1SD5aaefU+fRFz2v?=
 =?us-ascii?Q?A7nHITu9zIibeZKBfmKJJRwoKU4P3Fry2Y52oRNpucWvPE9fnhUFcWxfC3ho?=
 =?us-ascii?Q?yybmQwzpDyKMfMujvamb3Uq40LZkqc4UfOrgG+1m3USlY3UioLoSXgII59Td?=
 =?us-ascii?Q?VHJymaUS1mZxYLXezrfV+zXFNE00mCmlQCwbH0icIAigu7C3ArsdzWHjCiX+?=
 =?us-ascii?Q?XeNK1hVLV9mxkzEjHaMUV2up9jNqYtakowzbpX8XqwIEz+3l4d45UR/jX9Uq?=
 =?us-ascii?Q?lCllbG4O0VOCSS0DIsg5hgLqOESAoOLobj6ccPk09mlQWpqHQLwUL/N0eLUu?=
 =?us-ascii?Q?ruriOTNYHz5hEjtvOTPQtqlU4immXeGwsO/o7vBRpitvE+Ut8jk6yZ0u0s/X?=
 =?us-ascii?Q?+bzm2k0v/FwduDnU4CBKGvMgscR/+zsPH5YA4Vbd6MZb794AVeXkyL7sqZ9R?=
 =?us-ascii?Q?eNjjvR0tvTRE75bZh9JlipPQUcsXQ+JDdYIuStSTviw1w5BDl8r/NIZR8Sxw?=
 =?us-ascii?Q?MdRfGymDpGvbsuL/WiO+FWlreZr+QYkrIgYbC6Qc0OkWzxz5ifyuvGsqPchh?=
 =?us-ascii?Q?8yXqIV4zeJEgDuu997KpGkEtT2ZIuN22c2TQnO+KxOaVllE8Ua7tQbG80Bu/?=
 =?us-ascii?Q?r/adWQEy4HwCdf288ST/pxS+wDj6ZoXmL05gAUCc+nQHrnuLjfl63R8gANQR?=
 =?us-ascii?Q?18Ch0fmL1sqtnsrTnHwFAnbwak+32eqUUG/0tkOHR6xz4rOzYhzm8UPw/SOn?=
 =?us-ascii?Q?qrxyeW/zFF69RWDfdxoGM3eDTDCOAx+hzJVuz1T24n4m8Gg7g8NcYkDb2yYV?=
 =?us-ascii?Q?Wcy1xlGF/bVpaiZYTX4iTGZTOrHlXZkk/9WAYn66lvF22QXPDg5fHJ+M4cwO?=
 =?us-ascii?Q?SmK1VE/qhe9DP6reZCbMK7YoPNGpbWUIqDOGVHjeIzftytmvNuh/IcUq1kED?=
 =?us-ascii?Q?XRklOGwdzC22YPF+0aE0EnY9B9Md4qQotyXkL/Ctl0NjUndElDcDbVTcn+ZS?=
 =?us-ascii?Q?qPyHwFOAGhl6myceo8K4Zzb0Bp07HLzhjyfVuVW52CDD+g6gcSxaXQiSnGjS?=
 =?us-ascii?Q?QbrG4AlpVvEONtFzCS71lDkIpcTIFji6qqzV1IKASZUwHCsX9+ICWOFP7m1c?=
 =?us-ascii?Q?TVdnxoXqzLVyHTCEdFXXBPpCA026nwLZ1KYMajn0DXhM2Ke6aieG3HGCrKY5?=
 =?us-ascii?Q?B6Agpmi5AcKtD+YSpqw1KSuTFXvQcpThZ9Iq/P7hbNSJjxWV3nYxA96oJCUS?=
 =?us-ascii?Q?QU+0vBaWqMLCAlHNulThvE2zimiR5TPShMPx0WOaX1vuoY73LDrMqWtZLIvg?=
 =?us-ascii?Q?prdMvxPuPW/Lp9mtb8ptXLbl/EHGy7pbamUpY+fgM7U6GaILM277EoCp2PsU?=
 =?us-ascii?Q?Htu5YV+yoboaPFWbEBAWZ6zyYYeWCQSzgX1+IEOgLBMg6n4tES+0Utf+n597?=
 =?us-ascii?Q?N2mgwqVbCctoPOBYEkcj3KPT4UA2FIWpWeEM5ALL7nLxmpkZUSdXK5SmWB4K?=
 =?us-ascii?Q?ZWX4b9p0th7o/dzHazLZEg5meDWoSp/2Cthm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Rsb4DoJUvP2k94YD7dynj127jqa3SYAMaMVAY97b/qiWLBzDMxsgxZGz0Mt?=
 =?us-ascii?Q?OEDQcJeNbc/5knSi7DcMLcUuryoKgn+4ucqiOaR1llVMAwu7Gg0qWsMuXX+q?=
 =?us-ascii?Q?2zsD96aM3lpdzDkyfxiHL/yqaYKfRJoebR/Eu4HZWUwTFV9847eJnRXQn0Ht?=
 =?us-ascii?Q?hQLYOPfyGHe0CcOdUe6h+4uuxLG3C2ettIqKjhHGyzwhlTbjSYfEF71Ip6Fk?=
 =?us-ascii?Q?h5eUM2Y2yRUhClak11Sb1GA767IFPhl+vaLZPu5rHyNzpEIlmGufbyakRcpN?=
 =?us-ascii?Q?+rTVer5cuJUuiqJoiKsNzSlwpaVs+SohnV9VZA5jmVVBD3lU/oPGlMlshvpe?=
 =?us-ascii?Q?w+ojmqkH3wwsed+j8oLjG52JjYmT42yxjn5ITHVriMbH41AS+prufTLJLXZQ?=
 =?us-ascii?Q?l1fmZTEsPrwX93dN+yiBOBEzb6iVbif+BWO+VWk2T8B61c09xJwDN0dPbQZc?=
 =?us-ascii?Q?B2g6L70BycWJ79mi+Ez/Ylq/spJfaCB0/5PY5YQhwUZZsXhk2TdrkCWQSh6T?=
 =?us-ascii?Q?QYNHnJXmrK98SHjCQMLoeempPC8XxVJaNlJro+eYTWUdlRVmqozi0LLL3ZXl?=
 =?us-ascii?Q?pxtmwYwzDmsHpWAf1tqVAGDBU8yRVDXEL+UFBuJ5bg9SXpYWQwIUywqVdlHS?=
 =?us-ascii?Q?iwtRDl71oJPxTYOEYYrGA4u7LgjxRXJ/xxqCFNghqkje31XvVYWOdPlVGv0o?=
 =?us-ascii?Q?rDPn/xSBhlWQXjtJd69AkYFxYghk1acUI8i7o3RgrFq9ha7jJt+sOcErnhV3?=
 =?us-ascii?Q?Wr2iQ5t5F3t675qA30Jww6k8PlfZHgMfl7OqLVcMaOQRql7ckQTjHc4mNq4t?=
 =?us-ascii?Q?xUOGErCAWXMt3OtAaphRNjh1SKJxa3nibSkGT51XmvHWNmcwKCosN4ZtJPEI?=
 =?us-ascii?Q?AnmNMUo+5U+jr+IeKHA5C3ojZrePlrLWzyH/r3etKfuQcsnQnvQ/rBo9uvtd?=
 =?us-ascii?Q?WFWJ0UrLCRzkR/jdmC0KDzEBk2ehXn8q06mMF9izJ/iWgqpvEYfPyGtAMpzT?=
 =?us-ascii?Q?OKDQXuxeW2/5KlosfHbAvQfVLPY7ahvMiJi+X3UbmEMZgjOGkTakOpFdya7D?=
 =?us-ascii?Q?acfbRU32XhXzl/Jss/Hj9b/ghPyfXiqbMY1fv+XNxdjn3I5884cxVRkTfX6R?=
 =?us-ascii?Q?6FPuDXXaQVGPfx3L4f8Zi23w8U+W2A8xwF1ejru21wULKqAK5D1092fD+V02?=
 =?us-ascii?Q?hxoQ3jZu/UBC3KwA9tspTxK1BVWtsxCE+WQr2ahhNUvvEYxIrhgb2OApdfwB?=
 =?us-ascii?Q?1L5f4wlX7RuDt5IWne0XdeuoWQGTUu/8XjTewvfYt0QZVLepf5pyeByh2bQA?=
 =?us-ascii?Q?2e4idpnt25Z8PAF93J/JOEF4gOL/RJFWetW0JsivQPRZcsOm844QNak6FAz7?=
 =?us-ascii?Q?kHpZeNCv8msIkBDcO+lCI0RUzJgZz9p5rZwbGI1q8PFSKBk26R4t/+PeUKrX?=
 =?us-ascii?Q?SLrRzRkphZhkoDjWyN7HcVMuACcBoLl8JqcDgr2NHEMnW5W5nkJtOK1iWtwJ?=
 =?us-ascii?Q?ALYeFJciqveiNha+4hB3oPrTfeSWf5eHaKw8D4uameRedQ4Q1NYhKqMla9Cv?=
 =?us-ascii?Q?n68lFXq0kW7RE/I+nY0R0NMM/ZKKoxvUHJyxUMHu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe3e6c6-ee2a-41ab-ead0-08de1c5906d1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:42.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QotOA1Q6521vH02ey0Dg731dcTUllfitLujcJbyyL/Uovl6PHmAs2tea38WgEI/UveuK+R0NrfbPCJpvxjG3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10770

This patch adds a comprehensive debugfs interface for the nxpwifi driver,
enabling easier diagnostics, testing, and runtime inspection.

These tools are useful for both development and field debugging, especially
for validating DFS behavior, power management, and firmware interaction.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/debugfs.c | 1217 ++++++++++++++++++++
 1 file changed, 1217 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/debugfs.c b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
new file mode 100644
index 000000000000..5e3d249f6e5e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
@@ -0,0 +1,1217 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: debugfs
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <linux/debugfs.h>
+
+#include "main.h"
+#include "cmdevt.h"
+#include "11n.h"
+
+static struct dentry *nxpwifi_dfs_dir;
+
+static char *bss_modes[] = {
+	"UNSPECIFIED",
+	"ADHOC",
+	"STATION",
+	"AP",
+	"AP_VLAN",
+	"WDS",
+	"MONITOR",
+	"MESH_POINT",
+	"P2P_CLIENT",
+	"P2P_GO",
+	"P2P_DEVICE",
+};
+
+/* Proc info file read handler.
+ *
+ * This function is called when the 'info' file is opened for reading.
+ * It prints the following driver related information -
+ *      - Driver name
+ *      - Driver version
+ *      - Driver extended version
+ *      - Interface name
+ *      - BSS mode
+ *      - Media state (connected or disconnected)
+ *      - MAC address
+ *      - Total number of Tx bytes
+ *      - Total number of Rx bytes
+ *      - Total number of Tx packets
+ *      - Total number of Rx packets
+ *      - Total number of dropped Tx packets
+ *      - Total number of dropped Rx packets
+ *      - Total number of corrupted Tx packets
+ *      - Total number of corrupted Rx packets
+ *      - Carrier status (on or off)
+ *      - Tx queue status (started or stopped)
+ *
+ * For STA mode drivers, it also prints the following extra -
+ *      - ESSID
+ *      - BSSID
+ *      - Channel
+ *      - Region code
+ *      - Multicast count
+ *      - Multicast addresses
+ */
+static ssize_t
+nxpwifi_info_read(struct file *file, char __user *ubuf,
+		  size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	struct net_device *netdev = priv->netdev;
+	struct netdev_hw_addr *ha;
+	struct netdev_queue *txq;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page, fmt[64];
+	struct nxpwifi_bss_info info;
+	ssize_t ret;
+	int i = 0;
+
+	if (!p)
+		return -ENOMEM;
+
+	memset(&info, 0, sizeof(info));
+	ret = nxpwifi_get_bss_info(priv, &info);
+	if (ret)
+		goto free_and_exit;
+
+	nxpwifi_drv_get_driver_version(priv->adapter, fmt, sizeof(fmt) - 1);
+
+	nxpwifi_get_ver_ext(priv, 0);
+
+	p += sprintf(p, "driver_name = ");
+	p += sprintf(p, "\"nxpwifi\"\n");
+	p += sprintf(p, "driver_version = %s", fmt);
+	p += sprintf(p, "\nverext = %s", priv->version_str);
+	p += sprintf(p, "\ninterface_name=\"%s\"\n", netdev->name);
+
+	if (info.bss_mode >= ARRAY_SIZE(bss_modes))
+		p += sprintf(p, "bss_mode=\"%d\"\n", info.bss_mode);
+	else
+		p += sprintf(p, "bss_mode=\"%s\"\n", bss_modes[info.bss_mode]);
+
+	p += sprintf(p, "media_state=\"%s\"\n",
+		     (!priv->media_connected ? "Disconnected" : "Connected"));
+	p += sprintf(p, "mac_address=\"%pM\"\n", netdev->dev_addr);
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) {
+		p += sprintf(p, "multicast_count=\"%d\"\n",
+			     netdev_mc_count(netdev));
+		p += sprintf(p, "essid=\"%.*s\"\n", info.ssid.ssid_len,
+			     info.ssid.ssid);
+		p += sprintf(p, "bssid=\"%pM\"\n", info.bssid);
+		p += sprintf(p, "channel=\"%d\"\n", (int)info.bss_chan);
+		p += sprintf(p, "country_code = \"%s\"\n", info.country_code);
+		p += sprintf(p, "region_code=\"0x%x\"\n",
+			     priv->adapter->region_code);
+
+		netdev_for_each_mc_addr(ha, netdev)
+			p += sprintf(p, "multicast_address[%d]=\"%pM\"\n",
+					i++, ha->addr);
+	}
+
+	p += sprintf(p, "num_tx_bytes = %lu\n", priv->stats.tx_bytes);
+	p += sprintf(p, "num_rx_bytes = %lu\n", priv->stats.rx_bytes);
+	p += sprintf(p, "num_tx_pkts = %lu\n", priv->stats.tx_packets);
+	p += sprintf(p, "num_rx_pkts = %lu\n", priv->stats.rx_packets);
+	p += sprintf(p, "num_tx_pkts_dropped = %lu\n", priv->stats.tx_dropped);
+	p += sprintf(p, "num_rx_pkts_dropped = %lu\n", priv->stats.rx_dropped);
+	p += sprintf(p, "num_tx_pkts_err = %lu\n", priv->stats.tx_errors);
+	p += sprintf(p, "num_rx_pkts_err = %lu\n", priv->stats.rx_errors);
+	p += sprintf(p, "carrier %s\n", ((netif_carrier_ok(priv->netdev))
+					 ? "on" : "off"));
+	p += sprintf(p, "tx queue");
+	for (i = 0; i < netdev->num_tx_queues; i++) {
+		txq = netdev_get_tx_queue(netdev, i);
+		p += sprintf(p, " %d:%s", i, netif_tx_queue_stopped(txq) ?
+			     "stopped" : "started");
+	}
+	p += sprintf(p, "\n");
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+/* Proc getlog file read handler.
+ *
+ * This function is called when the 'getlog' file is opened for reading
+ * It prints the following log information -
+ *      - Number of multicast Tx frames
+ *      - Number of failed packets
+ *      - Number of Tx retries
+ *      - Number of multicast Tx retries
+ *      - Number of duplicate frames
+ *      - Number of RTS successes
+ *      - Number of RTS failures
+ *      - Number of ACK failures
+ *      - Number of fragmented Rx frames
+ *      - Number of multicast Rx frames
+ *      - Number of FCS errors
+ *      - Number of Tx frames
+ *      - WEP ICV error counts
+ *      - Number of received beacons
+ *      - Number of missed beacons
+ */
+static ssize_t
+nxpwifi_getlog_read(struct file *file, char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+	struct nxpwifi_ds_get_stats stats;
+
+	if (!p)
+		return -ENOMEM;
+
+	memset(&stats, 0, sizeof(stats));
+	ret = nxpwifi_get_stats_info(priv, &stats);
+	if (ret)
+		goto free_and_exit;
+
+	p += sprintf(p, "\n"
+		     "mcasttxframe     %u\n"
+		     "failed           %u\n"
+		     "retry            %u\n"
+		     "multiretry       %u\n"
+		     "framedup         %u\n"
+		     "rtssuccess       %u\n"
+		     "rtsfailure       %u\n"
+		     "ackfailure       %u\n"
+		     "rxfrag           %u\n"
+		     "mcastrxframe     %u\n"
+		     "fcserror         %u\n"
+		     "txframe          %u\n"
+		     "wepicverrcnt-1   %u\n"
+		     "wepicverrcnt-2   %u\n"
+		     "wepicverrcnt-3   %u\n"
+		     "wepicverrcnt-4   %u\n"
+		     "bcn_rcv_cnt   %u\n"
+		     "bcn_miss_cnt   %u\n",
+		     stats.mcast_tx_frame,
+		     stats.failed,
+		     stats.retry,
+		     stats.multi_retry,
+		     stats.frame_dup,
+		     stats.rts_success,
+		     stats.rts_failure,
+		     stats.ack_failure,
+		     stats.rx_frag,
+		     stats.mcast_rx_frame,
+		     stats.fcs_error,
+		     stats.tx_frame,
+		     stats.wep_icv_error[0],
+		     stats.wep_icv_error[1],
+		     stats.wep_icv_error[2],
+		     stats.wep_icv_error[3],
+		     stats.bcn_rcv_cnt,
+		     stats.bcn_miss_cnt);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+/* Sysfs histogram file read handler.
+ *
+ * This function is called when the 'histogram' file is opened for reading
+ * It prints the following histogram information -
+ *      - Number of histogram samples
+ *      - Receive packet number of each rx_rate
+ *      - Receive packet number of each snr
+ *      - Receive packet number of each nosie_flr
+ *      - Receive packet number of each signal streath
+ */
+static ssize_t
+nxpwifi_histogram_read(struct file *file, char __user *ubuf,
+		       size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	ssize_t ret;
+	struct nxpwifi_histogram_data *phist_data;
+	int i, value;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+
+	if (!p)
+		return -ENOMEM;
+
+	if (!priv || !priv->hist_data) {
+		ret = -EFAULT;
+		goto free_and_exit;
+	}
+
+	phist_data = priv->hist_data;
+
+	p += sprintf(p, "\n"
+		     "total samples = %d\n",
+		     atomic_read(&phist_data->num_samples));
+
+	p += sprintf(p,
+		     "rx rates (in Mbps): 0=1M   1=2M 2=5.5M  3=11M   4=6M   5=9M  6=12M\n"
+		     "7=18M  8=24M  9=36M  10=48M  11=54M 12-27=MCS0-15(BW20) 28-43=MCS0-15(BW40)\n");
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info)) {
+		p += sprintf(p,
+			     "44-53=MCS0-9(VHT:BW20) 54-63=MCS0-9(VHT:BW40) 64-73=MCS0-9(VHT:BW80)\n\n");
+	} else {
+		p += sprintf(p, "\n");
+	}
+
+	for (i = 0; i < NXPWIFI_MAX_RX_RATES; i++) {
+		value = atomic_read(&phist_data->rx_rate[i]);
+		if (value)
+			p += sprintf(p, "rx_rate[%02d] = %d\n", i, value);
+	}
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info)) {
+		for (i = NXPWIFI_MAX_RX_RATES; i < NXPWIFI_MAX_AC_RX_RATES;
+		     i++) {
+			value = atomic_read(&phist_data->rx_rate[i]);
+			if (value)
+				p += sprintf(p, "rx_rate[%02d] = %d\n",
+					   i, value);
+		}
+	}
+
+	for (i = 0; i < NXPWIFI_MAX_SNR; i++) {
+		value =  atomic_read(&phist_data->snr[i]);
+		if (value)
+			p += sprintf(p, "snr[%02ddB] = %d\n", i, value);
+	}
+	for (i = 0; i < NXPWIFI_MAX_NOISE_FLR; i++) {
+		value = atomic_read(&phist_data->noise_flr[i]);
+		if (value)
+			p += sprintf(p, "noise_flr[%02ddBm] = %d\n",
+				     (int)(i - 128), value);
+	}
+	for (i = 0; i < NXPWIFI_MAX_SIG_STRENGTH; i++) {
+		value = atomic_read(&phist_data->sig_str[i]);
+		if (value)
+			p += sprintf(p, "sig_strength[-%02ddBm] = %d\n",
+				i, value);
+	}
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_histogram_write(struct file *file, const char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+
+	if (priv && priv->hist_data)
+		nxpwifi_hist_data_reset(priv);
+	return 0;
+}
+
+static struct nxpwifi_debug_info info;
+
+/* Proc debug file read handler.
+ *
+ * This function is called when the 'debug' file is opened for reading
+ * It prints the following log information -
+ *      - Interrupt count
+ *      - WMM AC VO packets count
+ *      - WMM AC VI packets count
+ *      - WMM AC BE packets count
+ *      - WMM AC BK packets count
+ *      - Maximum Tx buffer size
+ *      - Tx buffer size
+ *      - Current Tx buffer size
+ *      - Power Save mode
+ *      - Power Save state
+ *      - Deep Sleep status
+ *      - Device wakeup required status
+ *      - Number of wakeup tries
+ *      - Host Sleep configured status
+ *      - Host Sleep activated status
+ *      - Number of Tx timeouts
+ *      - Number of command timeouts
+ *      - Last timed out command ID
+ *      - Last timed out command action
+ *      - Last command ID
+ *      - Last command action
+ *      - Last command index
+ *      - Last command response ID
+ *      - Last command response index
+ *      - Last event
+ *      - Last event index
+ *      - Number of host to card command failures
+ *      - Number of sleep confirm command failures
+ *      - Number of host to card data failure
+ *      - Number of deauthentication events
+ *      - Number of disassociation events
+ *      - Number of link lost events
+ *      - Number of deauthentication commands
+ *      - Number of association success commands
+ *      - Number of association failure commands
+ *      - Number of commands sent
+ *      - Number of data packets sent
+ *      - Number of command responses received
+ *      - Number of events received
+ *      - Tx BA stream table (TID, RA)
+ *      - Rx reorder table (TID, TA, Start window, Window size, Buffer)
+ */
+static ssize_t
+nxpwifi_debug_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+
+	if (!p)
+		return -ENOMEM;
+
+	ret = nxpwifi_get_debug_info(priv, &info);
+	if (ret)
+		goto free_and_exit;
+
+	p += nxpwifi_debug_info_to_buffer(priv, p, &info);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+free_and_exit:
+	free_page(page);
+	return ret;
+}
+
+static u32 saved_reg_type, saved_reg_offset, saved_reg_value;
+
+/* Proc regrdwr file write handler.
+ *
+ * This function is called when the 'regrdwr' file is opened for writing
+ *
+ * This function can be used to write to a register.
+ */
+static ssize_t
+nxpwifi_regrdwr_write(struct file *file,
+		      const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	char *buf;
+	int ret;
+	u32 reg_type = 0, reg_offset = 0, reg_value = UINT_MAX;
+	int rv;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	rv = sscanf(buf, "%u %x %x", &reg_type, &reg_offset, &reg_value);
+
+	if (rv != 3) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (reg_type == 0 || reg_offset == 0) {
+		ret = -EINVAL;
+		goto done;
+	} else {
+		saved_reg_type = reg_type;
+		saved_reg_offset = reg_offset;
+		saved_reg_value = reg_value;
+		ret = count;
+	}
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* Proc regrdwr file read handler.
+ *
+ * This function is called when the 'regrdwr' file is opened for reading
+ *
+ * This function can be used to read from a register.
+ */
+static ssize_t
+nxpwifi_regrdwr_read(struct file *file, char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos = 0, ret = 0;
+	u32 reg_value;
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (!saved_reg_type) {
+		/* No command has been given */
+		pos += snprintf(buf, PAGE_SIZE, "0");
+		goto done;
+	}
+	/* Set command has been given */
+	if (saved_reg_value != UINT_MAX) {
+		ret = nxpwifi_reg_write(priv, saved_reg_type, saved_reg_offset,
+					saved_reg_value);
+
+		pos += snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n",
+				saved_reg_type, saved_reg_offset,
+				saved_reg_value);
+
+		ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+		goto done;
+	}
+	/* Get command has been given */
+	ret = nxpwifi_reg_read(priv, saved_reg_type,
+			       saved_reg_offset, &reg_value);
+	if (ret) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	pos += snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", saved_reg_type,
+			saved_reg_offset, reg_value);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+done:
+	free_page(addr);
+	return ret;
+}
+
+/* Proc debug_mask file read handler.
+ * This function is called when the 'debug_mask' file is opened for reading
+ * This function can be used read driver debugging mask value.
+ */
+static ssize_t
+nxpwifi_debug_mask_read(struct file *file, char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)page;
+	size_t ret = 0;
+	int pos = 0;
+
+	if (!buf)
+		return -ENOMEM;
+
+	pos += snprintf(buf, PAGE_SIZE, "debug mask=0x%08x\n",
+			priv->adapter->debug_mask);
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(page);
+	return ret;
+}
+
+/* Proc debug_mask file read handler.
+ * This function is called when the 'debug_mask' file is opened for reading
+ * This function can be used read driver debugging mask value.
+ */
+static ssize_t
+nxpwifi_debug_mask_write(struct file *file, const char __user *ubuf,
+			 size_t count, loff_t *ppos)
+{
+	int ret;
+	unsigned long debug_mask;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (kstrtoul(buf, 0, &debug_mask)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	priv->adapter->debug_mask = debug_mask;
+	ret = count;
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* debugfs verext file write handler.
+ * This function is called when the 'verext' file is opened for write
+ */
+static ssize_t
+nxpwifi_verext_write(struct file *file, const char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	int ret;
+	u32 versionstrsel;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+
+	ret = kstrtou32_from_user(ubuf, count, 10, &versionstrsel);
+	if (ret)
+		return ret;
+
+	priv->versionstrsel = versionstrsel;
+
+	return count;
+}
+
+/* Proc verext file read handler.
+ * This function is called when the 'verext' file is opened for reading
+ * This function can be used read driver exteneed verion string.
+ */
+static ssize_t
+nxpwifi_verext_read(struct file *file, char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	char buf[256];
+	int ret;
+
+	nxpwifi_get_ver_ext(priv, priv->versionstrsel);
+	ret = snprintf(buf, sizeof(buf), "version string: %s\n",
+		       priv->version_str);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, ret);
+}
+
+/* Proc memrw file write handler.
+ * This function is called when the 'memrw' file is opened for writing
+ * This function can be used to write to a memory location.
+ */
+static ssize_t
+nxpwifi_memrw_write(struct file *file, const char __user *ubuf, size_t count,
+		    loff_t *ppos)
+{
+	int ret;
+	char cmd;
+	struct nxpwifi_ds_mem_rw mem_rw;
+	u16 cmd_action;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%c %x %x", &cmd, &mem_rw.addr, &mem_rw.value);
+	if (ret != 3) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if ((cmd == 'r') || (cmd == 'R')) {
+		cmd_action = HOST_ACT_GEN_GET;
+		mem_rw.value = 0;
+	} else if ((cmd == 'w') || (cmd == 'W')) {
+		cmd_action = HOST_ACT_GEN_SET;
+	} else {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	memcpy(&priv->mem_rw, &mem_rw, sizeof(mem_rw));
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MEM_ACCESS, cmd_action, 0,
+			       &mem_rw, true);
+	if (!ret)
+		ret = count;
+
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* Proc memrw file read handler.
+ * This function is called when the 'memrw' file is opened for reading
+ * This function can be used to read from a memory location.
+ */
+static ssize_t
+nxpwifi_memrw_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int ret, pos = 0;
+
+	if (!buf)
+		return -ENOMEM;
+
+	pos += snprintf(buf, PAGE_SIZE, "0x%x 0x%x\n", priv->mem_rw.addr,
+			priv->mem_rw.value);
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(addr);
+	return ret;
+}
+
+static u32 saved_offset = -1, saved_bytes = -1;
+
+/* Proc rdeeprom file write handler.
+ *
+ * This function is called when the 'rdeeprom' file is opened for writing
+ *
+ * This function can be used to write to a RDEEPROM location.
+ */
+static ssize_t
+nxpwifi_rdeeprom_write(struct file *file,
+		       const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	char *buf;
+	int ret = 0;
+	int offset = -1, bytes = -1;
+	int rv;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	rv = sscanf(buf, "%d %d", &offset, &bytes);
+
+	if (rv != 2) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (offset == -1 || bytes == -1) {
+		ret = -EINVAL;
+		goto done;
+	} else {
+		saved_offset = offset;
+		saved_bytes = bytes;
+		ret = count;
+	}
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* Proc rdeeprom read write handler.
+ *
+ * This function is called when the 'rdeeprom' file is opened for reading
+ *
+ * This function can be used to read from a RDEEPROM location.
+ */
+static ssize_t
+nxpwifi_rdeeprom_read(struct file *file, char __user *ubuf,
+		      size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos, ret, i;
+	u8 value[MAX_EEPROM_DATA];
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (saved_offset == -1) {
+		/* No command has been given */
+		pos = snprintf(buf, PAGE_SIZE, "0");
+		goto done;
+	}
+
+	/* Get command has been given */
+	ret = nxpwifi_eeprom_read(priv, (u16)saved_offset,
+				  (u16)saved_bytes, value);
+	if (ret) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	pos = snprintf(buf, PAGE_SIZE, "%d %d ", saved_offset, saved_bytes);
+
+	for (i = 0; i < saved_bytes; i++)
+		pos += scnprintf(buf + pos, PAGE_SIZE - pos, "%d ", value[i]);
+
+done:
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+out_free:
+	free_page(addr);
+	return ret;
+}
+
+/* Proc hscfg file write handler
+ * This function can be used to configure the host sleep parameters.
+ */
+static ssize_t
+nxpwifi_hscfg_write(struct file *file, const char __user *ubuf,
+		    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+	int ret, arg_num;
+	struct nxpwifi_ds_hs_cfg hscfg;
+	int conditions = HS_CFG_COND_DEF;
+	u32 gpio = HS_CFG_GPIO_DEF, gap = HS_CFG_GAP_DEF;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	arg_num = sscanf(buf, "%d %x %x", &conditions, &gpio, &gap);
+
+	memset(&hscfg, 0, sizeof(struct nxpwifi_ds_hs_cfg));
+
+	if (arg_num > 3) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Too many arguments\n");
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (arg_num >= 1 && arg_num < 3)
+		nxpwifi_set_hs_params(priv, HOST_ACT_GEN_GET,
+				      NXPWIFI_SYNC_CMD, &hscfg);
+
+	if (arg_num) {
+		if (conditions == HS_CFG_CANCEL) {
+			nxpwifi_cancel_hs(priv, NXPWIFI_ASYNC_CMD);
+			ret = count;
+			goto done;
+		}
+		hscfg.conditions = conditions;
+	}
+	if (arg_num >= 2)
+		hscfg.gpio = gpio;
+	if (arg_num == 3)
+		hscfg.gap = gap;
+
+	hscfg.is_invoke_hostcmd = false;
+	nxpwifi_set_hs_params(priv, HOST_ACT_GEN_SET,
+			      NXPWIFI_SYNC_CMD, &hscfg);
+
+	nxpwifi_enable_hs(priv->adapter);
+	clear_bit(NXPWIFI_IS_HS_ENABLING, &priv->adapter->work_flags);
+	ret = count;
+done:
+	kfree(buf);
+	return ret;
+}
+
+/* Proc hscfg file read handler
+ * This function can be used to read host sleep configuration
+ * parameters from driver.
+ */
+static ssize_t
+nxpwifi_hscfg_read(struct file *file, char __user *ubuf,
+		   size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	unsigned long addr = get_zeroed_page(GFP_KERNEL);
+	char *buf = (char *)addr;
+	int pos, ret;
+	struct nxpwifi_ds_hs_cfg hscfg;
+
+	if (!buf)
+		return -ENOMEM;
+
+	nxpwifi_set_hs_params(priv, HOST_ACT_GEN_GET,
+			      NXPWIFI_SYNC_CMD, &hscfg);
+
+	pos = snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", hscfg.conditions,
+		       hscfg.gpio, hscfg.gap);
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+
+	free_page(addr);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_timeshare_coex_read(struct file *file, char __user *ubuf,
+			    size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	char buf[3];
+	bool timeshare_coex;
+	int ret;
+	unsigned int len;
+
+	if (priv->adapter->fw_api_ver != NXPWIFI_FW_V15)
+		return -EOPNOTSUPP;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_ROBUST_COEX,
+			       HOST_ACT_GEN_GET, 0, &timeshare_coex, true);
+	if (ret)
+		return ret;
+
+	len = sprintf(buf, "%d\n", timeshare_coex);
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static ssize_t
+nxpwifi_timeshare_coex_write(struct file *file, const char __user *ubuf,
+			     size_t count, loff_t *ppos)
+{
+	bool timeshare_coex;
+	struct nxpwifi_private *priv = file->private_data;
+	int ret;
+
+	if (priv->adapter->fw_api_ver != NXPWIFI_FW_V15)
+		return -EOPNOTSUPP;
+
+	ret = kstrtobool_from_user(ubuf, count, &timeshare_coex);
+	if (ret)
+		return ret;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_ROBUST_COEX,
+			       HOST_ACT_GEN_SET, 0, &timeshare_coex, true);
+	if (ret)
+		return ret;
+	else
+		return count;
+}
+
+static ssize_t
+nxpwifi_reset_write(struct file *file,
+		    const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	bool result;
+	int rc;
+
+	rc = kstrtobool_from_user(ubuf, count, &result);
+	if (rc)
+		return rc;
+
+	if (!result)
+		return -EINVAL;
+
+	if (adapter->if_ops.card_reset) {
+		dev_info(adapter->dev, "Resetting per request\n");
+		adapter->if_ops.card_reset(adapter);
+	}
+
+	return count;
+}
+
+static ssize_t
+nxpwifi_fake_radar_detect_write(struct file *file,
+				const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv = file->private_data;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	bool result;
+	int rc;
+
+	rc = kstrtobool_from_user(ubuf, count, &result);
+	if (rc)
+		return rc;
+
+	if (!result)
+		return -EINVAL;
+
+	if (priv->wdev.links[0].cac_started) {
+		nxpwifi_dbg(adapter, MSG,
+			    "Generate fake radar detected during CAC\n");
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
+		cfg80211_radar_event(adapter->wiphy, &priv->dfs_chandef,
+				     GFP_KERNEL);
+	} else {
+		if (priv->bss_chandef.chan->dfs_cac_ms) {
+			nxpwifi_dbg(adapter, MSG,
+				    "Generate fake radar detected\n");
+			cfg80211_radar_event(adapter->wiphy,
+					     &priv->dfs_chandef,
+					     GFP_KERNEL);
+		}
+	}
+
+	return count;
+}
+
+static ssize_t
+nxpwifi_netmon_write(struct file *file, const char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_802_11_net_monitor netmon_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+	memset(&netmon_cfg, 0, sizeof(struct nxpwifi_802_11_net_monitor));
+	ret = sscanf(buf, "%u %u %u %u %u",
+		     &netmon_cfg.enable_net_mon,
+		     &netmon_cfg.filter_flag,
+		     &netmon_cfg.band,
+		     &netmon_cfg.channel,
+		     &netmon_cfg.chan_bandwidth);
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_NET_MONITOR,
+			       HOST_ACT_GEN_SET, 0, &netmon_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_setup_write(struct file *file, const char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hhu %hu %hhu %hu",
+		     &twt_cfg.param.twt_setup.implicit,
+		     &twt_cfg.param.twt_setup.announced,
+		     &twt_cfg.param.twt_setup.trigger_enabled,
+		     &twt_cfg.param.twt_setup.twt_info_disabled,
+		     &twt_cfg.param.twt_setup.negotiation_type,
+		     &twt_cfg.param.twt_setup.twt_wakeup_duration,
+		     &twt_cfg.param.twt_setup.flow_identifier,
+		     &twt_cfg.param.twt_setup.hard_constraint,
+		     &twt_cfg.param.twt_setup.twt_exponent,
+		     &twt_cfg.param.twt_setup.twt_mantissa,
+		     &twt_cfg.param.twt_setup.twt_request,
+		     &twt_cfg.param.twt_setup.bcn_miss_threshold);
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_SETUP_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_teardown_write(struct file *file, const char __user *ubuf,
+			   size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %hhu %hhu",
+		     &twt_cfg.param.twt_teardown.flow_identifier,
+		     &twt_cfg.param.twt_teardown.negotiation_type,
+		     &twt_cfg.param.twt_teardown.teardown_all_twt);
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_TEARDOWN_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_report_read(struct file *file, char __user *ubuf,
+			size_t count, loff_t *ppos)
+{
+	struct nxpwifi_private *priv =
+		(struct nxpwifi_private *)file->private_data;
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	char *p = (char *)page;
+	ssize_t ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	u8 num, i, j;
+
+	if (!p)
+		return -ENOMEM;
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_REPORT_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_GET, 0,
+			       &twt_cfg, true);
+	if (ret)
+		goto done;
+	num = twt_cfg.param.twt_report.length / NXPWIFI_BTWT_REPORT_LEN;
+	num = num <= NXPWIFI_BTWT_REPORT_MAX_NUM ? num : NXPWIFI_BTWT_REPORT_MAX_NUM;
+	p += sprintf(p, "\ntwt_report len %hhu, num %hhu, twt_report_info:\n",
+		twt_cfg.param.twt_report.length, num);
+	for (i = 0; i < num; i++) {
+		p += sprintf(p, "id[%hu]:\r\n", i);
+		for (j = 0; j < NXPWIFI_BTWT_REPORT_LEN; j++) {
+			p += sprintf(p,
+				" 0x%02x",
+				twt_cfg.param.twt_report.data[i * NXPWIFI_BTWT_REPORT_LEN + j]);
+		}
+		p += sprintf(p, "\r\n");
+	}
+
+	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
+				      (unsigned long)p - page);
+
+done:
+	free_page(page);
+	return ret;
+}
+
+static ssize_t
+nxpwifi_twt_information_write(struct file *file, const char __user *ubuf,
+			      size_t count, loff_t *ppos)
+{
+	int ret;
+	struct nxpwifi_twt_cfg twt_cfg;
+	struct nxpwifi_private *priv = (void *)file->private_data;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %u",
+		     &twt_cfg.param.twt_information.flow_identifier,
+		     &twt_cfg.param.twt_information.suspend_duration);
+
+	twt_cfg.sub_id = NXPWIFI_11AX_TWT_INFORMATION_SUBID;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TWT_CFG, HOST_ACT_GEN_SET, 0,
+			       &twt_cfg, true);
+
+	if (!ret)
+		ret = count;
+
+	kfree(buf);
+	return ret;
+}
+
+#define NXPWIFI_DFS_ADD_FILE(name) debugfs_create_file(#name, 0644,     \
+				   priv->dfs_dev_dir, priv,             \
+				   &nxpwifi_dfs_##name##_fops)
+
+#define NXPWIFI_DFS_FILE_OPS(name)                                      \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.read = nxpwifi_##name##_read,                                  \
+	.write = nxpwifi_##name##_write,                                \
+	.open = simple_open,                                            \
+}
+
+#define NXPWIFI_DFS_FILE_READ_OPS(name)                                 \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.read = nxpwifi_##name##_read,                                  \
+	.open = simple_open,                                            \
+}
+
+#define NXPWIFI_DFS_FILE_WRITE_OPS(name)                                \
+static const struct file_operations nxpwifi_dfs_##name##_fops = {       \
+	.write = nxpwifi_##name##_write,                                \
+	.open = simple_open,                                            \
+}
+
+NXPWIFI_DFS_FILE_READ_OPS(info);
+NXPWIFI_DFS_FILE_READ_OPS(debug);
+NXPWIFI_DFS_FILE_READ_OPS(getlog);
+NXPWIFI_DFS_FILE_OPS(regrdwr);
+NXPWIFI_DFS_FILE_OPS(rdeeprom);
+NXPWIFI_DFS_FILE_OPS(memrw);
+NXPWIFI_DFS_FILE_OPS(hscfg);
+NXPWIFI_DFS_FILE_OPS(histogram);
+NXPWIFI_DFS_FILE_OPS(debug_mask);
+NXPWIFI_DFS_FILE_OPS(timeshare_coex);
+NXPWIFI_DFS_FILE_WRITE_OPS(reset);
+NXPWIFI_DFS_FILE_WRITE_OPS(fake_radar_detect);
+NXPWIFI_DFS_FILE_OPS(verext);
+NXPWIFI_DFS_FILE_WRITE_OPS(netmon);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_setup);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_teardown);
+NXPWIFI_DFS_FILE_READ_OPS(twt_report);
+NXPWIFI_DFS_FILE_WRITE_OPS(twt_information);
+
+/* This function creates the debug FS directory structure and the files.
+ */
+void
+nxpwifi_dev_debugfs_init(struct nxpwifi_private *priv)
+{
+	if (!nxpwifi_dfs_dir || !priv)
+		return;
+
+	priv->dfs_dev_dir = debugfs_create_dir(priv->netdev->name,
+					       nxpwifi_dfs_dir);
+
+	NXPWIFI_DFS_ADD_FILE(info);
+	NXPWIFI_DFS_ADD_FILE(debug);
+	NXPWIFI_DFS_ADD_FILE(getlog);
+	NXPWIFI_DFS_ADD_FILE(regrdwr);
+	NXPWIFI_DFS_ADD_FILE(rdeeprom);
+
+	NXPWIFI_DFS_ADD_FILE(memrw);
+	NXPWIFI_DFS_ADD_FILE(hscfg);
+	NXPWIFI_DFS_ADD_FILE(histogram);
+	NXPWIFI_DFS_ADD_FILE(debug_mask);
+	NXPWIFI_DFS_ADD_FILE(timeshare_coex);
+	NXPWIFI_DFS_ADD_FILE(reset);
+	NXPWIFI_DFS_ADD_FILE(fake_radar_detect);
+	NXPWIFI_DFS_ADD_FILE(verext);
+	NXPWIFI_DFS_ADD_FILE(netmon);
+	NXPWIFI_DFS_ADD_FILE(twt_setup);
+	NXPWIFI_DFS_ADD_FILE(twt_teardown);
+	NXPWIFI_DFS_ADD_FILE(twt_report);
+	NXPWIFI_DFS_ADD_FILE(twt_information);
+}
+
+/* This function removes the debug FS directory structure and the files.
+ */
+void
+nxpwifi_dev_debugfs_remove(struct nxpwifi_private *priv)
+{
+	if (!priv)
+		return;
+
+	debugfs_remove_recursive(priv->dfs_dev_dir);
+}
+
+/* This function creates the top level proc directory.
+ */
+void
+nxpwifi_debugfs_init(void)
+{
+	if (!nxpwifi_dfs_dir)
+		nxpwifi_dfs_dir = debugfs_create_dir("nxpwifi", NULL);
+}
+
+/* This function removes the top level proc directory.
+ */
+void
+nxpwifi_debugfs_remove(void)
+{
+	debugfs_remove(nxpwifi_dfs_dir);
+}
-- 
2.34.1


