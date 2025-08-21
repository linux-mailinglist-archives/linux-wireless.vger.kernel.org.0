Return-Path: <linux-wireless+bounces-26517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8FBB2FA33
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F055F1C87564
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B932BF3E;
	Thu, 21 Aug 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBiOSeIa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0732A3E6
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782210; cv=none; b=qtmDHsyhfISFiQl5nXFeQj3Xa61RtlEZn+rGohRYPnUBBN22OH9WKtroeC2xZFEM+txOVe0CH/YgGeesL0u4gXHY7dVeppS6sQt37PbZ4/TxbII+5diwmk1eEZcuH4lI1IPtSexJpLAQBq96/AEP/aM1aefOG/WjGBVO5tBHMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782210; c=relaxed/simple;
	bh=61JWdqdg6ttc8hRt/w+pdh8UPhQBz1yHII1rdZ7h0dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoMZoT/PE9XQ932EcfKnepZpFKzwrhx6l1vHURRzB7vUMyllm2YL5ip0BkOb97Hm06NIbmTYwFGJFIsNi02MI9UYv8V/Ys5KF79QneaFkrT7t+uvzLgKvuOwlHxldVb3nuSja8S41P6q4wGWjg+09AUqahalm1R1fr5Op+eTTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBiOSeIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A405FC4CEEB;
	Thu, 21 Aug 2025 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782210;
	bh=61JWdqdg6ttc8hRt/w+pdh8UPhQBz1yHII1rdZ7h0dk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WBiOSeIa2tOfNOlCgXUBRK0laxOaQOgR524wMZr25pw0RzDYSgBTxXI6UIhUFaCJk
	 /PSadmL6/+hZjXad4QkdPZ1OtAjooX9hsXKowDWgga66Y6uW4IUXeV3wkB76IXqSDX
	 ackWI9iZ/7PkfSdJ7t5owGxMudf0K/PXyJjgUOueJZhnDqOCuyEX4YqAx8pW1oiSlY
	 KGg2MZszn8Rjyp0uLv+Y2BmmRk6hS9yy5059u7rkZaqI0CZXRKPNrZONjmSbVN6+nR
	 4IUpNNg841+DZZhnoMWTIKzUN5gBWb8WcEG+PDv8oPxBJ9YgXUlKbCtvaD7SygkIgB
	 eEGJEdtxtXrCQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:14:58 +0200
Subject: [PATCH mt76 06/14] wifi: mt76: mt7996: Introduce the capability to
 reset MT7992 WED device
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-6-6c8477ad969f@kernel.org>
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

This is a preliminary patch to enable WED support for MT7992 Kite
chipset supported by MT7996 driver.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  6 ++---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 30 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  1 +
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 543572328d65ff75ab654f41ff85b22ed0f34beb..8dc2e9155cba66cb51ba992c31da3e4273207f44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -726,9 +726,9 @@ void mt7996_wfsys_reset(struct mt7996_dev *dev)
 	msleep(20);
 }
 
-#ifdef CONFIG_NET_MEDIATEK_SOC_WED
-static void mt7996_rro_hw_init(struct mt7996_dev *dev)
+void mt7996_rro_hw_init(struct mt7996_dev *dev)
 {
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	u32 reg = MT_RRO_ADDR_ELEM_SEG_ADDR0;
 	int i;
@@ -808,8 +808,8 @@ static void mt7996_rro_hw_init(struct mt7996_dev *dev)
 	/* interrupt enable */
 	mt76_wr(dev, MT_RRO_HOST_INT_ENA,
 		MT_RRO_HOST_INT_ENA_HOST_RRO_DONE_ENA);
-}
 #endif
+}
 
 static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index d6531b74be1f15467c06e385d0efabad806db6b8..2ca10588b7a67be8a6d72b81c63322ec38cca257 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1847,6 +1847,32 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 	if (ret)
 		goto out;
 
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && dev->has_rro) {
+		u32 wed_irq_mask = dev->mt76.mmio.irqmask |
+				   MT_INT_RRO_RX_DONE |
+				   MT_INT_TX_DONE_BAND2;
+
+		mt7996_rro_hw_init(dev);
+		mt76_for_each_q_rx(&dev->mt76, i) {
+			if (mt76_queue_is_wed_rro_ind(&dev->mt76.q_rx[i]) ||
+			    mt76_queue_is_wed_rro_msdu_pg(&dev->mt76.q_rx[i]))
+				mt76_queue_rx_reset(dev, i);
+		}
+
+		mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
+		mtk_wed_device_start_hw_rro(&dev->mt76.mmio.wed, wed_irq_mask,
+					    false);
+		mt7996_irq_enable(dev, wed_irq_mask);
+		mt7996_irq_disable(dev, 0);
+	}
+
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed_hif2)) {
+		mt76_wr(dev, MT_INT_PCIE1_MASK_CSR,
+			MT_INT_TX_RX_DONE_EXT);
+		mtk_wed_device_start(&dev->mt76.mmio.wed_hif2,
+				     MT_INT_TX_RX_DONE_EXT);
+	}
+
 	/* set the necessary init items */
 	ret = mt7996_mcu_set_eeprom(dev);
 	if (ret)
@@ -2059,6 +2085,10 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 		mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
 
+		if (is_mt7992(&dev->mt76) && dev->has_rro)
+			mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
+				MT_RRO_3_0_EMU_CONF_EN_MASK);
+
 		mtk_wed_device_start_hw_rro(&dev->mt76.mmio.wed, wed_irq_mask,
 					    true);
 		mt7996_irq_enable(dev, wed_irq_mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index d269dcf957d74757a23dc4c48ef01f5e04668119..1efcfaf32d451e12a817c9b835fcc5e49b5ccb19 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -569,6 +569,7 @@ extern struct pci_driver mt7996_hif_driver;
 
 struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 				     void __iomem *mem_base, u32 device_id);
+void mt7996_rro_hw_init(struct mt7996_dev *dev);
 void mt7996_wfsys_reset(struct mt7996_dev *dev);
 irqreturn_t mt7996_irq_handler(int irq, void *dev_instance);
 u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif_link *link);

-- 
2.50.1


