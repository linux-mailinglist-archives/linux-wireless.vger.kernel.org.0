Return-Path: <linux-wireless+bounces-11185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6294CD94
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBDA1C219D5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F71946D1;
	Fri,  9 Aug 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V4HgpJie"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013064.outbound.protection.outlook.com [52.101.67.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207C1946B0;
	Fri,  9 Aug 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196786; cv=fail; b=RsnuwvPFXXeGGiNYBgeK0zikwEyyhouJ1P1swkNZSZMzk4mctOXUT6RPaKcUZ3sx7eFQnk1ISaE4iqYK2oYELi8bDIP4/pDhBCmVU/4xzM0KtuJH8e9/2Bncy7YLwakAnhX1udb+F386lLWGvaceSeDomGsb+MhKHWbebS8+gfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196786; c=relaxed/simple;
	bh=0CNz/25GMEbYYcYQxFZMmI2LMbIHPk/SDKijvl7H7ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLaQTaimMKYgQ5xiMUG8zIgMhzSQN42wwJ56p3pYz9qDM8oAlPerklw13lg12R9XXgh+fiKlBBtKOPdEbMO6NHvUUSCTGowSuFg0CZDIJU3D8ZrtKdZOIU+sSbXdIv0gSNmpddTb1xBw1T1tG45gF2IcYsfnSuSPtzzXOZ1xySw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V4HgpJie; arc=fail smtp.client-ip=52.101.67.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j31oXp1EHB0NpFv3KFnWv3MuOgIGKK1Z2u6pUrJqqtoyJoJgZkwrGYvvT6/urM+MlA69BAYQVi1iBjo+nOJAwot88Gqy7/pUJvmjxEq2fjT2hFkShbja7paI4AxyEqkb1gy4Nc+tPgFLInNHWHj9FhqVmYwoRvN9biSj/xzNxZ9Cd+H7rtckPfzK8wUf8qvocQVO7Xjv4xXIu4zG2jXbfxdsUV82QaHSOXDIN5uY4iIhJAsGyJEznRkNI0mbQvM2+8IuYHstNDL7Ht6Qofu5kAwNvPRzHl9n8XJflt31cx2oWIpnI5yORYEEBRPTkt9zS5cCYZrcS7Cnepw2hfEbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2DXrpx9hmOlKQwsxF0BPP2XgillHI6sHEcm28UpmPo=;
 b=R9XeDCh1eFUrpAC8j0N4ThLdS25KYVNeKfnOCCAh9GEyO2Oezq2U5rp5UmTbh2lSHTBnM3u1fkdGi+sd7UwG2Ea5KNHARyo8yvRqVxyfmYuioSOxkPQqdhbs3rq1h3Ysc2ALbK3O0Tv+dB5bZ5u0tOzFCI0bZRXZs2T/f14eOosUHgohiyLuO2PtSk8QJG/B2MuosYLJsappwWJ7H6S4MhDyWmHPlrmWHKtPsNi0+k4WPZWEm/qRh8cGI2ERVX/Gkqc3Cza+fWIdtJxSdiI1ngameCDdsDXFzL5Nu5IWIlVpyXR4+zR5Lw6OeUKvDyUPfZcTNvMd3swmgJVt0iZn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2DXrpx9hmOlKQwsxF0BPP2XgillHI6sHEcm28UpmPo=;
 b=V4HgpJie310fFThknTLq6d/aD1nNh7zvimA3SvCikc6f7uLtql5HScpPyBBWDnkCBgMsI6qZnm82EBAfhzPwloDm/OizZRe/WS9zoqapaLNmsl7YImOBZjRSZz3+GaMOQB7xx9e22ky4F2jj7FcYatacs3J5Omfhm8ljBy2esnLkrXKKAPXb7V4ey70+eNErDYmNxkb3cqRR1tuXOulkdU+v+BzUEVfC4Jx88v0aXJPIQOtlQYIdQ0bIinLAnI8JcrlTZiR45w/VuYvxu9ivmV9Ys8nGjm72gzOPqDj3vJkKdL6rh70tyC+jORCuJXjz0DXORxwZzvSeYIHSBQfL+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:17 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:17 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 08/43] wifi: nxpwifi: add 11n_rxreorder.c
Date: Fri,  9 Aug 2024 17:44:58 +0800
Message-Id: <20240809094533.1660-9-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 38994b04-bec0-42ef-7893-08dcb8581dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?88jhYau1FLkjX3Hdb7RPrBTumypvtzLVbxU3CtizH4+ewgmYCbMitOX3tJ+P?=
 =?us-ascii?Q?3aW+Wt0nLjYFwKKHYvDvrFo+BmqHbyau3SxH44Pi80d7g6w1jJOw6zAOzocq?=
 =?us-ascii?Q?XO3pcWaio5wIF2ijkX8RogFIv7QjzfwAdOv5bUKKNGvN/guxhp10oKhyGKsG?=
 =?us-ascii?Q?PbJPMHlbSpR9xmGU40xsBNJ+ZBOGsfTnvkNlgE0t0dyqbjtHfClZXfl2lM3K?=
 =?us-ascii?Q?INZVXZcJH4l53LuKfrdB7uIea09JbsACqozQ7s/XVQN7ohN8WaKAUWiss8fA?=
 =?us-ascii?Q?IknhcdLH5EJemIJ3GpF0UxVXSSAFx2L6n+lQ1r+ZHtwUDeK62Qvx2Dd9y66m?=
 =?us-ascii?Q?+vSjNibWTlgJo/MyGlivHqkVQ7cyTgm8Ylszq2avXi2qOTsjk12nn2UjBod7?=
 =?us-ascii?Q?kxULOd+T5x5RPdCCmjdHty971yG4kVlemvmpevaotoPMhWO6O1WO5MzUBvyN?=
 =?us-ascii?Q?DoiHttTNu0wA5LeTUkXXhQuAz3CSnmpACrq/aIt+6vH34Hs8uL8LUzFftdUi?=
 =?us-ascii?Q?QMwZkzKHWBAMhbm1YQfC7CR4dmc43juzjXp3hPJPVS5Gn0rpY726NsMMra+s?=
 =?us-ascii?Q?+52KeaKbq2Vnqhm/ogz3tH4odh+4mKPDZj33W0YlWvW+9OsxBi1SwoHyHyRv?=
 =?us-ascii?Q?1wsiIx/Iy8RKnjCRU7emjDMDSloLIwMjaBj+KEQTD0SFLq1epopy4AWHg/tW?=
 =?us-ascii?Q?II3jGVYzRllbVoxtX4VqOrTNlyYEyh5Vi8SkTAjlZwOmxVbblVmsYYCdYBdk?=
 =?us-ascii?Q?hqDE0SvEfSzuCup9oKs2+2mhDi2Z1QbDMTz+nOezf3w06D1hxVEZsTNyGEb0?=
 =?us-ascii?Q?guWOCQ834ZU6Pj6xKop4mkYNp3VvbJWOWWg9X94a/OT7Yte+0WSSeG6UXlki?=
 =?us-ascii?Q?8lhMvWNtX1nbEGQRVR6c/ARXj6DdSpoWOdhJSvZWU3jAtNmHSDeVoaTSRX6j?=
 =?us-ascii?Q?xmP5mdL60JbkSWhZFY60vG/C6X7iAaCVMl6uimR2TJ0drA2ICz1rfkJ3mVMJ?=
 =?us-ascii?Q?dqgv589KBHKSdcHNuHSUOHCwwCU0J6dhI9RjY9ojE2n4xh9MkV92PpzUHvb5?=
 =?us-ascii?Q?/KREimDaG7ePTXY9VivOxIO4Fd2gPf8qz6u7pUwaq9jjx4I2BiwFMtHC7Bv4?=
 =?us-ascii?Q?F5o8GsNNV83nwnAcI8dgPDxyhyODPeJeGSYJFK/6GM1KJJRp27bIIpmhIt1+?=
 =?us-ascii?Q?qMTygZCgBFkJzJfLv3VhEH0OnzARJsxJRUj65G+o8/z30ySYy0bcpSvspW/1?=
 =?us-ascii?Q?eH8AsUaMtj47AU3/RWVIqKIZJgCeI8/S3TLrIP8JqZghmGA9yVWBjuERcXbl?=
 =?us-ascii?Q?02kj4QLKm5yo6K+e0IT1+TDAv7QMt90DIPuD6uafJTkS/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wmWkmjwR+10DkQFXpyHZRSXEuzzsHEM6X1fSP0gGRa1NULAr1LovU7KqH6KP?=
 =?us-ascii?Q?hshPYttVwSFvnnIMpVL7mSc32eE6J3gb5O1RPYTaOYb7b0MBhI8pQySOdpoJ?=
 =?us-ascii?Q?haE3JgHfyjOcQUjlPXhjV2A15JmsK3YQUrziCpqKwTS/JMMIDRfUV2I2DawC?=
 =?us-ascii?Q?hQRJI4X0bWUyi9AoFOqryS8Kj44e/z32qnIbp2xAZJHCozts1TuBeLHkqsTp?=
 =?us-ascii?Q?qrP9r5e995VBjSrex7oS3u4bV3IeWGbS6ZZtNeC1SQHIMF/FZGd/Vle2GyS/?=
 =?us-ascii?Q?53NaWmDcyJJnsRlhuHPUC+iS2svWQ31Rz0o3xR6VQkdCBwX/fPvZbUug+2Qd?=
 =?us-ascii?Q?Ixzm454qvuNsIQozSfJs9n1Y697Xx0XPaYMrf5q97HnouPHh+l1cjU4yZRPj?=
 =?us-ascii?Q?172OdfAtauw1A9ivasrTQdKMqkypfTlSfL6qeKj5OQBLkfZQC+a3CXRK+YZo?=
 =?us-ascii?Q?c0dOQvNjxGYzHaiLIS1QBG0kwNEMcPfGT/+UEkA/1CeHWfTqxD4ARDejmDQq?=
 =?us-ascii?Q?BhFvP9gZLJiM5pjWLrXqkRQjW44nnKQ/R3gVgxWJduYtpXk1cAvFj+CUlhrf?=
 =?us-ascii?Q?ggkXo1UoKNliqgHAyheh3xaHH0b4DbIXgiDNxF9CF+oruSSq9ZOk0RAlgbyk?=
 =?us-ascii?Q?5oHmHDuCOdjaz829CVlutFed7Achec/FB1jDilCRuphTluWs4UZABj2ynKf/?=
 =?us-ascii?Q?hDd+3W84N08HVY3ZR/y+hWHnGbG7qWFfAXdqKy2xuYVFSG9uKaSltkz5r9Tg?=
 =?us-ascii?Q?edu7FUzmjSiuVIxnKmJJ/BJOTyNtounA5VY7v4nxU75B9EFOU9bOl7QsoZHB?=
 =?us-ascii?Q?usoDEl2oxczdGUC8d3RvMTKrj3GT8Qwd/c9jq1uPslXsypIdEfL1YfbJsNIm?=
 =?us-ascii?Q?KQAsueeY+GY6hcgVPgFmE7ZXB81AnULzPSc/jtHuYsEIsHbuf1s5gheJhtAR?=
 =?us-ascii?Q?WPjgKICemQE7xOZSbTtdB1xJsNBKts8IIqO3BW3J6pOiUnSs+ukx130MqP/J?=
 =?us-ascii?Q?H+FrR8soY715SHvaCnklkV5OCmEeiLhpaA1IpuPJfvjGemUHuNYjwej93ZgV?=
 =?us-ascii?Q?yVzbyYrPs7CHx+Lg/T3A/PQfjfRzubPl0m/oITnMdWs63AmJaHOvvL1SCgtw?=
 =?us-ascii?Q?+ZAlLFYW6p+zRhIFJsTmkSfV3n1VQQUEw5eRB1bc/JCOt1rOtccVK4uLCykW?=
 =?us-ascii?Q?ypFx/ctpKFD+3MQzw5XyZJOhbjfxZrvV3i1w26JV+eyNHu+8b7YgrlIIWPLy?=
 =?us-ascii?Q?bmNp3+tB8X2ghUxqmQjiAUBDMPrZuuTZh1756qI4OtyQxFZuO09FJ0Qg7lak?=
 =?us-ascii?Q?NMW0OdtmzaLZKuyR93+7XzkXoHt8xgIt4ouD7eJdi8KCoIvl8VyZtu+Tw36o?=
 =?us-ascii?Q?lB2W/6urM4KosmeyKng0Qq0doOZV890Vo97uKwjCbkPJEzIoRqaE9ks32cFO?=
 =?us-ascii?Q?jHezr0CsEzup2HuMFh9VJ7R+y4mgqad/ozeX2sSd35SZMI6Xx6Lp9psRumNw?=
 =?us-ascii?Q?tk8xrMvoQ5AL2KLFmRPIkgluuywi7yGLfPc6QQ+YxV/1Lu8Jwc5om5wy2drW?=
 =?us-ascii?Q?Yq2z/0zC+UhDu6Aipo+Mna9RY2CEPGyFEYEJb+uxmm7M3OyzxYtwcVxX3q9o?=
 =?us-ascii?Q?dkYTTSp1VSGd3Jfixp3mOfOBnrjv3KuX4/iLBHstDuKp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38994b04-bec0-42ef-7893-08dcb8581dac
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:17.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1g/fVQb+GWBeLxoVNzQywbI3VXNNeZpxPNe9iiWHurM/EBcxY/wA5eoTPeXy5SgpdQPHQxGonoEyVaZDWbqCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  | 917 ++++++++++++++++++
 1 file changed, 917 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
new file mode 100644
index 000000000000..f0407269942c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
@@ -0,0 +1,917 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11n RX Re-ordering
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
+					& IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK)
+					>> BLOCKACKPARAM_WINSIZE_POS;
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
+		add_ba_rsp->peer_mac_addr, tid, add_ba_rsp->ssn, win_size);
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
+		if (!priv)
+			continue;
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
+		if (!adapter->priv[i])
+			continue;
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
+					adapter->coex_rx_win_size;
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
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+			if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) {
+				if (priv->media_connected)
+					count++;
+			}
+			if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+				if (priv->bss_started)
+					count++;
+			}
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
-- 
2.34.1


