Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38B301489
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jan 2021 11:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbhAWKeJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Jan 2021 05:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbhAWKeE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Jan 2021 05:34:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81B5622CB9;
        Sat, 23 Jan 2021 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611398002;
        bh=7Zp0T6CtUn2xXiOKNhHbG5jezvQwyvbCAxDv/xZBEzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCOotMlUDYrP5piFoHSPRyEzvS2Ph+PzDMdlvBJx4DwD2CDxiF4aNqhUzbTRQtUQo
         U+XbYE1Wb+kwcwNVID8u9crI/fUJK5xj5zj/u6gELxnmTJKLOK+H73cH7wg/qqOzej
         0BGGaJu1GwBEg2m87y53/x3PYX+zp4F+y3AqUyq2dlQiY9hb0gRvvmoo8gezruV43X
         K8TczX3UEOEx0AgMEBk+zQ4RZTAwF+j/A6l0n+ZdC9EOzMhjE4+3iyxbTy2XynjBus
         Kr9LDIq48aGniRjoV797bFWkBdLe1BIGfVKnF/rScZg+wpEJ5j7nWK2aP6b2b1028S
         p9iypa2wm5R8A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/6] mt76: introduce mt76_vif data structure
Date:   Sat, 23 Jan 2021 11:32:59 +0100
Message-Id: <60b9765049ba45e5167206ee5aaf19329e98467f.1611397696.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611397696.git.lorenzo@kernel.org>
References: <cover.1611397696.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76_vif data structure to share common fields between
mt7615_vif and mt7921_vif and create a mcu common library

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   8 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  38 +++---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 109 +++++++++---------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   7 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |   2 +-
 6 files changed, 85 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3e2191efc4f0..8bf45497cfca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -561,6 +561,14 @@ struct mt76_testmode_data {
 	} rx_stats;
 };
 
+struct mt76_vif {
+	u8 idx;
+	u8 omac_idx;
+	u8 band_idx;
+	u8 wmm_idx;
+	u8 scan_seq_num;
+};
+
 struct mt76_phy {
 	struct ieee80211_hw *hw;
 	struct mt76_dev *dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 26909fdbb0a5..18b947f3bb9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -544,7 +544,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	u16 seqno = 0;
 
 	if (vif) {
-		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 
 		omac_idx = mvif->omac_idx;
 		wmm_idx = mvif->wmm_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index d655604b2993..46a9e9927074 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -187,8 +187,8 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	    is_zero_ether_addr(vif->addr))
 		phy->monitor_vif = vif;
 
-	mvif->idx = ffs(~dev->mt76.vif_mask) - 1;
-	if (mvif->idx >= MT7615_MAX_INTERFACES) {
+	mvif->mt76.idx = ffs(~dev->mt76.vif_mask) - 1;
+	if (mvif->mt76.idx >= MT7615_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -198,26 +198,26 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 		ret = -ENOSPC;
 		goto out;
 	}
-	mvif->omac_idx = idx;
+	mvif->mt76.omac_idx = idx;
 
-	mvif->band_idx = ext_phy;
+	mvif->mt76.band_idx = ext_phy;
 	if (mt7615_ext_phy(dev))
-		mvif->wmm_idx = ext_phy * (MT7615_MAX_WMM_SETS / 2) +
-				mvif->idx % (MT7615_MAX_WMM_SETS / 2);
+		mvif->mt76.wmm_idx = ext_phy * (MT7615_MAX_WMM_SETS / 2) +
+				mvif->mt76.idx % (MT7615_MAX_WMM_SETS / 2);
 	else
-		mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
+		mvif->mt76.wmm_idx = mvif->mt76.idx % MT7615_MAX_WMM_SETS;
 
-	dev->mt76.vif_mask |= BIT(mvif->idx);
-	dev->omac_mask |= BIT_ULL(mvif->omac_idx);
-	phy->omac_mask |= BIT_ULL(mvif->omac_idx);
+	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
+	dev->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
+	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
 	mt7615_mcu_set_dbdc(dev);
 
-	idx = MT7615_WTBL_RESERVED - mvif->idx;
+	idx = MT7615_WTBL_RESERVED - mvif->mt76.idx;
 
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.ext_phy = mvif->band_idx;
+	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -263,9 +263,9 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	dev->mt76.vif_mask &= ~BIT(mvif->idx);
-	dev->omac_mask &= ~BIT_ULL(mvif->omac_idx);
-	phy->omac_mask &= ~BIT_ULL(mvif->omac_idx);
+	dev->mt76.vif_mask &= ~BIT(mvif->mt76.idx);
+	dev->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 
 	mt7615_mutex_release(dev);
 
@@ -445,7 +445,7 @@ static int
 mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	int err;
 
@@ -589,7 +589,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.ext_phy = mvif->band_idx;
+	msta->wcid.ext_phy = mvif->mt76.band_idx;
 
 	err = mt7615_pm_wake(dev);
 	if (err)
@@ -598,7 +598,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		struct mt7615_phy *phy;
 
-		phy = mvif->band_idx ? mt7615_ext_phy(dev) : &dev->phy;
+		phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
 		mt7615_mcu_add_bss_info(phy, vif, sta, true);
 	}
 	mt7615_mac_wtbl_update(dev, idx,
@@ -627,7 +627,7 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 		struct mt7615_phy *phy;
 
-		phy = mvif->band_idx ? mt7615_ext_phy(dev) : &dev->phy;
+		phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
 		mt7615_mcu_add_bss_info(phy, vif, sta, false);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9aa4ec103262..aa744414f71b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -486,7 +486,7 @@ mt7615_mcu_beacon_loss_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_beacon_loss_event *event = priv;
 
-	if (mvif->idx != event->bss_idx)
+	if (mvif->mt76.idx != event->bss_idx)
 		return;
 
 	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
@@ -604,7 +604,7 @@ mt7615_mcu_muar_config(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		       bool bssid, bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	u32 idx = mvif->omac_idx - REPEATER_BSSID_START;
+	u32 idx = mvif->mt76.omac_idx - REPEATER_BSSID_START;
 	u32 mask = dev->omac_mask >> 32 & ~BIT(idx);
 	const u8 *addr = vif->addr;
 	struct {
@@ -657,8 +657,8 @@ mt7615_mcu_add_dev(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		} __packed tlv;
 	} data = {
 		.hdr = {
-			.omac_idx = mvif->omac_idx,
-			.band_idx = mvif->band_idx,
+			.omac_idx = mvif->mt76.omac_idx,
+			.band_idx = mvif->mt76.band_idx,
 			.tlv_num = cpu_to_le16(1),
 			.is_tlv_append = 1,
 		},
@@ -666,11 +666,11 @@ mt7615_mcu_add_dev(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
 			.len = cpu_to_le16(sizeof(struct req_tlv)),
 			.active = enable,
-			.band_idx = mvif->band_idx,
+			.band_idx = mvif->mt76.band_idx,
 		},
 	};
 
-	if (mvif->omac_idx >= REPEATER_BSSID_START)
+	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START)
 		return mt7615_mcu_muar_config(dev, vif, false, enable);
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
@@ -703,10 +703,10 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 		u8 bcc_cnt;
 		__le16 bcc_ie_pos;
 	} __packed req = {
-		.omac_idx = mvif->omac_idx,
+		.omac_idx = mvif->mt76.omac_idx,
 		.enable = enable,
 		.wlan_idx = wcid->idx,
-		.band_idx = mvif->band_idx,
+		.band_idx = mvif->mt76.band_idx,
 	};
 	struct sk_buff *skb;
 
@@ -720,7 +720,7 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 		return -EINVAL;
 	}
 
-	if (mvif->band_idx) {
+	if (mvif->mt76.band_idx) {
 		info = IEEE80211_SKB_CB(skb);
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 	}
@@ -779,9 +779,9 @@ mt7615_mcu_alloc_sta_req(struct mt7615_dev *dev, struct mt7615_vif *mvif,
 			 struct mt7615_sta *msta)
 {
 	struct sta_req_hdr hdr = {
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 		.wlan_idx = msta ? msta->wcid.idx : 0,
-		.muar_idx = msta ? mvif->omac_idx : 0,
+		.muar_idx = msta ? mvif->mt76.omac_idx : 0,
 		.is_tlv_append = 1,
 	};
 	struct sk_buff *skb;
@@ -893,7 +893,7 @@ mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	bss->network_type = cpu_to_le32(type);
 	bss->dtim_period = vif->bss_conf.dtim_period;
 	bss->bmc_tx_wlan_idx = wlan_idx;
-	bss->wmm_idx = mvif->wmm_idx;
+	bss->wmm_idx = mvif->mt76.wmm_idx;
 	bss->active = enable;
 
 	return 0;
@@ -903,10 +903,10 @@ static void
 mt7615_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	u8 omac_idx = mvif->mt76.omac_idx;
 	struct bss_info_omac *omac;
 	struct tlv *tlv;
 	u32 type = 0;
-	u8 idx;
 
 	tlv = mt7615_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
 
@@ -933,11 +933,10 @@ mt7615_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	}
 
 	omac = (struct bss_info_omac *)tlv;
-	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
 	omac->conn_type = cpu_to_le32(type);
-	omac->omac_idx = mvif->omac_idx;
-	omac->band_idx = mvif->band_idx;
-	omac->hw_bss_idx = idx;
+	omac->omac_idx = mvif->mt76.omac_idx;
+	omac->band_idx = mvif->mt76.band_idx;
+	omac->hw_bss_idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
 }
 
 /* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
@@ -949,7 +948,7 @@ mt7615_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt7615_vif *mvif)
 	int ext_bss_idx, tsf_offset;
 	struct tlv *tlv;
 
-	ext_bss_idx = mvif->omac_idx - EXT_BSSID_START;
+	ext_bss_idx = mvif->mt76.omac_idx - EXT_BSSID_START;
 	if (ext_bss_idx < 0)
 		return;
 
@@ -1153,7 +1152,7 @@ mt7615_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		else
 			generic->partial_aid = cpu_to_le16(sta->aid);
 		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
-		generic->muar_idx = mvif->omac_idx;
+		generic->muar_idx = mvif->mt76.omac_idx;
 		generic->qos = sta->wme;
 	} else {
 		eth_broadcast_addr(generic->peer_addr);
@@ -1255,7 +1254,7 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	struct mt7615_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
-	if (mvif->omac_idx >= REPEATER_BSSID_START)
+	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START)
 		mt7615_mcu_muar_config(dev, vif, true, enable);
 
 	skb = mt7615_mcu_alloc_sta_req(dev, mvif, NULL);
@@ -1267,8 +1266,8 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 
 	mt7615_mcu_bss_basic_tlv(skb, vif, sta, enable);
 
-	if (enable && mvif->omac_idx >= EXT_BSSID_START &&
-	    mvif->omac_idx < REPEATER_BSSID_START)
+	if (enable && mvif->mt76.omac_idx >= EXT_BSSID_START &&
+	    mvif->mt76.omac_idx < REPEATER_BSSID_START)
 		mt7615_mcu_bss_ext_tlv(skb, mvif);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
@@ -1505,6 +1504,7 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 		       struct ieee80211_vif *vif, bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	u8 omac_idx = mvif->mt76.omac_idx;
 	struct {
 		struct {
 			u8 omac_idx;
@@ -1520,8 +1520,8 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 		} __packed tlv;
 	} dev_req = {
 		.hdr = {
-			.omac_idx = mvif->omac_idx,
-			.band_idx = mvif->band_idx,
+			.omac_idx = omac_idx,
+			.band_idx = mvif->mt76.band_idx,
 		},
 		.tlv = {
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
@@ -1537,14 +1537,14 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 		struct mt7615_bss_basic_tlv basic;
 	} basic_req = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.basic = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
 			.len = cpu_to_le16(sizeof(struct mt7615_bss_basic_tlv)),
-			.omac_idx = mvif->omac_idx,
-			.band_idx = mvif->band_idx,
-			.wmm_idx = mvif->wmm_idx,
+			.omac_idx = omac_idx,
+			.band_idx = mvif->mt76.band_idx,
+			.wmm_idx = mvif->mt76.wmm_idx,
 			.active = enable,
 			.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx),
 			.sta_idx = cpu_to_le16(mvif->sta.wcid.idx),
@@ -1570,7 +1570,7 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 		break;
 	}
 
-	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
 	basic_req.basic.hw_bss_idx = idx;
 
 	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
@@ -1603,6 +1603,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	u8 omac_idx = mvif->mt76.omac_idx;
 	struct mt7615_dev *dev = phy->dev;
 	struct {
 		struct {
@@ -1613,16 +1614,16 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		struct mt7615_bss_qos_tlv qos;
 	} basic_req = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.basic = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
 			.len = cpu_to_le16(sizeof(struct mt7615_bss_basic_tlv)),
 			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
 			.dtim_period = vif->bss_conf.dtim_period,
-			.omac_idx = mvif->omac_idx,
-			.band_idx = mvif->band_idx,
-			.wmm_idx = mvif->wmm_idx,
+			.omac_idx = omac_idx,
+			.band_idx = mvif->mt76.band_idx,
+			.wmm_idx = mvif->mt76.wmm_idx,
 			.active = true, /* keep bss deactivated */
 			.phymode = 0x38,
 		},
@@ -1653,7 +1654,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		} __packed rlm;
 	} __packed rlm_req = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.rlm = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
@@ -1669,7 +1670,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	int err, conn_type;
 	u8 idx;
 
-	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
 	basic_req.basic.hw_bss_idx = idx;
 
 	switch (vif->type) {
@@ -1775,7 +1776,7 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 		} __packed beacon_tlv;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.beacon_tlv = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
@@ -2964,7 +2965,7 @@ int mt7615_mcu_set_vif_ps(struct mt7615_dev *dev, struct ieee80211_vif *vif)
 			      * 2: dynamic power saving
 			      */
 	} req = {
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 		.ps_state = vif->bss_conf.ps ? 2 : 0,
 	};
 
@@ -3078,12 +3079,12 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		return -ENOMEM;
 
 	set_bit(MT76_HW_SCANNING, &phy->mt76->state);
-	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+	mvif->mt76.scan_seq_num = (mvif->mt76.scan_seq_num + 1) & 0x7f;
 
 	req = (struct mt7615_hw_scan_req *)skb_put(skb, sizeof(*req));
 
-	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
-	req->bss_idx = mvif->idx;
+	req->seq_num = mvif->mt76.scan_seq_num | ext_phy << 7;
+	req->bss_idx = mvif->mt76.idx;
 	req->scan_type = sreq->n_ssids ? 1 : 0;
 	req->probe_req_num = sreq->n_ssids ? 2 : 0;
 	req->version = 1;
@@ -3151,7 +3152,7 @@ int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
 		u8 is_ext_channel;
 		u8 rsv[2];
 	} __packed req = {
-		.seq_num = mvif->scan_seq_num,
+		.seq_num = mvif->mt76.scan_seq_num,
 	};
 
 	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->mt76->state)) {
@@ -3189,11 +3190,11 @@ int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
 	if (!skb)
 		return -ENOMEM;
 
-	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
+	mvif->mt76.scan_seq_num = (mvif->mt76.scan_seq_num + 1) & 0x7f;
 
 	req = (struct mt7615_sched_scan_req *)skb_put(skb, sizeof(*req));
 	req->version = 1;
-	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
+	req->seq_num = mvif->mt76.scan_seq_num | ext_phy << 7;
 
 	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
 		get_random_mask_addr(req->random_mac, sreq->mac_addr,
@@ -3547,7 +3548,7 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		u8 bmc_triggered_ac;
 		u8 pad;
 	} req = {
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 		.aid = cpu_to_le16(vif->bss_conf.aid),
 		.dtim_period = vif->bss_conf.dtim_period,
 		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
@@ -3556,7 +3557,7 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		u8 bss_idx;
 		u8 pad[3];
 	} req_hdr = {
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 	};
 	int err;
 
@@ -3623,7 +3624,7 @@ mt7615_mcu_set_wow_ctrl(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		struct mt7615_wow_gpio_param_tlv gpio_tlv;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.wow_ctrl_tlv = {
 			.tag = cpu_to_le16(UNI_SUSPEND_WOW_CTRL),
@@ -3671,7 +3672,7 @@ mt7615_mcu_set_wow_pattern(struct mt7615_dev *dev,
 		u8 bss_idx;
 		u8 pad[3];
 	} __packed hdr = {
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 	};
 
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
@@ -3708,7 +3709,7 @@ mt7615_mcu_set_suspend_mode(struct mt7615_dev *dev,
 		struct mt7615_suspend_tlv suspend_tlv;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.suspend_tlv = {
 			.tag = cpu_to_le16(UNI_SUSPEND_MODE_SETTING),
@@ -3737,7 +3738,7 @@ mt7615_mcu_set_gtk_rekey(struct mt7615_dev *dev,
 		struct mt7615_gtk_rekey_tlv gtk_tlv;
 	} __packed req = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.gtk_tlv = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY),
@@ -3763,7 +3764,7 @@ mt7615_mcu_set_arp_filter(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		struct mt7615_arpns_tlv arpns;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.arpns = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
@@ -3837,7 +3838,7 @@ int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 		u8 bss_idx;
 		u8 pad[3];
 	} __packed hdr = {
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 	};
 
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
@@ -3872,7 +3873,7 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = phy->dev;
 	struct mt7615_roc_tlv req = {
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 		.active = !chan,
 		.max_interval = cpu_to_le32(duration),
 		.primary_chan = chan ? chan->hw_value : 0,
@@ -3903,7 +3904,7 @@ int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
 		struct mt7615_arpns_tlv arp;
 	} req_hdr = {
 		.hdr = {
-			.bss_idx = mvif->idx,
+			.bss_idx = mvif->mt76.idx,
 		},
 		.arp = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ARP),
@@ -3945,7 +3946,7 @@ int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 		u8 rsv[3];
 	} __packed req = {
 		.ct_win = cpu_to_le32(ct_window),
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 	};
 
 	if (!mt7615_firmware_offload(dev))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 99adbc933d0c..ba820f85063b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -133,12 +133,7 @@ struct mt7615_sta {
 };
 
 struct mt7615_vif {
-	u8 idx;
-	u8 omac_idx;
-	u8 band_idx;
-	u8 wmm_idx;
-	u8 scan_seq_num;
-
+	struct mt76_vif mt76; /* must be first */
 	struct mt7615_sta sta;
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 4cf7c5d34325..1b4cb145f38e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -118,7 +118,7 @@ mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
 
 	if (vif) {
-		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 
 		txp->bss_idx = mvif->idx;
 	}
-- 
2.29.2

