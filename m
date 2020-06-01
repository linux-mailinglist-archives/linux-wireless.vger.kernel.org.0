Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDE1E9F72
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgFAHpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 03:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgFAHpj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 03:45:39 -0400
Received: from localhost.localdomain.com (unknown [151.48.128.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F88206E2;
        Mon,  1 Jun 2020 07:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590997539;
        bh=txKC14HBYwwWvMplQgFuXyWfNDOkNziKNqZxcqkJVts=;
        h=From:To:Cc:Subject:Date:From;
        b=jPoM8xFLxloSBuuz65ic+pHSl19l5wgYoxrcbjf946T/t2FGvHq5n6nyGBip4P4xM
         cpUe1XWvqg1CDQqyfp4DqjEyxHFNmTphQ8saH4cUNksN9zxwwnemPxQq58VsufO25o
         UU4OvD9meCcxSCV/LHfZE+a4LSsO3Ewm0gNogLNk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com, obko@mail.ru
Subject: [PATCH] mt76: overwrite qid for non-bufferable mgmt frames
Date:   Mon,  1 Jun 2020 09:45:33 +0200
Message-Id: <c2d4c460512be8b8e9dc755c839af0ae6870ed76.1590997340.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Overwrite hw queue id for non-bufferable management frames if the hw
support always txq (altxq) in order to be in sync with mac txwi code

Fixes: cdad4874057d ("mt76: mt7615: add dma and tx queue initialization for MT7622")
Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Suggested-by: Felix Fietkau <nbd@nbd.name>
Tested-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: obko@mail.ru
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 20 +++++++------------
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |  7 +++++++
 6 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index dfe625a53c63..3d7db6ffb599 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -301,6 +301,7 @@ struct mt76_hw_cap {
 #define MT_DRV_TX_ALIGNED4_SKBS		BIT(1)
 #define MT_DRV_SW_RX_AIRTIME		BIT(2)
 #define MT_DRV_RX_DMA_HDR		BIT(3)
+#define MT_DRV_HW_MGMT_TXQ		BIT(4)
 
 struct mt76_driver_ops {
 	u32 drv_flags;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 83fdcf5db3c7..e5a965df899a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -100,6 +100,7 @@ mt7615_tx_cleanup(struct mt7615_dev *dev)
 	int i;
 
 	mt76_queue_tx_cleanup(dev, MT_TXQ_MCU, false);
+	mt76_queue_tx_cleanup(dev, MT_TXQ_PSD, false);
 	if (is_mt7615(&dev->mt76)) {
 		mt76_queue_tx_cleanup(dev, MT_TXQ_BE, false);
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 5990355bc731..d97315ec7265 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -526,22 +526,16 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
 	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
 
-	if (ieee80211_is_data(fc) || ieee80211_is_bufferable_mmpdu(fc)) {
-		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
-			mt7615_lmac_mapping(dev, skb_get_queue_mapping(skb));
-		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
-	} else if (beacon) {
-		if (ext_phy)
-			q_idx = MT_LMAC_BCN1;
-		else
-			q_idx = MT_LMAC_BCN0;
+	if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
+		q_idx = ext_phy ? MT_LMAC_BCN1 : MT_LMAC_BCN0;
+	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
+		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
+		q_idx = ext_phy ? MT_LMAC_ALTX1 : MT_LMAC_ALTX0;
 	} else {
-		if (ext_phy)
-			q_idx = MT_LMAC_ALTX1;
-		else
-			q_idx = MT_LMAC_ALTX0;
 		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
+		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
+			mt7615_lmac_mapping(dev, skb_get_queue_mapping(skb));
 	}
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index e670393506f0..2e99845b9c96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -146,7 +146,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt7615_txp_common),
-		.drv_flags = MT_DRV_TXWI_NO_FREE,
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index a50077eb24d7..f5dc1b828518 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -270,7 +270,7 @@ static int mt7663u_probe(struct usb_interface *usb_intf,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = MT_USB_TXD_SIZE,
-		.drv_flags = MT_DRV_RX_DMA_HDR,
+		.drv_flags = MT_DRV_RX_DMA_HDR | MT_DRV_HW_MGMT_TXQ,
 		.tx_prepare_skb = mt7663u_tx_prepare_skb,
 		.tx_complete_skb = mt7663u_tx_complete_skb,
 		.tx_status_data = mt7663u_tx_status_data,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index fca38ea2441f..f10c98aa883c 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -264,6 +264,13 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 		skb_set_queue_mapping(skb, qid);
 	}
 
+	if ((dev->drv->drv_flags & MT_DRV_HW_MGMT_TXQ) &&
+	    !ieee80211_is_data(hdr->frame_control) &&
+	    !ieee80211_is_bufferable_mmpdu(hdr->frame_control)) {
+		qid = MT_TXQ_PSD;
+		skb_set_queue_mapping(skb, qid);
+	}
+
 	if (!(wcid->tx_info & MT_WCID_TX_INFO_SET))
 		ieee80211_get_tx_rates(info->control.vif, sta, skb,
 				       info->control.rates, 1);
-- 
2.26.2

