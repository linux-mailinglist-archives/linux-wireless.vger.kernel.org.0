Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFF78E6A8
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbjHaGiK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 02:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242139AbjHaGiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 02:38:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42505A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 23:38:07 -0700 (PDT)
X-UUID: cec9c90447c611ee9cb5633481061a41-20230831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bqcwriT5uhym906Ccu9dOQ/FkJWDVjtzZ3N88mkXvSc=;
        b=Bq3b0Czbmkw5SABqo3HSOl1lOtIA4JD00X9/KyiIeIHugSecfTG9aQWbkKQK9zWGjvKSFUHvsMlkOhVsdsiKeCN+9rhlXvO6Q61KG/ulyo1B1rk/vORI/T0HVZyWUXj3B5PZR/rqUSX+NXO9/d0T3vzIRAwfWzHanq/LGSHt7iI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:b797c427-a52c-43e2-8a15-25181036d0d5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:b7e1f31f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cec9c90447c611ee9cb5633481061a41-20230831
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 202579639; Thu, 31 Aug 2023 14:22:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 31 Aug 2023 14:22:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 31 Aug 2023 14:22:47 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Chank Chen <chank.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/9] wifi: mt76: connac: add MBSSID support for mt7996
Date:   Thu, 31 Aug 2023 14:22:13 +0800
Message-ID: <20230831062221.20027-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chank Chen <chank.chen@mediatek.com>

Add bss_info_uni_mbssid tag and implement 802.11v MBSSID support for
mt7996 chipsets.

Signed-off-by: Chank Chen <chank.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 10 +++
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 79 ++++++++++++++++++-
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4543e5bf0482..bbeeb4b03191 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1279,6 +1279,7 @@ enum {
 	UNI_BSS_INFO_RLM = 2,
 	UNI_BSS_INFO_BSS_COLOR = 4,
 	UNI_BSS_INFO_HE_BASIC = 5,
+	UNI_BSS_INFO_11V_MBSSID = 6,
 	UNI_BSS_INFO_BCN_CONTENT = 7,
 	UNI_BSS_INFO_BCN_CSA = 8,
 	UNI_BSS_INFO_BCN_BCC = 9,
@@ -1549,6 +1550,15 @@ struct bss_info_uni_he {
 	u8 rsv[2];
 } __packed;
 
+struct bss_info_uni_mbssid {
+	__le16 tag;
+	__le16 len;
+	u8 max_indicator;
+	u8 mbss_idx;
+	u8 tx_bss_omac_idx;
+	u8 rsv;
+} __packed;
+
 struct mt76_connac_gtk_rekey_tlv {
 	__le16 tag;
 	__le16 len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f16f738e30db..12c2513826e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -180,6 +180,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7996_regd_notifier;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->mbssid_max_interfaces = 16;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
@@ -203,6 +204,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 
 	hw->max_tx_fragments = 4;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 3b56b90bb956..29e287373717 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -600,6 +600,24 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
 }
 
+static void
+mt7996_mcu_bss_mbssid_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+			  struct mt7996_phy *phy, int enable)
+{
+	struct bss_info_uni_mbssid *mbssid;
+	struct tlv *tlv;
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_11V_MBSSID, sizeof(*mbssid));
+
+	mbssid = (struct bss_info_uni_mbssid *)tlv;
+
+	if (enable && vif->bss_conf.bssid_indicator) {
+		mbssid->max_indicator = vif->bss_conf.bssid_indicator;
+		mbssid->mbss_idx = vif->bss_conf.bssid_index;
+		mbssid->tx_bss_omac_idx = 0;
+	}
+}
+
 static void
 mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		       struct mt7996_phy *phy)
@@ -866,6 +884,9 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
 		/* this tag is necessary no matter if the vif is MLD */
 		mt7996_mcu_bss_mld_tlv(skb, vif);
 	}
+
+	mt7996_mcu_bss_mbssid_tlv(skb, vif, phy, enable);
+
 out:
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
@@ -2126,6 +2147,59 @@ mt7996_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
 	info->cnt = skb->data[offs->cntdwn_counter_offs[0]];
 }
 
+static void
+mt7996_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
+		       struct ieee80211_vif *vif, struct bss_bcn_content_tlv *bcn,
+		       struct ieee80211_mutable_offsets *offs)
+{
+	struct bss_bcn_mbss_tlv *mbss;
+	const struct element *elem;
+	struct tlv *tlv;
+
+	if (!vif->bss_conf.bssid_indicator)
+		return;
+
+	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_MBSSID, sizeof(*mbss));
+
+	mbss = (struct bss_bcn_mbss_tlv *)tlv;
+	mbss->offset[0] = cpu_to_le16(offs->tim_offset);
+	mbss->bitmap = cpu_to_le32(1);
+
+	for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
+			    &skb->data[offs->mbssid_off],
+			    skb->len - offs->mbssid_off) {
+		const struct element *sub_elem;
+
+		if (elem->datalen < 2)
+			continue;
+
+		for_each_element(sub_elem, elem->data + 1, elem->datalen - 1) {
+			const struct ieee80211_bssid_index *idx;
+			const u8 *idx_ie;
+
+			/* not a valid BSS profile */
+			if (sub_elem->id || sub_elem->datalen < 4)
+				continue;
+
+			/* Find WLAN_EID_MULTI_BSSID_IDX
+			 * in the merged nontransmitted profile
+			 */
+			idx_ie = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX,
+						  sub_elem->data, sub_elem->datalen);
+			if (!idx_ie || idx_ie[1] < sizeof(*idx))
+				continue;
+
+			idx = (void *)(idx_ie + 2);
+			if (!idx->bssid_index || idx->bssid_index > 31)
+				continue;
+
+			mbss->offset[idx->bssid_index] = cpu_to_le16(idx_ie -
+								     skb->data);
+			mbss->bitmap |= cpu_to_le32(BIT(idx->bssid_index));
+		}
+	}
+}
+
 static void
 mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		       struct sk_buff *rskb, struct sk_buff *skb,
@@ -2166,6 +2240,9 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	struct tlv *tlv;
 	struct bss_bcn_content_tlv *bcn;
 
+	if (vif->bss_conf.nontransmitted)
+		return 0;
+
 	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
 					  MT7996_BEACON_UPDATE_SIZE);
 	if (IS_ERR(rskb))
@@ -2193,7 +2270,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
 
 	mt7996_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
-	/* TODO: subtag - 11v MBSSID */
+	mt7996_mcu_beacon_mbss(rskb, skb, vif, bcn, &offs);
 	mt7996_mcu_beacon_cntdwn(vif, rskb, skb, &offs);
 	dev_kfree_skb(skb);
 out:
-- 
2.39.2

