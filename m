Return-Path: <linux-wireless+bounces-9370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A8911D66
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83871F215D0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDE16D9A5;
	Fri, 21 Jun 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ndGhfD+F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9416E860;
	Fri, 21 Jun 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956375; cv=fail; b=gLww6+JapNvBM9oI+uE6fzlAeMIv/1VpLBZL6+cGlTVJQWyjXLEPN+mRD2s++xa5OV0n+yLL2dodsXZWklPusfYoIbJdVdWBb7xIF9lNuiuB3yVUbS8SzXvryejsLpoosECRBeLbjIt0fVAdhPnXH5FpV+cBVH0bMocg2Twb6yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956375; c=relaxed/simple;
	bh=r1L2c9vNy66MsrKECVNUDrtoSILyX+MMq5u6iBxSQdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwmI24Zw8NjdPDQCG4zilJNwmlNEAdchXhtMqMngEZozrnQpbn5dxQ6IbKectzm5+R9RwlR7opUTQtesQVBX1Pr3Rn52DJKI/VM2YauEY5UgjJsA0ToQ5dr1308dLdFBppGFay0hhJ0yKS/BDOPgkQqvxt1MpqP3pebkGF78EVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ndGhfD+F; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChXlmllEBp+hXu9UbeUg2+4yZL5WJDSAAg6S7WZhKR+36yOPHm52gYRIvVLVy3cY06cTRwFlMDNa6+V/a9s7K9TvHoG+K9/V+Tni5S3Yt2JyMe7J5qLRd/gH2uWe1+HoqVsv8/THIRcENoLmofBSktenbbo5mQ5hu3yMgZA7WpMA2IsNFpwgr59mOJpYYYOoZmqi9FOHsgAlM491CaBwrSUhBu8LaX6Ly2vYIMipcwA0trnRblKJDsZ5Kvx66khy8CtZ/GwYkIEdGeZPnKdjYxoWbjJQQXY9yjLvENyrwKmhI7LLoQ64vmlqUGYeDA293FAX9cg0pfoozOfGiNQ3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib1CEuU7lxRC8Q/V8J2N0pkm+C8PhVLSZwHXyMNkC5I=;
 b=QJq6Eg0lm6N+maiDCaWvP+M6P9L+g2EE+GF/rrnYXxyLFehTDy6uI0F8k8FOPFss1Pq4bIa4qdpfz5u7J//a3sIVW4/fkxmVQAmr9MbBNaeBhF8bMeBIre2lE+boKIfsl0iuciQJknZ9CPU8VoFdSZ3M22mI4qABO/nTF7Rwxog4D5omj4AIjUyn6eKwXklzBmAz0aNuHeaN6dGNEWGwO/0mjv2XNwsnHqWi0nVeowC0sf2xIWOmrClSXhQOFiibMhssrECELtvlUypQb8r7hYEAYXY0TF7oi67Eu/VZ0ZciufBM93LRXHK1TKbB6Lwux3KEr56RmgOGWP/D1pacaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib1CEuU7lxRC8Q/V8J2N0pkm+C8PhVLSZwHXyMNkC5I=;
 b=ndGhfD+Frqcnh9ChAFLmLk/fVV0a84FafVyqyrerZ78ZxCrgghAJnMnes+iCsbZW+JOs/LDyPAsUn66CYc3KqVtCQsh0estoQIEfeLfFBtDi9rb8CyWNte3hG7hyANV51w40R3oMSmUY80jljJdnv4yp5caacYVKNsWuu7biO48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:52:52 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:52:51 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 06/43] wifi: nxpwifi: add 11n_aggr.c
Date: Fri, 21 Jun 2024 15:51:31 +0800
Message-Id: <20240621075208.513497-7-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DB9PR04MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cddec74-d5f3-4c05-6d77-08dc91c726ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iIKuzU08pVqnKQmqDvjsa8bl5UHTrC58Xty8vR9lPFOVNXz+zsWwQuL6yoPA?=
 =?us-ascii?Q?pAdSuaxSnV5L3AbuwPohJgAsVAo4zYlMQLfLCp+qO5YDobNpzqUi6T7zQkGu?=
 =?us-ascii?Q?RUz/AK+PbCqzFHdWCE+BY+CYYZ+2eDIMBWlLgzmDSWom9ovrkq2yrqNCtiyp?=
 =?us-ascii?Q?zk6Sh5T8OWFviAfXbG5g9Y7AGpASlCEaFJy4/FwA91cfT+HwjWRD/fpJ4Q9M?=
 =?us-ascii?Q?9YOtSE/52F+0aeJGlhlgqT3L0NKxe4GZ+exdQjKzduGonS01zHeRL6TtF579?=
 =?us-ascii?Q?7Vn+xByQzWfhMORvSlVyOKi6UMdj2BM4L32+QV4zNXAkY8RMHBEbmw6xLB2c?=
 =?us-ascii?Q?URcHwO6l3j9hDCWQuQ5qFccDlvlWbOfCTeoqQv2aCehrFytgXE+WSGyCPb+j?=
 =?us-ascii?Q?kWeDhOqx9mXIUqGKVhXnaqJi/eCBCMI/e8H9+d5uLbLPJMFjcg757XkuHEFa?=
 =?us-ascii?Q?KfIGOdXlJXr3P4aFBdMyih2WPfNyYPq5sHBCtzSVDua6JcIU03PzLTv920P9?=
 =?us-ascii?Q?LHz/1VSYRPgZGTMe3vvy4I8PcPOe/Q9XprcS/RRsqdLY6xtVuV+VwPFDu96c?=
 =?us-ascii?Q?/Ofa5pFDJstvhTf5UibgY5nA4xDs2HFi8x+93G4Klp+zdgxwuGBuiUJdfkuI?=
 =?us-ascii?Q?HwcP4UXipz7RfBuGNn7Aq8E9+OC2Fn+pcE68klItvpvZy7/q3TW/M0gTqhYz?=
 =?us-ascii?Q?k+YibmcQ1TGZFvnVTSjazLyuY7aCwVhEl1qBBZZ3ilWQ10zN12r3x2ulQpxC?=
 =?us-ascii?Q?XzZHg3OYqlDZ1ajZHWMC01haro+LERy6oQIaFHjizqRDxZVSqrva8706Q/Bx?=
 =?us-ascii?Q?xrcaopWnM2PXqcGgHCUFSBEPf/PY/p+XmBNzNxDlpULx1byPZQT4atJjiZVr?=
 =?us-ascii?Q?s83dnZIK4U/38XFPJ/Wf8Iz0OaCqzkWU+9VADVNihCgq6fAnNLrCmus+T/T6?=
 =?us-ascii?Q?7ERXRj3WWoIIv0+dtY3UGz6lnn5NH0Ykn81pbfGyi+Dn8sY0QxF75cmI8t79?=
 =?us-ascii?Q?vOb35M7PFHFZlbKotfe7kuz+PfwiWTf2UAbNzmKOIL+xAqVbUj4A1l5LlaIB?=
 =?us-ascii?Q?kzY9pdPULd3fcpUz2s8mEmjfUApfl4tTwfaffOQbg6UG61YliLr2nb++ROsv?=
 =?us-ascii?Q?iunb5srOJ7qB3aSGKoXQj0WgCu36wZ94S1UCWJjxxNWt6RG38bAgbp0vC8yD?=
 =?us-ascii?Q?birTIDzOvaC9wC5kcojQlZwbPejGfCKxTlpOZGw6v/C1UABMM4sA4rP3IFfD?=
 =?us-ascii?Q?ddMBSy9Z3csI+Nw6bSZasFlk7yGnCyxKhAOTDcFg4nDm3mwHnQkoLk7XIhFO?=
 =?us-ascii?Q?l+OSlq10MZOT53RyteRscASDw7OVkAUq1W+hvOpY5x46Qfkji2f/NCu5lz21?=
 =?us-ascii?Q?3139PRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7toiuvts+L0gzjMlQtig14U0b8K+LMgPOzVO5ko9OXU04IdP+CtbFmN0eXA?=
 =?us-ascii?Q?YziSEFtqUKJ0lKLPNw9sLOZDb1SPvb8z2Qk00wmDJNp2v2ThjKC+dQ1g1tAp?=
 =?us-ascii?Q?hzO0g/V049Va4Axx9gBGtabVFkT4w5A6QhkE/s5jm1/unMZk2JQ9Mcms0Cau?=
 =?us-ascii?Q?DqA/rWtbq9sEDSjiB3J7UxLQJkT8A+TaV89ymrRJNhq8gKKwnFwh2384gh8h?=
 =?us-ascii?Q?Xz+1dZiqynaBsNABLkVTiY2e0SbBVg4jnkeQ9volz4f4+sTLJzaPPPKqxykU?=
 =?us-ascii?Q?JJHiCVR2Fqqo1wLGOOsb6zNFw9C0xvj4oCiKdoBmNcUvHcVk+SMTcs7fssLo?=
 =?us-ascii?Q?GJyX0YmOs2p1fVQYrUkuUiD1kIHotxtAADuBFOtdke2zRw4ei5gDAkFel6fn?=
 =?us-ascii?Q?96XDzS8PX0MhXJzbsxag2KdilZdJdrTvHsdu8+THJ52gb9OtYDRhpXzKXIp7?=
 =?us-ascii?Q?MG96db74mLVJlDCRJfPpz/Gcwbe+c0LO4CshHr9Pv0Lc0rp5ChyIE5avlml8?=
 =?us-ascii?Q?04sHq7De4fw1+LH/4iaJtGGWjrcIxhcCMZdg6fXY4EFKCnzAhI8HmL4ZwS75?=
 =?us-ascii?Q?Z+mkCsuCN02fjtm2ow3hL7o+3ri5oAp/H69yG9fgUAqVR7GhzQPdmQ68J1dh?=
 =?us-ascii?Q?3yoDWbmV/x8Efwiug0ozXpkM31/fg072qlJAMjIqNMJ+iAHQmvwSQOAXZRLo?=
 =?us-ascii?Q?61UZk2bdTVjt/VDzk4QJ5kA7oO0J7IV7BAV/25yhbGkKXa9q+5UfGP4wCKld?=
 =?us-ascii?Q?pKwdORzo4SsPdcIRvMorUfpK4l42uFtNguu7DAhTN2H+S7PTnqOl6Zct/iLX?=
 =?us-ascii?Q?XObnRiY/t2oWVl5U9jUqBCpqEb2WpwlripbHCAVV0/HZFLV9fOZVQZBcn6iZ?=
 =?us-ascii?Q?XUAhSPB7dmBt+cbDrIfqO9EWdcVhOR20dzSR9CA2IqEeLtD8d6csiHpFxnTs?=
 =?us-ascii?Q?EVrFRkUF+tOlH9niL02yuR7AD7GguxSHQTLmdnOftjJYoeQLTaHeEQC9eLHi?=
 =?us-ascii?Q?CsYKqbCMUS2nFtur1+jvb55WUxN25jwBeDr3OwhRLGDCBm2KRApwu3lsH7f6?=
 =?us-ascii?Q?WkacxDCMpY3xJPTDUcDtd1fYvpPbIzBZ8Lm9A/vx0Am0yjEdcrGOfjFevFXP?=
 =?us-ascii?Q?m+XszK0aW7j2QElgKdn/MxyyF2wFUKLzgMQNnpSmTByLgSrK7m1lIgs3Zu/W?=
 =?us-ascii?Q?48G8jG12NYpdzBZxxPBBPFimxZDGxChnbAj8AJsQjwIGTFbhvHWNhydfaaod?=
 =?us-ascii?Q?LMgDba6q5VJL0FLTeG8KpTSWVMtGiR6r1y1GaNO3rHcS/O0zz9GoEmRBI/cW?=
 =?us-ascii?Q?Xd5CLimKsdrPEF9rR+VvHkVBpslZEfDjFu4+n9ARn3cw0sV4X/QLudo8Q1Hf?=
 =?us-ascii?Q?ctErn5sMpl2SjPWXzTRcvTZ39YNrEa+YqafcPATc82cZn7gAfbX2eOQEzc6q?=
 =?us-ascii?Q?TWkYBRJeAAKV15MgC2vPJ3m2OfC8YvEAMulgSv4dbHYWkmD+advuWgQk/LOK?=
 =?us-ascii?Q?twq229yCigqhWkX1xvd59LRmR9lObKC2DYkehQZOVcs09L7RvOqdeamO41s0?=
 =?us-ascii?Q?kMSF0QiXE2D8bu7IDwEUw/Ik7/SXm8iNpOlcnKAk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cddec74-d5f3-4c05-6d77-08dc91c726ce
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:52:51.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjgMfnmLSZJQ3cEaRWr3VBB7I3EakK3Wt7EoFxt6N728Fi0JXiCiVkirZma3MMKuMbn3kxtcpkJyCb4X2BJeUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c | 278 ++++++++++++++++++++
 1 file changed, 278 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
new file mode 100644
index 000000000000..0169c8d910a4
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11n Aggregation
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
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
+		return -1;
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
+			return -1;
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
+			return -1;
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
+	case -1:
+		nxpwifi_dbg(adapter, ERROR, "%s: host_to_card failed: %#x\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb_aggr, 1, ret);
+		return 0;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb_aggr, 1, ret);
+		break;
+	default:
+		break;
+	}
+	if (ret != -EBUSY)
+		nxpwifi_rotate_priolists(priv, pra_list, ptrindex);
+
+	return 0;
+}
-- 
2.34.1


