Return-Path: <linux-wireless+bounces-26520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65074B2FA29
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E573BAE2F56
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9FC3277AF;
	Thu, 21 Aug 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkGDMcWE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D233436C
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782222; cv=none; b=WzbxBmaXFj9gdGKhU72IEhHJtySQwF/0LPcWVLEkIP6f0X/m1OGg07+ZDf5HWQogqH2y0yg8YjMEhjmDBr7COqOU8disNb94YX0vKCQWeE4fBHijmhWT7I4Tf7PVUEaUBPAh/DVv+X/HqZKp3Q7Z/t2/nGA9cIYMQ7yMVuhAsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782222; c=relaxed/simple;
	bh=eIBNs3P9QhUSDzz+JmmLgPNqzFNAEK1znU8UaALWMOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xe0eQ/VZnKDbWL37V9+r+b3vK5wmaHm505bV6DkcDLh94ISjM/dbPGlkolCfqUlC/Ddgr6Vu0dWtEcPDdyhDY758lDqN4qUTwUpeLrcC4L4XUaALCRmKhoHT7cz1z0CWLJO65EKgUkQPINk5F6zAWRk5kJntPWsd/Qh4L20z6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkGDMcWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A7CC4CEED;
	Thu, 21 Aug 2025 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782222;
	bh=eIBNs3P9QhUSDzz+JmmLgPNqzFNAEK1znU8UaALWMOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MkGDMcWEFvjlILkQWnC2vg1CG+t57uI9Pl7DF1BlBo36fZR34HX35DR/m/qmBfEeF
	 j+bCsQwh7KrcngElDcHqAgWIKuvzGjuXbH2c7YUu8sV7rHwj8BH0nsVPgQfY8pkfvO
	 HyEb5canuCOAF3vQkwwDsjLAO5dfLHv1ijY4ZntnJwzj/wrA3yrb7ZSCEKE3rHfJ9I
	 b4T+yTD2+awgmpr+8KfOLwcNDa0oTa5PuW7KAvNQgGMOv7mJWYFCTQXIK70yPDxbv1
	 WQI/E6eLmep6DjhTUxnHiT4t9/MF3B5C+HDgwrqWWKIYkCY7vFbNvP53GvzrPh8ZAT
	 dv2VCv3JCQrAA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:15:01 +0200
Subject: [PATCH mt76 09/14] wifi: mt76: mt7996: Enable WED for MT7992
 chipset
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-9-6c8477ad969f@kernel.org>
References: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
In-Reply-To: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Rex Lu <rex.lu@mediatek.com>, Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

From: Rex Lu <rex.lu@mediatek.com>

Introduce WED offload support for MT7992 chipset in MT7996 driver.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 26 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 11 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 19 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   | 72 ++++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  3 +
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |  1 +
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |  4 ++
 7 files changed, 101 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index b3665bb0a433ae4cdbf02fa647d644961509d7aa..c5fd25acf9a1a60d4aaffe8ba6d2cf2aafe4fd87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -17,7 +17,7 @@ int mt7996_init_tx_queues(struct mt7996_phy *phy, int idx, int n_desc,
 		ring_base += MT_TXQ_ID(0) * MT_RING_SIZE;
 		idx -= MT_TXQ_ID(0);
 
-		if (phy->mt76->band_idx == MT_BAND2)
+		if (wed == &dev->mt76.mmio.wed_hif2)
 			flags = MT_WED_Q_TX(0);
 		else
 			flags = MT_WED_Q_TX(idx);
@@ -429,6 +429,30 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 		mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL,
 			 MT_WFDMA_AXI_R2A_CTRL_OUTSTAND_MASK, 0x14);
 
+		if (dev->hif2->speed < PCIE_SPEED_5_0GT ||
+		    (dev->hif2->speed == PCIE_SPEED_5_0GT &&
+		     dev->hif2->width < PCIE_LNK_X2)) {
+			mt76_rmw(dev, WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
+				 WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
+				 FIELD_PREP(WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
+					    0x1));
+			mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL2,
+				 MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
+				 FIELD_PREP(MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
+					    0x1));
+		} else if (dev->hif2->speed < PCIE_SPEED_8_0GT ||
+			   (dev->hif2->speed == PCIE_SPEED_8_0GT &&
+			    dev->hif2->width < PCIE_LNK_X2)) {
+			mt76_rmw(dev, WF_WFDMA0_GLO_CFG_EXT0 + hif1_ofs,
+				 WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
+				 FIELD_PREP(WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK,
+					    0x2));
+			mt76_rmw(dev, MT_WFDMA_AXI_R2A_CTRL2,
+				 MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
+				 FIELD_PREP(MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK,
+					    0x2));
+		}
+
 		/* WFDMA rx threshold */
 		mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_45_TH + hif1_ofs, 0xc000c);
 		mt76_wr(dev, MT_WFDMA0_PAUSE_RX_Q_67_TH + hif1_ofs, 0x10008);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 03ef980d0b6ed150f8af2dc05c98761462df2c38..f1336c7441d27fd150ff6994147cb7c5b0d0b127 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -636,7 +636,9 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 	if (!mt7996_band_valid(dev, band))
 		return 0;
 
-	if (is_mt7996(&dev->mt76) && band == MT_BAND2 && dev->hif2) {
+	if (dev->hif2 &&
+	    ((is_mt7996(&dev->mt76) && band == MT_BAND2) ||
+	     (is_mt7992(&dev->mt76) && band == MT_BAND1))) {
 		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 		wed = &dev->mt76.mmio.wed_hif2;
 	}
@@ -694,10 +696,9 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 		goto error;
 
 	if (wed == &dev->mt76.mmio.wed_hif2 && mtk_wed_device_active(wed)) {
-		u32 irq_mask = dev->mt76.mmio.irqmask | MT_INT_TX_DONE_BAND2;
-
-		mt76_wr(dev, MT_INT1_MASK_CSR, irq_mask);
-		mtk_wed_device_start(&dev->mt76.mmio.wed_hif2, irq_mask);
+		mt76_wr(dev, MT_INT_PCIE1_MASK_CSR, MT_INT_TX_RX_DONE_EXT);
+		mtk_wed_device_start(&dev->mt76.mmio.wed_hif2,
+				     MT_INT_TX_RX_DONE_EXT);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 38d15963ec5801e70b8e539b7707a8d47c9a37fd..2ea7c572dcf330aa320804fb64680fe2f931f722 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2149,9 +2149,7 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	struct mt7996_sta_link *msta_link;
-	struct mt7996_vif_link *link;
 	struct mt76_vif_link *mlink;
-	struct mt7996_phy *phy;
 
 	mlink = rcu_dereference(mvif->mt76.link[msta->deflink_id]);
 	if (!mlink)
@@ -2164,13 +2162,10 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!msta_link->wcid.sta || msta_link->wcid.idx > MT7996_WTBL_STA)
 		return -EIO;
 
-	link = (struct mt7996_vif_link *)mlink;
-	phy = mt7996_vif_link_phy(link);
-	if (!phy)
-		return -ENODEV;
-
-	if (phy != &dev->phy && phy->mt76->band_idx == MT_BAND2)
-		wed = &dev->mt76.mmio.wed_hif2;
+	if (dev->hif2 &&
+	    ((is_mt7996(&dev->mt76) && msta_link->wcid.phy_idx == MT_BAND2) ||
+	     (is_mt7992(&dev->mt76) && msta_link->wcid.phy_idx == MT_BAND1)))
+	    wed = &dev->mt76.mmio.wed_hif2;
 
 	if (!mtk_wed_device_active(wed))
 		return -ENODEV;
@@ -2182,7 +2177,11 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	path->mtk_wdma.queue = 0;
 	path->mtk_wdma.wcid = msta_link->wcid.idx;
 
-	path->mtk_wdma.amsdu = mtk_wed_is_amsdu_supported(wed);
+	if (ieee80211_hw_check(hw, SUPPORTS_AMSDU_IN_AMPDU) &&
+	    mtk_wed_is_amsdu_supported(wed))
+		path->mtk_wdma.amsdu = msta_link->wcid.amsdu;
+	else
+		path->mtk_wdma.amsdu = 0;
 	ctx->dev = NULL;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index a8b4ef433c2bfdbbf79ae7f6aa54f33a5d5254ff..aa70e5fce98f005ef5c3f588203f61e179ff04e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -459,14 +459,14 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	struct pci_dev *pci_dev = pdev_ptr;
-	u32 hif1_ofs = 0;
+	u32 hif1_ofs;
 
 	if (!wed_enable)
 		return 0;
 
 	dev->has_rro = true;
 
-	hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+	hif1_ofs = dev->hif2 ? MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0) : 0;
 
 	if (hif2)
 		wed = &dev->mt76.mmio.wed_hif2;
@@ -491,10 +491,17 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 					     MT_TXQ_RING_BASE(0) +
 					     MT7996_TXQ_BAND2 * MT_RING_SIZE;
 		if (dev->has_rro) {
-			wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
-						 MT_RXQ_RING_BASE(0) +
-						 MT7996_RXQ_TXFREE2 * MT_RING_SIZE;
-			wed->wlan.txfree_tbit = ffs(MT_INT_RX_TXFREE_EXT) - 1;
+			if (is_mt7996(&dev->mt76)) {
+				wed->wlan.txfree_tbit = ffs(MT_INT_RX_TXFREE_EXT) - 1;
+				wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
+							 MT_RXQ_RING_BASE(0) +
+							 MT7996_RXQ_TXFREE2 * MT_RING_SIZE;
+			} else {
+				wed->wlan.txfree_tbit = ffs(MT_INT_RX_TXFREE_BAND1_EXT) - 1;
+				wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
+							 MT_RXQ_RING_BASE(0) +
+							 MT7996_RXQ_MCU_WA_EXT * MT_RING_SIZE;
+			}
 		} else {
 			wed->wlan.wpdma_txfree = wed->wlan.phy_base + hif1_ofs +
 						 MT_RXQ_RING_BASE(0) +
@@ -504,8 +511,8 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 
 		wed->wlan.wpdma_rx_glo = wed->wlan.phy_base + hif1_ofs + MT_WFDMA0_GLO_CFG;
 		wed->wlan.wpdma_rx[0] = wed->wlan.phy_base + hif1_ofs +
-					MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
-					MT7996_RXQ_BAND0 * MT_RING_SIZE;
+					MT_RXQ_RING_BASE(MT7996_RXQ_BAND2) +
+					MT7996_RXQ_BAND2 * MT_RING_SIZE;
 
 		wed->wlan.id = MT7996_DEVICE_ID_2;
 		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND2) - 1;
@@ -525,9 +532,19 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 		wed->wlan.wpdma_rx_rro[0] = wed->wlan.phy_base +
 					    MT_RXQ_RING_BASE(MT7996_RXQ_RRO_BAND0) +
 					    MT7996_RXQ_RRO_BAND0 * MT_RING_SIZE;
-		wed->wlan.wpdma_rx_rro[1] = wed->wlan.phy_base + hif1_ofs +
-					    MT_RXQ_RING_BASE(MT7996_RXQ_RRO_BAND2) +
-					    MT7996_RXQ_RRO_BAND2 * MT_RING_SIZE;
+		if (is_mt7996(&dev->mt76)) {
+			wed->wlan.wpdma_rx_rro[1] = wed->wlan.phy_base + hif1_ofs +
+						    MT_RXQ_RING_BASE(MT7996_RXQ_RRO_BAND2) +
+						    MT7996_RXQ_RRO_BAND2 * MT_RING_SIZE;
+		} else {
+			wed->wlan.wpdma_rx_rro[1] = wed->wlan.phy_base + hif1_ofs +
+						    MT_RXQ_RING_BASE(MT7996_RXQ_RRO_BAND1) +
+						    MT7996_RXQ_RRO_BAND1 * MT_RING_SIZE;
+			wed->wlan.wpdma_rx[1] = wed->wlan.phy_base + hif1_ofs +
+						MT_RXQ_RING_BASE(MT7996_RXQ_BAND1) +
+						MT7996_RXQ_BAND1 * MT_RING_SIZE;
+		}
+
 		wed->wlan.wpdma_rx_pg = wed->wlan.phy_base +
 					MT_RXQ_RING_BASE(MT7996_RXQ_MSDU_PG_BAND0) +
 					MT7996_RXQ_MSDU_PG_BAND0 * MT_RING_SIZE;
@@ -537,10 +554,14 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 		wed->wlan.rx_size = SKB_WITH_OVERHEAD(MT_RX_BUF_SIZE);
 
 		wed->wlan.rx_tbit[0] = ffs(MT_INT_RX_DONE_BAND0) - 1;
-		wed->wlan.rx_tbit[1] = ffs(MT_INT_RX_DONE_BAND2) - 1;
-
 		wed->wlan.rro_rx_tbit[0] = ffs(MT_INT_RX_DONE_RRO_BAND0) - 1;
-		wed->wlan.rro_rx_tbit[1] = ffs(MT_INT_RX_DONE_RRO_BAND2) - 1;
+		if (is_mt7996(&dev->mt76)) {
+			wed->wlan.rx_tbit[1] = ffs(MT_INT_RX_DONE_BAND2) - 1;
+			wed->wlan.rro_rx_tbit[1] = ffs(MT_INT_RX_DONE_RRO_BAND2) - 1;
+		} else {
+			wed->wlan.rx_tbit[1] = ffs(MT_INT_RX_DONE_BAND1) - 1;
+			wed->wlan.rro_rx_tbit[1] = ffs(MT_INT_RX_DONE_RRO_BAND1) - 1;
+		}
 
 		wed->wlan.rx_pg_tbit[0] = ffs(MT_INT_RX_DONE_MSDU_PG_BAND0) - 1;
 		wed->wlan.rx_pg_tbit[1] = ffs(MT_INT_RX_DONE_MSDU_PG_BAND1) - 1;
@@ -548,16 +569,27 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 
 		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND0) - 1;
 		wed->wlan.tx_tbit[1] = ffs(MT_INT_TX_DONE_BAND1) - 1;
-		if (dev->has_rro) {
-			wed->wlan.wpdma_txfree = wed->wlan.phy_base + MT_RXQ_RING_BASE(0) +
-						 MT7996_RXQ_TXFREE0 * MT_RING_SIZE;
-			wed->wlan.txfree_tbit = ffs(MT_INT_RX_TXFREE_MAIN) - 1;
+		if (is_mt7996(&dev->mt76)) {
+			if (dev->has_rro) {
+				wed->wlan.wpdma_txfree = wed->wlan.phy_base +
+							 MT_RXQ_RING_BASE(0) +
+							 MT7996_RXQ_TXFREE0 * MT_RING_SIZE;
+				wed->wlan.txfree_tbit = ffs(MT_INT_RX_TXFREE_MAIN) - 1;
+			} else {
+				wed->wlan.wpdma_txfree = wed->wlan.phy_base +
+							 MT_RXQ_RING_BASE(0) +
+							 MT7996_RXQ_MCU_WA_MAIN * MT_RING_SIZE;
+				wed->wlan.txfree_tbit = ffs(MT_INT_RX_DONE_WA_MAIN) - 1;
+			}
 		} else {
 			wed->wlan.txfree_tbit = ffs(MT_INT_RX_DONE_WA_MAIN) - 1;
 			wed->wlan.wpdma_txfree = wed->wlan.phy_base + MT_RXQ_RING_BASE(0) +
 						  MT7996_RXQ_MCU_WA_MAIN * MT_RING_SIZE;
 		}
 		dev->mt76.rx_token_size = MT7996_TOKEN_SIZE + wed->wlan.rx_npkt;
+
+		if (dev->hif2 && is_mt7992(&dev->mt76))
+			wed->wlan.id = 0x7992;
 	}
 
 	wed->wlan.nbuf = MT7996_HW_TOKEN_SIZE;
@@ -576,8 +608,10 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 		wed->wlan.reset_complete = mt76_wed_reset_complete;
 	}
 
-	if (mtk_wed_device_attach(wed))
+	if (mtk_wed_device_attach(wed)) {
+		dev->has_rro = false;
 		return 0;
+	}
 
 	*irq = wed->irq;
 	dev->mt76.dma_dev = wed->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 1efcfaf32d451e12a817c9b835fcc5e49b5ccb19..0182cc47959e422d07550c3f4781bd1946ac7170 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -280,6 +280,9 @@ struct mt7996_hif {
 	struct device *dev;
 	void __iomem *regs;
 	int irq;
+
+	enum pci_bus_speed speed;
+	enum pcie_link_width width;
 };
 
 struct mt7996_wed_rro_addr {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index f5ce50056ee94e2915fd189419905acc8cebd853..3f49bbbba3b9ccd100267f54775838ddef634766 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -87,6 +87,7 @@ static int mt7996_pci_hif2_probe(struct pci_dev *pdev)
 	hif->dev = &pdev->dev;
 	hif->regs = pcim_iomap_table(pdev)[0];
 	hif->irq = pdev->irq;
+	pcie_bandwidth_available(pdev, NULL, &hif->speed, &hif->width);
 	spin_lock_bh(&hif_lock);
 	list_add(&hif->list, &hif_list);
 	spin_unlock_bh(&hif_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 070cdebcd19d7713ebae1d74fdf0c6062eb7c925..d239fa3f375f5e86f9cf650fda713a4e1e4b2f96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -442,6 +442,7 @@ enum offs_rev {
 #define MT_WFDMA0_PAUSE_RX_Q_RRO_TH		MT_WFDMA0(0x27c)
 
 #define WF_WFDMA0_GLO_CFG_EXT0			MT_WFDMA0(0x2b0)
+#define WF_WFDMA0_GLO_CFG_EXT0_OUTSTAND_MASK	GENMASK(27, 24)
 #define WF_WFDMA0_GLO_CFG_EXT0_RX_WB_RXD	BIT(18)
 #define WF_WFDMA0_GLO_CFG_EXT0_WED_MERGE_MODE	BIT(14)
 
@@ -473,6 +474,9 @@ enum offs_rev {
 #define MT_WFDMA_AXI_R2A_CTRL			MT_WFDMA_EXT_CSR(0x500)
 #define MT_WFDMA_AXI_R2A_CTRL_OUTSTAND_MASK	GENMASK(4, 0)
 
+#define MT_WFDMA_AXI_R2A_CTRL2			MT_WFDMA_EXT_CSR(0x508)
+#define MT_WFDMA_AXI_R2A_CTRL2_OUTSTAND_MASK	GENMASK(31, 28)
+
 #define MT_PCIE_RECOG_ID			0xd7090
 #define MT_PCIE_RECOG_ID_MASK			GENMASK(30, 0)
 #define MT_PCIE_RECOG_ID_SEM			BIT(31)

-- 
2.50.1


