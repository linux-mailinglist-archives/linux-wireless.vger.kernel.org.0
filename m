Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA413B5B36
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhF1J3H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 05:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232480AbhF1J3G (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 05:29:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E66461C49;
        Mon, 28 Jun 2021 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624872401;
        bh=CNYgbUhag4J6IPy1rTOywb5nHKDlaf8BTKh4dR9sMRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErWlAgvcKS37hQimCasgTA1n8ILCTueWKt2hMcYzKfSPRubjiHCE8ebuyKX07XJA+
         55kvhJMwm0KiM/dmUokBqCzvYJVtbFiaNdEXvFaq+FlzNgYJjOGR/U4S0UpfBm0lAt
         szX0YL8QK1Pfu2povvHLjgNG7z+Vw77yD0YVjk/kVMxU3dS1Gdo3V3NrXDcs1zCt8t
         BGmaJw9Z8JjrHcpeVLLTaQ/TuqyCbUkyP1MInw3/WsPAUskV5ZB9O4v0d3iuUSQVB8
         vtoZZveveT+2uxFnIMNvqgD39vEBvjIWiEW2qRbC9vjD9w1xumnx4h438HboN83YvQ
         iUdEGr44tPXxg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     john@phrozen.org, nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v8 mac80211-next 3/3] mt76: mt7915: introduce bss coloring support
Date:   Mon, 28 Jun 2021 11:26:22 +0200
Message-Id: <5a2eec67784c4fa3989c5c3bf6bf3572ed8dc806.1624872141.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624872141.git.lorenzo@kernel.org>
References: <cover.1624872141.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mcu APIs to configure bss coloring and to report bss coloring
collisions. Add support to report coloring countdown in beacon sent by
the device.

Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 26 ++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 84 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 21 ++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
 5 files changed, 105 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 822f3aa6bb8b..49720a7a9595 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -146,6 +146,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->reg_notifier = mt7915_regd_notifier;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index e5bd687546b6..c93b2ecd4bcf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -526,6 +526,29 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static void
+mt7915_update_bss_color(struct ieee80211_hw *hw,
+			struct ieee80211_vif *vif,
+			struct cfg80211_he_bss_color *bss_color)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP: {
+		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+
+		if (mvif->omac_idx > HW_BSSID_MAX)
+			return;
+		fallthrough;
+	}
+	case NL80211_IFTYPE_STATION:
+		mt7915_mcu_update_bss_color(dev, vif, bss_color);
+		break;
+	default:
+		break;
+	}
+}
+
 static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
@@ -574,6 +597,9 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
 		mt7915_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
 
+	if (changed & BSS_CHANGED_HE_BSS_COLOR)
+		mt7915_update_bss_color(hw, vif, &info->he_bss_color);
+
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED))
 		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b3f14ff67c5a..353560078940 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -525,6 +525,15 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 		   (int)(skb->len - sizeof(*rxd)), data);
 }
 
+static void
+mt7915_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	if (!vif->color_change_active)
+		return;
+
+	ieee80211_color_change_finish(vif);
+}
+
 static void
 mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 {
@@ -543,6 +552,11 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	case MCU_EXT_EVENT_FW_LOG_2_HOST:
 		mt7915_mcu_rx_log_message(dev, skb);
 		break;
+	case MCU_EXT_EVENT_BCC_NOTIFY:
+		ieee80211_iterate_active_interfaces_atomic(dev->mt76.hw,
+				IEEE80211_IFACE_ITER_RESUME_ALL,
+				mt7915_mcu_cca_finish, dev);
+		break;
 	default:
 		break;
 	}
@@ -571,6 +585,7 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
 	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
+	    rxd->ext_eid == MCU_EXT_EVENT_BCC_NOTIFY ||
 	    rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
 	    !rxd->seq)
 		mt7915_mcu_rx_unsolicited_event(dev, skb);
@@ -2394,25 +2409,28 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 }
 
 static void
-mt7915_mcu_beacon_csa(struct sk_buff *rskb, struct sk_buff *skb,
-		      struct bss_info_bcn *bcn,
-		      struct ieee80211_mutable_offsets *offs)
+mt7915_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
+			 struct sk_buff *skb, struct bss_info_bcn *bcn,
+			 struct ieee80211_mutable_offsets *offs)
 {
-	if (offs->cntdwn_counter_offs[0]) {
-		struct tlv *tlv;
-		struct bss_info_bcn_csa *csa;
+	struct bss_info_bcn_cntdwn *info;
+	struct tlv *tlv;
+	int sub_tag;
 
-		tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_CSA,
-						   sizeof(*csa), &bcn->sub_ntlv,
-						   &bcn->len);
-		csa = (struct bss_info_bcn_csa *)tlv;
-		csa->cnt = skb->data[offs->cntdwn_counter_offs[0]];
-	}
+	if (!offs->cntdwn_counter_offs[0])
+		return;
+
+	sub_tag = vif->csa_active ? BSS_INFO_BCN_CSA : BSS_INFO_BCN_BCC;
+	tlv = mt7915_mcu_add_nested_subtlv(rskb, sub_tag, sizeof(*info),
+					   &bcn->sub_ntlv, &bcn->len);
+	info = (struct bss_info_bcn_cntdwn *)tlv;
+	info->cnt = skb->data[offs->cntdwn_counter_offs[0]];
 }
 
 static void
-mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct sk_buff *rskb,
-		       struct sk_buff *skb, struct bss_info_bcn *bcn,
+mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+		       struct sk_buff *rskb, struct sk_buff *skb,
+		       struct bss_info_bcn *bcn,
 		       struct ieee80211_mutable_offsets *offs)
 {
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
@@ -2428,8 +2446,14 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct sk_buff *rskb,
 	cont->pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	cont->tim_ofs = cpu_to_le16(offs->tim_offset);
 
-	if (offs->cntdwn_counter_offs[0])
-		cont->csa_ofs = cpu_to_le16(offs->cntdwn_counter_offs[0] - 4);
+	if (offs->cntdwn_counter_offs[0]) {
+		u16 offset = offs->cntdwn_counter_offs[0];
+
+		if (vif->csa_active)
+			cont->csa_ofs = cpu_to_le16(offset - 4);
+		if (vif->color_change_active)
+			cont->bcc_ofs = cpu_to_le16(offset - 3);
+	}
 
 	buf = (u8 *)tlv + sizeof(*cont);
 	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL,
@@ -2477,9 +2501,9 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 	}
 
-	/* TODO: subtag - bss color count & 11v MBSSID */
-	mt7915_mcu_beacon_csa(rskb, skb, bcn, &offs);
-	mt7915_mcu_beacon_cont(dev, rskb, skb, bcn, &offs);
+	/* TODO: subtag - 11v MBSSID */
+	mt7915_mcu_beacon_cntdwn(vif, rskb, skb, bcn, &offs);
+	mt7915_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
 	dev_kfree_skb(skb);
 
 out:
@@ -3796,3 +3820,25 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 
 	return ret;
 }
+
+int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+				struct cfg80211_he_bss_color *he_bss_color)
+{
+	int len = sizeof(struct sta_req_hdr) + sizeof(struct bss_info_color);
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct bss_info_color *bss_color;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	skb = mt7915_mcu_alloc_sta_req(dev, mvif, NULL, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_BSS_COLOR, sizeof(*bss_color));
+	bss_color = (struct bss_info_color *)tlv;
+	bss_color->disable = !he_bss_color->enabled;
+	bss_color->color = he_bss_color->color;
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 42582a66e42d..98201f771cf0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -43,6 +43,7 @@ enum {
 	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
 	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
+	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
 	MCU_EXT_EVENT_RATE_REPORT = 0x87,
 };
 
@@ -507,6 +508,14 @@ struct bss_info_hw_amsdu {
 	u8 rsv;
 } __packed;
 
+struct bss_info_color {
+	__le16 tag;
+	__le16 len;
+	u8 disable;
+	u8 color;
+	u8 rsv[2];
+} __packed;
+
 struct bss_info_he {
 	__le16 tag;
 	__le16 len;
@@ -525,14 +534,7 @@ struct bss_info_bcn {
 	__le16 sub_ntlv;
 } __packed __aligned(4);
 
-struct bss_info_bcn_csa {
-	__le16 tag;
-	__le16 len;
-	u8 cnt;
-	u8 rsv[3];
-} __packed __aligned(4);
-
-struct bss_info_bcn_bcc {
+struct bss_info_bcn_cntdwn {
 	__le16 tag;
 	__le16 len;
 	u8 cnt;
@@ -1102,8 +1104,7 @@ enum {
 					 sizeof(struct bss_info_ext_bss))
 
 #define MT7915_BEACON_UPDATE_SIZE	(sizeof(struct sta_req_hdr) +	\
-					 sizeof(struct bss_info_bcn_csa) + \
-					 sizeof(struct bss_info_bcn_bcc) + \
+					 sizeof(struct bss_info_bcn_cntdwn) + \
 					 sizeof(struct bss_info_bcn_mbss) + \
 					 sizeof(struct bss_info_bcn_cont))
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 4ea8972d4e2f..ed74a96960ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -316,6 +316,8 @@ int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
 int mt7915_mcu_add_key(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		       struct mt7915_sta *msta, struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd);
+int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+				struct cfg80211_he_bss_color *he_bss_color);
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  int enable);
 int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-- 
2.31.1

