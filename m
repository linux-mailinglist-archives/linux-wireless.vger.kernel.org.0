Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606064D9B00
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbiCOMUh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 08:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348194AbiCOMUe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 08:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2BF527CC
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 05:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 579EEB815D5
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 12:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B612EC340E8;
        Tue, 15 Mar 2022 12:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647346759;
        bh=/DE9uLyQ0X0XQe1Hh0xwQZu/4h1cQzZapO2Pwjypjg4=;
        h=From:To:Cc:Subject:Date:From;
        b=GwJhTFiuSVSx2XnEm1fzaPNzktDDzozKuYihoxGtJbtx32xG7k79+6bsbjBhF/DMj
         LgX/CxHRDyCfv0hmYrgGlOxS+2cuPf5TvB0XcbXgAbmOSdPASQkG642srHBMLgKw1B
         3vSt23F+6SPck5SL1+ojwGYkgrGV317zIfnLmZx8m8NNVU4uCDVnUOliWTMeQfNKnt
         +N4J9P6PYuEhSBXEo84HKO3AllN2bVGQr8/vut3uy28Ja7vmmJfAqklKl/opx6Ywec
         1IDDrq2LyJLGubKRWkSqlRqn7c/j2WIDMoPLG5x7LRiS8CUM1Ro+HBzYcBMVN1th4j
         Ug0CBe8amZlFA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, money.wang@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v2] mt76: mt7915: introduce 802.11ax multi-bss support
Date:   Tue, 15 Mar 2022 13:19:12 +0100
Message-Id: <de8955efb254ae54ed9e1b7883ad2b067ae34d0f.1647346612.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mbss mcu APIs to enable 802.11ax multi-bss AP support for
mt7915 devices

Tested-by: Money Wang <money.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Co-developed-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- rebase on mbss mac80211 support
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 19 +++++--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 54 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index eeb73d14552b..7cb17bf40e35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2675,11 +2675,25 @@ int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 	struct bss_info_basic *bss;
 	struct tlv *tlv;
 
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
+	bss = (struct bss_info_basic *)tlv;
+
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MONITOR:
 		break;
+	case NL80211_IFTYPE_AP:
+		if (ieee80211_hw_check(phy->hw, SUPPORTS_MULTI_BSSID)) {
+			u8 bssid_id = vif->bss_conf.bssid_indicator;
+			struct wiphy *wiphy = phy->hw->wiphy;
+
+			if (bssid_id > ilog2(wiphy->mbssid_max_interfaces))
+				return -EINVAL;
+
+			bss->non_tx_bssid = vif->bss_conf.bssid_index;
+			bss->max_bssid = bssid_id;
+		}
+		break;
 	case NL80211_IFTYPE_STATION:
 		if (enable) {
 			rcu_read_lock();
@@ -2704,9 +2718,6 @@ int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 		break;
 	}
 
-	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
-
-	bss = (struct bss_info_basic *)tlv;
 	bss->network_type = cpu_to_le32(type);
 	bss->bmc_wcid_lo = to_wcid_lo(wlan_idx);
 	bss->bmc_wcid_hi = to_wcid_hi(wlan_idx);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 9a8df1282f8d..6d29366c5139 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -343,6 +343,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
 	wiphy->reg_notifier = mt7915_regd_notifier;
 	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->mbssid_max_interfaces = 16;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
@@ -360,6 +361,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 
 	hw->max_tx_fragments = 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 10dc4bf5adec..9cd458223b00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1825,6 +1825,55 @@ mt7915_mcu_beacon_cntdwn(struct ieee80211_vif *vif, struct sk_buff *rskb,
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
+
+	if (!vif->bss_conf.bssid_indicator)
+		return;
+
+	tlv = mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_MBSSID,
+					   sizeof(*mbss), &bcn->sub_ntlv,
+					   &bcn->len);
+
+	mbss = (struct bss_info_bcn_mbss *)tlv;
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
+			const u8 *data;
+
+			if (sub_elem->id || sub_elem->datalen < 4)
+				continue; /* not a valid BSS profile */
+
+			/* Find WLAN_EID_MULTI_BSSID_IDX
+			 * in the merged nontransmitted profile
+			 */
+			data = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX,
+						sub_elem->data,
+						sub_elem->datalen);
+			if (!data || data[1] < 1 || !data[2])
+				continue;
+
+			mbss->offset[data[2]] = cpu_to_le16(data - skb->data);
+			mbss->bitmap |= cpu_to_le32(BIT(data[2]));
+		}
+	}
+}
+
 static void
 mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		       struct sk_buff *rskb, struct sk_buff *skb,
@@ -1952,6 +2001,9 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	int len = MT7915_BEACON_UPDATE_SIZE + MAX_BEACON_SIZE;
 	bool ext_phy = phy != &dev->phy;
 
+	if (vif->bss_conf.nontransmitted)
+		return 0;
+
 	rskb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
 					       NULL, len);
 	if (IS_ERR(rskb))
@@ -1981,8 +2033,8 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 
 	mt7915_mcu_beacon_check_caps(phy, vif, skb);
 
-	/* TODO: subtag - 11v MBSSID */
 	mt7915_mcu_beacon_cntdwn(vif, rskb, skb, bcn, &offs);
+	mt7915_mcu_beacon_mbss(rskb, skb, vif, bcn, &offs);
 	mt7915_mcu_beacon_cont(dev, vif, rskb, skb, bcn, &offs);
 	dev_kfree_skb(skb);
 
-- 
2.35.1

