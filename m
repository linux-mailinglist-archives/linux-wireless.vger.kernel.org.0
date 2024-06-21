Return-Path: <linux-wireless+bounces-9395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772F911DA7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3371C22245
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DDF176AB1;
	Fri, 21 Jun 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ctqRE9Mq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516F16E88F;
	Fri, 21 Jun 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956465; cv=fail; b=ZizT0Boha83xc8yP+QxWlT3J9E5BJjRw9XZ26w5D9NKZlSPgUBnyIH7hqdcrRQmcjJuQJVIoDmoapRQvkW7Wls86BS2o9NKzJwHMX5KQPtC4QM3tOkskpLpYtIajMKO/lCyAQudZJXEbZibcUYEtCGrRWZImsoTUNn78vtzFbdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956465; c=relaxed/simple;
	bh=Djzln+3lGkZZ9EFjfSDXTbdRkq2+it4KTZpzuWitzPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KFXSQOEetZiSSNs6r8MiNeMwJ+qYMB7IilY4mu7tYsSuCj5Wsipl7/g6TGpSRNBxSjmxZUMpzcsf47LpSxgbVCoKKGJIjio0Dj5HqHCa9KfJwTeJwuMMoBBB7hCQXxzZqIciskzb3fm9hhyjeuLGYF5iuLRMe+1Zrr0lluDSVxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ctqRE9Mq; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvDzc7EC093Fmsm8T8PkqJfAzujIEvKJYf+FvlCPpvcmCu8YUnLV7G7ali39VyGcVrcYtljaGIJVHeb8BsJ6+6acX2q4/ixNhxayw1ciHfB8QSjZkxraHFatIOj8e6DhI2oaC4cwkmlppB/rXTYXEgUERad9/MB/jj3swPeZj8RTKe/nYo1iRT8n/LY/9UowzQBY7UMpzeWBpzlXfLmE4nbDlgzCnhiooITfe1AAriH8k2YFcJIocUPHCHG7O4aQh23r/TQrQCx7B5f7JHkDX0WtoBsALKuaWumz6PXS6JiiQLbV0rRWAfg+alXGgkemMoMXGQGi1OeWm6gx6awUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLYvg+X4YphWukZS7QCqHGZLsN9xLcKOGLe4/faSvDs=;
 b=iUnbMGlPeAYF/9zoRzB7Lp6/hICnGilHMp31hJiZXFMHzttkQwbXTl8khLOvgzFoYaYtDx2f5zA7SWfkVX6FTWaJ2u3/R72X0orNqYzxlJLnmHXN4PAYZ8hGPhS86mpGAtQoIYHWgE9/83EvMlaw/5zN3j2RU1gFir7mFTZRB6ekwQ/Eg/psp/Xc3xE/iDg2PmFUCbA4Pl/+WSpp+pjslWoPCJ+QHy+AkULs6CVyrnBIFyHPB+t4g0mT41aPDpnrIjIw9aSwEK2KnB9YBx9zuauU3P5yewAn8x01ZmiVqbXnkEAoFdc1ITMnKVEsP9cQM8qjnZ5cK0m/TEBLr7LAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLYvg+X4YphWukZS7QCqHGZLsN9xLcKOGLe4/faSvDs=;
 b=ctqRE9Mqklyxeg4idAnJNre7NmcXWs3oEo6IZ6PYMPSXLgm4o4Ni+5VqvSxJKuI1UGCONEqMwrtSEB1WPnNghL59O0bsFG5yTmWFo2eOmSs0rFmXRgdChaz6YjJvT5r0r8j6G1pTNVQ1mQaY24lREW4ynmDmQPiIcg0YVswgMVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:54:18 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:54:18 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 31/43] wifi: nxpwifi: add sta_rx.c
Date: Fri, 21 Jun 2024 15:51:56 +0800
Message-Id: <20240621075208.513497-32-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06f26854-1806-42f9-3ad5-08dc91c75a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7hs5zqo8b3s4sQ7Rhg38UbeIozsTPH4axM0LZoppwbbD42nQntggThADzCvq?=
 =?us-ascii?Q?cgZJfLc59ZvIyNqPEohcD06SS6aDxYRlDPXKt8R9js0ACZn4KSqdJkDpgcuv?=
 =?us-ascii?Q?OjIIVE3laoQS7uqlmmf+AjNEjKeOzzVE03Z5pHEYWuzL/S7zho+wHv1MeXcg?=
 =?us-ascii?Q?uSYcs2/dhtYAfQ/mckKiOOk07KO3qQugYsnt8gUo8sCcDCXyHXuzGy2sF6la?=
 =?us-ascii?Q?133ERPffCF7rH/+lGtCAcXFe/YShVtQLylN8geYyWZ0dqMIf47jgK5woOxP9?=
 =?us-ascii?Q?0WHjjnhxcqUDZQ7I/iJDxRdgJvAtVcCfo9TrsJMQDfO/Z5IXVRifqFgSlt3P?=
 =?us-ascii?Q?OVbF2FV7F0t4ZwzpuSQmpz6xQOdsdUzXBTd+pzKblT9q6UeIxaTiKiCpQGQE?=
 =?us-ascii?Q?p3+NpQ8RaTCOE0EbKxNzOUv2Sg11xXVfS0Y0Ih7FflE0l3kHYZle+BNTYOfS?=
 =?us-ascii?Q?NLFAt3KSYx0Mm97fVsA3hh/dmoO2hGADErJrenDbJkCaqo3foWzvf3ZIa0jw?=
 =?us-ascii?Q?kuyLZnds1xRzsTl/eI6DYMgw6NuGgHmHk15GOgcVTO5cx86mVQGcEYnWXo0v?=
 =?us-ascii?Q?XFTL8SPGQTQK91xqRoOuuo0ToWnR6U6y8qUIXmHyUNZkZIbNgjKABUQpecss?=
 =?us-ascii?Q?ZzrQX7JpKRoSLu4p2SNGwXxMWkvxu5b5kz66RRq0v6N4UMwbaf/lHGk2pDHG?=
 =?us-ascii?Q?TErHiKG0w3MQGBhRtFFnc+qa9C6eR/Ji1nJfG+D4RLGxodp3e3qlfbCgCt72?=
 =?us-ascii?Q?sqvmy0hgtmZqa7+TkRAFKe959izwYkLvOAaWUlQjZ8+E8T/ViVH8HnsPNFsI?=
 =?us-ascii?Q?ueueJZoNwfWImI0phkjfUoC3Dp4n+iPVqO377w4XRP2acnTv4C/agdJ4810V?=
 =?us-ascii?Q?32FZa4M0XSJEvNiV83MwHd9gBfE4EqrxJw+8Id9sai8XuZHXQC2hZy0/Lx81?=
 =?us-ascii?Q?z/1QJEa1l7nUHLJ3z2ffWj1rDIWPcAIsaPIxXr4cJrCueGUN19WTIhc1I5dA?=
 =?us-ascii?Q?PATaM4lXRC4UQzrxaqUPa2FVUV2EiFShkiR0zIgl5FkDNpf1Vo1YZfpzWJCM?=
 =?us-ascii?Q?7kkspQlUzaZphuXXFDcXOQwD6qc55t4hgk9/dW92vHQdQvn7UpK/TanRLPxW?=
 =?us-ascii?Q?ME0sGXvxHpVQv8B/yVuva1VSpAcrpFDPgsnoqbs7lf7ZpOr1Ng6ANd/AarpS?=
 =?us-ascii?Q?Skb98QeXxxpcU9FADV3rV89+actsd8TS6cHqyrXRwHLmxDBupiFwYu2BxdcA?=
 =?us-ascii?Q?ExzWMrHAcFQ8cuVUSqqpC4z2kPJYFq9OrD7HvxMtm7T+Xol7FvSut/t2kecq?=
 =?us-ascii?Q?SZXr89Jo9/EvYI0Tmpg439ANWGqy1Jq22KVQYWzS44dmvXnR4riZqOJrXCXs?=
 =?us-ascii?Q?UI5MvPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbqic4xo3YzKe36Uy6bkz7mj+MN6iwHEJa1APnYhbUKaeD9ytCinJJWeP8Ra?=
 =?us-ascii?Q?/96984ashiqAh3MamxfyLpV4sMXZtCC5BUfI8PO1QvAzAlHyGM/kf3U9KvV3?=
 =?us-ascii?Q?HVb6gMVFfEJKrLwl4s0k1cHy1sGV0XsD+ENMF/UYbLdZ76r5BzX2dxu31r9U?=
 =?us-ascii?Q?4kQEqvFMTtCgBXMKbK4giJMG8cNd/ZH21QoXjyiHOMWWmJ9mComyqzrqCJ/h?=
 =?us-ascii?Q?Vcd8SZ0BDdxOYkSTAkgUmrFPdx3rypWqS9RpktefmufSV5X9aV+rcY7obndF?=
 =?us-ascii?Q?8SAO4mmg7IWZ4hXCk9FFRp7ollBITeqxVkf5IhicihD0JyUDsCUwhG/Z5m01?=
 =?us-ascii?Q?ZUSB3efrtMjVXeaetDe2m8BchEIuMOMFjhl5JTqEBsa0GjtmkT5l+AB81K5G?=
 =?us-ascii?Q?fVSr5BkAtaP2GLgYpvCzRIPjGMCurdJT4eQa18WXjulomIkoYR3B7EPpKetR?=
 =?us-ascii?Q?bV1ihcxxoWtxOGTTsx4+Omh3Go5ANpjkWhoqeofKO6WjMAx8SpbytNp0jDkc?=
 =?us-ascii?Q?cNY+mDPMl5OovaJRUzfvhyqrbav0clNnqPFfE7ex3GgZZV8x5GE2pq/PPT9K?=
 =?us-ascii?Q?ElPowbmi9fjBlmCzmMySB47s+c0WvvXxWGlBN6bpmhVacQJwOpuVXg8Xj4ve?=
 =?us-ascii?Q?xony8oehqm9C2D3sXN8lNaCn83cuKBVSJWZNbcS5t8fpcLpzfWiQRGZhBEBF?=
 =?us-ascii?Q?10RTKUYYshlb8kkFLKjfnxTHYb4kp/8WfXxs0QYJERta1aJ5mpEJTejGXZ8q?=
 =?us-ascii?Q?r0J8+oUTq/eazlZ2rxTpUSfDFSa1sFAPe+PSg1VuuNTF+nQKSSBriFDatoJ6?=
 =?us-ascii?Q?Jg1Bh3xj7QmnunMyaJhAWA//rLj9GLSP7+FRV916IvofI2HuWtqnY/1KGFYB?=
 =?us-ascii?Q?wBVpn8olhlE93AnsPieVZhepZfx77EFMig7U8ExQhyvZm2PWknOt7y5Sh0Hu?=
 =?us-ascii?Q?k9uDueVKiChi/uENa7nBmvZG50yiiFhy6R24TlLFiT7gxzz73IXR5qRIWCN6?=
 =?us-ascii?Q?Qq19EaMCJIfc7SfB/endOh2nrprWOkarQHz25dVr4Lgw+i0wkYtHLoXhRUT/?=
 =?us-ascii?Q?A3164GOJkWu9Iy5mznN8i7ZggbuLriwZTy3QWGHPcl4+tyV4pDivUa+5YZzQ?=
 =?us-ascii?Q?HjZZqKJ0MQNsa4p944+vB0zc/m9TMBzBq/INwqy0hLbnrfhw/ZKT5pO+xv/z?=
 =?us-ascii?Q?lKEymW2JiBC7zCcSZOUfBNk9c65DD+jENwhJfcENr43lfeqygRzUjjrB/D8V?=
 =?us-ascii?Q?1vCfODg3LIvUHSQwbI8PWLL/e3la/kUTAez5o6BlPh0C3jOS4OYb7HWAOyTg?=
 =?us-ascii?Q?5IsQ2tdX2Z3zPp4a6aecKohEHslzWjGYagXaZ3K5fgZGMqw8qPjPj7GPpnAA?=
 =?us-ascii?Q?v/vRgNDdFMcmEwdBTuqTI5lh1IF2IpW0yL9TNoNuIz6gAEvWWQwQKMVYqqdX?=
 =?us-ascii?Q?7XKIEdcfVIZcyJShm+CU7XNYjeXJdy1q9W3F1Xlf5OSnQ84kXzbEFSF5I0z5?=
 =?us-ascii?Q?DiFyYPypLb802lGz1XM6Vh04dWKpUAAsZY8OTga+s9sMYqJTwZTMiRXiV4U/?=
 =?us-ascii?Q?UINVNShwKr/wKP1BVPSI0t+UxTS7LJ9EerVt2ehs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f26854-1806-42f9-3ad5-08dc91c75a31
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:54:18.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGjGJtRvjN8YLspmXNV2HmRWKoGFAI3ia3wCwdDnhk0+DcwAp0wbNT3UwBZzWU0ftWv1+BpGtRNhKLMTrjcaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c | 244 ++++++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_rx.c b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
new file mode 100644
index 000000000000..9309ac510ac5
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <uapi/linux/ipv6.h>
+#include <net/ndisc.h>
+#include "decl.h"
+#include "ioctl.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/* This function checks if a frame is IPv4 ARP or IPv6 Neighbour advertisement
+ * frame. If frame has both source and destination mac address as same, this
+ * function drops such gratuitous frames.
+ */
+static bool
+nxpwifi_discard_gratuitous_arp(struct nxpwifi_private *priv,
+			       struct sk_buff *skb)
+{
+	const struct nxpwifi_arp_eth_header *arp;
+	struct ethhdr *eth;
+	struct ipv6hdr *ipv6;
+	struct icmp6hdr *icmpv6;
+
+	eth = (struct ethhdr *)skb->data;
+	switch (ntohs(eth->h_proto)) {
+	case ETH_P_ARP:
+		arp = (void *)(skb->data + sizeof(struct ethhdr));
+		if (arp->hdr.ar_op == htons(ARPOP_REPLY) ||
+		    arp->hdr.ar_op == htons(ARPOP_REQUEST)) {
+			if (!memcmp(arp->ar_sip, arp->ar_tip, 4))
+				return true;
+		}
+		break;
+	case ETH_P_IPV6:
+		ipv6 = (void *)(skb->data + sizeof(struct ethhdr));
+		icmpv6 = (void *)(skb->data + sizeof(struct ethhdr) +
+				  sizeof(struct ipv6hdr));
+		if (icmpv6->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
+			if (!memcmp(&ipv6->saddr, &ipv6->daddr,
+				    sizeof(struct in6_addr)))
+				return true;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/* This function processes the received packet and forwards it
+ * to kernel/upper layer.
+ *
+ * This function parses through the received packet and determines
+ * if it is a debug packet or normal packet.
+ *
+ * For non-debug packets, the function chops off unnecessary leading
+ * header bytes, reconstructs the packet as an ethernet frame or
+ * 802.2/llc/snap frame as required, and sends it to kernel/upper layer.
+ *
+ * The completion callback is called after processing in complete.
+ */
+int nxpwifi_process_rx_packet(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	int ret;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct rxpd *local_rx_pd;
+	int hdr_chop;
+	struct ethhdr *eth;
+	u16 rx_pkt_off, rx_pkt_len;
+	u8 adj_rx_rate = 0;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+
+	rx_pkt_off = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
+
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return -1;
+	}
+
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX)))) {
+		/*  Replace the 803 header and rfc1042 header (llc/snap) with an
+		 *    EthernetII header, keep the src/dst and snap_type
+		 *    (ethertype).
+		 *  The firmware only passes up SNAP frames converting
+		 *    all RX Data from 802.11 to 802.2/LLC/SNAP frames.
+		 *  To create the Ethernet II, just move the src, dst address
+		 *    right before the snap_type.
+		 */
+		eth = (struct ethhdr *)
+			((u8 *)&rx_pkt_hdr->eth803_hdr
+			 + sizeof(rx_pkt_hdr->eth803_hdr) +
+			 sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+
+		memcpy(eth->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(eth->h_source));
+		memcpy(eth->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(eth->h_dest));
+
+		/* Chop off the rxpd + the excess memory from the 802.2/llc/snap
+		 * header that was removed.
+		 */
+		hdr_chop = (u8 *)eth - (u8 *)local_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)local_rx_pd;
+	}
+
+	/* Chop off the leading header bytes so the it points to the start of
+	 * either the reconstructed EthII frame or the 802.2/llc/snap frame
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (priv->hs2_enabled &&
+	    nxpwifi_discard_gratuitous_arp(priv, skb)) {
+		nxpwifi_dbg(priv->adapter, INFO, "Bypassed Gratuitous ARP\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	/* Only stash RX bitrate for unicast packets. */
+	if (likely(!is_multicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest))) {
+		priv->rxpd_rate = local_rx_pd->rx_rate;
+		priv->rxpd_htinfo = local_rx_pd->ht_info;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA ||
+	    GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		adj_rx_rate = nxpwifi_adjust_data_rate(priv,
+						       local_rx_pd->rx_rate,
+						       local_rx_pd->ht_info);
+		nxpwifi_hist_data_add(priv, adj_rx_rate, local_rx_pd->snr,
+				      local_rx_pd->nf);
+	}
+
+	ret = nxpwifi_recv_packet(priv, skb);
+	if (ret == -1)
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "recv packet failed\n");
+
+	return ret;
+}
+
+/* This function processes the received buffer.
+ *
+ * The function looks into the RxPD and performs sanity tests on the
+ * received buffer to ensure its a valid packet, before processing it
+ * further. If the packet is determined to be aggregated, it is
+ * de-aggregated accordingly. Non-unicast packets are sent directly to
+ * the kernel/upper layers. Unicast packets are handed over to the
+ * Rx reordering routine if 11n is enabled.
+ *
+ * The completion callback is called after processing in complete.
+ */
+int nxpwifi_process_sta_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret = 0;
+	struct rxpd *local_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ta[ETH_ALEN];
+	u16 rx_pkt_type, rx_pkt_offset, rx_pkt_length, seq_num;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(local_rx_pd->rx_pkt_type);
+	rx_pkt_offset = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_length = le16_to_cpu(local_rx_pd->rx_pkt_length);
+	seq_num = le16_to_cpu(local_rx_pd->seq_num);
+
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
+
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
+			    skb->len, rx_pkt_offset, rx_pkt_length);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret)
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	/* If the packet is not an unicast packet then send the packet
+	 * directly to os. Don't pass thru rx reordering
+	 */
+	if (!IS_11N_ENABLED(priv) ||
+	    !ether_addr_equal_unaligned(priv->curr_addr,
+					rx_pkt_hdr->eth803_hdr.h_dest)) {
+		nxpwifi_process_rx_packet(priv, skb);
+		return ret;
+	}
+
+	if (nxpwifi_queuing_ra_based(priv)) {
+		memcpy(ta, rx_pkt_hdr->eth803_hdr.h_source, ETH_ALEN);
+	} else {
+		if (rx_pkt_type != PKT_TYPE_BAR &&
+		    local_rx_pd->priority < MAX_NUM_TID)
+			priv->rx_seq[local_rx_pd->priority] = seq_num;
+		memcpy(ta, priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+	}
+
+	/* Reorder and send to OS */
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, seq_num, local_rx_pd->priority,
+					 ta, (u8)rx_pkt_type, skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
-- 
2.34.1


