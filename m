Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28523713906
	for <lists+linux-wireless@lfdr.de>; Sun, 28 May 2023 12:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjE1K3D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 May 2023 06:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE1K3C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 May 2023 06:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC3BD
        for <linux-wireless@vger.kernel.org>; Sun, 28 May 2023 03:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E100660919
        for <linux-wireless@vger.kernel.org>; Sun, 28 May 2023 10:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093B7C433EF;
        Sun, 28 May 2023 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685269740;
        bh=8Hn+PyOhSn26dTziuGvswTgBnLsjvuNXsFUT8YkYeDU=;
        h=From:To:Cc:Subject:Date:From;
        b=rlVKu3IsI+C9cvIH/dP6oCwBPksvzq+y5EHfgkYFznQn1B3GEFMfTcCHh43fr3Mde
         wGD/SYfd1Uzh6IEy7wOtqvqE1/tFyIcawMRRCZLGuyPWa65I5Wwu2XeFBACR0pEcuj
         Fe7jWjNXjuDw43/mq4vKLFQzAgPAmvUNavDLA2+u87tVqKoxxy8orBtz0yrzPe1S0r
         ts/tmINNpW1Jw4XLTgI+BgoPwCDi4qmdAQy1kif05ldhe7E29cDhTkdfE2shmvFs/4
         D6/rcnE6bAGwRHk/rXJInG9ILyDeZ2cSfrVe5V24XTfvmLcIaCUmwpTDcKDJu+5+lp
         4JhFCQb6LIC5A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@kernel.org
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wifi: mt76: mt7996: fix possible NULL pointer dereference in mt7996_mac_write_txwi()
Date:   Sun, 28 May 2023 12:28:49 +0200
Message-Id: <2637628a84f42ad6d7b774e706f041d5b45c8cb5.1685269638.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix possible NULL pointer dereference on mvif pointer in
mt7996_mac_write_txwi routine.

Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 39a4a73ef8e6..9b0f6053e0fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1004,10 +1004,10 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	struct mt7996_vif *mvif;
 	u16 tx_count = 15;
 	u32 val;
 	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
@@ -1015,7 +1015,8 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
 					 BSS_CHANGED_FILS_DISCOVERY));
 
-	if (vif) {
+	mvif = vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
+	if (mvif) {
 		omac_idx = mvif->mt76.omac_idx;
 		wmm_idx = mvif->mt76.wmm_idx;
 		band_idx = mvif->mt76.band_idx;
@@ -1081,12 +1082,16 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 		bool mcast = ieee80211_is_data(hdr->frame_control) &&
 			     is_multicast_ether_addr(hdr->addr1);
-		u8 idx = mvif->basic_rates_idx;
+		u8 idx = MT7996_BASIC_RATES_TBL;
 
-		if (mcast && mvif->mcast_rates_idx)
-			idx = mvif->mcast_rates_idx;
-		else if (beacon && mvif->beacon_rates_idx)
-			idx = mvif->beacon_rates_idx;
+		if (mvif) {
+			if (mcast && mvif->mcast_rates_idx)
+				idx = mvif->mcast_rates_idx;
+			else if (beacon && mvif->beacon_rates_idx)
+				idx = mvif->beacon_rates_idx;
+			else
+				idx = mvif->basic_rates_idx;
+		}
 
 		txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TX_RATE, idx));
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
-- 
2.40.1

