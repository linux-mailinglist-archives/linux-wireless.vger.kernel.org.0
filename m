Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032C94EE415
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbiCaWe2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 18:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbiCaWe0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 18:34:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A524A77C
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 15:32:33 -0700 (PDT)
X-UUID: ffeee6dc82124f9c92919d7900c5f864-20220401
X-UUID: ffeee6dc82124f9c92919d7900c5f864-20220401
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1408182338; Fri, 01 Apr 2022 06:32:27 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 1 Apr 2022 06:32:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 1 Apr
 2022 06:32:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Apr 2022 06:32:25 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: Add hotspot mode support
Date:   Fri, 1 Apr 2022 06:32:24 +0800
Message-ID: <734908dd741b85b7cc3855f23596cc5884c335e4.1648765636.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add hostspot mode support to mt7921 that can work for mt7921[e,s,u]
with the common code.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 11 ++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  9 +++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 46 +++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 79 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  4 +
 5 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 91fc41922d95..f9e1255bd9c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -11,6 +11,10 @@ static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = MT7921_MAX_INTERFACES,
 		.types = BIT(NL80211_IFTYPE_STATION)
+	},
+	{
+		.max = 1,
+		.types = BIT(NL80211_IFTYPE_AP)
 	}
 };
 
@@ -64,7 +68,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->iface_combinations = if_comb;
 	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
 			  WIPHY_FLAG_4ADDR_STATION);
-	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
+	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				 BIT(NL80211_IFTYPE_AP);
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
@@ -80,6 +85,10 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
 			   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index f34070ca7bbe..368e54c53ddd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1361,12 +1361,21 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct mt7921_dev *dev = mvif->phy->dev;
+	struct ieee80211_hw *hw = mt76_hw(dev);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
 
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, true);
 	mt7921_mcu_set_tx(dev, vif);
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.wcid,
+					    true);
+		mt7921_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_NONE);
+		mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
+	}
 }
 
 /* system error recovery */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index ae86705faec2..52b7e3684189 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -53,6 +53,7 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 
 		switch (i) {
 		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_AP:
 			break;
 		default:
 			continue;
@@ -86,6 +87,23 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 			IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
 
 		switch (i) {
+		case NL80211_IFTYPE_AP:
+			he_cap_elem->mac_cap_info[2] |=
+				IEEE80211_HE_MAC_CAP2_BSR;
+			he_cap_elem->mac_cap_info[4] |=
+				IEEE80211_HE_MAC_CAP4_BQR;
+			he_cap_elem->mac_cap_info[5] |=
+				IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX;
+			he_cap_elem->phy_cap_info[3] |=
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
+				IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_QPSK;
+			he_cap_elem->phy_cap_info[6] |=
+				IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
+				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
+			he_cap_elem->phy_cap_info[9] |=
+				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
+			break;
 		case NL80211_IFTYPE_STATION:
 			he_cap_elem->mac_cap_info[1] |=
 				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
@@ -634,6 +652,21 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
+		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+		mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
+					    true);
+		mt7921_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_NONE);
+	}
+
+	if (changed & (BSS_CHANGED_BEACON |
+		       BSS_CHANGED_BEACON_ENABLED)) {
+		mt7921_mcu_uni_add_beacon_offload(dev, hw, vif,
+						  info->enable_beacon);
+	}
+
 	/* ensure that enable txcmd_mode after bss_info */
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7921_mcu_set_tx(dev, vif);
@@ -1394,6 +1427,18 @@ static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
 	return err;
 }
 
+static void
+mt7921_channel_switch_beacon(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct cfg80211_chan_def *chandef)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	mt7921_mutex_acquire(dev);
+	mt7921_mcu_uni_add_beacon_offload(dev, hw, vif, true);
+	mt7921_mutex_release(dev);
+}
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt7921_tx,
 	.start = mt7921_start,
@@ -1412,6 +1457,7 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_rts_threshold = mt7921_set_rts_threshold,
 	.wake_tx_queue = mt76_wake_tx_queue,
 	.release_buffered_frames = mt76_release_buffered_frames,
+	.channel_switch_beacon = mt7921_channel_switch_beacon,
 	.get_txpower = mt76_get_txpower,
 	.get_stats = mt7921_get_stats,
 	.get_et_sset_count = mt7921_get_et_sset_count,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index da2be050ed7c..1ecbbe4fa498 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -248,7 +248,8 @@ mt7921_mcu_connection_loss_iter(void *priv, u8 *mac,
 	if (mvif->idx != event->bss_idx)
 		return;
 
-	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
+	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER) ||
+	    vif->type != NL80211_IFTYPE_STATION)
 		return;
 
 	ieee80211_connection_loss(vif);
@@ -1166,3 +1167,79 @@ int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
 				 true);
 }
+
+int
+mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
+				  struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  bool enable)
+{
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct ieee80211_mutable_offsets offs;
+	struct {
+		struct req_hdr {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct bcn_content_tlv {
+			__le16 tag;
+			__le16 len;
+			__le16 tim_ie_pos;
+			__le16 csa_ie_pos;
+			__le16 bcc_ie_pos;
+			/* 0: disable beacon offload
+			 * 1: enable beacon offload
+			 * 2: update probe respond offload
+			 */
+			u8 enable;
+			/* 0: legacy format (TXD + payload)
+			 * 1: only cap field IE
+			 */
+			u8 type;
+			__le16 pkt_len;
+			u8 pkt[512];
+		} __packed beacon_tlv;
+	} req = {
+		.hdr = {
+			.bss_idx = mvif->mt76.idx,
+		},
+		.beacon_tlv = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
+			.len = cpu_to_le16(sizeof(struct bcn_content_tlv)),
+			.enable = enable,
+		},
+	};
+	struct sk_buff *skb;
+
+	if (!enable)
+		goto out;
+
+	skb = ieee80211_beacon_get_template(mt76_hw(dev), vif, &offs);
+	if (!skb)
+		return -EINVAL;
+
+	if (skb->len > 512 - MT_TXD_SIZE) {
+		dev_err(dev->mt76.dev, "beacon size limit exceed\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	mt7921_mac_write_txwi(dev, (__le32 *)(req.beacon_tlv.pkt), skb,
+			      wcid, NULL, 0, true);
+	memcpy(req.beacon_tlv.pkt + MT_TXD_SIZE, skb->data, skb->len);
+	req.beacon_tlv.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
+	req.beacon_tlv.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
+
+	if (offs.cntdwn_counter_offs[0]) {
+		u16 csa_offs;
+
+		csa_offs = MT_TXD_SIZE + offs.cntdwn_counter_offs[0] - 4;
+		req.beacon_tlv.csa_ie_pos = cpu_to_le16(csa_offs);
+	}
+	dev_kfree_skb(skb);
+
+out:
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
+				 &req, sizeof(req), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index eae223a31000..adbdb2e22934 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -469,4 +469,8 @@ int mt7921u_wfsys_reset(struct mt7921_dev *dev);
 int mt7921u_dma_init(struct mt7921_dev *dev, bool resume);
 int mt7921u_init_reset(struct mt7921_dev *dev);
 int mt7921u_mac_reset(struct mt7921_dev *dev);
+int mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
+				      struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      bool enable);
 #endif
-- 
2.25.1

