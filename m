Return-Path: <linux-wireless+bounces-17233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A36A07421
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 12:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EED41889720
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848A92165ED;
	Thu,  9 Jan 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="saSZ5hSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011036.outbound.protection.outlook.com [52.103.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B82153FE;
	Thu,  9 Jan 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420689; cv=fail; b=Tffudu99PmmVO9b1SMx6hGhRs/5N6/BOFrljmAya0APb2lA6OzzZlShO/zo4LkHUT8PqHGi2ji1bYhLdcV1SPfQ/d9wMZIwLaTPGJME7HJ1ffjbph8CUQ22l8NtrbLgfjq9+ch6FBK3y2tIWrRMuG6tQRrFNUlEmGfyAgA+BuRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420689; c=relaxed/simple;
	bh=ALUJRG7g6UypioI5RrsRj3RRfFBFIaBtS6f3xLgz8gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlHCoEPURue7cq0SuH30sCL4N847SCaNuHaCJswFTAa1CxKDKNCdiX/agwynDtlxaLt/WdN14uGUQ3uMBIGRLOBzxSjcPvDCrdQvI3D0lBiQbGbbcg89cRB59aslMc2MmJ3aaOPIBZJ9O+yFv8dzrxLb1EQ7wfEbuKjAOmR1/yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=saSZ5hSC; arc=fail smtp.client-ip=52.103.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HblYGC5FJjibqNn7hBLLxr96UZHGi+w46dCQ/3zMxNnxgIAbKtUstaLYOOJ+khuslsdj56/g2GwBX/AZBGGKVzuKQemkgcnR8ERZ6b17PlMPGFl2hxCvwfOmtf1JnQnZwo4rvcmIkGyqWXMlXtjn3NyQncp2R4x+Vz8NBMb0lisp5HLO3lnpd/OGto952So1dY40AOE3NvJclGyu3T9xw7xxvbK1CUotn6gGjTkUWb0sF7oEO08D6bOsTO0a81zatz49yjVt814hIjMcTZAQ19SLnlgzoKD9Se36iPgSTusigc+jeR3+FTjdir7NWKbOOWnTxCR8VzkpynWONc1dXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCZFE6dchRPH4UjuTwGd/zVR9PrRU78QyVrANr79aUo=;
 b=qwzmd2sT4KF3r+38/oeD+AI7W7Oh2K63/p0fC7bUhG74rrzHZMO4K+KW93efnw5s0vh4gZevTUn7QS6jI6N4qFU8CRc9ve7bIAx2EhkVaLGDyAL4uUdVPRzloWxCeNwaO5Ffu6rb1AXf5J8HK9BQkZRkFVOb1eBtBL9duGrG0dd6DmmWrQYRG0z/nnV9IrUT8rQdbMS3SErbzg3Wm8auHbKCEamBRM8ssiZhBHiVlobyAnjxYEcWixteltFQOLXs5yr9HAxx2wuiKuOcWf1FZUnqDwpauhPr/3TkQTgX/6FCRAHDEZ7/bzSRR1Yx3UC/5Vm+SpEF/HvBkxaDEbOFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCZFE6dchRPH4UjuTwGd/zVR9PrRU78QyVrANr79aUo=;
 b=saSZ5hSCoB/uspWD4WgrTu/KT/gsIufwH/x9vI9ntnFHx55tW4hCo2NdvRBq5Xn7PvfRgIL/fjWmRksrnJAJ3q0UpqOlfGODXwiCFxGZN34Oo1nsj29XHmqQ2TfkaD+BJfOfDWCeaP9sFQNplJH1ShnF3wJH+tjPPPNf3W8NBeSHnHQcMBSLmeTXl/rSWxjt73haopgoALjFPTf/dBiqnRJVIuhU7nIzNW0zmrCFeFUFTRCEVpN7uuzK9nwdv0lWPM5wRYjMaw3CtHZtoHVMHFbKNEfdCMbGHe9Cabz/jp4klPzLAP34tOUr6iINJlgZvn+AVKzGWStVCYIAYkAj2g==
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com (2603:1096:604:183::12)
 by TYAPR01MB5532.jpnprd01.prod.outlook.com (2603:1096:404:8040::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 11:04:43 +0000
Received: from OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7]) by OSZPR01MB8434.jpnprd01.prod.outlook.com
 ([fe80::7c3f:73bc:3c62:fe7%5]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 11:04:43 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	leitao@debian.org,
	chad@monroe.io,
	Bo.Jiao@mediatek.com,
	sujuan.chen@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	evelyn.tsai@mediatek.com,
	meichia.chiu@mediatek.com,
	Money.Wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 1/2] wifi: mt76: mt7915: fix register mapping
Date: Thu,  9 Jan 2025 19:04:35 +0800
Message-ID:
 <OSZPR01MB843401EAA1DA6BD7AEF356F298132@OSZPR01MB8434.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109110436.25870-1-wiagn233@outlook.com>
References: <20250109110436.25870-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::16) To OSZPR01MB8434.jpnprd01.prod.outlook.com
 (2603:1096:604:183::12)
X-Microsoft-Original-Message-ID: <20250109110436.25870-2-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8434:EE_|TYAPR01MB5532:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ea0468-5407-4996-844d-08dd309d6bdb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|15080799006|5072599009|19110799003|7092599003|1602099012|440099028|3412199025|4302099013|10035399004|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JbHBJbfFNfUPb2lPDghNM56SyaeARPxicUFLJGzPjNj/kgaGGFV9yvB311qW?=
 =?us-ascii?Q?3FI2sX32PDXUcofkSz2O2s/gQoi48/QEFQXpo/k7qI7j6Dd5IvcDBWaer8AB?=
 =?us-ascii?Q?VPj1PFPJl4iLa8RdABGPqgT/piz4qpuL9D5eWY6yvA8YXHftPE28bQHeFAqs?=
 =?us-ascii?Q?HxmAa01bvjbjuVX3eqbEeThOBMC6swIDSAesXcg2BZRCuIaGdvgTnd1LRVq3?=
 =?us-ascii?Q?DD5GwblL7RO5tPDMHsGWIJB0jUldLonqk6W4JG/i8MztrYlSitLRWUBkw1Z7?=
 =?us-ascii?Q?TZryOKr5tHjLs3xVDcLdDtJlB9C0bbgUdobD5myc2XYRaViJDJEK5IBaSTt/?=
 =?us-ascii?Q?QYkJ5rQ62akrOnjB73+aTSAzSmsw5BWDd8WClHr2ksrKflQOcH6XFU0HHBb7?=
 =?us-ascii?Q?zD1p8MMUbY7/aFOWZLMmAD2q7JQILHh4SH2bcehIA70xZqnT3reLBTV0s8Oj?=
 =?us-ascii?Q?6mxrpzdP22KosMP8rKoXeubPDg3F/y3MEJvlaO0g7NgZSq8gC1nWTEep2fjw?=
 =?us-ascii?Q?YEI25RxKrGPlgHt6IFfwY48YW+PkGrM76adiOKJaaiSdc9wpFfRDMvoMIV0r?=
 =?us-ascii?Q?b9DZ5CDA9cLUVVNv3a45xS9kSdsj3uOLuBIj3lpJy6NMO4ppAxedXKRkglSb?=
 =?us-ascii?Q?9WE65o1udW/XTk3Fp6nVyxvVz9wcDqg3eRfiLZvxZ7hVZNGeaIuk7FK2Evwi?=
 =?us-ascii?Q?qUkPKhwEZR2MeSxPR1cTFZVzxN8Y5tIhxcftygrIPZyN2POnk8MdTOEHvl7T?=
 =?us-ascii?Q?/lfhL51t+Hh9lQD0VKk3K+7GucSbrSlysmrpcyLtB4elEbbMxdDhLycGqNFL?=
 =?us-ascii?Q?6PJdxyNdr/4LUITViZIC5vUKecMlvH8p5MKtcWEZP6r1ceGhX+2LxEgt+dZ6?=
 =?us-ascii?Q?KFcUcG9FnAn9jf4zafBk7GUeT1+6JXIrzK4XB4wFpdAO0Pj2JrMGMEMaVyFZ?=
 =?us-ascii?Q?nw2w3c3qyFFxVCqgiLSuzJ4D6pFksjhAw1L6uMB81awqm+gtbKJIN7YDjfg3?=
 =?us-ascii?Q?T/nP1SAawc/l3NR781TmXGvKVJQRQLQUfh6Idr7Np79li2M0bCK7xW3QEXxP?=
 =?us-ascii?Q?8T2jGWCex7f8GhbNTtx4LJySnMDTyMwkmfh2i6+3Nl0ss4zfjAQMyFhbRlWK?=
 =?us-ascii?Q?rW/f01bseWZml0SLyoqSHMA7b/7fAcrspKueI0oEF7UmGJumupscImlx+X2J?=
 =?us-ascii?Q?zApd8csJ2J6+sRf4qODAbLpaYjGct9vQVdHqEQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vE7miSutoCEXwGE2bv/G2p8B1TTyONttzMWvcFmS3OQRcC6iaMvw64rn5fqI?=
 =?us-ascii?Q?jhIMK3aeo6gRJfpvxJ6matzhUSkWNP7Kh1D5eCJ8VchAh3OJyuSFKIwXRWig?=
 =?us-ascii?Q?b61dnKH3pJxDs33dwhIny7jrWm0v3oYeWO7mmeqJuaaVGUOBwJY2y02ExMEv?=
 =?us-ascii?Q?8e932C9w0aBOGZFyFJX57a4Ft5OxOEasWnZrAVosBk/9CrCQmM/qxZmwRCkZ?=
 =?us-ascii?Q?M6awi9OWbJh1WHOm66omPf96huNcRCj/nkt4kMqnCQGlTLYug+CXPfl7w3mp?=
 =?us-ascii?Q?ATLBife1y5Bjw0zN9au9jKa8W84trrXKwJu4slBZ+xnlTiHy9AkLS3GZZ+pR?=
 =?us-ascii?Q?5ZUTxWPo3W0Jwh7wWuwmomI9kAB8NGr6nxyByN7zE6V70yiwDxe2JhTRROvp?=
 =?us-ascii?Q?jAsODw5r2UNuyNDy1zsvpbOXyuHn9C41ElEnWxyiseUjsgokDaRafQSxHMao?=
 =?us-ascii?Q?Qjl5wxp2PLOPKfzNNLSNbKbTIEj2BWZ8vryid2GxBQ/sYUrMy0nEVu3FwEbP?=
 =?us-ascii?Q?9ObICnybWiVe0hPzi1jdSKsiFyHn1j9nG1sZOHskuG4Vq02l9aYIBACNhutX?=
 =?us-ascii?Q?dPtt1zAXvJak3XAOG82HDKvTSwp85Pj1p4webOUI6YC2Hz3mmw2MbtD4Q3e0?=
 =?us-ascii?Q?o6IrpCY3CDSal+nlGGq8u56vaISkje3lB0e++QvYRUGhN5U3eUnpPNmkEetU?=
 =?us-ascii?Q?Hrq/faEdCPZfGReTpPrv7gFkhFXOzL2jEZOZQjpJqb3kkZmYMXZvxY3ANXlb?=
 =?us-ascii?Q?z0ETzP+vuaS2f8YeotWNA92dH+7B4Bcav2J6ENzWwZu1Heov/EmPf15OIA1t?=
 =?us-ascii?Q?F6ySOq6ZO921oi881gtJQ6VAt2Y8h+HOK7QQxGoP9xlO2sHB+2O+XMcPKs9S?=
 =?us-ascii?Q?/PWyWkXhodvsW+s9763zdNUfSpCLBhzQci19kthUvaPE639lmXjwnQzrGHxb?=
 =?us-ascii?Q?j1a+RZBC5y3IzXOP+/bOV+TWa0j1MLh/NqGjISCvv1dH8iaWTCFXI2pN39nf?=
 =?us-ascii?Q?MUetdS2uEk8ALRx9ghk/7UPww3ByHeUprllQfCcgiv7elJXF3Tuv9GKHfcWk?=
 =?us-ascii?Q?R3Yd0pdpDT23WcBWe1TzbSKMEljJxpOWZHNVIJD3kcjfgJodwLqAHDCqqeq5?=
 =?us-ascii?Q?SyQ/A7dA0dyqKGXKPKvG9jahAdeswCkI1c7867ErZBxXI8jP4Z7OFz+Cwhkr?=
 =?us-ascii?Q?NY/sEj2sh5z6aCjQMC0iaGuLm36mDOajLNi5mk3B3RId+EJpn+qICEHgoaft?=
 =?us-ascii?Q?CcbmswjpDi/fO4cdQ9e0KuAUPhFwYgWSnHDB+wkNPVserhReEVElyxJYI+9o?=
 =?us-ascii?Q?PjE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ea0468-5407-4996-844d-08dd309d6bdb
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8434.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:04:43.6468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5532

Bypass the entry when ofs is equal to dev->reg.map[i].size.
Without this patch, it would get incorrect register mapping when the CR
address is located at the boundary of an entry.

SDK patch: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/3627eb7e975959ed944e333e383e92f01ac5cdb9/autobuild/autobuild_5.4_mac80211_release/package/kernel/mt76/patches/0026-wifi-mt76-mt7915-fix-register-mapping.patch

Fixes: cd4c314a65d3 ("mt76: mt7915: refine register definition")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 530182e20ce2..876f0692850a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -486,7 +486,7 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 			continue;
 
 		ofs = addr - dev->reg.map[i].phys;
-		if (ofs > dev->reg.map[i].size)
+		if (ofs >= dev->reg.map[i].size)
 			continue;
 
 		return dev->reg.map[i].maps + ofs;
-- 
2.43.0


