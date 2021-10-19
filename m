Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F3433348
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhJSKPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235150AbhJSKPU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11CD761374;
        Tue, 19 Oct 2021 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638388;
        bh=lMYbLm4buof14xRT4477wVXZ/86S0QxT/PfVtKW3bFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OD9wO7hcvxQOMCPUt5ZNxDro/XbIJzOLCctyxLn8QDVvaGIY0Gk+epWjBIqRpUGxz
         fTlvCStD7U5B4ZxyWFfV0MTW0Tod42+kMKvu8uDV9IQGbkqFCvvJi0s69V0tR1T7iw
         pHBw5kOYFr4GizH5PpKLFGiLo4qSY6w1QWX9THdFIE90pEa5k3OPJC+F4xm6T3A2eq
         u6XJQO0D47wpDE8yN7uG+rg+B4up8XsO6oNZTeswXMQrEUptiRMb0t5PKzdRwui22G
         lyM4iGei8pVb8ZUpPPq2JOuXJPFqqK7W0/kTf/RIvgsEa9n/vFbemobliXjVd1yI7B
         e9o2K1wfSRKgw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 02/10] mt76: move mt76_ethtool_worker_info in mt76 module
Date:   Tue, 19 Oct 2021 12:12:24 +0200
Message-Id: <32bbf1f6e927629573ab8fe6ac418f542842945d.1634637742.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634637742.git.lorenzo@kernel.org>
References: <cover.1634637742.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_ethtool_worker_info in common code in order to be reused in
mt7921 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 28 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 10 ++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 47 +++----------------
 3 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 766681a4f89e..62807dc311c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1508,3 +1508,31 @@ u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
 	return rate->hw_value;
 }
 EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
+
+void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
+			 struct mt76_sta_stats *stats)
+{
+	int i, ei = wi->initial_stat_idx;
+	u64 *data = wi->data;
+
+	wi->sta_count++;
+
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_CCK];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_OFDM];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HT];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HT_GF];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_VHT];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_SU];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_EXT_SU];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_TB];
+	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_MU];
+
+	for (i = 0; i < ARRAY_SIZE(stats->tx_bw); i++)
+		data[ei++] += stats->tx_bw[i];
+
+	for (i = 0; i < 12; i++)
+		data[ei++] += stats->tx_mcs[i];
+
+	wi->worker_stat_count = ei - wi->initial_stat_idx;
+}
+EXPORT_SYMBOL_GPL(mt76_ethtool_worker);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ae6c3a735f49..e2da720a91b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -786,6 +786,14 @@ struct mt76_sta_stats {
 	u64 tx_mcs[16];		/* mcs idx */
 };
 
+struct mt76_ethtool_worker_info {
+	u64 *data;
+	int idx;
+	int initial_stat_idx;
+	int worker_stat_count;
+	int sta_count;
+};
+
 #define CCK_RATE(_idx, _rate) {					\
 	.bitrate = _rate,					\
 	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
@@ -1241,6 +1249,8 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
 
+void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
+			 struct mt76_sta_stats *stats);
 int mt76_skb_adjust_pad(struct sk_buff *skb, int pad);
 int mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 			 u8 req_type, u16 val, u16 offset,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index bbf74e7452d8..f0fe4ee30e79 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1187,45 +1187,15 @@ int mt7915_get_et_sset_count(struct ieee80211_hw *hw,
 	return 0;
 }
 
-struct mt7915_ethtool_worker_info {
-	u64 *data;
-	struct mt7915_vif *mvif;
-	int initial_stat_idx;
-	int worker_stat_count;
-	int sta_count;
-};
-
 static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 {
-	struct mt7915_ethtool_worker_info *wi = wi_data;
+	struct mt76_ethtool_worker_info *wi = wi_data;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt76_sta_stats *mstats = &msta->stats;
-	int ei = wi->initial_stat_idx;
-	int q;
-	u64 *data = wi->data;
 
-	if (msta->vif != wi->mvif)
+	if (msta->vif->idx != wi->idx)
 		return;
 
-	wi->sta_count++;
-
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_CCK];
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_OFDM];
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HT];
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HT_GF];
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_VHT];
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_SU];
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_EXT_SU];
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_TB];
-	data[ei++] += mstats->tx_mode[MT_PHY_TYPE_HE_MU];
-
-	for (q = 0; q < ARRAY_SIZE(mstats->tx_bw); q++)
-		data[ei++] += mstats->tx_bw[q];
-
-	for (q = 0; q < 12; q++)
-		data[ei++] += mstats->tx_mcs[q];
-
-	wi->worker_stat_count = ei - wi->initial_stat_idx;
+	mt76_ethtool_worker(wi, &msta->stats);
 }
 
 static
@@ -1236,9 +1206,11 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_ethtool_worker_info wi;
+	struct mt76_ethtool_worker_info wi = {
+		.data = data,
+		.idx = mvif->idx,
+	};
 	struct mib_stats *mib = &phy->mib;
-
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
 	int i, n, ei = 0;
@@ -1303,12 +1275,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->rx_ba_cnt;
 
 	/* Add values for all stations owned by this vif */
-	wi.data = data;
-	wi.mvif = mvif;
 	wi.initial_stat_idx = ei;
-	wi.worker_stat_count = 0;
-	wi.sta_count = 0;
-
 	ieee80211_iterate_stations_atomic(hw, mt7915_ethtool_worker, &wi);
 
 	if (wi.sta_count == 0)
-- 
2.31.1

