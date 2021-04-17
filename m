Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321BC362F39
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhDQK31 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 06:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhDQK3Z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 06:29:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C473610C8;
        Sat, 17 Apr 2021 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618655339;
        bh=FUjLa/5Dwd49HvveTK1NOMg3CcYr7nJ9kRFVq50fl68=;
        h=From:To:Cc:Subject:Date:From;
        b=ARiuH/mBQo4f2sJj/BQNpC03MARi8uHxBQB7zEc7okbCrpKDEPcFAJuKaSDg3/wyi
         BtaGpMSB16uqTV3jtCJpBMw/ntz2kc93xnH9ZghZtgiRww6JL0G6HIvxmFk/Jp7Uyq
         +8Dc/LM7UWrDVSDEDzyC5elr8vG3i782sKwgdA+RY6LIYaRKHg0rOiJ0hM0tH/pzuS
         uF6Y5zl5h3cMb5YqS6HhLuE2WtxCLuB3IUCHLz/Q06WEIwngjiMbUWoGJnvwRDuTCR
         6m4iyI9k0fevLt97IdGdoS2YRk/x8lJGC+zIh6mlEqzzVfx1iP+SvtvMGiAe+BRqD2
         IJwzlcnpJEWtQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: connac: move mcu_update_arp_filter in mt76_connac module
Date:   Sat, 17 Apr 2021 12:28:49 +0200
Message-Id: <833de68ca87fd069f37864855ac7c087aae2488c.1618655272.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_mcu_update_arp_filter in mt76_connac module since the
code is shared between mt7615 and mt7921

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  9 +++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 47 -------------------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 --
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 42 +++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  8 +++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 44 -----------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  6 ---
 8 files changed, 58 insertions(+), 104 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 62d9df47a1f6..8313bf468db2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -578,8 +578,13 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_PS)
 		mt76_connac_mcu_set_vif_ps(&dev->mt76, vif);
 
-	if (changed & BSS_CHANGED_ARP_FILTER)
-		mt7615_mcu_update_arp_filter(hw, vif, info);
+	if ((changed & BSS_CHANGED_ARP_FILTER) &&
+	    mt7615_firmware_offload(dev)) {
+		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+
+		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->mt76,
+						  info);
+	}
 
 	if (changed & BSS_CHANGED_ASSOC)
 		mt7615_mac_set_beacon_filter(phy, vif, info->assoc);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index be976fe97290..364daef4b0be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2704,53 +2704,6 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 				 sizeof(req), false);
 }
 
-int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_bss_conf *info)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt7615_dev *dev = mt7615_hw_dev(hw);
-	struct sk_buff *skb;
-	int i, len = min_t(int, info->arp_addr_cnt,
-			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt76_connac_arpns_tlv arp;
-	} req_hdr = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.arp = {
-			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
-			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
-			.ips_num = len,
-			.mode = 2,  /* update */
-			.option = 1,
-		},
-	};
-
-	if (!mt7615_firmware_offload(dev))
-		return 0;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-				 sizeof(req_hdr) + len * sizeof(__be32));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
-	for (i = 0; i < len; i++) {
-		u8 *addr = (u8 *)skb_put(skb, sizeof(__be32));
-
-		memcpy(addr, &info->arp_addr_list[i], sizeof(__be32));
-	}
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_OFFLOAD,
-				     true);
-}
-
 int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 6a50338ec9f5..5262b84a28c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -549,9 +549,6 @@ int mt7615_mac_set_beacon_filter(struct mt7615_phy *phy,
 				 bool enable);
 int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
-int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_bss_conf *info);
 int __mt7663_load_firmware(struct mt7615_dev *dev);
 u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset);
 void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 860406a53cb6..a1389ccbff7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1802,6 +1802,48 @@ mt76_connac_mcu_set_arp_filter(struct mt76_dev *dev, struct ieee80211_vif *vif,
 				 true);
 }
 
+int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
+				      struct mt76_vif *vif,
+				      struct ieee80211_bss_conf *info)
+{
+	struct sk_buff *skb;
+	int i, len = min_t(int, info->arp_addr_cnt,
+			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_arpns_tlv arp;
+	} req_hdr = {
+		.hdr = {
+			.bss_idx = vif->idx,
+		},
+		.arp = {
+			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
+			.ips_num = len,
+			.mode = 2,  /* update */
+			.option = 1,
+		},
+	};
+
+	skb = mt76_mcu_msg_alloc(dev, NULL,
+				 sizeof(req_hdr) + len * sizeof(__be32));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
+	for (i = 0; i < len; i++) {
+		u8 *addr = (u8 *)skb_put(skb, sizeof(__be32));
+
+		memcpy(addr, &info->arp_addr_list[i], sizeof(__be32));
+	}
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_OFFLOAD, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_arp_filter);
+
 static int
 mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			      bool suspend)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ff9fca52f344..abefd9d3e5ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1010,6 +1010,9 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
 				      struct ieee80211_vif *vif,
 				      bool enable);
+int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
+				      struct mt76_vif *vif,
+				      struct ieee80211_bss_conf *info);
 int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct cfg80211_gtk_rekey_data *key);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8e1891da5c6a..25591e2c510c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -626,8 +626,12 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC)
 		mt7921_bss_bcnft_apply(dev, vif, info->assoc);
 
-	if (changed & BSS_CHANGED_ARP_FILTER)
-		mt7921_mcu_update_arp_filter(hw, vif, info);
+	if (changed & BSS_CHANGED_ARP_FILTER) {
+		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->mt76,
+						  info);
+	}
 
 	mt7921_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index a360929983ea..14ba856de0b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1339,50 +1339,6 @@ mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	}
 }
 
-int mt7921_mcu_update_arp_filter(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_bss_conf *info)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
-	struct sk_buff *skb;
-	int i, len = min_t(int, info->arp_addr_cnt,
-			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt76_connac_arpns_tlv arp;
-	} req_hdr = {
-		.hdr = {
-			.bss_idx = mvif->mt76.idx,
-		},
-		.arp = {
-			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
-			.len = cpu_to_le16(sizeof(struct mt76_connac_arpns_tlv)),
-			.ips_num = len,
-			.mode = 2,  /* update */
-			.option = 1,
-		},
-	};
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-				 sizeof(req_hdr) + len * sizeof(__be32));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
-	for (i = 0; i < len; i++) {
-		u8 *addr = (u8 *)skb_put(skb, sizeof(__be32));
-
-		memcpy(addr, &info->arp_addr_list[i], sizeof(__be32));
-	}
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_OFFLOAD,
-				     true);
-}
-
 int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
 {
 	struct mt7921_txpwr_event *event;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c34cf3e3a26b..3982e074ff50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -364,9 +364,6 @@ int mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			     bool enable);
 int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
-int mt7921_mcu_update_arp_filter(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_bss_conf *info);
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
@@ -377,9 +374,6 @@ int mt7921_mac_set_beacon_filter(struct mt7921_phy *phy,
 				 bool enable);
 void mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
 void mt7921_coredump_work(struct work_struct *work);
-int mt7921_mcu_update_arp_filter(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_bss_conf *info);
 int mt7921_wfsys_reset(struct mt7921_dev *dev);
 int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr);
 #endif
-- 
2.30.2

