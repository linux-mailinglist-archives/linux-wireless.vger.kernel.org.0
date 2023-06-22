Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501ED73A67E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjFVQwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjFVQwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47510A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B3B6184D
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 16:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28B1C433C0;
        Thu, 22 Jun 2023 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452718;
        bh=ux5dc1KNQ2EvogDNYHSigaP2en76zRGNj9l6A0h/gbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7J2NK0zig/PIhKqB59OJSDSHq5LYcPalnsZaN9CRf2Fgiik3Im2Z7EN/PiIq3ofw
         THOhlTPW7jJttHqx68OoLnpd6YGmwUH8+5tjGDyb+YkTZ3AiXl0jYrC2yJmgIDIwVq
         bgs/g+yXiMXwuChSH9lVtoZGLrUU1IwQflTqkWQG38i1PMwPekpokxSWUwooM1Ng+i
         vu1DMbFhxNLW5GXo9KicHeDT/tb5v0cgBuV+0/zeu7CHdp+8lOWVFJ1psa4jhqhEoI
         i8zLKni9XETmYEieTRZ3C82djfMesIERbn0DSIbr+KJGtmxdtdaFpo3idaSFLnGoqK
         2he4cmmNAA6sA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, deren.wu@mediatek.com,
        shayne.chen@mediatek.com
Subject: [PATCH v4 13/15] wifi: mt76: move rate info in mt76_vif
Date:   Thu, 22 Jun 2023 18:50:30 +0200
Message-ID: <6601023837fda9cabfc06c9b9b8a674aabec1d29.1687452202.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687452202.git.lorenzo@kernel.org>
References: <cover.1687452202.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce mt76_connac3 mac library used
by WiFi7 chipsets (e.g. mt7996).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  4 ----
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8ec77682d8e9..878087257ea7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -705,6 +705,9 @@ struct mt76_vif {
 	u8 wmm_idx;
 	u8 scan_seq_num;
 	u8 cipher;
+	u8 basic_rates_idx;
+	u8 mcast_rates_idx;
+	u8 beacon_rates_idx;
 };
 
 struct mt76_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index dfe70e0ff329..6fc9260a2e92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1013,7 +1013,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	struct mt7996_vif *mvif;
+	struct mt76_vif *mvif;
 	u16 tx_count = 15;
 	u32 val;
 	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
@@ -1021,11 +1021,11 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
 					 BSS_CHANGED_FILS_DISCOVERY));
 
-	mvif = vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
+	mvif = vif ? (struct mt76_vif *)vif->drv_priv : NULL;
 	if (mvif) {
-		omac_idx = mvif->mt76.omac_idx;
-		wmm_idx = mvif->mt76.wmm_idx;
-		band_idx = mvif->mt76.band_idx;
+		omac_idx = mvif->omac_idx;
+		wmm_idx = mvif->wmm_idx;
+		band_idx = mvif->band_idx;
 	}
 
 	if (inband_disc) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 54858cfc9342..c3a479dc3f53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -223,9 +223,9 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
-		mvif->basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
+		mvif->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
 	else
-		mvif->basic_rates_idx = MT7996_BASIC_RATES_TBL;
+		mvif->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL;
 
 	mt7996_init_bitrate_mask(vif);
 
@@ -505,7 +505,7 @@ static u8
 mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       bool beacon, bool mcast)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct mt76_phy *mphy = hw->priv;
 	u16 rate;
 	u8 i, idx, ht;
@@ -517,7 +517,7 @@ mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
 		/* must odd index */
-		idx = MT7996_BEACON_RATES_TBL + 2 * (mvif->mt76.idx % 20);
+		idx = MT7996_BEACON_RATES_TBL + 2 * (mvif->idx % 20);
 		mt7996_mac_set_fixed_rate_table(dev, idx, rate);
 		return idx;
 	}
@@ -555,7 +555,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_bss_conf *info,
 				    u64 changed)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 611f6450520b..4a30db49ef33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -604,7 +604,7 @@ static void
 mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		       struct mt7996_phy *phy)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct bss_rate_tlv *bmc;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	enum nl80211_band band = chandef->chan->band;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 79cb71c16264..726c222e8e1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -128,10 +128,6 @@ struct mt7996_vif {
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 	struct cfg80211_bitrate_mask bitrate_mask;
-
-	u8 basic_rates_idx;
-	u8 mcast_rates_idx;
-	u8 beacon_rates_idx;
 };
 
 /* crash-dump */
-- 
2.41.0

