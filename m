Return-Path: <linux-wireless+bounces-11210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E094CDC6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789351C21EFD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7BE19ADB9;
	Fri,  9 Aug 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ui4sjTLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13A19AD48;
	Fri,  9 Aug 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196865; cv=fail; b=jIOyokGQCJzgY56oDo9C7FXn60X/6aAcEKb3CxW3B7EQjSGrsWwgwCNTBp0Pm797FttpWSlAzHLxP97bHgPD5OOSkdntg3hCja+JOYszkDbpiFM/3xo/wUeI1wI2xteyjjtkHQ8wYzIaSlRsH3OSIc5PcGJUjNwrodHFkNroyl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196865; c=relaxed/simple;
	bh=0foHhzZXDVtTTmtALmLNAKsobPNH8aCc51X2vIiJAfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QC1tbS6ZwEibJrnmqnwSSoOS85ffnF2kssAX+MJlGiKIlCBZPdWdwwuh3vA59Jq0cwzmEvnKbnY30+4l43gtTgpIBf7KCglVEYj2bhWqPlsymx1w5r5A6Z9QuxJpNom/kTDrA8gIj1li3h9atts9dMtJOvqwUBsbiACDj+Vhhts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ui4sjTLu; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3012qx51JYs238zSkuD88LBBTCP6SlajjU/V1o7oMjSyeSfW3RF5sRp1u+av0blchMyunXYfmmGDED8PdpMBUNx6N3AoQHSf0KAz9gT+zSqjQrmG7vad5yzK/VwZGEt0sqAln/6qtxf8fCdWmawLnRxY3o5sKtZd18QIbBfFoLr5BY1+I4aUmEqGxo6tFpr2iAHo8w+NNe/Wa8b0S7QNvqYg6fiPY/y6lSeZDTtD0Dmgtykada2qIgRSQIp7EQvQqN3lccKJGHMtjvdTuGZLMBPk1p30ISYtWq4CJyKz1rH8sxURLmr1Axjg8w9pxlZ2qY6Br0JBPL84HvZuvFnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjdDSqhEjpHYUdYJjHVZDVET+mboUoj9PnFSwThXIrM=;
 b=uVP1awQKEBn+TZACKUfVYhHN5iclQSSCIgwJvq6x3+RZI4GxZr0jdOU9qJuT9hEI0tNpHF3m0Xdgzsw0Zr9rnnHNq+pNzjhDcXIE9KILz4abtn+EL+9vOmFk98Pdtb+knNm/rMUwM7h0eXMSdQ/DD1+9p9/uE5za4CO/13HoDJisfxexbbcdJaEBRO/owsWLFy2vEIE7OVPN+dVbmHrX2rdMgAVzWJbizR/Ibp0vL85GMm+/4cefH8KayQS9XXN2u26wCZfUXfepuKw57DQVIUlkxgn4x0UUKD/B9Z6Q1dIbTkHPVXvIm0Nvfrlo3BlFRzthOOyzy4aLrSCPOBg2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjdDSqhEjpHYUdYJjHVZDVET+mboUoj9PnFSwThXIrM=;
 b=Ui4sjTLudNudQDxMp9OsMopkFHRLGA6dn1Y0VJxPqQCAmUaxpxWXiTvaL+dyN7OExlXs++OLo95W9nrXdodMce2DQF2F4wxdplgf4ScnDNIS7oJvR+2jl1ejpjw8KImECC+m9/FtvF/LgjS+C+blZpTvsKwy+Uy1aJp2FjHuDNlNqTt4bYf9b93JsIJILpiKgPTB4ub97NnaBbNY171QW1Rjwqp59Q440jVHyBsW4mUeUaJ/6aNiUjPE+/40pPTWCyyvRoXu37nuN1CFIhH8vf+3RAj+pVzP2aWRmUDUExoF7DbBZE8ZEDcxBZFO4AD5E+KsMCxw4VZb+ezrGnk6Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:40 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:40 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 33/43] wifi: nxpwifi: add txrx.c
Date: Fri,  9 Aug 2024 17:45:23 +0800
Message-Id: <20240809094533.1660-34-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 63a2a05f-8999-459c-45cf-08dcb8584ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PK+ZR9Hzm4ivHhwtbbJysvYKGTGoXqpc4nV2DOotampQPQAFHZDGBltTtprT?=
 =?us-ascii?Q?aO+F8A66ffTyjidNfyA5gWeQrakQUpkHT8OBwdFkSBF5JD8m9Rime68YyEjj?=
 =?us-ascii?Q?rciItYv+jXV3AinnI675dclJBEgXUtCLosdJHFCwgqW8sLiCoNQ0fFJGVdLx?=
 =?us-ascii?Q?Qve0/h7GEmioTas3xdkANONB3gWMBKLxQg455T8jWgY0NIry/3gJXY0DK4rk?=
 =?us-ascii?Q?Gr5Mu0zVFhMCpKpaxCYIyrLD9UusIG15QcfN1tYqpUqAcrpxDdVxVgZivwTP?=
 =?us-ascii?Q?nOaxKB8L2hW53GywIWtSvk/RrKnSyBUxJYoROZHU/mFBHhlJZG6iFTgIZzX3?=
 =?us-ascii?Q?krDx8EYiaCjknZYlmJS2vJex3PpEBpmciE7dLx/OKAc+NJJy3G4WWTKR/9wM?=
 =?us-ascii?Q?1Xyb138gR4W9/ez0nqi4yb2WBHx1F4ZAz7dr8IFOgijRAtKjZ39zoBW27W3u?=
 =?us-ascii?Q?uKtAg/p5Z0pajf0u8rRtqry22ATRYdlgres6/nioZAyWczRsjelKJYyXi+Et?=
 =?us-ascii?Q?RFUhnabyw/XuI4rlXNmgsaRwvEKsqbClTd7LD74DLQTvQmgKFW6ZEHec7HA5?=
 =?us-ascii?Q?slONwptcxDrxklpSIFiTcxJD/Rbgi2Tp4rTqt0rXE0leJfMdhg7H3BE5Y/Yi?=
 =?us-ascii?Q?n2GOKPFoz5s+sTEt0gjD+0B2oeYNuvx5r7C/VTJZDyfj1q6GE88u9ehWW04U?=
 =?us-ascii?Q?pPBcxoXQEed75LfBgpSwhbN096A8jZ9Yo2SkcoWm3jYEqprlIoOrMIgwa7u3?=
 =?us-ascii?Q?efvCK6qrYFRIW5tivF5EzCRRUavNeM0JaoC1xlSexx2X1XfVgYWpib7DYZl1?=
 =?us-ascii?Q?85czo7gSqktRpmRgE8zg57EMIye6S3ocBes6Cyns1Ao/q4W2wBEINy98pn4h?=
 =?us-ascii?Q?6OfMNR3YibycWvSJv+Qt5uRYlkF3BX3GrqgihPlGE7k5SuvEAfUQQHaJIL8q?=
 =?us-ascii?Q?dRiKp+XmRk48EIapsJw0gKy7MhfMQVK673qG9W5GHsozTTVqZSSjRpIDVudW?=
 =?us-ascii?Q?I/FmGnM9I3HMTJIIw4OBQsnhmXuXke+Fuson01Jccfuj7eBDfJtAXRFDll2Q?=
 =?us-ascii?Q?B6vMkJ+ZwnsqicdhQaNjjkZxc85jFYrNZOzob4uVq2EfbXAwOomW3ZBsj9Sa?=
 =?us-ascii?Q?YjYICmY4LY2iuM8FrGXaKjMFiTVgcjw5l0ISPnSfslIy9h1pooXlVTtHlDXN?=
 =?us-ascii?Q?T3GjlJFLoh/gR/IpTpixApHY56ERDKiiWXBGr0iJU4xTjfen0f+yXoyXEtDD?=
 =?us-ascii?Q?PuI8Q5C3Ki91jexbDjl6zvdpK/HEtb+h5rO1mFwQiMwF/ZzoTfvbg3D6ngSn?=
 =?us-ascii?Q?tADLJZ12TUnsrWxE2jUIzPTTq/oaSVsGNV80QXme8aKbbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GD8ylD7Cn002A6audz05b0wW+86w787vg0owX+UOhTCE3meQnrrEJR2LcZZW?=
 =?us-ascii?Q?dUYcHdzAsNE+nK4XrE/LlEjT9aRTiWqzm+ikAWSLGMUoONvwliOUpF6PVUiV?=
 =?us-ascii?Q?6XyM7hF0jtNalfEWpf6Tne7yNf4iD34FMUeZKK650BrldwdyWu21WGfqJCG1?=
 =?us-ascii?Q?Tb6CmpQOxBEgWo9eXnpfxnZ8xcwtnXikk56ni/MmVNPCeU45/TGhW8vOk2WG?=
 =?us-ascii?Q?IlTN0KiuTE467m9TK88AX7kPNE7kIekl/25TP2amhgX42mz7bOcDl4oGo4Rg?=
 =?us-ascii?Q?fdO3IamWQgMzSMySmbPfwL0Qk5odIxTLBek30bDRJp/jImNgZDAs+yMoQeEN?=
 =?us-ascii?Q?SfOLkUzzyoOIUMT2ybdr5LmLWlPRHrPGlAmEs/tewqoH7F2naP5j75NudKtl?=
 =?us-ascii?Q?r8LWgMBJgPk/03M6+Yc9FC2ipjzHHnmX5Yekj+lEiy4Mi8eFBPK51LtsSK+E?=
 =?us-ascii?Q?FeFSLhqTjqGrohw6gM8hErn6xt/jLoh+SBMcVch+Bengn3rE1S/xYL7Suvzz?=
 =?us-ascii?Q?wwGC8w16aqgypgWiEGco+GJd+VRiAZyomp8MrgduItpye4Urv3cDRhlJ4V0I?=
 =?us-ascii?Q?WVrGEUi2WChvYIbYyUGsCbzUj+lV8piAxrXPnGBvit1XP8rnuLknJfAM64Xp?=
 =?us-ascii?Q?TC0Nim3huXnQZQknPN+sPoAu+YOJv6bJ8EQo/bdezrTvb1rqjWH9UAX6BI+i?=
 =?us-ascii?Q?5MU/c+CMFvD7tVznB04z+6WA1hM/t9oCJsTZfqUkdv/ZKVKh0wl2glZwbens?=
 =?us-ascii?Q?PO0yrOhwOtUBm87bAdkrT4gYz3aggjc/EQ/V1iiTuMCibdh1Yc9liiLyGRCa?=
 =?us-ascii?Q?5jvUt4/ttYHRztfaRi9fd1Ww1vMFoC67bT1gtNStLHHsLCfbKD6jslfMVk+A?=
 =?us-ascii?Q?dDAM5vPmUB+f+k81bdIRC3+PBlEFZc0lhiRKFlxbSViceby1UkH2o/Cja3pU?=
 =?us-ascii?Q?bRONEEBc+hwXJ2KTtEEns2FsxP5FdLgeWtISMWmCuak26bTiIdErSt/QTQ7i?=
 =?us-ascii?Q?cOfSMbzoDv5WMzwDymK0Y6gQrE9Wv1g8olCv9S7i5NNkSe6c+57vptj9cKRX?=
 =?us-ascii?Q?WVPeXM4wutwci//E1pMvUJXXP9/LEtHYfWnk9sCWX10vGTv/siLN5QKusW6B?=
 =?us-ascii?Q?4m6dYdpG6cZ91f71pR8FzsjeuszWwxTRmYFNb/cmAur7YgnzTVxZBEsrqB/3?=
 =?us-ascii?Q?zUWW9xUmIv1027atb35bFJziNzxyuK+VIXXxOEseU12rwG44oAhJIuXqPKS5?=
 =?us-ascii?Q?xSae7AKKJl/g/jbYokpF06XpqDENcVLnq5fLEgZcMrfbVZl3Lww88ygbsF9T?=
 =?us-ascii?Q?XDc2ao9XnckW37kKteFHCXj/e04xJWAjS3HdcVeaB7fZ8Y9G247YUghtuZuu?=
 =?us-ascii?Q?7CQ7k1IzzfPs1DC6XdT2RsYatbqp7VLl3tETEAqGTmUSqaqw5lBjRuAp2oK2?=
 =?us-ascii?Q?7j4ONYNEWKxDyMMpoM1bXyPcF6dBV7McKI1Dzr3FjVnup0PizpciK9BMb1YE?=
 =?us-ascii?Q?xUJufP1YL3Jb9Q0jHm93Qxa7OFNrJ84nqJw8c+UWHQQAhKAtoNGDlnZu/WdO?=
 =?us-ascii?Q?U4rqNegkKo726hl4ReZQKfIXedEcXLZqjAuV0xWNYNw6dxARy9YOSWFt5+sH?=
 =?us-ascii?Q?0ZThe3zMJXvmW++ZNOWcx45OrZZyNkB4fQAxRR5j4D2V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a2a05f-8999-459c-45cf-08dcb8584ee4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:40.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsIbmySnFunsEsWEmPYKrXlyutg/AQS66wCvoAPIixEZ0BPbU866C2pSK8uhNX5JIiDwdPligSLfS2vjyfSQ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/txrx.c | 358 ++++++++++++++++++++++++
 1 file changed, 358 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/txrx.c b/drivers/net/wireless/nxp/nxpwifi/txrx.c
new file mode 100644
index 000000000000..860c88bf8ea8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/txrx.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: generic TX/RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+
+/* This function processes the received buffer.
+ *
+ * Main responsibility of this function is to parse the RxPD to
+ * identify the correct interface this packet is headed for and
+ * forwarding it to the associated handling function, where the
+ * packet will be further processed and sent to kernel/upper layer
+ * if required.
+ */
+int nxpwifi_handle_rx_packet(struct nxpwifi_adapter *adapter,
+			     struct sk_buff *skb)
+{
+	struct nxpwifi_private *priv =
+		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	struct rxpd *local_rx_pd;
+	struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+	int ret;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	/* Get the BSS number from rxpd, get corresponding priv */
+	priv = nxpwifi_get_priv_by_id(adapter, local_rx_pd->bss_num &
+				      BSS_NUM_MASK, local_rx_pd->bss_type);
+	if (!priv)
+		priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop RX packet\n");
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	nxpwifi_dbg_dump(adapter, DAT_D, "rx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+	memset(rx_info, 0, sizeof(*rx_info));
+	rx_info->bss_num = priv->bss_num;
+	rx_info->bss_type = priv->bss_type;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+		ret = nxpwifi_process_uap_rx_packet(priv, skb);
+	else
+		ret = nxpwifi_process_sta_rx_packet(priv, skb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_handle_rx_packet);
+
+/* This function sends a packet to device.
+ *
+ * It processes the packet to add the TxPD, checks condition and
+ * sends the processed packet to firmware for transmission.
+ *
+ * On successful completion, the function calls the completion callback
+ * and logs the time.
+ */
+int nxpwifi_process_tx(struct nxpwifi_private *priv, struct sk_buff *skb,
+		       struct nxpwifi_tx_param *tx_param)
+{
+	int hroom, ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd = NULL;
+	struct nxpwifi_sta_node *dest_node;
+	struct ethhdr *hdr = (void *)skb->data;
+
+	if (unlikely(!skb->len ||
+		     skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hroom = adapter->intf_hdr_len;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP) {
+		dest_node = nxpwifi_get_sta_entry(priv, hdr->h_dest);
+		if (dest_node) {
+			dest_node->stats.tx_bytes += skb->len;
+			dest_node->stats.tx_packets++;
+		}
+
+		nxpwifi_process_uap_txpd(priv, skb);
+	} else {
+		nxpwifi_process_sta_txpd(priv, skb);
+	}
+
+	if ((adapter->data_sent || adapter->tx_lock_flag)) {
+		skb_queue_tail(&adapter->tx_data_q, skb);
+		atomic_inc(&adapter->tx_queued);
+		return 0;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(skb->data + hroom);
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+	nxpwifi_dbg_dump(adapter, DAT_D, "tx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+out:
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, DATA, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode && adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case -EINVAL:
+		nxpwifi_dbg(adapter, ERROR,
+			    "malformed skb (length: %u, headroom: %u)\n",
+			    skb->len, skb_headroom(skb));
+		fallthrough;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n",
+			    ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+
+	return ret;
+}
+
+static int nxpwifi_host_to_card(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb,
+				struct nxpwifi_tx_param *tx_param)
+{
+	struct txpd *local_tx_pd = NULL;
+	u8 *head_ptr = skb->data;
+	int ret = 0;
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop TX packet\n");
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+		return ret;
+	}
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(head_ptr + adapter->intf_hdr_len);
+
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, ERROR, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode &&
+		    adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		skb_queue_head(&adapter->tx_data_q, skb);
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+			atomic_add(tx_info->aggr_num, &adapter->tx_queued);
+		else
+			atomic_inc(&adapter->tx_queued);
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n", ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+	return ret;
+}
+
+static int
+nxpwifi_dequeue_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	struct sk_buff *skb, *skb_next;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_tx_param tx_param;
+
+	skb = skb_dequeue(&adapter->tx_data_q);
+	if (!skb)
+		return -ENOMEM;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		atomic_sub(tx_info->aggr_num, &adapter->tx_queued);
+	else
+		atomic_dec(&adapter->tx_queued);
+
+	if (!skb_queue_empty(&adapter->tx_data_q))
+		skb_next = skb_peek(&adapter->tx_data_q);
+	else
+		skb_next = NULL;
+	tx_param.next_pkt_len = ((skb_next) ? skb_next->len : 0);
+	if (!tx_param.next_pkt_len) {
+		if (!nxpwifi_wmm_lists_empty(adapter))
+			tx_param.next_pkt_len = 1;
+	}
+	return nxpwifi_host_to_card(adapter, skb, &tx_param);
+}
+
+void
+nxpwifi_process_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	do {
+		if (adapter->data_sent || adapter->tx_lock_flag)
+			break;
+		if (nxpwifi_dequeue_tx_queue(adapter))
+			break;
+	} while (!skb_queue_empty(&adapter->tx_data_q));
+}
+
+/* Packet send completion callback handler.
+ *
+ * It either frees the buffer directly or forwards it to another
+ * completion callback which checks conditions, updates statistics,
+ * wakes up stalled traffic queue if required, and then frees the buffer.
+ */
+int nxpwifi_write_data_complete(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb, int aggr, int status)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+	struct netdev_queue *txq;
+	int index;
+
+	if (!skb)
+		return 0;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv)
+		goto done;
+
+	nxpwifi_set_trans_start(priv->netdev);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT)
+		atomic_dec_return(&adapter->pending_bridged_pkts);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		goto done;
+
+	if (!status) {
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += tx_info->pkt_len;
+		if (priv->tx_timeout_cnt)
+			priv->tx_timeout_cnt = 0;
+	} else {
+		priv->stats.tx_errors++;
+	}
+
+	if (aggr)
+		/* For skb_aggr, do not wake up tx queue */
+		goto done;
+
+	atomic_dec(&adapter->tx_pending);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	if (atomic_dec_return(&priv->wmm_tx_pending[index]) < LOW_TX_PENDING) {
+		txq = netdev_get_tx_queue(priv->netdev, index);
+		if (netif_tx_queue_stopped(txq)) {
+			netif_tx_wake_queue(txq);
+			nxpwifi_dbg(adapter, DATA, "wake queue: %d\n", index);
+		}
+	}
+done:
+	dev_kfree_skb_any(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_write_data_complete);
+
+void nxpwifi_parse_tx_status_event(struct nxpwifi_private *priv,
+				   void *event_body)
+{
+	struct tx_status_event *tx_status = (void *)priv->adapter->event_body;
+	struct sk_buff *ack_skb;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!tx_status->tx_token_id)
+		return;
+
+	spin_lock_bh(&priv->ack_status_lock);
+	ack_skb = idr_remove(&priv->ack_status_frames, tx_status->tx_token_id);
+	spin_unlock_bh(&priv->ack_status_lock);
+
+	if (ack_skb) {
+		tx_info = NXPWIFI_SKB_TXCB(ack_skb);
+
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS) {
+			/* consumes ack_skb */
+			skb_complete_wifi_ack(ack_skb, !tx_status->status);
+		} else {
+			/* Remove broadcast address which was added by driver */
+			memmove(ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16),
+				ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN, ack_skb->len -
+				(sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN));
+			ack_skb->len = ack_skb->len - ETH_ALEN;
+			/* Remove driver's proprietary header including 2 bytes
+			 * of packet length and pass actual management frame buffer
+			 * to cfg80211.
+			 */
+			cfg80211_mgmt_tx_status(&priv->wdev, tx_info->cookie,
+						ack_skb->data +
+						NXPWIFI_MGMT_FRAME_HEADER_SIZE +
+						sizeof(u16), ack_skb->len -
+						(NXPWIFI_MGMT_FRAME_HEADER_SIZE
+						 + sizeof(u16)),
+						!tx_status->status, GFP_ATOMIC);
+			dev_kfree_skb_any(ack_skb);
+		}
+	}
+}
-- 
2.34.1


