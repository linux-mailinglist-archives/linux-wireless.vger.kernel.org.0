Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2043BA3BA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhGBRq5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 13:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhGBRq5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 13:46:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7125B600CC;
        Fri,  2 Jul 2021 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625247864;
        bh=8zmV0AZ1Wqrggw0ik3oUZEZWhVoEMTjxRAat0Za0zdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYytwxQh+yZxKK47NbqbNEArxaQ/7UoEWGzqG8i6JXWibj42CfJegEbOnNI9vNn2r
         wuGiw/R49WbCwtVihvR4DSbrCl2qsWXoql775/zYWTNpHGd5XxfOzIUR4/0H9LLFJE
         f5pZd5xjto6HegoQod07OiwbKEpw3dpAkdt9gaxaa9/dfQJBkWzPGg7i4/MtP6UTst
         mB+o0/U5Z81jDGqrKyiv0pMKsmp/9x9eWyUVLrHYtJMLlBQurLs0XQXq2YPyl2abyV
         DBdu02TiB8q6FEhwlRq2DdZ0T0liwqn2Sqm/GYadDA1M+ctdKcTQon4Jerjl7wYIAe
         i+wseo4JwLCyQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     john@phrozen.org, nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        dan.carpenter@oracle.com
Subject: [PATCH v9 mac80211-next 3/3] mt76: mt7915: introduce bss coloring support
Date:   Fri,  2 Jul 2021 19:44:09 +0200
Message-Id: <874619754271a7ec86fc63e0a12e8160a5f33e00.1625247619.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625247619.git.lorenzo@kernel.org>
References: <cover.1625247619.git.lorenzo@kernel.org>
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
index 4798d6344305..f93ed3965662 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -232,6 +232,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->reg_notifier = mt7915_regd_notifier;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index c25f8da590dd..d67d0e1c0953 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -538,6 +538,29 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
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
@@ -586,6 +609,9 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
 		mt7915_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
 
+	if (changed & BSS_CHANGED_HE_BSS_COLOR)
+		mt7915_update_bss_color(hw, vif, &info->he_bss_color);
+
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED))
 		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 863aa18b3024..c142202d39c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -657,6 +657,15 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
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
@@ -678,6 +687,11 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
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
@@ -706,6 +720,7 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
 	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
+	    rxd->ext_eid == MCU_EXT_EVENT_BCC_NOTIFY ||
 	    rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
 	    !rxd->seq)
 		mt7915_mcu_rx_unsolicited_event(dev, skb);
@@ -2534,25 +2549,28 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
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
@@ -2568,8 +2586,14 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct sk_buff *rskb,
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
 	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
@@ -2617,9 +2641,9 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
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
@@ -4069,3 +4093,25 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 
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
index edd3ba3a0c2d..431851ff3f8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -43,6 +43,7 @@ enum {
 	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
 	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
+	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
 	MCU_EXT_EVENT_RATE_REPORT = 0x87,
 };
 
@@ -545,6 +546,14 @@ struct bss_info_hw_amsdu {
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
@@ -563,14 +572,7 @@ struct bss_info_bcn {
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
@@ -1156,8 +1158,7 @@ enum {
 					 sizeof(struct bss_info_ext_bss))
 
 #define MT7915_BEACON_UPDATE_SIZE	(sizeof(struct sta_req_hdr) +	\
-					 sizeof(struct bss_info_bcn_csa) + \
-					 sizeof(struct bss_info_bcn_bcc) + \
+					 sizeof(struct bss_info_bcn_cntdwn) + \
 					 sizeof(struct bss_info_bcn_mbss) + \
 					 sizeof(struct bss_info_bcn_cont))
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3f613fae6218..e2b8c1a45b99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -327,6 +327,8 @@ int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
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

