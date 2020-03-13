Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2081835C1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgCLQDG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 12:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgCLQDG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 12:03:06 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983F5206F1;
        Thu, 12 Mar 2020 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584028985;
        bh=P6wyT4s59TD3nglnPScx8iUJeqosmUleKKMlX1Gt8C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/tgQtVUcSubKD1jgRqbXhgZOQ6bMI7KgJK+z/bklKF//e2WMbuQzrRygAhwJmjFD
         QcQsL5WaIXoEJtbRuAsIJ0HrDeejiaV1iMkHC9QY1fKSj9ZEJ9Cg0qI+MAYS4vbumy
         65zjT10xw1j4jkaNtaGj6da0mFP/LP3COmA2QiBU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3 11/25] mt76: mt7615: rework mt7615_mcu_set_bss_info using skb APIs
Date:   Thu, 12 Mar 2020 17:02:21 +0100
Message-Id: <2e227014bcdfe7618dfb2b4a9a4bf9a3fce15c8d.1584028319.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584028319.git.lorenzo@kernel.org>
References: <cover.1584028319.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplify mt7615_mcu_set_bss_info relying on mcu tlv helpers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 274 ++++++++----------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +-
 2 files changed, 125 insertions(+), 151 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 73ec31b20d21..e5df46d7648a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -317,8 +317,8 @@ mt7615_mcu_alloc_sta_req(struct mt7615_vif *mvif, struct mt7615_sta *msta)
 {
 	struct sta_req_hdr hdr = {
 		.bss_idx = mvif->idx,
-		.wlan_idx = msta->wcid.idx,
-		.muar_idx = mvif->omac_idx,
+		.wlan_idx = msta ? msta->wcid.idx : 0,
+		.muar_idx = msta ? mvif->omac_idx : 0,
 		.is_tlv_append = 1,
 	};
 	struct sk_buff *skb;
@@ -390,6 +390,115 @@ mt7615_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
 	return mt7615_mcu_add_nested_tlv(skb, tag, len, skb->data, NULL);
 }
 
+static int
+mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			 bool enable)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct bss_info_basic *bss;
+	u8 wlan_idx = mvif->sta.wcid.idx;
+	u32 type = NETWORK_INFRA;
+	struct tlv *tlv;
+
+	tlv = mt7615_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		break;
+	case NL80211_IFTYPE_STATION:
+		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
+		if (enable) {
+			struct ieee80211_sta *sta;
+			struct mt7615_sta *msta;
+
+			rcu_read_lock();
+			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
+			if (!sta) {
+				rcu_read_unlock();
+				return -EINVAL;
+			}
+
+			msta = (struct mt7615_sta *)sta->drv_priv;
+			wlan_idx = msta->wcid.idx;
+			rcu_read_unlock();
+		}
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		type = NETWORK_IBSS;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	bss = (struct bss_info_basic *)tlv;
+	memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
+	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
+	bss->network_type = cpu_to_le32(type);
+	bss->dtim_period = vif->bss_conf.dtim_period;
+	bss->bmc_tx_wlan_idx = wlan_idx;
+	bss->wmm_idx = mvif->wmm_idx;
+	bss->active = enable;
+
+	return 0;
+}
+
+static void
+mt7615_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+{
+	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	struct bss_info_omac *omac;
+	struct tlv *tlv;
+	u32 type = 0;
+	u8 idx;
+
+	tlv = mt7615_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		type = CONNECTION_INFRA_AP;
+		break;
+	case NL80211_IFTYPE_STATION:
+		type = CONNECTION_INFRA_STA;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		type = CONNECTION_IBSS_ADHOC;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	omac = (struct bss_info_omac *)tlv;
+	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	omac->conn_type = cpu_to_le32(type);
+	omac->omac_idx = mvif->omac_idx;
+	omac->band_idx = mvif->band_idx;
+	omac->hw_bss_idx = idx;
+}
+
+/* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
+#define BCN_TX_ESTIMATE_TIME (4096 + 20)
+static void
+mt7615_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt7615_vif *mvif)
+{
+	struct bss_info_ext_bss *ext;
+	int ext_bss_idx, tsf_offset;
+	struct tlv *tlv;
+
+	ext_bss_idx = mvif->omac_idx - EXT_BSSID_START;
+	if (ext_bss_idx < 0)
+		return;
+
+	tlv = mt7615_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
+
+	ext = (struct bss_info_ext_bss *)tlv;
+	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
+	ext->mbss_tsf_offset = cpu_to_le32(tsf_offset);
+}
+
 static void
 mt7615_mcu_sta_ba_tlv(struct sk_buff *skb,
 		      struct ieee80211_ampdu_params *params,
@@ -1484,161 +1593,26 @@ int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 				   &data, sizeof(data), true);
 }
 
-static void
-mt7615_mcu_bss_info_omac_header(struct mt7615_vif *mvif, u8 *data,
-				u32 conn_type)
-{
-	struct bss_info_omac *hdr = (struct bss_info_omac *)data;
-	u8 idx;
-
-	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
-	hdr->tag = cpu_to_le16(BSS_INFO_OMAC);
-	hdr->len = cpu_to_le16(sizeof(struct bss_info_omac));
-	hdr->hw_bss_idx = idx;
-	hdr->omac_idx = mvif->omac_idx;
-	hdr->band_idx = mvif->band_idx;
-	hdr->conn_type = cpu_to_le32(conn_type);
-}
-
-static void
-mt7615_mcu_bss_info_basic_header(struct ieee80211_vif *vif, u8 *data,
-				 u32 net_type, u8 tx_wlan_idx,
-				 bool enable)
+int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
+			    bool enable)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct bss_info_basic *hdr = (struct bss_info_basic *)data;
-
-	hdr->tag = cpu_to_le16(BSS_INFO_BASIC);
-	hdr->len = cpu_to_le16(sizeof(struct bss_info_basic));
-	hdr->network_type = cpu_to_le32(net_type);
-	hdr->active = enable;
-	hdr->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
-	memcpy(hdr->bssid, vif->bss_conf.bssid, ETH_ALEN);
-	hdr->wmm_idx = mvif->wmm_idx;
-	hdr->dtim_period = vif->bss_conf.dtim_period;
-	hdr->bmc_tx_wlan_idx = tx_wlan_idx;
-}
-
-static void
-mt7615_mcu_bss_info_ext_header(struct mt7615_vif *mvif, u8 *data)
-{
-/* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
-#define BCN_TX_ESTIMATE_TIME (4096 + 20)
-	struct bss_info_ext_bss *hdr = (struct bss_info_ext_bss *)data;
-	int ext_bss_idx, tsf_offset;
-
-	ext_bss_idx = mvif->omac_idx - EXT_BSSID_START;
-	if (ext_bss_idx < 0)
-		return;
-
-	hdr->tag = cpu_to_le16(BSS_INFO_EXT_BSS);
-	hdr->len = cpu_to_le16(sizeof(struct bss_info_ext_bss));
-	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
-	hdr->mbss_tsf_offset = cpu_to_le32(tsf_offset);
-}
-
-int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
-			    struct ieee80211_vif *vif, int en)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	struct req_hdr {
-		u8 bss_idx;
-		u8 rsv0;
-		__le16 tlv_num;
-		u8 is_tlv_append;
-		u8 rsv1[3];
-	} __packed;
-	int len = sizeof(struct req_hdr) + sizeof(struct bss_info_basic);
-	int ret, i, features = BIT(BSS_INFO_BASIC), ntlv = 1;
-	u32 conn_type = 0, net_type = NETWORK_INFRA;
-	u8 *buf, *data, tx_wlan_idx = 0;
-	struct req_hdr *hdr;
-
-	if (en) {
-		len += sizeof(struct bss_info_omac);
-		features |= BIT(BSS_INFO_OMAC);
-		if (mvif->omac_idx > EXT_BSSID_START) {
-			len += sizeof(struct bss_info_ext_bss);
-			features |= BIT(BSS_INFO_EXT_BSS);
-			ntlv++;
-		}
-		ntlv++;
-	}
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_MESH_POINT:
-		tx_wlan_idx = mvif->sta.wcid.idx;
-		conn_type = CONNECTION_INFRA_AP;
-		break;
-	case NL80211_IFTYPE_STATION: {
-		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
-		if (en) {
-			struct ieee80211_sta *sta;
-			struct mt7615_sta *msta;
-
-			rcu_read_lock();
-			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
-			if (!sta) {
-				rcu_read_unlock();
-				return -EINVAL;
-			}
-
-			msta = (struct mt7615_sta *)sta->drv_priv;
-			tx_wlan_idx = msta->wcid.idx;
-			rcu_read_unlock();
-		}
-		conn_type = CONNECTION_INFRA_STA;
-		break;
-	}
-	case NL80211_IFTYPE_ADHOC:
-		conn_type = CONNECTION_IBSS_ADHOC;
-		tx_wlan_idx = mvif->sta.wcid.idx;
-		net_type = NETWORK_IBSS;
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	buf = kzalloc(len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	struct sk_buff *skb;
 
-	hdr = (struct req_hdr *)buf;
-	hdr->bss_idx = mvif->idx;
-	hdr->tlv_num = cpu_to_le16(ntlv);
-	hdr->is_tlv_append = 1;
+	skb = mt7615_mcu_alloc_sta_req(mvif, NULL);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 
-	data = buf + sizeof(*hdr);
-	for (i = 0; i < BSS_INFO_MAX_NUM; i++) {
-		int tag = ffs(features & BIT(i)) - 1;
+	if (enable)
+		mt7615_mcu_bss_omac_tlv(skb, vif);
 
-		switch (tag) {
-		case BSS_INFO_OMAC:
-			mt7615_mcu_bss_info_omac_header(mvif, data,
-							conn_type);
-			data += sizeof(struct bss_info_omac);
-			break;
-		case BSS_INFO_BASIC:
-			mt7615_mcu_bss_info_basic_header(vif, data, net_type,
-							 tx_wlan_idx, en);
-			data += sizeof(struct bss_info_basic);
-			break;
-		case BSS_INFO_EXT_BSS:
-			mt7615_mcu_bss_info_ext_header(mvif, data);
-			data += sizeof(struct bss_info_ext_bss);
-			break;
-		default:
-			break;
-		}
-	}
+	mt7615_mcu_bss_basic_tlv(skb, vif, enable);
 
-	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BSS_INFO_UPDATE,
-				  buf, len, true);
-	kfree(buf);
+	if (enable && mvif->omac_idx > EXT_BSSID_START)
+		mt7615_mcu_bss_ext_tlv(skb, mvif);
 
-	return ret;
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				       MCU_EXT_CMD_BSS_INFO_UPDATE, true);
 }
 
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index ea98c652711f..66fb77e9c311 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -304,7 +304,7 @@ bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev);
 int mt7615_mcu_set_dev_info(struct mt7615_dev *dev,
 			    struct ieee80211_vif *vif, bool enable);
 int mt7615_mcu_set_bss_info(struct mt7615_dev *dev, struct ieee80211_vif *vif,
-			    int en);
+			    bool enable);
 void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates);
-- 
2.24.1

