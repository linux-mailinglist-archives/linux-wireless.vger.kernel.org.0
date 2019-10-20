Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2EADDDA5
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfJTKEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:04:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfJTKEt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:04:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C8C260FB9; Sun, 20 Oct 2019 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565886;
        bh=g/jDisnRtGX70xBui3w3bkaqNUY+waURf3s9NoaQQTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLNk/qZy7rDsFdykW76c0jpKuKwcNK/dJy2Yv4A6uX0ir93uckE6BBh2kwX6ln2V1
         BYelj5ywX0LuyCxWEBwQA3gr/EHOV/N+woXWFxWtbkBFUsN0k0KTrmuwoBYkLmkR5s
         SHGTeI9Rx6h+XG72Yl5K/gGQsk/wQLy+sptsihKo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 199BA61019;
        Sun, 20 Oct 2019 10:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565881;
        bh=g/jDisnRtGX70xBui3w3bkaqNUY+waURf3s9NoaQQTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/dntgJRHNgkSnUwTlT4SOC+BROCUUWWiElfIzfB32h5p6UqYuf8VmrdLISE5CiXn
         H/MjffoKUCLbiJYNHz8PTD0DgRQNLCiTS71WrZw1x+7Y08/cYaVq5udPMKvZfdYdTd
         aILjmVAo/FiYq3SOpiQL9Dv98lj3M9+shjkryv4c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 199BA61019
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 14/49] ath11k: add debugfs_sta.c
Date:   Sun, 20 Oct 2019 13:03:32 +0300
Message-Id: <1571565847-10338-15-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 538 ++++++++++++++++++++++++++
 1 file changed, 538 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
new file mode 100644
index 000000000000..b392117eff3c
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/vmalloc.h>
+
+#include "core.h"
+#include "peer.h"
+#include "debug.h"
+
+void
+ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
+				    struct ath11k_per_peer_tx_stats *peer_stats,
+				    u8 legacy_rate_idx)
+{
+	struct rate_info *txrate = &arsta->txrate;
+	struct ath11k_htt_tx_stats *tx_stats;
+	int gi, mcs, bw, nss;
+
+	if (!arsta->tx_stats)
+		return;
+
+	tx_stats = arsta->tx_stats;
+	gi = FIELD_GET(RATE_INFO_FLAGS_SHORT_GI, arsta->txrate.flags);
+	mcs = txrate->mcs;
+	bw = txrate->bw;
+	nss = txrate->nss - 1;
+
+#define STATS_OP_FMT(name) tx_stats->stats[ATH11K_STATS_TYPE_##name]
+
+	if (txrate->flags & RATE_INFO_FLAGS_HE_MCS) {
+		STATS_OP_FMT(SUCC).he[0][mcs] += peer_stats->succ_bytes;
+		STATS_OP_FMT(SUCC).he[1][mcs] += peer_stats->succ_pkts;
+		STATS_OP_FMT(FAIL).he[0][mcs] += peer_stats->failed_bytes;
+		STATS_OP_FMT(FAIL).he[1][mcs] += peer_stats->failed_pkts;
+		STATS_OP_FMT(RETRY).he[0][mcs] += peer_stats->retry_bytes;
+		STATS_OP_FMT(RETRY).he[1][mcs] += peer_stats->retry_pkts;
+	} else if (txrate->flags & RATE_INFO_FLAGS_VHT_MCS) {
+		STATS_OP_FMT(SUCC).vht[0][mcs] += peer_stats->succ_bytes;
+		STATS_OP_FMT(SUCC).vht[1][mcs] += peer_stats->succ_pkts;
+		STATS_OP_FMT(FAIL).vht[0][mcs] += peer_stats->failed_bytes;
+		STATS_OP_FMT(FAIL).vht[1][mcs] += peer_stats->failed_pkts;
+		STATS_OP_FMT(RETRY).vht[0][mcs] += peer_stats->retry_bytes;
+		STATS_OP_FMT(RETRY).vht[1][mcs] += peer_stats->retry_pkts;
+	} else if (txrate->flags & RATE_INFO_FLAGS_MCS) {
+		STATS_OP_FMT(SUCC).ht[0][mcs] += peer_stats->succ_bytes;
+		STATS_OP_FMT(SUCC).ht[1][mcs] += peer_stats->succ_pkts;
+		STATS_OP_FMT(FAIL).ht[0][mcs] += peer_stats->failed_bytes;
+		STATS_OP_FMT(FAIL).ht[1][mcs] += peer_stats->failed_pkts;
+		STATS_OP_FMT(RETRY).ht[0][mcs] += peer_stats->retry_bytes;
+		STATS_OP_FMT(RETRY).ht[1][mcs] += peer_stats->retry_pkts;
+	} else {
+		mcs = legacy_rate_idx;
+
+		STATS_OP_FMT(SUCC).legacy[0][mcs] += peer_stats->succ_bytes;
+		STATS_OP_FMT(SUCC).legacy[1][mcs] += peer_stats->succ_pkts;
+		STATS_OP_FMT(FAIL).legacy[0][mcs] += peer_stats->failed_bytes;
+		STATS_OP_FMT(FAIL).legacy[1][mcs] += peer_stats->failed_pkts;
+		STATS_OP_FMT(RETRY).legacy[0][mcs] += peer_stats->retry_bytes;
+		STATS_OP_FMT(RETRY).legacy[1][mcs] += peer_stats->retry_pkts;
+	}
+
+	if (peer_stats->is_ampdu) {
+		tx_stats->ba_fails += peer_stats->ba_fails;
+
+		if (txrate->flags & RATE_INFO_FLAGS_HE_MCS) {
+			STATS_OP_FMT(AMPDU).he[0][mcs] +=
+			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			STATS_OP_FMT(AMPDU).he[1][mcs] +=
+			peer_stats->succ_pkts + peer_stats->retry_pkts;
+		} else if (txrate->flags & RATE_INFO_FLAGS_MCS) {
+			STATS_OP_FMT(AMPDU).ht[0][mcs] +=
+			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			STATS_OP_FMT(AMPDU).ht[1][mcs] +=
+			peer_stats->succ_pkts + peer_stats->retry_pkts;
+		} else {
+			STATS_OP_FMT(AMPDU).vht[0][mcs] +=
+			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			STATS_OP_FMT(AMPDU).vht[1][mcs] +=
+			peer_stats->succ_pkts + peer_stats->retry_pkts;
+		}
+		STATS_OP_FMT(AMPDU).bw[0][bw] +=
+			peer_stats->succ_bytes + peer_stats->retry_bytes;
+		STATS_OP_FMT(AMPDU).nss[0][nss] +=
+			peer_stats->succ_bytes + peer_stats->retry_bytes;
+		STATS_OP_FMT(AMPDU).gi[0][gi] +=
+			peer_stats->succ_bytes + peer_stats->retry_bytes;
+		STATS_OP_FMT(AMPDU).bw[1][bw] +=
+			peer_stats->succ_pkts + peer_stats->retry_pkts;
+		STATS_OP_FMT(AMPDU).nss[1][nss] +=
+			peer_stats->succ_pkts + peer_stats->retry_pkts;
+		STATS_OP_FMT(AMPDU).gi[1][gi] +=
+			peer_stats->succ_pkts + peer_stats->retry_pkts;
+	} else {
+		tx_stats->ack_fails += peer_stats->ba_fails;
+	}
+
+	STATS_OP_FMT(SUCC).bw[0][bw] += peer_stats->succ_bytes;
+	STATS_OP_FMT(SUCC).nss[0][nss] += peer_stats->succ_bytes;
+	STATS_OP_FMT(SUCC).gi[0][gi] += peer_stats->succ_bytes;
+
+	STATS_OP_FMT(SUCC).bw[1][bw] += peer_stats->succ_pkts;
+	STATS_OP_FMT(SUCC).nss[1][nss] += peer_stats->succ_pkts;
+	STATS_OP_FMT(SUCC).gi[1][gi] += peer_stats->succ_pkts;
+
+	STATS_OP_FMT(FAIL).bw[0][bw] += peer_stats->failed_bytes;
+	STATS_OP_FMT(FAIL).nss[0][nss] += peer_stats->failed_bytes;
+	STATS_OP_FMT(FAIL).gi[0][gi] += peer_stats->failed_bytes;
+
+	STATS_OP_FMT(FAIL).bw[1][bw] += peer_stats->failed_pkts;
+	STATS_OP_FMT(FAIL).nss[1][nss] += peer_stats->failed_pkts;
+	STATS_OP_FMT(FAIL).gi[1][gi] += peer_stats->failed_pkts;
+
+	STATS_OP_FMT(RETRY).bw[0][bw] += peer_stats->retry_bytes;
+	STATS_OP_FMT(RETRY).nss[0][nss] += peer_stats->retry_bytes;
+	STATS_OP_FMT(RETRY).gi[0][gi] += peer_stats->retry_bytes;
+
+	STATS_OP_FMT(RETRY).bw[1][bw] += peer_stats->retry_pkts;
+	STATS_OP_FMT(RETRY).nss[1][nss] += peer_stats->retry_pkts;
+	STATS_OP_FMT(RETRY).gi[1][gi] += peer_stats->retry_pkts;
+
+	tx_stats->tx_duration += peer_stats->duration;
+}
+
+void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
+					       struct sk_buff *msdu,
+					       struct hal_tx_status *ts)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
+	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
+	struct ieee80211_sta *sta;
+	u16 rate;
+	u8 rate_idx;
+	int ret;
+
+	rcu_read_lock();
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath11k_warn(ab, "failed to find the peer\n");
+		spin_unlock_bh(&ab->base_lock);
+		rcu_read_unlock();
+		return;
+	}
+
+	sta = peer->sta;
+	arsta = (struct ath11k_sta *)sta->drv_priv;
+
+	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
+
+	if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
+	    ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
+		ret = ath11k_mac_hw_ratecode_to_legacy_rate(ts->mcs,
+							    ts->pkt_type,
+							    &rate_idx,
+							    &rate);
+		if (ret < 0) {
+			spin_unlock_bh(&ab->base_lock);
+			rcu_read_unlock();
+			return;
+		}
+		arsta->txrate.legacy = rate;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
+		if (ts->mcs > 7) {
+			ath11k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
+			spin_unlock_bh(&ab->base_lock);
+			rcu_read_unlock();
+			return;
+		}
+
+		arsta->txrate.mcs = ts->mcs + 8 * (arsta->last_txrate.nss - 1);
+		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
+		if (ts->sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
+		if (ts->mcs > 9) {
+			ath11k_warn(ab, "Invalid VHT mcs index %d\n", ts->mcs);
+			spin_unlock_bh(&ab->base_lock);
+			rcu_read_unlock();
+			return;
+		}
+
+		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (ts->sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else {
+		/*TODO: update HE rates */
+	}
+
+	arsta->txrate.nss = arsta->last_txrate.nss;
+	arsta->txrate.bw = ts->bw;
+
+	ath11k_accumulate_per_peer_tx_stats(arsta, peer_stats, rate_idx);
+	spin_unlock_bh(&ab->base_lock);
+	rcu_read_unlock();
+}
+
+static ssize_t ath11k_dbg_sta_dump_tx_stats(struct file *file,
+					    char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	struct ath11k_htt_data_stats *stats;
+	static const char *str_name[ATH11K_STATS_TYPE_MAX] = {"succ", "fail",
+							      "retry", "ampdu"};
+	static const char *str[ATH11K_COUNTER_TYPE_MAX] = {"bytes", "packets"};
+	int len = 0, i, j, k, retval = 0;
+	const int size = 2 * 4096;
+	char *buf;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mutex_lock(&ar->conf_mutex);
+
+	spin_lock_bh(&ar->data_lock);
+	for (k = 0; k < ATH11K_STATS_TYPE_MAX; k++) {
+		for (j = 0; j < ATH11K_COUNTER_TYPE_MAX; j++) {
+			stats = &arsta->tx_stats->stats[k];
+			len += scnprintf(buf + len, size - len, "%s_%s\n",
+					 str_name[k],
+					 str[j]);
+			len += scnprintf(buf + len, size - len,
+					 " HE MCS %s\n",
+					 str[j]);
+			for (i = 0; i < ATH11K_HE_MCS_NUM; i++)
+				len += scnprintf(buf + len, size - len,
+						 "  %llu ",
+						 stats->he[j][i]);
+			len += scnprintf(buf + len, size - len, "\n");
+			len += scnprintf(buf + len, size - len,
+					 " VHT MCS %s\n",
+					 str[j]);
+			for (i = 0; i < ATH11K_VHT_MCS_NUM; i++)
+				len += scnprintf(buf + len, size - len,
+						 "  %llu ",
+						 stats->vht[j][i]);
+			len += scnprintf(buf + len, size - len, "\n");
+			len += scnprintf(buf + len, size - len, " HT MCS %s\n",
+					 str[j]);
+			for (i = 0; i < ATH11K_HT_MCS_NUM; i++)
+				len += scnprintf(buf + len, size - len,
+						 "  %llu ", stats->ht[j][i]);
+			len += scnprintf(buf + len, size - len, "\n");
+			len += scnprintf(buf + len, size - len,
+					" BW %s (20,40,80,160 MHz)\n", str[j]);
+			len += scnprintf(buf + len, size - len,
+					 "  %llu %llu %llu %llu\n",
+					 stats->bw[j][0], stats->bw[j][1],
+					 stats->bw[j][2], stats->bw[j][3]);
+			len += scnprintf(buf + len, size - len,
+					 " NSS %s (1x1,2x2,3x3,4x4)\n", str[j]);
+			len += scnprintf(buf + len, size - len,
+					 "  %llu %llu %llu %llu\n",
+					 stats->nss[j][0], stats->nss[j][1],
+					 stats->nss[j][2], stats->nss[j][3]);
+			len += scnprintf(buf + len, size - len,
+					 " GI %s (0.4us,0.8us,1.6us,3.2us)\n",
+					 str[j]);
+			len += scnprintf(buf + len, size - len,
+					 "  %llu %llu %llu %llu\n",
+					 stats->gi[j][0], stats->gi[j][1],
+					 stats->gi[j][2], stats->gi[j][3]);
+			len += scnprintf(buf + len, size - len,
+					 " legacy rate %s (1,2 ... Mbps)\n  ",
+					 str[j]);
+			for (i = 0; i < ATH11K_LEGACY_NUM; i++)
+				len += scnprintf(buf + len, size - len, "%llu ",
+						 stats->legacy[j][i]);
+			len += scnprintf(buf + len, size - len, "\n");
+		}
+	}
+
+	len += scnprintf(buf + len, size - len,
+			 "\nTX duration\n %llu usecs\n",
+			 arsta->tx_stats->tx_duration);
+	len += scnprintf(buf + len, size - len,
+			"BA fails\n %llu\n", arsta->tx_stats->ba_fails);
+	len += scnprintf(buf + len, size - len,
+			"ack fails\n %llu\n", arsta->tx_stats->ack_fails);
+	spin_unlock_bh(&ar->data_lock);
+
+	if (len > size)
+		len = size;
+	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+
+	mutex_unlock(&ar->conf_mutex);
+	return retval;
+}
+
+static const struct file_operations fops_tx_stats = {
+	.read = ath11k_dbg_sta_dump_tx_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_dbg_sta_dump_rx_stats(struct file *file,
+					    char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	struct ath11k_rx_peer_stats *rx_stats = arsta->rx_stats;
+	int len = 0, i, retval = 0;
+	const int size = 4096;
+	char *buf;
+
+	if (!rx_stats)
+		return -ENOENT;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mutex_lock(&ar->conf_mutex);
+	spin_lock_bh(&ar->ab->base_lock);
+
+	len += scnprintf(buf + len, size - len, "RX peer stats:\n");
+	len += scnprintf(buf + len, size - len, "Num of MSDUs: %llu\n",
+			 rx_stats->num_msdu);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs with TCP L4: %llu\n",
+			 rx_stats->tcp_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs with UDP L4: %llu\n",
+			 rx_stats->udp_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs part of AMPDU: %llu\n",
+			 rx_stats->ampdu_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs not part of AMPDU: %llu\n",
+			 rx_stats->non_ampdu_msdu_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs using STBC: %llu\n",
+			 rx_stats->stbc_count);
+	len += scnprintf(buf + len, size - len, "Num of MSDUs beamformed: %llu\n",
+			 rx_stats->beamformed_count);
+	len += scnprintf(buf + len, size - len, "Num of MPDUs with FCS ok: %llu\n",
+			 rx_stats->num_mpdu_fcs_ok);
+	len += scnprintf(buf + len, size - len, "Num of MPDUs with FCS error: %llu\n",
+			 rx_stats->num_mpdu_fcs_err);
+	len += scnprintf(buf + len, size - len,
+			 "GI: 0.8us %llu 0.4us %llu 1.6us %llu 3.2us %llu\n",
+			 rx_stats->gi_count[0], rx_stats->gi_count[1],
+			 rx_stats->gi_count[2], rx_stats->gi_count[3]);
+	len += scnprintf(buf + len, size - len,
+			 "BW: 20Mhz %llu 40Mhz %llu 80Mhz %llu 160Mhz %llu\n",
+			 rx_stats->bw_count[0], rx_stats->bw_count[1],
+			 rx_stats->bw_count[2], rx_stats->bw_count[3]);
+	len += scnprintf(buf + len, size - len, "BCC %llu LDPC %llu\n",
+			 rx_stats->coding_count[0], rx_stats->coding_count[1]);
+	len += scnprintf(buf + len, size - len,
+			 "preamble: 11A %llu 11B %llu 11N %llu 11AC %llu 11AX %llu\n",
+			 rx_stats->pream_cnt[0], rx_stats->pream_cnt[1],
+			 rx_stats->pream_cnt[2], rx_stats->pream_cnt[3],
+			 rx_stats->pream_cnt[4]);
+	len += scnprintf(buf + len, size - len,
+			 "reception type: SU %llu MU_MIMO %llu MU_OFDMA %llu MU_OFDMA_MIMO %llu\n",
+			 rx_stats->reception_type[0], rx_stats->reception_type[1],
+			 rx_stats->reception_type[2], rx_stats->reception_type[3]);
+	len += scnprintf(buf + len, size - len, "TID(0-15) Legacy TID(16):");
+	for (i = 0; i <= IEEE80211_NUM_TIDS; i++)
+		len += scnprintf(buf + len, size - len, "%llu ", rx_stats->tid_count[i]);
+	len += scnprintf(buf + len, size - len, "\nMCS(0-11) Legacy MCS(12):");
+	for (i = 0; i < HAL_RX_MAX_MCS + 1; i++)
+		len += scnprintf(buf + len, size - len, "%llu ", rx_stats->mcs_count[i]);
+	len += scnprintf(buf + len, size - len, "\nNSS(1-8):");
+	for (i = 0; i < HAL_RX_MAX_NSS; i++)
+		len += scnprintf(buf + len, size - len, "%llu ", rx_stats->nss_count[i]);
+	len += scnprintf(buf + len, size - len, "\nRX Duration:%llu ",
+			 rx_stats->rx_duration);
+	len += scnprintf(buf + len, size - len, "\n");
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	if (len > size)
+		len = size;
+	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+
+	mutex_unlock(&ar->conf_mutex);
+	return retval;
+}
+
+static const struct file_operations fops_rx_stats = {
+	.read = ath11k_dbg_sta_dump_rx_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static int
+ath11k_dbg_sta_open_htt_peer_stats(struct inode *inode, struct file *file)
+{
+	struct ieee80211_sta *sta = inode->i_private;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	struct debug_htt_stats_req *stats_req;
+	int ret;
+
+	stats_req = vzalloc(sizeof(*stats_req) + ATH11K_HTT_STATS_BUF_SIZE);
+	if (!stats_req)
+		return -ENOMEM;
+
+	mutex_lock(&ar->conf_mutex);
+	ar->debug.htt_stats.stats_req = stats_req;
+	stats_req->type = ATH11K_DBG_HTT_EXT_STATS_PEER_INFO;
+	memcpy(stats_req->peer_addr, sta->addr, ETH_ALEN);
+	ret = ath11k_dbg_htt_stats_req(ar);
+	mutex_unlock(&ar->conf_mutex);
+	if (ret < 0)
+		goto out;
+
+	file->private_data = stats_req;
+	return 0;
+out:
+	vfree(stats_req);
+	return ret;
+}
+
+static int
+ath11k_dbg_sta_release_htt_peer_stats(struct inode *inode, struct file *file)
+{
+	vfree(file->private_data);
+	return 0;
+}
+
+static ssize_t ath11k_dbg_sta_read_htt_peer_stats(struct file *file,
+						  char __user *user_buf,
+						  size_t count, loff_t *ppos)
+{
+	struct debug_htt_stats_req *stats_req = file->private_data;
+	char *buf;
+	u32 length = 0;
+
+	buf = stats_req->buf;
+	length = min_t(u32, stats_req->buf_len, ATH11K_HTT_STATS_BUF_SIZE);
+	return simple_read_from_buffer(user_buf, count, ppos, buf, length);
+}
+
+static const struct file_operations fops_htt_peer_stats = {
+	.open = ath11k_dbg_sta_open_htt_peer_stats,
+	.release = ath11k_dbg_sta_release_htt_peer_stats,
+	.read = ath11k_dbg_sta_read_htt_peer_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_dbg_sta_write_peer_pktlog(struct file *file,
+						const char __user *buf,
+						size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	int ret, enable;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto out;
+	}
+
+	ret = kstrtoint_from_user(buf, count, 0, &enable);
+	if (ret)
+		goto out;
+
+	ar->debug.pktlog_peer_valid = enable;
+	memcpy(ar->debug.pktlog_peer_addr, sta->addr, ETH_ALEN);
+
+	/* Send peer based pktlog enable/disable */
+	ret = ath11k_wmi_pdev_peer_pktlog_filter(ar, sta->addr, enable);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set peer pktlog filter %pM: %d\n",
+			    sta->addr, ret);
+		goto out;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "peer pktlog filter set to %d\n",
+		   enable);
+	ret = count;
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static ssize_t ath11k_dbg_sta_read_peer_pktlog(struct file *file,
+					       char __user *ubuf,
+					       size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	char buf[32] = {0};
+	int len;
+
+	mutex_lock(&ar->conf_mutex);
+	len = scnprintf(buf, sizeof(buf), "%08x %pM\n",
+			ar->debug.pktlog_peer_valid,
+			ar->debug.pktlog_peer_addr);
+	mutex_unlock(&ar->conf_mutex);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_peer_pktlog = {
+	.write = ath11k_dbg_sta_write_peer_pktlog,
+	.read = ath11k_dbg_sta_read_peer_pktlog,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, struct dentry *dir)
+{
+	struct ath11k *ar = hw->priv;
+
+	if (ath11k_debug_is_extd_tx_stats_enabled(ar))
+		debugfs_create_file("tx_stats", 0400, dir, sta,
+				    &fops_tx_stats);
+	if (ath11k_debug_is_extd_rx_stats_enabled(ar))
+		debugfs_create_file("rx_stats", 0400, dir, sta,
+				    &fops_rx_stats);
+
+	debugfs_create_file("htt_peer_stats", 0400, dir, sta,
+			    &fops_htt_peer_stats);
+
+	debugfs_create_file("peer_pktlog", 0644, dir, sta,
+			    &fops_peer_pktlog);
+}

