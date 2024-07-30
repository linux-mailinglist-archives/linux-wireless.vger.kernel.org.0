Return-Path: <linux-wireless+bounces-10651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E389405EC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B950FB2218C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2416C6BF;
	Tue, 30 Jul 2024 03:31:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021130.outbound.protection.outlook.com [52.101.129.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15341465B1;
	Tue, 30 Jul 2024 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310284; cv=fail; b=FmN0TSxyE781j/CyzvWFOSloazRqS92f6WceHl6PeR4NfcOG4Aytxb/y3teNLjubNd1k4lWEr9QV1WxSkPQvo8ke8L6hCPE1nyqpTT+wHyAhJ/0y4S6Qd9zGS1oUsaRrvY1avt496A3SCBFEVcyxkhdMlESy33WKY/TXiQwTmjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310284; c=relaxed/simple;
	bh=ek52fnBz04htlTkhLeEw692vR6FLjNTYPllqp+XT9dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MyiCnS/nOloE9MPTjXrQZuonYyE+hO9um+1iW9uNI8KaPqMLHkBl5DaahRydElxwFPqGTflYf17/NshjZhXDzuEfsVGVSe5cTAmeAAuydqer96nBuHPFznIYMP+UCVOe04DnUIMnwNTeDF2LoEOIDhArL3cwQCdELu2MXnhnHNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.129.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cetq/FNQv3oN1QPUM9dKQp1TJifRxt+cSZcpMdZBkbuNuGlp9F1KU8ti049KoBaraiNp75ZprQ0Rp34gx+1fbt0qpNXF0aI8zh9BPk97MtKw7lIkMFGALfKMfung2vR6sMWtyKABshcrdrS0se0vBSzTRx9wGfAXkXrCg1OKCVig/cdBLBn4YnKX6KPZoHUjNXchzCLdQnwN6fMLdCZrWCY9IjI/1O9EEx7BaLEQkHAb/wuLVh7ReB2Cl3hXEioxTXCkQ4u+2MRQ6IIfNsYmeEZurKVhjwYmRMFcjfgUG8zUYknPGaEQf9/GZJLagExG6tlj5psYp5KLntuu913Heg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rspe/NDPnfZ6Do/p42MpgllFIGSSJ0/L4KOhKjDQjM8=;
 b=CQUh2RlgiCgqLMc3wAI/m0sR8b5jQf0hCyMRXVW1AzYtlq9I4VAXLxWOxvr7MVl3sCFtQ6yJbVhPi0P2IsVY1rkWbeSuKCCiRzGnvGiWAdQJErvcClBtkPw15HaOUUgj6Cj4pG6/qKpQ6KWWNP94Sm9INDODkc7ldJqa287WHrZynOe7fQ/uQoa5Ufikt8USG947r7JDaKCAoUmFEHEkAnva1EMg6vQdq2iOg2pYazH1eBQ/AFnl1sOIpajhYulv/2bEssD6uXpnDsm4bJredUp/NG98kjXGfN2h5Sq0I7P3435q9j2iKvnMmgxHpCeZ8tQGluTlr1CFjT1HhCzmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7705.apcprd03.prod.outlook.com (2603:1096:400:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 03:31:21 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Tue, 30 Jul 2024
 03:31:21 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	megi@xff.cz,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v5 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Tue, 30 Jul 2024 11:30:52 +0800
Message-Id: <20240730033053.4092132-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730033053.4092132-1-jacobe.zang@wesion.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 410c6696-5990-4dfd-dd96-08dcb04814cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gwOg3Mjunr+TE2KrNtslpxxMSG1izSvaOHVG++iw6C1Vtr80HPSmb32wIrJk?=
 =?us-ascii?Q?dfHQJOGSeelCDl/EoE4gwdat8SZjWrQDtTO4hj6ShQ+2prWptKcM9x/EZnky?=
 =?us-ascii?Q?4YixbYjs1F5vFEcZt6jhuscs1GrTAtRI4lTEesj8bQ8rRE/xcYy91to+Ndo9?=
 =?us-ascii?Q?r7a4R+R8P78WMKQkkapmHZtlWnm3SQe/lEK1aryQjwirOZ64kqYq8AOAwzTA?=
 =?us-ascii?Q?aU+OE/uajDnt22r5oAQEfRBgj7yBoq1sIW+BzGfEdMqL16NRo92zJotHiO79?=
 =?us-ascii?Q?ni1jvyzn3zjSoVtJ3wusrimBJw6wWPE5TQNPKj4cfcfS/z1ko+tSYz2rSoRH?=
 =?us-ascii?Q?PDiFrv1Ywvpoq+wxAm99TI1p1oukxr3Vo+1K9phmMbCMvFIONtpQB3l90GPx?=
 =?us-ascii?Q?e7+xsv4/iNeRFdfIlj17dOUzs8YEkYNFw3AbbpQpim7I0jsBepU49cr1GUUf?=
 =?us-ascii?Q?fp1V8iCN3Nga6QUttDLpu8S6VMYUppdasoZGNGYx42fMRi0O9n7lzxH8jR22?=
 =?us-ascii?Q?VLaR0/X2uypH1sj+wDYvHo7Xs++iQ3h5U/EHwY/om49CjQDEZTxeau1RWKx+?=
 =?us-ascii?Q?Uvs7QTnHopXWusLCmxi4TJUM1gxO3RNQnzk/vwplf505YiTqWtowewhtxj2I?=
 =?us-ascii?Q?VCixluX/rlgfKpcYckYMZxOxXpwKfpZf2BikZ5iHhCjqWbPQSUS9jIk3anEf?=
 =?us-ascii?Q?mJYIE88AY1rl6kdNEQZJyskYy5hb1w7IzmN3yPmu7WwpeqPQ57e5QBZnkR0m?=
 =?us-ascii?Q?1ITPUVPv1n6OF2aOVN1k9F8zYgOJjYXbxI1vP2chbOcfJ0uVJ+J1UxLeL8wx?=
 =?us-ascii?Q?64GR1Fcrh43lg7jxKPN7eVdQ42QdDi5NYHr5P78WfKafuSTMDv2fxriUv6hf?=
 =?us-ascii?Q?V3jyBMYXILdQs6JN7j616TqeJyEXTW2glItLncT1IXEHHsVaRdilyVf/sl/B?=
 =?us-ascii?Q?H4edL9IShFvnMF+PQtlwwkXdiH8401TBqDKAyiVj2vWSzcZ//7d0iK92ywkl?=
 =?us-ascii?Q?s5BBNmBuL9wWKL3EOx3tmV3iXrb4k/Mn5Emq7Vu80nqlJhgD0ebst5jsczlW?=
 =?us-ascii?Q?kpbm3PSNBa0kKqX/G3qXZ1nigkuY/W2weohIekkyIBxUYOOVeMntaDlrEIRt?=
 =?us-ascii?Q?nLuKBeHoXpGkfnadjRz2G5WBBqRsQup7DbIJ1NsyKIMX72kO0hrX34iMZAEA?=
 =?us-ascii?Q?bwZZbor4mn7jyC+wzFmZcqn18Q5t5F3MTq37fY7yUs7yz2yoHPrFwB2k25vT?=
 =?us-ascii?Q?o/w5nKETqW+Fv8dSMuFfI5Sa5R99rNACxCv30YUoNacszsAa+IcgrR9VqOeZ?=
 =?us-ascii?Q?0Y5vaduzJxcykdjBjgAVkSPDz+gf7Urs9rcOHpSsPXwfLiUyTRF84wsxeqa4?=
 =?us-ascii?Q?KSaAzLkM968kfSNwE9QzoPMzc5v+MxCLSQ8rlR0QDjj3TKWfLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0GVZM/kSW1NhxEpFecNhyiRobXEQrlUDzpXoNKuCzQDyJXyoSnoUlhEhGjxI?=
 =?us-ascii?Q?RDm8/wMi6IlwEkaLpRksFy/gt4tFgYZZ5c5DL5VhWueyGlOHmVpfUjCv562w?=
 =?us-ascii?Q?fmqAPdJ40oXYn1liDupLjEPKBhPlSbdK8tL7mTlZ3pmaOYhCzOoAWst/yCoi?=
 =?us-ascii?Q?DLZzojZvyQ6mVzNoWOIR1PYrzf4mnPFl003q08rPOw8YG3fddiLrK1pvCGap?=
 =?us-ascii?Q?aYwU8RO5CR6Z9zMb2NBtl7k1ARBfLlMY3QN/zyK9YIrLOWxekrMvPmdQjOuT?=
 =?us-ascii?Q?T35MxZP20YANx2hzWlECQjHFbCXMpIZr0WLRLqsxawKYXi18bup+14ux4P8E?=
 =?us-ascii?Q?Wqh/vAPBMd9fpF2XPl3RFDehQuSojWCLv5cP+zjyMjDzFjI3PNzan3IUBKL6?=
 =?us-ascii?Q?cKjKnfYkXMSGQ5DD1HHyCc3N2HQXo1is3Whi1zu7qZZAJh6+95wwA6fezzmX?=
 =?us-ascii?Q?sR0/gAN07oXmodGq52mHHIKxyDamITzgoPCHz+PZLfGJK54UP5TtGA9QiAEL?=
 =?us-ascii?Q?m/ATRWdZAm5s1pViKdZ4yjjJagZu1Zjwz/UUrvDEVGxzr3G54rVxXE1XN0Db?=
 =?us-ascii?Q?ZAUENl6/hUgsn7WwueBWCSJ5X+LJNEV8dsrqKZSHAxK1NpKDqHHbmmU6ibIW?=
 =?us-ascii?Q?0vFaqnb77JUiLc9N6v9bM1AlOXAoBee9q+WOn1FOBnt0ssYT942RcdOKfe0n?=
 =?us-ascii?Q?HUoS62u8aKmzse05ScoqWxssot7nBSASHzSyZuMoIdeXBvbCt5EUFFgG2pqn?=
 =?us-ascii?Q?78u5tM0kVACdInB1fqWe7HF4L6U8n/rv4/QghfPIN2E/lWg3h/LXgmxJJyay?=
 =?us-ascii?Q?aVzSE0VDydHtX5wxxi5Nb9DNCtGIGaw7yqNaFychUoogUdWHJNmfn3k9N3Rd?=
 =?us-ascii?Q?s1mQ571X6LM2Zn6LYbsHoXolBFWara/emtooKFnKlzZzWlEZjFArM9/39vdi?=
 =?us-ascii?Q?gnDomAKDXpIty7fx+N+K8kGQgLwPWBnan0c2T5AenTMbPL3AVqQWvYGprESI?=
 =?us-ascii?Q?mmwSHdG9nOUmdCAOfqTepBQJTikqJJ0uG9vAH2HJPB139ZrnIIx5INKbFlTr?=
 =?us-ascii?Q?I9v0w3rp5fnWhZK1faw6GjS70rbV+o9QmAffgJP+LDxSy+5VVDIoyQLLXras?=
 =?us-ascii?Q?teiv/XAtXkjFePCCQDVhyssb91+APq9Zp3hDGeNvYLgXh7OHw4E4HZzIsYIx?=
 =?us-ascii?Q?x6wvFuGUc8QfC5qOnoF0R7L8ZBq3wsQebehelcHt6oSi8DJe8FTGewleGsUX?=
 =?us-ascii?Q?aNldTBQq+VRMmNwd8DPFXybEc3jAvg3+iJ7Oirf3hr4dasUTOUwepFtZ217K?=
 =?us-ascii?Q?tuz2IIGw3dYvnoPE+vv9Tmg7Jpm7KbCiyrO7bwFGDHf6CPuSndT2yTt2DwBA?=
 =?us-ascii?Q?94yLhdQ6IXvUyeJ2hxLlg/ZpPFZFvRcyIfmu6nhf3AoPSXjoB4ABW8g86dCA?=
 =?us-ascii?Q?tvlGlRY+vo6+b/+g6L6ggHIv2V8KU+TK/U9FSCCW8GpqkdeRnU5qqiHscC/d?=
 =?us-ascii?Q?zszJRmM1tprCxXpctvC8rQwIDpZ6Hod8bnWDLuJq3NmyJV8mTwAGMGd9gC4p?=
 =?us-ascii?Q?79IZtWQK6dZI1SqdxzLY0YtCyh16D2MLS1pwwuTD?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410c6696-5990-4dfd-dd96-08dcb04814cc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 03:31:21.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJoxW3Z+iR53aW0CuwmSCwm5lTHt92aoIMRx1VSg5ztPv6tASCOp81CxifTjJ2gLIMO3IP6Sno9Z3iLgw7XzOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7705

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a62..6246e3fd7399f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -70,6 +71,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
@@ -113,6 +115,12 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (!IS_ERR_OR_NULL(clk)) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		clk_set_rate(clk, 32768);
+	}
+
 	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 		return;
 
-- 
2.34.1


