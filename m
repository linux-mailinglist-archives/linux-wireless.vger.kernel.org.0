Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C501E173852
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 14:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgB1N3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Feb 2020 08:29:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgB1N3f (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Feb 2020 08:29:35 -0500
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F0C246A8;
        Fri, 28 Feb 2020 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582896574;
        bh=T12eM19oBLi6NSsHPOZm9A5cS5mkqUrLmvBgHZg8E2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQOGIvJsOL0iJLjRP5nMlI1vFQu1QT0zpqSkUzQ/quUqifS9rwf5qr3V9VOMSco4A
         0fBEflHy3B5hAshZUQdP2qH0yiGw1RB7mBKWq6FGNYhR73lSGT1h2NvgFQlB/I/2RE
         24HPaqGWWVNwenpPHr1k+5Yi67GKdrTgpKHlep7I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 1/6] mt76: mt7615: introduce mt7663u support to mt7615_write_txwi
Date:   Fri, 28 Feb 2020 14:29:22 +0100
Message-Id: <a369147f92207eb7713c4ac8c9154149812b0939.1582893136.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582893136.git.lorenzo@kernel.org>
References: <cover.1582893136.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend mt7615_write_txwi routine to support usb txwi configuration

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 12 ++++++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c5244006cd9c..a14ca0825582 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -512,11 +512,12 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->mphy;
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
+	bool is_usb = mt76_is_usb(&dev->mt76);
 	int tx_count = 8;
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	__le16 fc = hdr->frame_control;
+	u32 val, sz_txd = is_usb ? MT_USB_TXD_SIZE : MT_TXD_SIZE;
 	u16 seqno = 0;
-	u32 val;
 
 	if (vif) {
 		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
@@ -540,7 +541,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	if (ieee80211_is_data(fc) || ieee80211_is_bufferable_mmpdu(fc)) {
 		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
 			skb_get_queue_mapping(skb);
-		p_fmt = MT_TX_TYPE_CT;
+		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
 	} else if (ieee80211_is_beacon(fc)) {
 		if (ext_phy)
 			q_idx = MT_LMAC_BCN1;
@@ -552,10 +553,10 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			q_idx = MT_LMAC_ALTX1;
 		else
 			q_idx = MT_LMAC_ALTX0;
-		p_fmt = MT_TX_TYPE_CT;
+		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
 	}
 
-	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
 	      FIELD_PREP(MT_TXD0_P_IDX, MT_TX_PORT_IDX_LMAC) |
 	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
 	txwi[0] = cpu_to_le32(val);
@@ -649,6 +650,9 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 
 	txwi[7] = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
 		  FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	if (is_usb)
+		txwi[8] = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
+			  FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 2e052f6d9761..5fe6a0e667a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -163,6 +163,7 @@ enum tx_phy_bandwidth {
 #define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
 #define MT_CT_INFO_HSR2_TX		BIT(4)
 
+#define MT_USB_TXD_SIZE			(MT_TXD_SIZE + 8 * 4)
 #define MT_TXD_SIZE			(8 * 4)
 
 #define MT_TXD0_P_IDX			BIT(31)
-- 
2.24.1

