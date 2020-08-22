Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42424E9E0
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Aug 2020 22:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgHVUyH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Aug 2020 16:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgHVUyE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Aug 2020 16:54:04 -0400
Received: from localhost.localdomain (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 270432072D;
        Sat, 22 Aug 2020 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598129644;
        bh=VBprktu898nd6D+ge31tJXEGNqsOI3UjmbNpOagoPYw=;
        h=From:To:Cc:Subject:Date:From;
        b=F3gWdwYNJTJvaw6khue63VCskxTleb09CIH9mU8XzxGFWu7HV63mngxcmfrTEWVoB
         dCLODE1C9f1DU4t1SeH5rCNYFiC1Dckio8kjMEkrRHu0wUsGKJ98pPokz+9djb8490
         nxmkkL3zHflUrpEpCQx+VQtDcnnnZVrBi/tGcr5Q=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: introduce basic bss coloring support
Date:   Sat, 22 Aug 2020 22:53:25 +0200
Message-Id: <57bfffe1164a24cbe9a4a31d0b4bddbaf3728ef7.1598115999.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mcu APIs to configure bss coloring and to report bss coloring
collisions

Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 26 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 33 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  9 +++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 ++
 4 files changed, 70 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index f3d26968735c..99ae49971612 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -416,6 +416,29 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
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
@@ -464,6 +487,9 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
 		mt7915_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
 
+	if (changed & BSS_CHANGED_HE_BSS_COLOR)
+		mt7915_update_bss_color(hw, vif, &info->he_bss_color);
+
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED))
 		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 655e3bd84b19..7e028395af75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -568,6 +568,11 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 	wiphy_info(mt76_hw(dev)->wiphy, "%s: %s", type, data);
 }
 
+static void
+mt7915_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+}
+
 static void
 mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 {
@@ -588,6 +593,11 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	case MCU_EXT_EVENT_FW_LOG_2_HOST:
 		mt7915_mcu_rx_log_message(dev, skb);
 		break;
+	case MCU_EXT_EVENT_CCA_NOTIFY:
+		ieee80211_iterate_active_interfaces_atomic(dev->mt76.hw,
+				IEEE80211_IFACE_ITER_RESUME_ALL,
+				mt7915_mcu_cca_finish, dev);
+		break;
 	default:
 		break;
 	}
@@ -616,6 +626,7 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
 	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
+	    rxd->ext_eid == MCU_EXT_EVENT_CCA_NOTIFY ||
 	    rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
 	    !rxd->seq)
 		mt7915_mcu_rx_unsolicited_event(dev, skb);
@@ -3359,3 +3370,25 @@ int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SPR,
 				   &req, sizeof(req), true);
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
+	bss_color->disable = he_bss_color->disabled;
+	bss_color->color = he_bss_color->color;
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_EXT_CMD_BSS_INFO_UPDATE, true);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index c656d66385c4..4b103a60bad5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -43,6 +43,7 @@ enum {
 	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
 	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
+	MCU_EXT_EVENT_CCA_NOTIFY = 0x75,
 	MCU_EXT_EVENT_RATE_REPORT = 0x87,
 };
 
@@ -412,6 +413,14 @@ struct bss_info_hw_amsdu {
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1a5f3922e46b..12cb4564d972 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -300,6 +300,8 @@ int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
 int mt7915_mcu_add_key(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		       struct mt7915_sta *msta, struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd);
+int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+				struct cfg80211_he_bss_color *he_bss_color);
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  int enable);
 int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-- 
2.26.2

