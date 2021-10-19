Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7452A433351
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhJSKPd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235194AbhJSKPd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FBE161381;
        Tue, 19 Oct 2021 10:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638400;
        bh=VVTlSBQOGa2kk4lyUAjz7dkItqkDENVUvqxqBMA5HFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4xDR2kYiPacRH6OPdPKbpIoIKfpKOTA6jj4Jq0UgVIgDOKOThtY0/xi/ZBy7vniu
         pJFLIEi3rMrWD7YriAJTSW7yb57yAivX7V4Q8aItB38vAqwB2uGmEKriZ792RY/065
         aWjBCUC1uP/jJYNj6wrYD4FhZd4DQONylwjTCX04AP+wAEEsBwm5/eLiv4LEmrowTJ
         +CQCHj1+GaOE+ugyylTNMxKHxRi0XpywFa0CiIbnS4+uqpAA9N9A1KPiofP25162o1
         rC3OCqfySvF2qMeux6tkSu3EPhZ5uzgtid1NEmPTUiUfSOaftdZB8HsUYZEXUqYs2I
         Uuw9L2Ca9aHQg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 10/10] mt76: mt7921: add per-vif counters in ethtool
Date:   Tue, 19 Oct 2021 12:12:32 +0200
Message-Id: <68c6dbd092df7df071c707dadc0b5148e6b4c732.1634637742.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634637742.git.lorenzo@kernel.org>
References: <cover.1634637742.git.lorenzo@kernel.org>
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
index 575f23d9ec52..35a490c049e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -902,7 +902,33 @@ static const char mt7921_gstrings_stats[][ETH_GSTRING_LEN] = {
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
@@ -922,13 +948,30 @@ mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
@@ -967,8 +1010,16 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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

