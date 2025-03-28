Return-Path: <linux-wireless+bounces-20921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A775A743A8
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4813B1892926
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4776421171D;
	Fri, 28 Mar 2025 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VaKliTAw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD521018A
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141249; cv=none; b=CX48VIBIXGjhzpyAkF5syGhpfjnGjumcF5GJC4Lxlw9m2eFYdDB9AC6CWV3lV1mCMXU+HCY/Yd9j3FSQC3Wk2lOXHn7/VzNcY6m7nQzDzcWjnsoaBrlPcqxLGiaXRbA3bV9ISqbCi9YvL0MkH2dOGbnqSQSOlVXBFAfcH2hswYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141249; c=relaxed/simple;
	bh=HzfZ36s/6mA4yXw0FytqutZlqSK/6tZIGAq6HURSBXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dR2V3VreIrc63JjsLUXwDy9pCDjwPXQCIGl8Gh02cuG7rHzotLK0RJISh0YW4Qulw3H7u4gRyISIQLOUGfh4mZrh61y2smqqMLqdNnqhgnBevUKIXcT8xKpV1tUBSb6W0iLt5htlzO3m8pryzTixLURwOllLYOlR+/RIBS1K3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VaKliTAw; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0b42d64a0b9911f08eb9c36241bbb6fb-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ORYWmPk8ADrE9mxDQmnh8WLjbCoSun65/Nzkwh9xP5A=;
	b=VaKliTAw583gl+CtYtRTBs3Y4ep1CGLLluUjKamKZgUqZjSxrRHaAd2JSBUe9T8q40cMezKJuIh3ZhO6B6IlML7PcsmsV6wFy89fQWTYIW0PtCVu0JADdBoHLx7RKHfAGXp1Lkxq4L74hKbLBFFsWUxNvE9jHROLdpzzD8SAvp0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:760de8d4-bee4-457b-9a15-0117c41234cf,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:0c9c67a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0b42d64a0b9911f08eb9c36241bbb6fb-20250328
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1476235165; Fri, 28 Mar 2025 13:53:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 13:53:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 13:53:57 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 05/10] wifi: mt76: mt7996: rework register mapping for mt7990
Date: Fri, 28 Mar 2025 13:50:53 +0800
Message-ID: <20250328055058.1648755-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328055058.1648755-1-shayne.chen@mediatek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Rework register offset and l1/l2/cbtop mapping for mt7990.
This is a preliminary patch to support mt7990 chipset.

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 186 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  47 +++--
 2 files changed, 208 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 8b07883f45cc..51dd9a5f83cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -54,6 +54,17 @@ static const u32 mt7996_offs[] = {
 	[MIB_BSCR7]		= 0x9e8,
 	[MIB_BSCR17]		= 0xa10,
 	[MIB_TRDR1]		= 0xa28,
+	[HIF_REMAP_L1]		= 0x24,
+	[HIF_REMAP_BASE_L1]	= 0x130000,
+	[HIF_REMAP_L2]		= 0x1b4,
+	[HIF_REMAP_BASE_L2]	= 0x1000,
+	[CBTOP1_PHY_END]	= 0x77ffffff,
+	[INFRA_MCU_END]		= 0x7c3fffff,
+	[WTBLON_WDUCR]		= 0x370,
+	[WTBL_UPDATE]		= 0x380,
+	[WTBL_ITCR]		= 0x3b0,
+	[WTBL_ITCR0]		= 0x3b8,
+	[WTBL_ITCR1]		= 0x3bc,
 };
 
 static const u32 mt7992_offs[] = {
@@ -80,6 +91,54 @@ static const u32 mt7992_offs[] = {
 	[MIB_BSCR7]		= 0xae4,
 	[MIB_BSCR17]		= 0xb0c,
 	[MIB_TRDR1]		= 0xb24,
+	[HIF_REMAP_L1]		= 0x8,
+	[HIF_REMAP_BASE_L1]	= 0x40000,
+	[HIF_REMAP_L2]		= 0x1b4,
+	[HIF_REMAP_BASE_L2]	= 0x1000,
+	[CBTOP1_PHY_END]	= 0x77ffffff,
+	[INFRA_MCU_END]		= 0x7c3fffff,
+	[WTBLON_WDUCR]		= 0x370,
+	[WTBL_UPDATE]		= 0x380,
+	[WTBL_ITCR]		= 0x3b0,
+	[WTBL_ITCR0]		= 0x3b8,
+	[WTBL_ITCR1]		= 0x3bc,
+};
+
+static const u32 mt7990_offs[] = {
+	[MIB_RVSR0]		= 0x800,
+	[MIB_RVSR1]		= 0x804,
+	[MIB_BTSCR5]		= 0x868,
+	[MIB_BTSCR6]		= 0x878,
+	[MIB_RSCR1]		= 0x890,
+	[MIB_RSCR27]		= 0xa38,
+	[MIB_RSCR28]		= 0xa3c,
+	[MIB_RSCR29]		= 0xa40,
+	[MIB_RSCR30]		= 0xa44,
+	[MIB_RSCR31]		= 0xa48,
+	[MIB_RSCR33]		= 0xa50,
+	[MIB_RSCR35]		= 0xa58,
+	[MIB_RSCR36]		= 0xa5c,
+	[MIB_BSCR0]		= 0xbb8,
+	[MIB_BSCR1]		= 0xbbc,
+	[MIB_BSCR2]		= 0xbc0,
+	[MIB_BSCR3]		= 0xbc4,
+	[MIB_BSCR4]		= 0xbc8,
+	[MIB_BSCR5]		= 0xbcc,
+	[MIB_BSCR6]		= 0xbd0,
+	[MIB_BSCR7]		= 0xbd4,
+	[MIB_BSCR17]		= 0xbfc,
+	[MIB_TRDR1]		= 0xc14,
+	[HIF_REMAP_L1]		= 0x8,
+	[HIF_REMAP_BASE_L1]	= 0x40000,
+	[HIF_REMAP_L2]		= 0x1b8,
+	[HIF_REMAP_BASE_L2]	= 0x110000,
+	[CBTOP1_PHY_END]	= 0x7fffffff,
+	[INFRA_MCU_END]		= 0x7cffffff,
+	[WTBLON_WDUCR]		= 0x400,
+	[WTBL_UPDATE]		= 0x410,
+	[WTBL_ITCR]		= 0x440,
+	[WTBL_ITCR0]		= 0x448,
+	[WTBL_ITCR1]		= 0x44c,
 };
 
 static const struct __map mt7996_reg_map[] = {
@@ -135,14 +194,83 @@ static const struct __map mt7996_reg_map[] = {
 	{ 0x0, 0x0, 0x0 }, /* imply end of search */
 };
 
+static const struct __map mt7990_reg_map[] = {
+	{0x54000000, 0x02000, 0x1000}, /* WFDMA_0 (PCIE0 MCU DMA0) */
+	{0x55000000, 0x03000, 0x1000}, /* WFDMA_1 (PCIE0 MCU DMA1) */
+	{0x56000000, 0x04000, 0x1000}, /* WFDMA_2 (Reserved) */
+	{0x57000000, 0x05000, 0x1000}, /* WFDMA_3 (MCU wrap CR) */
+	{0x58000000, 0x06000, 0x1000}, /* WFDMA_4 (PCIE1 MCU DMA0 (MEM_DMA)) */
+	{0x59000000, 0x07000, 0x1000}, /* WFDMA_5 (PCIE1 MCU DMA1) */
+	{0x820c0000, 0x08000, 0x4000}, /* WF_UMAC_TOP (PLE) */
+	{0x820c8000, 0x0c000, 0x2000}, /* WF_UMAC_TOP (PSE) */
+	{0x820cc000, 0x0e000, 0x2000}, /* WF_UMAC_TOP (PP) */
+	{0x820e0000, 0x20000, 0x0400}, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{0x820e1000, 0x20400, 0x0200}, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{0x820e2000, 0x20800, 0x0400}, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{0x820e3000, 0x20c00, 0x0400}, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{0x820e4000, 0x21000, 0x0400}, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{0x820e5000, 0x21400, 0x0800}, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{0x820ce000, 0x21c00, 0x0200}, /* WF_LMAC_TOP (WF_SEC) */
+	{0x820e7000, 0x21e00, 0x0200}, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{0x820cf000, 0x22000, 0x1000}, /* WF_LMAC_TOP (WF_PF) */
+	{0x820e9000, 0x23400, 0x0200}, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{0x820ea000, 0x24000, 0x0200}, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{0x820eb000, 0x24200, 0x0400}, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{0x820ec000, 0x24600, 0x0200}, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{0x820ed000, 0x24800, 0x0800}, /* WF_LMAC_TOP BN0 (WF_MIB) */
+	{0x820ca000, 0x26000, 0x2000}, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
+	{0x820d0000, 0x30000, 0x10000}, /* WF_LMAC_TOP (WF_WTBLON) */
+	{0x00400000, 0x80000, 0x10000}, /* WF_MCU_SYSRAM */
+	{0x820f0000, 0xa0000, 0x0400}, /* WF_LMAC_TOP BN1 (WF_CFG) */
+	{0x820f1000, 0xa0600, 0x0200}, /* WF_LMAC_TOP BN1 (WF_TRB) */
+	{0x820f2000, 0xa0800, 0x0400}, /* WF_LMAC_TOP BN1 (WF_AGG) */
+	{0x820f3000, 0xa0c00, 0x0400}, /* WF_LMAC_TOP BN1 (WF_ARB) */
+	{0x820f4000, 0xa1000, 0x0400}, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+	{0x820f5000, 0xa1400, 0x0800}, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+	{0x820f7000, 0xa1e00, 0x0200}, /* WF_LMAC_TOP BN1 (WF_DMA) */
+	{0x820f9000, 0xa3400, 0x0200}, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+	{0x820fa000, 0xa4000, 0x0200}, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+	{0x820fb000, 0xa4200, 0x0400}, /* WF_LMAC_TOP BN1 (WF_LPON) */
+	{0x820fc000, 0xa4600, 0x0200}, /* WF_LMAC_TOP BN1 (WF_INT) */
+	{0x820fd000, 0xa4800, 0x0800}, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	{0x820cc000, 0xa5000, 0x2000}, /* WF_LMAC_TOP BN1 (WF_MUCOP) */
+	{0x820c4000, 0xa8000, 0x4000}, /* WF_LMAC_TOP (WF_UWTBL) */
+	{0x81030000, 0xae000, 0x100}, /* WFSYS_AON part 1 */
+	{0x81031000, 0xae100, 0x100}, /* WFSYS_AON part 2 */
+	{0x81032000, 0xae200, 0x100}, /* WFSYS_AON part 3 */
+	{0x81033000, 0xae300, 0x100}, /* WFSYS_AON part 4 */
+	{0x81034000, 0xae400, 0x100}, /* WFSYS_AON part 5 */
+	{0x80020000, 0xb0000, 0x10000}, /* WF_TOP_MISC_OFF */
+	{0x81020000, 0xc0000, 0x10000}, /* WF_TOP_MISC_ON */
+	{0x81040000, 0x120000, 0x1000}, /* WF_MCU_CFG_ON */
+	{0x81050000, 0x121000, 0x1000}, /* WF_MCU_EINT */
+	{0x81060000, 0x122000, 0x1000}, /* WF_MCU_GPT */
+	{0x81070000, 0x123000, 0x1000}, /* WF_MCU_WDT */
+	{0x80010000, 0x124000, 0x1000}, /* WF_AXIDMA */
+	{0x7c020000, 0xd0000, 0x10000}, /* CONN_INFRA, wfdma for from CODA flow use */
+	{0x7c060000, 0xe0000, 0x10000}, /* CONN_INFRA, conn_host_csr_top for from CODA flow use */
+	{0x20020000, 0xd0000, 0x10000}, /* CONN_INFRA, wfdma */
+	{0x20060000, 0xe0000, 0x10000}, /* CONN_INFRA, conn_host_csr_top */
+	{0x7c000000, 0xf0000, 0x10000}, /* CONN_INFRA */
+	{0x70020000, 0x1f0000, 0x9000}, /* PCIE remapping (AP2CONN) */
+	{0x0, 0x0, 0x0}, /* imply end of search */
+};
+
 static u32 mt7996_reg_map_l1(struct mt7996_dev *dev, u32 addr)
 {
 	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
 	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+	u32 l1_mask, val;
+
+	if (is_mt7996(&dev->mt76)) {
+		l1_mask = MT_HIF_REMAP_L1_MASK_7996;
+		val = FIELD_PREP(MT_HIF_REMAP_L1_MASK_7996, base);
+	} else {
+		l1_mask = MT_HIF_REMAP_L1_MASK;
+		val = FIELD_PREP(MT_HIF_REMAP_L1_MASK, base);
+	}
 
-	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L1,
-			  MT_HIF_REMAP_L1_MASK,
-			  FIELD_PREP(MT_HIF_REMAP_L1_MASK, base));
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L1, l1_mask, val);
 	/* use read to push write */
 	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L1);
 
@@ -151,18 +279,41 @@ static u32 mt7996_reg_map_l1(struct mt7996_dev *dev, u32 addr)
 
 static u32 mt7996_reg_map_l2(struct mt7996_dev *dev, u32 addr)
 {
-	u32 offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
-	u32 base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
+	u32 offset, base, l2_mask, val;
 
-	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2,
-			  MT_HIF_REMAP_L2_MASK,
-			  FIELD_PREP(MT_HIF_REMAP_L2_MASK, base));
+	if (is_mt7990(&dev->mt76)) {
+		offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET_7990, addr);
+		base = FIELD_GET(MT_HIF_REMAP_L2_BASE_7990, addr);
+		l2_mask = MT_HIF_REMAP_L2_MASK_7990;
+		val = FIELD_PREP(MT_HIF_REMAP_L2_MASK_7990, base);
+	} else {
+		offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
+		base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
+		l2_mask = MT_HIF_REMAP_L2_MASK;
+		val = FIELD_PREP(MT_HIF_REMAP_L2_MASK, base);
+	}
+
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2, l2_mask, val);
 	/* use read to push write */
 	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
 
 	return MT_HIF_REMAP_BASE_L2 + offset;
 }
 
+static u32 mt7996_reg_map_cbtop(struct mt7996_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_CBTOP_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_CBTOP_BASE, addr);
+
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_CBTOP,
+			  MT_HIF_REMAP_CBTOP_MASK,
+			  FIELD_PREP(MT_HIF_REMAP_CBTOP_MASK, base));
+	/* use read to push write */
+	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_CBTOP);
+
+	return MT_HIF_REMAP_BASE_CBTOP + offset;
+}
+
 static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
 {
 	int i;
@@ -193,17 +344,20 @@ static u32 __mt7996_reg_remap_addr(struct mt7996_dev *dev, u32 addr)
 	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END))
 		return mt7996_reg_map_l1(dev, addr);
 
-	if (dev_is_pci(dev->mt76.dev) &&
-	    ((addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
-	    addr >= MT_CBTOP2_PHY_START))
-		return mt7996_reg_map_l1(dev, addr);
-
 	/* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
 	if (addr >= MT_INFRA_MCU_START && addr <= MT_INFRA_MCU_END) {
 		addr = addr - MT_INFRA_MCU_START + MT_INFRA_BASE;
 		return mt7996_reg_map_l1(dev, addr);
 	}
 
+	if (dev_is_pci(dev->mt76.dev) &&
+	    ((addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
+	    addr >= MT_CBTOP2_PHY_START)) {
+		if (is_mt7990(&dev->mt76))
+			return mt7996_reg_map_cbtop(dev, addr);
+		return mt7996_reg_map_l1(dev, addr);
+	}
+
 	return mt7996_reg_map_l2(dev, addr);
 }
 
@@ -455,6 +609,12 @@ static int mt7996_mmio_init(struct mt76_dev *mdev,
 		dev->reg.map = mt7996_reg_map;
 		dev->reg.map_size = ARRAY_SIZE(mt7996_reg_map);
 		break;
+	case MT7990_DEVICE_ID:
+		dev->reg.base = mt7996_reg_base;
+		dev->reg.offs_rev = mt7990_offs;
+		dev->reg.map = mt7990_reg_map;
+		dev->reg.map_size = ARRAY_SIZE(mt7990_reg_map);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 1981b6250f45..e942c0058731 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -64,6 +64,17 @@ enum offs_rev {
 	MIB_BSCR7,
 	MIB_BSCR17,
 	MIB_TRDR1,
+	HIF_REMAP_L1,
+	HIF_REMAP_BASE_L1,
+	HIF_REMAP_L2,
+	HIF_REMAP_BASE_L2,
+	CBTOP1_PHY_END,
+	INFRA_MCU_END,
+	WTBLON_WDUCR,
+	WTBL_UPDATE,
+	WTBL_ITCR,
+	WTBL_ITCR0,
+	WTBL_ITCR1,
 	__MT_OFFS_MAX,
 };
 
@@ -291,19 +302,19 @@ enum offs_rev {
 /* WTBLON TOP */
 #define MT_WTBLON_TOP_BASE			0x820d4000
 #define MT_WTBLON_TOP(ofs)			(MT_WTBLON_TOP_BASE + (ofs))
-#define MT_WTBLON_TOP_WDUCR			MT_WTBLON_TOP(0x370)
+#define MT_WTBLON_TOP_WDUCR			MT_WTBLON_TOP(__OFFS(WTBLON_WDUCR))
 #define MT_WTBLON_TOP_WDUCR_GROUP		GENMASK(4, 0)
 
-#define MT_WTBL_UPDATE				MT_WTBLON_TOP(0x380)
+#define MT_WTBL_UPDATE				MT_WTBLON_TOP(__OFFS(WTBL_UPDATE))
 #define MT_WTBL_UPDATE_WLAN_IDX			GENMASK(11, 0)
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR		BIT(14)
 #define MT_WTBL_UPDATE_BUSY			BIT(31)
 
-#define MT_WTBL_ITCR				MT_WTBLON_TOP(0x3b0)
+#define MT_WTBL_ITCR				MT_WTBLON_TOP(__OFFS(WTBL_ITCR))
 #define MT_WTBL_ITCR_WR				BIT(16)
 #define MT_WTBL_ITCR_EXEC			BIT(31)
-#define MT_WTBL_ITDR0				MT_WTBLON_TOP(0x3b8)
-#define MT_WTBL_ITDR1				MT_WTBLON_TOP(0x3bc)
+#define MT_WTBL_ITDR0				MT_WTBLON_TOP(__OFFS(WTBL_ITCR0))
+#define MT_WTBL_ITDR1				MT_WTBLON_TOP(__OFFS(WTBL_ITCR1))
 #define MT_WTBL_SPE_IDX_SEL			BIT(6)
 
 /* WTBL */
@@ -578,27 +589,39 @@ enum offs_rev {
 #define MT_MCU_CMD_WDT_MASK			GENMASK(31, 30)
 
 /* l1/l2 remap */
-#define MT_HIF_REMAP_L1				0x155024
-#define MT_HIF_REMAP_L1_MASK			GENMASK(31, 16)
+#define CONN_BUS_CR_VON_BASE			0x155000
+#define MT_HIF_REMAP_L1				(CONN_BUS_CR_VON_BASE + __OFFS(HIF_REMAP_L1))
+#define MT_HIF_REMAP_L1_MASK_7996		GENMASK(31, 16)
+#define MT_HIF_REMAP_L1_MASK			GENMASK(15, 0)
 #define MT_HIF_REMAP_L1_OFFSET			GENMASK(15, 0)
 #define MT_HIF_REMAP_L1_BASE			GENMASK(31, 16)
-#define MT_HIF_REMAP_BASE_L1			0x130000
+#define MT_HIF_REMAP_BASE_L1			__OFFS(HIF_REMAP_BASE_L1)
 
-#define MT_HIF_REMAP_L2				0x1b4
+#define MT_HIF_REMAP_L2				__OFFS(HIF_REMAP_L2)
 #define MT_HIF_REMAP_L2_MASK			GENMASK(19, 0)
 #define MT_HIF_REMAP_L2_OFFSET			GENMASK(11, 0)
 #define MT_HIF_REMAP_L2_BASE			GENMASK(31, 12)
-#define MT_HIF_REMAP_BASE_L2			0x1000
+#define MT_HIF_REMAP_L2_MASK_7990		GENMASK(15, 0)
+#define MT_HIF_REMAP_L2_OFFSET_7990		GENMASK(15, 0)
+#define MT_HIF_REMAP_L2_BASE_7990		GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L2			__OFFS(HIF_REMAP_BASE_L2)
+
+/* for mt7990 only */
+#define MT_HIF_REMAP_CBTOP			0x1f6554
+#define MT_HIF_REMAP_CBTOP_MASK			GENMASK(15, 0)
+#define MT_HIF_REMAP_CBTOP_OFFSET		GENMASK(15, 0)
+#define MT_HIF_REMAP_CBTOP_BASE			GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_CBTOP			0x1c0000
 
 #define MT_INFRA_BASE				0x18000000
 #define MT_WFSYS0_PHY_START			0x18400000
 #define MT_WFSYS1_PHY_START			0x18800000
 #define MT_WFSYS1_PHY_END			0x18bfffff
 #define MT_CBTOP1_PHY_START			0x70000000
-#define MT_CBTOP1_PHY_END			0x77ffffff
+#define MT_CBTOP1_PHY_END			__OFFS(CBTOP1_PHY_END)
 #define MT_CBTOP2_PHY_START			0xf0000000
 #define MT_INFRA_MCU_START			0x7c000000
-#define MT_INFRA_MCU_END			0x7c3fffff
+#define MT_INFRA_MCU_END			__OFFS(INFRA_MCU_END)
 
 /* FW MODE SYNC */
 #define MT_FW_ASSERT_CNT			0x02208274
-- 
2.39.2


