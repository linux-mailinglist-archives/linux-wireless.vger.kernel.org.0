Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D803DDBEA
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhHBPIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 11:08:35 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:36318 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234579AbhHBPIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 11:08:32 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.75])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C62542007F
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:08:18 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9B4F18006E
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:08:18 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 4890E13C2B5;
        Mon,  2 Aug 2021 08:08:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4890E13C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627916898;
        bh=aDElV/Pvgx+lAhFSv7CvWl1Mos19XGYDaj8Vtcn0VDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmgZCoiM1RYNQPEFKKXYbyBEul9MlyeYwbMYREDV1KVNehRWgGpWkgjbfCAXnpp1n
         isl8ZCodoOf4Tncqh0ajbbKx12L8Ius8SrG/UwoPCovp8muzG7uga0k8NpHV77Jxpr
         O2rG03/Tpw6+VJyHq3cESYLVP35HUnYp2ELpiUMg=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v6 3/7] mt76: mt7915: add some per-station tx stats to ethtool
Date:   Mon,  2 Aug 2021 08:08:04 -0700
Message-Id: <20210802150808.30113-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802150808.30113-1-greearb@candelatech.com>
References: <20210802150808.30113-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627916899-79UAgt7TA5uX
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The tx status callback is not called for every frame, so
those specific counters under-count, but at least they give
some idea of what is going on.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 98 ++++++++++++++++++-
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 994f84e9d7aa..88a8547e2e7f 100644
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
@@ -1093,6 +1122,50 @@ int mt7915_get_et_sset_count(struct ieee80211_hw *hw,
 	return 0;
 }
 
+struct mt7915_ethtool_worker_info {
+	u64 *data;
+	struct mt7915_vif *mvif;
+	int initial_stat_idx;
+	int worker_stat_count;
+	int sta_count;
+};
+
+static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
+{
+	struct mt7915_ethtool_worker_info *wi = wi_data;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int ei = wi->initial_stat_idx;
+	int q;
+	u64 *data = wi->data;
+	struct mt7915_sta_stats *mstats = &msta->stats;
+
+	if (msta->vif != wi->mvif)
+		return;
+
+	wi->sta_count++;
+
+	data[ei++] += mstats->tx_mpdu_attempts;
+	data[ei++] += mstats->tx_mpdu_fail;
+	data[ei++] += mstats->tx_mpdu_retry;
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_CCK];
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_OFDM];
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HT];
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HT_GF];
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_VHT];
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_SU];
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_EXT_SU];
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_TB];
+	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_MU];
+
+	for (q = 0; q < ARRAY_SIZE(mstats->tx_bw); q++)
+		data[ei++] += mstats->tx_bw[q];
+
+	for (q = 0; q < 12; q++)
+		data[ei++] += mstats->tx_mcs[q];
+
+	wi->worker_stat_count = ei - wi->initial_stat_idx;
+}
+
 static
 void mt7915_get_et_stats(struct ieee80211_hw *hw,
 			 struct ieee80211_vif *vif,
@@ -1100,10 +1173,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-
-	/* TODO:  These are mostly dev-wide stats at this point.
-	 *  Get some per-vif stats?
-	 */
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_ethtool_worker_info wi;
 
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
@@ -1161,7 +1232,24 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	for (i = 0; i < 8; i++)
 		data[ei++] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
 
-	WARN_ON(ei != MT7915_SSTATS_LEN);
+	/* Add values for all stations owned by this vif */
+	wi.data = data;
+	wi.mvif = mvif;
+	wi.initial_stat_idx = ei;
+	wi.worker_stat_count = 0;
+	wi.sta_count = 0;
+
+	ieee80211_iterate_stations_atomic(hw, mt7915_ethtool_worker, &wi);
+
+	if (wi.sta_count == 0)
+		return;
+
+	ei += wi.worker_stat_count;
+	if (ei != MT7915_SSTATS_LEN) {
+		dev_err(dev->mt76.dev, "ei: %d  MT7915_SSTATS_LEN: %d",
+			ei, (int)(MT7915_SSTATS_LEN));
+		WARN_ON_ONCE(ei != MT7915_SSTATS_LEN);
+	}
 }
 
 const struct ieee80211_ops mt7915_ops = {
-- 
2.20.1

