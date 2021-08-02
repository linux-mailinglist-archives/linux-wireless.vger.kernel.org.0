Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0203DDBEE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 17:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhHBPIk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 11:08:40 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:43738 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234833AbhHBPIe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 11:08:34 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1F9CE2006A
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:08:19 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D9CF53C006D
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:08:18 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6ECC513C2B7;
        Mon,  2 Aug 2021 08:08:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6ECC513C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627916898;
        bh=Qq4uG+yQF5enjKGtIbsOU7aFZUZ6fvUcc2Iwv2J/Swc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buDRUAkcAiHg6KQ1EJYHtKli2MU54JY5k3vnTFumfziyFPaLfviIqdwA7qrXVYlYj
         DaoULSlbWPXXZ0PjENb5lGTZkYps45mbAmg1omM87NPqgGaugs4b2JRYLYR+wQthFp
         QcsoshU+k3HELCJYIzRCcS6LggzfYoprlTs0kCHg=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v6 4/7] mt76: mt7915: add tx mu/su counters to mib
Date:   Mon,  2 Aug 2021 08:08:05 -0700
Message-Id: <20210802150808.30113-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802150808.30113-1-greearb@candelatech.com>
References: <20210802150808.30113-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627916899-0JMhAeEgeXiO
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

These counters are clear-on-read, so we need to accumulate
them in the update_stats poll logic, and read the accumulated
values instead of directly doing register reads when reporting
to debugfs and ethtool stats.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 59 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 32 +++++++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 44 ++++++--------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 19 ++++++
 4 files changed, 94 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 1a48b09d0cb7..91664ac63a8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -146,56 +146,51 @@ mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 static void
 mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 {
-	struct mt7915_dev *dev = s->private;
-	bool ext_phy = phy != &dev->phy;
 	static const char * const bw[] = {
 		"BW20", "BW40", "BW80", "BW160"
 	};
-	int cnt;
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
-	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
-	seq_printf(s, "Tx multi-user Beamforming counts: %ld\n",
-		   FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt));
-	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
-	seq_printf(s, "Tx multi-user MPDU counts: %d\n", cnt);
-	cnt = mt76_rr(dev, MT_MIB_DR9(ext_phy));
-	seq_printf(s, "Tx multi-user successful MPDU counts: %d\n", cnt);
-	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
-	seq_printf(s, "Tx single-user successful MPDU counts: %d\n", cnt);
+	seq_printf(s, "Tx multi-user Beamforming counts: %d\n",
+		   mib->tx_bf_cnt);
+	seq_printf(s, "Tx multi-user MPDU counts: %d\n", mib->tx_mu_mpdu_cnt);
+	seq_printf(s, "Tx multi-user successful MPDU counts: %d\n",
+		   mib->tx_mu_acked_mpdu_cnt);
+	seq_printf(s, "Tx single-user successful MPDU counts: %d\n",
+		   mib->tx_su_acked_mpdu_cnt);
 
 	seq_puts(s, "\n");
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6f445999e516..c395600b378a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1890,10 +1890,40 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
 	bool ext_phy = phy != &dev->phy;
-	int i, aggr0, aggr1;
+	int i, aggr0, aggr1, cnt;
 
 	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
 					   MT_MIB_SDR3_FCS_ERR_MASK);
+	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
+	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
+	mib->tx_mu_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_DR9(ext_phy));
+	mib->tx_mu_acked_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
+	mib->tx_su_acked_mpdu_cnt += cnt;
+
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
 
 	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 88a8547e2e7f..c9806a4c57ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1175,10 +1175,11 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_ethtool_worker_info wi;
+	struct mib_stats *mib = &phy->mib;
 
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
-	int i, n, cnt;
+	int i, n;
 	int ei = 0;
 
 	if (!phy)
@@ -1192,39 +1193,28 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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
-	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
-	data[ei++] = FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
-
-	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
-	data[ei++] = cnt;
-
-	cnt = mt76_rr(dev, MT_MIB_DR9(ext_phy));
-	data[ei++] = cnt; /* MU MPDU SUccessful */
-
-	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
-	data[ei++] = cnt; /* SU MPDU successful */
+	data[ei++] = mib->tx_bf_cnt;
+	data[ei++] = mib->tx_mu_mpdu_cnt;
+	data[ei++] = mib->tx_mu_acked_mpdu_cnt;
+	data[ei++] = mib->tx_su_acked_mpdu_cnt;
 
 	/* TODO:  External phy too?? */
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index a8617ba69a21..565766debb5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -110,12 +110,31 @@ struct mt7915_vif {
 	struct cfg80211_bitrate_mask bitrate_mask;
 };
 
+/* per-phy stats.  */
 struct mib_stats {
 	u32 ack_fail_cnt;
 	u32 fcs_err_cnt;
 	u32 rts_cnt;
 	u32 rts_retries_cnt;
 	u32 ba_miss_cnt;
+	u32 tx_bf_cnt;
+	u32 tx_mu_mpdu_cnt;
+	u32 tx_mu_acked_mpdu_cnt;
+	u32 tx_su_acked_mpdu_cnt;
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

