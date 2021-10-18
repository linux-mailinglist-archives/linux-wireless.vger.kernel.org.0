Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD01B4318A8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhJRMQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 08:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbhJRMQh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 08:16:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38E61610A3;
        Mon, 18 Oct 2021 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634559266;
        bh=+G7spr0hpBbQYp1ngah2Y2L550U315sRoRAj5bsiH8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZXPmeL5uHgwPaDdzZp22nAql5xjPnyHmJNzzrrYylyeT+opDVQ1QU8JP0C/pLbCO
         YFkhzc8Vl5gwqOYVdD/Q+eg/nhJkE6xC5afF1RL24i/0k/DBjG3nfAWUhRMbafMNhz
         ZI4+5OPS0TlLfq+tZBlU/JNHZO1zkKQKQ0PnLveSSAcBQ8z6qqQ0GK9s3TJf6JsrU9
         2PKvqJ7AO5hbyOAjEKWHUWopWVPEkHBN2qwHlFD6XNegBlsnxCsoOyN0S0id9jnrkF
         m0M7kNeK9+U4SBhzlci9ED3V3dZmous4bBjSACK+BxsOce9xoKev+3KsZIZcQn0+/B
         PJ+q4orM3AqHQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: [PATCH 07/10] mt76: mt7921: add per-vif counters in ethtool
Date:   Mon, 18 Oct 2021 14:14:06 +0200
Message-Id: <350ad74a2911722f032842bc07dd8bb7d6ccb288.1634558817.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634558817.git.lorenzo@kernel.org>
References: <cover.1634558817.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915 driver, add per-vif tx counters in ethtool.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 53 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 39ec3e62748b..6aaf255e87c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -900,7 +900,33 @@ static const char mt7921_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_mpdu_cnt",
 	"rx_ampdu_cnt",
 	"rx_ampdu_bytes_cnt",
-	"rx_ba_cnt"
+	"rx_ba_cnt",
+	/* per vif counters */
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
 
 static void
@@ -920,13 +946,30 @@ mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return sset == ETH_SS_STATS ? ARRAY_SIZE(mt7921_gstrings_stats) : 0;
 }
 
+static void
+mt7921_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
+{
+	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt76_ethtool_worker_info *wi = wi_data;
+
+	if (msta->vif->mt76.idx != wi->idx)
+		return;
+
+	mt76_ethtool_worker(wi, &msta->stats);
+}
+
 static
 void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 struct ethtool_stats *stats, u64 *data)
 {
+	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
+	struct mt76_ethtool_worker_info wi = {
+		.data = data,
+		.idx = mvif->mt76.idx,
+	};
 	int i, ei = 0;
 
 	mt7921_mutex_acquire(dev);
@@ -965,8 +1008,16 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	data[ei++] = mib->rx_ampdu_bytes_cnt;
 	data[ei++] = mib->rx_ba_cnt;
 
+	/* Add values for all stations owned by this vif */
+	wi.initial_stat_idx = ei;
+	ieee80211_iterate_stations_atomic(hw, mt7921_ethtool_worker, &wi);
+
 	mt7921_mutex_release(dev);
 
+	if (!wi.sta_count)
+		return;
+
+	ei += wi.worker_stat_count;
 	if (ei != ARRAY_SIZE(mt7921_gstrings_stats))
 		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %lu",
 			ei, ARRAY_SIZE(mt7921_gstrings_stats));
-- 
2.31.1

