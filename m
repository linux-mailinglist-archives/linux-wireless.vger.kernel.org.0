Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEB19C8A5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbgDBSTQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 14:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbgDBSTQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 14:19:16 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8E720BED;
        Thu,  2 Apr 2020 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585851555;
        bh=KjgJPaETZxp1kZfdNo/7sMHsHLl7eVpB6vRIBWMpiz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNTwI+T9mcZEDeXPDaDu3AE75BdUKZRwrQBHS4q+T+8y1GLT3OQi+1YogUIC0iB31
         aavFW72LnKKctg7QhgLAJrUj6rhrRfdwvs2hL6xZWtGHw4t5Dxx429YDFPziEyMUqn
         DTs5yD/yDX3eJumjzfAzyDnA2hy0VYeNBqd6xtvw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/9] mt76: mt7615: introduce mt7663u support to mt7615_write_txwi
Date:   Thu,  2 Apr 2020 20:18:49 +0200
Message-Id: <342c53e345ef63211943a00a46ba183f538b2ae4.1585851049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585851049.git.lorenzo@kernel.org>
References: <cover.1585851049.git.lorenzo@kernel.org>
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
index c988a104f911..285d3af621ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -526,11 +526,12 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
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
@@ -554,7 +555,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	if (ieee80211_is_data(fc) || ieee80211_is_bufferable_mmpdu(fc)) {
 		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
 			skb_get_queue_mapping(skb);
-		p_fmt = MT_TX_TYPE_CT;
+		p_fmt = is_usb ? MT_TX_TYPE_SF : MT_TX_TYPE_CT;
 	} else if (beacon) {
 		if (ext_phy)
 			q_idx = MT_LMAC_BCN1;
@@ -566,10 +567,10 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
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
@@ -663,6 +664,9 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 
 	txwi[7] = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
 		  FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	if (is_usb)
+		txwi[8] = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
+			  FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index e0b89257db90..422a140fd812 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -165,6 +165,7 @@ enum tx_phy_bandwidth {
 #define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
 #define MT_CT_INFO_HSR2_TX		BIT(4)
 
+#define MT_USB_TXD_SIZE			(MT_TXD_SIZE + 8 * 4)
 #define MT_TXD_SIZE			(8 * 4)
 
 #define MT_TXD0_P_IDX			BIT(31)
-- 
2.25.1

