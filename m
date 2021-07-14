Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604313C933F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 23:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhGNVrb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 17:47:31 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:52670 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhGNVrb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 17:47:31 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 35187A0068
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:38 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F08883C0068
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:37 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5C33613C2B1;
        Wed, 14 Jul 2021 14:44:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5C33613C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626299077;
        bh=llrxTKstxoB/Srx3nsoU+2zeq3b0XhABcrDX86NK1lQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gVaH6Gb8E7dYbBSgsZgEXTuSTa4ym4gzhB8D8kdqOV10Zdi7G/4m0BBc4MnAhSjKe
         QdXfmsYgEoJE9ECFpeXFACcnUBPnQyMs/q85m8+4IYIjKS+EXmGm/Wk0+86ZCAl4cA
         7hYeJ7QgbfD5XUBuLMPlHQe7hJNyHAyPaTwzlXBg=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 1/8] mt76 - mt7915: Add ethtool stats support.
Date:   Wed, 14 Jul 2021 14:44:25 -0700
Message-Id: <20210714214432.15162-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626299078-EjGeDiPNEJvU
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This exposes some tx-path stats to the ethtool API, so that
ethtool -S wlanX provides some more useful info.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 135 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   3 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  12 ++
 3 files changed, 150 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 1a48b09d0cb7..469028d641c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -382,4 +382,139 @@ void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
 }
+
 #endif
+
+static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
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
+	"tx_beamformer_rx_feedback_bw", /* zero based idx: 20, 40, 80, 160 */
+	"tx_beamformer_rx_feedback_nc",
+	"tx_beamformer_rx_feedback_nr",
+	"tx_beamformee_ok_feedback_pkts",
+	"tx_beamformee_feedback_trig",
+	"tx_mu_beamforming",
+	"tx_mu_mpdu",
+	"tx_mu_successful_mpdu",
+	"tx_su_successful_mpdu",
+	"tx_msdu_pack_1",
+	"tx_msdu_pack_2",
+	"tx_msdu_pack_3",
+	"tx_msdu_pack_4",
+	"tx_msdu_pack_5",
+	"tx_msdu_pack_6",
+	"tx_msdu_pack_7",
+	"tx_msdu_pack_8",
+};
+
+#define MT7915_SSTATS_LEN ARRAY_SIZE(mt7915_gstrings_stats)
+
+/* Ethtool related API */
+void mt7915_debug_get_et_strings(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 u32 sset, u8 *data)
+{
+	if (sset == ETH_SS_STATS)
+		memcpy(data, *mt7915_gstrings_stats,
+		       sizeof(mt7915_gstrings_stats));
+}
+
+int mt7915_debug_get_et_sset_count(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif, int sset)
+{
+	if (sset == ETH_SS_STATS)
+		return MT7915_SSTATS_LEN;
+
+	return 0;
+}
+
+void mt7915_debug_get_et_stats(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ethtool_stats *stats, u64 *data)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+
+	/* TODO:  These are mostly dev-wide stats at this point.
+	 *  Get some per-vif stats?
+	 */
+
+	/* See mt7915_ampdu_stat_read_phy, etc */
+	bool ext_phy = phy != &dev->phy;
+	int i, n, cnt;
+	int ei = 0;
+
+	if (!phy)
+		return;
+
+	/* Tx ampdu stat */
+	n = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
+	for (i = 0; i < 15 /*ARRAY_SIZE(bound)*/; i++)
+		data[ei++] = dev->mt76.aggr_stats[i + n];
+
+	data[ei++] = phy->mib.ba_miss_cnt;
+
+	/* Tx Beamformer monitor */
+	cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
+	data[ei++] = FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
+	data[ei++] = FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
+
+	/* Tx Beamformer Rx feedback monitor */
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
+	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
+	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
+	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
+	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
+
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
+	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
+	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
+	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
+
+	/* Tx Beamformee Rx NDPA & Tx feedback report */
+	cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
+	data[ei++] = FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
+	data[ei++] = FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
+
+	/* Tx SU & MU counters */
+	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
+	data[ei++] = FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
+	data[ei++] = cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_DR9(ext_phy));
+	data[ei++] = cnt; /* MU MPDU SUccessful */
+
+	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
+	data[ei++] = cnt; /* SU MPDU successful */
+
+	/* TODO:  External phy too?? */
+
+	/* Tx amsdu info (pack-count histogram) */
+	for (i = 0; i < 8; i++)
+		data[ei++] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+
+	WARN_ON(ei != MT7915_SSTATS_LEN);
+}
+
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 48b5e2051bad..ed94e3c3c51d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1052,6 +1052,9 @@ const struct ieee80211_ops mt7915_ops = {
 	.get_txpower = mt76_get_txpower,
 	.channel_switch_beacon = mt7915_channel_switch_beacon,
 	.get_stats = mt7915_get_stats,
+	.get_et_sset_count = mt7915_debug_get_et_sset_count,
+	.get_et_stats = mt7915_debug_get_et_stats,
+	.get_et_strings = mt7915_debug_get_et_strings,
 	.get_tsf = mt7915_get_tsf,
 	.set_tsf = mt7915_set_tsf,
 	.offset_tsf = mt7915_offset_tsf,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 33be449309e0..a3c78365db23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -419,4 +419,16 @@ void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
 #endif
 
+/* Ethtool API, implementation found in debugfs.c */
+void mt7915_debug_get_et_strings(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 u32 sset, u8 *data);
+
+int mt7915_debug_get_et_sset_count(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif, int sset);
+
+void mt7915_debug_get_et_stats(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ethtool_stats *stats, u64 *data);
+
 #endif
-- 
2.20.1

