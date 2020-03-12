Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FC1835C2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 17:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgCLQDJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 12:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgCLQDJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 12:03:09 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47186206FA;
        Thu, 12 Mar 2020 16:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584028987;
        bh=guiKi2gDeXR1C/Nu6zGsvnTshmAjhgSwbx8SZjLUnzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzDEHy2JRZhEXwG/t7vqVntimWLVxdiuW08bMsxhwxBbt+H1Rqd/PMF3J2Fs6ljiw
         6pL7i1gvwmPsNbjZ9xpbx8jXLSUDmNsUuUNaUoowYaubHgQoRA1QaGndM/xTv5o1Ki
         j6zuCG5cShac/mh8Qw6aP8a3gG03iqmT3Nes8G3E=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3 12/25] mt76: mt7615: move more mcu commands in mt7615_mcu_ops data structure
Date:   Thu, 12 Mar 2020 17:02:22 +0100
Message-Id: <af6f2177f32aeb67f406d2191eb9276c1519cb7f.1584028319.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584028319.git.lorenzo@kernel.org>
References: <cover.1584028319.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_mcu_set_beacon_offload, mt7615_mcu_set_dev and
mt7615_mcu_set_bss routine in mt7615_mcu_ops data structure.
This is a preliminary patch to support mt7663 firmware

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  20 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 322 +++++++++---------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  19 +-
 4 files changed, 191 insertions(+), 173 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1fbd240c2b47..6c36585c3423 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1823,8 +1823,9 @@ static void
 mt7615_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
 	struct ieee80211_hw *hw = priv;
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
-	mt7615_mcu_set_bcn(hw, vif, vif->bss_conf.enable_beacon);
+	mt7615_mcu_add_beacon(dev, hw, vif, vif->bss_conf.enable_beacon);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 6ef1acc6531f..6586176c29af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -39,13 +39,13 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	running = mt7615_dev_running(dev);
 
 	if (!running) {
-		mt7615_mcu_ctrl_pm_state(dev, 0, 0);
+		mt7615_mcu_set_pm(dev, 0, 0);
 		mt7615_mcu_set_mac_enable(dev, 0, true);
 		mt7615_mac_enable_nf(dev, 0);
 	}
 
 	if (phy != &dev->phy) {
-		mt7615_mcu_ctrl_pm_state(dev, 1, 0);
+		mt7615_mcu_set_pm(dev, 1, 0);
 		mt7615_mcu_set_mac_enable(dev, 1, true);
 		mt7615_mac_enable_nf(dev, 1);
 	}
@@ -78,14 +78,14 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	if (phy != &dev->phy) {
-		mt7615_mcu_ctrl_pm_state(dev, 1, 1);
+		mt7615_mcu_set_pm(dev, 1, 1);
 		mt7615_mcu_set_mac_enable(dev, 1, false);
 	}
 
 	if (!mt7615_dev_running(dev)) {
 		cancel_delayed_work_sync(&dev->mt76.mac_work);
 
-		mt7615_mcu_ctrl_pm_state(dev, 0, 1);
+		mt7615_mcu_set_pm(dev, 0, 1);
 		mt7615_mcu_set_mac_enable(dev, 0, false);
 	}
 
@@ -157,7 +157,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	else
 		mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
 
-	ret = mt7615_mcu_set_dev_info(dev, vif, 1);
+	ret = mt7615_mcu_add_dev_info(dev, vif, true);
 	if (ret)
 		goto out;
 
@@ -200,7 +200,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	/* TODO: disable beacon for the bss */
 
-	mt7615_mcu_set_dev_info(dev, vif, 0);
+	mt7615_mcu_add_dev_info(dev, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 	if (vif->txq)
@@ -412,7 +412,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 
 	if (changed & BSS_CHANGED_ASSOC)
-		mt7615_mcu_set_bss_info(dev, vif, info->assoc);
+		mt7615_mcu_add_bss_info(dev, vif, info->assoc);
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = info->use_short_slot ? 9 : 20;
@@ -425,13 +425,13 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
-		mt7615_mcu_set_bss_info(dev, vif, info->enable_beacon);
+		mt7615_mcu_add_bss_info(dev, vif, info->enable_beacon);
 		mt7615_mcu_sta_add(dev, vif, NULL, info->enable_beacon);
 	}
 
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED))
-		mt7615_mcu_set_bcn(hw, vif, info->enable_beacon);
+		mt7615_mcu_add_beacon(dev, hw, vif, info->enable_beacon);
 
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -444,7 +444,7 @@ mt7615_channel_switch_beacon(struct ieee80211_hw *hw,
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7615_mcu_set_bcn(hw, vif, true);
+	mt7615_mcu_add_beacon(dev, hw, vif, true);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e5df46d7648a..1c26e2c3e476 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -312,6 +312,142 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 				   &req, sizeof(req), true);
 }
 
+static int
+mt7615_mcu_add_dev(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+		   bool enable)
+{
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
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = enable,
+			.band_idx = mvif->band_idx,
+		},
+	};
+
+	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
+				   &data, sizeof(data), true);
+}
+
+static int
+mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
+			      struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif, bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct ieee80211_mutable_offsets offs;
+	struct ieee80211_tx_info *info;
+	struct req {
+		u8 omac_idx;
+		u8 enable;
+		u8 wlan_idx;
+		u8 band_idx;
+		u8 pkt_type;
+		u8 need_pre_tbtt_int;
+		__le16 csa_ie_pos;
+		__le16 pkt_len;
+		__le16 tim_ie_pos;
+		u8 pkt[512];
+		u8 csa_cnt;
+		/* bss color change */
+		u8 bcc_cnt;
+		__le16 bcc_ie_pos;
+	} __packed req = {
+		.omac_idx = mvif->omac_idx,
+		.enable = enable,
+		.wlan_idx = wcid->idx,
+		.band_idx = mvif->band_idx,
+	};
+	struct sk_buff *skb;
+
+	skb = ieee80211_beacon_get_template(hw, vif, &offs);
+	if (!skb)
+		return -EINVAL;
+
+	if (skb->len > 512 - MT_TXD_SIZE) {
+		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	if (mvif->band_idx) {
+		info = IEEE80211_SKB_CB(skb);
+		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
+	}
+
+	mt7615_mac_write_txwi(dev, (__le32 *)(req.pkt), skb, wcid, NULL,
+			      0, NULL, true);
+	memcpy(req.pkt + MT_TXD_SIZE, skb->data, skb->len);
+	req.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
+	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
+	if (offs.csa_counter_offs[0]) {
+		u16 csa_offs;
+
+		csa_offs = MT_TXD_SIZE + offs.csa_counter_offs[0] - 4;
+		req.csa_ie_pos = cpu_to_le16(csa_offs);
+		req.csa_cnt = skb->data[offs.csa_counter_offs[0]];
+	}
+	dev_kfree_skb(skb);
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BCN_OFFLOAD,
+				   &req, sizeof(req), true);
+}
+
+static int
+mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
+{
+#define ENTER_PM_STATE	1
+#define EXIT_PM_STATE	2
+	struct {
+		u8 pm_number;
+		u8 pm_state;
+		u8 bssid[ETH_ALEN];
+		u8 dtim_period;
+		u8 wlan_idx;
+		__le16 bcn_interval;
+		__le32 aid;
+		__le32 rx_filter;
+		u8 band_idx;
+		u8 rsv[3];
+		__le32 feature;
+		u8 omac_idx;
+		u8 wmm_idx;
+		u8 bcn_loss_cnt;
+		u8 bcn_sp_duration;
+	} __packed req = {
+		.pm_number = 5,
+		.pm_state = state ? ENTER_PM_STATE : EXIT_PM_STATE,
+		.band_idx = band,
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL,
+				   &req, sizeof(req), true);
+}
+
 static struct sk_buff *
 mt7615_mcu_alloc_sta_req(struct mt7615_vif *mvif, struct mt7615_sta *msta)
 {
@@ -727,6 +863,29 @@ mt7615_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	}
 }
 
+static int
+mt7615_mcu_add_bss(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+		   bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct sk_buff *skb;
+
+	skb = mt7615_mcu_alloc_sta_req(mvif, NULL);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	if (enable)
+		mt7615_mcu_bss_omac_tlv(skb, vif);
+
+	mt7615_mcu_bss_basic_tlv(skb, vif, enable);
+
+	if (enable && mvif->omac_idx > EXT_BSSID_START)
+		mt7615_mcu_bss_ext_tlv(skb, mvif);
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_EXT_CMD_BSS_INFO_UPDATE, true);
+}
+
 static int
 mt7615_mcu_wtbl_tx_ba(struct mt7615_dev *dev,
 		      struct ieee80211_ampdu_params *params,
@@ -837,6 +996,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 }
 
 static const struct mt7615_mcu_ops wtbl_update_ops = {
+	.add_beacon_offload = mt7615_mcu_add_beacon_offload,
+	.set_pm_state = mt7615_mcu_ctrl_pm_state,
+	.add_dev_info = mt7615_mcu_add_dev,
+	.add_bss_info = mt7615_mcu_add_bss,
 	.add_tx_ba = mt7615_mcu_wtbl_tx_ba,
 	.add_rx_ba = mt7615_mcu_wtbl_rx_ba,
 	.sta_add = mt7615_mcu_wtbl_sta_add,
@@ -920,6 +1083,10 @@ mt7615_mcu_add_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 }
 
 static const struct mt7615_mcu_ops sta_update_ops = {
+	.add_beacon_offload = mt7615_mcu_add_beacon_offload,
+	.set_pm_state = mt7615_mcu_ctrl_pm_state,
+	.add_dev_info = mt7615_mcu_add_dev,
+	.add_bss_info = mt7615_mcu_add_bss,
 	.add_tx_ba = mt7615_mcu_sta_tx_ba,
 	.add_rx_ba = mt7615_mcu_sta_rx_ba,
 	.sta_add = mt7615_mcu_add_sta,
@@ -1465,36 +1632,6 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 				   &req, sizeof(req), true);
 }
 
-int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter)
-{
-#define ENTER_PM_STATE	1
-#define EXIT_PM_STATE	2
-	struct {
-		u8 pm_number;
-		u8 pm_state;
-		u8 bssid[ETH_ALEN];
-		u8 dtim_period;
-		u8 wlan_idx;
-		__le16 bcn_interval;
-		__le32 aid;
-		__le32 rx_filter;
-		u8 band_idx;
-		u8 rsv[3];
-		__le32 feature;
-		u8 omac_idx;
-		u8 wmm_idx;
-		u8 bcn_loss_cnt;
-		u8 bcn_sp_duration;
-	} __packed req = {
-		.pm_number = 5,
-		.pm_state = (enter) ? ENTER_PM_STATE : EXIT_PM_STATE,
-		.band_idx = band,
-	};
-
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL,
-				   &req, sizeof(req), true);
-}
-
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
 {
 	struct mt7615_phy *ext_phy = mt7615_ext_phy(dev);
@@ -1554,67 +1691,6 @@ int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
 				   &req, sizeof(req), true);
 }
 
-int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
-			    struct ieee80211_vif *vif, bool enable)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct {
-		struct req_hdr {
-			u8 omac_idx;
-			u8 band_idx;
-			__le16 tlv_num;
-			u8 is_tlv_append;
-			u8 rsv[3];
-		} __packed hdr;
-		struct req_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 active;
-			u8 band_idx;
-			u8 omac_addr[ETH_ALEN];
-		} __packed tlv;
-	} data = {
-		.hdr = {
-			.omac_idx = mvif->omac_idx,
-			.band_idx = mvif->band_idx,
-			.tlv_num = cpu_to_le16(1),
-			.is_tlv_append = 1,
-		},
-		.tlv = {
-			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
-			.len = cpu_to_le16(sizeof(struct req_tlv)),
-			.active = enable,
-			.band_idx = mvif->band_idx,
-		},
-	};
-
-	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
-				   &data, sizeof(data), true);
-}
-
-int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			    bool enable)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct sk_buff *skb;
-
-	skb = mt7615_mcu_alloc_sta_req(mvif, NULL);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	if (enable)
-		mt7615_mcu_bss_omac_tlv(skb, vif);
-
-	mt7615_mcu_bss_basic_tlv(skb, vif, enable);
-
-	if (enable && mvif->omac_idx > EXT_BSSID_START)
-		mt7615_mcu_bss_ext_tlv(skb, mvif);
-
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_BSS_INFO_UPDATE, true);
-}
-
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 {
 	struct wtbl_req_hdr req = {
@@ -1625,70 +1701,6 @@ int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 				   &req, sizeof(req), true);
 }
 
-int mt7615_mcu_set_bcn(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		       int en)
-{
-	struct mt7615_dev *dev = mt7615_hw_dev(hw);
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
-	struct ieee80211_mutable_offsets offs;
-	struct ieee80211_tx_info *info;
-	struct req {
-		u8 omac_idx;
-		u8 enable;
-		u8 wlan_idx;
-		u8 band_idx;
-		u8 pkt_type;
-		u8 need_pre_tbtt_int;
-		__le16 csa_ie_pos;
-		__le16 pkt_len;
-		__le16 tim_ie_pos;
-		u8 pkt[512];
-		u8 csa_cnt;
-		/* bss color change */
-		u8 bcc_cnt;
-		__le16 bcc_ie_pos;
-	} __packed req = {
-		.omac_idx = mvif->omac_idx,
-		.enable = en,
-		.wlan_idx = wcid->idx,
-		.band_idx = mvif->band_idx,
-	};
-	struct sk_buff *skb;
-
-	skb = ieee80211_beacon_get_template(hw, vif, &offs);
-	if (!skb)
-		return -EINVAL;
-
-	if (skb->len > 512 - MT_TXD_SIZE) {
-		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
-		dev_kfree_skb(skb);
-		return -EINVAL;
-	}
-
-	if (mvif->band_idx) {
-		info = IEEE80211_SKB_CB(skb);
-		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
-	}
-
-	mt7615_mac_write_txwi(dev, (__le32 *)(req.pkt), skb, wcid, NULL,
-			      0, NULL, true);
-	memcpy(req.pkt + MT_TXD_SIZE, skb->data, skb->len);
-	req.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
-	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
-	if (offs.csa_counter_offs[0]) {
-		u16 csa_offs;
-
-		csa_offs = MT_TXD_SIZE + offs.csa_counter_offs[0] - 4;
-		req.csa_ie_pos = cpu_to_le16(csa_offs);
-		req.csa_cnt = skb->data[offs.csa_counter_offs[0]];
-	}
-	dev_kfree_skb(skb);
-
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BCN_OFFLOAD,
-				   &req, sizeof(req), true);
-}
-
 int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		       enum mt7615_rdd_cmd cmd, u8 index,
 		       u8 rx_sel, u8 val)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 66fb77e9c311..e51b6ab6ebb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -147,6 +147,10 @@ struct mt7615_phy {
 #define mt7615_mcu_add_tx_ba(dev, ...)	(dev)->mcu_ops->add_tx_ba((dev), __VA_ARGS__)
 #define mt7615_mcu_add_rx_ba(dev, ...)	(dev)->mcu_ops->add_rx_ba((dev), __VA_ARGS__)
 #define mt7615_mcu_sta_add(dev, ...)	(dev)->mcu_ops->sta_add((dev),  __VA_ARGS__)
+#define mt7615_mcu_add_dev_info(dev, ...) (dev)->mcu_ops->add_dev_info((dev),  __VA_ARGS__)
+#define mt7615_mcu_add_bss_info(dev, ...) (dev)->mcu_ops->add_bss_info((dev),  __VA_ARGS__)
+#define mt7615_mcu_add_beacon(dev, ...)	(dev)->mcu_ops->add_beacon_offload((dev),  __VA_ARGS__)
+#define mt7615_mcu_set_pm(dev, ...)	(dev)->mcu_ops->set_pm_state((dev),  __VA_ARGS__)
 struct mt7615_mcu_ops {
 	int (*add_tx_ba)(struct mt7615_dev *dev,
 			 struct ieee80211_ampdu_params *params,
@@ -157,6 +161,14 @@ struct mt7615_mcu_ops {
 	int (*sta_add)(struct mt7615_dev *dev,
 		       struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable);
+	int (*add_dev_info)(struct mt7615_dev *dev,
+			    struct ieee80211_vif *vif, bool enable);
+	int (*add_bss_info)(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			    bool enable);
+	int (*add_beacon_offload)(struct mt7615_dev *dev,
+				  struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif, bool enable);
+	int (*set_pm_state)(struct mt7615_dev *dev, int band, int state);
 };
 
 struct mt7615_dev {
@@ -301,16 +313,10 @@ int mt7615_dma_init(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
 int mt7615_mcu_init(struct mt7615_dev *dev);
 bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev);
-int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
-			    struct ieee80211_vif *vif, bool enable);
-int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			    bool enable);
 void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev);
-int mt7615_mcu_set_bcn(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		       int en);
 int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd);
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 		       const struct ieee80211_tx_queue_params *params);
@@ -368,7 +374,6 @@ int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable);
 int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val);
-int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int enter);
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
-- 
2.24.1

