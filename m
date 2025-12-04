Return-Path: <linux-wireless+bounces-29492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E9CA2C3F
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38ED73064371
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABFD3321BB;
	Thu,  4 Dec 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi/g7otK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8B3321B0
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835894; cv=none; b=km+5jkrIrg3JSryJiRw9X4UwYk/4tx0ObxXXGVFCeWhdlRjlrqZjG3F1UkO6c2JhnCP5c689pZiek0AEkNToVID1G6I35JbqVC5CLASZbPKFTqVzJjV1CYyUTVVHRq2dPPAdPYEeenzyvQnMRJZm72f5zXdCNXUaRuQk2G0+mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835894; c=relaxed/simple;
	bh=9tkiIoFRCYZoXUyUbxUPn15FtFCqvMqqWuG2MjAgwnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANVVGGqp1zaGk6HCRNqlZVMPE0TaEYrhC5DrisS0DkE92Yl6aY2LTE3eNTZmzg0r8qiSBaDj9iZR7ZR9R/zFBb59MRE6Tk7niZY2Ik0zYhVSKOhch/1MD6JgsspLQYVGMYFiSVXpoEChQckPgHvpgtBQFwnKCf8AJc6IhFC4Lb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi/g7otK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5104C4CEFB;
	Thu,  4 Dec 2025 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835894;
	bh=9tkiIoFRCYZoXUyUbxUPn15FtFCqvMqqWuG2MjAgwnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pi/g7otKqRIiFGvIX4xL7IEzBgfVdqdxzAC9ulp4ORE5QV4MaPUwqpocavkQ9Z2TA
	 MACoajbNq3k9pQi0ErArJ/4f7CTveRv/NeJx7FBn//GJTWwJXUU5Z+i/zjvh9an1Td
	 ZxUQpyJiWWNxQM73rGysOfIyAt8rjqs/G3FtS5dHZKm+kFf0J6K9UhIIFvRHV4OGg0
	 9brZKQc4KsLTkG9Cl/RB2Jvi7BHiyBq6rzzhTpmwtz/QqQM3yhRD0tVHRd0a7LVdEu
	 4sC7yQvEFNWRjB/H1G+UcEbxYXDSMNCtliWliBp5gOhzx3w/lmsIds+kVd068jl5WK
	 DeX6x+2a7kl9g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:46 +0100
Subject: [PATCH mt76 04/11] wifi: mt76: mt7996: Fix BAND2 tx queues
 initialization when NPU is enabled
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-4-7819c52c0893@kernel.org>
References: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
In-Reply-To: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

Fix BAND2 tx queues initialization for MT7996 chipset when NPU is
enabled. This is a preliminary patch to enable NPU offload for MT7996
(7990-Eagle) chipset.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 18 ++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  1 +
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 00a8286bd136862d756706d6ad8098a2ddc3ca4e..9fbe4235de0d0d42776d5661fa1c297e431b8d27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -668,8 +668,9 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 		return 0;
 
 	if (dev->hif2 &&
-	    ((is_mt7996(&dev->mt76) && band == MT_BAND2) ||
-	     (is_mt7992(&dev->mt76) && band == MT_BAND1))) {
+	    ((is_mt7992(&dev->mt76) && band == MT_BAND1) ||
+	     (is_mt7996(&dev->mt76) && band == MT_BAND2 &&
+	      !mt76_npu_device_active(&dev->mt76)))) {
 		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 		wed = &dev->mt76.mmio.wed_hif2;
 	}
@@ -709,14 +710,19 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 	/* init wiphy according to mphy and phy */
 	mt7996_init_wiphy_band(mphy->hw, phy);
 
-	if (is_mt7996(&dev->mt76) && !dev->hif2 && band == MT_BAND1) {
+	if (is_mt7996(&dev->mt76) &&
+	    ((band == MT_BAND1 && !dev->hif2) ||
+	     (band == MT_BAND2 && mt76_npu_device_active(&dev->mt76)))) {
 		int i;
 
 		for (i = 0; i <= MT_TXQ_PSD; i++)
-			mphy->q_tx[i] = dev->mt76.phys[MT_BAND0]->q_tx[0];
+			mphy->q_tx[i] = dev->mt76.phys[band - 1]->q_tx[0];
 	} else {
-		ret = mt7996_init_tx_queues(mphy->priv, MT_TXQ_ID(band),
-					    MT7996_TX_RING_SIZE,
+		int size = is_mt7996(&dev->mt76) &&
+			   mt76_npu_device_active(&dev->mt76)
+			   ? MT7996_NPU_TX_RING_SIZE / 2 : MT7996_TX_RING_SIZE;
+
+		ret = mt7996_init_tx_queues(mphy->priv, MT_TXQ_ID(band), size,
 					    MT_TXQ_RING_BASE(band) + hif1_ofs,
 					    wed);
 		if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7a884311800ea8cfc0e302b2a140a4072ce18b69..29a77d75099033727f5df5a487216c043fd04f85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -29,6 +29,7 @@
 #define MT7996_RX_RING_SIZE		1536
 #define MT7996_RX_MCU_RING_SIZE		512
 #define MT7996_RX_MCU_RING_SIZE_WA	1024
+#define MT7996_NPU_TX_RING_SIZE		1024
 /* scatter-gather of mcu event is not supported in connac3 */
 #define MT7996_RX_MCU_BUF_SIZE		(2048 + \
 					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

-- 
2.52.0


