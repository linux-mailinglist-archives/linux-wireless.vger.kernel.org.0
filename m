Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C83D3CB7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhGWPGH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:06:07 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:42006 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235557AbhGWPGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:06:05 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.132])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 565311C0061
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2B8B694006C
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CA7E013C2B4;
        Fri, 23 Jul 2021 08:46:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CA7E013C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627055196;
        bh=YWjQfZ1QdXKNGVnH4NlxAFkFllBsY6SWJoflhWUXg4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/nj6FEPZP5DK1/lUUmk7lKpYwGu8ACdxYB6mo8X7qV1RgSj0GwSRNvVfzEI2wY7W
         eVcHT3ZPOk+HcTlOt7tgqfdYpesePFwJnNij9epQfTRlIuweGJvPjI8HY5a0fdm1zY
         8zG7+GTSXtIZeywH10lK9m4+Zmdn8OlVoCA29riE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v4 3/8] mt76 - mt7915: Add some per-station tx stats to ethtool.
Date:   Fri, 23 Jul 2021 08:46:22 -0700
Message-Id: <20210723154627.10078-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723154627.10078-1-greearb@candelatech.com>
References: <20210723154627.10078-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627055197-8IAUVq1nxY99
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The tx status callback is not called for every frame, so
those specific counters under-count, but at least they give
some idea of what is going on.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 116 +++++++++++++++++-
 1 file changed, 110 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d0288fe2abdf..de083008663e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1068,6 +1068,35 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"tx_msdu_pack_6",
 	"tx_msdu_pack_7",
 	"tx_msdu_pack_8",
+	/* per vif counters */
+	"v_tx_mpdu_attempts",
+	"v_tx_mpdu_fail",
+	"v_tx_mpdu_retry",
+	"v_tx_mode_cck",
+	"v_tx_mode_ofdm",
+	"v_tx_mode_ht",
+	"v_tx_mode_ht_gf",
+	"v_tx_mode_vht",
+	"v_tx_mode_he_su",
+	"v_tx_mode_he_ext_su",
+	"v_tx_mode_he_tb",
+	"v_tx_mode_he_mu",
+	"v_tx_bw_20",
+	"v_tx_bw_40",
+	"v_tx_bw_80",
+	"v_tx_bw_160",
+	"v_tx_mcs_0",
+	"v_tx_mcs_1",
+	"v_tx_mcs_2",
+	"v_tx_mcs_3",
+	"v_tx_mcs_4",
+	"v_tx_mcs_5",
+	"v_tx_mcs_6",
+	"v_tx_mcs_7",
+	"v_tx_mcs_8",
+	"v_tx_mcs_9",
+	"v_tx_mcs_10",
+	"v_tx_mcs_11",
 };
 
 #define MT7915_SSTATS_LEN ARRAY_SIZE(mt7915_gstrings_stats)
@@ -1097,14 +1126,15 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-
-	/* TODO:  These are mostly dev-wide stats at this point.
-	 *  Get some per-vif stats?
-	 */
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt76_wcid *wcid;
+	struct mt7915_sta *msta;
+	struct mt7915_sta_stats *mstats;
+	bool found_sta = false;
 
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
-	int i, n, cnt;
+	int i, j, n, cnt, next_ei;
 	int ei = 0;
 
 	if (!phy)
@@ -1158,7 +1188,81 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	for (i = 0; i < 8; i++)
 		data[ei++] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
 
-	WARN_ON(ei != MT7915_SSTATS_LEN);
+	/* Add values for all stations owned by this vif */
+
+	/* See mt76_get_min_avr_rssi for example of how to find all sta
+	 * for a vif
+	 */
+	local_bh_disable();
+	rcu_read_lock();
+
+	next_ei = ei;
+
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.wcid_mask); i++) {
+		u32 mask = dev->mt76.wcid_mask[i];
+		u32 phy_mask = dev->mt76.wcid_phy_mask[i];
+		int q;
+
+		if (!mask)
+			continue;
+
+		for (j = i * 32; mask; j++, mask >>= 1, phy_mask >>= 1) {
+			if (!(mask & 1))
+				continue;
+
+			if (!!(phy_mask & 1) != ext_phy)
+				continue;
+
+			wcid = rcu_dereference(dev->mt76.wcid[j]);
+			if (!wcid)
+				continue;
+
+			msta = container_of(wcid, struct mt7915_sta, wcid);
+
+			if (msta->vif != mvif)
+				continue;
+
+			ei = next_ei;
+			mstats = &msta->stats;
+			data[ei++] += mstats->tx_mpdu_attempts;
+			data[ei++] += mstats->tx_mpdu_fail;
+			data[ei++] += mstats->tx_mpdu_retry;
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_CCK];
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_OFDM];
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HT];
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HT_GF];
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_VHT];
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_SU];
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_EXT_SU];
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_TB];
+			data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_MU];
+
+			for (q = 0; q < ARRAY_SIZE(mstats->tx_bw); q++)
+				data[ei++] += mstats->tx_bw[q];
+
+			for (q = 0; q < 12; q++)
+				data[ei++] += mstats->tx_mcs[q];
+			found_sta = true;
+		}
+	}
+
+	rcu_read_unlock();
+	local_bh_enable();
+
+	/* If we have no stations above, then we will not have filled out
+	 * the STA stats.  Zero those stats.
+	 */
+	if (!found_sta) {
+		int q;
+
+		for (q = 0; q < 28; q++)
+			data[ei++] = 0;
+	}
+
+	if (ei != MT7915_SSTATS_LEN) {
+		pr_err("ei: %d  MT7915_SSTATS_LEN: %d", ei, (int)(MT7915_SSTATS_LEN));
+		WARN_ON_ONCE(ei != MT7915_SSTATS_LEN);
+	}
 }
 
 const struct ieee80211_ops mt7915_ops = {
-- 
2.20.1

