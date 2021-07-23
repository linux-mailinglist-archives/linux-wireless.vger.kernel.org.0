Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5E3D3CBA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhGWPGJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:06:09 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:41682 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235595AbhGWPGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:06:05 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DF0A5A0068
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A4FC43C007E
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 29E8213C2B7;
        Fri, 23 Jul 2021 08:46:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 29E8213C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627055197;
        bh=NXp/zMSljHZJNF8bzNl9VtGOTcKivNtovadz6MH8B24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jK1LclaYQvr5tDC6dp1rY7XB9Z44nV4UOx6kZemSJCjSXcb7TeP5HCUdPixsWzrs4
         d7CyRhnerf9aM7HcXth3HE8n+HcGB7PddHLzQg3Bw5bT9DBZztiQjUPa0EpkHcWqQU
         E8W6UCLOPYGKKmjh/l6lnbTqgV2p3xtkjDAYbiCk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v4 5/8] mt76 - mt7915: Move more tx-bf stats to mib.
Date:   Fri, 23 Jul 2021 08:46:24 -0700
Message-Id: <20210723154627.10078-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723154627.10078-1-greearb@candelatech.com>
References: <20210723154627.10078-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627055198-JywyeaFglP_F
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

These are clear-on-read, so accumulate them in the update_stats
polling method, then access them via the mib structure
when reading them from debugfs/ethtool.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 44 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 19 ++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 28 +++++-------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 15 +++++++
 4 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 35248d182728..91664ac63a8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -146,46 +146,42 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 static void
 mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 {
-	struct mt7915_dev *dev = s->private;
-	bool ext_phy = phy != &dev->phy;
 	static const char * const bw[] = {
 		"BW20", "BW40", "BW80", "BW160"
 	};
-	int cnt;
-	struct mib_stats *mib = &phy->mib;
+	struct mib_stats *mib;
 
 	if (!phy)
 		return;
 
+	mib = &phy->mib;
+
 	/* Tx Beamformer monitor */
 	seq_puts(s, "\nTx Beamformer applied PPDU counts: ");
 
-	cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
-	seq_printf(s, "iBF: %ld, eBF: %ld\n",
-		   FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt),
-		   FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt));
+	seq_printf(s, "iBF: %d, eBF: %d\n",
+		   mib->tx_bf_ibf_ppdu_cnt,
+		   mib->tx_bf_ebf_ppdu_cnt);
 
 	/* Tx Beamformer Rx feedback monitor */
 	seq_puts(s, "Tx Beamformer Rx feedback statistics: ");
 
-	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
-	seq_printf(s, "All: %ld, HE: %ld, VHT: %ld, HT: %ld, ",
-		   FIELD_GET(MT_ETBF_RX_FB_ALL, cnt),
-		   FIELD_GET(MT_ETBF_RX_FB_HE, cnt),
-		   FIELD_GET(MT_ETBF_RX_FB_VHT, cnt),
-		   FIELD_GET(MT_ETBF_RX_FB_HT, cnt));
-	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
-	seq_printf(s, "%s, NC: %ld, NR: %ld\n",
-		   bw[FIELD_GET(MT_ETBF_RX_FB_BW, cnt)],
-		   FIELD_GET(MT_ETBF_RX_FB_NC, cnt),
-		   FIELD_GET(MT_ETBF_RX_FB_NR, cnt));
+	seq_printf(s, "All: %d, HE: %d, VHT: %d, HT: %d, ",
+		   mib->tx_bf_rx_fb_all_cnt,
+		   mib->tx_bf_rx_fb_he_cnt,
+		   mib->tx_bf_rx_fb_vht_cnt,
+		   mib->tx_bf_rx_fb_ht_cnt);
+
+	seq_printf(s, "%s, NC: %d, NR: %d\n",
+		   bw[mib->tx_bf_rx_fb_bw],
+		   mib->tx_bf_rx_fb_nc_cnt,
+		   mib->tx_bf_rx_fb_nr_cnt);
 
 	/* Tx Beamformee Rx NDPA & Tx feedback report */
-	cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
-	seq_printf(s, "Tx Beamformee successful feedback frames: %ld\n",
-		   FIELD_GET(MT_ETBF_TX_FB_CPL, cnt));
-	seq_printf(s, "Tx Beamformee feedback triggered counts: %ld\n",
-		   FIELD_GET(MT_ETBF_TX_FB_TRI, cnt));
+	seq_printf(s, "Tx Beamformee successful feedback frames: %d\n",
+		   mib->tx_bf_fb_cpl_cnt);
+	seq_printf(s, "Tx Beamformee feedback triggered counts: %d\n",
+		   mib->tx_bf_fb_trig_cnt);
 
 	/* Tx SU & MU counters */
 	seq_printf(s, "Tx multi-user Beamforming counts: %d\n",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 064d754e0565..c395600b378a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1906,6 +1906,25 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
 	mib->tx_su_acked_mpdu_cnt += cnt;
 
+	cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
+	mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
+	mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
+	mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
+	mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
+	mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
+	mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
+
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
+	mib->tx_bf_rx_fb_bw = FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
+	mib->tx_bf_rx_fb_nc_cnt += FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
+	mib->tx_bf_rx_fb_nr_cnt += FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
+
+	cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
+	mib->tx_bf_fb_cpl_cnt += FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
+	mib->tx_bf_fb_trig_cnt += FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
+
 	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
 		u32 val;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index be6444650afe..885e35bf0fe8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1135,7 +1135,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
-	int i, j, n, cnt, next_ei;
+	int i, j, n, next_ei;
 	int ei = 0;
 
 	if (!phy)
@@ -1149,26 +1149,22 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = phy->mib.ba_miss_cnt;
 
 	/* Tx Beamformer monitor */
-	cnt = mt76_rr(dev, MT_ETBF_TX_APP_CNT(ext_phy));
-	data[ei++] = FIELD_GET(MT_ETBF_TX_IBF_CNT, cnt);
-	data[ei++] = FIELD_GET(MT_ETBF_TX_EBF_CNT, cnt);
+	data[ei++] = mib->tx_bf_ibf_ppdu_cnt;
+	data[ei++] = mib->tx_bf_ebf_ppdu_cnt;
 
 	/* Tx Beamformer Rx feedback monitor */
-	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
-	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_ALL, cnt);
-	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_HE, cnt);
-	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_VHT, cnt);
-	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_HT, cnt);
+	data[ei++] = mib->tx_bf_rx_fb_all_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_he_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_vht_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_ht_cnt;
 
-	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
-	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_BW, cnt);
-	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_NC, cnt);
-	data[ei++] = FIELD_GET(MT_ETBF_RX_FB_NR, cnt);
+	data[ei++] = mib->tx_bf_rx_fb_bw;
+	data[ei++] = mib->tx_bf_rx_fb_nc_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_nr_cnt;
 
 	/* Tx Beamformee Rx NDPA & Tx feedback report */
-	cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
-	data[ei++] = FIELD_GET(MT_ETBF_TX_FB_CPL, cnt);
-	data[ei++] = FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
+	data[ei++] = mib->tx_bf_fb_cpl_cnt;
+	data[ei++] = mib->tx_bf_fb_trig_cnt;
 
 	/* Tx SU & MU counters */
 	data[ei++] = mib->tx_bf_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 26f2befc46dd..565766debb5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -110,6 +110,7 @@ struct mt7915_vif {
 	struct cfg80211_bitrate_mask bitrate_mask;
 };
 
+/* per-phy stats.  */
 struct mib_stats {
 	u32 ack_fail_cnt;
 	u32 fcs_err_cnt;
@@ -120,6 +121,20 @@ struct mib_stats {
 	u32 tx_mu_mpdu_cnt;
 	u32 tx_mu_acked_mpdu_cnt;
 	u32 tx_su_acked_mpdu_cnt;
+	u32 tx_bf_ibf_ppdu_cnt;
+	u32 tx_bf_ebf_ppdu_cnt;
+
+	u32 tx_bf_rx_fb_all_cnt;
+	u32 tx_bf_rx_fb_he_cnt;
+	u32 tx_bf_rx_fb_vht_cnt;
+	u32 tx_bf_rx_fb_ht_cnt;
+
+	u32 tx_bf_rx_fb_bw; /* value of last sample, not cumulative */
+	u32 tx_bf_rx_fb_nc_cnt;
+	u32 tx_bf_rx_fb_nr_cnt;
+	u32 tx_bf_fb_cpl_cnt;
+	u32 tx_bf_fb_trig_cnt;
+
 	/* Add more stats here, updated from mac_update_stats */
 };
 
-- 
2.20.1

