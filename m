Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D5B43334E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 12:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhJSKP3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 06:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235180AbhJSKP2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 06:15:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1B4E6137C;
        Tue, 19 Oct 2021 10:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634638396;
        bh=jCkKSt0tthJ8gCn38kUdGHx4fp6r6SdWk4es9vm5gag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzrkuIalIINZQ6nqltVfz33nWGhiXcJTiaG45c4acQaQt9TdXVrcHFTizLnojtMZP
         cgd2dDZi+F5gUmQs+YpvAOPJKPETumFoemgDyDE2R7tGvr2j94c/OTMmwwAFt2v0Ks
         NIog0qFrWXEF16KkGmzykCHiS6Ro7VeKscj5nnAGEcOpxkX/Vl6zzivJooIMJ9pK7+
         n46Cmg+gzc/GZWbe6b/JCqyrttS1c0OX1zof8huAuZpmuCRXg1QBP4RRPBDcjvnOLY
         J7WQtwrha/STwRHJUyrBq9qZBOetJmdCAI8780sy/j9vx0spg6yvXW+E6Qipew/A4S
         pdivEX+6f59Yg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com,
        ryder.lee@mediatek.com
Subject: [PATCH v2 07/10] mt76: mt7921: introduce stats reporting through ethtool
Date:   Tue, 19 Oct 2021 12:12:29 +0200
Message-Id: <579c1b1d45e36615fc53a97d45338c8e1197b0a8.1634637742.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634637742.git.lorenzo@kernel.org>
References: <cover.1634637742.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915 driver, add tx/rx statistics reporting through ethtool.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 22d5a0adb5ad..bd49cfd59617 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -861,6 +861,119 @@ mt7921_get_stats(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static const char mt7921_gstrings_stats[][ETH_GSTRING_LEN] = {
+	/* tx counters */
+	"tx_ampdu_cnt",
+	"tx_mpdu_attempts",
+	"tx_mpdu_success",
+	"tx_pkt_ebf_cnt",
+	"tx_pkt_ibf_cnt",
+	"tx_ampdu_len:0-1",
+	"tx_ampdu_len:2-10",
+	"tx_ampdu_len:11-19",
+	"tx_ampdu_len:20-28",
+	"tx_ampdu_len:29-37",
+	"tx_ampdu_len:38-46",
+	"tx_ampdu_len:47-55",
+	"tx_ampdu_len:56-79",
+	"tx_ampdu_len:80-103",
+	"tx_ampdu_len:104-127",
+	"tx_ampdu_len:128-151",
+	"tx_ampdu_len:152-175",
+	"tx_ampdu_len:176-199",
+	"tx_ampdu_len:200-223",
+	"tx_ampdu_len:224-247",
+	"ba_miss_count",
+	"tx_beamformer_ppdu_iBF",
+	"tx_beamformer_ppdu_eBF",
+	"tx_beamformer_rx_feedback_all",
+	"tx_beamformer_rx_feedback_he",
+	"tx_beamformer_rx_feedback_vht",
+	"tx_beamformer_rx_feedback_ht",
+	"tx_msdu_pack_1",
+	"tx_msdu_pack_2",
+	"tx_msdu_pack_3",
+	"tx_msdu_pack_4",
+	"tx_msdu_pack_5",
+	"tx_msdu_pack_6",
+	"tx_msdu_pack_7",
+	"tx_msdu_pack_8",
+	/* rx counters */
+	"rx_mpdu_cnt",
+	"rx_ampdu_cnt",
+	"rx_ampdu_bytes_cnt",
+	"rx_ba_cnt"
+};
+
+static void
+mt7921_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      u32 sset, u8 *data)
+{
+	if (sset != ETH_SS_STATS)
+		return;
+
+	memcpy(data, *mt7921_gstrings_stats, sizeof(mt7921_gstrings_stats));
+}
+
+static int
+mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 int sset)
+{
+	return sset == ETH_SS_STATS ? ARRAY_SIZE(mt7921_gstrings_stats) : 0;
+}
+
+static
+void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 struct ethtool_stats *stats, u64 *data)
+{
+	struct mt7921_phy *phy = mt7921_hw_phy(hw);
+	struct mt7921_dev *dev = phy->dev;
+	struct mib_stats *mib = &phy->mib;
+	int i, ei = 0;
+
+	mt7921_mutex_acquire(dev);
+
+	mt7921_mac_update_mib_stats(phy);
+
+	data[ei++] = mib->tx_ampdu_cnt;
+	data[ei++] = mib->tx_mpdu_attempts_cnt;
+	data[ei++] = mib->tx_mpdu_success_cnt;
+	data[ei++] = mib->tx_pkt_ebf_cnt;
+	data[ei++] = mib->tx_pkt_ibf_cnt;
+
+	/* Tx ampdu stat */
+	for (i = 0; i < 15; i++)
+		data[ei++] = dev->mt76.aggr_stats[i];
+
+	data[ei++] = phy->mib.ba_miss_cnt;
+
+	/* Tx Beamformer monitor */
+	data[ei++] = mib->tx_bf_ibf_ppdu_cnt;
+	data[ei++] = mib->tx_bf_ebf_ppdu_cnt;
+
+	/* Tx Beamformer Rx feedback monitor */
+	data[ei++] = mib->tx_bf_rx_fb_all_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_he_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_vht_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_ht_cnt;
+
+	/* Tx amsdu info (pack-count histogram) */
+	for (i = 0; i < 8; i++)
+		data[ei++] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+
+	/* rx counters */
+	data[ei++] = mib->rx_mpdu_cnt;
+	data[ei++] = mib->rx_ampdu_cnt;
+	data[ei++] = mib->rx_ampdu_bytes_cnt;
+	data[ei++] = mib->rx_ba_cnt;
+
+	mt7921_mutex_release(dev);
+
+	if (ei != ARRAY_SIZE(mt7921_gstrings_stats))
+		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %lu",
+			ei, ARRAY_SIZE(mt7921_gstrings_stats));
+}
+
 static u64
 mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
@@ -1230,6 +1343,9 @@ const struct ieee80211_ops mt7921_ops = {
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
 	.get_stats = mt7921_get_stats,
+	.get_et_sset_count = mt7921_get_et_sset_count,
+	.get_et_strings = mt7921_get_et_strings,
+	.get_et_stats = mt7921_get_et_stats,
 	.get_tsf = mt7921_get_tsf,
 	.set_tsf = mt7921_set_tsf,
 	.get_survey = mt76_get_survey,
-- 
2.31.1

