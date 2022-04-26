Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCDC50EEAF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 04:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242099AbiDZC0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Apr 2022 22:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241949AbiDZC0t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Apr 2022 22:26:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D1EE0AEF
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 19:23:42 -0700 (PDT)
X-UUID: 8bd02d6712d04ab6b7a46a0169d6364a-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e3ede632-b477-43cf-ae6e-c3b09d9a5ff0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:e3ede632-b477-43cf-ae6e-c3b09d9a5ff0,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:480deef0-da02-41b4-b6df-58f4ccd36682,C
        OID:4e0930bca38b,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 8bd02d6712d04ab6b7a46a0169d6364a-20220426
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 457570605; Tue, 26 Apr 2022 10:23:38 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 26 Apr 2022 10:23:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Apr
 2022 10:23:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 10:23:37 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Subject: [PATCH] mt76: mt7915: add support for 6G in-band discovery
Date:   Tue, 26 Apr 2022 10:23:35 +0800
Message-ID: <20220426022335.8433-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add offloading FILS discovery and unsolicited broadcast probe response support.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 17 +++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  8 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 75 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 15 +++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +-
 6 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 70baad756dd0..d123ecb9fb0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -351,6 +351,8 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
 
 	if (!mdev->dev->of_node ||
 	    !of_property_read_bool(mdev->dev->of_node,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e353e8c44d6c..de7bf137c234 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1177,7 +1177,7 @@ mt7915_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
-			   struct ieee80211_key_conf *key, bool beacon)
+			   struct ieee80211_key_conf *key, u32 changed)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
@@ -1188,6 +1188,10 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	bool mcast = false;
 	u16 tx_count = 15;
 	u32 val;
+	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
+				    BSS_CHANGED_BEACON_ENABLED));
+	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
+					 BSS_CHANGED_FILS_DISCOVERY));
 
 	if (vif) {
 		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
@@ -1200,7 +1204,10 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	if (ext_phy && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
-	if (beacon) {
+	if (inband_disc) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_ALTX0;
+	} else if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = MT_LMAC_BCN0;
 	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
@@ -1308,8 +1315,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-	mt7915_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid, key,
-			      false);
+	mt7915_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid, key, 0);
 
 	txp = (struct mt7915_txp *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
@@ -1919,7 +1925,8 @@ mt7915_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_AP:
-		mt7915_mcu_add_beacon(hw, vif, vif->bss_conf.enable_beacon);
+		mt7915_mcu_add_beacon(hw, vif, vif->bss_conf.enable_beacon,
+				      BSS_CHANGED_BEACON_ENABLED);
 		break;
 	default:
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 5177b19f9154..c2c615931782 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -622,8 +622,10 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		mt7915_update_bss_color(hw, vif, &info->he_bss_color);
 
 	if (changed & (BSS_CHANGED_BEACON |
-		       BSS_CHANGED_BEACON_ENABLED))
-		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon);
+		       BSS_CHANGED_BEACON_ENABLED |
+		       BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
+		       BSS_CHANGED_FILS_DISCOVERY))
+		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon, changed);
 
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -636,7 +638,7 @@ mt7915_channel_switch_beacon(struct ieee80211_hw *hw,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7915_mcu_add_beacon(hw, vif, true);
+	mt7915_mcu_add_beacon(hw, vif, true, BSS_CHANGED_BEACON);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2a07a5d2a439..87e44c69d72b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1892,6 +1892,7 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	u8 *buf;
 	int len = sizeof(*cont) + MT_TXD_SIZE + skb->len;
 
+	len = (len & 0x3) ? ((len | 0x3) + 1) : len;
 	tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_CONTENT,
 					   len, &bcn->sub_ntlv, &bcn->len);
 
@@ -1910,7 +1911,7 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	buf = (u8 *)tlv + sizeof(*cont);
 	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
-			      true);
+			      BSS_CHANGED_BEACON);
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
 
@@ -1992,8 +1993,71 @@ mt7915_mcu_beacon_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 	}
 }
 
-int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
-			  struct ieee80211_vif *vif, int en)
+static void
+mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+				struct sk_buff *rskb, struct bss_info_bcn *bcn,
+				u32 changed)
+{
+#define OFFLOAD_TX_MODE_SU	BIT(0)
+#define OFFLOAD_TX_MODE_MU	BIT(1)
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct bss_info_inband_discovery *discov;
+	struct ieee80211_tx_info *info;
+	struct sk_buff *skb = NULL;
+	struct tlv *tlv;
+	bool ext_phy = phy != &dev->phy;
+	u8 *buf, interval;
+	int len;
+
+	if (changed & BSS_CHANGED_FILS_DISCOVERY &&
+	    vif->bss_conf.fils_discovery.max_interval) {
+		interval = vif->bss_conf.fils_discovery.max_interval;
+		skb = ieee80211_get_fils_discovery_tmpl(hw, vif);
+	} else if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP &&
+		   vif->bss_conf.unsol_bcast_probe_resp_interval) {
+		interval = vif->bss_conf.unsol_bcast_probe_resp_interval;
+		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
+	}
+
+	if (!skb)
+		return;
+
+	info = IEEE80211_SKB_CB(skb);
+	info->control.vif = vif;
+	info->band = band;
+
+	if (ext_phy)
+		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
+
+	len = sizeof(*discov) + MT_TXD_SIZE + skb->len;
+	len = (len & 0x3) ? ((len | 0x3) + 1) : len;
+
+	tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_DISCOV,
+					   len, &bcn->sub_ntlv, &bcn->len);
+	discov = (struct bss_info_inband_discovery *)tlv;
+	discov->tx_mode = OFFLOAD_TX_MODE_SU;
+	/* 0: UNSOL PROBE RESP, 1: FILS DISCOV */
+	discov->tx_type = !!(changed & BSS_CHANGED_FILS_DISCOVERY);
+	discov->tx_interval = interval;
+	discov->prob_rsp_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
+	discov->enable = true;
+
+	buf = (u8 *)tlv + sizeof(*discov);
+
+	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
+			      changed);
+	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
+
+	dev_kfree_skb(skb);
+}
+
+int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  int en, u32 changed)
 {
 #define MAX_BEACON_SIZE 512
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
@@ -2044,6 +2108,11 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	mt7915_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
 	dev_kfree_skb(skb);
 
+	if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP ||
+	    changed & BSS_CHANGED_FILS_DISCOVERY)
+		mt7915_mcu_beacon_inband_discov(dev, vif, rskb,
+						bcn, changed);
+
 out:
 	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
 				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 064d33e33738..e1d576701fdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -404,11 +404,23 @@ struct bss_info_bcn_cont {
 	__le16 pkt_len;
 } __packed __aligned(4);
 
+struct bss_info_inband_discovery {
+	__le16 tag;
+	__le16 len;
+	u8 tx_type;
+	u8 tx_mode;
+	u8 tx_interval;
+	u8 enable;
+	__le16 rsv;
+	__le16 prob_rsp_len;
+} __packed __aligned(4);
+
 enum {
 	BSS_INFO_BCN_CSA,
 	BSS_INFO_BCN_BCC,
 	BSS_INFO_BCN_MBSSID,
 	BSS_INFO_BCN_CONTENT,
+	BSS_INFO_BCN_DISCOV,
 	BSS_INFO_BCN_MAX
 };
 
@@ -476,6 +488,7 @@ enum {
 #define MT7915_BEACON_UPDATE_SIZE	(sizeof(struct sta_req_hdr) +	\
 					 sizeof(struct bss_info_bcn_cntdwn) + \
 					 sizeof(struct bss_info_bcn_mbss) + \
-					 sizeof(struct bss_info_bcn_cont))
+					 sizeof(struct bss_info_bcn_cont) + \
+					 sizeof(struct bss_info_inband_discovery))
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 6c590eff14f1..03431012b2ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -464,7 +464,7 @@ int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
 int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				struct cfg80211_he_bss_color *he_bss_color);
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			  int enable);
+			  int enable, u32 changed);
 int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
                             bool enable);
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
@@ -551,7 +551,7 @@ void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy);
 void mt7915_mac_enable_nf(struct mt7915_dev *dev, bool ext_phy);
 void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
-			   struct ieee80211_key_conf *key, bool beacon);
+			   struct ieee80211_key_conf *key, u32 changed);
 void mt7915_mac_set_timing(struct mt7915_phy *phy);
 int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
-- 
2.18.0

