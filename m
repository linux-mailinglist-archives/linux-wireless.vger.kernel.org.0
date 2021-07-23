Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02EE3D3CB9
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhGWPGI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:06:08 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:42012 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235591AbhGWPGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:06:05 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.129])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 51D991C0069
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 26E9550007F
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6EEE613C2B1;
        Fri, 23 Jul 2021 08:46:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6EEE613C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627055196;
        bh=MEmLF8Jh8EKquxReqyGP9MwmyZuDkVv5mzlWcw0ZXD0=;
        h=From:To:Cc:Subject:Date:From;
        b=chSoewXT8+OKviTuoeaMYaSfbs0bSfQTmOiLjJCTEwCT3H5KIcGyjBSYXhv2RACgl
         10+nVgXDa6AGvELbe2J51gdA1YuzaqTagGLbaTpr2p9GogioNJm6aUZNju0/3gn3qm
         ml5Jjt9bZ8TopokOm6j6q2+FHgjNXgKT+KzI+Qjs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v4 1/8] mt76 - mt7915: Add ethtool stats support.
Date:   Fri, 23 Jul 2021 08:46:20 -0700
Message-Id: <20210723154627.10078-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627055197-fUv5cbOXt9XD
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This exposes some tx-path stats to the ethtool API, so that
ethtool -S wlanX provides some more useful info.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 
v4: move ethtool code to main.c
  Re-work the 2/8 patch per review.
  Did not try to refactor the station walk per comments on 3/8, I saw
  no clean way to do that.

.../net/wireless/mediatek/mt76/mt7915/main.c  | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 48b5e2051bad..d0288fe2abdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1028,6 +1028,139 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 	mt7915_mcu_sta_update_hdr_trans(dev, vif, sta);
 }
 
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
+void mt7915_get_et_strings(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif,
+			   u32 sset, u8 *data)
+{
+	if (sset == ETH_SS_STATS)
+		memcpy(data, *mt7915_gstrings_stats,
+		       sizeof(mt7915_gstrings_stats));
+}
+
+int mt7915_get_et_sset_count(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif, int sset)
+{
+	if (sset == ETH_SS_STATS)
+		return MT7915_SSTATS_LEN;
+
+	return 0;
+}
+
+void mt7915_get_et_stats(struct ieee80211_hw *hw,
+			 struct ieee80211_vif *vif,
+			 struct ethtool_stats *stats, u64 *data)
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
 const struct ieee80211_ops mt7915_ops = {
 	.tx = mt7915_tx,
 	.start = mt7915_start,
@@ -1052,6 +1185,9 @@ const struct ieee80211_ops mt7915_ops = {
 	.get_txpower = mt76_get_txpower,
 	.channel_switch_beacon = mt7915_channel_switch_beacon,
 	.get_stats = mt7915_get_stats,
+	.get_et_sset_count = mt7915_get_et_sset_count,
+	.get_et_stats = mt7915_get_et_stats,
+	.get_et_strings = mt7915_get_et_strings,
 	.get_tsf = mt7915_get_tsf,
 	.set_tsf = mt7915_set_tsf,
 	.offset_tsf = mt7915_offset_tsf,
-- 
2.20.1

