Return-Path: <linux-wireless+bounces-2244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF3E832612
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35742858E5
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE062942E;
	Fri, 19 Jan 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NQUeag5C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF30288DD
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654668; cv=none; b=T/gchFeQaMRQrGJZMY1XSXiXbMe++7pYsk0SBfrb43pR9pNP89QIYx/g4QAUq6XkArPqj0xQajb4wpPz4NmnaejW2o7Q39I191A3MtHB7U8bmkooEEqB7OuH6gu25H5kO3N2a+QehSRFESAq7WexzPQmpk1kGxxy+nbQxmbiGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654668; c=relaxed/simple;
	bh=utGuQY8THoMS2YfyOc+5EUfZo4qx5ZqQlIrADnMJj4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCyR4iv7lTtLi0JauBOc7F1I/QR9VClU24ulxNDVPyj2q0mkktgoM3Uvk4qcACsKSv60SGEnyLdaIIUc4nhjmEIZA9UAjQU/xuNVN4d6oKGXckrbeeFl3e1knObmGKT7OD7nis+rIUn/Rs93b6udfhbAPXNS+jhz89CQ1UTpRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NQUeag5C; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cb7a381eb6a811eea2298b7352fd921d-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=K0zyQKV5np2tMpTf/XlhiaVAYdwVNvNwKoQ+98xgoIM=;
	b=NQUeag5CkOn33UAf3n8d22QwMmhY1QY6ShpIjqmGm6/J1tTKsRhVfHTQGLUMOsbC0qgBkEfotRFP+csi7yJrnMRxcwmNSDd0TXiHJntAOY5rHJmjvxSDzt59G40MVFKFU0Hq9/RNd52DWg8nAMpjFR0oCMTaxHiQzZJWgS8ne6A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:ed1b71d0-236c-4c30-888b-d3695c5860ce,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:1f7b6e8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: cb7a381eb6a811eea2298b7352fd921d-20240119
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1627173463; Fri, 19 Jan 2024 16:57:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jan 2024 16:57:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jan 2024 16:57:36 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 10/12] wifi: mt76: mt7996: add locking for accessing mapped registers
Date: Fri, 19 Jan 2024 16:57:06 +0800
Message-ID: <20240119085708.23592-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240119085708.23592-1-shayne.chen@mediatek.com>
References: <20240119085708.23592-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

A race condition was observed when accessing mapped registers, so add
locking to protect against concurrent access.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 64 ++++++++++++-------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  3 +-
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index c50d89a445e9..ff6a335e1fa7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -140,7 +140,6 @@ static u32 mt7996_reg_map_l1(struct mt7996_dev *dev, u32 addr)
 	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
 	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
 
-	dev->reg_l1_backup = dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L1);
 	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L1,
 			  MT_HIF_REMAP_L1_MASK,
 			  FIELD_PREP(MT_HIF_REMAP_L1_MASK, base));
@@ -155,7 +154,6 @@ static u32 mt7996_reg_map_l2(struct mt7996_dev *dev, u32 addr)
 	u32 offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
 	u32 base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
 
-	dev->reg_l2_backup = dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
 	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2,
 			  MT_HIF_REMAP_L2_MASK,
 			  FIELD_PREP(MT_HIF_REMAP_L2_MASK, base));
@@ -165,26 +163,10 @@ static u32 mt7996_reg_map_l2(struct mt7996_dev *dev, u32 addr)
 	return MT_HIF_REMAP_BASE_L2 + offset;
 }
 
-static void mt7996_reg_remap_restore(struct mt7996_dev *dev)
-{
-	/* remap to ori status */
-	if (unlikely(dev->reg_l1_backup)) {
-		dev->bus_ops->wr(&dev->mt76, MT_HIF_REMAP_L1, dev->reg_l1_backup);
-		dev->reg_l1_backup = 0;
-	}
-
-	if (dev->reg_l2_backup) {
-		dev->bus_ops->wr(&dev->mt76, MT_HIF_REMAP_L2, dev->reg_l2_backup);
-		dev->reg_l2_backup = 0;
-	}
-}
-
 static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
 {
 	int i;
 
-	mt7996_reg_remap_restore(dev);
-
 	if (addr < 0x100000)
 		return addr;
 
@@ -201,6 +183,11 @@ static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
 		return dev->reg.map[i].mapped + ofs;
 	}
 
+	return 0;
+}
+
+static u32 __mt7996_reg_remap_addr(struct mt7996_dev *dev, u32 addr)
+{
 	if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
 	    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
 	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END))
@@ -225,28 +212,60 @@ void mt7996_memcpy_fromio(struct mt7996_dev *dev, void *buf, u32 offset,
 {
 	u32 addr = __mt7996_reg_addr(dev, offset);
 
-	memcpy_fromio(buf, dev->mt76.mmio.regs + addr, len);
+	if (addr) {
+		memcpy_fromio(buf, dev->mt76.mmio.regs + addr, len);
+		return;
+	}
+
+	spin_lock_bh(&dev->reg_lock);
+	memcpy_fromio(buf, dev->mt76.mmio.regs +
+			   __mt7996_reg_remap_addr(dev, offset), len);
+	spin_unlock_bh(&dev->reg_lock);
 }
 
 static u32 mt7996_rr(struct mt76_dev *mdev, u32 offset)
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	u32 addr = __mt7996_reg_addr(dev, offset), val;
+
+	if (addr)
+		return dev->bus_ops->rr(mdev, addr);
 
-	return dev->bus_ops->rr(mdev, __mt7996_reg_addr(dev, offset));
+	spin_lock_bh(&dev->reg_lock);
+	val = dev->bus_ops->rr(mdev, __mt7996_reg_remap_addr(dev, offset));
+	spin_unlock_bh(&dev->reg_lock);
+
+	return val;
 }
 
 static void mt7996_wr(struct mt76_dev *mdev, u32 offset, u32 val)
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	u32 addr = __mt7996_reg_addr(dev, offset);
 
-	dev->bus_ops->wr(mdev, __mt7996_reg_addr(dev, offset), val);
+	if (addr) {
+		dev->bus_ops->wr(mdev, addr, val);
+		return;
+	}
+
+	spin_lock_bh(&dev->reg_lock);
+	dev->bus_ops->wr(mdev, __mt7996_reg_remap_addr(dev, offset), val);
+	spin_unlock_bh(&dev->reg_lock);
 }
 
 static u32 mt7996_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	u32 addr = __mt7996_reg_addr(dev, offset);
+
+	if (addr)
+		return dev->bus_ops->rmw(mdev, addr, mask, val);
+
+	spin_lock_bh(&dev->reg_lock);
+	val = dev->bus_ops->rmw(mdev, __mt7996_reg_remap_addr(dev, offset), mask, val);
+	spin_unlock_bh(&dev->reg_lock);
 
-	return dev->bus_ops->rmw(mdev, __mt7996_reg_addr(dev, offset), mask, val);
+	return val;
 }
 
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
@@ -421,6 +440,7 @@ static int mt7996_mmio_init(struct mt76_dev *mdev,
 
 	dev = container_of(mdev, struct mt7996_dev, mt76);
 	mt76_mmio_init(&dev->mt76, mem_base);
+	spin_lock_init(&dev->reg_lock);
 
 	switch (device_id) {
 	case 0x7990:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 8154ad37827f..36d1f247d55a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -325,8 +325,7 @@ struct mt7996_dev {
 		u8 n_agrt;
 	} twt;
 
-	u32 reg_l1_backup;
-	u32 reg_l2_backup;
+	spinlock_t reg_lock;
 
 	u8 wtbl_size_group;
 };
-- 
2.39.2


