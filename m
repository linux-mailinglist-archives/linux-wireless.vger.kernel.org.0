Return-Path: <linux-wireless+bounces-9402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014B911DBB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308711C219ED
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73B17BB2F;
	Fri, 21 Jun 2024 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Umxayas0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4017BB08;
	Fri, 21 Jun 2024 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956486; cv=fail; b=FQMGOfR16ESm3pe8Wg/q7aT1OPt1yq4IJIMRb0RPUnSYK5TqEMuItDBO+/pxOBELuIAu8B3D5or1sAKlzW/mLRWb65KwtqNEGhxpZgPJNMZsMDxuMwCl6E+cRdGW0ySZis7uaFLSEj/ae0WrFwH1606E+tQIIoy5hElYzEpck4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956486; c=relaxed/simple;
	bh=nGAYl9p0ukgl9GAscW0O1woUwz9Lx9h1HW8yx74dqsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+VixSZZL7VQoi5UIdyztmOY06qb+3BSKzNk0xFKD4Q8KrlJp/sZV6Wk34qxsuNQVd3coKgS90ZjtzyqgAlSFV9lgN7u+Se2F1fWQA8W0gBBkNC70JN8MbpZoG7kQ4saoCpp25NgcZbE+mNAJSSEDF6jORnHBl/oRjBvAluJPkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Umxayas0; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWe1zdVYf67cJmDFIFfYsYNMvn9Ez3oiY8pDezydrM2rp9dpEkCv+yzoTZAhv9S83OOT7pVgwGONwOSXbOGJ5h2KrhPGfcU1f+y9Gq6YVEc2v650RQe45UosY+zXKX6CxlV5IxzZ3Hj27S0MF/39Vq5TNM11i8Tu9dgmRfozsfCdE2GfDjtAkpqOvJ6dOYKactZE3PB8d3rsjCL5rxd5G+Fz3+T3Y2lUSKFzcw/sQOJNA6AxzFlKOkSSIRrr576AzMeUrtdC2S5aqq9atwyYZHIKB40MwDz7MC777We6oVbF6idl6lBemHzKW3BfqAxA8e1sOEGF7qwwOjbXYR/MVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuhOydKWuHZgMBC03Swx3VgXDJPXQEtyZoJJQkEVy5c=;
 b=hRK+MQhLyf16NvPXOMfQdZ/YS0pOYR6fTtZWeJzZHzBT6mu5PguqrGQIQfwRB6+AhG2yxqB7MbcRDa+1y43GZ60xsG5wrzQKxb0Nd3U/zJUEljiLYL3P0QeWnBe7gskNHl2U5bULdJZoy2m3x8QuwQ/9WyEjYYSKkFjaXlPOAG+wm5gdfmB5vhsyPF4RQ3VhA/DM2JtobkWZtstCEXaqHImkLJ6OnF2kTGE9CUQBiqysHkpmtczZDLw/XlSz4vFljgdsASfEepJWPnA59DfsEqys5cb0n+nH0XhWKpShbDPpOFaD8qoQcNCyjPCQ6eRXXc9w0bbedbsk7tZTBKt5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuhOydKWuHZgMBC03Swx3VgXDJPXQEtyZoJJQkEVy5c=;
 b=Umxayas0CynCyz7hnA/uW9/qzk27Pl3ZBf5kD9zrJ1YkMaq0WVFlliJcBw9pFx9dgKmD0OtEgcsfEggon6nzxmxuc5bJB+jEPrX8+HP8G1AqtctgxcKKf8ScpXBRFLIiNJN2mXCpmE+kVhMEVx6NPD2PKt1dDevmXFo+GSxNVPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:39 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:39 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 38/43] wifi: nxpwifi: add util.h
Date: Fri, 21 Jun 2024 15:52:03 +0800
Message-Id: <20240621075208.513497-39-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: fab89f7f-bfa6-476b-7c96-08dc91c766f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wgPSQmbtLvgYhRfcXtI1S3N0rHZL9eLH41g6ZHqga992EeiT5URzpv8rMic2?=
 =?us-ascii?Q?5TvUPpzXw75qK1+wdz4IMvjg+dcthxpclGjaiFu+uo0SzwJKKbZQxSKqT3e5?=
 =?us-ascii?Q?a/H3eiEsKRl0oy2oC8A6SFVwtgCtlftyFiATlJk8FvEcw+FH9z5j4dNPV3GM?=
 =?us-ascii?Q?tW2OqoMlf5u/3fNhKcyyIUPTwxj1F2t8ylXYzd9CwRSKXDCcJq6sAAgYv/34?=
 =?us-ascii?Q?BgEmIrY48eTZaBLfJiPoeJhTFtKcNjrzV5AFp30miaqNj5gt368jBkF44d3e?=
 =?us-ascii?Q?EUQEnen7+9SA+wH6K6P8q+2X+JQDFj2UEwybFgPtrJzZDlDQLiDO+7jPUn5K?=
 =?us-ascii?Q?fdUplM72FI3IfcYNLET7uLXg82xJ4ccCYPDs+aQlZPBMPpMI6UPvFpwPADRn?=
 =?us-ascii?Q?ME3xGp8asdRcovOU3m7ud4VEpBX1Jwd6UBnU566PvMLl4QF4INKU+XHd0uXm?=
 =?us-ascii?Q?Tqbg7Zu1X+azLmkL7jYJyNR39T+Ir7wy1bWvlvBteaRPSaQAMCh/PRtslO8I?=
 =?us-ascii?Q?u3SuG4dVtwNN3niEDF21cS8diTKgzdjq+/dVs/OGm9Dg8MhL7bjzLhV/rqhE?=
 =?us-ascii?Q?Xr0l1YXxj5FnDwX2bzBqGwIs5LAqT6LflXvDs8O9pJtg4S2b8YTDqwfKmlZU?=
 =?us-ascii?Q?C6FHxvccv4XiwkNFW2uH0mridW8kqGP+mpnQfQ80bwaoS1oBg4nvCQBoBY5X?=
 =?us-ascii?Q?6kjQH0kdd8D4h1HP0xTfqaIM5HcGIdCHDAUWaQwhkhqVV0yxKrVTEdKf481e?=
 =?us-ascii?Q?J7ITHOOhnCcHDXxlSHiv0KRBiMZQvLU9YmXW2IjZ8iPPW6wL4D/ZkKFJL1Xb?=
 =?us-ascii?Q?4/K53uUt+kQwkP2eG5UITk+6gqIiuGqtVYc419FWoOSxlmONMCbj5zFBLous?=
 =?us-ascii?Q?xftduDt0sZWB48E4/Tm8Djj2XdyGk9qpwmhSpPjbsxt8rtb0sG+9YGUVFoAA?=
 =?us-ascii?Q?CBdRmRarXJSUktW8vjSH1IXcTCP8nHaErBJ7wsYHgM2nCf5dfH/xhdEUjko6?=
 =?us-ascii?Q?zMO2vm/Ar4KsJGE1oG+U3Eu9VASysFixSER2PGZTqBYj60ghBtVVQUnwF3GB?=
 =?us-ascii?Q?RJdtkS+BsGyE2GI3ptRtQQ4McktMKrATmR748tpUSYQThMf2L6vXLuThSnPG?=
 =?us-ascii?Q?2TqLD4QcU75+Kwk3DrmEaEl2cEmXD9vARMRGvk0v+8N26rqJWkQUFSUELkRk?=
 =?us-ascii?Q?6FkAmep5T8z3wmAynxNbrWjrc0faJCS4iSpuAJIfnuiA3c5+Nsp6LL3/i1DB?=
 =?us-ascii?Q?ey0lBdNQF/Ep6Y32tKWGSpFqw2VRQquF92ivyEgR6aCfLNiQNiFaMwGpv4Wt?=
 =?us-ascii?Q?W2djisbzJiskGVa3kLEJPMYC45WE3ubXUIePfCPFkNkCKQi7pM/xjCDI11gI?=
 =?us-ascii?Q?u4qGFG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TzWws+6pQIb+7T1wSAD2fK4MxURcyWbUqXICbyrPhnoGbNv1X/trAsC7RBPL?=
 =?us-ascii?Q?pDncIxbMcCJdJ57wNmxxPq1HqzwtrPKOdvPuns8d4YXmoFDL2mJuWsdIUEq/?=
 =?us-ascii?Q?s6vtQZKPaEcuI8eAj7hCx312GksiZyMYC1GQGdpOjLYk5P0fnCROF0o9dKzH?=
 =?us-ascii?Q?nTmLmBVNq1fJHSUoBXRa4IabfU4hIU+V2SZ5zzj5OTysUGXnEHX9GaKWUMwC?=
 =?us-ascii?Q?W4PSqhckYS6OpUA4MMX4P3lznVQRFZhsz//BgaIStiibyjxkhV9cZl3ToPm5?=
 =?us-ascii?Q?Kt8eFTGRGjbr/ZRRuzCqFGbOLECnDtkVpfsuzU80c5g5JYb514nfZNV0Cgqr?=
 =?us-ascii?Q?gPeZT9gAZXiv+oksrxT8A8Tt+JoEab91ipB/fzpWsqx/ywgg3qdOldGkgEru?=
 =?us-ascii?Q?U0ia9Nr5QhexyhDkFaBMUK5bDG/8Koo2OFk0niTgZwU8P2ibbRn/sLnyJsBm?=
 =?us-ascii?Q?rOA0LBmMf7IWgHK7eBWEr2eCBKufOKYQhiq2jYBw7hFu/vF03+SudOEeWuGe?=
 =?us-ascii?Q?VHKejsfilGHlEWDwVIa4LHeUJq3g6MgUilv8mKRWyBC5Lmh2Vp/Nq3Gbe8OA?=
 =?us-ascii?Q?02M8xGi3QLAn2uv1gWJcgfvaobgC9U7sd9WIjThEc1UWOIfi+EwqtgV1nQrG?=
 =?us-ascii?Q?kf/BlgnHbKH4NyFSLPj7qt/h3TxyjfeNRWHpWce5jV6yW9Lkm5qLYZE86SFa?=
 =?us-ascii?Q?pyzZ1dycdFLqWcpLhrrq4W+9blGtPjAOMr/qKaPZiT2QmYh6byQEg90/aZGs?=
 =?us-ascii?Q?JkPdsut8cDkcERDfgoPf2mCR4LSCaklm+/ucsVsjl1ZoGO1Ksad+h9M5yk9I?=
 =?us-ascii?Q?RJIyAM3vkTbiIH3EGZcwwGIiD9ow+HWgWq/ECdDaVDvh/1i7QiYJk+jbKmkU?=
 =?us-ascii?Q?iexPC3C9lh9cY2vvQjDMB6W+bZktAgmfxk3Ctu5Do6Ib+Xf1ggAaN3yTtDYl?=
 =?us-ascii?Q?3v+B2Q9/lJAkZKSCME9tRyEJJ8uiastH37fFOSCxLFdWmzcm6d8Xpnhucngf?=
 =?us-ascii?Q?UxtNlAeL7d5/F2DBAynGkjrnRl5bOeoKpNdSiDec92CEfSUvozdZdIN7yaAf?=
 =?us-ascii?Q?RBQUCDAUlXyy94Y/KHfcZUhE/ev+iVC7XJtHnWAjyeDsCFh2MXAhTj3xioad?=
 =?us-ascii?Q?5noyoHFhdjpopSO7komefor8wCHpe3V448eV/2sF2/l0YdxPPqi3YDZ3JGng?=
 =?us-ascii?Q?6i3JIzLRSIEBS7dmNx+j17AA1qy9MxG9S+9GT7DzHJ/cPb2LG4uH/Z0JVt7h?=
 =?us-ascii?Q?UGt+Nhlj9OC8XFGG+rAmG7HOWw7dlNQRn9HJUlhJxJ0osd9v7lZiUXJJhVgW?=
 =?us-ascii?Q?lcIhe+wXDQ64fiqQkMb7UYKRIpzY/7J4lHwfuKL/KgJ7sHqZazMKC5nDqrMK?=
 =?us-ascii?Q?YKwKhRxuju3tZboyUeTnUvisvCLm3cuYus9Hq+hjmEl58zKCilD3O2doMkWE?=
 =?us-ascii?Q?0F9iKmbfg27sfweIL3E67caOKnzOjAR4I9UaAcVEirGQBYUtZ8uQ+trPbEAY?=
 =?us-ascii?Q?GcrhylxR5LDTsH7zTcRkLO91a1CVdojGCHkz4ee2CHQwNKu52k7MBlvzcuq9?=
 =?us-ascii?Q?VMgqEs6iSVGbWGmDqrPlghg/mf35MJ0G+MlsNHp4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab89f7f-bfa6-476b-7c96-08dc91c766f3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:39.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGO/djVC7K9Ay9GmJ+MLezuhCIoihhgtqh4zxvHMnHb6F1w8PjpJbsPew+NAqT5iyl2+WRoRUw1QxGu7RpkuPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/util.h | 90 +++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/util.h b/drivers/net/wireless/nxp/nxpwifi/util.h
new file mode 100644
index 000000000000..b9cccb340933
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/util.h
@@ -0,0 +1,90 @@
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
+#endif /* !_NXPWIFI_UTIL_H_ */
-- 
2.34.1


