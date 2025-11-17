Return-Path: <linux-wireless+bounces-29040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA9C63BAB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5E70363A00
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245732F771;
	Mon, 17 Nov 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UzBwZBZS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18932ED53;
	Mon, 17 Nov 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377369; cv=fail; b=sX5DMNHTfSTdjs2GSfCqyN5LUaCnAfyB2QiaNZKVngBiX0v+kjcJ0f7w1QcrQp9ck7N0/RW7FAs5MUnIsAx4pNUrV3Fll33R9AkJLmmbnMfANShTWgz2LktdBnP8v5cv0xgYfAr+agVF5YPxynTt2wOnA7CQ1c7E91RjNwLusXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377369; c=relaxed/simple;
	bh=majteyj+qAE8/FZwB16Mj6AqdDV7Mak+4xAJ0xh4SaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXsvMNceVsE1UYua77u9AYXYpY5CszSdakjWMjxnmniqGxXCdpuwyTD3ttSklvgfqIM48lf9Q3vPIbBpQeGW7UaluQunZm7E0vN9n/D6DS0+oEcMEhNCMC2Af9jse26CLTxaBWwUStq/C3HgkvJXM1kHXVKeA8n09KUNfzmUovk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UzBwZBZS; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMp/v9x4kW96NImO8H41wdE0gsBoQa+WBssORVghWB3Nfcs0UpYE9qTyAsM6/IKKmL0J5O5ZmD1aZh8Oe55NTjiPbzbUbvTLJKLM2lP08fpI190xlSIO7rs2GP/Phy9yQXs9DFO6TXKZ3YoeHO4UC5Zw54foY2ntZDn3HHj2wHqMyXp4/v2M7zyaiNINli6rCGmDcybAQpKyWAYYscohC86rep8TyHmcG62DrM16jQ2u0qufO95bxyqoraLbrKge324v22gYl8Z1nvOBfUuHPyGr7uIxe/x3+T+Hd44o3kVvxoCP1RQbGN/IdTxLOfzbObzr82Fv/20llVZ/5B2LSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8sMbMPq2uaYg2N6Q68BlR5qznlYJh+W9lG5tQnibFY=;
 b=kwmVq/Tn6tKWpBSDf0WE6gzTO540bWnJMX5oK7szGtH8NPstNXB5atg0jon5cddHYIFOUYU1Px2A/zG38fGWmEW8ugnMAZcOx56r5ynnmdDunhdGirSpp9r/9j9uAduZYWZbnzZjM/irGMGgPBB2AiHbig+E4rS/X1UtNXReaLUoQEQ8ZJlRudxpRJkK4ns5s9EEAz6AyMjsaJgfq7roF7goLDIiQMFct61HE9qau13TCb7Lf8ArVZce0S3/xfPkPbuFZWl7dMrfwjsvZCyhhRFiwRa4GdUk1qMCYvmouBeY326rM4jfG6oWhaJqYTYVb1BR1VFFibGtP9rKv8/Vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8sMbMPq2uaYg2N6Q68BlR5qznlYJh+W9lG5tQnibFY=;
 b=UzBwZBZSNiodUTrp+R0Mf+DHy+wNLh3xbJg/tSAg+WaudKDXC4ugsNdzT+H5MLrYIA7WvQ510K7pJM32jSjbG3lwezMpX1XiTW2PYHzeQ9CRI/VUPLx48fU+PRnxWoGLdBvnnVNLHD4r2ZTORm9zZh9zaSjmgQZvy8cSCQBprjq/eb9CkbJAvZfOysynsVaZbGbaTAr+U3ziecEXGVa2GZPJloxnwko3ObLYll04r+8ZITjtQfWmJHzhy5066F6uLCuy+AslO/8lSyQn9r+jrE5tiICho6uzNkRhh8+tCDvOY9KJtRFvSW2thAoluXg/TnP42GhX9wqX2gFB4aMdEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV4PR04MB11852.eurprd04.prod.outlook.com (2603:10a6:150:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:34 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:34 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 14/22] wifi: nxpwifi: add debugfs support for diagnostics and testing
Date: Mon, 17 Nov 2025 19:00:38 +0800
Message-Id: <20251117110046.2810811-15-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GV4PR04MB11852:EE_
X-MS-Office365-Filtering-Correlation-Id: 911a4737-7c9e-47a0-504c-08de25c8cf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7Lyw7Jaep8HXJfCEruyI+zdUP8aVXkf8CDuuqe4LtoRgviHjeIVI1HcCfeA?=
 =?us-ascii?Q?/PNoViIkshEFBH1ZULnVYGRR4W2prOngv1qfosiA6M94tsHQJM0UWjI1LY16?=
 =?us-ascii?Q?5ejup+JUbQNGgZdp1WEAlP9N6yMKb4vbjOmZp1k0khCvA2R2c6/DM6ThwfnG?=
 =?us-ascii?Q?/vIGapO7NfhbPULhU5ktoP1wUiocfz16zor5wyJlycEtjWMYnNjR8pvCxzfx?=
 =?us-ascii?Q?24slUC3Erj+Re/WV78jLqXwjL7wkgEk0qtbRg/1luLci74jTLZblBvXkpBpt?=
 =?us-ascii?Q?Ai8qIq7ReL6pfBAaCaLoUlVyeHrEBkV1nS9HwkkvWsExzpjLfHBM6MwzZVvt?=
 =?us-ascii?Q?68SzWrsgZCgHwvkmj9D6+e+eRrdVqhYXFh+/2tnGMG9zXPOz7xBVvx+VZj8J?=
 =?us-ascii?Q?ARQXX6j1QQAUnh4Dr2cghEXAkPz9qDOtdr5txFOsLCwsGJoof1tSnwHURHcl?=
 =?us-ascii?Q?F5hwMNNsZn7Cn6TZsBZVNLb5de4tRsMKnep5Jb8yyw7wfhyZXUG72XYCxQ9c?=
 =?us-ascii?Q?Kdlak53dsh6CqLBjLojIHGlZ9hM6sdJacD7kbRpW/Ukg9jCpnQJCQdHtQhga?=
 =?us-ascii?Q?WWQq9ne3xxnVnH/E0kZgrp3FboLh2RFjwxLOAs4mbQ55XK7PMyuxszMkjhkS?=
 =?us-ascii?Q?L7CPwMN+w0JfE7PcxpMCsST2JsGHB+Qma1f1mcxhnlerE/OhGJm4rB/fVa40?=
 =?us-ascii?Q?27I36C56JWTB0Eqfj0T+JOeOhuOnX5NMuRmxY8z4es6wgbpKUYlntNTsJj/s?=
 =?us-ascii?Q?qlCAzBnmzX05b4e97Q+pHqZk3jaW0hMbliI17+1II7N7Rivu4ZHdABPpsbVz?=
 =?us-ascii?Q?i2D79BeCMwQz9v2vB10gBDYEwvat39R9ods12FBf12s9zzVDq6Dpc1qxCkmQ?=
 =?us-ascii?Q?tiE3UkC3v07GOymb3SrN8oeDSHlps9RV0AQRJjuBZa1uLJr6kiG526MRsto2?=
 =?us-ascii?Q?LQJm549Iy9N4ip3U5H8hWtmvwj3tX6f/R5NNfVObDuY7FzwdPXYaWo3XTviM?=
 =?us-ascii?Q?o+8TMBGk8MhED9ZOpqcT8oYBdq5+bSCNYWZ1AMaHjTe3Dn2GcJWQIo43FS7n?=
 =?us-ascii?Q?cdfWlx82obQEf1jPo4KJa1X1w5MZi3l0MscKZqLMgWbeE2Lv3ZbqK4LyP0AP?=
 =?us-ascii?Q?NtoJXe9cSp9F75rSe2FbSbO3RBrk68qlS9Ww4uUkeMmUTf6DxfTxDyqcfAqQ?=
 =?us-ascii?Q?ofnqzxWxFDHoKj2B9yuBkjRd8dZJc9wIGg+4d4r/vdQyzT9HVa0M2blVMyvp?=
 =?us-ascii?Q?8Esm3ykWkAUQFJkduFMdjFu0/R2Xmy/ayN+LCxuJXvJnSh6KhAWMQkG2HqQ0?=
 =?us-ascii?Q?x2n3X9daoUoz/mR0AYaAelo/wJDU99abMMUC8KKuWytv7wxYjb9d/SBWGzyd?=
 =?us-ascii?Q?lAVmsUwqY0ArrTZcr6NR2KTwov1hF/kUejdD12ExEaokPWXMwXPIcUCPlORv?=
 =?us-ascii?Q?6YRIiRZS70WLblMexZIpEhmgMfyPZR7ifeLt+4DBkLmmXpEv8YKrxcqKTIKt?=
 =?us-ascii?Q?iF2F7bAExWSIwU7Jke9Dwy+huFoKqsFjadw6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+rSm0N5tZchdB6rwgVjxj7KzmEL5mO7CbqhIvZOc7nELY4C5qBgJ9PeMw0w?=
 =?us-ascii?Q?2RzIfspg99/gx51s24Snv/G0I/f11IZuK7vcjg6DxWmat6GzJs783wmKX+Gy?=
 =?us-ascii?Q?C1vNUdw9YOiYNbxaKvP6fyI5cYW8NjxIq8XbGpshMVgB6qgeZMjezPMZNFYB?=
 =?us-ascii?Q?78fkcVUd7xlMz5USW4ry/6P4xoLl/FgxNKp3PRIHR1lSjrHqQiZ9jP5V+oIg?=
 =?us-ascii?Q?PTKXnnlQtHD9gc8TuzIGkapkLceHS/CVGggAoKjYwmfThZxRzL+dHJzSqaU4?=
 =?us-ascii?Q?FF7CwSJmEGnIuhJTJD9640L8DrCenu8L5a7GTBx3U4o82lfXiV5bl/Prrnd0?=
 =?us-ascii?Q?dgZMLU0F6RcHpgzNiutx3S0mfmAxqMmTy8WdC1/V8C8AB8yJxXQSF0/MhuXS?=
 =?us-ascii?Q?91n+2Fs2JPM73YAe4He2vK3vEjI/2if+vX9zMB77RBVPp2ydBqIPX5DbWqoS?=
 =?us-ascii?Q?urMZDfUZf9wCXm4D5bIxI3Yt6asRYitaaRMsTEgL+hBErLkKg8WiYGDxqFkS?=
 =?us-ascii?Q?DIw0Tj7oJkLPmiRVX8iZ/TqTVs7uIs0+q7Fwd/cvkV0V2s45wPV/yvyk5Rok?=
 =?us-ascii?Q?rQQRxrkCsKsdgonz1tY2lDvBm2mO6a/wolaNJPzUKauueERLGK4SHk10o4yh?=
 =?us-ascii?Q?mT4bUuAvnTcySNkT0QuogsF1Ji57KM8A0UH1IxgzMVhGHAY+/pjWTGJSrNWY?=
 =?us-ascii?Q?PW9d2ealkZIn5AakOF4jjRyumI+iFLMVW3KBY3V4b0UEOouYi2Z6fZlUyNmL?=
 =?us-ascii?Q?JhKuZ45s3reOcyC1uCm7NbZ0r8QGJMFQQI/JskMmxLLulaea9NhCIN4N76te?=
 =?us-ascii?Q?jx76WO+SyTZ4OXm9Hi3RiqCUMLMLb/2LyTx7IlJbzmzCTkWPHQDHA+07tEfp?=
 =?us-ascii?Q?Tdm2OW7A1m/od0PW0+V+GUV9EeFPLjD/OqNJAcV0mUhpHqKYl7FVTSSnZa/t?=
 =?us-ascii?Q?bdtvd9/+qMVY/KIREm02fXXANyMYrIPQ3vO/fzxNT8ZCkUHkZdRJ8ZBcjyIU?=
 =?us-ascii?Q?WTv5BftrHQQM0etn3IjKphdwB2g3kwfgaY/ybUxfBNEi+BXZnAm1WVA8ZlLF?=
 =?us-ascii?Q?ASYPiD/yafoXTfmdUSQCmiYnXBRuQOez/WVTbxuk2Jy6ff6PBCrQansC6nwl?=
 =?us-ascii?Q?BOUt6qcTJA+Zz6Tt7S2yqrBfFSe2I1SQ/Uz9ni+ZTfjhY6lebuM3EpGTFOxe?=
 =?us-ascii?Q?/i4c5ALnfAyFgaJEPGd9h++vhFQe7CyMiXwEt8Dt9rSpm80s61zN2S1gEPwy?=
 =?us-ascii?Q?noxa3YpK6w+L8PKEj/a6IifJKkL2XjkfxGZq56GPqpGRsMOUbdSo5EsKsyLg?=
 =?us-ascii?Q?YR9LZ/F+fqNlamcq6K1omi0sEJ+/M9rNO8pokiSTtyYqe/zq7ATH+ho0HsD9?=
 =?us-ascii?Q?B3TRLIwWJLddcaexhd3Vr4xI+n38Dijp/NjXCBJiNNj7X4KBrSJGYp+L7FL+?=
 =?us-ascii?Q?yg+8Fk7fPua2r5j4ifaHzjTMHxQd/oXjghnKsNaS1SlGIPswHMy5OR4n8x52?=
 =?us-ascii?Q?50AUAwxNSaHtoYdb6s8nVabLJpgpmUKglVt3wMO0wsDjZH6pjA4pnQbQudxO?=
 =?us-ascii?Q?N5ySlFXOxr7CdYZBSt/Thtz6vq/NrRYvCelwJH/w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911a4737-7c9e-47a0-504c-08de25c8cf98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:34.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dllZFwqkY7dyaAeavB2sjVXmPJGPxxFR4nGwRwqkzX8k4IK+tPZTo0ZplMK5/XFPCMcvR7gpAfvb/B7MvIq3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11852

This patch adds a comprehensive debugfs interface for the nxpwifi driver,
enabling easier diagnostics, testing, and runtime inspection.

These tools are useful for both development and field debugging, especially
for validating DFS behavior, power management, and firmware interaction.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/debugfs.c | 1221 ++++++++++++++++++++
 1 file changed, 1221 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/debugfs.c b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
new file mode 100644
index 000000000000..d87460ee87b5
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/debugfs.c
@@ -0,0 +1,1221 @@
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
+		nxpwifi_dbg(adapter, INFO, "Resetting per request\n");
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
+	u16 twt_mantissa, bcn_miss_threshold;
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
+		     &twt_mantissa,
+		     &twt_cfg.param.twt_setup.twt_request,
+		     &bcn_miss_threshold);
+
+	twt_cfg.param.twt_setup.twt_mantissa = cpu_to_le16(twt_mantissa);
+	twt_cfg.param.twt_setup.bcn_miss_threshold = cpu_to_le16(bcn_miss_threshold);
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
+	u32 suspend_duration;
+
+	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = sscanf(buf, "%hhu %u",
+		     &twt_cfg.param.twt_information.flow_identifier, &suspend_duration);
+	twt_cfg.param.twt_information.suspend_duration = cpu_to_le32(suspend_duration);
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


