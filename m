Return-Path: <linux-wireless+bounces-11208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A534894CDC1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294A21F22651
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939219AA5A;
	Fri,  9 Aug 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k/NcWVWn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633519A292;
	Fri,  9 Aug 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196862; cv=fail; b=cKUL/5UOgr/e7a/wl4NfCiVHQRYhJ0IVNLMod71JtaWtwIZMgKrH99zfAD/amy+PHS8M9RUe1sJykrYwrO7NcNEKObl+oNUtwcJ5sK0epbmhvi1DZM/lQS9cpFssKvxu73Xr7bzAXiFgGsXhV4bfIH8/zm550W/bX36R8DEHbBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196862; c=relaxed/simple;
	bh=DDQiYReXEn8m66gnYh6BKe8sKCmgXc9a08gjrNYGTeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9CKm9lrNdSWveqByViHuQXpPW7amITLblC++rDEJ4BAzzv9KKWaR+zZzr4VP34RJTmq10aJtApE5EPQktakluAB+3QD3yc0oTDLTEK8vvj4MHT0D1ztiFw+yS9JWvuhyfNx24T6mM1snHIvwHrVHUtX5uV3PQ3fNjF2tYQQwAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k/NcWVWn; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+Icd5mvKahcSXz6z4VSBhSQwfz0gUb3hU1uvdAXPRj1miyY6tl5C7cNE2aluY5Gy8hH8bo2s59KNeeA8wXKJJ1Y08QDM1yM6O16mZav9lGf9wWfEctntsj7BBVGgBRhJV/GuSzQwAcOi94pXerZ5BRXuhTPkSkOcLmwV6dwZw3eV88JemPnfNevwEdDSHhD/9XKtALrL86A1pjE6LwEOnSbrsWj/qEgVLZ/mjc/etzzfXnDuWFl1llPZ/RRb5WMxWPOhmQNgWZT8+e31h1T2mSj66qHau1c0QZ8WmLsrybKVzJEiJAEALSNNoeU5C7ORiTdzJ4Eiq+qtLTSN1/lHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPYKdYedoU53SfuboJdEPF5gmNgQoeI+D72UANQYILg=;
 b=Z1YjspJ/kDRDUVvAzsjsu9JXAC1AW5xmw0UIHyIRT1t954EfNCKkMFjGw3x0orjkRJPgD1msZiNxhYYDLTOQ6Oh1+GgyXu5vZpTC9E+OQohrqQQsmMHfaIEaP+QedqtR45npIzWu/5Gkm/dxqr0vg8FdvML3zM9EXQXxsFkjEH3T0x8YWNKaUhQKc35qRykM6w5cePDsHcaF51OXYkhLDTpYnOhycxwQ5aY8SdAfOEDsX1wKKkBSs9QPT4jkCczUD98M46dYBZosEBS1CRJX3NO2+ToSdj03eLzWOi6w9n584v7b4xRoaKYMcx5Y46mVjhCS6gpReQitnxhZx88Efg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPYKdYedoU53SfuboJdEPF5gmNgQoeI+D72UANQYILg=;
 b=k/NcWVWnINkYFPsUfRYEojZhLvTvSktN13ULsCQk4LSTvoix9ePLJKwMTe3ZLjQB5Nxwqlp+UdMWw/LxmdzzIwUWSno6APVNfA7dAWXYg2ytUP3ixKYcram/10Ckq8f3itke0a/OlwyDXPOXFdLPv46pAQb0By3PD9K2HNEPOvHjN/3RIlX2XcgZHvxCLv5b7ruJd1fjRzcgNljOQ1Bq/kqZYR4rekQzX9nHBAQkWVXgRGXTj6b377Y8C8wxy0dU17jWayh5ZUyRRVfNKR8GbJbnTm8p5a8MmE1sVUiTtiSxrPApBG0jhgrXJ3D9JvsR18QSGt5n1TBZqAXIsL5wNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:37 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 32/43] wifi: nxpwifi: add sta_tx.c
Date: Fri,  9 Aug 2024 17:45:22 +0800
Message-Id: <20240809094533.1660-33-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GVXPR04MB9949:EE_
X-MS-Office365-Filtering-Correlation-Id: 93207915-a224-4da1-9327-08dcb8584cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3d4prWFXeEiybTOgBnjv54e0CPkufRrWf50WH66HN3ycCpx+TRoWQXygNUnA?=
 =?us-ascii?Q?ILWF1VnfSKVrTamf/YW1WRPWWMvZpghAeFKLwFJrSKwBZR5tnUw0p6w7E6YQ?=
 =?us-ascii?Q?P9YU8RD3zwJdcOm2Lnu62VkWRW5X708FLVkXaXob6j/3doAKdPohkuHaM6qD?=
 =?us-ascii?Q?lUUqTYfKmH1Q26iVx7u5XauGgnj7eyW/W2tLkhHXY/lkNn7EVv794PIWAQo5?=
 =?us-ascii?Q?+CdVwmKvocy0kkEfhyOPxyxdS56wr1ruoui7oELHUow8/WCmC4SHtELwNZ9D?=
 =?us-ascii?Q?xDtHvMQvLELRlqRpKToxtJbjE6EwZ28vWVI5oe4FL3gNuQm98JrO3RvgcuNK?=
 =?us-ascii?Q?PKc3tQ9/bj9vB3UnE7oX+3GlXPFcy46LcSK1bWXXFeqFi3DrL5se35/LYvFw?=
 =?us-ascii?Q?49ftfSOW+SwUBv6drvmlWY1SoaS7eknYJtRLYVC9yIgkklY9ubk+oMcI1d/Y?=
 =?us-ascii?Q?yH1l4F7w48sSGP717BnmpwNSyf10D5wi4VygDyBfFnrPgBu6PgWjcmmJvfAI?=
 =?us-ascii?Q?cSgip2B8f/yPwAGjvlKS8ocPqjyiytK6WRfKhjaCfLEJYGxk+jdhznKBu1oQ?=
 =?us-ascii?Q?d3/6YE+wzwggQC+7mM0kbgYgN6L2rjdiRV/YOdF7KAiBWylpW2y54wpvVbpN?=
 =?us-ascii?Q?WeaCvKCfWIXlnKEXcETjKkZZzz8aT1s3Reu3p3TFNEz/B58M2QeiLkuHs70G?=
 =?us-ascii?Q?B1zcmawKbY8b5Ofe7J12gPXhBNrVeJA4UaA2XxG0H61pchcqCEWAc/YVnmIF?=
 =?us-ascii?Q?ngvshwUbnBRmA72bMosHEG1htmBBYc0fpmf7r/lu3Xq0cTkrCFnDL+SKXW9U?=
 =?us-ascii?Q?xqhaVUoNj1Hn5sKz4KMpxr1uNh3SYbPLbD1B07SJRD2HiQolSEeSZIwaayVw?=
 =?us-ascii?Q?4XGGwROynimvkEYsD/ki3qD68zfnttoE3JeHqJULgWx2nr1edCGVTxNH3zuV?=
 =?us-ascii?Q?A1zQhOE3tctMki2sjDeyHx5vjSQP2DyEPElBwUYDkRkI6aIDOiKF0HfHYbug?=
 =?us-ascii?Q?epePX8odnWHQig6TCBsR4V2DnrPwMMlk2Bttv6MgkREPBjNCOR10y9J+MZ3s?=
 =?us-ascii?Q?6juY9czEhf1//5QBwPx1mv2RvzpNvmNgh+2xfwk3oE/EWiG0qkjksGTVy3Gi?=
 =?us-ascii?Q?EldT7075FhdEBP7Ve/wG8kNXm8ilP44z3Lvt/8TBZ3urx3tiAI/JaqakXx9B?=
 =?us-ascii?Q?Him39zuiOyq4ArtNiSjmpFoDjTZIacCfkExA+eeCC9B8pWV23MPGso7x8ovY?=
 =?us-ascii?Q?AAiwq1EgJHkVCd1rkHMvD2PtYEW9nKTRYmPyCabEX9LtC/pj9EPe0LlySidS?=
 =?us-ascii?Q?tod8x4VEe4mg92mPk/GEIlAiazseuOy27+yHRHWfbZnvdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dXl7Vlc/sIaqJBGRiNayJZDCbo/rB8Tv/SsskeF4Dwo5GyiescgYYhBt+Io8?=
 =?us-ascii?Q?kZZMQov/tfP50x8kHK3GlRaIJXGD2pSF5AcAp/QZEgM40x/nF6kee/PJZT74?=
 =?us-ascii?Q?gcDRWRLUWji6wE+WkfkG8WsunBk7qFtke+WJa++XakGuUV5KbaLb9Yy2lhIb?=
 =?us-ascii?Q?q4wpOi6t8Stdfawf4LozWuaIFdQPWE+USh+tHkS0p8bvU6E7EKGN8PgNIHss?=
 =?us-ascii?Q?9O9vinWJtiWt7t5n1XX2GlLbD4s2f89KPd5wyQbdUSEE012vAOt2WHHRsXMW?=
 =?us-ascii?Q?ux/eD5HyjjvIEanjkdqNPiA/luhrlclEAFFtvJrCpxnz8RiEo5maRuZ7jIHb?=
 =?us-ascii?Q?EIwpMKZdmioxfd6TSi9xgRpHV3T7USsbBbzqhRS5X+di5ZLkPcCbYtiPaky3?=
 =?us-ascii?Q?/9ctHRa5NUNy6Bwd8IICo5K+i7TLton8lifUzyoyRdcVVyUapG/YiUA0oniH?=
 =?us-ascii?Q?yCjEDgIupYdEpmkNbFF7ugdeyX9biqlRb3T4GLktHauy7IC5eWRlXpnmFL0F?=
 =?us-ascii?Q?5jHQi0pT5awQwra7+Ln1DQGIQe3kUv+QG+CPS6kXDK47pwopixIwYGSUg8bA?=
 =?us-ascii?Q?4UvDQdq3BKR1oOwGcKzgmMolkxDu/2VobefluErorngYRskBLsxNyMgFoGQg?=
 =?us-ascii?Q?ywj713RtKmdRzNp8PPzgIMzON0hZ0e+4M5CZNAeadS49csMN66elMY8d/7Ev?=
 =?us-ascii?Q?54Olhx0+xzOFxy8304P71wVT5deAsRgIBI0RfYghpP8GIiZpp/G5cRdFAyyB?=
 =?us-ascii?Q?YsxL3q/Nwg2q0+LUp68Wn0DeeAJL1yw54q/yizu5SUaZBkhoy2pon7yEFara?=
 =?us-ascii?Q?9yamzoEa+sIK00uT5FD4Vvkzr9rdAiM1OpYf3CXPUpcQQUKmsFGWigapEFTK?=
 =?us-ascii?Q?dasoYptXyoKBDNFXN3sChQCvD1tx6EwWDWsvisY3w6dcsi6hABfjf4SAf/Yk?=
 =?us-ascii?Q?ATBvxjKImWPZ6EdXzcGXxFN0U4hJA6NZOt+2DAcbQzHjukAIJxGb6EJ5mzRO?=
 =?us-ascii?Q?27CUZlAVYZKtNxe8MJfNJSeX/aBL0ticEroR5cc/xaFLpr1lHmCiAgXIPnXt?=
 =?us-ascii?Q?CvMljtg4pZtYw/CcCRYkNjjqhihtJsqNVNlmHllOV3EtLrGrhIkX74mxt53y?=
 =?us-ascii?Q?0R3XQIm2vwVg1w/w6+51q8iXeGpqLBCJ+MrmmBPjFV+LC9nat+vwiPFcYu9M?=
 =?us-ascii?Q?XwFqLuBKMZYOgU/D49PWJiH/M92qVRnbJRHEweCLEG/WrynkSakG1fteeYca?=
 =?us-ascii?Q?lj57QeuBbqm0ARKmK5w2Pw5O6vdVgIs8RWQzuc3LVRfhjWXKbjJvMPNyB1gA?=
 =?us-ascii?Q?/X3cSSAw6yGHKtWK6wXykCd2Z6o2jvW1GfPUZmeR6FLGM2VhFUxr1ReoENFX?=
 =?us-ascii?Q?zwk3dONdL6HWkNA5Yn6Pj2+96gYdqY72VE7U8meJk4yZk5Dih41jz1ye03mI?=
 =?us-ascii?Q?iANxmUkemHvTQm11T+Sxqlw7YrCpiK/C7ytCXCop4XrsLUpgSUkUQP1Yq91t?=
 =?us-ascii?Q?IVkHumdtJRTmxvm11JT++8jrRJYPAxEw2MXqHibGtBZM1VbW3Y51zP2umcxV?=
 =?us-ascii?Q?FPL+ETiubs+qwtp1BQ94rhP3YSLhneu8iP9F7k+Bwmf/hGQK4CkMueVFqMph?=
 =?us-ascii?Q?8IlBDS/L4MWkMYfOaCzSVH2jPRWdy9xVBV8bYO4ZKWF5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93207915-a224-4da1-9327-08dcb8584cee
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:37.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFHVDau/7EgUDNa6dRwdAmJG032GlE/gqIqR9APX5YpiawVU9/ZWGnwW6iMzw7Xh9xOSjkhu2qB5AUISzQEmcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c | 209 ++++++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_tx.c b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
new file mode 100644
index 000000000000..f1b686ecc843
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station TX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+
+/* This function fills the TxPD for tx packets.
+ *
+ * The Tx buffer received by this function should already have the
+ * header space allocated for TxPD.
+ *
+ * This function inserts the TxPD in between interface header and actual
+ * data and adjusts the buffer pointers accordingly.
+ *
+ * The following TxPD fields are set by this function, as required -
+ *      - BSS number
+ *      - Tx packet length and offset
+ *      - Priority
+ *      - Packet delay
+ *      - Priority specific Tx control
+ *      - Flags
+ */
+void nxpwifi_process_sta_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	unsigned int pad;
+	u16 pkt_type, pkt_length, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+	u32 tx_control;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*local_tx_pd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+	skb_push(skb, sizeof(*local_tx_pd) + pad);
+
+	local_tx_pd = (struct txpd *)skb->data;
+	memset(local_tx_pd, 0, sizeof(struct txpd));
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+
+	pkt_length = (u16)(skb->len - (sizeof(struct txpd) + pad));
+	if (pkt_type == PKT_TYPE_MGMT)
+		pkt_length -= NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	local_tx_pd->tx_pkt_length = cpu_to_le16(pkt_length);
+
+	local_tx_pd->priority = (u8)skb->priority;
+	local_tx_pd->pkt_delay_2ms =
+				nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		local_tx_pd->tx_token_id = tx_info->ack_frame_id;
+		local_tx_pd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (local_tx_pd->priority <
+	    ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl)) {
+		/* Set the priority specific tx_control field, setting of 0 will
+		 *   cause the default value to be used later in this function
+		 */
+		tx_control =
+			priv->wmm.user_pri_pkt_tx_ctrl[local_tx_pd->priority];
+		local_tx_pd->tx_control = cpu_to_le32(tx_control);
+	}
+
+	if (adapter->pps_uapsd_mode) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			adapter->tx_lock_flag = true;
+			local_tx_pd->flags =
+				NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET;
+		}
+	}
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(struct txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		local_tx_pd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!local_tx_pd->tx_control)
+		/* TxCtrl set by user or default */
+		local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
+
+/* This function tells firmware to send a NULL data packet.
+ *
+ * The function creates a NULL data packet with TxPD and sends to the
+ * firmware for transmission, with highest priority setting.
+ */
+int nxpwifi_send_null_packet(struct nxpwifi_private *priv, u8 flags)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd;
+	struct nxpwifi_tx_param tx_param;
+/* sizeof(struct txpd) + Interface specific header */
+#define NULL_PACKET_HDR 64
+	u32 data_len = NULL_PACKET_HDR;
+	struct sk_buff *skb;
+	int ret;
+	struct nxpwifi_txinfo *tx_info = NULL;
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return -EPERM;
+
+	if (!priv->media_connected)
+		return -EPERM;
+
+	if (adapter->data_sent)
+		return -EBUSY;
+
+	skb = dev_alloc_skb(data_len);
+	if (!skb)
+		return -ENOMEM;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->pkt_len = data_len -
+			(sizeof(struct txpd) + adapter->intf_hdr_len);
+	skb_reserve(skb, sizeof(struct txpd) + adapter->intf_hdr_len);
+	skb_push(skb, sizeof(struct txpd));
+
+	local_tx_pd = (struct txpd *)skb->data;
+	local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+	local_tx_pd->flags = flags;
+	local_tx_pd->priority = WMM_HIGHEST_PRIORITY;
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(sizeof(struct txpd));
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+
+	skb_push(skb, adapter->intf_hdr_len);
+	tx_param.next_pkt_len = 0;
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_DATA,
+					   skb, &tx_param);
+
+	switch (ret) {
+	case -EBUSY:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: host_to_card failed: ret=%d\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		break;
+	case 0:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, DATA,
+			    "data: %s: host_to_card succeeded\n",
+			    __func__);
+		adapter->tx_lock_flag = true;
+		break;
+	case -EINPROGRESS:
+		adapter->tx_lock_flag = true;
+		break;
+	default:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: host_to_card failed: ret=%d\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		break;
+	}
+
+	return ret;
+}
+
+/* This function checks if we need to send last packet indication.
+ */
+u8
+nxpwifi_check_last_packet_indication(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 ret = false;
+
+	if (!adapter->sleep_period.period)
+		return ret;
+	if (nxpwifi_wmm_lists_empty(adapter))
+		ret = true;
+
+	if (ret && !adapter->cmd_sent && !adapter->curr_cmd &&
+	    !is_command_pending(adapter)) {
+		adapter->delay_null_pkt = false;
+		ret = true;
+	} else {
+		ret = false;
+		adapter->delay_null_pkt = true;
+	}
+	return ret;
+}
-- 
2.34.1


