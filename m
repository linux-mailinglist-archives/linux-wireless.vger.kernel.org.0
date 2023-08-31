Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888B078E6A9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 08:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbjHaGiU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 02:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241979AbjHaGiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 02:38:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657BAA4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 23:38:13 -0700 (PDT)
X-UUID: d244ad6047c611eeb20a276fd37b9834-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BP6UPpZCEa0/OiJ4HUTk7gPcHcFJ1tAnpx2pQZggyRc=;
        b=mzLVRkolkGcH++0dld7158AQr1685W3Pyt4NlA3kgoRXwylaXh665wkJRa5kqDjcHIowVk2IVs6IZnzRbr8jZh6ozboPQc6qSaQmgZiPW7RTlqcC3NOKBZjQrHj91hv6bzBxFxm2X1GI5DVkwc/8nQm8OrO5WHP5fL2v8ioBmYg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:6a2d5a95-e0ec-4391-8afb-47a5241c5227,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:fde1f31f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d244ad6047c611eeb20a276fd37b9834-20230831
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 997805599; Thu, 31 Aug 2023 14:22:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 14:22:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Aug 2023 14:22:53 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/9] wifi: mt76: update beacon size limitation
Date:   Thu, 31 Aug 2023 14:22:14 +0800
Message-ID: <20230831062221.20027-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230831062221.20027-1-shayne.chen@mediatek.com>
References: <20230831062221.20027-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: MeiChia Chiu <meichia.chiu@mediatek.com>

To accommodate 11v MBSSID IE and support maximum 16 MBSSIDs, expand the
beacon size limitation for beacon and inband discovery commands.

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  8 +--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 49 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 18 +++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 38 ++++++++------
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 11 ++---
 7 files changed, 72 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 8ebbf186fab2..d06c25dda325 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -646,11 +646,13 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		mt7915_update_bss_color(hw, vif, &info->he_bss_color);
 
 	if (changed & (BSS_CHANGED_BEACON |
-		       BSS_CHANGED_BEACON_ENABLED |
-		       BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
-		       BSS_CHANGED_FILS_DISCOVERY))
+		       BSS_CHANGED_BEACON_ENABLED))
 		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon, changed);
 
+	if (changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
+		       BSS_CHANGED_FILS_DISCOVERY))
+		mt7915_mcu_add_inband_discov(dev, vif, changed);
+
 	if (set_bss_info == 0)
 		mt7915_mcu_add_bss_info(phy, vif, false);
 	if (set_sta == 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 50ae7bf3af91..5cf45c5ce5e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1882,10 +1882,9 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
 
-static void
-mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-				struct sk_buff *rskb, struct bss_info_bcn *bcn,
-				u32 changed)
+int
+mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+			     u32 changed)
 {
 #define OFFLOAD_TX_MODE_SU	BIT(0)
 #define OFFLOAD_TX_MODE_MU	BIT(1)
@@ -1895,14 +1894,27 @@ mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vi
 	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	struct bss_info_bcn *bcn;
 	struct bss_info_inband_discovery *discov;
 	struct ieee80211_tx_info *info;
-	struct sk_buff *skb = NULL;
-	struct tlv *tlv;
+	struct sk_buff *rskb, *skb = NULL;
+	struct tlv *tlv, *sub_tlv;
 	bool ext_phy = phy != &dev->phy;
 	u8 *buf, interval;
 	int len;
 
+	if (vif->bss_conf.nontransmitted)
+		return 0;
+
+	rskb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76, NULL,
+					       MT7915_MAX_BSS_OFFLOAD_SIZE);
+	if (IS_ERR(rskb))
+		return PTR_ERR(rskb);
+
+	tlv = mt76_connac_mcu_add_tlv(rskb, BSS_INFO_OFFLOAD, sizeof(*bcn));
+	bcn = (struct bss_info_bcn *)tlv;
+	bcn->enable = true;
+
 	if (changed & BSS_CHANGED_FILS_DISCOVERY &&
 	    vif->bss_conf.fils_discovery.max_interval) {
 		interval = vif->bss_conf.fils_discovery.max_interval;
@@ -1914,26 +1926,25 @@ mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vi
 	}
 
 	if (!skb)
-		return;
+		return -EINVAL;
 
 	info = IEEE80211_SKB_CB(skb);
 	info->control.vif = vif;
 	info->band = band;
-
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, ext_phy);
 
 	len = sizeof(*discov) + MT_TXD_SIZE + skb->len;
 	len = (len & 0x3) ? ((len | 0x3) + 1) : len;
 
-	if (len > (MT7915_MAX_BSS_OFFLOAD_SIZE - rskb->len)) {
+	if (skb->len > MT7915_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "inband discovery size limit exceed\n");
 		dev_kfree_skb(skb);
-		return;
+		return -EINVAL;
 	}
 
-	tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_DISCOV,
-					   len, &bcn->sub_ntlv, &bcn->len);
-	discov = (struct bss_info_inband_discovery *)tlv;
+	sub_tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_DISCOV,
+					       len, &bcn->sub_ntlv, &bcn->len);
+	discov = (struct bss_info_inband_discovery *)sub_tlv;
 	discov->tx_mode = OFFLOAD_TX_MODE_SU;
 	/* 0: UNSOL PROBE RESP, 1: FILS DISCOV */
 	discov->tx_type = !!(changed & BSS_CHANGED_FILS_DISCOVERY);
@@ -1941,13 +1952,16 @@ mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vi
 	discov->prob_rsp_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	discov->enable = true;
 
-	buf = (u8 *)tlv + sizeof(*discov);
+	buf = (u8 *)sub_tlv + sizeof(*discov);
 
 	mt7915_mac_write_txwi(&dev->mt76, (__le32 *)buf, skb, wcid, 0, NULL,
 			      0, changed);
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 
 	dev_kfree_skb(skb);
+
+	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
+				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
 
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -1983,7 +1997,7 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (!skb)
 		return -EINVAL;
 
-	if (skb->len > MT7915_MAX_BEACON_SIZE - MT_TXD_SIZE) {
+	if (skb->len > MT7915_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
 		dev_kfree_skb(skb);
 		return -EINVAL;
@@ -1997,11 +2011,6 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt7915_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
 	dev_kfree_skb(skb);
 
-	if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP ||
-	    changed & BSS_CHANGED_FILS_DISCOVERY)
-		mt7915_mcu_beacon_inband_discov(dev, vif, rskb,
-						bcn, changed);
-
 out:
 	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
 				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index b9ea297f382c..1592b5d6751a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -495,10 +495,14 @@ enum {
 	SER_RECOVER
 };
 
-#define MT7915_MAX_BEACON_SIZE		512
-#define MT7915_MAX_INBAND_FRAME_SIZE	256
-#define MT7915_MAX_BSS_OFFLOAD_SIZE	(MT7915_MAX_BEACON_SIZE +	  \
-					 MT7915_MAX_INBAND_FRAME_SIZE +	  \
+#define MT7915_MAX_BEACON_SIZE		1308
+#define MT7915_BEACON_UPDATE_SIZE	(sizeof(struct sta_req_hdr) +	\
+					 sizeof(struct bss_info_bcn) +	\
+					 sizeof(struct bss_info_bcn_cntdwn) +	\
+					 sizeof(struct bss_info_bcn_mbss) +	\
+					 MT_TXD_SIZE +	\
+					 sizeof(struct bss_info_bcn_cont))
+#define MT7915_MAX_BSS_OFFLOAD_SIZE	(MT7915_MAX_BEACON_SIZE +	\
 					 MT7915_BEACON_UPDATE_SIZE)
 
 #define MT7915_BSS_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +	\
@@ -511,12 +515,6 @@ enum {
 					 sizeof(struct bss_info_bmc_rate) +\
 					 sizeof(struct bss_info_ext_bss))
 
-#define MT7915_BEACON_UPDATE_SIZE	(sizeof(struct sta_req_hdr) +	\
-					 sizeof(struct bss_info_bcn_cntdwn) + \
-					 sizeof(struct bss_info_bcn_mbss) + \
-					 sizeof(struct bss_info_bcn_cont) + \
-					 sizeof(struct bss_info_inband_discovery))
-
 static inline s8
 mt7915_get_power_bound(struct mt7915_phy *phy, s8 txpower)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0456e56f6348..21984e972370 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -447,6 +447,8 @@ int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
 			 bool add);
 int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				struct cfg80211_he_bss_color *he_bss_color);
+int mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+				 u32 changed);
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  int enable, u32 changed);
 int mt7915_mcu_add_obss_spr(struct mt7915_phy *phy, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 6068e009c408..72576430be6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -615,8 +615,8 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 		mt7996_mcu_add_beacon(hw, vif, info->enable_beacon);
 	}
 
-	if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP ||
-	    changed & BSS_CHANGED_FILS_DISCOVERY)
+	if (changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
+		       BSS_CHANGED_FILS_DISCOVERY))
 		mt7996_mcu_beacon_inband_discov(dev, vif, changed);
 
 	if (changed & BSS_CHANGED_MU_GROUPS)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 29e287373717..6740c1111af4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2221,7 +2221,7 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			bcn->bcc_ie_pos = cpu_to_le16(offset - 3);
 	}
 
-	buf = (u8 *)bcn + sizeof(*bcn) - MAX_BEACON_SIZE;
+	buf = (u8 *)bcn + sizeof(*bcn);
 	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0,
 			      BSS_CHANGED_BEACON);
 
@@ -2239,28 +2239,21 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	struct sk_buff *skb, *rskb;
 	struct tlv *tlv;
 	struct bss_bcn_content_tlv *bcn;
+	int len;
 
 	if (vif->bss_conf.nontransmitted)
 		return 0;
 
 	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
-					  MT7996_BEACON_UPDATE_SIZE);
+					  MT7996_MAX_BSS_OFFLOAD_SIZE);
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
 
-	tlv = mt7996_mcu_add_uni_tlv(rskb,
-				     UNI_BSS_INFO_BCN_CONTENT, sizeof(*bcn));
-	bcn = (struct bss_bcn_content_tlv *)tlv;
-	bcn->enable = en;
-
-	if (!en)
-		goto out;
-
 	skb = ieee80211_beacon_get_template(hw, vif, &offs, 0);
 	if (!skb)
 		return -EINVAL;
 
-	if (skb->len > MAX_BEACON_SIZE - MT_TXD_SIZE) {
+	if (skb->len > MT7996_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "Bcn size limit exceed\n");
 		dev_kfree_skb(skb);
 		return -EINVAL;
@@ -2269,11 +2262,18 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	info = IEEE80211_SKB_CB(skb);
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
 
+	len = sizeof(*bcn) + MT_TXD_SIZE + skb->len;
+	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_CONTENT, len);
+	bcn = (struct bss_bcn_content_tlv *)tlv;
+	bcn->enable = en;
+	if (!en)
+		goto out;
+
 	mt7996_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
 	mt7996_mcu_beacon_mbss(rskb, skb, vif, bcn, &offs);
 	mt7996_mcu_beacon_cntdwn(vif, rskb, skb, &offs);
-	dev_kfree_skb(skb);
 out:
+	dev_kfree_skb(skb);
 	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
 }
@@ -2294,9 +2294,13 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	struct sk_buff *rskb, *skb = NULL;
 	struct tlv *tlv;
 	u8 *buf, interval;
+	int len;
+
+	if (vif->bss_conf.nontransmitted)
+		return 0;
 
 	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
-					  MT7996_INBAND_FRAME_SIZE);
+					  MT7996_MAX_BSS_OFFLOAD_SIZE);
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
 
@@ -2313,7 +2317,7 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	if (!skb)
 		return -EINVAL;
 
-	if (skb->len > MAX_INBAND_FRAME_SIZE - MT_TXD_SIZE) {
+	if (skb->len > MT7996_MAX_BEACON_SIZE) {
 		dev_err(dev->mt76.dev, "inband discovery size limit exceed\n");
 		dev_kfree_skb(skb);
 		return -EINVAL;
@@ -2324,7 +2328,9 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	info->band = band;
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
 
-	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_OFFLOAD, sizeof(*discov));
+	len = sizeof(*discov) + MT_TXD_SIZE + skb->len;
+
+	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_OFFLOAD, len);
 
 	discov = (struct bss_inband_discovery_tlv *)tlv;
 	discov->tx_mode = OFFLOAD_TX_MODE_SU;
@@ -2335,7 +2341,7 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	discov->enable = true;
 	discov->wcid = cpu_to_le16(MT7996_WTBL_RESERVED);
 
-	buf = (u8 *)tlv + sizeof(*discov) - MAX_INBAND_FRAME_SIZE;
+	buf = (u8 *)tlv + sizeof(*discov);
 
 	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0, changed);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 078f82858621..e4b31228ba0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -270,8 +270,6 @@ struct bss_inband_discovery_tlv {
 	u8 enable;
 	__le16 wcid;
 	__le16 prob_rsp_len;
-#define MAX_INBAND_FRAME_SIZE 512
-	u8 pkt[MAX_INBAND_FRAME_SIZE];
 } __packed;
 
 struct bss_bcn_content_tlv {
@@ -283,8 +281,6 @@ struct bss_bcn_content_tlv {
 	u8 enable;
 	u8 type;
 	__le16 pkt_len;
-#define MAX_BEACON_SIZE 512
-	u8 pkt[MAX_BEACON_SIZE];
 } __packed;
 
 struct bss_bcn_cntdwn_tlv {
@@ -591,13 +587,14 @@ enum {
 					 sizeof(struct sta_rec_hdr_trans) +	\
 					 sizeof(struct tlv))
 
+#define MT7996_MAX_BEACON_SIZE		1342
 #define MT7996_BEACON_UPDATE_SIZE	(sizeof(struct bss_req_hdr) +		\
 					 sizeof(struct bss_bcn_content_tlv) +	\
+					 MT_TXD_SIZE +				\
 					 sizeof(struct bss_bcn_cntdwn_tlv) +	\
 					 sizeof(struct bss_bcn_mbss_tlv))
-
-#define MT7996_INBAND_FRAME_SIZE	(sizeof(struct bss_req_hdr) +		\
-					 sizeof(struct bss_inband_discovery_tlv))
+#define MT7996_MAX_BSS_OFFLOAD_SIZE	(MT7996_MAX_BEACON_SIZE +		\
+					 MT7996_BEACON_UPDATE_SIZE)
 
 enum {
 	UNI_BAND_CONFIG_RADIO_ENABLE,
-- 
2.39.2

