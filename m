Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF73E9A8A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhHKVqJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:46:09 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:41002 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232245AbhHKVp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:29 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.134])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1C35B1C0065
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:53 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E4E64BC0077
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 7330A13C340;
        Wed, 11 Aug 2021 14:44:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7330A13C340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718292;
        bh=lG22ctjjjubD0x90Wg+NHLFBSZMSC+d0oRjQACDTOW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECijYtidaXbrj1i0OkrvAaaBEO4/t+kU0FM7gAtySdPSaN9apKGWSQapb+LrOyexU
         EJ03J+hB6LXDWZ5kqNPS1BWpYkCy2Mc/p2Gs05JVcX+rtgv6PTF3FDhaFLg3jpxb+o
         osfcNn5uyuhc9Lbg52cCL33S+85hQZWsudSgz3uY=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 14/15] mt76: mt7915:  ethtool and mib rx stats
Date:   Wed, 11 Aug 2021 14:44:38 -0700
Message-Id: <20210811214439.17458-15-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718293-fj059OBXopZH
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add some new stats read from MIB registers, including
rx-mu-vht histogram data.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 45 ++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 77 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 12 +++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 47 +++++++++++
 4 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 44c76f7480f5..ba1c71bee149 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2139,7 +2139,7 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
 	bool ext_phy = phy != &dev->phy;
-	int i, aggr0, aggr1, cnt;
+	int i, q, aggr0, aggr1, cnt;
 
 	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
 					   MT_MIB_SDR3_FCS_ERR_MASK);
@@ -2212,6 +2212,26 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
 	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
 
+	cnt = mt76_rr(dev, MT_MIB_SDR38(ext_phy));
+	mib->tx_mgt_frame_cnt += FIELD_GET(MT_MIB_CTRL_TX_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR39(ext_phy));
+	mib->tx_mgt_frame_retry_cnt += FIELD_GET(MT_MIB_MGT_RETRY_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR40(ext_phy));
+	mib->tx_data_frame_retry_cnt += FIELD_GET(MT_MIB_DATA_RETRY_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR42(ext_phy));
+	mib->rx_partial_beacon_cnt += FIELD_GET(MT_MIB_RX_PARTIAL_BEACON_BSSID0, cnt);
+	mib->rx_partial_beacon_cnt += FIELD_GET(MT_MIB_RX_PARTIAL_BEACON_BSSID1, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR43(ext_phy));
+	mib->rx_partial_beacon_cnt += FIELD_GET(MT_MIB_RX_PARTIAL_BEACON_BSSID2, cnt);
+	mib->rx_partial_beacon_cnt += FIELD_GET(MT_MIB_RX_PARTIAL_BEACON_BSSID3, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR46(ext_phy));
+	mib->rx_oppo_ps_rx_dis_drop_cnt += FIELD_GET(MT_MIB_OPPO_PS_RX_DIS_DROP_COUNT, cnt);
+
 	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
 	mib->tx_mu_mpdu_cnt += cnt;
 
@@ -2267,6 +2287,29 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu_pack_stats); i++)
 		mib->tx_amsdu_pack_stats[i] += mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
 
+	cnt = mt76_rr(dev, MT_MIB_M0DROPSR00(ext_phy));
+	mib->tx_drop_rts_retry_fail_cnt += FIELD_GET(MT_MIB_RTS_RETRY_FAIL_DROP_MASK, cnt);
+	mib->tx_drop_mpdu_retry_fail_cnt += FIELD_GET(MT_MIB_RTS_RETRY_FAIL_DROP_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_M0DROPSR01(ext_phy));
+	mib->tx_drop_lto_limit_fail_cnt += FIELD_GET(MT_MIB_LTO_FAIL_DROP_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR50(ext_phy));
+	mib->tx_dbnss_cnt += FIELD_GET(MT_MIB_DBNSS_CNT_DROP_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR51(ext_phy));
+	mib->rx_fcs_ok_cnt += FIELD_GET(MT_MIB_RX_FCS_OK_MASK, cnt);
+
+	for (i = 0; i < 2; i++) {
+		for (q = 0; q < 10; q++) {
+			cnt = mt76_rr(dev, MT_MIB_VHT_RX_FCS_HISTOGRAM(ext_phy, i, q));
+			mib->rx_mu_fcs_ok_hist[i][q] +=
+				FIELD_GET(MT_MIB_VHT_RX_FCS_HIST_OK_MASK, cnt);
+			mib->rx_mu_fcs_err_hist[i][q] +=
+				FIELD_GET(MT_MIB_VHT_RX_FCS_HIST_ERR_MASK, cnt);
+		}
+	}
+
 }
 
 void mt7915_mac_sta_rc_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index fa9e3fd9bb4b..0c49b86c5058 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1081,6 +1081,13 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"tx_msdu_pack_6",
 	"tx_msdu_pack_7",
 	"tx_msdu_pack_8",
+	"tx_mgt_frame", /* SDR38, management frame tx counter */
+	"tx_mgt_frame_retry", /* SDR39, management frame retried counter */
+	"tx_data_frame_retry", /* SDR40, data frame retried counter */
+	"tx_drop_rts_retry_fail", /* TX Drop, RTS retries exhausted */
+	"tx_drop_mpdu_retry_fail", /* TX Drop, MPDU retries exhausted */
+	"tx_drop_lto_limit_fail", /* TX drop, Life Time Out limit reached. */
+	"tx_dbnss", /* pkts TX using double number of spatial streams */
 
 	/* rx counters */
 	"rx_fifo_full_cnt",
@@ -1097,6 +1104,54 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_pfdrop_cnt",
 	"rx_vec_queue_overflow_drop_cnt",
 	"rx_ba_cnt",
+	"rx_partial_beacon",
+	"rx_oppo_ps_rx_dis_drop",
+	"rx_fcs_ok",
+
+	/* rx MU VHT histogram */
+	"rx_mu_fcs_ok_nss1_mcs0",
+	"rx_mu_fcs_ok_nss1_mcs1",
+	"rx_mu_fcs_ok_nss1_mcs2",
+	"rx_mu_fcs_ok_nss1_mcs3",
+	"rx_mu_fcs_ok_nss1_mcs4",
+	"rx_mu_fcs_ok_nss1_mcs5",
+	"rx_mu_fcs_ok_nss1_mcs6",
+	"rx_mu_fcs_ok_nss1_mcs7",
+	"rx_mu_fcs_ok_nss1_mcs8",
+	"rx_mu_fcs_ok_nss1_mcs9",
+
+	"rx_mu_fcs_ok_nss2_mcs0",
+	"rx_mu_fcs_ok_nss2_mcs1",
+	"rx_mu_fcs_ok_nss2_mcs2",
+	"rx_mu_fcs_ok_nss2_mcs3",
+	"rx_mu_fcs_ok_nss2_mcs4",
+	"rx_mu_fcs_ok_nss2_mcs5",
+	"rx_mu_fcs_ok_nss2_mcs6",
+	"rx_mu_fcs_ok_nss2_mcs7",
+	"rx_mu_fcs_ok_nss2_mcs8",
+	"rx_mu_fcs_ok_nss2_mcs9",
+
+	"rx_mu_fcs_err_nss1_mcs0",
+	"rx_mu_fcs_err_nss1_mcs1",
+	"rx_mu_fcs_err_nss1_mcs2",
+	"rx_mu_fcs_err_nss1_mcs3",
+	"rx_mu_fcs_err_nss1_mcs4",
+	"rx_mu_fcs_err_nss1_mcs5",
+	"rx_mu_fcs_err_nss1_mcs6",
+	"rx_mu_fcs_err_nss1_mcs7",
+	"rx_mu_fcs_err_nss1_mcs8",
+	"rx_mu_fcs_err_nss1_mcs9",
+
+	"rx_mu_fcs_err_nss2_mcs0",
+	"rx_mu_fcs_err_nss2_mcs1",
+	"rx_mu_fcs_err_nss2_mcs2",
+	"rx_mu_fcs_err_nss2_mcs3",
+	"rx_mu_fcs_err_nss2_mcs4",
+	"rx_mu_fcs_err_nss2_mcs5",
+	"rx_mu_fcs_err_nss2_mcs6",
+	"rx_mu_fcs_err_nss2_mcs7",
+	"rx_mu_fcs_err_nss2_mcs8",
+	"rx_mu_fcs_err_nss2_mcs9",
 
 	/* driver rx counters */
 	"d_rx_skb",
@@ -1264,7 +1319,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
-	int i, n;
+	int i, n, q;
 	int ei = 0;
 
 	if (!phy)
@@ -1322,6 +1377,14 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	for (i = 0; i < 8; i++)
 		data[ei++] = mib->tx_amsdu_pack_stats[i];
 
+	data[ei++] = mib->tx_mgt_frame_cnt;
+	data[ei++] = mib->tx_mgt_frame_retry_cnt;
+	data[ei++] = mib->tx_data_frame_retry_cnt;
+	data[ei++] = mib->tx_drop_rts_retry_fail_cnt;
+	data[ei++] = mib->tx_drop_mpdu_retry_fail_cnt;
+	data[ei++] = mib->tx_drop_lto_limit_fail_cnt;
+	data[ei++] = mib->tx_dbnss_cnt;
+
 	/* rx counters */
 	data[ei++] = mib->rx_fifo_full_cnt; /* group-5 might exacerbate this */
 	data[ei++] = mib->rx_oor_cnt;
@@ -1337,6 +1400,18 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->rx_pfdrop_cnt;
 	data[ei++] = mib->rx_vec_queue_overflow_drop_cnt;
 	data[ei++] = mib->rx_ba_cnt;
+	data[ei++] = mib->rx_partial_beacon_cnt;
+	data[ei++] = mib->rx_oppo_ps_rx_dis_drop_cnt;
+	data[ei++] = mib->rx_fcs_ok_cnt;
+
+	for (i = 0; i < 2; i++) { /* for each nss */
+		for (q = 0; q < 10; q++) /* for each mcs */
+			data[ei++] = mib->rx_mu_fcs_ok_hist[i][q];
+	}
+	for (i = 0; i < 2; i++) { /* for each nss */
+		for (q = 0; q < 10; q++) /* for each mcs */
+			data[ei++] = mib->rx_mu_fcs_err_hist[i][q];
+	}
 
 	/* rx stats from driver */
 	data[ei++] = mib->rx_d_skb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 4515d42e5f74..34c8e7a3b317 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -165,6 +165,13 @@ struct mib_stats {
 	u32 tx_rwp_fail_cnt;
 	u32 tx_rwp_need_cnt;
 	u32 tx_amsdu_pack_stats[8]; /* histogram of how many sub-frames in amsdu */
+	u32 tx_mgt_frame_cnt;
+	u32 tx_mgt_frame_retry_cnt;
+	u32 tx_data_frame_retry_cnt;
+	u32 tx_drop_rts_retry_fail_cnt;
+	u32 tx_drop_mpdu_retry_fail_cnt;
+	u32 tx_drop_lto_limit_fail_cnt;
+	u32 tx_dbnss_cnt;
 
 	/* rx stats */
 	u32 rx_fifo_full_cnt;
@@ -181,6 +188,11 @@ struct mib_stats {
 	u32 rx_pfdrop_cnt;
 	u32 rx_vec_queue_overflow_drop_cnt;
 	u32 rx_ba_cnt;
+	u32 rx_partial_beacon_cnt;
+	u32 rx_oppo_ps_rx_dis_drop_cnt;
+	u32 rx_fcs_ok_cnt;
+	u32 rx_mu_fcs_ok_hist[2][10]; /* nss, mcs */
+	u32 rx_mu_fcs_err_hist[2][10]; /* nss, mcs */
 
 	/* rx stats from the driver */
 	u32 rx_d_skb; /* total skb received in rx path */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 6898cbe34470..8c559c78860b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -247,6 +247,29 @@
 
 /* 36, 37 both DNR */
 
+#define MT_MIB_SDR38(_band)		MT_WF_MIB(_band, 0x0d0)
+#define MT_MIB_CTRL_TX_CNT		GENMASK(23, 0)
+
+#define MT_MIB_SDR39(_band)		MT_WF_MIB(_band, 0x0d4)
+#define MT_MIB_MGT_RETRY_CNT		GENMASK(23, 0)
+
+#define MT_MIB_SDR40(_band)		MT_WF_MIB(_band, 0x0d8)
+#define MT_MIB_DATA_RETRY_CNT		GENMASK(23, 0)
+
+#define MT_MIB_SDR42(_band)		MT_WF_MIB(_band, 0x0e0)
+#define MT_MIB_RX_PARTIAL_BEACON_BSSID0	GENMASK(15, 0)
+#define MT_MIB_RX_PARTIAL_BEACON_BSSID1	GENMASK(31, 16)
+
+#define MT_MIB_SDR43(_band)		MT_WF_MIB(_band, 0x0e4)
+#define MT_MIB_RX_PARTIAL_BEACON_BSSID2	GENMASK(15, 0)
+#define MT_MIB_RX_PARTIAL_BEACON_BSSID3	GENMASK(31, 16)
+
+/* This counter shall increment when  PPDUs dropped by the oppo_ps_rx_dis
+ * mechanism
+ */
+#define MT_MIB_SDR46(_band)		MT_WF_MIB(_band, 0x0f0)
+#define MT_MIB_OPPO_PS_RX_DIS_DROP_COUNT GENMASK(15, 0)
+
 #define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
 #define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
 #define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
@@ -264,6 +287,30 @@
 #define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x4b8 + ((n) << 2))
 #define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
 
+/* drop due to retries being exhausted */
+#define MT_MIB_M0DROPSR00(_band)	MT_WF_MIB(_band, 0x190)
+#define MT_MIB_RTS_RETRY_FAIL_DROP_MASK	GENMASK(15, 0)
+#define MT_MIB_MPDU_RETRY_FAIL_DROP_MASK GENMASK(31, 16)
+
+/* life time out limit */
+#define MT_MIB_M0DROPSR01(_band)	MT_WF_MIB(_band, 0x194)
+#define MT_MIB_LTO_FAIL_DROP_MASK	GENMASK(15, 0)
+
+/* increment when using double number of spatial streams */
+#define MT_MIB_SDR50(_band)		MT_WF_MIB(_band, 0x1dc)
+#define MT_MIB_DBNSS_CNT_DROP_MASK	GENMASK(15, 0)
+
+/* NOTE:  Would need to poll this quickly since it is 16-bit */
+#define MT_MIB_SDR51(_band)		MT_WF_MIB(_band, 0x1e0)
+#define MT_MIB_RX_FCS_OK_MASK		GENMASK(15, 0)
+
+/* VHT MU rx fcs ok, fcs fail.  NSS: 0,1  MCS: 0..9  */
+#define MT_MIB_VHT_RX_FCS_HISTOGRAM_BASE_M0NSS1MCS0(_band)	MT_WF_MIB(_band, 0x400)
+#define MT_MIB_VHT_RX_FCS_HIST_OK_MASK	GENMASK(15, 0)
+#define MT_MIB_VHT_RX_FCS_HIST_ERR_MASK	GENMASK(31, 16)
+#define MT_MIB_VHT_RX_FCS_HISTOGRAM(_band, nss, mcs)			\
+	(MT_MIB_VHT_RX_FCS_HISTOGRAM_BASE_M0NSS1MCS0(_band) + (nss) * 4 + (mcs))
+
 #define MT_WTBLON_TOP_BASE		0x34000
 #define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
 #define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x0)
-- 
2.20.1

