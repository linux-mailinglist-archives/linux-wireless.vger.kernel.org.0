Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728DA377DC0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhEJIOd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 04:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhEJIOc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 04:14:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4792061364;
        Mon, 10 May 2021 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620634408;
        bh=i0gua8za3pwMXZRmgEoctxHs9tLeBaWrQdukP5uby8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=YLcLYLN8B2essRplXPqRZeHnXn798/vz3WyqvwJKXLA1IdzU4Mmh2iLaCV0xoxIGU
         NthYxlzXZp9VsL3VBeQkBlmXIiLKjUy/dGXG0LMc/V+KyUgqPQ6VI3bM1loyt28ymT
         LjLt7jGuHyA/Zhoe4r8Qd4IB30OT7s5KLFKjFL64VT27bK/S7JDrz/Ewh8/GVeZULn
         k7Cw++iZyw2PYYNuoXVjFx680rN9jhe72CwoL/MAgy8U7q6Bz5XPzsOrDkn7maCaXh
         hUDf93Nc4P+Ls1ZHnoey2iVac9yddcNbFwgKNAIbIuhGuD2XCXzH/QVXy+6N8b5NDB
         0UI9aWBpmNMZQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7663: enable hw rx header translation
Date:   Mon, 10 May 2021 10:13:07 +0200
Message-Id: <35dc6e8bb7bd274c8a794826fdf81420204ea86b.1620634297.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As already done for mt7615 and mt7915, enable rx header translation
offload for mt7663 in order to reduce cpu load in the rx path.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 66 +++++++++++++------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 +-
 3 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 39733b351ac4..faae60775b16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1162,7 +1162,7 @@ static void mt7615_sta_set_decap_offload(struct ieee80211_hw *hw,
 	else
 		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 
-	mt7615_mcu_sta_update_hdr_trans(dev, vif, sta);
+	mt7615_mcu_set_sta_decap_offload(dev, vif, sta);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 359d5bd8ed60..317ddb2402ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1058,6 +1058,26 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
 }
 
+static int
+mt7615_mcu_wtbl_update_hdr_trans(struct mt7615_dev *dev,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta)
+{
+	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sk_buff *skb = NULL;
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, NULL, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, &msta->wcid, NULL,
+					   wtbl_hdr);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+				     true);
+}
+
 static const struct mt7615_mcu_ops wtbl_update_ops = {
 	.add_beacon_offload = mt7615_mcu_add_beacon_offload,
 	.set_pm_state = mt7615_mcu_ctrl_pm_state,
@@ -1068,6 +1088,7 @@ static const struct mt7615_mcu_ops wtbl_update_ops = {
 	.sta_add = mt7615_mcu_wtbl_sta_add,
 	.set_drv_ctrl = mt7615_mcu_drv_pmctrl,
 	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
+	.set_sta_decap_offload = mt7615_mcu_wtbl_update_hdr_trans,
 };
 
 static int
@@ -1142,6 +1163,18 @@ mt7615_mcu_add_sta(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 				    MCU_EXT_CMD_STA_REC_UPDATE);
 }
 
+static int
+mt7615_mcu_sta_update_hdr_trans(struct mt7615_dev *dev,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta)
+{
+	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+
+	return mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76,
+						    vif, &msta->wcid,
+						    MCU_EXT_CMD_STA_REC_UPDATE);
+}
+
 static const struct mt7615_mcu_ops sta_update_ops = {
 	.add_beacon_offload = mt7615_mcu_add_beacon_offload,
 	.set_pm_state = mt7615_mcu_ctrl_pm_state,
@@ -1152,27 +1185,9 @@ static const struct mt7615_mcu_ops sta_update_ops = {
 	.sta_add = mt7615_mcu_add_sta,
 	.set_drv_ctrl = mt7615_mcu_drv_pmctrl,
 	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
+	.set_sta_decap_offload = mt7615_mcu_sta_update_hdr_trans,
 };
 
-int mt7615_mcu_sta_update_hdr_trans(struct mt7615_dev *dev,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta)
-{
-	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct sk_buff *skb = NULL;
-
-	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
-						  WTBL_SET, NULL, &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
-
-	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, &msta->wcid, NULL,
-					   wtbl_hdr);
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
-				     true);
-}
-
 static int
 mt7615_mcu_uni_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 {
@@ -1338,6 +1353,18 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 				     MCU_UNI_CMD_STA_REC_UPDATE, true);
 }
 
+static int
+mt7615_mcu_sta_uni_update_hdr_trans(struct mt7615_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta)
+{
+	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+
+	return mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76,
+						    vif, &msta->wcid,
+						    MCU_UNI_CMD_STA_REC_UPDATE);
+}
+
 static const struct mt7615_mcu_ops uni_update_ops = {
 	.add_beacon_offload = mt7615_mcu_uni_add_beacon_offload,
 	.set_pm_state = mt7615_mcu_uni_ctrl_pm_state,
@@ -1348,6 +1375,7 @@ static const struct mt7615_mcu_ops uni_update_ops = {
 	.sta_add = mt7615_mcu_uni_add_sta,
 	.set_drv_ctrl = mt7615_mcu_lp_drv_pmctrl,
 	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
+	.set_sta_decap_offload = mt7615_mcu_sta_uni_update_hdr_trans,
 };
 
 int mt7615_mcu_restart(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 989f05ed4377..2ba86bd96a31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -202,6 +202,7 @@ struct mt7615_phy {
 #define mt7615_mcu_set_pm(dev, ...)	(dev)->mcu_ops->set_pm_state((dev),  __VA_ARGS__)
 #define mt7615_mcu_set_drv_ctrl(dev)	(dev)->mcu_ops->set_drv_ctrl((dev))
 #define mt7615_mcu_set_fw_ctrl(dev)	(dev)->mcu_ops->set_fw_ctrl((dev))
+#define mt7615_mcu_set_sta_decap_offload(dev, ...) (dev)->mcu_ops->set_sta_decap_offload((dev), __VA_ARGS__)
 struct mt7615_mcu_ops {
 	int (*add_tx_ba)(struct mt7615_dev *dev,
 			 struct ieee80211_ampdu_params *params,
@@ -221,6 +222,9 @@ struct mt7615_mcu_ops {
 	int (*set_pm_state)(struct mt7615_dev *dev, int band, int state);
 	int (*set_drv_ctrl)(struct mt7615_dev *dev);
 	int (*set_fw_ctrl)(struct mt7615_dev *dev);
+	int (*set_sta_decap_offload)(struct mt7615_dev *dev,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta);
 };
 
 struct mt7615_dev {
@@ -518,9 +522,6 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7615_mac_work(struct work_struct *work);
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
-int mt7615_mcu_sta_update_hdr_trans(struct mt7615_dev *dev,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta);
 int mt7615_mcu_set_rx_hdr_trans_blacklist(struct mt7615_dev *dev);
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val);
 int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
-- 
2.31.1

