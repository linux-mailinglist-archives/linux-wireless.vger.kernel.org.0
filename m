Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2AB6101036
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 01:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSA0n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 19:26:43 -0500
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:62767 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfKSA0n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 19:26:43 -0500
Received: from ironmsg02-tai.qualcomm.com ([10.249.140.7])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 19 Nov 2019 08:20:32 +0800
IronPort-SDR: RX/ihiP9o2KnMquE7FYZYGmZNpRCdbMr7OrYa7RACbVZ5YSg7W6kj+1FqgWrAacM8CNye5kOFM
 NuFTRYZVQFxkJGQyZrXojscLNwolP53Dw=
Received: from vento-sdc-01.ap.qualcomm.com (HELO vento-sdc-01.qualcomm.com) ([10.253.144.67])
  by ironmsg02-tai.qualcomm.com with ESMTP; 19 Nov 2019 08:20:29 +0800
Received: by vento-sdc-01.qualcomm.com (Postfix, from userid 0)
        id 828631A44; Tue, 19 Nov 2019 08:20:28 +0800 (CST)
From:   root <root@vento-sdc-01.qualcomm.com>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/2] ath10k: correct legacy rate in tx stats
Date:   Tue, 19 Nov 2019 08:20:28 +0800
Message-Id: <20191119002028.2519-3-root@vento-sdc-01.qualcomm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191119002028.2519-1-root@vento-sdc-01.qualcomm.com>
References: <20191119002028.2519-1-root@vento-sdc-01.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yu Wang <yyuwang@codeaurora.org>

When working in station mode, after connected to a legacy
AP, 11g only, for example, the tx bitrate is incorrect in
output of command 'iw wlan0 link'.

That's because the legacy tx bitrate value reported by
firmware is not well handled:
For QCA6174, the value represents rate index, but treated
as a real rate;
For QCA9888, the value is real rate, with unit 'Mbps', but
treated as '100kbps'.

To fix this issue:
1. Translate the rate index to real rate for QCA6174;
2. Translate the rate from 'Mbps' to 'kbps' for QCA9888.

Tested with:
QCA6174 PCIe with firmware WLAN.RM.4.4.1.c3-00031.
QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
QCA9888 PCIe with firmware 10.4-3.9.0.2-00040.

Signed-off-by: Yu Wang <yyuwang@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 83 +++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/mac.c    |  2 +-
 drivers/net/wireless/ath/ath10k/mac.h    |  1 +
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index cde2d9b..796c8c0 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3455,7 +3455,7 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ieee80211_chanctx_conf *conf = NULL;
 	u8 rate = 0, sgi;
-	s8 rate_idx = 0;
+	s8 rate_idx = -1;
 	bool skip_auto_rate;
 	struct rate_info txrate;
 
@@ -3497,6 +3497,12 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 		rate_idx = ath10k_get_legacy_rate_idx(ar, rate);
 		if (rate_idx < 0)
 			return;
+
+		/* from 1Mbps to 100Kbps */
+		rate = rate * 10;
+		if (rate == 50)
+			rate = 55;
+
 		arsta->txrate.legacy = rate;
 	} else if (txrate.flags == WMI_RATE_PREAMBLE_HT) {
 		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
@@ -3723,6 +3729,74 @@ static void ath10k_htt_rx_sec_ind_handler(struct ath10k *ar,
 	spin_unlock_bh(&ar->data_lock);
 }
 
+static int
+ath10k_htt_update_ratecode(struct ath10k *ar, struct ath10k_sta *arsta,
+			   u8 *ratecode)
+{
+	u8 hw_rate, preamble;
+	u16 bitrate;
+	int i;
+	const struct ieee80211_rate *bitrates;
+	bool cck;
+	struct ieee80211_chanctx_conf *conf = NULL;
+	enum nl80211_band band;
+	struct ieee80211_supported_band *sband;
+
+	if (!ratecode)
+		return -EINVAL;
+
+	/* only for legacy ratecode */
+	preamble = ATH10K_HW_PREAMBLE(*ratecode);
+	if (preamble != WMI_RATE_PREAMBLE_CCK &&
+	    preamble != WMI_RATE_PREAMBLE_OFDM)
+		return 0;
+
+	if (!arsta->arvif || !arsta->arvif->vif)
+		return -EINVAL;
+
+	WARN_ON(!rcu_read_lock_held());
+	conf = rcu_dereference(arsta->arvif->vif->chanctx_conf);
+	if (!conf)
+		return -EINVAL;
+
+	band = conf->def.chan->band;
+	sband = &ar->mac.sbands[band];
+	if (!sband->bitrates)
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(sband->n_bitrates > S8_MAX))
+		return -EINVAL;
+
+	cck = (preamble == WMI_RATE_PREAMBLE_CCK);
+	hw_rate = ATH10K_HW_LEGACY_RATE(*ratecode);
+	for (i = 0; i < sband->n_bitrates; i++) {
+		bitrates = &sband->bitrates[i];
+		if (ath10k_mac_bitrate_is_cck(bitrates->bitrate) != cck)
+			continue;
+
+		if (bitrates->hw_value == hw_rate ||
+		    (bitrates->flags & IEEE80211_RATE_SHORT_PREAMBLE &&
+		     bitrates->hw_value_short == hw_rate)) {
+			bitrate = bitrates->bitrate;
+
+			/* The bitrate will be recovered in
+			 * ath10k_update_per_peer_tx_stats().
+			 */
+			if (bitrate == 55)
+				bitrate = 60;
+
+			bitrate = bitrate / 10;
+
+			/* replace hw_value with bitrate in ratecode */
+			*ratecode = ATH10K_HW_RATECODE(bitrate, 0, preamble);
+			return 0;
+		}
+	}
+
+	ath10k_warn(ar, "Invalid legacy ratecode %hhd ppdu stats", *ratecode);
+	return -EINVAL;
+}
+
 static void
 ath10k_htt_process_ppdu_stats(struct ath10k *ar, struct sk_buff *skb)
 {
@@ -3734,6 +3808,7 @@ ath10k_htt_process_ppdu_stats(struct ath10k *ar, struct sk_buff *skb)
 	struct ath10k_peer *peer;
 	u32 peer_id, i;
 	u8 num_ppdu;
+	u8 ratecode;
 
 	num_ppdu = resp->ppdu_stats.num_ppdu;
 	tx_stats = &resp->ppdu_stats.tx_ppdu_stats[0];
@@ -3753,6 +3828,10 @@ ath10k_htt_process_ppdu_stats(struct ath10k *ar, struct sk_buff *skb)
 	for (i = 0; i < num_ppdu; i++) {
 		tx_stats = &resp->ppdu_stats.tx_ppdu_stats[i];
 		arsta = (struct ath10k_sta *)sta->drv_priv;
+		ratecode = tx_stats->tx_ratecode;
+
+		if (ath10k_htt_update_ratecode(ar, arsta, &ratecode))
+			goto err;
 
 		p_tx_stats->succ_bytes =
 			__le32_to_cpu(tx_stats->tx_success_bytes);
@@ -3760,7 +3839,7 @@ ath10k_htt_process_ppdu_stats(struct ath10k *ar, struct sk_buff *skb)
 			__le32_to_cpu(tx_stats->tx_retry_bytes);
 		p_tx_stats->failed_bytes =
 			__le32_to_cpu(tx_stats->tx_failed_bytes);
-		p_tx_stats->ratecode = tx_stats->tx_ratecode;
+		p_tx_stats->ratecode = ratecode;
 		p_tx_stats->flags = tx_stats->flags;
 		p_tx_stats->succ_pkts =
 			__le16_to_cpu(tx_stats->tx_success_msdus);
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 83cc877..95a5069 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -94,7 +94,7 @@ static struct ieee80211_rate ath10k_rates_rev2[] = {
 
 #define ath10k_wmi_legacy_rates ath10k_rates
 
-static bool ath10k_mac_bitrate_is_cck(int bitrate)
+bool ath10k_mac_bitrate_is_cck(int bitrate)
 {
 	switch (bitrate) {
 	case 10:
diff --git a/drivers/net/wireless/ath/ath10k/mac.h b/drivers/net/wireless/ath/ath10k/mac.h
index 98d83a2..cc245b1 100644
--- a/drivers/net/wireless/ath/ath10k/mac.h
+++ b/drivers/net/wireless/ath/ath10k/mac.h
@@ -28,6 +28,7 @@ struct rfc1042_hdr {
 	__be16 snap_type;
 } __packed;
 
+bool ath10k_mac_bitrate_is_cck(int bitrate);
 struct ath10k *ath10k_mac_create(size_t priv_size);
 void ath10k_mac_destroy(struct ath10k *ar);
 int ath10k_mac_register(struct ath10k *ar);
-- 
2.7.4

