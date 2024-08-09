Return-Path: <linux-wireless+bounces-11213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8CF94CDCF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA98E1C21CE0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D619D093;
	Fri,  9 Aug 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F2MQ5LXQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179319D07A;
	Fri,  9 Aug 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196876; cv=fail; b=npQSgV5QGCJPYzW2Ux/Uy8m2eXJhMo+e4Gi9qv/EVXcdHYUTsmxPHC/0ZXik5D0Kf2SDABUuJ8S42xzsMMvqwnCUp9MXRhxnd8w4Ug0zv7fw0LQPkAGIpddSueDOAmhme4GpGKUHVZlcZSCsifkSJAdkSLEktHdXtGN0HLae4rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196876; c=relaxed/simple;
	bh=PJwWgNafYEvNChbAOajpS7VRK80Rd0RJvL+1bFodo78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bF1Na316cpcvXePMUbeMstvBDCVTyen+zcvEHfCmtDssKH11gwrbh+w6Z7aRc3C/Odx8Y2hlnoYttdAapRHBuxOqGd8MP2XZT+MCNNxZmE76rWO2f79Vb/LtODhM+ifukN/d73ch+VcaZGs8G7SmS2B0k622vn0pE1vjrOlwyXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F2MQ5LXQ; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyy4FKoTkHaRfbY0NWoKxaEn9fqB9Rqu64DkCbRovQGBV6vgYtduzmy5jskpk/42bRmi1Ld438vYP6OWq4f5MUmX+En63RScLTVBOw1WZBXq38byelMhkOfyetnmWuVpTAvz9b5f9GXMIaVMlgt6OWXYN387ohZqQ2tdWWkJ8ilGRT0mqnXZPUAfkka0n34JNDYTmZbfnzTlPtHj6yPNePGji0kwi53hJyiqkK0lVC+IHBoDr2XRzpD38Kd/f2usK27phxEPHX/syNClTIJVsLz4H+vpHHKAntQrfgIlSoZM2BlSrWlP4LZ5resNE1crt7uBkVq6/0+PY92B8U2RUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvPY5ptuBWJjuwawDhf/2mnTFwoF6mW0U43JF7OFyN8=;
 b=kUNsUBDiJAsvrRyjdFK9pjI5eyp5HefawnTup+Ju1RoxhqmLCCwuOjWVmEsPthZPRJTCfPatOioyohBm3+j92qM24AdL+NjFnop12iQHB/AK4kvKsypTNPKLAKfIdkjaoNwirtHZdRzwJq7OS9OPbcUMN/tlICQDwVBEr9KwSgjn88gFaHAaEoTVTJBU5KVVmd7P41MIunZA/RFI1uhInyB2ND7V5N6AuPv+ZjslhglYcpQmcRNYtV/RhS8GI04zVa9ZCWNJUNWHZW6KT8nRWP6ibpL/BSqyPvALdcS9jLIE5KVuqMU3TmusygR011uY579xxVwSKKMVSa9mLWrGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvPY5ptuBWJjuwawDhf/2mnTFwoF6mW0U43JF7OFyN8=;
 b=F2MQ5LXQiLSMXlbIsccguoHevGuPx4Y+6CWQEaJfncUClL2x5oqFgrjP7lGh1d6EhC3i0AsaQ2wTVE/z1WI2FII0/BR2FMrwouBVNk45S0uDi2mwiBcgdI0p7OVUJY+FzThQq7q3HzhWvGhu5D+YC4no1liOa9mCq06yNeugw1uhhAopKI/v3KuKz7c5zm2dAAjUqd9JrLtpemAUz2YrAiA1WBh2zc4qyPVselN/a/j2WWGcRppWVjYnlggTLmcROtfUtifpEfEhdEMa5EYZ+w3lWkfZUqvCUOIfT9mh/lbbCtC56D1RNqOIpzy00k4MzfXA6jg8zexa2Y3M1fFrig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:50 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:50 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 36/43] wifi: nxpwifi: add uap_txrx.c
Date: Fri,  9 Aug 2024 17:45:26 +0800
Message-Id: <20240809094533.1660-37-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a4a119a-fd33-4fee-2970-08dcb85854be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQLtWs/d0PHU3kR/40Y7r+u25RvExiAEkJef8xmVJalfeuDeLay4wmYNIpXt?=
 =?us-ascii?Q?gOQ+AqYQaXg2EKKuImpZv0XB6X5DeVS2ndGcsLVB6mRmyygFD1vetiqagclu?=
 =?us-ascii?Q?TmyR88/o6pn0vEWUVsgQ4/lAt+Vgm9p+AhEZKOXVjXL4DckZEqawrEot5GaR?=
 =?us-ascii?Q?Jfj0koztRaEd8nylMedhzWgLH3AvqDn21LovrlJg+XJVuk3TfbU35WduAKOd?=
 =?us-ascii?Q?crvRxw2wTtzS/lBXluv+tfhyfIX/xkYF0AnLf5fiU9ZwY8VVCI60FdiOXeDJ?=
 =?us-ascii?Q?kPpomOjKOA79sUzvyEedAjIH5fKFSxNhI1kU1WgwGkK3YsTFfRWe/LLyRakJ?=
 =?us-ascii?Q?u/jm1AjGmROGCPSok0T4fnozym3PT1W2lOhJMzExtu74lSizTFJKut4TBp88?=
 =?us-ascii?Q?kf13bwoMPvRocitYAyMYPmMoOpwmS0CAVa8Iqa5XO2D0+feiSfLjlOw7e1P2?=
 =?us-ascii?Q?H3w9lNrsxoe6L+VQWSNb/84QBtGP1YM1rwkvEndmgHfGrrgpWt83KDRehJBu?=
 =?us-ascii?Q?IJV1HLje43oG6sASxCOVL21AIHlszj5aL1f/Mo15uSAJcdBdRveOozSci2Ar?=
 =?us-ascii?Q?4g6Gce5lHR+kbY2r+jV/nAfd2BHMIBS4EVBLltcLqdwJdbKZy5cX/Wp4rdmH?=
 =?us-ascii?Q?ECUiUygLnYLCA+SUTe8QH+DBYZKzd2WRcX43MxYYMNnFYiH7uy+LBFnCOqQA?=
 =?us-ascii?Q?nkoUnhqI7rOBpLz8erwm+768z2qHB2cxqcFdD5QDYp29qvrhQsFoZyyUU7gI?=
 =?us-ascii?Q?AJIZb6hiyoQd4noV8GKntSgUh95n5GAUAeA2ZGTqilPbe44Bi+xVR82erGy/?=
 =?us-ascii?Q?VBdpNwyU5i4rWJcXTcjSPY7Y8vV3O5KOQUftxmDzT3w9HSGKehEwWFismcs1?=
 =?us-ascii?Q?Nw4uSmZ1bqo5IdIQdT9tI33Cn/QSyRqlodvpNChWHCU0jMpNkn2f++SDxfg0?=
 =?us-ascii?Q?sITkZQ0z9rG2EjAFFnA4qJ3EB1lWjUfYqRtrcWxG8WP48Pwbf2M8d4YagfYB?=
 =?us-ascii?Q?pGlNguCAdsa1j9GrMidcAg5H6eNjS6gTy/L2og1sgU+8dK3jQR04xzk1cxNA?=
 =?us-ascii?Q?oqaIzcjsKpYW/z9Ii5wP2qJm2Fo9t2Hw2Wjveq+eTSI5u+Efm2mOTVZbqBKh?=
 =?us-ascii?Q?E36P22hFhHUeAGrXwpZKEBwujQPL7qeZGlGSzMaAggIlWTeR1932VGa6r0M1?=
 =?us-ascii?Q?VDEFyBI88rClQqGFazRamTtaHKjMq9aLe41v5h3ND3GvVAK8bvyX+hXKwtGG?=
 =?us-ascii?Q?XchPG6SFwVO4P9tSv6Q4vRugftnnqapzcbfPigS5K/sOaHgj5RBb9YkYxyQa?=
 =?us-ascii?Q?6ETOowoLuFwYJ5jC+rRRebQV7v8CE5zFMZwPKJfya9McEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uw8dQR+uU7/QNcP+g6ZM2wktWw0qO5R3vSlWWni2Ljm2DVL4upoWesdJQ7C8?=
 =?us-ascii?Q?AyquomZ5UN7ClT/4HEx68kOWHG7bbFQxF+23gxpE5Wi2rS1q6hbP2Nlh2xm4?=
 =?us-ascii?Q?yuxA826OLjqg/1cA93GHpaMOQVJxStjtFsk2DDXnqrVcHpgT6aL2zhqvZkBh?=
 =?us-ascii?Q?z+hmfXeIrzsWIm+T7/nyI4cll9R0ruYSztqFhdMyffbRW1Tz0wOqbQVFr8gu?=
 =?us-ascii?Q?SAntg6aIRq3/6c0YLiwNIJwJIDJgzL62o2qyJuBKmq9Mc3lNQh9CUj9aIOdj?=
 =?us-ascii?Q?4Cvq+KneCiVtRtriN6bQBvwscuW8grA01uNhzTXYu4UcDjMDUohKraxKt3yn?=
 =?us-ascii?Q?NJF8APIPyc9uu4CUTU4DY8E8iW2oP3hnAqJpF3x2gpO9cO+AWhI662sU3h6R?=
 =?us-ascii?Q?G9huvynpYtbCAMN2zpfEdtFixwK6pucUCQoQ1iOBMWfMQL+ggyopcmEseFBh?=
 =?us-ascii?Q?5437wlgr+NNOuLMQEH3W3WqlQaK4cJgeiN2Dks2lbhsNNJfuY31u4KPT30ye?=
 =?us-ascii?Q?Xl+zNrqYxjvZshPmuQH4niBkARnciovnkrkNs/lWlq07gd6inVA5ve7CnUe3?=
 =?us-ascii?Q?wCiEZFVgNtYKZAADEU7sRdtJ110HB2/thNnXlNUB26dlrdD3+W50W4oSkCx9?=
 =?us-ascii?Q?tXWjQLGu31hjwMYBHPRS/DJWTnMIhZyVyJgkfaiQppREBQlRzSGZd5+X12qH?=
 =?us-ascii?Q?K9QnU5tBZY+eQU2vZ7cYgJtbymb7uFcuFS3H6bCJKisZGxB4VYLOtUV29W5a?=
 =?us-ascii?Q?0vBHe0aU+NhdDr4Pb0jqCb5WdRqxnv1wOrQYMPC3UcRRhz72guXK/z8354hF?=
 =?us-ascii?Q?CX37o3ndYujvL+CUJAriQZ37Uvu/s69fgW0GsdAbWdzJ3U47ggIkkEwQFDWH?=
 =?us-ascii?Q?HTwSf3a5rqTQacF5812XpxP8kiJtzvxPixho06JHR9Nen1LbwDyjy/KSyKCl?=
 =?us-ascii?Q?QXzr6JYPdIx5DNjq3QcxYe6YL6Xa6n81khM5p2oiKLnTWxYdQwgUSJrse0HD?=
 =?us-ascii?Q?pRAo24cwSpFF+WKozooJ+lFl20LE/FIdie5C1nFTpMUqoBh8QIHfp16lWFuU?=
 =?us-ascii?Q?TZ9waCfKZ2/3X1MbkIsaetfCLyQHll4CSYUUnD+d2eewTrvP+Q9f+TceXU78?=
 =?us-ascii?Q?x40V5LTniimJ5pifj1HJpakuwkAhUmDy7fX6csaUd8SCqnVx7yjblw+drZer?=
 =?us-ascii?Q?bl5vxF/GQ/MlLHWFoDRM9PEFjvJkqKW4kPcDI2Jk/CG/LQFolzyDwI6yYxVX?=
 =?us-ascii?Q?sZsV/VWb2QRkDK/99CODc/bqVMChbx/5diXQcVaVEpK1NlH7mznCSLTRydAJ?=
 =?us-ascii?Q?Ev5rFZWh6rcDPQSxWNYhQnjSjixfCHOx2jXR9jL2Ky9l1RNG6da8BlFrzcTl?=
 =?us-ascii?Q?ZTNwXf/8PADt4wdlIm4V+PQPoMkF9uUOzt7d2vm5kzi89dAJkhL0twZQHcNP?=
 =?us-ascii?Q?SJTyhNUMAWrU64v5oBqAH5fNITsX72AGjqapqq6OV8b6yhm1yzftOMjeT7ee?=
 =?us-ascii?Q?uqQeGUqN8m5LYWuFRjWvDnrg2UP4ADlzxZ39YrCuIFGaTCjrssNN6+5IDbJK?=
 =?us-ascii?Q?ljiKjDsbwtmD56957pgP9LKMoOnUvePNxteL2P84+AVwYuhlciU20jFGpZlF?=
 =?us-ascii?Q?mmeMnNg6QJW1FWu94nG7XiGkOq5W17NmvGpjPtSbAoqt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4a119a-fd33-4fee-2970-08dcb85854be
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:50.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmUwh1A32p10wPcoNxA1YZvtpo2P/51vrDj43ynbikgh6+kK/TGbCQNIBoF130wkUTHqLaC9gyFCc/vaFh5X0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

---
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c | 499 ++++++++++++++++++++
 1 file changed, 499 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
new file mode 100644
index 000000000000..b3a3d7cd9ce3
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP TX and RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "cfg.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/* This function checks if particular RA list has packets more than low bridge
+ * packet threshold and then deletes packet from this RA list.
+ * Function deletes packets from such RA list and returns true. If no such list
+ * is found, false is returned.
+ */
+static bool
+nxpwifi_uap_del_tx_pkts_in_ralist(struct nxpwifi_private *priv,
+				  struct list_head *ra_list_head,
+				  int tid)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+	struct sk_buff *skb, *tmp;
+	bool pkt_deleted = false;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	list_for_each_entry(ra_list, ra_list_head, list) {
+		if (skb_queue_empty(&ra_list->skb_head))
+			continue;
+
+		skb_queue_walk_safe(&ra_list->skb_head, skb, tmp) {
+			tx_info = NXPWIFI_SKB_TXCB(skb);
+			if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT) {
+				__skb_unlink(skb, &ra_list->skb_head);
+				nxpwifi_write_data_complete(adapter, skb, 0,
+							    -1);
+				if (ra_list->tx_paused)
+					priv->wmm.pkts_paused[tid]--;
+				else
+					atomic_dec(&priv->wmm.tx_pkts_queued);
+				pkt_deleted = true;
+			}
+			if ((atomic_read(&adapter->pending_bridged_pkts) <=
+					     NXPWIFI_BRIDGED_PKTS_THR_LOW))
+				break;
+		}
+	}
+
+	return pkt_deleted;
+}
+
+/* This function deletes packets from particular RA List. RA list index
+ * from which packets are deleted is preserved so that packets from next RA
+ * list are deleted upon subsequent call thus maintaining fairness.
+ */
+static void nxpwifi_uap_cleanup_tx_queues(struct nxpwifi_private *priv)
+{
+	struct list_head *ra_list;
+	int i;
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	for (i = 0; i < MAX_NUM_TID; i++, priv->del_list_idx++) {
+		if (priv->del_list_idx == MAX_NUM_TID)
+			priv->del_list_idx = 0;
+		ra_list = &priv->wmm.tid_tbl_ptr[priv->del_list_idx].ra_list;
+		if (nxpwifi_uap_del_tx_pkts_in_ralist(priv, ra_list, i)) {
+			priv->del_list_idx++;
+			break;
+		}
+	}
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+static void
+nxpwifi_uap_queue_bridged_pkt(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct sk_buff *new_skb;
+	struct nxpwifi_txinfo *tx_info;
+	int hdr_chop;
+	struct ethhdr *p_ethhdr;
+	struct nxpwifi_sta_node *src_node;
+	int index;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					     NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Tx: Bridge packet limit reached. Drop packet!\n");
+		kfree_skb(skb);
+		nxpwifi_uap_cleanup_tx_queues(priv);
+		return;
+	}
+
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		     sizeof(bridge_tunnel_header))) ||
+	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		     sizeof(rfc1042_header)) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX))) {
+		/* Replace the 803 header and rfc1042 header (llc/snap) with
+		 * an Ethernet II header, keep the src/dst and snap_type
+		 * (ethertype).
+		 *
+		 * The firmware only passes up SNAP frames converting all RX
+		 * data from 802.11 to 802.2/LLC/SNAP frames.
+		 *
+		 * To create the Ethernet II, just move the src, dst address
+		 * right before the snap_type.
+		 */
+		p_ethhdr = (struct ethhdr *)
+			((u8 *)(&rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+		memcpy(p_ethhdr->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(p_ethhdr->h_source));
+		memcpy(p_ethhdr->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(p_ethhdr->h_dest));
+		/* Chop off the rxpd + the excess memory from
+		 * 802.2/llc/snap header that was removed.
+		 */
+		hdr_chop = (u8 *)p_ethhdr - (u8 *)uap_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)uap_rx_pd;
+	}
+
+	/* Chop off the leading header bytes so that it points
+	 * to the start of either the reconstructed EthII frame
+	 * or the 802.2/llc/snap frame.
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: Tx: insufficient skb headroom %d\n",
+			    skb_headroom(skb));
+		/* Insufficient skb headroom - allocate a new skb */
+		new_skb =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		if (unlikely(!new_skb)) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "Tx: cannot allocate new_skb\n");
+			kfree_skb(skb);
+			priv->stats.tx_dropped++;
+			return;
+		}
+
+		kfree_skb(skb);
+		skb = new_skb;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: new skb headroom %d\n",
+			    skb_headroom(skb));
+	}
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+
+	src_node = nxpwifi_get_sta_entry(priv, rx_pkt_hdr->eth803_hdr.h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+		src_node->stats.last_tx_rate = uap_rx_pd->rx_rate;
+		src_node->stats.last_tx_htinfo = uap_rx_pd->ht_info;
+	}
+
+	if (is_unicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest)) {
+		/* Update bridge packet statistics as the
+		 * packet is not going to kernel/upper layer.
+		 */
+		priv->stats.rx_bytes += skb->len;
+		priv->stats.rx_packets++;
+
+		/* Sending bridge packet to TX queue, so save the packet
+		 * length in TXCB to update statistics in TX complete.
+		 */
+		tx_info->pkt_len = skb->len;
+	}
+
+	__net_timestamp(skb);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	atomic_inc(&priv->wmm_tx_pending[index]);
+	nxpwifi_wmm_add_buf_txqueue(priv, skb);
+	atomic_inc(&adapter->tx_pending);
+	atomic_inc(&adapter->pending_bridged_pkts);
+
+	nxpwifi_queue_work(adapter, &adapter->main_work);
+}
+
+/* This function contains logic for AP packet forwarding.
+ *
+ * If a packet is multicast/broadcast, it is sent to kernel/upper layer
+ * as well as queued back to AP TX queue so that it can be sent to other
+ * associated stations.
+ * If a packet is unicast and RA is present in associated station list,
+ * it is again requeued into AP TX queue.
+ * If a packet is unicast and RA is not in associated station list,
+ * packet is forwarded to kernel to handle routing logic.
+ */
+int nxpwifi_handle_uap_rx_forward(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ra[ETH_ALEN];
+	struct sk_buff *skb_uap;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	/* don't do packet forwarding in disconnected state */
+	if (!priv->media_connected) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "drop packet in disconnected state.\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	memcpy(ra, rx_pkt_hdr->eth803_hdr.h_dest, ETH_ALEN);
+
+	if (is_multicast_ether_addr(ra)) {
+		skb_uap = skb_copy(skb, GFP_ATOMIC);
+		if (likely(skb_uap)) {
+			nxpwifi_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			nxpwifi_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+				    priv->stats.rx_dropped++;
+				    dev_kfree_skb_any(skb);
+			return -ENOMEM;
+		}
+	} else {
+		if (nxpwifi_get_sta_entry(priv, ra)) {
+			/* Requeue Intra-BSS packet */
+			nxpwifi_uap_queue_bridged_pkt(priv, skb);
+			return 0;
+		}
+	}
+
+	/* Forward unicat/Inter-BSS packets to kernel. */
+	return nxpwifi_process_rx_packet(priv, skb);
+}
+
+int nxpwifi_uap_recv_packet(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_sta_node *src_node;
+	struct ethhdr *p_ethhdr;
+	struct sk_buff *skb_uap;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!skb)
+		return -ENOMEM;
+
+	p_ethhdr = (void *)skb->data;
+	src_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+	}
+
+	if (is_multicast_ether_addr(p_ethhdr->h_dest) ||
+	    nxpwifi_get_sta_entry(priv, p_ethhdr->h_dest)) {
+		if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)
+			skb_uap =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		else
+			skb_uap = skb_copy(skb, GFP_ATOMIC);
+
+		if (likely(skb_uap)) {
+			tx_info = NXPWIFI_SKB_TXCB(skb_uap);
+			memset(tx_info, 0, sizeof(*tx_info));
+			tx_info->bss_num = priv->bss_num;
+			tx_info->bss_type = priv->bss_type;
+			tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+			__net_timestamp(skb_uap);
+			nxpwifi_wmm_add_buf_txqueue(priv, skb_uap);
+			atomic_inc(&adapter->tx_pending);
+			atomic_inc(&adapter->pending_bridged_pkts);
+			if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+				nxpwifi_dbg(adapter, ERROR,
+					    "Tx: Bridge packet limit reached. Drop packet!\n");
+				nxpwifi_uap_cleanup_tx_queues(priv);
+			}
+
+		} else {
+			nxpwifi_dbg(adapter, ERROR, "failed to allocate skb_uap");
+		}
+
+		nxpwifi_queue_work(adapter, &adapter->main_work);
+		/* Don't forward Intra-BSS unicast packet to upper layer*/
+		if (nxpwifi_get_sta_entry(priv, p_ethhdr->h_dest))
+			return 0;
+	}
+
+	skb->dev = priv->netdev;
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* Forward multicast/broadcast packet to upper layer*/
+	netif_rx(skb);
+	return 0;
+}
+
+/* This function processes the packet received on AP interface.
+ *
+ * The function looks into the RxPD and performs sanity tests on the
+ * received buffer to ensure its a valid packet before processing it
+ * further. If the packet is determined to be aggregated, it is
+ * de-aggregated accordingly. Then skb is passed to AP packet forwarding logic.
+ *
+ * The completion callback is called after processing is complete.
+ */
+int nxpwifi_process_uap_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u16 rx_pkt_type;
+	u8 ta[ETH_ALEN], pkt_type;
+	struct nxpwifi_sta_node *node;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	    sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet for struct ethhdr: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
+
+	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16)skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, offset=%d, length=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset),
+			    le16_to_cpu(uap_rx_pd->rx_pkt_length));
+		priv->stats.rx_dropped++;
+
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->stats.tx_failed++;
+
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret && (ret != -EINPROGRESS))
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		if (ret != -EINPROGRESS)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type != PKT_TYPE_BAR && uap_rx_pd->priority < MAX_NUM_TID) {
+		spin_lock_bh(&priv->sta_list_spinlock);
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->rx_seq[uap_rx_pd->priority] =
+						le16_to_cpu(uap_rx_pd->seq_num);
+		spin_unlock_bh(&priv->sta_list_spinlock);
+	}
+
+	if (!priv->ap_11n_enabled ||
+	    (!nxpwifi_11n_get_rx_reorder_tbl(priv, uap_rx_pd->priority, ta) &&
+	    (le16_to_cpu(uap_rx_pd->rx_pkt_type) != PKT_TYPE_AMSDU))) {
+		ret = nxpwifi_handle_uap_rx_forward(priv, skb);
+		return ret;
+	}
+
+	/* Reorder and send to kernel */
+	pkt_type = (u8)le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, le16_to_cpu(uap_rx_pd->seq_num),
+					 uap_rx_pd->priority, ta, pkt_type,
+					 skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
+
+/* This function fills the TxPD for AP tx packets.
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
+void nxpwifi_process_uap_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_txpd *txpd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	int pad;
+	u16 pkt_type, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*txpd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+
+	skb_push(skb, sizeof(*txpd) + pad);
+
+	txpd = (struct uap_txpd *)skb->data;
+	memset(txpd, 0, sizeof(*txpd));
+	txpd->bss_num = priv->bss_num;
+	txpd->bss_type = priv->bss_type;
+	txpd->tx_pkt_length = cpu_to_le16((u16)(skb->len - (sizeof(*txpd) +
+						pad)));
+	txpd->priority = (u8)skb->priority;
+
+	txpd->pkt_delay_2ms = nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		txpd->tx_token_id = tx_info->ack_frame_id;
+		txpd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (txpd->priority < ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl))
+		/* Set the priority specific tx_control field, setting of 0 will
+		 * cause the default value to be used later in this function.
+		 */
+		txpd->tx_control =
+		    cpu_to_le32(priv->wmm.user_pri_pkt_tx_ctrl[txpd->priority]);
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(*txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		txpd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	txpd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!txpd->tx_control)
+		/* TxCtrl set by user or default */
+		txpd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
-- 
2.34.1


