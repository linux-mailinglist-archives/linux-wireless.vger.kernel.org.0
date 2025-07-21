Return-Path: <linux-wireless+bounces-25733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0818B0BCAC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285FB1753E7
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15E288C33;
	Mon, 21 Jul 2025 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DGnGQQHk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737A2882C4;
	Mon, 21 Jul 2025 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079532; cv=fail; b=SSxOxW4l204io7MLPM2xAY0NmL2PmEJ/jTAs2cMYcmRDjGFxPCpqWRkcfmwWurYwzDLUziUn65gst2JAt8+R+O4pcBiuc5vFeSv4IIefaBnxbwl5TV5YEIldi7kSLQuLeCHjq8XF0ljh8uu+v9QQxT2N9Er6sBFY+XTxwiB2EAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079532; c=relaxed/simple;
	bh=db5IftD8fjkxlUZHlBQd2WSDWQb+PCTl4/QIk7trJc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Clu9WZM7FQNiAwnqmQ3rDvmUQhGt5xJlTjTSym1VHGWXdGu4dBcWXP17dw+62IuSNfMKTUpQKJy7v5ZXQNwuKKmokSRYObsAtDrspKGwg2U8xIXjszM8l2DNXtEXg4Mirbf3eLn0N2nyX1liYeqyETCiWDQOXXdvQZ53YgmfaVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DGnGQQHk; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTG6IZebrq0kwCHtlqjQRvsFMaAiuZZiAH1nCwH97ghG6GHWn+eRKRWhdhjL28+T0Ay1CJ2wRbQYKqfkKXIAJijbeetu2pgXVSTNsqFpAhT3Uy4upJfC5YuOyt4Rj4k6OQyDMU+0dTqntuxNK/OjO6Oex0jDoFuyc2KFsUGlMFV5Be2CywqpIZtUieW/5nV/OrLpnPtI0DfrXaf8424T+DOZqKueoHMG7tcN0ZRCku3dcYIrcYVrxwSe3sZ5dld6cdRHt7aUEozFEIgUUqtsabOBnNNjqYFcAx5b7aUwnNHFapxAqGmULoM61XvPnZvOyXrnH7XCSAWjLm0zWtXxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlBey5kPSQteKeY8heDreTajGIIM35wynR4tw1bAQUI=;
 b=c0SBZcoFKSGIKGxBOjzqKH+24nlasy69ql6nKmHW5TEqXJTT/ATXsoKN2pysV/DJyctM6c2mhhHCRZiFC+ptLgk4+oTV/je9XyibqiKAZZOrRylNtyiflgdX7ZHk7otXZc0HziZ4svPk0iOICdKb/a5l0S0FqoRMh3DYaGrkGbCj2zHVvSxOyU4ihYZqTh0t7GXUKOzLlCF3g9PsFknbODXnbW/e8myN+mAnabV+GADCV2OoJH0AXmILf7h8q0aewXFgxyYIEtC3GepYE5ShWVFRqHzaB4YafaV/eTaAp7PMxj6ZgPXCG2Pug1QbMf1qTgYjPE5jXfnMuiLPROo2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlBey5kPSQteKeY8heDreTajGIIM35wynR4tw1bAQUI=;
 b=DGnGQQHkyR80NHZRQA0Zxg9C+12CkPoA79yPTYvbzUr+1gut8BUheOvoyDlWoIc7qJl21fkE6inV3DUWPFxz8cTWlyKIpuYgzXP5Nx+95mdYeqwkYksteFieDpEuutfRnY7vwlaeJUk6xs9wankHk5WZVP6ykwX2HlmVH7wQ8uNP7e/Gvz/ap91GXe+cpBnkR9zAIhHMKXXHp8a4pEakMWIeowC31EYgoNnVuCsI0jEXBZUhHe+Bj4XgK60c0hXN49aL6/MGgnUWAZpgs+yRDPCSx+7PR2irK4TANqT2mA2u9nEWOoqUzYge8xztoCE9com1w/BqbtLBkVtVbPj7/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:32:01 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:32:01 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com,
	jeff.chen_1@nxp.com,
	brian.hsu@nxp.com
Subject: [PATCH v4 17/22] wifi: nxpwifi: add initialization file
Date: Mon, 21 Jul 2025 14:26:36 +0800
Message-Id: <20250721062641.2001796-18-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
References: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|AM8PR04MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f4a1ed-1f69-4b62-ded3-08ddc8204cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7W2cSKn1VOZrRwbkdQuOjvBzJj6lbCgqdIu6s+o47QUOAi0aeb8B7YTwF7w?=
 =?us-ascii?Q?WzcrkknxGcIVrfcSiSmlw0Hc5CvwEpiMRlHKLaaA/m4krEdHG5HWsjhtAY07?=
 =?us-ascii?Q?GuuAgriRKIdxf5lYQQ2RvNMuT0ydGXBpgxKgHrGn2a+7h/zM9KBrZPkwEFSJ?=
 =?us-ascii?Q?sZfY7M1ysgCAVusAYbIG3ii0HP45hA6j3ahm5IGoLzHSFyBWmf/jdriSSeoy?=
 =?us-ascii?Q?X8/wXviZ+zRWk+qo7+rzvfKFMUy3Z24KZMvbeo4TwFDFag4Tz3/cVapANvCl?=
 =?us-ascii?Q?zN0IDCm+5M7TCYf6AW1BYKO4ljUqMc5Wp/6qf4mHv9bcpoJ9B16ybzegv1+1?=
 =?us-ascii?Q?HiBE4k5CCbVKu7Lx53rFKxxIB/nrEJ3X+bz3A4pmT0MqhWyhEq3u6qQ+NjCL?=
 =?us-ascii?Q?AMbApSVqm8sBH3et3ie/l1cCptrwceY7PFJzLDAzDFtMed5FOtqAtYXbBdRo?=
 =?us-ascii?Q?c1IBMrWDWdLVjPq3AdvJV++EchVOqwiRrGPuy+R8WjZblPtwyIRSEzxG2R6O?=
 =?us-ascii?Q?G2I4/9M+0/cNbOZ7/UFAg/iQCN8qJ2YeS3ddshHzHX09D0Kho6861RnqgLTm?=
 =?us-ascii?Q?rDyHEQ5z4R/Ff1CvlH/HV5altu49TT3gt+pLXFPDDx3vc8U/ZQysg0qkVGqu?=
 =?us-ascii?Q?KzGPCwyb8UoPZkoC6J7Jym0nYpFJzYwJxVSaLDwz3sFtVdxnJR/Za0BM/eFB?=
 =?us-ascii?Q?P2ttKqI/yXPCfYie4KitMh7K4qUEV9zbkDT0PARPfAD0Wu2QSs1QAs43p2HB?=
 =?us-ascii?Q?dG2iqm95tonp+duMO2tvVrI/+eQXg3+rSlCePEbKUVk1/y+C/bgOkakp1CQE?=
 =?us-ascii?Q?5wrF0aKUu9wrQHJ20zJHzE7xaPgHomjb1YG9DzPNd3KCp38ifd1+inA9gA8M?=
 =?us-ascii?Q?7IiNDOrjG1MjYXlUhDZIcVtpv70W5S4G7UKVk8AlEh7z37dEjEHTvMOEcvYy?=
 =?us-ascii?Q?3eAzfcjGG8pT1KE9nZ1YA3JUs6DemaD9yfG5875L7xQEGjj1uiyHCYdXoKGN?=
 =?us-ascii?Q?O0r8drEmYA8L9HOT/75OjeBXiPGvuZ5bt1s/CO7qVOZrTG1lrm1aMrk6y/xr?=
 =?us-ascii?Q?ta3Mayx+3yAkFxNLm+9TErehC/VrUGpUGvYGUFf2PRmjRz5cPNjmfB91lNMx?=
 =?us-ascii?Q?zs6KfIJwJcm3ealEyhSPjjjR63iaU9CKXvQKyCOMpSMNh6GYZuO24tgTkVNm?=
 =?us-ascii?Q?oBK2uP/pH6BhzIcdJXyxD6FvczphpmqCRFny50+1lkmTcdIJcb8J9K9OiQJi?=
 =?us-ascii?Q?EBBvCiZ1z3G98qksIPQWPm+woYgw9oCL7n7prD/pNm5NAtJliDW6V6nQGK1U?=
 =?us-ascii?Q?cYhnQMkknINbRPaYIJkoKsAXEoO0rvWFtuiOxvyDeQAzmZpy5vc5I9N4baut?=
 =?us-ascii?Q?qWw2FHZzGG8GHLbK4riHy9SyIX2ZgoU0bYkS/82a1xZpxNBXMCSXI4LCGa/m?=
 =?us-ascii?Q?HyJfbGh31qLu7I/tVBfekqxucEYnBfk6ANhduDrC4Fw8LZU6LO1Tsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DG32L10+FgDekJ4vA9BBmmNa+1WZWy9hvhqVFDroPOzmTxN/FELcg4PbN3uw?=
 =?us-ascii?Q?V9lEpPfKCXAzEvqTA92ONj0VsOJVMlD1JCCF7Fe25cWlgbG9QmLuBOAhY76i?=
 =?us-ascii?Q?3p0wiZ/6yEXJ5WHrz3HrecM2w2F93yYRHm+iqKwUBQLVh1wjqdn0nQvPi0X7?=
 =?us-ascii?Q?+nW4AQHjgbfwS1EJOhYRU0+l8LWtkfqqEe5THBG/kCEnIdXcgul7YPD0tAVj?=
 =?us-ascii?Q?traJ1K2oTy2DEnnyGswgCjrJgnKQjxl1OhqN8nzBX0Bq1WAHR9zEfrY6tPFd?=
 =?us-ascii?Q?U2xlCSHPGHeyms48nVA6p6KISq0oQ+QWbUA4AZVSIpqeTGHwfJfp7P6picpg?=
 =?us-ascii?Q?OH37jivfO3gvSU0cDfhEiSBpiW66BK46P3P8wo2zXHjHgMirXcRx9ty/x3Dp?=
 =?us-ascii?Q?NXlJmelPFBQ+u8FXtm1gCxB5rvPJRrJwO8Fj/r9WI9hB33whtiADNptPdlfr?=
 =?us-ascii?Q?S8L7GT357MvsZHIAtqtKHdQvwTlp11pFe4IRuY5Dl6S+njxdlN58c/tweKKg?=
 =?us-ascii?Q?9zr6Qhhm7/Fxv2RotQXIlaX9ZKUMw+jzy7jT3rhaFXDOToyZAqlFaNvzoX1k?=
 =?us-ascii?Q?rM7SqVw69x/5Dx9kWGm5s5rnDs7AIxt3iATxVFXg7m16DVviC/liyQatcatu?=
 =?us-ascii?Q?9K7fRn4rcyvO6UZnoZK+afYFRyY6lF1rC85H5aAq5L/mhSEHvs+JrFBQtS8L?=
 =?us-ascii?Q?gyLc0fqtI0d6u/cCESEcqJyFWRQ53cc3heIt3NqZfCjff4ObxpP2TsOTisWX?=
 =?us-ascii?Q?vk2ZP/GweUlOisrEdz28QDr+oNV5Qk1OYDQ5XLIoxX7nVR13iLKGw1VRQQLH?=
 =?us-ascii?Q?RUfLNHYmVC8LcbKf7t5yVHuF0UVZdZIQu/sNn10g3YxMPzFkSGX1bcqyA65U?=
 =?us-ascii?Q?82DcnEiFhA8sx0MFGJYI+/zEwMprIiEzPOr4VH3ysn+A5xKQo58RTmLRykbi?=
 =?us-ascii?Q?uJZ4DG2C/q3ptsBQceg4V+ngNEQwcJ0wuzB1u8pDBd/CzTvSCXtdK7kw/SnC?=
 =?us-ascii?Q?OQvn+3f7ZyIFHvY+Xb71qT8VTAbdunL0VsWi/17IopZ3kGCywzFPvDU78vzq?=
 =?us-ascii?Q?/KYQUJTSfwpmrm/CI/AWqVf0xGiFXsl0Ik+Q/Z/p0MXSpzxjf6awxMX5lXM6?=
 =?us-ascii?Q?gmDf5R9rmN40ge3KwxWA385OT1PqJeL7zxtiU0abn2tOhZ67qxpNXAegSwkc?=
 =?us-ascii?Q?XmklB6xEG9VEqxg90nGYrNORiIwqQHP4LdTpPaadKYjpTrN5UFBUVtcL64/e?=
 =?us-ascii?Q?k7N7G/raWibnArVSDUimPLR59+DYmWppp1XmfWraO0wnG+Gop+03ZBsVv+Tp?=
 =?us-ascii?Q?HIJzKXWL1zd6QTH6mJ9JV6u1qtbCf52GbEfNmAhtbAmh3S2gpyrz0Fk8IJ1E?=
 =?us-ascii?Q?1LO57D5kiRcT/zfV3lzYz1z/lPCR1G3QadQDpSU8uzC1fEk6CayW4JZLJqlu?=
 =?us-ascii?Q?ZDJYaExch0xDrs4aHzN6L0v0teR5rjiLG03d9ERaxWkHV8VOG6FIhHxBgbMP?=
 =?us-ascii?Q?LRoCmG/BEBwuYO68nXUCK8UNn9V2ETVseRJOKgRMde0E6yrYSqBwneYFjkAX?=
 =?us-ascii?Q?Q8SomM1BXYOTO4gG2IysZdaFk1Jb8eTCvZCcuZmb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f4a1ed-1f69-4b62-ded3-08ddc8204cff
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:32:01.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9l9Dk7n5kgWpt2ekNW2+yQsS4o6zzsyO3cAG5v1CsuR0Was7T4mAKHWQWBkb8kObVAiOLp1r9M40bE4xx7pLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780

Support initialization functions.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/init.c | 684 ++++++++++++++++++++++++
 1 file changed, 684 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/init.c b/drivers/net/wireless/nxp/nxpwifi/init.c
new file mode 100644
index 000000000000..7e0fc541e6f0
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/init.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: HW/FW Initialization
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
+/* This function adds a BSS priority table to the table list.
+ *
+ * The function allocates a new BSS priority table node and adds it to
+ * the end of BSS priority table list, kept in driver memory.
+ */
+static int nxpwifi_add_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bss_prio;
+	struct nxpwifi_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
+
+	bss_prio = kzalloc(sizeof(*bss_prio), GFP_KERNEL);
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
+	struct nxpwifi_adapter *adapter = from_timer(adapter, t, wakeup_timer);
+
+	nxpwifi_dbg(adapter, ERROR, "Firmware wakeup failed\n");
+	adapter->hw_status = NXPWIFI_HW_STATUS_RESET;
+	nxpwifi_cancel_all_pending_cmd(adapter);
+
+	if (adapter->if_ops.card_reset)
+		adapter->if_ops.card_reset(adapter);
+}
+
+/* This function initializes the private structure and sets default
+ * values to the members.
+ *
+ * Additionally, it also initializes all the locks and sets up all the
+ * lists.
+ */
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
+/* This function allocates buffers for members of the adapter
+ * structure.
+ *
+ * The memory allocated includes scan table, command buffers, and
+ * sleep confirm command buffer. In addition, the queues are
+ * also initialized.
+ */
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
+/* This function initializes the adapter structure and sets default
+ * values to the members of adapter.
+ *
+ * This also initializes the WMM related parameters in the driver private
+ * structures.
+ */
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
+}
+
+/* This function sets trans_start per tx_queue
+ */
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
+/* This function wakes up all queues in net_device
+ */
+void nxpwifi_wake_up_net_dev_queue(struct net_device *netdev,
+				   struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_wake_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* This function stops all queues in net_device
+ */
+void nxpwifi_stop_net_dev_queue(struct net_device *netdev,
+				struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_stop_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* This function invalidates the list heads.
+ */
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
+/* This function performs cleanup for adapter structure.
+ *
+ * The cleanup is done recursively, by canceling all pending
+ * commands, freeing the member buffers previously allocated
+ * (command buffers, scan table buffer, sleep confirm command
+ * buffer), stopping the timers and calling the cleanup routines
+ * for every interface.
+ */
+static void
+nxpwifi_adapter_cleanup(struct nxpwifi_adapter *adapter)
+{
+	del_timer(&adapter->wakeup_timer);
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
+/*  This function intializes the lock variables and
+ *  the list heads.
+ */
+void nxpwifi_init_lock_list(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	spin_lock_init(&adapter->int_lock);
+	spin_lock_init(&adapter->main_proc_lock);
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
+		idr_init(&priv->ack_status_frames);
+	}
+}
+
+/* This function initializes the firmware.
+ *
+ * The following operations are performed sequentially -
+ *      - Allocate adapter structure
+ *      - Initialize the adapter structure
+ *      - Initialize the private structure
+ *      - Add BSS priority tables to the adapter structure
+ *      - For each interface, send the init commands to firmware
+ *      - Send the first command in command pending queue, if available
+ */
+int nxpwifi_init_fw(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+	struct nxpwifi_private *priv;
+	u8 i;
+	bool first_sta = true;
+	int is_cmd_pend_q_empty;
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
+		if (ret && ret != -EINPROGRESS)
+			return ret;
+
+		first_sta = false;
+	}
+
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+	if (!is_cmd_pend_q_empty)
+		/* Send the first command in queue and return */
+		nxpwifi_main_process(adapter);
+	else
+		adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+
+	return ret;
+}
+
+/* This function deletes the BSS priority tables.
+ *
+ * The function traverses through all the allocated BSS priority nodes
+ * in every BSS priority table and frees them.
+ */
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
+/* This function frees the private structure, including cleans
+ * up the TX and RX queues and frees the BSS priority tables.
+ */
+void nxpwifi_free_priv(struct nxpwifi_private *priv)
+{
+	nxpwifi_clean_txrx(priv);
+	nxpwifi_delete_bss_prio_tbl(priv);
+	nxpwifi_free_curr_bcn(priv);
+}
+
+/* This function is used to shutdown the driver.
+ *
+ * The following operations are performed sequentially -
+ *      - Check if already shut down
+ *      - Make sure the main process has stopped
+ *      - Clean up the Tx and Rx queues
+ *      - Delete BSS priority tables
+ *      - Free the adapter
+ *      - Notify completion
+ */
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
+		del_timer_sync(&adapter->cmd_timer);
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
+	spin_lock_bh(&adapter->rx_proc_lock);
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
+	spin_unlock_bh(&adapter->rx_proc_lock);
+
+	nxpwifi_adapter_cleanup(adapter);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_NOT_READY;
+}
+
+/* This function downloads the firmware to the card.
+ *
+ * The actual download is preceded by two sanity checks -
+ *      - Check if firmware is already running
+ *      - Check if the interface is the winner to download the firmware
+ *
+ * ...and followed by another -
+ *      - Check if the firmware is downloaded successfully
+ *
+ * After download is successfully completed, the host interrupts are enabled.
+ */
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


