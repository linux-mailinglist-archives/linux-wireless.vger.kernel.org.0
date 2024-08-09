Return-Path: <linux-wireless+bounces-11215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623494CDD2
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B3E1C21F62
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4796D19D8BC;
	Fri,  9 Aug 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZHmh+6fu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED019D89A;
	Fri,  9 Aug 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196882; cv=fail; b=cKUesZWWXsgvewv2L5CJ7/qjjPXYwVTY7tdRcq+8yhG7xYK0DU2VsqeBGKvYWNqKsFFf3z3X9qOd1QOq8XCdra04jLdaovzjrYOH9TOu2XTShitwAdYMG55fw2WDn1E98gzM2H1FegD4RvrwJdZ3RdbByT4zJlutIS/ToJbnlco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196882; c=relaxed/simple;
	bh=tp90pHiNnFMTZUCcpw6Id7ktOM6NLbgvG3kpHZqpjKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtqV+KPaG5TO6s1AfQ48CjTXYqP5eJfMH+xWLwhw49Q449ljiMmSqxPbc+EqOAzkkYBDbwqvtX5D6zu2efp0+hGUgS2CFo6KQBq1LE3GkdEBSqPiliUInaG/0pqBJJH8byHjGrVOIOCxRNtfNmsctILHolrWoQ1Z09oAJ5nzB7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZHmh+6fu; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNzcV0ZDQf8Gk1h1ZTYoJNPGYzxmJVXkd0RS76jyBblOz5GcFKk4UwxxOwNBfb/wVW0yIazj3v+fREtiVQy+mLbuYd0vjWI7OzeXx0NENEktjDLLlAb4KKLieW4mPqe5zqt7DWyZaxw+pxvkfZyrtjtHHmEeRztuKIuJ6m3IXQCm+E8ZcgIHvPC+kjreKHxESyrYGgIYXbvgXUQ14z/yEyMwuF5PHVcUYdw//AfFXeKE99VG0Z2Q0pwbSiRIzwv50hoIGlzoxdYavnIVtBGzqBGrUePIkY8aQw89vJl/q54BKKP5lWuPivM0+TdQWqHkOHZXXfbFxXhygpa6NFqB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2511BHSxmECGkDmV0EyIawAlQqTep7qT0n8dj1bwGA=;
 b=ObYT5VM5RdwQFZ+edvzL7f06wutQjZ+TlXuPvCxUD258b5p29Gv5UEvih9ueRtWihbS1L837jQGoVXgk2D1CJfPAKd+GJhIEwChxvozaVoCYvYbstDcFQBczecKm9YOPXOM2244fVmgIz/3rwnvE1P37hqOvU9H/eHLkY/h6vgAwvRdndDKM8ChWbpJIg68DeqK858MPJtb+6MCd1AKSZ0vAVXfPEC7/NhED0PYKfLWDVhrd4QvlfAAzJFw/Y7ehyvIbeWsyxHfxF7hyMfIwmqO1VdpIoGWLfzkfFdR9V9rAh5KIR7+Y56TTYuUZsl8PWCbrW3sDgSjub70OYUXQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2511BHSxmECGkDmV0EyIawAlQqTep7qT0n8dj1bwGA=;
 b=ZHmh+6fuLF3pa+SJPwIWtqG0gxaM+v2gjT11Z6VdarCyaaCT+ea8VB4RexuxmRqNyTB0CMcI0iajC3fUDgDCL6/nQwmpavRdudg4x6VTEPuhzhReVQPuhAzm9cCc1P1KrXPWrqW96bTE6Q+vjX0fa8TyFmeMRurPcDjOb7O3eaQncalHnzyz/L/xPbAgmE3jgmVss9jHMluAGD9e++6lxKgYC22gIixn0KrLx8fSBClXLPytoBCKtYxCMELZUNTWyPyCbDRJUI/RbqN0hmfNwjK1ycCrCBVHW5AXPmddcwBUW8IGce4zrt4UG3bThF5Dc/+qr9b+TvNrEvSKscC3lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:56 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:56 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 38/43] wifi: nxpwifi: add util.h
Date: Fri,  9 Aug 2024 17:45:28 +0800
Message-Id: <20240809094533.1660-39-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58692884-7026-48ac-894d-08dcb85858a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W8uQPXCwGht2D55YSSc5xERtKawSOkZAWmqyYIsLlPOmmEoju180q8wAc+jH?=
 =?us-ascii?Q?uNk35i93OnOeVvd5O9uWoZLhokczEcX9NvKKP+dZpAD2YkQfryhe9SYWO99g?=
 =?us-ascii?Q?GFlmGL7B9O1GotXbH+6liylxDOs1LLa5eUrb55xOe92gprc+lf37Ruf7oxd3?=
 =?us-ascii?Q?qXb+V+3jvHRJlixL3pR4HgSdUBYBZalHpGAAhR4kDtgZWGg04jyQvQ5vlb9Y?=
 =?us-ascii?Q?D5BfEhruTVCN2I3pD5S0FACrgXvEfPr6o3UpGph3D1jZpsgyiBT4pafPD4H9?=
 =?us-ascii?Q?ekU502zcKPe36J1EXQ6mdIkwEKkG+z3IIeXK4jA98jmLJi5Y3BP+q/tvk8Wc?=
 =?us-ascii?Q?jYpwHGj/A0e4hHiFay7tT0VyyBTZ11XNdgbu/Yam9o7+bj68Xp9QBLMbctwg?=
 =?us-ascii?Q?NRdztPBaF2ehbpFZtLemvjOK43hxsBKux5gCsxMJhVwDW+JSyLq7QcwPn/mF?=
 =?us-ascii?Q?PVzXTb8b/ufOO4nBGn70gzXp7zZHvmGGJiqI2KV3r4vVs28CH1zOJN8POwJP?=
 =?us-ascii?Q?bG6Xuc8V/99cFU5R2Nlp0jq+gE++FQGmsZne4bVPYgqSBALYYghEEpBL20UE?=
 =?us-ascii?Q?vq0B9y8sQR4WSITYzLJ+eQXoraZh24aavu1u0GUnKEyp0BGpp50uT/vUSv3x?=
 =?us-ascii?Q?TsvCa8SlNVfJtQygLhMiFEz/AQF6fSppt2x8ayQhEpb3pjqjmb/2Q1wpDqqv?=
 =?us-ascii?Q?ZXeTG4fOd4rzZoXkl2Mb0ntTvIf2jiQfsbLgtirmyJHCWgwX3A2mei/Wnvcj?=
 =?us-ascii?Q?kF0LEY7N0NBBu55XfdMmHdiliUd8emEOdQc635QtuATYT+FDe/F7A4leqX/e?=
 =?us-ascii?Q?loMM4BnxCVqx4Hnn7ynyGi3q4E7WNqM5lgdP3OAUO06kL1XsUqum8fm2Ok27?=
 =?us-ascii?Q?biQU0tI0O2tYv+YUxiYpk1JWdopZJaNsGgJ3r5IZlSkwwfLk5OIjeNmGoixq?=
 =?us-ascii?Q?KH9MTkGlm9vZ/B1ZYuhVPvMieMVTuuJjUSKeBoqB64+C2k0meWz0Jp1D2Umu?=
 =?us-ascii?Q?eWNzC8usCCIyO7vpQrZUpOm4yXL6F3dwcUGzxBRIEZDDPRCZtFcA3Wel3TTn?=
 =?us-ascii?Q?T5ce5ZVGYB4iR3exyy65CszWAs6p0QinVS1eG0VIgpnvtRarKKXmI0LiYMy9?=
 =?us-ascii?Q?dSZRuEY1178FMhFwP6T0QRKtwHKHkpclk/MFERp6IHAXeVqkY6WPOSVt8KEE?=
 =?us-ascii?Q?Y6OCmlxTT5+BIk1UEZCJChPe/708KlsrNTP1VneOiYrNttYeeR4nVQ3cjfcX?=
 =?us-ascii?Q?OkJIvb9ojGL7La7VwA66Eztx8HadrXURfxYXA4ov9vTcWKSinxfgOLn0IG6Z?=
 =?us-ascii?Q?M+lUYOBOPa2Zui02jUvvahzDo9inWJhZcekSEstdXc6oYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3ZS0JFu/ISHdTbMURZhCdFPRQ8gPldSnKBAYj6jsGMOn/WbQTkfA9T4fmrH?=
 =?us-ascii?Q?j6bfrPBku5TXC0jrj4PuEUXKWR7fzYQ5RMIZy1PxgpHKnXfAwlgtxnLl1R3d?=
 =?us-ascii?Q?bSgER57l1KiFlydtig91fONGKLWAUvg0M4Uh5nx0G2AsWe5xnGVLflAPLI2n?=
 =?us-ascii?Q?WoQ8mHbHydgP1omVoxcntRqlxtdoKm3620zov7YoGamJellLG35wnsLxWih2?=
 =?us-ascii?Q?rGVYSGJE24dG43aBPOqCmA64wOq1aM7cjibbh1XTZTbgkIVQ5nu4sOWZObHw?=
 =?us-ascii?Q?M1PDYjr3gheokcLVU6J/dtFRa/ZfVwh4wW5UBx3Y3xUYxxtEuSuvdTZsu/Qz?=
 =?us-ascii?Q?BIxElHIVYWLbWSP1bPIJ2ZKy1icrIVLAMz2Oipty5d8meLxm0/V5UnDV7/cQ?=
 =?us-ascii?Q?nlbwPFrHwxYtpMGbAPbXB+gwtGQWkKV2JEvRJyUlnhUCCzv2RlWNKfWswtqN?=
 =?us-ascii?Q?II7LZBrNyMkz9otkvHV2bUqswet4hGP/3Zv8q9to6MAwutyL3fqPLeUoJ+ZK?=
 =?us-ascii?Q?H6ixFrfWPkhdn8Gugt6kvdT42166725pcAKQF6uOqZhFdoFmP63YdJvsQhdP?=
 =?us-ascii?Q?a0Teywo1Na3PGJgOuVyPMDPAInmqIcOkBQgA+xNncVVf/MgWjzeNRWcszWIT?=
 =?us-ascii?Q?9h9fSiLiROHKgpwRqYmEq1Dv4uqw7FJkX8br/axxR5gfp+1NxI/fbzU2HZAC?=
 =?us-ascii?Q?X0PVfZtkpb6FSlVA9myIJ3hvIpOOAsqJKV9EW3w95tY9wXMl0+ij7N2iiyJh?=
 =?us-ascii?Q?e5GJFWN9mJVsSVPRH/aIr464hC3D1AJyc3+p8yFTgxDX8dIXAhGZ9ygZKmjk?=
 =?us-ascii?Q?8KPwGmEdMs11UU1YXc7BPRm8GxndjwyEFJS2BpVUkmJdnl0v25syVitaAJ7G?=
 =?us-ascii?Q?cn8K6X6HoFziRCzN87IUAb3D2QRl/3Oy9JH9FjM69Ti50Uv8iuslaaAS7ots?=
 =?us-ascii?Q?mQH1l/xnMUVfbCjZSfBO00TbuPa4Fuu2Vw3H7V7CHj2aNxBlHKlxb9HIC6aU?=
 =?us-ascii?Q?JJPygsVeMdFiu6Otoh1T9yUI/f9b1LuLD4Xf8sG64ioYgiRdkO8OY8lPYx4s?=
 =?us-ascii?Q?D7f9v2R26lmwyXERax3N3XpwlpdlXDytKdRKB41hP0ilH5/nNq4OLgdHyva5?=
 =?us-ascii?Q?zGhvuzc37enuzaPtBzgvHOfhfaY/P1K6aMHntQBGpMIF6oEebqkKcNLqorkN?=
 =?us-ascii?Q?vuPrP+nRoOam1dAgx7pGXikiSnCmmdn9+exJw+/oNW72SdmyHS0BVIB23nqb?=
 =?us-ascii?Q?gJMQi7xbq/xbdlAaheRzmGmEG1ulcHAToNZUZecCnongeu/WJdOg6phERMNY?=
 =?us-ascii?Q?Z95zmfwuwir75X3aBzhjPnuek97s0X/agYADPDCnY9UxXHTlasuJY+zHPmKR?=
 =?us-ascii?Q?dVoKKmZKvsG/YlcptKfQqpL/wPZuvvRKNiD2ni9nlxEt9ut+iIJ8jDH+hbGR?=
 =?us-ascii?Q?MmwXeo+Etv3MXhv0QyyCYwgta6iXTrtWABwnONYYu6x+EDM/Gai2e7t3Bt/N?=
 =?us-ascii?Q?2JPU6nCX4v1+O163k0AFNgzYeVBOBbF81Fjb6jzSPzG1hW4aPWdYR/E3QfCC?=
 =?us-ascii?Q?4u95mWZvZFdPp6Uf8XVZ/PL/Aj05yFKoJHhVAc1/L7q9sYCZ2S8was78Dwof?=
 =?us-ascii?Q?oP6mlAhmxSvZglnimgvtSwS/siVJ6vcDP23RoYS2DSaT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58692884-7026-48ac-894d-08dcb85858a5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:56.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76WaYXBbSKnKQWafrgRtfS7LMIdcoj0kSHPUdg44H+iOEolaOwR9HkKwQWyukWeelkKbOj2vbcjV6ggAMKi3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

---
 drivers/net/wireless/nxp/nxpwifi/util.h | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/util.h b/drivers/net/wireless/nxp/nxpwifi/util.h
new file mode 100644
index 000000000000..17089c673f3a
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/util.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: utility functions
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_UTIL_H_
+#define _NXPWIFI_UTIL_H_
+
+struct nxpwifi_adapter;
+
+struct nxpwifi_private;
+
+struct nxpwifi_dma_mapping {
+	dma_addr_t addr;
+	size_t len;
+};
+
+struct nxpwifi_cb {
+	struct nxpwifi_dma_mapping dma_mapping;
+	union {
+		struct nxpwifi_rxinfo rx_info;
+		struct nxpwifi_txinfo tx_info;
+	};
+};
+
+/* size/addr for nxpwifi_debug_info */
+#define item_size(n)		(sizeof_field(struct nxpwifi_debug_info, n))
+#define item_addr(n)		(offsetof(struct nxpwifi_debug_info, n))
+
+/* size/addr for struct nxpwifi_adapter */
+#define adapter_item_size(n)	(sizeof_field(struct nxpwifi_adapter, n))
+#define adapter_item_addr(n)	(offsetof(struct nxpwifi_adapter, n))
+
+struct nxpwifi_debug_data {
+	char name[32];		/* variable/array name */
+	u32 size;		/* size of the variable/array */
+	size_t addr;		/* address of the variable/array */
+	int num;		/* number of variables in an array */
+};
+
+static inline struct nxpwifi_rxinfo *NXPWIFI_SKB_RXCB(struct sk_buff *skb)
+{
+	struct nxpwifi_cb *cb = (struct nxpwifi_cb *)skb->cb;
+
+	BUILD_BUG_ON(sizeof(struct nxpwifi_cb) > sizeof(skb->cb));
+	return &cb->rx_info;
+}
+
+static inline struct nxpwifi_txinfo *NXPWIFI_SKB_TXCB(struct sk_buff *skb)
+{
+	struct nxpwifi_cb *cb = (struct nxpwifi_cb *)skb->cb;
+
+	return &cb->tx_info;
+}
+
+static inline void nxpwifi_store_mapping(struct sk_buff *skb,
+					 struct nxpwifi_dma_mapping *mapping)
+{
+	struct nxpwifi_cb *cb = (struct nxpwifi_cb *)skb->cb;
+
+	memcpy(&cb->dma_mapping, mapping, sizeof(*mapping));
+}
+
+static inline void nxpwifi_get_mapping(struct sk_buff *skb,
+				       struct nxpwifi_dma_mapping *mapping)
+{
+	struct nxpwifi_cb *cb = (struct nxpwifi_cb *)skb->cb;
+
+	memcpy(mapping, &cb->dma_mapping, sizeof(*mapping));
+}
+
+static inline dma_addr_t NXPWIFI_SKB_DMA_ADDR(struct sk_buff *skb)
+{
+	struct nxpwifi_dma_mapping mapping;
+
+	nxpwifi_get_mapping(skb, &mapping);
+
+	return mapping.addr;
+}
+
+int nxpwifi_debug_info_to_buffer(struct nxpwifi_private *priv, char *buf,
+				 struct nxpwifi_debug_info *info);
+
+static inline void le16_unaligned_add_cpu(__le16 *var, u16 val)
+{
+	put_unaligned_le16(get_unaligned_le16(var) + val, var);
+}
+
+int nxpwifi_append_data_tlv(u16 id, u8 *data, int len, u8 *pos, u8 *cmd_end);
+
+int nxpwifi_download_vdll_block(struct nxpwifi_adapter *adapter,
+				u8 *block, u16 block_len);
+
+int nxpwifi_process_vdll_event(struct nxpwifi_private *priv,
+			       struct sk_buff *skb);
+
+u64 nxpwifi_roc_cookie(struct nxpwifi_adapter *adapter);
+
+void nxpwifi_queue_work(struct nxpwifi_adapter *adapter,
+			struct work_struct *work);
+
+void nxpwifi_queue_delayed_work(struct nxpwifi_adapter *adapter,
+				struct delayed_work *dwork,
+				unsigned long delay);
+
+#endif /* !_NXPWIFI_UTIL_H_ */
-- 
2.34.1


