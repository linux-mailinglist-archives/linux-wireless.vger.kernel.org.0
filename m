Return-Path: <linux-wireless+bounces-11217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C8E94CDD8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE3280AB5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7D19DFA7;
	Fri,  9 Aug 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="krfEM5IE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAD19D89A;
	Fri,  9 Aug 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196890; cv=fail; b=o0oulWLLFfkpa6uiCCwxrqf2PV4P5E+AvCDXYt77kAHF8OVPYrcrCEvSw8MbJxOkskKfOnj2aBL6/KVljDB3DzsAXadY9Lade3E1xaMYYqUiIcL2xLVjSIctHeB20PzPcxtvMQQjBqYG3r96nYGLbO0jE+MQ3SyYMpBM3wa4bp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196890; c=relaxed/simple;
	bh=FOt+cZidB2Yxar++XFT2S53xkdTDVNiquxmSCJazfEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3wHcJJr304UD2MzRY9GxcHQsLthFyTlcEE/CHiGmdzVDFe8TjADfOXhCnSi3zGPRahxKhUD7mC+f3w7VQoZ2u+IbRHkTtpdsT79uz/tBWPPDjYSbOnPp4DHt8CQI9+Gj53KCwo0JaKtQKzXzce8p8yqtcaL3pqCsPEBJ2pM9U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=krfEM5IE; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfl7ddqeZNF1uINr/WwzOR/q7qWdkqCn/3fL5YgB/Rvget+K/4g2w0XacsghH2+a8FeoeOpbsoAmV56owTBsF8kUBKMfiQCb0HO7skOj+/c7FcoZXuRbdtS7VIJWghICFnS992TdU2hTBCXyorUW1xecNYgB3nWrSaZIRK4YEGA9rm9Cp2UOa14DvxSu9UXu4o+tKxILByyB8Snq+1UrHQXtbxKpjNzph/51Kw+w9VrNCwWFQWJs2FkqJbBJfAT92lntLXqtfRoEAYrRcg6wCHackwNa9VhxNbU/m6cku//bJdFHNOs1amf0wovRe7Y7LXaf7adfJh8no2NgQ1JJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXykF0am/9voC6dIHGjayFXtS8btaToNjb0SipAQ/JA=;
 b=WotAqpkN5xCXsRbluvVy+pGp+Opgraw3eHxf1JJ1d1KY1n+/C3Mbt7GV9fEeK1Xod+Af06U7oTfU97mziKvkIqSzsU66RNOikAvI0k88WDVS+eXRSq/GXVnirYkvQluZtafh0TGYS0X7zYK8PITnIzfH9zpW9TJ6gfNFrUCOmi13mUhyF6OTU/dTE8wtbFDNmjzmYi6Qdjuyypxae2tcHMi7Xr/2AGMTCThIX+p8nkYT+CWplHVnaA92KEFVqxnYTuiz/5doAleEGxwrAN3rmhZDXXR11lAelzOQ5vP8OnwNJzFN6Ug9vQ8NNSL47UF/zSWqd2Pf8t65DvXocf83/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXykF0am/9voC6dIHGjayFXtS8btaToNjb0SipAQ/JA=;
 b=krfEM5IEFqtEN8RElazMFDTd+4IQmMKdS9Mj61bWKex6m5f7Wbl5Cyt5UIc8SM0wywBqoyxZlOblL9LKy7+UrbhpIgSjmyFWw7lk/dXQwHnTeb/fy9A7krLMNN6vDBS/R4ltQeYJOx1UCFmig8laU9wsFk8X9RG5NMc7WlkInrvG18t4VSp1LABQJrf8vUw3BZggCZlXEYDSmtCqi+K6k0vijqRTuenP8RodWc00+BPOea2YoJlhvEHHNfZRYxn132Mb9U/o58j96BC4UGg1HcwAaUcQkMkIMrx2U/LBsbCty1Z79uzEYF7TEvfmQvBMbWWH5F4UohjVXjmQwGZOHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:48:03 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:48:02 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Date: Fri,  9 Aug 2024 17:45:30 +0800
Message-Id: <20240809094533.1660-41-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 1998d713-97a0-4964-a6c1-08dcb8585c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQIGOWrsf619JbnG3UAArYEZU/n/coICZLCThxX2iQZC5R7TpYRfL0aIHsQR?=
 =?us-ascii?Q?SK63p/ELNVNmgFFN7dYvsOeNytzDID26g9BmTputJxzMYrSBT0chwNvKN5qx?=
 =?us-ascii?Q?j2PZZfEfX5gJCVnoH/uw07Tkv0QZj1aGqRQhz/eDoDVlntP1LlfsALnPYqTZ?=
 =?us-ascii?Q?x/59rM+8cbSelHacWYU26Z59eLbwAqqyyX3YSBoSTMwrcemyIzjqzkWG2oIG?=
 =?us-ascii?Q?onH1Z49Rf5ipnn7VZ1rSG8c5M5vz2MnOMwYjHfXD9GHwz1qpHwxNpuQ7OdAc?=
 =?us-ascii?Q?PdMrB6OY0R4jkN6MimSbHumw6op6I5OYHYSS8UqI0sJSIM097PqhOz9hXU5C?=
 =?us-ascii?Q?jeYczfW0m/ZcNxN4lrC1VLaFnDVeko9YBLODJFFaD8e+uvEjbXKBwEYR1TW9?=
 =?us-ascii?Q?1DEgi4ga89LMORH317mqOy6ixzA+G/ozdYlJ8SdRUsFx3fgDy8TjAx3ya//5?=
 =?us-ascii?Q?Djpoz6kzSQcJueuOxmgMcqnVItwAn5dxSZ0/3ZFZcp3g//rMYostgcV1nPBQ?=
 =?us-ascii?Q?OuHO+fn1U8tfss+qcn5crId295+BKNAXozioh+Jrn7Eiga81oNGU8Oco9b+f?=
 =?us-ascii?Q?v2DB9nPlSd+DO+pArj03T3mDbDaYuF8BDGEibUMg6la+q/fhOZpGgqP2ZaPz?=
 =?us-ascii?Q?ErV6LA6ze7SHIirM9+UD1rM+3ZpxRJC3DM3MpxV64qhZHUsN1vqFIV6UnWOn?=
 =?us-ascii?Q?7n41XT/X9FD6cMsG+m/1OoRty+5CMfIQGSG0WtvlOUzalfHknjabphOjgeyE?=
 =?us-ascii?Q?DcOs/zVkhppvdhuBAqQnuSZI66hy21JhbldCv9etO/HhfOhWA0TACu9S69VI?=
 =?us-ascii?Q?QYx457Yrw1ftVrZ/aXFJnPEUn5FX186e2p1ijGQllVQnwV3l+k6zgbskg/Sn?=
 =?us-ascii?Q?Rpa65fj9SMukyfV/zGzJtJjElyfCws8z8GSDgzMmuqO7747XRHOHndDxnlL1?=
 =?us-ascii?Q?hRsFefE/+QweMNsmk9P7lbd5tFhiSigYArlgq57fEbxmPdWpMrs5eX9wSPix?=
 =?us-ascii?Q?Jdvyt3/M6yUoEMCyicYlubYRupsxaCfLUOx/QNS0fsPAY2RzGGGDQmWE+BIG?=
 =?us-ascii?Q?HcUSiwKbADR9FLhQjzkBsGIPkySzjAMoYjqms9mtQ1V3CD49Fa08+YyBdx5J?=
 =?us-ascii?Q?qP7QjFGIdODYJ5BtTC3la/mqDjkGK7GHYtfIoyqiGQ5m6nSSt/PB4l94HMMb?=
 =?us-ascii?Q?18JB/KO3hwX+uHbHWEW+uQ69gIw/LUlUKUaSD/S7mh+ad+5DzdRZ7eYewoB6?=
 =?us-ascii?Q?lyMgnuiobdMaqQq4NpbMl8S/xelTMatVwvmEPJrT9Hd7nsTixfYpqlu5K/aB?=
 =?us-ascii?Q?4jsvA22jC2uMnvKitSheZ3Aih2xnjCI+vn8g1pf7XleF7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?As4rWfdmH5Szb0T+YAGy3AiNgxPAr7WfgRRyiwY5XtFbZBWIPyhtW9kfWiXO?=
 =?us-ascii?Q?Mr4GIhmg6aPbiNX4fwZxqv59AAhMzurrgOwn6u1kX/6bYYN9Gzo0s/rkN22j?=
 =?us-ascii?Q?01oUFG6OlcSxl9IzGME9W/GBCy/xrdqVohlz7TCfdvhpXnrd+Nxit0ynqVnI?=
 =?us-ascii?Q?1b/WPRDYZyYoXQCjDTHMiJUkEiDh5l4XJJbh++IDGhdt3MAjYVcR0WEdYHQC?=
 =?us-ascii?Q?LIiEQ+gTsmH3xsoQU8lI+aRCfo5JIerRIigJJSNKhNG60mfhh7Xp8EcfPRs5?=
 =?us-ascii?Q?TRqjmyLymgQkJzwrhp38gSvAV5AqpsaLSyaAlL1L2atZMgRZIs/JXNZMF2LA?=
 =?us-ascii?Q?CGXUBtMRXaYhg/jF/LOB9ApCsKvDGzEpf8mMw3gVugi0rpxK+l94CzWNnK6Q?=
 =?us-ascii?Q?oYXWdjfu2AuM4e/HZH0jtiaoPDJTAcDEVq6Beeiqmj6CMxuxnmNZKY9mmeV3?=
 =?us-ascii?Q?H7ftkkNZ4+kpKkdzoPQzlPEfxF6crmtTQNHkGP7WsYcajOE8cCBmhSApIm0j?=
 =?us-ascii?Q?qTZcgR7bHs7CB8Hwh62jfJuOvc6AyefE3Mr5bRgAkzRxpY6cyI1YOttcItHL?=
 =?us-ascii?Q?RYMf89WlvghgYQXFTc3WoFVbxpCQlRoy3Qll1aQP9BGm4U0RWxAMZEJ67uWB?=
 =?us-ascii?Q?mDWy/3bG3fYntXu5C0eDsUTb51X9056sLa6O9DK8qclNmwKziRuA60a9y8lj?=
 =?us-ascii?Q?bEQSQKElJYnbTzNya2VYapN3JLu44dU8gg8Mba87N1LQssQKAOUgUTaPMuVc?=
 =?us-ascii?Q?V7Yn3qMZo/KysXZfqi2VGFk9Ze3osqmMWpyUF8qPho3d6psB8GSBxHN1dMyj?=
 =?us-ascii?Q?jz02lXI34S76Uh6nHKZctNsN8dFJ+NzCgAE1UkUwcFTC/JWNXJ1yhG02M3RG?=
 =?us-ascii?Q?TrkzoNUyllLO5L6KI4n3xAjze8ST4OX2UNVCXYPvP1rIMxJQcx/j7l5bMzOt?=
 =?us-ascii?Q?zCGpvPYU6W3oXzblRciHfdlarCKWaKy+yYVAF6+INAaLMqo2bnWzrTUjvb33?=
 =?us-ascii?Q?Ng91ysweYOoyvHqXilYbpZBzlMktNsUui7MnZhozWV6CWxVQvUPRaL/AghjW?=
 =?us-ascii?Q?0DK5AutwU/1MVWIQ2HZ2tY0bSVol74HBLgzzvPuQbeABhNhg4/fQKDi/zkK3?=
 =?us-ascii?Q?dkWDvCFnsxNKT8zvbP6JWUqIRXbAFjTHSFVxOFQEAKUH487uGaz5eoKleOHb?=
 =?us-ascii?Q?iy4AyG+ZCHwcLXoIVSvmkqez7hhZf8WbGndEySujcLQjTC0EJW1CnPdNy+el?=
 =?us-ascii?Q?Zy3yhtmJ208jQO6Qp/a20nTDZyRXx6qHlkBtFPZ2lbivhgOMZ6l+fpYkP532?=
 =?us-ascii?Q?VygOQOM35P/RSFhzzK2vgJFoE2/E2o423tdHp1NsAMwMi2/z28xvzlcn7KNf?=
 =?us-ascii?Q?atUZ6pc0VGK23YUkj8+o9dZNKNVgeeUzyKeaojL+1w/702CnAKVW924eQG4B?=
 =?us-ascii?Q?6xgbfdSidbJOKfaYk3e4TL35s9RsdSEgbxlsoaXxo5RIT1L5WPRniieYrwtW?=
 =?us-ascii?Q?G7K6f8EgnoTJsIw7Sw+VAQUutJukrZmcDIqgw+/6rTzUZmq+JXU0tEN1b3W7?=
 =?us-ascii?Q?nXXh1UKvXiOUgHG0mwA4l9wo5At8v2fwSebXLu5kB514Nj2E0IMbCkCuiDB9?=
 =?us-ascii?Q?cBH4do0+j3talkFUlZTorVfvXjCblEyu7GFdxthlLMu4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1998d713-97a0-4964-a6c1-08dcb8585c67
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:48:02.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVKJN+bkww5Bst7jzEASm75AIksW1n6it7v4ugLSfZC5Dz4PU1m8E5cT9VpdSLaOdHRD3AOWkGAPCZtuBEo9ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

---
 drivers/net/wireless/nxp/nxpwifi/wmm.h | 78 ++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/wmm.h b/drivers/net/wireless/nxp/nxpwifi/wmm.h
new file mode 100644
index 000000000000..fc9bbb989144
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/wmm.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: WMM
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_WMM_H_
+#define _NXPWIFI_WMM_H_
+
+enum ieee_types_wmm_aciaifsn_bitmasks {
+	NXPWIFI_AIFSN = (BIT(0) | BIT(1) | BIT(2) | BIT(3)),
+	NXPWIFI_ACM = BIT(4),
+	NXPWIFI_ACI = (BIT(5) | BIT(6)),
+};
+
+enum ieee_types_wmm_ecw_bitmasks {
+	NXPWIFI_ECW_MIN = (BIT(0) | BIT(1) | BIT(2) | BIT(3)),
+	NXPWIFI_ECW_MAX = (BIT(4) | BIT(5) | BIT(6) | BIT(7)),
+};
+
+extern const u16 nxpwifi_1d_to_wmm_queue[];
+extern const u8 tos_to_tid_inv[];
+
+/* This function retrieves the TID of the given RA list.
+ */
+static inline int
+nxpwifi_get_tid(struct nxpwifi_ra_list_tbl *ptr)
+{
+	struct sk_buff *skb;
+
+	if (skb_queue_empty(&ptr->skb_head))
+		return 0;
+
+	skb = skb_peek(&ptr->skb_head);
+
+	return skb->priority;
+}
+
+void nxpwifi_wmm_add_buf_txqueue(struct nxpwifi_private *priv,
+				 struct sk_buff *skb);
+void nxpwifi_wmm_add_buf_bypass_txqueue(struct nxpwifi_private *priv,
+					struct sk_buff *skb);
+void nxpwifi_ralist_add(struct nxpwifi_private *priv, const u8 *ra);
+void nxpwifi_rotate_priolists(struct nxpwifi_private *priv,
+			      struct nxpwifi_ra_list_tbl *ra, int tid);
+
+bool nxpwifi_wmm_lists_empty(struct nxpwifi_adapter *adapter);
+bool nxpwifi_bypass_txlist_empty(struct nxpwifi_adapter *adapter);
+void nxpwifi_wmm_process_tx(struct nxpwifi_adapter *adapter);
+void nxpwifi_process_bypass_tx(struct nxpwifi_adapter *adapter);
+bool nxpwifi_is_ralist_valid(struct nxpwifi_private *priv,
+			     struct nxpwifi_ra_list_tbl *ra_list, int tid);
+
+u8 nxpwifi_wmm_compute_drv_pkt_delay(struct nxpwifi_private *priv,
+				     const struct sk_buff *skb);
+void nxpwifi_wmm_init(struct nxpwifi_adapter *adapter);
+
+u32 nxpwifi_wmm_process_association_req(struct nxpwifi_private *priv,
+					u8 **assoc_buf,
+					struct ieee80211_wmm_param_ie *wmmie,
+					struct ieee80211_ht_cap *htcap);
+
+void nxpwifi_wmm_setup_queue_priorities(struct nxpwifi_private *priv,
+					struct ieee80211_wmm_param_ie *wmm_ie);
+void nxpwifi_wmm_setup_ac_downgrade(struct nxpwifi_private *priv);
+int nxpwifi_ret_wmm_get_status(struct nxpwifi_private *priv,
+			       const struct host_cmd_ds_command *resp);
+struct nxpwifi_ra_list_tbl *
+nxpwifi_wmm_get_queue_raptr(struct nxpwifi_private *priv, u8 tid,
+			    const u8 *ra_addr);
+u8 nxpwifi_wmm_downgrade_tid(struct nxpwifi_private *priv, u32 tid);
+void nxpwifi_update_ralist_tx_pause(struct nxpwifi_private *priv, u8 *mac,
+				    u8 tx_pause);
+
+struct nxpwifi_ra_list_tbl *nxpwifi_wmm_get_ralist_node(struct nxpwifi_private
+					*priv, u8 tid, const u8 *ra_addr);
+#endif /* !_NXPWIFI_WMM_H_ */
-- 
2.34.1


