Return-Path: <linux-wireless+bounces-28660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 387ABC394B2
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 07:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F84E18A9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF52E5B10;
	Thu,  6 Nov 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G/gxU3Ic"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A552E06ED
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411399; cv=none; b=HeYzMC2OLjwti/C1knXK9oA/0Zs9b/DwEzl2FDnc3oxq2gEdAss9IAva6iiOBLH+ju21VHAbXwEP+5h07rHo8aN/xkWoAPt41eYVtX+8Eh+80CpmbJtYDIlZNi66jfsIGN4YtsY1jVgeeE9E13EI9LMWp3Abm8OJNX44oHeT3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411399; c=relaxed/simple;
	bh=Q/96exuN97SxzzUKcFHF/CrhTPhV8VZoDUARMN+ogR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6menp4xLRwX/3aArNTYwWMWmhmiR24hL6ONzWWvexKvYJjDrWFdLc6rCNohKOtRserQtsDYaxxjtC9uw5ZFgUbgUbPTDj2JjrmFQs8GfTqGMsV3CH1biuxXquGmoql8APQr1wInFi1G1P1on/u3Hr4n3dbLvyOA7aJ6yUCUG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G/gxU3Ic; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d7843860badb11f0b33aeb1e7f16c2b6-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J1pyXI3y8UlM2LlJDo1kbV6NWLkhSbpGDadWWV7iSiA=;
	b=G/gxU3Ic1BidYtzg7UeGz6ZxJaOHhsB7PoMiB0ZcTaKCgt6cS9+VCjGUnsP+n2gBOgGTuJl2WnI+o5hgxHMcP8qhovsM/JAY4rTxuMmPtdbwe1YqG/eSGfI4FphesUBr+g8ReM2IQOVFFLqViIennXcUtWx5+etM84xWhXYwy+8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:90224919-d57b-4b0c-8bc4-f8691197a193,IP:0,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:59abf87c-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:1|19,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d7843860badb11f0b33aeb1e7f16c2b6-20251106
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 624562666; Thu, 06 Nov 2025 14:43:02 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 14:43:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 14:43:01 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	Rex Lu <rex.lu@mediatek.com>
Subject: [PATCH mt76 v2 12/12] wifi: mt76: mt7996: fix EMI rings for RRO
Date: Thu, 6 Nov 2025 14:42:03 +0800
Message-ID: <20251106064203.1000505-12-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251106064203.1000505-1-shayne.chen@mediatek.com>
References: <20251106064203.1000505-1-shayne.chen@mediatek.com>
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
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
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


