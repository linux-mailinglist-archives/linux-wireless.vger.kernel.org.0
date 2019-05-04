Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413E613AF3
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEDP3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 11:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfEDP3q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 11:29:46 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE2D2086C;
        Sat,  4 May 2019 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556983784;
        bh=v9X8Qr35Lesdi6pZ73fSLVEEvKBi9aKLr605clvIb5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1+SLk5ntdzF39zSPV5E3qUrJOeuVocH2ES3I8/1fzyTPy9H9TWlVCTHfjsx2vw2g
         W6MkFe3bFaZLbo3X+UbYHYjMInU44yqZmW4/3iZvPglCqLwf2fdc0yKHXMkiiYTDGV
         ZTGwtP0+bDOyHKM1VkA9gCG9vKU2/QBywgDbQLzw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 11/17] mt7615: mcu: unify __mt7615_mcu_set_dev_info and mt7615_mcu_set_dev_info
Date:   Sat,  4 May 2019 17:29:03 +0200
Message-Id: <6e545ac18c1738311ae068c07ea2304348afc4c7.1556981521.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
References: <cover.1556981521.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unify mt7615_mcu_set_dev_info and __mt7615_mcu_set_dev_info since the
latter is run just by mt7615_mcu_set_dev_info

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 91 ++++++++-----------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 +-
 2 files changed, 38 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 39fc36ad0052..0e82fcb34e07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -633,68 +633,49 @@ int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter)
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_PM_STATE_CTRL);
 }
 
-static int __mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
-				     struct dev_info *dev_info)
+int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
+			    struct ieee80211_vif *vif, bool enable)
 {
-	struct req_hdr {
-		u8 omac_idx;
-		u8 band_idx;
-		__le16 tlv_num;
-		u8 is_tlv_append;
-		u8 rsv[3];
-	} __packed req_hdr = {0};
-	struct req_tlv {
-		__le16 tag;
-		__le16 len;
-		u8 active;
-		u8 band_idx;
-		u8 omac_addr[ETH_ALEN];
-	} __packed;
-	struct sk_buff *skb;
-	u16 tlv_num = 0;
-
-	skb = mt7615_mcu_msg_alloc(NULL, sizeof(req_hdr) +
-				   sizeof(struct req_tlv));
-	skb_reserve(skb, sizeof(req_hdr));
-
-	if (dev_info->feature & BIT(DEV_INFO_ACTIVE)) {
-		struct req_tlv req_tlv = {
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct {
+		struct req_hdr {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 tlv_num;
+			u8 is_tlv_append;
+			u8 rsv[3];
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 band_idx;
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} data = {
+		.hdr = {
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.tlv_num = cpu_to_le16(1),
+			.is_tlv_append = 1,
+		},
+		.tlv = {
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
-			.len = cpu_to_le16(sizeof(req_tlv)),
-			.active = dev_info->enable,
-			.band_idx = dev_info->band_idx,
-		};
-		memcpy(req_tlv.omac_addr, dev_info->omac_addr, ETH_ALEN);
-		memcpy(skb_put(skb, sizeof(req_tlv)), &req_tlv,
-		       sizeof(req_tlv));
-		tlv_num++;
-	}
-
-	req_hdr.omac_idx = dev_info->omac_idx;
-	req_hdr.band_idx = dev_info->band_idx;
-	req_hdr.tlv_num = cpu_to_le16(tlv_num);
-	req_hdr.is_tlv_append = tlv_num ? 1 : 0;
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+			.band_idx = mvif->band_idx,
+		},
+	};
+	struct sk_buff *skb;
 
-	memcpy(skb_push(skb, sizeof(req_hdr)), &req_hdr, sizeof(req_hdr));
+	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
+	skb = mt7615_mcu_msg_alloc(&data, sizeof(data));
+	if (!skb)
+		return -ENOMEM;
 
 	return mt7615_mcu_msg_send(dev, skb, MCU_EXT_CMD_DEV_INFO_UPDATE);
 }
 
-int mt7615_mcu_set_dev_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			    int en)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct dev_info dev_info = {0};
-
-	dev_info.omac_idx = mvif->omac_idx;
-	memcpy(dev_info.omac_addr, vif->addr, ETH_ALEN);
-	dev_info.band_idx = mvif->band_idx;
-	dev_info.enable = en;
-	dev_info.feature = BIT(DEV_INFO_ACTIVE);
-
-	return __mt7615_mcu_set_dev_info(dev, &dev_info);
-}
-
 static void bss_info_omac_handler (struct mt7615_dev *dev,
 				   struct bss_info *bss_info,
 				   struct sk_buff *skb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 81501cb64f1f..e19739f9668b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -108,8 +108,8 @@ int mt7615_eeprom_init(struct mt7615_dev *dev);
 int mt7615_dma_init(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
 int mt7615_mcu_init(struct mt7615_dev *dev);
-int mt7615_mcu_set_dev_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			    int en);
+int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
+			    struct ieee80211_vif *vif, bool enable);
 int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			    int en);
 int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
-- 
2.20.1

