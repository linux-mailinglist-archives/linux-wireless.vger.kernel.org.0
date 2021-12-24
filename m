Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5396B47EE66
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 11:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbhLXK6s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 05:58:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44464 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352521AbhLXK6r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 05:58:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4ADAB82288
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 10:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC0EC36AEA;
        Fri, 24 Dec 2021 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640343524;
        bh=AlTKVkA2Bm/6RYSCYjgK5BTEo7uSCpenuFcUCOwdBSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2m+BelS21vidwIrw8sSuYcGjiS54Gl8L2AqJ3Kfo0/zxnUAMlqnVaccjvkRM2/EZ
         6ROXRRagZnarZD0ju584xjI8uKAC3MSlrkFf+U9qSK7o5ttrSEtuaJAEEdM0dq3mc0
         8c8QJ6aC8FWwYyiPkBs8oTpz8LL0g4daCzPVv5SlSZls/TgIeJCWX/o+hmXJCEnHfW
         tVC/21bedf14yMecwM+uraR/OWavn58EXvLSdZVBNz8GkEwl7GJFVqKqSGR/tjUfA0
         6xEMV4w0bTsoL3z1LvGPnxYhbGVvXHZFcNyE3fPwJ0yD92xVQJQ/IDV0TykGPFB0jA
         IGf8rg96qgV6Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 10/10] mt76: connac: move mt76_connac_mcu_rdd_cmd in mt76-connac module
Date:   Fri, 24 Dec 2021 11:58:11 +0100
Message-Id: <6cb9ec1f8e1c70c78098a1a699e5976900d8fff9.1640342400.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640342400.git.lorenzo@kernel.org>
References: <cover.1640342400.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_mcu_rdd_cmd routine in mt76-connac module and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 23 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 21 -----------------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 ---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 21 +++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 ++
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 21 -----------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 --
 9 files changed, 52 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ec25e5a95d44..8f8a7bc0169b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2160,21 +2160,24 @@ static void mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy)
 	struct mt7615_dev *dev = phy->dev;
 
 	if (phy->rdd_state & BIT(0))
-		mt7615_mcu_rdd_cmd(dev, RDD_STOP, 0, MT_RX_SEL0, 0);
+		mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, 0,
+					MT_RX_SEL0, 0);
 	if (phy->rdd_state & BIT(1))
-		mt7615_mcu_rdd_cmd(dev, RDD_STOP, 1, MT_RX_SEL0, 0);
+		mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, 1,
+					MT_RX_SEL0, 0);
 }
 
 static int mt7615_dfs_start_rdd(struct mt7615_dev *dev, int chain)
 {
 	int err;
 
-	err = mt7615_mcu_rdd_cmd(dev, RDD_START, chain, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, chain,
+				      MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
-	return mt7615_mcu_rdd_cmd(dev, RDD_DET_MODE, chain,
-				  MT_RX_SEL0, 1);
+	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_DET_MODE, chain,
+				       MT_RX_SEL0, 1);
 }
 
 static int mt7615_dfs_start_radar_detector(struct mt7615_phy *phy)
@@ -2185,7 +2188,8 @@ static int mt7615_dfs_start_radar_detector(struct mt7615_phy *phy)
 	int err;
 
 	/* start CAC */
-	err = mt7615_mcu_rdd_cmd(dev, RDD_CAC_START, ext_phy, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_START, ext_phy,
+				      MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
@@ -2280,12 +2284,13 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
 			return mt7615_dfs_start_radar_detector(phy);
 
-		return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
-					  MT_RX_SEL0, 0);
+		return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END, ext_phy,
+					       MT_RX_SEL0, 0);
 	}
 
 stop:
-	err = mt7615_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START, ext_phy,
+				      MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 0a914494bb32..f992e1285eaa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1891,27 +1891,6 @@ int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 				 &req, sizeof(req), true);
 }
 
-int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
-		       enum mt7615_rdd_cmd cmd, u8 index,
-		       u8 rx_sel, u8 val)
-{
-	struct {
-		u8 ctrl;
-		u8 rdd_idx;
-		u8 rdd_rx_sel;
-		u8 val;
-		u8 rsv[4];
-	} req = {
-		.ctrl = cmd,
-		.rdd_idx = index,
-		.rdd_rx_sel = rx_sel,
-		.val = val,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_CTRL),
-				 &req, sizeof(req), true);
-}
-
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 07b833654920..3b66aa749a21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -403,9 +403,6 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd);
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		       const struct ieee80211_tx_queue_params *params);
 void mt7615_mcu_rx_event(struct mt7615_dev *dev, struct sk_buff *skb);
-int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
-		       enum mt7615_rdd_cmd cmd, u8 index,
-		       u8 rx_sel, u8 val);
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev);
 int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 2b647c19521b..1b2340e4ce0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2764,5 +2764,26 @@ int mt76_connac_mcu_restart(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_restart);
 
+int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
+			    u8 rx_sel, u8 val)
+{
+	struct {
+		u8 ctrl;
+		u8 rdd_idx;
+		u8 rdd_rx_sel;
+		u8 val;
+		u8 rsv[4];
+	} __packed req = {
+		.ctrl = cmd,
+		.rdd_idx = index,
+		.rdd_rx_sel = rx_sel,
+		.val = val,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(SET_RDD_CTRL), &req,
+				 sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_rdd_cmd);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index bce3134e36a1..9277a6a2c95e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1649,4 +1649,6 @@ void mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb,
 				   void *sta_wtbl, void *wtbl_tlv);
 int mt76_connac_mcu_set_pm(struct mt76_dev *dev, int band, int enter);
 int mt76_connac_mcu_restart(struct mt76_dev *dev);
+int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
+			    u8 rx_sel, u8 val);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 710f8cad6245..c59ef08a5306 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -75,7 +75,7 @@ mt7915_radar_trigger(void *data, u64 val)
 {
 	struct mt7915_dev *dev = data;
 
-	return mt7915_mcu_rdd_cmd(dev, RDD_RADAR_EMULATE, 1, 0, 0);
+	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_RADAR_EMULATE, 1, 0, 0);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_trigger, NULL,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d83e828b6e3e..e0200f84a2f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2346,20 +2346,24 @@ static void mt7915_dfs_stop_radar_detector(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 
 	if (phy->rdd_state & BIT(0))
-		mt7915_mcu_rdd_cmd(dev, RDD_STOP, 0, MT_RX_SEL0, 0);
+		mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, 0,
+					MT_RX_SEL0, 0);
 	if (phy->rdd_state & BIT(1))
-		mt7915_mcu_rdd_cmd(dev, RDD_STOP, 1, MT_RX_SEL0, 0);
+		mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_STOP, 1,
+					MT_RX_SEL0, 0);
 }
 
 static int mt7915_dfs_start_rdd(struct mt7915_dev *dev, int chain)
 {
 	int err;
 
-	err = mt7915_mcu_rdd_cmd(dev, RDD_START, chain, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_START, chain,
+				      MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
-	return mt7915_mcu_rdd_cmd(dev, RDD_DET_MODE, chain, MT_RX_SEL0, 1);
+	return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_DET_MODE, chain,
+				       MT_RX_SEL0, 1);
 }
 
 static int mt7915_dfs_start_radar_detector(struct mt7915_phy *phy)
@@ -2370,7 +2374,8 @@ static int mt7915_dfs_start_radar_detector(struct mt7915_phy *phy)
 	int err;
 
 	/* start CAC */
-	err = mt7915_mcu_rdd_cmd(dev, RDD_CAC_START, ext_phy, MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_START, ext_phy,
+				      MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
@@ -2459,13 +2464,13 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 		if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
 			return mt7915_dfs_start_radar_detector(phy);
 
-		return mt7915_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
-					  MT_RX_SEL0, 0);
+		return mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_CAC_END,
+					       ext_phy, MT_RX_SEL0, 0);
 	}
 
 stop:
-	err = mt7915_mcu_rdd_cmd(dev, RDD_NORMAL_START, ext_phy,
-				 MT_RX_SEL0, 0);
+	err = mt76_connac_mcu_rdd_cmd(&dev->mt76, RDD_NORMAL_START, ext_phy,
+				      MT_RX_SEL0, 0);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index eb9ce86d5303..74cdfd3d13b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2528,27 +2528,6 @@ int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif)
 	return mt7915_mcu_update_edca(dev, &req);
 }
 
-int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev,
-		       enum mt7915_rdd_cmd cmd, u8 index,
-		       u8 rx_sel, u8 val)
-{
-	struct {
-		u8 ctrl;
-		u8 rdd_idx;
-		u8 rdd_rx_sel;
-		u8 val;
-		u8 rsv[4];
-	} __packed req = {
-		.ctrl = cmd,
-		.rdd_idx = index,
-		.rdd_rx_sel = rx_sel,
-		.val = val,
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_CTRL), &req,
-				 sizeof(req), true);
-}
-
 int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3f32ae274600..5adde022d4e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -457,8 +457,6 @@ int mt7915_mcu_get_temperature(struct mt7915_phy *phy);
 int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state);
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
-int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev, enum mt7915_rdd_cmd cmd,
-		       u8 index, u8 rx_sel, u8 val);
 int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl);
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
-- 
2.33.1

