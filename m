Return-Path: <linux-wireless+bounces-9396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE9911DAA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F01B2160A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397AC16E892;
	Fri, 21 Jun 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VcyTi0Z3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75606176AB5;
	Fri, 21 Jun 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956468; cv=fail; b=CJl4kJnVRGBLw1gWmuknTCrauKFh2A2i/tiCFshNhxdK8WGh20Khwxl2up6j/vQwMMoc5dYcys5xQyRxnA0+2RTfzYbbHW6kYgdclkHXIow+IV7W4Lu/1CyAwz82pwiJp/KzkWL1UJKq+Tcbwj440X+CIFNSPePn41/MDqbKCgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956468; c=relaxed/simple;
	bh=aklnOpT2v7W0jpVlAabJ6Fw02cxZKm5w7S0hayxQ0Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gh+ye7vROsaY/LiRdAWD0LZ2xerIY6Ge5qXMl91sM/cC6gQZvl38ge4Cmi7JwqWtAVNp8XTugxTSinRadMOdWPLdmi07qrN0fSHnv5mO9hpVQIvEBBRjkObgOT0+8h0D4iRP9/SVzDHMKxzZ9lOKe8LluBETyXbjZ3Y5quVfb9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VcyTi0Z3; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwwKlW+OO2y0efjv7oH93nkTXvFc9FPKIcXbF0ccvHNeBPbbR6kNcSbC695oq/BNHDSfGday3U2JILRQzEM1+P73YTgtKWQ64PKfRHQRSac874uhbakOAqar69q0WcLeEWO3J045b/gla5votoNfzNkmyXAZEzOYAle9AbzkctEc5r5kWHBavUNjaJ30IHnDJ7uAP/Oan0yE7MGbrD4s9k/aGFxVj87XOC9dQWnuksbRJ7QY+Y6zab06z+NsSET2FJsGRZwPjV/3BL8T11+0nP/cDYJgMPCLfL286gHC6XQ6t7b7UgL4ZMNHKbIsrfRtXnWmaG+rRSZvydjiDdLyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtNF4CrZJxpN3HJymi7dgfcDvCQZ6LjMXc3Vxjl+j1Y=;
 b=oYP0lYNkr0nqyphVpxs4AhjfonnuREmCnHdJmWeSPaXQuvSOlA8FXhJt3lw+RhX8MxvJmBkOnbTWJfhJ2hrzSI7vnuCxylrTPcSH4LHGLqs6Bfk6C63frTx8Y5LmPpWMGs+8MKJdAn1/AgaStCECT4qxUPHbuwoY7XFoBge48jGlwQjdaOS1SMiLkXx5M0PWcPtLwF0S5u6cIPf8lzWoGgLa9pW0x+yQzPoc5aUlXiU8F+ZaByUIsCmpSwOOwWGZsPdmfW9Wrq4k/kdJzxQHflhF3DW0v9skwZj8cXJumD8UGVgnWg8BI4T6j/gkuWQuWz5Wqfd1b/a8gRXqMCVmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtNF4CrZJxpN3HJymi7dgfcDvCQZ6LjMXc3Vxjl+j1Y=;
 b=VcyTi0Z348zLPKYu6Zi6hKJnD3vRpJN85+ilbXbbAWvU2NGiggnQgNMiE0Dom9gRTEBxat358OnalNUWg/AehGITj2aGftm6pz3WWsALNFj0YFEXpsX3LNOC6QfDSs0UqLGJ3BHqT+swyXuTuKZ0iJixiAJIbQoWIcoO4x5zfe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:21 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:21 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 32/43] wifi: nxpwifi: add sta_tx.c
Date: Fri, 21 Jun 2024 15:51:57 +0800
Message-Id: <20240621075208.513497-33-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2177fd-61a5-4501-c3d1-08dc91c75beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Oqkd5ldoq8LRFJ57mNTNYCJJPWVyRSSvOjTxBNw3A/gdNucNFzdHkPmrzCB?=
 =?us-ascii?Q?0sW4LadNwiZAHCiDTk+Zt0wIHL2ut0Id1yk6bsrYnQHAKSQ8Xpxi2RsaWDI6?=
 =?us-ascii?Q?VtCulXSXz5TBKAc06Rr9lkcN4eqR1wElXAwAs9zMkpQ9tTqO87x6hwz3X7KB?=
 =?us-ascii?Q?qAwMu0HMydj6M47umiOvotBvzkENIaon5ZPOgSbrTeJN9P9lzuZfzXASUOHb?=
 =?us-ascii?Q?TDkSMM2+iT4f0+HwlwHmarcDpDaKJyVgJd5uzB1FzJTTh5M3wTo8wqGx/U8J?=
 =?us-ascii?Q?WIK0Fm3Cbo2DCADeBI3T1EqPggVk6l4hMcCEaINvdCfiBppGJ9dV5F5wu3uL?=
 =?us-ascii?Q?e4VFy3hOcU8EHENZrFazyxUUB2sicxiZUkceebeyvygdLMQxc2Tktrk2izv3?=
 =?us-ascii?Q?DwizRa1p0EQrN/ZGiGFuR+peibKqL6WGpkrf/UDoQ81fYxHX7w+MIqsFgCmz?=
 =?us-ascii?Q?pDsm9q32lDqP7fSZbvBPax1iPwowDXBty3j+XaAaGJiJXJwlYKDlzp1MV1KG?=
 =?us-ascii?Q?U43cZGDxGM2ONqlGA7ePINpPYsVjl/yk20MT0ggEt4LV0MLPaBZ2ya59t1Ko?=
 =?us-ascii?Q?K59c+HkZpgdR0pwPewH3DfNkc+w63MwDtQXFuJZvOhxv0YJn0nxoa+QR7xxb?=
 =?us-ascii?Q?BvmC4YQHNSoHr7NrHiyBntcC/qFzi6Qc/fh9X03BB/FDQbHWdyQcq4w1dIIB?=
 =?us-ascii?Q?s7PnqC6FI104M+wMJYqaOMSW3U3khYF5zS/rqiJcoddBWQOxStdGADvwACjE?=
 =?us-ascii?Q?glBAsTEVPr4ohug5GziG5Ax0tC2POKSRqgGbyVQPcRlViunZ4KJyXYwH1p0l?=
 =?us-ascii?Q?pMgyo/X9jLvV+YrEheEzTPPmHmBFKSu3lH4KOqKkhoMskyqhPYOmAROGwtI6?=
 =?us-ascii?Q?FOn97OZYEII6O4skIS0s8yT6Zec/7r0dRPXu9dX2rfoLlcLmZaqJoakQGyYO?=
 =?us-ascii?Q?65Ejd+YJk4EMh/L2zmTIcbkjsVbc5J/C+II29hxgrm5WYGa/E38Z2BYkuy+Y?=
 =?us-ascii?Q?3EoxyzNdykN9gBEv0Ii1YLGTtN5+JdnovX4vnE4OAM2dmjSf1ji16yLb4kQX?=
 =?us-ascii?Q?u8+Mt5tiTKJ2zCDb6Wh3Tflv812DLQC6W6l2HMxGnzhw4YnpNrSvY6PAuCMX?=
 =?us-ascii?Q?Y6TeAAIcrvop+abFgm2JmUrQQ7EqQZp2LcvYblUGk1RWLyjhjWnsc7eVKGYv?=
 =?us-ascii?Q?YihvWO51oyftNU++J7XZbJLDeVs/NT/L0Qbcnje2Y6UnttJdZFn7myFABGrR?=
 =?us-ascii?Q?0mXGYplmWTGpBRsxLUKlKawJN07yNVq7+hnc4yGlDimVilUGmz21Er5pASN6?=
 =?us-ascii?Q?rP/+wuwtdtJXUL9Z2s3NNtzVhkOx3DjUfDibECUp/IHVDXD1OXqmZ8htuvSV?=
 =?us-ascii?Q?XjLIXSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paeAXd/8nX3461HUShzI6S0gi1oZp6LXvY15fYNzM5Z6vfK8gqqjbvL+dz8B?=
 =?us-ascii?Q?on8zf/rQmUQgLGhjspMrZ5HHzTPpdoE6tShm8EdxGa2fEqX5LS8sCmVxAl/R?=
 =?us-ascii?Q?Hi56OH2aUfUWMfOV56Qaj28uJSysY1FhV8rGMYwoM5ndUkmOhc5biQuhCsIL?=
 =?us-ascii?Q?uKKou+2LfeIWGYBrYgYbepwv68Yg6/2KC30NwqNmIqg3J8gH85nttPPIi4la?=
 =?us-ascii?Q?CWU4mmDj5BdhgIF9tyCzkpa/EX5OlMhxhUGwer9eI5D1Tu9h9idiRnav8KS3?=
 =?us-ascii?Q?/NQ0vpatAWbB68DU2ZQRwyPAmiNm678Hpki+rUoBeQbTSegpHeGgFzANJ0fR?=
 =?us-ascii?Q?JvEdyiJSo4w8/dieKLCo2/hzvVwq0gpPPZbD8vnsIFVTsqQoyWcW8wACNuIQ?=
 =?us-ascii?Q?BizMz5Bd45HvHXj52S0NMkdyglNUH4gTsSS45y+WfIl/CxFZC8GBw4pI2zXw?=
 =?us-ascii?Q?OCX1e1ulcYVVX0PSm+wUcTecwB3aCpxJbpjvp7+fckf8MBM1K/CxmiNe/TNl?=
 =?us-ascii?Q?QCP8/tCLz8jngPjbL1Lnazyqzyv1aiPOYXoq/cujulFFu2+96CtkHBZNcMeC?=
 =?us-ascii?Q?sOQqwmugASli2zhRCFRcQCYZewBkdDsD9ECSIc0S9LuxlJ4JogEJZjznK8O+?=
 =?us-ascii?Q?zqSjb4YGVIpoei91OkM2ozCw7xMZOaQHM25P+7xdSgV6IiaS2S4vvE6eIXhJ?=
 =?us-ascii?Q?BzLHebLEOTZ8+/0PlY0lNtf9nazWDt3S47ytzNk4zOYp2WIdltMdXVNTc6F4?=
 =?us-ascii?Q?AfrvuYWdbX5LrOT49dcNJtR1kysd4jqNuykClpa8Fhid0Ag7L9OchpFuNVnx?=
 =?us-ascii?Q?nG3QyxEoR1KNcQEgodsseNh6vPeiT/eHXiOO1oSInIoKNSciBC1GKIB+sQjZ?=
 =?us-ascii?Q?VNzGqC+oANf42kKoMa1jPypBJ6M0FKSi6XH9mZZZ2A1+vg7spW68eAsgVldq?=
 =?us-ascii?Q?+xS1jM9sN5bwzvwGm7srL/WGv9YGIVu1SVuAbtGR3FYYb3pbjqsNT3xiD+E2?=
 =?us-ascii?Q?R+ExM9QaJmtTAh2XxL+woqyS8ECiqDPSJcTOu7BUr2KuEY0mcBwVA4GItipI?=
 =?us-ascii?Q?lgsyGLou67AuFJFphqbIw1sOCPaU3Ty5D9zCtXMaaQ01hZdAFwNx7Ie0Rcw4?=
 =?us-ascii?Q?buVvDn5/Hj8hZLjyGVAg/s3VWyAzDTaEXHE0B31zdNLAc7+tLWKepMheWxTH?=
 =?us-ascii?Q?uNabENryx1nesvd5RN8bILboPME3N7f81gWpSNqFvhUTGI9x/NfkB3xue8x9?=
 =?us-ascii?Q?OZgEK6MFjw7lHiVPU9adA25dRjOpg48VnDqUE/uRP6jC/i+DcwTT3bwIC5S8?=
 =?us-ascii?Q?zZq1WvSVfTDtnmmE0PT1Qp1PYXJpeg+RZ34oST7RmHHTp9oU/IlD2G3YeJm3?=
 =?us-ascii?Q?eW9Vjttp+gv/CDP7Nq2ZPP5NLy2XB7ansbhkATo8B1aOKA9RB/vEMGiG3Btl?=
 =?us-ascii?Q?Zr4unuNufGHoBH9p07C+HQpCDVJuoebd9c3BdPpRQySwgOLxDPgZgmi9eLQ8?=
 =?us-ascii?Q?ctKhqVETlb/Pf+9VxN96gI7Ss9nAECg2QC4+VsyNChYvlXU3At5WidJEssKT?=
 =?us-ascii?Q?Cn3u5qrXfAnvoKRF1V+hET4fiVK7S4zDnxsXrd9t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2177fd-61a5-4501-c3d1-08dc91c75beb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:20.9806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl6UUNJIffsibSsDF/qSWGj1gWDuejm2Abezcu5VHfOP4JtBjGyUyTQ4NNB4rKHnJyRj3Bye0Bcm3FfBmPvt4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c | 215 ++++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_tx.c b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
new file mode 100644
index 000000000000..8fb3a146552d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station TX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
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
+		return -1;
+
+	if (!priv->media_connected)
+		return -1;
+
+	if (adapter->data_sent)
+		return -1;
+
+	if (adapter->if_ops.is_port_ready &&
+	    !adapter->if_ops.is_port_ready(priv))
+		return -1;
+
+	skb = dev_alloc_skb(data_len);
+	if (!skb)
+		return -1;
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
+	case -1:
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


