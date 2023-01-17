Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A490D66D39A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 01:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjAQAQX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 19:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjAQAQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 19:16:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B825622DE2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 16:16:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5457B61188
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 00:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567E3C433EF;
        Tue, 17 Jan 2023 00:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673914578;
        bh=r6auEO1BAK6L9pQl6Op0CsmdQkcg/US17zBOHUFc9EU=;
        h=From:To:Cc:Subject:Date:From;
        b=kxVh2AhW137CtAoxzmLI9f63eBy4LH8EoDzPASZxThyfgo7fiTSX/6asxa09TK4YR
         Q0j5G1c+ED5uncnQcGd+tV0BJ/hQrw/KOip+1ycNyJ+h+FLsRTIDsNXrTzA1YVpeXR
         teptfqXS1d7ANsngcy+IJn0+trF1vCRkYDIoi/p6HDIg7S1+6anarnUeYwB6HyYUIe
         SNncFTOsYwQRgXZvTBgTajg/PobLGgV54dQbrQ+7w7J65F1kaBS7wfI9WtvQTXROBW
         XUalnvDJTzuvcf4mZF6wgBlKD3jtXHRbQ1GfEjKXpU4rUm4+FoytZdzx3zzt0+LItc
         8ouL4G3ux0sSw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] wifi: mt76: mt7996: rely on mt76_connac2_mac_tx_rate_val
Date:   Tue, 17 Jan 2023 01:16:07 +0100
Message-Id: <e370ac02b77dc49c9a1d6473cdc4c75060510c05.1673914447.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to fix a possible NULL pointer dereference in
mt7996_mac_write_txwi() of vif pointer, export
mt76_connac2_mac_tx_rate_val utility routine and reuse it
in mt7996 driver.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 ++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  7 +--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 48 +------------------
 3 files changed, 9 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 8ba883b03e50..2ee9a3c8e25c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -370,6 +370,9 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				 struct sk_buff *skb, struct mt76_wcid *wcid,
 				 struct ieee80211_key_conf *key, int pid,
 				 enum mt76_txq_id qid, u32 changed);
+u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
+				 struct ieee80211_vif *vif,
+				 bool beacon, bool mcast);
 bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			       __le32 *txs_data);
 bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index c8d0c84e688b..aed4ee95fb2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -267,9 +267,9 @@ int mt76_connac_init_tx_queues(struct mt76_phy *phy, int idx, int n_desc,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_init_tx_queues);
 
-static u16
-mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
-			     bool beacon, bool mcast)
+u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
+				 struct ieee80211_vif *vif,
+				 bool beacon, bool mcast)
 {
 	u8 mode = 0, band = mphy->chandef.chan->band;
 	int rateidx = 0, mcast_rate;
@@ -319,6 +319,7 @@ mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	return FIELD_PREP(MT_TX_RATE_IDX, rateidx) |
 	       FIELD_PREP(MT_TX_RATE_MODE, mode);
 }
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_tx_rate_val);
 
 static void
 mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e198ab006c46..797dd920c0dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -959,51 +959,6 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	}
 }
 
-static u16
-mt7996_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
-		       bool beacon, bool mcast)
-{
-	u8 mode = 0, band = mphy->chandef.chan->band;
-	int rateidx = 0, mcast_rate;
-
-	if (beacon) {
-		struct cfg80211_bitrate_mask *mask;
-
-		mask = &vif->bss_conf.beacon_tx_rate;
-		if (hweight16(mask->control[band].he_mcs[0]) == 1) {
-			rateidx = ffs(mask->control[band].he_mcs[0]) - 1;
-			mode = MT_PHY_TYPE_HE_SU;
-			goto out;
-		} else if (hweight16(mask->control[band].vht_mcs[0]) == 1) {
-			rateidx = ffs(mask->control[band].vht_mcs[0]) - 1;
-			mode = MT_PHY_TYPE_VHT;
-			goto out;
-		} else if (hweight8(mask->control[band].ht_mcs[0]) == 1) {
-			rateidx = ffs(mask->control[band].ht_mcs[0]) - 1;
-			mode = MT_PHY_TYPE_HT;
-			goto out;
-		} else if (hweight32(mask->control[band].legacy) == 1) {
-			rateidx = ffs(mask->control[band].legacy) - 1;
-			goto legacy;
-		}
-	}
-
-	mcast_rate = vif->bss_conf.mcast_rate[band];
-	if (mcast && mcast_rate > 0)
-		rateidx = mcast_rate - 1;
-	else
-		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
-
-legacy:
-	rateidx = mt76_calculate_default_rate(mphy, rateidx);
-	mode = rateidx >> 8;
-	rateidx &= GENMASK(7, 0);
-
-out:
-	return FIELD_PREP(MT_TX_RATE_IDX, rateidx) |
-	       FIELD_PREP(MT_TX_RATE_MODE, mode);
-}
-
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
 			   struct ieee80211_key_conf *key, u32 changed)
@@ -1091,7 +1046,8 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		/* Fixed rata is available just for 802.11 txd */
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 		bool multicast = is_multicast_ether_addr(hdr->addr1);
-		u16 rate = mt7996_mac_tx_rate_val(mphy, vif, beacon, multicast);
+		u16 rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon,
+							multicast);
 
 		/* fix to bw 20 */
 		val = MT_TXD6_FIXED_BW |
-- 
2.39.0

