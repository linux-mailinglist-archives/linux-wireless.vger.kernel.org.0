Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A567A289F36
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Oct 2020 10:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgJJIPO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Oct 2020 04:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729807AbgJJIMb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Oct 2020 04:12:31 -0400
Received: from localhost.localdomain (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48BD6207C4;
        Sat, 10 Oct 2020 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602317040;
        bh=qstRlnMhFpppqBbJembTBTYmRUc7bRZGmYp193dRDGg=;
        h=From:To:Cc:Subject:Date:From;
        b=Lu8yKCKuIFiptvOaFvY+UHJox/DgYR0XPnDttDZq6uIw8HhwQHek3s3AaqckjzdW0
         re3uKKFBSqz3adY/iDP9TSF2klzyr09Nz1WFFVmbaL6ZUtTVtKrckMjqakF3mjOQl0
         MVzJ2J+n+LF+/739vJFpqG4erSdNKYEgQK/BGDaI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, john@phrozen.org
Subject: [PATCH] mt76: mt7915: introduce 802.11ax multi-bss support
Date:   Sat, 10 Oct 2020 10:03:53 +0200
Message-Id: <8f612baf1b04165446a9f9f73c85e011f618d4fa.1602316667.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mbss mcu APIs to enable 802.11ax multi-bss AP support for
mt7915 devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on "mt76: mt7915: introduce bss coloring support"
https://patchwork.kernel.org/patch/11782149/
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 81 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 11 ++-
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 140222c083dd..21cdb5c8fcd5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -265,6 +265,8 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID_AP);
 
 	hw->max_tx_fragments = 4;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6cedee285e25..4b9dddba7228 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -755,11 +755,22 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 
 	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
+	bss = (struct bss_info_basic *)tlv;
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
 		break;
+	case NL80211_IFTYPE_AP: {
+		/* mbss */
+		int max_bss_id = fls(vif->bss_conf.multiple_bssid.count);
+
+		if (max_bss_id > 8)
+			return -EINVAL;
+
+		bss->non_tx_bssid = vif->bss_conf.multiple_bssid.index;
+		bss->max_bssid = max_bss_id;
+		break;
+	}
 	case NL80211_IFTYPE_STATION:
 		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
 		if (enable) {
@@ -786,7 +797,6 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		break;
 	}
 
-	bss = (struct bss_info_basic *)tlv;
 	memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
 	bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 	bss->network_type = cpu_to_le32(type);
@@ -1075,6 +1085,29 @@ mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 				   &req, sizeof(req), true);
 }
 
+static int
+mt7915_mcu_mbss_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+{
+	struct bss_info_mbss *mbss;
+	struct tlv *tlv;
+	int max_bss_id;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	max_bss_id = fls(vif->bss_conf.multiple_bssid.count);
+	if (max_bss_id > 8)
+		return -EINVAL;
+
+	tlv = mt7915_mcu_add_tlv(skb, BSS_INFO_11V_MBSSID, sizeof(*mbss));
+	mbss = (struct bss_info_mbss *)tlv;
+
+	mbss->bssid_index = vif->bss_conf.multiple_bssid.index;
+	mbss->max_bssid = max_bss_id;
+
+	return 0;
+}
+
 int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, int enable)
 {
@@ -1100,6 +1133,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 		mt7915_mcu_bss_bmc_tlv(skb, phy);
 		mt7915_mcu_bss_ra_tlv(skb, vif, phy);
 		mt7915_mcu_bss_hw_amsdu_tlv(skb);
+		mt7915_mcu_mbss_tlv(skb, vif);
 
 		if (vif->bss_conf.he_support)
 			mt7915_mcu_bss_he_tlv(skb, vif, phy);
@@ -2497,6 +2531,43 @@ mt7915_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
 	info->cnt = skb->data[offs->cntdwn_counter_offs[0]];
 }
 
+static void
+mt7915_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
+		       struct ieee80211_vif *vif, struct bss_info_bcn *bcn,
+		       struct ieee80211_mutable_offsets *offs)
+{
+	struct bss_info_bcn_mbss *mbss;
+	const struct element *elem;
+	struct tlv *tlv;
+	int i = 1;
+
+	if (!vif->bss_conf.multiple_bssid.count)
+		return;
+
+	tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_MBSSID,
+					   sizeof(*mbss), &bcn->sub_ntlv,
+					   &bcn->len);
+	mbss = (struct bss_info_bcn_mbss *)tlv;
+	mbss->offset[0] = cpu_to_le16(offs->tim_offset);
+	mbss->bitmap = cpu_to_le32(1);
+
+	for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
+			    &skb->data[offs->multiple_bssid_offset],
+			    offs->multiple_bssid_offset) {
+		const struct element *sub_elem;
+
+		for_each_element(sub_elem, elem->data + 1, elem->datalen - 1) {
+			if (sub_elem->id)
+				continue;
+
+			mbss->offset[i] =
+				cpu_to_le16((u8 *)sub_elem - skb->data);
+			mbss->bitmap |= cpu_to_le32(1 << i);
+			i++;
+		}
+	}
+}
+
 static void
 mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		       struct sk_buff *rskb, struct sk_buff *skb,
@@ -2545,6 +2616,10 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	struct bss_info_bcn *bcn;
 	int len = MT7915_BEACON_UPDATE_SIZE + MAX_BEACON_SIZE;
 
+	if (vif->bss_conf.multiple_bssid.count &&
+	    vif->bss_conf.multiple_bssid.parent)
+		return 0;
+
 	skb = ieee80211_beacon_get_template(hw, vif, &offs);
 	if (!skb)
 		return -EINVAL;
@@ -2570,8 +2645,8 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 	}
 
-	/* TODO: subtag - 11v MBSSID */
 	mt7915_mcu_beacon_cntdwn(vif, rskb, skb, bcn, &offs);
+	mt7915_mcu_beacon_mbss(rskb, skb, vif, bcn, &offs);
 	mt7915_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
 	dev_kfree_skb(skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index e4cfbd26e565..da0d1fb769f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -367,6 +367,14 @@ struct bss_info_sync_mode {
 	u8 rsv[8];
 } __packed;
 
+struct bss_info_mbss {
+	__le16 tag;
+	__le16 len;
+	u8 max_bssid;
+	u8 bssid_index;
+	u8 rsv[2];
+} __packed;
+
 struct bss_info_bmc_rate {
 	__le16 tag;
 	__le16 len;
@@ -1013,7 +1021,8 @@ enum {
 					 sizeof(struct bss_info_he) +	\
 					 sizeof(struct bss_info_bmc_rate) +\
 					 sizeof(struct bss_info_ext_bss) +\
-					 sizeof(struct bss_info_sync_mode))
+					 sizeof(struct bss_info_sync_mode) + \
+					 sizeof(struct bss_info_mbss))
 
 #define MT7915_BEACON_UPDATE_SIZE	(sizeof(struct sta_req_hdr) +	\
 					 sizeof(struct bss_info_bcn_cntdwn) + \
-- 
2.26.2

