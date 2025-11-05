Return-Path: <linux-wireless+bounces-28564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52658C34E47
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC85649A6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8C630ACFB;
	Wed,  5 Nov 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C3MXs85n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161F305E38
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335099; cv=none; b=Ew0cT2duNAlizQ56ouFdrWo6wIveD3ur9INZRBI95fpuhtI5XuyHTfhhR9d/NixAT6HCtugok9o9eGOm7E3xx4JpQVWCI20B1g+7gbHvzyzNZLKmzPgIvxHTslaF8JLjbbO1y9F2BhzaoUPbs1uwPMnIpcQBGE39W+JKvCTSAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335099; c=relaxed/simple;
	bh=UYAN7fz/wFz2EndwoxUWgthuW5cEeZL/bVMiEVMxwkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia0fxCL1z3SZyKbj7kYOWgwQfw+RtMlAMkKxIvsc7jj+XvCB0QR7EmPx76QLF1yDYOlUx+xcZ9zM0XYB5oJcfgPUV77qkTFf75kDoApy0bdlPJSD6+9PmlJjGxhlRHpdJNWP7AINnkKmLtCnh7f4/frv9/Ug5yBgtcZ0ad1Aw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=C3MXs85n; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 36eec002ba2a11f0b33aeb1e7f16c2b6-20251105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ke7DYEgo5Pazw+azwqJIhOKD05nu/fkzTd6SQ7Ywwys=;
	b=C3MXs85nTyOmprguKglb/2zGnruBmerPiHj3z/Ubjqw5hfCHhSKxonPVpnKYBQhQPzLP956Q6F5fkZmE6+Ev3TqZfI12GVyRNIlTbhptQ0RyLOHc56wBzxOgLxtiQODNetsQaX5aCjSr9GaafGUbbEVgQZDUulh84l9Ly+aHgDU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:14924b37-b008-4e6e-877c-93fe777167f7,IP:0,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:c9d7106b-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:1|19,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 36eec002ba2a11f0b33aeb1e7f16c2b6-20251105
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 725518221; Wed, 05 Nov 2025 17:31:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 5 Nov 2025 17:31:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 5 Nov 2025 17:31:30 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	Rex Lu <rex.lu@mediatek.com>
Subject: [PATCH mt76 12/12] wifi: mt76: mt7996: fix EMI rings for RRO
Date: Wed, 5 Nov 2025 17:31:00 +0800
Message-ID: <20251105093100.541408-12-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251105093100.541408-1-shayne.chen@mediatek.com>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The RRO EMI rings only need to be allocated when WED is not active.
This patch fixes command timeout issue for the setting of WED off and
RRO on.

Fixes: 3a29164425e9 ("wifi: mt76: mt7996: Add SW path for HW-RRO v3.1")
Co-developed-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 15 +++++++++------
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 19 ++++++++++++++++---
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 7ac4defca29d..274b273df1ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -515,12 +515,15 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 		if (ret)
 			return ret;
 
-		/* We need to set cpu idx pointer before resetting the EMI
-		 * queues.
-		 */
-		mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].emi_cpu_idx =
-			&dev->wed_rro.emi_rings_cpu.ptr->ring[0].idx;
-		mt76_queue_reset(dev, &mdev->q_rx[MT_RXQ_RRO_RXDMAD_C], true);
+		if (!mtk_wed_device_active(&mdev->mmio.wed)) {
+			/* We need to set cpu idx pointer before resetting the
+			 * EMI queues.
+			 */
+			mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].emi_cpu_idx =
+				&dev->wed_rro.emi_rings_cpu.ptr->ring[0].idx;
+			mt76_queue_reset(dev, &mdev->q_rx[MT_RXQ_RRO_RXDMAD_C],
+					 true);
+		}
 		goto start_hw_rro;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index bd7b720c64c5..00a8286bd136 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -960,9 +960,10 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 		       MT7996_RRO_MSDU_PG_SIZE_PER_CR);
 	}
 
-	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
+	if (!mtk_wed_device_active(&dev->mt76.mmio.wed) &&
+	    dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
 		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
-					  sizeof(dev->wed_rro.emi_rings_cpu.ptr),
+					  sizeof(*dev->wed_rro.emi_rings_cpu.ptr),
 					  &dev->wed_rro.emi_rings_cpu.phy_addr,
 					  GFP_KERNEL);
 		if (!ptr)
@@ -971,7 +972,7 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 		dev->wed_rro.emi_rings_cpu.ptr = ptr;
 
 		ptr = dmam_alloc_coherent(dev->mt76.dma_dev,
-					  sizeof(dev->wed_rro.emi_rings_dma.ptr),
+					  sizeof(*dev->wed_rro.emi_rings_dma.ptr),
 					  &dev->wed_rro.emi_rings_dma.phy_addr,
 					  GFP_KERNEL);
 		if (!ptr)
@@ -1037,6 +1038,18 @@ static void mt7996_wed_rro_free(struct mt7996_dev *dev)
 				   dev->wed_rro.msdu_pg[i].phy_addr);
 	}
 
+	if (dev->wed_rro.emi_rings_cpu.ptr)
+		dmam_free_coherent(dev->mt76.dma_dev,
+				   sizeof(*dev->wed_rro.emi_rings_cpu.ptr),
+				   dev->wed_rro.emi_rings_cpu.ptr,
+				   dev->wed_rro.emi_rings_cpu.phy_addr);
+
+	if (dev->wed_rro.emi_rings_dma.ptr)
+		dmam_free_coherent(dev->mt76.dma_dev,
+				   sizeof(*dev->wed_rro.emi_rings_dma.ptr),
+				   dev->wed_rro.emi_rings_dma.ptr,
+				   dev->wed_rro.emi_rings_dma.phy_addr);
+
 	if (!dev->wed_rro.session.ptr)
 		return;
 
-- 
2.51.0


