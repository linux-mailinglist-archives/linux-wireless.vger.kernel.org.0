Return-Path: <linux-wireless+bounces-13286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E931989A91
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F0B21806
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01614F9F1;
	Mon, 30 Sep 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZXPD/tSu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20F7462;
	Mon, 30 Sep 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678259; cv=fail; b=PXNCEuYpoTi7jeo0pNjbsve1uscOztNil/9FzVqpn+O5v0BiJP5Zg1zhZEIRrSJwtqw0iVGFmdjZvrOxzNh7sKt8pJPbO5UFkVw4BRYCFuCWxIDF/n/NDzWk4Tp71X57YSith9vYiTPjyN1ZmLHbyalZICnkiuMkHzpNQ8OhceE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678259; c=relaxed/simple;
	bh=wnReHUm9OOtap1t5tBYQOwwSVSZOeovF3xzq6QoVg0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TfP0v2uXFiGkxYidVuZQe603+045UjgATNqNBCvjddmKOp9pxUdq4vdvLjz6lj1Egu8piVvSp2qj+TPPYvB3Bc874tYK0EwVCSc8v6B2QElp68EKHKfS5tCND13VQzLkVu312XlBnZWgKPcILAdmIV+SCEk4G4LOUczU0wkwoLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZXPD/tSu; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2qnmvd2eB6+Ws94tCTtUDqQayYPllnUYugOWBcxJ9IHYANp5R2CJeczi4zKzR0oXaXAqj3SZow7LaF7JYRdCllXJkGkhEAXdv624curMheveItuIYhhm5PCmCma1Ysjdi1lvkhnZ6/NOCba3mgfh9VQPsvVurH7+Ajabq/F1pKTqdyMv59tGFrgM/c4J5QOoiHRAtPL6fbLGJZvAMbCcx+Fyx+F9KaDXxMLnL4310FxSJ28OKNk0hNE6G9EDf0bMkXs8UewSgUVAtzvFa1SMQFjncm9NZoWrKFDkUn+N7vYczohPScNFK57Dfg42LwGmrWs3Z3ownQVJr19YDRJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jfc1KkdBH60Wkqa8T1NLtl150HQxe0jMEWFSfoigAI4=;
 b=MHsCLGMR/sIfaOk8BhQjZ+q8Xud2PYsWcdsKaudjyK6jxHTdw6cdVy1Hr1DaXxUXZgAEdn1mRPhFTriCDNe20ofdHxRx3MjAE0b2icZVUqv9azThRwrLhoQYTLiGuNKAZHDvybjy/R+HiOvwjNCi250zsngQyrm755Zcx2nHZHXM6CFM/7jlrTC39wNjsoQPZo6o8RriArITUSNDwaEWnr3CajnCD9W4GlXDd3/UCqjOMqlBf1FNH0rpJxz0B/vDngUpeeaaErcuc4V9TLR4pTQfSu3p6EoiTEsqhD1PXd7yaW6b8tPoP8Vazn3sBnGl2ZvTULY1N4qaflzp30hRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfc1KkdBH60Wkqa8T1NLtl150HQxe0jMEWFSfoigAI4=;
 b=ZXPD/tSuVevAwOBzRodUf6bSdYZZe72FFvu5AcRLO43F0Xcn1r5v9CjsHUGRS43nw9dyLGKFUV0oo/atMSaly+YfsYfUBluhueonXnGWl4kl1th8MGngPGzmzeHi36zddQJr6UhoGbhHPXPdKlCkoTv8k9UuBLMdR89ynIyoQSrt/6395EN4mbjHXmo333qIg86AAbiGj+y6StSTRr63wG/t9PHGKkY/kUlq4qK2+dcQ0dAd6FXu3Bh4BwDMWNExF1hZNOr6yzwFNlX7YWpqHK6Dkba+ozGmw5o3whNgKULZ7AVbqOpO9ZnnloCGtYZHg0Bj/PSZIQIiGs/WWbE7ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB9000.eurprd04.prod.outlook.com (2603:10a6:10:2e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 30 Sep
 2024 06:37:31 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:37:31 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 01/22] wifi: nxpwifi: add 802.11n files
Date: Mon, 30 Sep 2024 14:36:40 +0800
Message-Id: <20240930063701.2566520-2-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DU2PR04MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f9b57b-c240-4844-b7ea-08dce11a5bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3xO8VbQF32Zez5LRJF1Y5I3E1UVVwGwGaX4tloHnuxzohjmtQ+AUQ8ga90rE?=
 =?us-ascii?Q?HrbKjuEgVyJAOUTl+8ZGx5OCql1jE4P/zwmPZsiOLNBUjeq2xIOBDY4Gcotr?=
 =?us-ascii?Q?Clto+old/QA1KW6UEgb51l0Xo1ukGgXsjuWTyBiUlajUl1FrsW/Pxdln/ivQ?=
 =?us-ascii?Q?oECyUSP2w+WCTtzSC9NoR7BRgek2dfgDKCAATM606l1bP7a8RsDrhqfqXapL?=
 =?us-ascii?Q?Hhm2hREzxwA/eDxK4PGrsZxq2o5KksHFak7g8oROMIU94cS6inj5tGdUnCwo?=
 =?us-ascii?Q?2noZ92oMsim3GhGDj5Jki4jacTN45S9zoGb1aCqfJTfr5B4xA5X56VMdSJru?=
 =?us-ascii?Q?OYYcKetURh3yh0blB62ME3U9nu4+SFZPaI8TJMxpWY0hgF9ql6K0dfkP39A+?=
 =?us-ascii?Q?p07+8FJFG2oFVuIZSLhnOChYZO4Y74wdgyT9A0xbnSAgZPsZMIM+5v3FyAl5?=
 =?us-ascii?Q?C8UL646mtb5Ps8r3+D5K2FC/+ZYGEkOmvZGUr8ENxPqSTtZVT1fH5fcJXmQu?=
 =?us-ascii?Q?7rI3PwkakzcRuE5AW48F0R1AnwX8kTpvtkY4wpEnBxsOswiqA4h+v/2xX1X+?=
 =?us-ascii?Q?9PnuuSqQF6xwxV/BJ9V6nD5WiFaU1gxbu6ypk2MfnoHNZF5dLyNLZLrNkhYe?=
 =?us-ascii?Q?Vccf5hnfReRRKL2eghzbBkQ1GH68bUQxIr782U+L/JB/sb5ROrf0XTTvx3HH?=
 =?us-ascii?Q?qlUGcANu0ykl2sVWYIAiDejtWOOWxtRXae0MZzqvmMTi2SQVqEoyb/f1h7bI?=
 =?us-ascii?Q?muD6UdxX3XDsqidFBl6epyxDPrHtBpcMR7PY5UlfTavWrw+3OYj9HmE31aFG?=
 =?us-ascii?Q?glotkmgFJTATIFUJIe43CweUlYmPJEejWxDBz5jWzGrld7lZXV2+g1iVSsu5?=
 =?us-ascii?Q?PoSk36m4COXK/4i/V6F96w5miIi2qRqJaU3OOGGxjaynEUwwR13N5W/CUDki?=
 =?us-ascii?Q?4NQ+HGC74hbxPrYDh1unArj12Q8KEtYQWYzkMggEsIVv7FOaagHtRQehl6aP?=
 =?us-ascii?Q?u3ByWfdfpUnicNHMzA1qHUkeVZgsa6APAp5SUUqaS7/YIY4yzai681M2ubUQ?=
 =?us-ascii?Q?XyhAyG1Z4ZuOCyhKIVjvG4zEqfPTsIAj+r3C0RmkcadbSQ8orBruXk/8uxHe?=
 =?us-ascii?Q?OQxt26zY9GvUbIu6piKUCRdenczdzjn1BtZY826EHzjc4RQ35h0HI+MaaDZ1?=
 =?us-ascii?Q?5yPUd/QEFGVoXBoT1fTX3TLkda7tR95AqOX9mi10eE3yy3X2H6yiZ3oc2nl0?=
 =?us-ascii?Q?85Ngm2jthfZuEci7TwwiI8clVuatOylRRU2AWSEipUwhZhlq6p+138YbLZcX?=
 =?us-ascii?Q?oPNpiQk+EZDgnr3F1yfo8x8AQYWQg5bATfjZsPSlLhAqtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgAFwBBiNns2LjVKprqAZdxQxByjLZE1VKqVWkBzjEQDlJ8EubMTjYBcW1dD?=
 =?us-ascii?Q?NfxJ2rpB7ECp5KCvweSCOBekl7LqZBD0/pQqFsaKWcZaGp+GInSvcC+kUwTu?=
 =?us-ascii?Q?IQutJa++2OuGkOF/ayX+IJzhGGyKMRf1pMkWGVQ0P5HlBYO34sQraV1TRf96?=
 =?us-ascii?Q?iqWLuSs/dDyZnuFF9Afp1dpXy17lz/hX5MmjW3vVgY2hKBQkf5XqcZhlGfez?=
 =?us-ascii?Q?Bg/cJR+SvJ0vuZ3Rl4EgIZ5khVqpWMIKcyvvMoXDywebzppb0AHouOVz9UJ0?=
 =?us-ascii?Q?aU7fkVtwyYYs1jnajdA6id3d2g+fI4BOTSiivHlW1jJ6neWc2f4Iiiz6kJmL?=
 =?us-ascii?Q?aMo0DUHukmJ8Q9GzRZkCM3ilXHUL+U+Jiz5furjnIo82NUBrcsKQO/c6E73d?=
 =?us-ascii?Q?ytJ1qbU6bbhSdwz55nY2okdlMb+LfblObpXSThKTn4eSyYROZW6kWotljqv3?=
 =?us-ascii?Q?8vZgUSI0FivhXVxG0DERp4vlDHGwFMhdlkk9QO8emFzkeEshrBWioJ8UqNLU?=
 =?us-ascii?Q?rng+lDEb0tU/gzPVMmkauXFdaxzfKR2Inh94xdkV21tfpvmMveLDspKgwjjZ?=
 =?us-ascii?Q?shFTFp2/duQG5ULp9oaRQnD6NZBzS267fwHYVws5LlleXP0FwJD8M6dmWOTy?=
 =?us-ascii?Q?jg9hGTToifyf3mkGzS1lJmONYEAS7gAYxYyrCNAnTEo5HSnQh4olhgoW2UgW?=
 =?us-ascii?Q?mkNrpaW7JvbEOlK1osyoO92eepGvL/KWDE3+UHserFmy8pJOpxdczxw9IYRs?=
 =?us-ascii?Q?Ozihc3E3uTKhSUIPIybXosch8FA2qsTp7XZdsJ2O5IqaCFVHq3aouGdWnfCn?=
 =?us-ascii?Q?/wuolRpD9nHx9Fcd3e5CPRzOipDYhEWXkrndGSyGPvA/P0tD5pYbj8V2dOg6?=
 =?us-ascii?Q?XHV+nvRejWLQZo/QA7xzdsEbkENHosnrTLX0a4TXwb2G2zKOUO2v4aPQk4ah?=
 =?us-ascii?Q?GUzi4guIu3omL6xggkDbLU/y8wukXbeYqWtWUlm0lZPbMtE1ymeTigJX2NJf?=
 =?us-ascii?Q?lYkXOXP6IGl3gxiXpO0B8jUBzSKDmrzWyr1q9g5zQY4dFJcx9D3hrQqEMM2f?=
 =?us-ascii?Q?x9wyvedLr+HdXT7+PQNDs9YmFaatMCyIaJ/xTkY20lGnbnfbdNC0PiPrkCB0?=
 =?us-ascii?Q?t6XlGHXSSlVpnSFBUtud5IBWNtwheeLLP2YeBQRGdQJBPdP7366osbKZk1zD?=
 =?us-ascii?Q?XVFYiIfu4rHKiEG3HbT9KHf3/+yrFqbi6Y1i6gcFpIRnMmvdW3YHOHSLWBpn?=
 =?us-ascii?Q?dPnNHO4TMMIzgBWuqOVYnvIH1axq+GiuYxMNL1NBTLuF76CCYAk3vIvHqxQv?=
 =?us-ascii?Q?oGAW5diOvhQIwrgOHPbOZZ9x86zFesOaVh7GWyWAYG14LUuL+rjMbGT11CpC?=
 =?us-ascii?Q?vxFM5RMsjLAtIq/N7AHenewICQ8KwwCPV2/fQfYNJr8Oet//TH2ZMhjQZ/Oz?=
 =?us-ascii?Q?TLu+LGO3hvCyG+6va7/0LJKJVxFgvfX8E7G61OxvvLz4SXrDpLOOuK8JhqRF?=
 =?us-ascii?Q?YTGH//MvYKrsvjTHthaN3GbHVIOYaRWAF1VFfV/fJ+JX+ckCQO1k1bjboJEQ?=
 =?us-ascii?Q?CN50HGnnLs0Ye2XaH0MGF2J2QCaKCjVuo9iQVAEn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f9b57b-c240-4844-b7ea-08dce11a5bbf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:37:31.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNx+KebX+oa0G9HH2FHkJ1MsKFLjgrc0KHmiOCYRcYxTstf0Jr6EiYcd4lRBZSg6DW77QznSAJ6NZEpUnP2xvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9000

For client mode, NXP firmware will help association process via
host command HOST_CMD_802_11_ASSOCIATE. IEs for 802.11n should be
converted from parameters passed from cfg80211 to TLVs appended
to host command HOST_CMD_802_11_ASSOCIATE.

For AP mode, IEs for 802.11n should be converted from parameters
passed from cfg80211 to TLVs appened to host command
HOST_CMD_UAP_SYS_CONFIG.

Because resource limitation of FW, AMSDU and BA Rx buffer and reorder
should be done by driver.

Files in this commit will support 802.11n features based on above
descriptions.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11n.c        | 848 ++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        | 161 ++++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   | 275 ++++++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |  21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  | 910 ++++++++++++++++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |  72 ++
 6 files changed, 2287 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n.c b/drivers/net/wireless/nxp/nxpwifi/11n.c
new file mode 100644
index 000000000000..a1b4e6e998a1
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n.c
@@ -0,0 +1,848 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11n
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
+/* Fills HT capability information field, AMPDU Parameters field, HT extended
+ * capability field, and supported MCS set fields.
+ *
+ * HT capability information field, AMPDU Parameters field, supported MCS set
+ * fields are retrieved from cfg80211 stack
+ *
+ * RD responder bit to set to clear in the extended capability header.
+ */
+int nxpwifi_fill_cap_info(struct nxpwifi_private *priv, u8 radio_type,
+			  struct ieee80211_ht_cap *ht_cap)
+{
+	u16 ht_cap_info;
+	u16 bcn_ht_cap = le16_to_cpu(ht_cap->cap_info);
+	u16 ht_ext_cap = le16_to_cpu(ht_cap->extended_ht_cap_info);
+	struct ieee80211_supported_band *sband =
+					priv->wdev.wiphy->bands[radio_type];
+
+	if (WARN_ON_ONCE(!sband)) {
+		nxpwifi_dbg(priv->adapter, ERROR, "Invalid radio type!\n");
+		return -EINVAL;
+	}
+
+	ht_cap->ampdu_params_info =
+		(sband->ht_cap.ampdu_factor &
+		 IEEE80211_HT_AMPDU_PARM_FACTOR) |
+		((sband->ht_cap.ampdu_density <<
+		 IEEE80211_HT_AMPDU_PARM_DENSITY_SHIFT) &
+		 IEEE80211_HT_AMPDU_PARM_DENSITY);
+
+	memcpy((u8 *)&ht_cap->mcs, &sband->ht_cap.mcs,
+	       sizeof(sband->ht_cap.mcs));
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION ||
+	    (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
+	     priv->adapter->sec_chan_offset != IEEE80211_HT_PARAM_CHA_SEC_NONE))
+		/* Set MCS32 for infra mode or ad-hoc mode with 40MHz support */
+		SETHT_MCS32(ht_cap->mcs.rx_mask);
+
+	/* Clear RD responder bit */
+	ht_ext_cap &= ~IEEE80211_HT_EXT_CAP_RD_RESPONDER;
+
+	ht_cap_info = sband->ht_cap.cap;
+	if (bcn_ht_cap) {
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+			ht_cap_info &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_SGI_40))
+			ht_cap_info &= ~IEEE80211_HT_CAP_SGI_40;
+		if (!(bcn_ht_cap & IEEE80211_HT_CAP_40MHZ_INTOLERANT))
+			ht_cap_info &= ~IEEE80211_HT_CAP_40MHZ_INTOLERANT;
+	}
+	ht_cap->cap_info = cpu_to_le16(ht_cap_info);
+	ht_cap->extended_ht_cap_info = cpu_to_le16(ht_ext_cap);
+
+	if (ISSUPP_BEAMFORMING(priv->adapter->hw_dot_11n_dev_cap))
+		ht_cap->tx_BF_cap_info = cpu_to_le32(NXPWIFI_DEF_11N_TX_BF_CAP);
+
+	return 0;
+}
+
+/* This function returns the pointer to an entry in BA Stream
+ * table which matches the requested BA status.
+ */
+static struct nxpwifi_tx_ba_stream_tbl *
+nxpwifi_get_ba_status(struct nxpwifi_private *priv,
+		      enum nxpwifi_ba_status ba_status)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		if (tx_ba_tsr_tbl->ba_status == ba_status) {
+			spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+			return tx_ba_tsr_tbl;
+		}
+	}
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+	return NULL;
+}
+
+/* This function handles the command response of delete a block
+ * ack request.
+ *
+ * The function checks the response success status and takes action
+ * accordingly (send an add BA request in case of success, or recreate
+ * the deleted stream in case of failure, if the add BA was also
+ * initiated by us).
+ */
+int nxpwifi_ret_11n_delba(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp)
+{
+	int tid;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tbl;
+	struct host_cmd_ds_11n_delba *del_ba = &resp->params.del_ba;
+	u16 del_ba_param_set = le16_to_cpu(del_ba->del_ba_param_set);
+
+	tid = del_ba_param_set >> DELBA_TID_POS;
+	if (del_ba->del_result == BA_RESULT_SUCCESS) {
+		nxpwifi_del_ba_tbl(priv, tid, del_ba->peer_mac_addr,
+				   TYPE_DELBA_SENT,
+				   INITIATOR_BIT(del_ba_param_set));
+
+		tx_ba_tbl = nxpwifi_get_ba_status(priv, BA_SETUP_INPROGRESS);
+		if (tx_ba_tbl)
+			nxpwifi_send_addba(priv, tx_ba_tbl->tid,
+					   tx_ba_tbl->ra);
+	} else { /*
+		  * In case of failure, recreate the deleted stream in case
+		  * we initiated the DELBA
+		  */
+		if (!INITIATOR_BIT(del_ba_param_set))
+			return 0;
+
+		nxpwifi_create_ba_tbl(priv, del_ba->peer_mac_addr, tid,
+				      BA_SETUP_INPROGRESS);
+
+		tx_ba_tbl = nxpwifi_get_ba_status(priv, BA_SETUP_INPROGRESS);
+
+		if (tx_ba_tbl)
+			nxpwifi_del_ba_tbl(priv, tx_ba_tbl->tid, tx_ba_tbl->ra,
+					   TYPE_DELBA_SENT, true);
+	}
+
+	return 0;
+}
+
+/* This function handles the command response of add a block
+ * ack request.
+ *
+ * Handling includes changing the header fields to CPU formats, checking
+ * the response success status and taking actions accordingly (delete the
+ * BA stream table in case of failure).
+ */
+int nxpwifi_ret_11n_addba_req(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp)
+{
+	int tid, tid_down;
+	struct host_cmd_ds_11n_addba_rsp *add_ba_rsp = &resp->params.add_ba_rsp;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tbl;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	u16 block_ack_param_set = le16_to_cpu(add_ba_rsp->block_ack_param_set);
+
+	add_ba_rsp->ssn = cpu_to_le16((le16_to_cpu(add_ba_rsp->ssn))
+			& SSN_MASK);
+
+	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
+	       >> BLOCKACKPARAM_TID_POS;
+
+	tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+	ra_list = nxpwifi_wmm_get_ralist_node(priv, tid_down,
+					      add_ba_rsp->peer_mac_addr);
+	if (le16_to_cpu(add_ba_rsp->status_code) != BA_RESULT_SUCCESS) {
+		if (ra_list) {
+			ra_list->ba_status = BA_SETUP_NONE;
+			ra_list->amsdu_in_ampdu = false;
+		}
+		nxpwifi_del_ba_tbl(priv, tid, add_ba_rsp->peer_mac_addr,
+				   TYPE_DELBA_SENT, true);
+		if (add_ba_rsp->add_rsp_result != BA_RESULT_TIMEOUT)
+			priv->aggr_prio_tbl[tid].ampdu_ap =
+				BA_STREAM_NOT_ALLOWED;
+		return 0;
+	}
+
+	tx_ba_tbl = nxpwifi_get_ba_tbl(priv, tid, add_ba_rsp->peer_mac_addr);
+	if (tx_ba_tbl) {
+		nxpwifi_dbg(priv->adapter, EVENT, "info: BA stream complete\n");
+		tx_ba_tbl->ba_status = BA_SETUP_COMPLETE;
+		if ((block_ack_param_set & BLOCKACKPARAM_AMSDU_SUPP_MASK) &&
+		    priv->add_ba_param.tx_amsdu &&
+		    priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED)
+			tx_ba_tbl->amsdu = true;
+		else
+			tx_ba_tbl->amsdu = false;
+		if (ra_list) {
+			ra_list->amsdu_in_ampdu = tx_ba_tbl->amsdu;
+			ra_list->ba_status = BA_SETUP_COMPLETE;
+		}
+	} else {
+		nxpwifi_dbg(priv->adapter, ERROR, "BA stream not created\n");
+	}
+
+	return 0;
+}
+
+/* This function prepares command of reconfigure Tx buffer.
+ *
+ * Preparation includes -
+ *      - Setting command ID, action and proper size
+ *      - Setting Tx buffer size (for SET only)
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_recfg_tx_buf(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd, int cmd_action,
+			     u16 *buf_size)
+{
+	struct host_cmd_ds_txbuf_cfg *tx_buf = &cmd->params.tx_buf;
+	u16 action = (u16)cmd_action;
+
+	cmd->command = cpu_to_le16(HOST_CMD_RECONFIGURE_TX_BUFF);
+	cmd->size =
+		cpu_to_le16(sizeof(struct host_cmd_ds_txbuf_cfg) + S_DS_GEN);
+	tx_buf->action = cpu_to_le16(action);
+	switch (action) {
+	case HOST_ACT_GEN_SET:
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: set tx_buf=%d\n", *buf_size);
+		tx_buf->buff_size = cpu_to_le16(*buf_size);
+		break;
+	case HOST_ACT_GEN_GET:
+	default:
+		tx_buf->buff_size = 0;
+		break;
+	}
+	return 0;
+}
+
+/* This function prepares command of AMSDU aggregation control.
+ *
+ * Preparation includes -
+ *      - Setting command ID, action and proper size
+ *      - Setting AMSDU control parameters (for SET only)
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_amsdu_aggr_ctrl(struct host_cmd_ds_command *cmd,
+				int cmd_action,
+				struct nxpwifi_ds_11n_amsdu_aggr_ctrl *aa_ctrl)
+{
+	struct host_cmd_ds_amsdu_aggr_ctrl *amsdu_ctrl =
+		&cmd->params.amsdu_aggr_ctrl;
+	u16 action = (u16)cmd_action;
+
+	cmd->command = cpu_to_le16(HOST_CMD_AMSDU_AGGR_CTRL);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_amsdu_aggr_ctrl)
+				+ S_DS_GEN);
+	amsdu_ctrl->action = cpu_to_le16(action);
+	switch (action) {
+	case HOST_ACT_GEN_SET:
+		amsdu_ctrl->enable = cpu_to_le16(aa_ctrl->enable);
+		amsdu_ctrl->curr_buf_size = 0;
+		break;
+	case HOST_ACT_GEN_GET:
+	default:
+		amsdu_ctrl->curr_buf_size = 0;
+		break;
+	}
+	return 0;
+}
+
+/* This function prepares 11n configuration command.
+ *
+ * Preparation includes -
+ *      - Setting command ID, action and proper size
+ *      - Setting HT Tx capability and HT Tx information fields
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_11n_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_ds_11n_tx_cfg *txcfg)
+{
+	struct host_cmd_ds_11n_cfg *htcfg = &cmd->params.htcfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_11n_cfg) + S_DS_GEN);
+	htcfg->action = cpu_to_le16(cmd_action);
+	htcfg->ht_tx_cap = cpu_to_le16(txcfg->tx_htcap);
+	htcfg->ht_tx_info = cpu_to_le16(txcfg->tx_htinfo);
+
+	if (priv->adapter->is_hw_11ac_capable)
+		htcfg->misc_config = cpu_to_le16(txcfg->misc_config);
+
+	return 0;
+}
+
+/* This function appends an 11n TLV to a buffer.
+ *
+ * Buffer allocation is responsibility of the calling
+ * function. No size validation is made here.
+ *
+ * The function fills up the following sections, if applicable -
+ *      - HT capability IE
+ *      - HT information IE (with channel list)
+ *      - 20/40 BSS Coexistence IE
+ *      - HT Extended Capabilities IE
+ */
+int
+nxpwifi_cmd_append_11n_tlv(struct nxpwifi_private *priv,
+			   struct nxpwifi_bssdescriptor *bss_desc,
+			   u8 **buffer)
+{
+	struct nxpwifi_ie_types_htcap *ht_cap;
+	struct nxpwifi_ie_types_chan_list_param_set *chan_list;
+	struct nxpwifi_ie_types_2040bssco *bss_co_2040;
+	struct nxpwifi_ie_types_extcap *ext_cap;
+	int ret_len = 0;
+	struct ieee80211_supported_band *sband;
+	struct element *hdr;
+	u8 radio_type;
+
+	if (!buffer || !*buffer)
+		return ret_len;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	if (bss_desc->bcn_ht_cap) {
+		ht_cap = (struct nxpwifi_ie_types_htcap *)*buffer;
+		memset(ht_cap, 0, sizeof(struct nxpwifi_ie_types_htcap));
+		ht_cap->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		ht_cap->header.len =
+			cpu_to_le16(sizeof(struct ieee80211_ht_cap));
+		memcpy((u8 *)ht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_ht_cap,
+		       le16_to_cpu(ht_cap->header.len));
+
+		nxpwifi_fill_cap_info(priv, radio_type, &ht_cap->ht_cap);
+		/* Update HT40 capability from current channel information */
+		if (bss_desc->bcn_ht_oper) {
+			u8 ht_param = bss_desc->bcn_ht_oper->ht_param;
+			u8 radio =
+				nxpwifi_band_to_radio_type(bss_desc->bss_band);
+			int freq =
+				ieee80211_channel_to_frequency(bss_desc->channel,
+							       radio);
+			struct ieee80211_channel *chan =
+				ieee80211_get_channel(priv->adapter->wiphy, freq);
+
+			switch (ht_param & IEEE80211_HT_PARAM_CHA_SEC_OFFSET) {
+			case IEEE80211_HT_PARAM_CHA_SEC_ABOVE:
+				if (chan->flags & IEEE80211_CHAN_NO_HT40PLUS) {
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16
+					(~IEEE80211_HT_CAP_SUP_WIDTH_20_40);
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16(~IEEE80211_HT_CAP_SGI_40);
+				}
+				break;
+			case IEEE80211_HT_PARAM_CHA_SEC_BELOW:
+				if (chan->flags & IEEE80211_CHAN_NO_HT40MINUS) {
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16
+					(~IEEE80211_HT_CAP_SUP_WIDTH_20_40);
+					ht_cap->ht_cap.cap_info &=
+					cpu_to_le16(~IEEE80211_HT_CAP_SGI_40);
+				}
+				break;
+			}
+		}
+
+		*buffer += sizeof(struct nxpwifi_ie_types_htcap);
+		ret_len += sizeof(struct nxpwifi_ie_types_htcap);
+	}
+
+	if (bss_desc->bcn_ht_oper) {
+		chan_list =
+			(struct nxpwifi_ie_types_chan_list_param_set *)*buffer;
+		memset(chan_list, 0, struct_size(chan_list, chan_scan_param, 1));
+		chan_list->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
+		chan_list->header.len =
+			cpu_to_le16(sizeof(struct nxpwifi_chan_scan_param_set));
+		chan_list->chan_scan_param[0].chan_number =
+			bss_desc->bcn_ht_oper->primary_chan;
+		chan_list->chan_scan_param[0].radio_type =
+			nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+
+		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
+		    bss_desc->bcn_ht_oper->ht_param &
+		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
+			SET_SECONDARYCHAN
+			(chan_list->chan_scan_param[0].radio_type,
+			 (bss_desc->bcn_ht_oper->ht_param &
+			 IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
+
+		*buffer += struct_size(chan_list, chan_scan_param, 1);
+		ret_len += struct_size(chan_list, chan_scan_param, 1);
+	}
+
+	if (bss_desc->bcn_bss_co_2040) {
+		bss_co_2040 = (struct nxpwifi_ie_types_2040bssco *)*buffer;
+		memset(bss_co_2040, 0,
+		       sizeof(struct nxpwifi_ie_types_2040bssco));
+		bss_co_2040->header.type = cpu_to_le16(WLAN_EID_BSS_COEX_2040);
+		bss_co_2040->header.len =
+		       cpu_to_le16(sizeof(bss_co_2040->bss_co_2040));
+
+		memcpy((u8 *)bss_co_2040 +
+		       sizeof(struct nxpwifi_ie_types_header),
+		       bss_desc->bcn_bss_co_2040 +
+		       sizeof(struct element),
+		       le16_to_cpu(bss_co_2040->header.len));
+
+		*buffer += sizeof(struct nxpwifi_ie_types_2040bssco);
+		ret_len += sizeof(struct nxpwifi_ie_types_2040bssco);
+	}
+
+	if (bss_desc->bcn_ext_cap) {
+		hdr = (void *)bss_desc->bcn_ext_cap;
+		ext_cap = (struct nxpwifi_ie_types_extcap *)*buffer;
+		memset(ext_cap, 0, sizeof(struct nxpwifi_ie_types_extcap));
+		ext_cap->header.type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+		ext_cap->header.len = cpu_to_le16(hdr->datalen);
+
+		memcpy((u8 *)ext_cap->ext_capab,
+		       bss_desc->bcn_ext_cap + sizeof(struct element),
+		       le16_to_cpu(ext_cap->header.len));
+
+		if (hdr->datalen > 3 &&
+		    ext_cap->ext_capab[3] & WLAN_EXT_CAPA4_INTERWORKING_ENABLED)
+			priv->hs2_enabled = true;
+		else
+			priv->hs2_enabled = false;
+
+		*buffer += sizeof(struct nxpwifi_ie_types_extcap) + hdr->datalen;
+		ret_len += sizeof(struct nxpwifi_ie_types_extcap) + hdr->datalen;
+	}
+
+	return ret_len;
+}
+
+/* This function checks if the given pointer is valid entry of
+ * Tx BA Stream table.
+ */
+static int
+nxpwifi_is_tx_ba_stream_ptr_valid(struct nxpwifi_private *priv,
+				  struct nxpwifi_tx_ba_stream_tbl *tx_tbl_ptr)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+
+	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		if (tx_ba_tsr_tbl == tx_tbl_ptr)
+			return true;
+	}
+
+	return false;
+}
+
+/* This function deletes the given entry in Tx BA Stream table.
+ *
+ * The function also performs a validity check on the supplied
+ * pointer before trying to delete.
+ */
+void
+nxpwifi_11n_delete_tx_ba_stream_tbl_entry(struct nxpwifi_private *priv,
+					  struct nxpwifi_tx_ba_stream_tbl *tbl)
+{
+	if (!tbl && nxpwifi_is_tx_ba_stream_ptr_valid(priv, tbl))
+		return;
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: tx_ba_tsr_tbl %p\n", tbl);
+
+	list_del(&tbl->list);
+
+	kfree(tbl);
+}
+
+/* This function deletes all the entries in Tx BA Stream table.
+ */
+void nxpwifi_11n_delete_all_tx_ba_stream_tbl(struct nxpwifi_private *priv)
+{
+	int i;
+	struct nxpwifi_tx_ba_stream_tbl *del_tbl_ptr, *tmp_node;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry_safe(del_tbl_ptr, tmp_node,
+				 &priv->tx_ba_stream_tbl_ptr, list)
+		nxpwifi_11n_delete_tx_ba_stream_tbl_entry(priv, del_tbl_ptr);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+
+	INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr);
+
+	for (i = 0; i < MAX_NUM_TID; ++i)
+		priv->aggr_prio_tbl[i].ampdu_ap =
+			priv->aggr_prio_tbl[i].ampdu_user;
+}
+
+/* This function returns the pointer to an entry in BA Stream
+ * table which matches the given RA/TID pair.
+ */
+struct nxpwifi_tx_ba_stream_tbl *
+nxpwifi_get_ba_tbl(struct nxpwifi_private *priv, int tid, u8 *ra)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		if (ether_addr_equal_unaligned(tx_ba_tsr_tbl->ra, ra) &&
+		    tx_ba_tsr_tbl->tid == tid) {
+			spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+			return tx_ba_tsr_tbl;
+		}
+	}
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+	return NULL;
+}
+
+/* This function creates an entry in Tx BA stream table for the
+ * given RA/TID pair.
+ */
+void nxpwifi_create_ba_tbl(struct nxpwifi_private *priv, u8 *ra, int tid,
+			   enum nxpwifi_ba_status ba_status)
+{
+	struct nxpwifi_tx_ba_stream_tbl *new_node;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	int tid_down;
+
+	if (!nxpwifi_get_ba_tbl(priv, tid, ra)) {
+		new_node = kzalloc(sizeof(*new_node), GFP_ATOMIC);
+		if (!new_node)
+			return;
+
+		tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+		ra_list = nxpwifi_wmm_get_ralist_node(priv, tid_down, ra);
+		if (ra_list) {
+			ra_list->ba_status = ba_status;
+			ra_list->amsdu_in_ampdu = false;
+		}
+		INIT_LIST_HEAD(&new_node->list);
+
+		new_node->tid = tid;
+		new_node->ba_status = ba_status;
+		memcpy(new_node->ra, ra, ETH_ALEN);
+
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+		list_add_tail(&new_node->list, &priv->tx_ba_stream_tbl_ptr);
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+	}
+}
+
+/* This function sends an add BA request to the given TID/RA pair.
+ */
+int nxpwifi_send_addba(struct nxpwifi_private *priv, int tid, u8 *peer_mac)
+{
+	struct host_cmd_ds_11n_addba_req add_ba_req;
+	u32 tx_win_size = priv->add_ba_param.tx_win_size;
+	static u8 dialog_tok;
+	int ret;
+	u16 block_ack_param_set;
+
+	nxpwifi_dbg(priv->adapter, CMD, "cmd: %s: tid %d\n", __func__, tid);
+
+	memset(&add_ba_req, 0, sizeof(add_ba_req));
+
+	block_ack_param_set = (u16)((tid << BLOCKACKPARAM_TID_POS) |
+				    tx_win_size << BLOCKACKPARAM_WINSIZE_POS |
+				    IMMEDIATE_BLOCK_ACK);
+
+	/* enable AMSDU inside AMPDU */
+	if (priv->add_ba_param.tx_amsdu &&
+	    priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED)
+		block_ack_param_set |= BLOCKACKPARAM_AMSDU_SUPP_MASK;
+
+	add_ba_req.block_ack_param_set = cpu_to_le16(block_ack_param_set);
+	add_ba_req.block_ack_tmo = cpu_to_le16((u16)priv->add_ba_param.timeout);
+
+	++dialog_tok;
+
+	if (dialog_tok == 0)
+		dialog_tok = 1;
+
+	add_ba_req.dialog_token = dialog_tok;
+	memcpy(&add_ba_req.peer_mac_addr, peer_mac, ETH_ALEN);
+
+	/* We don't wait for the response of this command */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_11N_ADDBA_REQ,
+			       0, 0, &add_ba_req, false);
+
+	return ret;
+}
+
+/* This function sends a delete BA request to the given TID/RA pair.
+ */
+int nxpwifi_send_delba(struct nxpwifi_private *priv, int tid, u8 *peer_mac,
+		       int initiator)
+{
+	struct host_cmd_ds_11n_delba delba;
+	int ret;
+	u16 del_ba_param_set;
+
+	memset(&delba, 0, sizeof(delba));
+
+	del_ba_param_set = tid << DELBA_TID_POS;
+
+	if (initiator)
+		del_ba_param_set |= IEEE80211_DELBA_PARAM_INITIATOR_MASK;
+	else
+		del_ba_param_set &= ~IEEE80211_DELBA_PARAM_INITIATOR_MASK;
+
+	delba.del_ba_param_set = cpu_to_le16(del_ba_param_set);
+	memcpy(&delba.peer_mac_addr, peer_mac, ETH_ALEN);
+
+	/* We don't wait for the response of this command */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_11N_DELBA,
+			       HOST_ACT_GEN_SET, 0, &delba, false);
+
+	return ret;
+}
+
+/* This function sends delba to specific tid
+ */
+void nxpwifi_11n_delba(struct nxpwifi_private *priv, int tid)
+{
+	struct nxpwifi_rx_reorder_tbl *rx_reor_tbl_ptr;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_for_each_entry(rx_reor_tbl_ptr, &priv->rx_reorder_tbl_ptr, list) {
+		if (rx_reor_tbl_ptr->tid == tid) {
+			dev_dbg(priv->adapter->dev,
+				"Send delba to tid=%d, %pM\n",
+				tid, rx_reor_tbl_ptr->ta);
+			nxpwifi_send_delba(priv, tid, rx_reor_tbl_ptr->ta, 0);
+			goto exit;
+		}
+	}
+exit:
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+}
+
+/* This function handles the command response of a delete BA request.
+ */
+void nxpwifi_11n_delete_ba_stream(struct nxpwifi_private *priv, u8 *del_ba)
+{
+	struct host_cmd_ds_11n_delba *cmd_del_ba =
+		(struct host_cmd_ds_11n_delba *)del_ba;
+	u16 del_ba_param_set = le16_to_cpu(cmd_del_ba->del_ba_param_set);
+	int tid;
+
+	tid = del_ba_param_set >> DELBA_TID_POS;
+
+	nxpwifi_del_ba_tbl(priv, tid, cmd_del_ba->peer_mac_addr,
+			   TYPE_DELBA_RECEIVE, INITIATOR_BIT(del_ba_param_set));
+}
+
+/* This function retrieves the Rx reordering table.
+ */
+int nxpwifi_get_rx_reorder_tbl(struct nxpwifi_private *priv,
+			       struct nxpwifi_ds_rx_reorder_tbl *buf)
+{
+	int i;
+	struct nxpwifi_ds_rx_reorder_tbl *rx_reo_tbl = buf;
+	struct nxpwifi_rx_reorder_tbl *rx_reorder_tbl_ptr;
+	int count = 0;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_for_each_entry(rx_reorder_tbl_ptr, &priv->rx_reorder_tbl_ptr,
+			    list) {
+		rx_reo_tbl->tid = (u16)rx_reorder_tbl_ptr->tid;
+		memcpy(rx_reo_tbl->ta, rx_reorder_tbl_ptr->ta, ETH_ALEN);
+		rx_reo_tbl->start_win = rx_reorder_tbl_ptr->start_win;
+		rx_reo_tbl->win_size = rx_reorder_tbl_ptr->win_size;
+		for (i = 0; i < rx_reorder_tbl_ptr->win_size; ++i) {
+			if (rx_reorder_tbl_ptr->rx_reorder_ptr[i])
+				rx_reo_tbl->buffer[i] = true;
+			else
+				rx_reo_tbl->buffer[i] = false;
+		}
+		rx_reo_tbl++;
+		count++;
+
+		if (count >= NXPWIFI_MAX_RX_BASTREAM_SUPPORTED)
+			break;
+	}
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+
+	return count;
+}
+
+/* This function retrieves the Tx BA stream table.
+ */
+int nxpwifi_get_tx_ba_stream_tbl(struct nxpwifi_private *priv,
+				 struct nxpwifi_ds_tx_ba_stream_tbl *buf)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
+	struct nxpwifi_ds_tx_ba_stream_tbl *rx_reo_tbl = buf;
+	int count = 0;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		rx_reo_tbl->tid = (u16)tx_ba_tsr_tbl->tid;
+		nxpwifi_dbg(priv->adapter, DATA, "data: %s tid=%d\n",
+			    __func__, rx_reo_tbl->tid);
+		memcpy(rx_reo_tbl->ra, tx_ba_tsr_tbl->ra, ETH_ALEN);
+		rx_reo_tbl->amsdu = tx_ba_tsr_tbl->amsdu;
+		rx_reo_tbl++;
+		count++;
+		if (count >= NXPWIFI_MAX_TX_BASTREAM_SUPPORTED)
+			break;
+	}
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+
+	return count;
+}
+
+/* This function retrieves the entry for specific tx BA stream table by RA and
+ * deletes it.
+ */
+void nxpwifi_del_tx_ba_stream_tbl_by_ra(struct nxpwifi_private *priv, u8 *ra)
+{
+	struct nxpwifi_tx_ba_stream_tbl *tbl, *tmp;
+
+	if (!ra)
+		return;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry_safe(tbl, tmp, &priv->tx_ba_stream_tbl_ptr, list)
+		if (!memcmp(tbl->ra, ra, ETH_ALEN))
+			nxpwifi_11n_delete_tx_ba_stream_tbl_entry(priv, tbl);
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+}
+
+/* This function initializes the BlockACK setup information for given
+ * nxpwifi_private structure.
+ */
+void nxpwifi_set_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_STA_AMPDU_DEF_RXWINSIZE;
+	}
+
+	priv->add_ba_param.tx_amsdu = true;
+	priv->add_ba_param.rx_amsdu = true;
+}
+
+u8 nxpwifi_get_sec_chan_offset(int chan)
+{
+	u8 sec_offset;
+
+	switch (chan) {
+	case 36:
+	case 44:
+	case 52:
+	case 60:
+	case 100:
+	case 108:
+	case 116:
+	case 124:
+	case 132:
+	case 140:
+	case 149:
+	case 157:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_ABOVE;
+		break;
+	case 40:
+	case 48:
+	case 56:
+	case 64:
+	case 104:
+	case 112:
+	case 120:
+	case 128:
+	case 136:
+	case 144:
+	case 153:
+	case 161:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_BELOW;
+		break;
+	case 165:
+	default:
+		sec_offset = IEEE80211_HT_PARAM_CHA_SEC_NONE;
+		break;
+	}
+
+	return sec_offset;
+}
+
+/* This function will send DELBA to entries in the priv's
+ * Tx BA stream table
+ */
+static void
+nxpwifi_send_delba_txbastream_tbl(struct nxpwifi_private *priv, u8 tid)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_tx_ba_stream_tbl *tx_ba_stream_tbl_ptr;
+
+	list_for_each_entry(tx_ba_stream_tbl_ptr,
+			    &priv->tx_ba_stream_tbl_ptr, list) {
+		if (tx_ba_stream_tbl_ptr->ba_status == BA_SETUP_COMPLETE) {
+			if (tid == tx_ba_stream_tbl_ptr->tid) {
+				dev_dbg(adapter->dev,
+					"Tx:Send delba to tid=%d, %pM\n", tid,
+					tx_ba_stream_tbl_ptr->ra);
+				nxpwifi_send_delba(priv,
+						   tx_ba_stream_tbl_ptr->tid,
+						   tx_ba_stream_tbl_ptr->ra, 1);
+				return;
+			}
+		}
+	}
+}
+
+/* This function updates all the tx_win_size
+ */
+void nxpwifi_update_ampdu_txwinsize(struct nxpwifi_adapter *adapter)
+{
+	u8 i, j;
+	u32 tx_win_size;
+	struct nxpwifi_private *priv;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		tx_win_size = priv->add_ba_param.tx_win_size;
+
+		if (priv->bss_type == NXPWIFI_BSS_TYPE_STA)
+			priv->add_ba_param.tx_win_size =
+				NXPWIFI_STA_AMPDU_DEF_TXWINSIZE;
+
+		if (priv->bss_type == NXPWIFI_BSS_TYPE_UAP)
+			priv->add_ba_param.tx_win_size =
+				NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE;
+
+		if (adapter->coex_win_size) {
+			if (adapter->coex_tx_win_size)
+				priv->add_ba_param.tx_win_size =
+					adapter->coex_tx_win_size;
+		}
+
+		if (tx_win_size != priv->add_ba_param.tx_win_size) {
+			if (!priv->media_connected)
+				continue;
+			for (j = 0; j < MAX_NUM_TID; j++)
+				nxpwifi_send_delba_txbastream_tbl(priv, j);
+		}
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n.h b/drivers/net/wireless/nxp/nxpwifi/11n.h
new file mode 100644
index 000000000000..627d8dff38dc
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_H_
+#define _NXPWIFI_11N_H_
+
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+#include "wmm.h"
+
+int nxpwifi_ret_11n_delba(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp);
+int nxpwifi_ret_11n_addba_req(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp);
+int nxpwifi_cmd_11n_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_ds_11n_tx_cfg *txcfg);
+int nxpwifi_cmd_append_11n_tlv(struct nxpwifi_private *priv,
+			       struct nxpwifi_bssdescriptor *bss_desc,
+			       u8 **buffer);
+int nxpwifi_fill_cap_info(struct nxpwifi_private *priv, u8 radio_type,
+			  struct ieee80211_ht_cap *ht_cap);
+int nxpwifi_set_get_11n_htcap_cfg(struct nxpwifi_private *priv,
+				  u16 action, int *htcap_cfg);
+void nxpwifi_11n_delete_tx_ba_stream_tbl_entry(struct nxpwifi_private *priv,
+					       struct nxpwifi_tx_ba_stream_tbl
+					       *tx_tbl);
+void nxpwifi_11n_delete_all_tx_ba_stream_tbl(struct nxpwifi_private *priv);
+struct nxpwifi_tx_ba_stream_tbl *nxpwifi_get_ba_tbl(struct nxpwifi_private
+						    *priv, int tid, u8 *ra);
+void nxpwifi_create_ba_tbl(struct nxpwifi_private *priv, u8 *ra, int tid,
+			   enum nxpwifi_ba_status ba_status);
+int nxpwifi_send_addba(struct nxpwifi_private *priv, int tid, u8 *peer_mac);
+int nxpwifi_send_delba(struct nxpwifi_private *priv, int tid, u8 *peer_mac,
+		       int initiator);
+void nxpwifi_11n_delete_ba_stream(struct nxpwifi_private *priv, u8 *del_ba);
+int nxpwifi_get_rx_reorder_tbl(struct nxpwifi_private *priv,
+			       struct nxpwifi_ds_rx_reorder_tbl *buf);
+int nxpwifi_get_tx_ba_stream_tbl(struct nxpwifi_private *priv,
+				 struct nxpwifi_ds_tx_ba_stream_tbl *buf);
+int nxpwifi_cmd_recfg_tx_buf(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd,
+			     int cmd_action, u16 *buf_size);
+int nxpwifi_cmd_amsdu_aggr_ctrl(struct host_cmd_ds_command *cmd,
+				int cmd_action,
+				struct nxpwifi_ds_11n_amsdu_aggr_ctrl *aa_ctrl);
+void nxpwifi_del_tx_ba_stream_tbl_by_ra(struct nxpwifi_private *priv, u8 *ra);
+u8 nxpwifi_get_sec_chan_offset(int chan);
+
+static inline u8
+nxpwifi_is_station_ampdu_allowed(struct nxpwifi_private *priv,
+				 struct nxpwifi_ra_list_tbl *ptr, int tid)
+{
+	struct nxpwifi_sta_node *node = nxpwifi_get_sta_entry(priv, ptr->ra);
+
+	if (unlikely(!node))
+		return false;
+
+	return (node->ampdu_sta[tid] != BA_STREAM_NOT_ALLOWED) ? true : false;
+}
+
+/* This function checks whether AMPDU is allowed or not for a particular TID. */
+static inline u8
+nxpwifi_is_ampdu_allowed(struct nxpwifi_private *priv,
+			 struct nxpwifi_ra_list_tbl *ptr, int tid)
+{
+	u8 ret;
+
+	if (is_broadcast_ether_addr(ptr->ra))
+		return false;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP)
+		ret = nxpwifi_is_station_ampdu_allowed(priv, ptr, tid);
+	else
+		ret = (priv->aggr_prio_tbl[tid].ampdu_ap !=
+		       BA_STREAM_NOT_ALLOWED) ? true : false;
+
+	return ret;
+}
+
+/* This function checks whether AMSDU is allowed or not for a particular TID.
+ */
+static inline u8
+nxpwifi_is_amsdu_allowed(struct nxpwifi_private *priv, int tid)
+{
+	return (((priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED) &&
+		 (priv->is_data_rate_auto || !(priv->bitmap_rates[2] & 0x03)))
+		? true : false);
+}
+
+/* This function checks whether a space is available for new BA stream or not.
+ */
+static inline u8
+nxpwifi_space_avail_for_new_ba_stream(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	u8 i;
+	size_t ba_stream_num = 0, ba_stream_max;
+
+	ba_stream_max = NXPWIFI_MAX_TX_BASTREAM_SUPPORTED;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		ba_stream_num += list_count_nodes(&priv->tx_ba_stream_tbl_ptr);
+	}
+
+	if (adapter->fw_api_ver == NXPWIFI_FW_V15) {
+		ba_stream_max =
+			GETSUPP_TXBASTREAMS(adapter->hw_dot_11n_dev_cap);
+		if (!ba_stream_max)
+			ba_stream_max = NXPWIFI_MAX_TX_BASTREAM_SUPPORTED;
+	}
+
+	return ((ba_stream_num < ba_stream_max) ? true : false);
+}
+
+/* This function finds the correct Tx BA stream to delete.
+ *
+ * Upon successfully locating, both the TID and the RA are returned.
+ */
+static inline u8
+nxpwifi_find_stream_to_delete(struct nxpwifi_private *priv, int ptr_tid,
+			      int *ptid, u8 *ra)
+{
+	int tid;
+	u8 ret = false;
+	struct nxpwifi_tx_ba_stream_tbl *tx_tbl;
+
+	tid = priv->aggr_prio_tbl[ptr_tid].ampdu_user;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry(tx_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		if (tid > priv->aggr_prio_tbl[tx_tbl->tid].ampdu_user) {
+			tid = priv->aggr_prio_tbl[tx_tbl->tid].ampdu_user;
+			*ptid = tx_tbl->tid;
+			memcpy(ra, tx_tbl->ra, ETH_ALEN);
+			ret = true;
+		}
+	}
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+
+	return ret;
+}
+
+/* This function checks whether associated station is 11n enabled
+ */
+static inline int nxpwifi_is_sta_11n_enabled(struct nxpwifi_private *priv,
+					     struct nxpwifi_sta_node *node)
+{
+	if (!node || (priv->bss_role == NXPWIFI_BSS_ROLE_UAP &&
+		      !priv->ap_11n_enabled))
+		return 0;
+
+	return node->is_11n_enabled;
+}
+
+#endif /* !_NXPWIFI_11N_H_ */
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
new file mode 100644
index 000000000000..06698c0af56b
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11n Aggregation
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n.h"
+#include "11n_aggr.h"
+
+/* Creates an AMSDU subframe for aggregation into one AMSDU packet.
+ *
+ * The resultant AMSDU subframe format is -
+ *
+ * +---- ~ -----+---- ~ ------+---- ~ -----+----- ~ -----+---- ~ -----+
+ * |     DA     |     SA      |   Length   | SNAP header |   MSDU     |
+ * | data[0..5] | data[6..11] |            |             | data[14..] |
+ * +---- ~ -----+---- ~ ------+---- ~ -----+----- ~ -----+---- ~ -----+
+ * <--6-bytes--> <--6-bytes--> <--2-bytes--><--8-bytes--> <--n-bytes-->
+ *
+ * This function also computes the amount of padding required to make the
+ * buffer length multiple of 4 bytes.
+ *
+ * Data => |DA|SA|SNAP-TYPE|........    .|
+ * MSDU => |DA|SA|Length|SNAP|......   ..|
+ */
+static int
+nxpwifi_11n_form_amsdu_pkt(struct sk_buff *skb_aggr,
+			   struct sk_buff *skb_src, int *pad)
+
+{
+	int dt_offset;
+	struct rfc_1042_hdr snap = {
+		0xaa,		/* LLC DSAP */
+		0xaa,		/* LLC SSAP */
+		0x03,		/* LLC CTRL */
+		{0x00, 0x00, 0x00},	/* SNAP OUI */
+		0x0000		/* SNAP type */
+			/* This field will be overwritten
+			 * later with ethertype
+			 */
+	};
+	struct tx_packet_hdr *tx_header;
+
+	tx_header = skb_put(skb_aggr, sizeof(*tx_header));
+
+	/* Copy DA and SA */
+	dt_offset = 2 * ETH_ALEN;
+	memcpy(&tx_header->eth803_hdr, skb_src->data, dt_offset);
+
+	/* Copy SNAP header */
+	snap.snap_type = ((struct ethhdr *)skb_src->data)->h_proto;
+
+	dt_offset += sizeof(__be16);
+
+	memcpy(&tx_header->rfc1042_hdr, &snap, sizeof(struct rfc_1042_hdr));
+
+	skb_pull(skb_src, dt_offset);
+
+	/* Update Length field */
+	tx_header->eth803_hdr.h_proto = htons(skb_src->len + LLC_SNAP_LEN);
+
+	/* Add payload */
+	skb_put_data(skb_aggr, skb_src->data, skb_src->len);
+
+	/* Add padding for new MSDU to start from 4 byte boundary */
+	*pad = (4 - ((unsigned long)skb_aggr->tail & 0x3)) % 4;
+
+	return skb_aggr->len + *pad;
+}
+
+/* Adds TxPD to AMSDU header.
+ *
+ * Each AMSDU packet will contain one TxPD at the beginning,
+ * followed by multiple AMSDU subframes.
+ */
+static void
+nxpwifi_11n_form_amsdu_txpd(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct txpd *local_tx_pd;
+
+	skb_push(skb, sizeof(*local_tx_pd));
+
+	local_tx_pd = (struct txpd *)skb->data;
+	memset(local_tx_pd, 0, sizeof(struct txpd));
+
+	/* Original priority has been overwritten */
+	local_tx_pd->priority = (u8)skb->priority;
+	local_tx_pd->pkt_delay_2ms =
+		nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+	/* Always zero as the data is followed by struct txpd */
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(sizeof(struct txpd));
+	local_tx_pd->tx_pkt_type = cpu_to_le16(PKT_TYPE_AMSDU);
+	local_tx_pd->tx_pkt_length = cpu_to_le16(skb->len -
+						 sizeof(*local_tx_pd));
+
+	if (local_tx_pd->tx_control == 0)
+		/* TxCtrl set by user or default */
+		local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA &&
+	    priv->adapter->pps_uapsd_mode) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			priv->adapter->tx_lock_flag = true;
+			local_tx_pd->flags =
+				NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET;
+		}
+	}
+}
+
+/* Create aggregated packet.
+ *
+ * This function creates an aggregated MSDU packet, by combining buffers
+ * from the RA list. Each individual buffer is encapsulated as an AMSDU
+ * subframe and all such subframes are concatenated together to form the
+ * AMSDU packet.
+ *
+ * A TxPD is also added to the front of the resultant AMSDU packets for
+ * transmission. The resultant packets format is -
+ *
+ * +---- ~ ----+------ ~ ------+------ ~ ------+-..-+------ ~ ------+
+ * |    TxPD   |AMSDU sub-frame|AMSDU sub-frame| .. |AMSDU sub-frame|
+ * |           |       1       |       2       | .. |       n       |
+ * +---- ~ ----+------ ~ ------+------ ~ ------+ .. +------ ~ ------+
+ */
+int
+nxpwifi_11n_aggregate_pkt(struct nxpwifi_private *priv,
+			  struct nxpwifi_ra_list_tbl *pra_list,
+			  int ptrindex)
+			  __releases(&priv->wmm.ra_list_spinlock)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct sk_buff *skb_aggr, *skb_src;
+	struct nxpwifi_txinfo *tx_info_aggr, *tx_info_src;
+	int pad = 0, aggr_num = 0, ret;
+	struct nxpwifi_tx_param tx_param;
+	struct txpd *ptx_pd = NULL;
+	int headroom = adapter->intf_hdr_len;
+
+	skb_src = skb_peek(&pra_list->skb_head);
+	if (!skb_src) {
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		return 0;
+	}
+
+	tx_info_src = NXPWIFI_SKB_TXCB(skb_src);
+	skb_aggr = nxpwifi_alloc_dma_align_buf(adapter->tx_buf_size,
+					       GFP_ATOMIC);
+	if (!skb_aggr) {
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		return -ENOMEM;
+	}
+
+	/* skb_aggr->data already 64 byte align, just reserve bus interface
+	 * header and txpd.
+	 */
+	skb_reserve(skb_aggr, headroom + sizeof(struct txpd));
+	tx_info_aggr =  NXPWIFI_SKB_TXCB(skb_aggr);
+
+	memset(tx_info_aggr, 0, sizeof(*tx_info_aggr));
+	tx_info_aggr->bss_type = tx_info_src->bss_type;
+	tx_info_aggr->bss_num = tx_info_src->bss_num;
+
+	tx_info_aggr->flags |= NXPWIFI_BUF_FLAG_AGGR_PKT;
+	skb_aggr->priority = skb_src->priority;
+	skb_aggr->tstamp = skb_src->tstamp;
+
+	do {
+		/* Check if AMSDU can accommodate this MSDU */
+		if ((skb_aggr->len + skb_src->len + LLC_SNAP_LEN) >
+		    adapter->tx_buf_size)
+			break;
+
+		skb_src = skb_dequeue(&pra_list->skb_head);
+		pra_list->total_pkt_count--;
+		atomic_dec(&priv->wmm.tx_pkts_queued);
+		aggr_num++;
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		nxpwifi_11n_form_amsdu_pkt(skb_aggr, skb_src, &pad);
+
+		nxpwifi_write_data_complete(adapter, skb_src, 0, 0);
+
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+		if (!nxpwifi_is_ralist_valid(priv, pra_list, ptrindex)) {
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+			return -ENOENT;
+		}
+
+		if (skb_tailroom(skb_aggr) < pad) {
+			pad = 0;
+			break;
+		}
+		skb_put(skb_aggr, pad);
+
+		skb_src = skb_peek(&pra_list->skb_head);
+
+	} while (skb_src);
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+
+	/* Last AMSDU packet does not need padding */
+	skb_trim(skb_aggr, skb_aggr->len - pad);
+
+	/* Form AMSDU */
+	nxpwifi_11n_form_amsdu_txpd(priv, skb_aggr);
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		ptx_pd = (struct txpd *)skb_aggr->data;
+
+	skb_push(skb_aggr, headroom);
+	tx_info_aggr->aggr_num = aggr_num * 2;
+	if (adapter->data_sent || adapter->tx_lock_flag) {
+		atomic_add(aggr_num * 2, &adapter->tx_queued);
+		skb_queue_tail(&adapter->tx_data_q, skb_aggr);
+		return 0;
+	}
+
+	if (skb_src)
+		tx_param.next_pkt_len = skb_src->len + sizeof(struct txpd);
+	else
+		tx_param.next_pkt_len = 0;
+
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_DATA,
+					   skb_aggr, &tx_param);
+
+	switch (ret) {
+	case -EBUSY:
+		spin_lock_bh(&priv->wmm.ra_list_spinlock);
+		if (!nxpwifi_is_ralist_valid(priv, pra_list, ptrindex)) {
+			spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+			nxpwifi_write_data_complete(adapter, skb_aggr, 1, -1);
+			return -EINVAL;
+		}
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA &&
+		    adapter->pps_uapsd_mode && adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (ptx_pd)
+				ptx_pd->flags = 0;
+		}
+
+		skb_queue_tail(&pra_list->skb_head, skb_aggr);
+
+		pra_list->total_pkt_count++;
+
+		atomic_inc(&priv->wmm.tx_pkts_queued);
+
+		tx_info_aggr->flags |= NXPWIFI_BUF_FLAG_REQUEUED_PKT;
+		spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb_aggr, 1, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR, "%s: host_to_card failed: %#x\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb_aggr, 1, ret);
+		break;
+	}
+	if (ret != -EBUSY)
+		nxpwifi_rotate_priolists(priv, pra_list, ptrindex);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
new file mode 100644
index 000000000000..be9f0f8f4e48
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n Aggregation
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_AGGR_H_
+#define _NXPWIFI_11N_AGGR_H_
+
+#define PKT_TYPE_AMSDU	0xE6
+#define MIN_NUM_AMSDU 2
+
+int nxpwifi_11n_deaggregate_pkt(struct nxpwifi_private *priv,
+				struct sk_buff *skb);
+int nxpwifi_11n_aggregate_pkt(struct nxpwifi_private *priv,
+			      struct nxpwifi_ra_list_tbl *ptr,
+			      int ptr_index)
+			      __releases(&priv->wmm.ra_list_spinlock);
+
+#endif /* !_NXPWIFI_11N_AGGR_H_ */
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
new file mode 100644
index 000000000000..cb037d577528
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
@@ -0,0 +1,910 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11n RX Re-ordering
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
+#include "11n_rxreorder.h"
+
+/* This function will dispatch amsdu packet and forward it to kernel/upper
+ * layer.
+ */
+static int nxpwifi_11n_dispatch_amsdu_pkt(struct nxpwifi_private *priv,
+					  struct sk_buff *skb)
+{
+	struct rxpd *local_rx_pd = (struct rxpd *)(skb->data);
+	int ret;
+
+	if (le16_to_cpu(local_rx_pd->rx_pkt_type) == PKT_TYPE_AMSDU) {
+		struct sk_buff_head list;
+		struct sk_buff *rx_skb;
+
+		__skb_queue_head_init(&list);
+
+		skb_pull(skb, le16_to_cpu(local_rx_pd->rx_pkt_offset));
+		skb_trim(skb, le16_to_cpu(local_rx_pd->rx_pkt_length));
+
+		ieee80211_amsdu_to_8023s(skb, &list, priv->curr_addr,
+					 priv->wdev.iftype, 0, NULL, NULL, false);
+
+		while (!skb_queue_empty(&list)) {
+			rx_skb = __skb_dequeue(&list);
+
+			if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+				ret = nxpwifi_uap_recv_packet(priv, rx_skb);
+			else
+				ret = nxpwifi_recv_packet(priv, rx_skb);
+			if (ret)
+				nxpwifi_dbg(priv->adapter, ERROR,
+					    "Rx of A-MSDU failed");
+		}
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/* This function will process the rx packet and forward it to kernel/upper
+ * layer.
+ */
+static int nxpwifi_11n_dispatch_pkt(struct nxpwifi_private *priv,
+				    struct sk_buff *payload)
+{
+	int ret;
+
+	if (!payload) {
+		nxpwifi_dbg(priv->adapter, INFO, "info: fw drop data\n");
+		return 0;
+	}
+
+	ret = nxpwifi_11n_dispatch_amsdu_pkt(priv, payload);
+	if (!ret)
+		return 0;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+		return nxpwifi_handle_uap_rx_forward(priv, payload);
+
+	return nxpwifi_process_rx_packet(priv, payload);
+}
+
+/* This function dispatches all packets in the Rx reorder table until the
+ * start window.
+ *
+ * There could be holes in the buffer, which are skipped by the function.
+ * Since the buffer is linear, the function uses rotation to simulate
+ * circular buffer.
+ */
+static void
+nxpwifi_11n_dispatch_pkt_until_start_win(struct nxpwifi_private *priv,
+					 struct nxpwifi_rx_reorder_tbl *tbl,
+					 int start_win)
+{
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+	int pkt_to_send, i;
+
+	__skb_queue_head_init(&list);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+
+	pkt_to_send = (start_win > tbl->start_win) ?
+		      min((start_win - tbl->start_win), tbl->win_size) :
+		      tbl->win_size;
+
+	for (i = 0; i < pkt_to_send; ++i) {
+		if (tbl->rx_reorder_ptr[i]) {
+			skb = tbl->rx_reorder_ptr[i];
+			__skb_queue_tail(&list, skb);
+			tbl->rx_reorder_ptr[i] = NULL;
+		}
+	}
+
+	/* We don't have a circular buffer, hence use rotation to simulate
+	 * circular buffer
+	 */
+	for (i = 0; i < tbl->win_size - pkt_to_send; ++i) {
+		tbl->rx_reorder_ptr[i] = tbl->rx_reorder_ptr[pkt_to_send + i];
+		tbl->rx_reorder_ptr[pkt_to_send + i] = NULL;
+	}
+
+	tbl->start_win = start_win;
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+
+	while ((skb = __skb_dequeue(&list)))
+		nxpwifi_11n_dispatch_pkt(priv, skb);
+}
+
+/* This function dispatches all packets in the Rx reorder table until
+ * a hole is found.
+ *
+ * The start window is adjusted automatically when a hole is located.
+ * Since the buffer is linear, the function uses rotation to simulate
+ * circular buffer.
+ */
+static void
+nxpwifi_11n_scan_and_dispatch(struct nxpwifi_private *priv,
+			      struct nxpwifi_rx_reorder_tbl *tbl)
+{
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+	int i, j, xchg;
+
+	__skb_queue_head_init(&list);
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+
+	for (i = 0; i < tbl->win_size; ++i) {
+		if (!tbl->rx_reorder_ptr[i])
+			break;
+		skb = tbl->rx_reorder_ptr[i];
+		__skb_queue_tail(&list, skb);
+		tbl->rx_reorder_ptr[i] = NULL;
+	}
+
+	/* We don't have a circular buffer, hence use rotation to simulate
+	 * circular buffer
+	 */
+	if (i > 0) {
+		xchg = tbl->win_size - i;
+		for (j = 0; j < xchg; ++j) {
+			tbl->rx_reorder_ptr[j] = tbl->rx_reorder_ptr[i + j];
+			tbl->rx_reorder_ptr[i + j] = NULL;
+		}
+	}
+	tbl->start_win = (tbl->start_win + i) & (MAX_TID_VALUE - 1);
+
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+
+	while ((skb = __skb_dequeue(&list)))
+		nxpwifi_11n_dispatch_pkt(priv, skb);
+}
+
+/* This function deletes the Rx reorder table and frees the memory.
+ *
+ * The function stops the associated timer and dispatches all the
+ * pending packets in the Rx reorder table before deletion.
+ */
+static void
+nxpwifi_del_rx_reorder_entry(struct nxpwifi_private *priv,
+			     struct nxpwifi_rx_reorder_tbl *tbl)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int start_win;
+
+	if (!tbl)
+		return;
+
+	tasklet_disable(&adapter->rx_task);
+
+	start_win = (tbl->start_win + tbl->win_size) & (MAX_TID_VALUE - 1);
+	nxpwifi_11n_dispatch_pkt_until_start_win(priv, tbl, start_win);
+
+	del_timer_sync(&tbl->timer_context.timer);
+	tbl->timer_context.timer_is_set = false;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_del(&tbl->list);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+
+	kfree(tbl->rx_reorder_ptr);
+	kfree(tbl);
+
+	tasklet_enable(&adapter->rx_task);
+}
+
+/* This function returns the pointer to an entry in Rx reordering
+ * table which matches the given TA/TID pair.
+ */
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rx_reorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta)
+{
+	struct nxpwifi_rx_reorder_tbl *tbl;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_for_each_entry(tbl, &priv->rx_reorder_tbl_ptr, list) {
+		if (!memcmp(tbl->ta, ta, ETH_ALEN) && tbl->tid == tid) {
+			spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+			return tbl;
+		}
+	}
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+
+	return NULL;
+}
+
+/* This function retrieves the pointer to an entry in Rx reordering
+ * table which matches the given TA and deletes it.
+ */
+void nxpwifi_11n_del_rx_reorder_tbl_by_ta(struct nxpwifi_private *priv, u8 *ta)
+{
+	struct nxpwifi_rx_reorder_tbl *tbl, *tmp;
+
+	if (!ta)
+		return;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_for_each_entry_safe(tbl, tmp, &priv->rx_reorder_tbl_ptr, list) {
+		if (!memcmp(tbl->ta, ta, ETH_ALEN)) {
+			spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+			nxpwifi_del_rx_reorder_entry(priv, tbl);
+			spin_lock_bh(&priv->rx_reorder_tbl_lock);
+		}
+	}
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+}
+
+/* This function finds the last sequence number used in the packets
+ * buffered in Rx reordering table.
+ */
+static int
+nxpwifi_11n_find_last_seq_num(struct reorder_tmr_cnxt *ctx)
+{
+	struct nxpwifi_rx_reorder_tbl *rx_reorder_tbl_ptr = ctx->ptr;
+	struct nxpwifi_private *priv = ctx->priv;
+	int i;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	for (i = rx_reorder_tbl_ptr->win_size - 1; i >= 0; --i) {
+		if (rx_reorder_tbl_ptr->rx_reorder_ptr[i]) {
+			spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+			return i;
+		}
+	}
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+
+	return -EINVAL;
+}
+
+/* This function flushes all the packets in Rx reordering table.
+ *
+ * The function checks if any packets are currently buffered in the
+ * table or not. In case there are packets available, it dispatches
+ * them and then dumps the Rx reordering table.
+ */
+static void
+nxpwifi_flush_data(struct timer_list *t)
+{
+	struct reorder_tmr_cnxt *ctx =
+		from_timer(ctx, t, timer);
+	int start_win, seq_num;
+
+	ctx->timer_is_set = false;
+	seq_num = nxpwifi_11n_find_last_seq_num(ctx);
+
+	if (seq_num < 0)
+		return;
+
+	nxpwifi_dbg(ctx->priv->adapter, INFO, "info: flush data %d\n", seq_num);
+	start_win = (ctx->ptr->start_win + seq_num + 1) & (MAX_TID_VALUE - 1);
+	nxpwifi_11n_dispatch_pkt_until_start_win(ctx->priv, ctx->ptr,
+						 start_win);
+}
+
+/* This function creates an entry in Rx reordering table for the
+ * given TA/TID.
+ *
+ * The function also initializes the entry with sequence number, window
+ * size as well as initializes the timer.
+ *
+ * If the received TA/TID pair is already present, all the packets are
+ * dispatched and the window size is moved until the SSN.
+ */
+static void
+nxpwifi_11n_create_rx_reorder_tbl(struct nxpwifi_private *priv, u8 *ta,
+				  int tid, int win_size, int seq_num)
+{
+	int i;
+	struct nxpwifi_rx_reorder_tbl *tbl, *new_node;
+	u16 last_seq = 0;
+	struct nxpwifi_sta_node *node;
+
+	/* If we get a TID, ta pair which is already present dispatch all
+	 * the packets and move the window size until the ssn
+	 */
+	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, ta);
+	if (tbl) {
+		nxpwifi_11n_dispatch_pkt_until_start_win(priv, tbl, seq_num);
+		return;
+	}
+	/* if !tbl then create one */
+	new_node = kzalloc(sizeof(*new_node), GFP_KERNEL);
+	if (!new_node)
+		return;
+
+	INIT_LIST_HEAD(&new_node->list);
+	new_node->tid = tid;
+	memcpy(new_node->ta, ta, ETH_ALEN);
+	new_node->start_win = seq_num;
+	new_node->init_win = seq_num;
+	new_node->flags = 0;
+
+	spin_lock_bh(&priv->sta_list_spinlock);
+	if (nxpwifi_queuing_ra_based(priv)) {
+		if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP) {
+			node = nxpwifi_get_sta_entry(priv, ta);
+			if (node)
+				last_seq = node->rx_seq[tid];
+		}
+	} else {
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			last_seq = node->rx_seq[tid];
+		else
+			last_seq = priv->rx_seq[tid];
+	}
+	spin_unlock_bh(&priv->sta_list_spinlock);
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: last_seq=%d start_win=%d\n",
+		    last_seq, new_node->start_win);
+
+	if (last_seq != NXPWIFI_DEF_11N_RX_SEQ_NUM &&
+	    last_seq >= new_node->start_win) {
+		new_node->start_win = last_seq + 1;
+		new_node->flags |= RXREOR_INIT_WINDOW_SHIFT;
+	}
+
+	new_node->win_size = win_size;
+
+	new_node->rx_reorder_ptr = kcalloc(win_size, sizeof(void *),
+					   GFP_KERNEL);
+	if (!new_node->rx_reorder_ptr) {
+		kfree(new_node);
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: failed to alloc reorder_ptr\n", __func__);
+		return;
+	}
+
+	new_node->timer_context.ptr = new_node;
+	new_node->timer_context.priv = priv;
+	new_node->timer_context.timer_is_set = false;
+
+	timer_setup(&new_node->timer_context.timer, nxpwifi_flush_data, 0);
+
+	for (i = 0; i < win_size; ++i)
+		new_node->rx_reorder_ptr[i] = NULL;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_add_tail(&new_node->list, &priv->rx_reorder_tbl_ptr);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+}
+
+static void
+nxpwifi_11n_rxreorder_timer_restart(struct nxpwifi_rx_reorder_tbl *tbl)
+{
+	u32 min_flush_time;
+
+	if (tbl->win_size >= NXPWIFI_BA_WIN_SIZE_32)
+		min_flush_time = MIN_FLUSH_TIMER_15_MS;
+	else
+		min_flush_time = MIN_FLUSH_TIMER_MS;
+
+	mod_timer(&tbl->timer_context.timer,
+		  jiffies + msecs_to_jiffies(min_flush_time * tbl->win_size));
+
+	tbl->timer_context.timer_is_set = true;
+}
+
+/* This function prepares command for adding a BA request.
+ *
+ * Preparation includes -
+ *      - Setting command ID and proper size
+ *      - Setting add BA request buffer
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_11n_addba_req(struct host_cmd_ds_command *cmd, void *data_buf)
+{
+	struct host_cmd_ds_11n_addba_req *add_ba_req = &cmd->params.add_ba_req;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_ADDBA_REQ);
+	cmd->size = cpu_to_le16(sizeof(*add_ba_req) + S_DS_GEN);
+	memcpy(add_ba_req, data_buf, sizeof(*add_ba_req));
+
+	return 0;
+}
+
+/* This function prepares command for adding a BA response.
+ *
+ * Preparation includes -
+ *      - Setting command ID and proper size
+ *      - Setting add BA response buffer
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_11n_addba_rsp_gen(struct nxpwifi_private *priv,
+				  struct host_cmd_ds_command *cmd,
+				  struct host_cmd_ds_11n_addba_req
+				  *cmd_addba_req)
+{
+	struct host_cmd_ds_11n_addba_rsp *add_ba_rsp = &cmd->params.add_ba_rsp;
+	u32 rx_win_size = priv->add_ba_param.rx_win_size;
+	u8 tid;
+	int win_size;
+	u16 block_ack_param_set;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_ADDBA_RSP);
+	cmd->size = cpu_to_le16(sizeof(*add_ba_rsp) + S_DS_GEN);
+
+	memcpy(add_ba_rsp->peer_mac_addr, cmd_addba_req->peer_mac_addr,
+	       ETH_ALEN);
+	add_ba_rsp->dialog_token = cmd_addba_req->dialog_token;
+	add_ba_rsp->block_ack_tmo = cmd_addba_req->block_ack_tmo;
+	add_ba_rsp->ssn = cmd_addba_req->ssn;
+
+	block_ack_param_set = le16_to_cpu(cmd_addba_req->block_ack_param_set);
+	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
+		>> BLOCKACKPARAM_TID_POS;
+	add_ba_rsp->status_code = cpu_to_le16(ADDBA_RSP_STATUS_ACCEPT);
+	block_ack_param_set &= ~IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK;
+
+	/* If we don't support AMSDU inside AMPDU, reset the bit */
+	if (!priv->add_ba_param.rx_amsdu ||
+	    priv->aggr_prio_tbl[tid].amsdu == BA_STREAM_NOT_ALLOWED)
+		block_ack_param_set &= ~BLOCKACKPARAM_AMSDU_SUPP_MASK;
+	block_ack_param_set |= rx_win_size << BLOCKACKPARAM_WINSIZE_POS;
+	add_ba_rsp->block_ack_param_set = cpu_to_le16(block_ack_param_set);
+	win_size = (le16_to_cpu(add_ba_rsp->block_ack_param_set)
+		    & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK)
+		   >> BLOCKACKPARAM_WINSIZE_POS;
+	cmd_addba_req->block_ack_param_set = cpu_to_le16(block_ack_param_set);
+
+	nxpwifi_11n_create_rx_reorder_tbl(priv, cmd_addba_req->peer_mac_addr,
+					  tid, win_size,
+					  le16_to_cpu(cmd_addba_req->ssn));
+	return 0;
+}
+
+/* This function prepares command for deleting a BA request.
+ *
+ * Preparation includes -
+ *      - Setting command ID and proper size
+ *      - Setting del BA request buffer
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_11n_delba(struct host_cmd_ds_command *cmd, void *data_buf)
+{
+	struct host_cmd_ds_11n_delba *del_ba = &cmd->params.del_ba;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11N_DELBA);
+	cmd->size = cpu_to_le16(sizeof(*del_ba) + S_DS_GEN);
+	memcpy(del_ba, data_buf, sizeof(*del_ba));
+
+	return 0;
+}
+
+/* This function identifies if Rx reordering is needed for a received packet.
+ *
+ * In case reordering is required, the function will do the reordering
+ * before sending it to kernel.
+ *
+ * The Rx reorder table is checked first with the received TID/TA pair. If
+ * not found, the received packet is dispatched immediately. But if found,
+ * the packet is reordered and all the packets in the updated Rx reordering
+ * table is dispatched until a hole is found.
+ *
+ * For sequence number less than the starting window, the packet is dropped.
+ */
+int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *priv,
+			       u16 seq_num, u16 tid,
+			       u8 *ta, u8 pkt_type, void *payload)
+{
+	struct nxpwifi_rx_reorder_tbl *tbl;
+	int prev_start_win, start_win, end_win, win_size;
+	u16 pkt_index;
+	bool init_window_shift = false;
+	int ret = 0;
+
+	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, ta);
+	if (!tbl) {
+		if (pkt_type != PKT_TYPE_BAR)
+			nxpwifi_11n_dispatch_pkt(priv, payload);
+		return ret;
+	}
+
+	if (pkt_type == PKT_TYPE_AMSDU && !tbl->amsdu) {
+		nxpwifi_11n_dispatch_pkt(priv, payload);
+		return ret;
+	}
+
+	start_win = tbl->start_win;
+	prev_start_win = start_win;
+	win_size = tbl->win_size;
+	end_win = ((start_win + win_size) - 1) & (MAX_TID_VALUE - 1);
+	if (tbl->flags & RXREOR_INIT_WINDOW_SHIFT) {
+		init_window_shift = true;
+		tbl->flags &= ~RXREOR_INIT_WINDOW_SHIFT;
+	}
+
+	if (tbl->flags & RXREOR_FORCE_NO_DROP) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "RXREOR_FORCE_NO_DROP when HS is activated\n");
+		tbl->flags &= ~RXREOR_FORCE_NO_DROP;
+	} else if (init_window_shift && seq_num < start_win &&
+		   seq_num >= tbl->init_win) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "Sender TID sequence number reset %d->%d for SSN %d\n",
+			    start_win, seq_num, tbl->init_win);
+		start_win = seq_num;
+		tbl->start_win = start_win;
+		end_win = ((start_win + win_size) - 1) & (MAX_TID_VALUE - 1);
+	} else {
+		/* If seq_num is less then starting win then ignore and drop
+		 * the packet
+		 */
+		if ((start_win + TWOPOW11) > (MAX_TID_VALUE - 1)) {
+			if (seq_num >= ((start_win + TWOPOW11) &
+					(MAX_TID_VALUE - 1)) &&
+			    seq_num < start_win) {
+				ret = -EINVAL;
+				goto done;
+			}
+		} else if ((seq_num < start_win) ||
+			   (seq_num >= (start_win + TWOPOW11))) {
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+	/* If this packet is a BAR we adjust seq_num as
+	 * WinStart = seq_num
+	 */
+	if (pkt_type == PKT_TYPE_BAR)
+		seq_num = ((seq_num + win_size) - 1) & (MAX_TID_VALUE - 1);
+
+	if ((end_win < start_win &&
+	     seq_num < start_win && seq_num > end_win) ||
+	    (end_win > start_win && (seq_num > end_win ||
+				     seq_num < start_win))) {
+		end_win = seq_num;
+		if (((end_win - win_size) + 1) >= 0)
+			start_win = (end_win - win_size) + 1;
+		else
+			start_win = (MAX_TID_VALUE - (win_size - end_win)) + 1;
+		nxpwifi_11n_dispatch_pkt_until_start_win(priv, tbl, start_win);
+	}
+
+	if (pkt_type != PKT_TYPE_BAR) {
+		if (seq_num >= start_win)
+			pkt_index = seq_num - start_win;
+		else
+			pkt_index = (seq_num + MAX_TID_VALUE) - start_win;
+
+		if (tbl->rx_reorder_ptr[pkt_index]) {
+			ret = -EINVAL;
+			goto done;
+		}
+
+		tbl->rx_reorder_ptr[pkt_index] = payload;
+	}
+
+	/* Dispatch all packets sequentially from start_win until a
+	 * hole is found and adjust the start_win appropriately
+	 */
+	nxpwifi_11n_scan_and_dispatch(priv, tbl);
+
+done:
+	if (!tbl->timer_context.timer_is_set ||
+	    prev_start_win != tbl->start_win)
+		nxpwifi_11n_rxreorder_timer_restart(tbl);
+	return ret;
+}
+
+/* This function deletes an entry for a given TID/TA pair.
+ *
+ * The TID/TA are taken from del BA event body.
+ */
+void
+nxpwifi_del_ba_tbl(struct nxpwifi_private *priv, int tid, u8 *peer_mac,
+		   u8 type, int initiator)
+{
+	struct nxpwifi_rx_reorder_tbl *tbl;
+	struct nxpwifi_tx_ba_stream_tbl *ptx_tbl;
+	struct nxpwifi_ra_list_tbl *ra_list;
+	u8 cleanup_rx_reorder_tbl;
+	int tid_down;
+
+	if (type == TYPE_DELBA_RECEIVE)
+		cleanup_rx_reorder_tbl = (initiator) ? true : false;
+	else
+		cleanup_rx_reorder_tbl = (initiator) ? false : true;
+
+	nxpwifi_dbg(priv->adapter, EVENT, "event: DELBA: %pM tid=%d initiator=%d\n",
+		    peer_mac, tid, initiator);
+
+	if (cleanup_rx_reorder_tbl) {
+		tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid, peer_mac);
+		if (!tbl) {
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "event: TID, TA not found in table\n");
+			return;
+		}
+		nxpwifi_del_rx_reorder_entry(priv, tbl);
+	} else {
+		ptx_tbl = nxpwifi_get_ba_tbl(priv, tid, peer_mac);
+		if (!ptx_tbl) {
+			nxpwifi_dbg(priv->adapter, EVENT,
+				    "event: TID, RA not found in table\n");
+			return;
+		}
+
+		tid_down = nxpwifi_wmm_downgrade_tid(priv, tid);
+		ra_list = nxpwifi_wmm_get_ralist_node(priv, tid_down, peer_mac);
+		if (ra_list) {
+			ra_list->amsdu_in_ampdu = false;
+			ra_list->ba_status = BA_SETUP_NONE;
+		}
+		spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+		nxpwifi_11n_delete_tx_ba_stream_tbl_entry(priv, ptx_tbl);
+		spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+	}
+}
+
+/* This function handles the command response of an add BA response.
+ *
+ * Handling includes changing the header fields into CPU format and
+ * creating the stream, provided the add BA is accepted.
+ */
+int nxpwifi_ret_11n_addba_resp(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command *resp)
+{
+	struct host_cmd_ds_11n_addba_rsp *add_ba_rsp = &resp->params.add_ba_rsp;
+	int tid, win_size;
+	struct nxpwifi_rx_reorder_tbl *tbl;
+	u16 block_ack_param_set;
+
+	block_ack_param_set = le16_to_cpu(add_ba_rsp->block_ack_param_set);
+
+	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
+		>> BLOCKACKPARAM_TID_POS;
+	/* Check if we had rejected the ADDBA, if yes then do not create
+	 * the stream
+	 */
+	if (le16_to_cpu(add_ba_rsp->status_code) != BA_RESULT_SUCCESS) {
+		nxpwifi_dbg(priv->adapter, ERROR, "ADDBA RSP: failed %pM tid=%d)\n",
+			    add_ba_rsp->peer_mac_addr, tid);
+
+		tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid,
+						     add_ba_rsp->peer_mac_addr);
+		if (tbl)
+			nxpwifi_del_rx_reorder_entry(priv, tbl);
+
+		return 0;
+	}
+
+	win_size = (block_ack_param_set & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK)
+		    >> BLOCKACKPARAM_WINSIZE_POS;
+
+	tbl = nxpwifi_11n_get_rx_reorder_tbl(priv, tid,
+					     add_ba_rsp->peer_mac_addr);
+	if (tbl) {
+		if ((block_ack_param_set & BLOCKACKPARAM_AMSDU_SUPP_MASK) &&
+		    priv->add_ba_param.rx_amsdu &&
+		    priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED)
+			tbl->amsdu = true;
+		else
+			tbl->amsdu = false;
+	}
+
+	nxpwifi_dbg(priv->adapter, CMD,
+		    "cmd: ADDBA RSP: %pM tid=%d ssn=%d win_size=%d\n",
+		    add_ba_rsp->peer_mac_addr, tid, add_ba_rsp->ssn, win_size);
+
+	return 0;
+}
+
+/* This function handles BA stream timeout event by preparing and sending
+ * a command to the firmware.
+ */
+void nxpwifi_11n_ba_stream_timeout(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_11n_batimeout *event)
+{
+	struct host_cmd_ds_11n_delba delba;
+
+	memset(&delba, 0, sizeof(struct host_cmd_ds_11n_delba));
+	memcpy(delba.peer_mac_addr, event->peer_mac_addr, ETH_ALEN);
+
+	delba.del_ba_param_set |=
+		cpu_to_le16((u16)event->tid << DELBA_TID_POS);
+	delba.del_ba_param_set |=
+		cpu_to_le16((u16)event->origninator << DELBA_INITIATOR_POS);
+	delba.reason_code = cpu_to_le16(WLAN_REASON_QSTA_TIMEOUT);
+	nxpwifi_send_cmd(priv, HOST_CMD_11N_DELBA, 0, 0, &delba, false);
+}
+
+/* This function cleans up the Rx reorder table by deleting all the entries
+ * and re-initializing.
+ */
+void nxpwifi_11n_cleanup_reorder_tbl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_rx_reorder_tbl *del_tbl_ptr, *tmp_node;
+
+	spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	list_for_each_entry_safe(del_tbl_ptr, tmp_node,
+				 &priv->rx_reorder_tbl_ptr, list) {
+		spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+		nxpwifi_del_rx_reorder_entry(priv, del_tbl_ptr);
+		spin_lock_bh(&priv->rx_reorder_tbl_lock);
+	}
+	INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr);
+	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+
+	nxpwifi_reset_11n_rx_seq_num(priv);
+}
+
+/* This function updates all rx_reorder_tbl's flags.
+ */
+void nxpwifi_update_rxreor_flags(struct nxpwifi_adapter *adapter, u8 flags)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_rx_reorder_tbl *tbl;
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		spin_lock_bh(&priv->rx_reorder_tbl_lock);
+		list_for_each_entry(tbl, &priv->rx_reorder_tbl_ptr, list)
+			tbl->flags = flags;
+		spin_unlock_bh(&priv->rx_reorder_tbl_lock);
+	}
+}
+
+/* This function update all the rx_win_size based on coex flag
+ */
+static void nxpwifi_update_ampdu_rxwinsize(struct nxpwifi_adapter *adapter,
+					   bool coex_flag)
+{
+	u8 i;
+	u32 rx_win_size;
+	struct nxpwifi_private *priv;
+
+	dev_dbg(adapter->dev, "Update rxwinsize %d\n", coex_flag);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		rx_win_size = priv->add_ba_param.rx_win_size;
+		if (coex_flag) {
+			if (priv->bss_type == NXPWIFI_BSS_TYPE_STA)
+				priv->add_ba_param.rx_win_size =
+					NXPWIFI_STA_COEX_AMPDU_DEF_RXWINSIZE;
+			if (priv->bss_type == NXPWIFI_BSS_TYPE_UAP)
+				priv->add_ba_param.rx_win_size =
+					NXPWIFI_UAP_COEX_AMPDU_DEF_RXWINSIZE;
+		} else {
+			if (priv->bss_type == NXPWIFI_BSS_TYPE_STA)
+				priv->add_ba_param.rx_win_size =
+					NXPWIFI_STA_AMPDU_DEF_RXWINSIZE;
+			if (priv->bss_type == NXPWIFI_BSS_TYPE_UAP)
+				priv->add_ba_param.rx_win_size =
+					NXPWIFI_UAP_AMPDU_DEF_RXWINSIZE;
+		}
+
+		if (adapter->coex_win_size && adapter->coex_rx_win_size)
+			priv->add_ba_param.rx_win_size =
+				adapter->coex_rx_win_size;
+
+		if (rx_win_size != priv->add_ba_param.rx_win_size) {
+			if (!priv->media_connected)
+				continue;
+			for (i = 0; i < MAX_NUM_TID; i++)
+				nxpwifi_11n_delba(priv, i);
+		}
+	}
+}
+
+/* This function check coex for RX BA
+ */
+void nxpwifi_coex_ampdu_rxwinsize(struct nxpwifi_adapter *adapter)
+{
+	u8 i;
+	struct nxpwifi_private *priv;
+	u8 count = 0;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) {
+			if (priv->media_connected)
+				count++;
+		}
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+			if (priv->bss_started)
+				count++;
+		}
+		if (count >= NXPWIFI_BSS_COEX_COUNT)
+			break;
+	}
+	if (count >= NXPWIFI_BSS_COEX_COUNT)
+		nxpwifi_update_ampdu_rxwinsize(adapter, true);
+	else
+		nxpwifi_update_ampdu_rxwinsize(adapter, false);
+}
+
+/* This function handles rxba_sync event
+ */
+void nxpwifi_11n_rxba_sync_event(struct nxpwifi_private *priv,
+				 u8 *event_buf, u16 len)
+{
+	struct nxpwifi_ie_types_rxba_sync *tlv_rxba = (void *)event_buf;
+	u16 tlv_type, tlv_len;
+	struct nxpwifi_rx_reorder_tbl *rx_reor_tbl_ptr;
+	u8 i, j;
+	u16 seq_num, tlv_seq_num, tlv_bitmap_len;
+	int tlv_buf_left = len;
+	int ret;
+	u8 *tmp;
+
+	nxpwifi_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
+			 event_buf, len);
+	while (tlv_buf_left > sizeof(*tlv_rxba)) {
+		tlv_type = le16_to_cpu(tlv_rxba->header.type);
+		tlv_len  = le16_to_cpu(tlv_rxba->header.len);
+		if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf_left) {
+			nxpwifi_dbg(priv->adapter, WARN,
+				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
+				    size_add(sizeof(tlv_rxba->header), tlv_len),
+				    tlv_buf_left);
+			return;
+		}
+
+		if (tlv_type != TLV_TYPE_RXBA_SYNC) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Wrong TLV id=0x%x\n", tlv_type);
+			return;
+		}
+
+		tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
+		tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
+		if (size_add(sizeof(*tlv_rxba), tlv_bitmap_len) > tlv_buf_left) {
+			nxpwifi_dbg(priv->adapter, WARN,
+				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
+				    size_add(sizeof(*tlv_rxba), tlv_bitmap_len),
+				    tlv_buf_left);
+			return;
+		}
+
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "%pM tid=%d seq_num=%d bitmap_len=%d\n",
+			    tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
+			    tlv_bitmap_len);
+
+		rx_reor_tbl_ptr =
+			nxpwifi_11n_get_rx_reorder_tbl(priv, tlv_rxba->tid,
+						       tlv_rxba->mac);
+		if (!rx_reor_tbl_ptr) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Can not find rx_reorder_tbl!");
+			return;
+		}
+
+		for (i = 0; i < tlv_bitmap_len; i++) {
+			for (j = 0 ; j < 8; j++) {
+				if (tlv_rxba->bitmap[i] & (1 << j)) {
+					seq_num = (MAX_TID_VALUE - 1) &
+						(tlv_seq_num + i * 8 + j);
+
+					nxpwifi_dbg(priv->adapter, ERROR,
+						    "drop packet,seq=%d\n",
+						    seq_num);
+
+					ret = nxpwifi_11n_rx_reorder_pkt
+					(priv, seq_num, tlv_rxba->tid,
+					 tlv_rxba->mac, 0, NULL);
+
+					if (ret)
+						nxpwifi_dbg(priv->adapter,
+							    ERROR,
+							    "Fail to drop packet");
+				}
+			}
+		}
+
+		tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
+		tmp = (u8 *)tlv_rxba + sizeof(tlv_rxba->header) + tlv_len;
+		tlv_rxba = (struct nxpwifi_ie_types_rxba_sync *)tmp;
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
new file mode 100644
index 000000000000..9b5dd4899f0e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n RX Re-ordering
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_RXREORDER_H_
+#define _NXPWIFI_11N_RXREORDER_H_
+
+#define MIN_FLUSH_TIMER_MS		50
+#define MIN_FLUSH_TIMER_15_MS		15
+#define NXPWIFI_BA_WIN_SIZE_32		32
+
+#define PKT_TYPE_BAR 0xE7
+#define MAX_TID_VALUE			(2 << 11)
+#define TWOPOW11			(2 << 10)
+
+#define BLOCKACKPARAM_TID_POS		2
+#define BLOCKACKPARAM_AMSDU_SUPP_MASK	0x1
+#define BLOCKACKPARAM_WINSIZE_POS	6
+#define DELBA_TID_POS			12
+#define DELBA_INITIATOR_POS		11
+#define TYPE_DELBA_SENT			1
+#define TYPE_DELBA_RECEIVE		2
+#define IMMEDIATE_BLOCK_ACK		0x2
+
+#define ADDBA_RSP_STATUS_ACCEPT 0
+
+#define NXPWIFI_DEF_11N_RX_SEQ_NUM	0xffff
+#define BA_SETUP_MAX_PACKET_THRESHOLD	16
+#define BA_SETUP_PACKET_OFFSET		16
+
+enum nxpwifi_rxreor_flags {
+	RXREOR_FORCE_NO_DROP		= 1 << 0,
+	RXREOR_INIT_WINDOW_SHIFT	= 1 << 1,
+};
+
+static inline void nxpwifi_reset_11n_rx_seq_num(struct nxpwifi_private *priv)
+{
+	memset(priv->rx_seq, 0xff, sizeof(priv->rx_seq));
+}
+
+int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *,
+			       u16 seqNum,
+			       u16 tid, u8 *ta,
+			       u8 pkttype, void *payload);
+void nxpwifi_del_ba_tbl(struct nxpwifi_private *priv, int tid,
+			u8 *peer_mac, u8 type, int initiator);
+void nxpwifi_11n_ba_stream_timeout(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_11n_batimeout *event);
+int nxpwifi_ret_11n_addba_resp(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command
+			       *resp);
+int nxpwifi_cmd_11n_delba(struct host_cmd_ds_command *cmd,
+			  void *data_buf);
+int nxpwifi_cmd_11n_addba_rsp_gen(struct nxpwifi_private *priv,
+				  struct host_cmd_ds_command *cmd,
+				  struct host_cmd_ds_11n_addba_req
+				  *cmd_addba_req);
+int nxpwifi_cmd_11n_addba_req(struct host_cmd_ds_command *cmd,
+			      void *data_buf);
+void nxpwifi_11n_cleanup_reorder_tbl(struct nxpwifi_private *priv);
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rxreorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta);
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rx_reorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta);
+void nxpwifi_11n_del_rx_reorder_tbl_by_ta(struct nxpwifi_private *priv, u8 *ta);
+void nxpwifi_update_rxreor_flags(struct nxpwifi_adapter *adapter, u8 flags);
+void nxpwifi_11n_rxba_sync_event(struct nxpwifi_private *priv,
+				 u8 *event_buf, u16 len);
+#endif /* _NXPWIFI_11N_RXREORDER_H_ */
-- 
2.34.1


