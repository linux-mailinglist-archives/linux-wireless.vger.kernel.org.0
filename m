Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B791F776B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFLLqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 07:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgFLLqr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 07:46:47 -0400
Received: from localhost.localdomain.com (unknown [151.48.140.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4342B2065C;
        Fri, 12 Jun 2020 11:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591962406;
        bh=10FWGFws5PvlmZbbfQTbwYS7HthjPSyztFAWGfoS16I=;
        h=From:To:Cc:Subject:Date:From;
        b=eQQfNduKIF4uDsm12XwoWS96X+V8ayOfoSNl09s54NU/XA3TyrWpjA6GfNoFetNPj
         jtiaucDY8Zf+YzYfQ/UpVnBNLowHq67fuaAbivWwWtQ2SGSvEOczD1nQzhCoOrFU4J
         92FNgpi+N4fZGmGDT5wlXajxKyBzCi1SBjLpwsaQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: add U-APSD support on AP side
Date:   Fri, 12 Jun 2020 13:46:31 +0200
Message-Id: <3cc2bb7671f6b6c4947ee1293814ac908db065b6.1591962131.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce U-APSD support in mt76 driver for AP interface

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 46 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 21 +++++++++
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 907098101898..bc7db11c6047 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -279,7 +279,8 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 
 	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
-			WIPHY_FLAG_SUPPORTS_TDLS;
+			WIPHY_FLAG_SUPPORTS_TDLS |
+			WIPHY_FLAG_AP_UAPSD;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
@@ -289,6 +290,7 @@ mt76_phy_init(struct mt76_dev *dev, struct ieee80211_hw *hw)
 	wiphy->available_antennas_rx = dev->phy.antenna_mask;
 
 	hw->txq_data_size = sizeof(struct mt76_txq);
+	hw->uapsd_max_sp_len = IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL;
 
 	if (!hw->max_tx_fragments)
 		hw->max_tx_fragments = 16;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 06b870b0de99..8454fcd25ff4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -953,6 +953,38 @@ mt7615_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	}
 }
 
+static void
+mt7615_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta)
+{
+	struct sta_rec_uapsd *uapsd;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
+		return;
+
+	tlv = mt7615_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
+	uapsd = (struct sta_rec_uapsd *)tlv;
+
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
+		uapsd->dac_map |= BIT(3);
+		uapsd->tac_map |= BIT(3);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
+		uapsd->dac_map |= BIT(2);
+		uapsd->tac_map |= BIT(2);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
+		uapsd->dac_map |= BIT(1);
+		uapsd->tac_map |= BIT(1);
+	}
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
+		uapsd->dac_map |= BIT(0);
+		uapsd->tac_map |= BIT(0);
+	}
+	uapsd->max_sp = sta->max_sp;
+}
+
 static void
 mt7615_mcu_wtbl_ba_tlv(struct sk_buff *skb,
 		       struct ieee80211_ampdu_params *params,
@@ -1215,8 +1247,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(sskb);
 
 	mt7615_mcu_sta_basic_tlv(sskb, vif, sta, enable);
-	if (enable && sta)
+	if (enable && sta) {
 		mt7615_mcu_sta_ht_tlv(sskb, sta);
+		mt7615_mcu_sta_uapsd(sskb, vif, sta);
+	}
 
 	wtbl_hdr = mt7615_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
 					     NULL, &wskb);
@@ -1312,8 +1346,10 @@ mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	mt7615_mcu_sta_basic_tlv(skb, vif, sta, enable);
-	if (enable && sta)
+	if (enable && sta) {
 		mt7615_mcu_sta_ht_tlv(skb, sta);
+		mt7615_mcu_sta_uapsd(skb, vif, sta);
+	}
 
 	sta_wtbl = mt7615_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
@@ -1456,6 +1492,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			u8 pad[3];
 		} __packed hdr;
 		struct mt7615_bss_basic_tlv basic;
+		struct mt7615_bss_qos_tlv qos;
 	} basic_req = {
 		.hdr = {
 			.bss_idx = mvif->idx,
@@ -1471,6 +1508,11 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			.active = true, /* keep bss deactivated */
 			.phymode = 0x38,
 		},
+		.qos = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
+			.len = cpu_to_le16(sizeof(struct mt7615_bss_qos_tlv)),
+			.qos = vif->bss_conf.qos,
+		},
 	};
 	struct {
 		struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 98579bea8bfc..509affb7fc0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -455,6 +455,13 @@ struct mt7615_bss_basic_tlv {
 	u8 pad[3];
 } __packed;
 
+struct mt7615_bss_qos_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 qos;
+	u8 pad[3];
+} __packed;
+
 struct mt7615_wow_ctrl_tlv {
 	__le16 tag;
 	__le16 len;
@@ -596,6 +603,8 @@ enum {
 	UNI_BSS_INFO_BASIC = 0,
 	UNI_BSS_INFO_RLM = 2,
 	UNI_BSS_INFO_BCN_CONTENT = 7,
+	UNI_BSS_INFO_QBSS = 15,
+	UNI_BSS_INFO_UAPSD = 19,
 };
 
 enum {
@@ -909,6 +918,7 @@ struct wtbl_raw {
 					 sizeof(struct sta_rec_basic) +	\
 					 sizeof(struct sta_rec_ht) +	\
 					 sizeof(struct sta_rec_vht) +	\
+					 sizeof(struct sta_rec_uapsd) + \
 					 sizeof(struct tlv) +	\
 					 MT7615_WTBL_UPDATE_MAX_SIZE)
 
@@ -998,6 +1008,17 @@ struct sta_rec_ba {
 	__le16 winsize;
 } __packed;
 
+struct sta_rec_uapsd {
+	__le16 tag;
+	__le16 len;
+	u8 dac_map;
+	u8 tac_map;
+	u8 max_sp;
+	u8 rsv0;
+	__le16 listen_interval;
+	u8 rsv1[2];
+} __packed;
+
 enum {
 	STA_REC_BASIC,
 	STA_REC_RA,
-- 
2.26.2

