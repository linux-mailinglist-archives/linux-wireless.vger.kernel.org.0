Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941C422F6C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbfETIzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 04:55:23 -0400
Received: from nbd.name ([46.4.11.11]:41456 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbfETIzW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 04:55:22 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSe4k-0002Y7-4z; Mon, 20 May 2019 10:55:18 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V5 4/8] ath11k: add HE handling to the debug code
Date:   Mon, 20 May 2019 10:55:04 +0200
Message-Id: <20190520085508.5888-5-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520085508.5888-1-john@phrozen.org>
References: <20190520085508.5888-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch allows the driver to also show the HE counters and stats.
Also extend the appropriate debug prints with HE info.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.h        |  2 ++
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 24 +++++++++++++++++--
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  3 ++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 148c9a4c0978..994170e08cc5 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -253,6 +253,7 @@ struct ath11k_peer {
 	struct dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
 };
 
+#define ATH11K_HE_MCS_NUM       12
 #define ATH11K_VHT_MCS_NUM      10
 #define ATH11K_BW_NUM           4
 #define ATH11K_NSS_NUM          4
@@ -306,6 +307,7 @@ struct ath11k_htt_data_stats {
 	u64 legacy[ATH11K_COUNTER_TYPE_MAX][ATH11K_LEGACY_NUM];
 	u64 ht[ATH11K_COUNTER_TYPE_MAX][ATH11K_HT_MCS_NUM];
 	u64 vht[ATH11K_COUNTER_TYPE_MAX][ATH11K_VHT_MCS_NUM];
+	u64 he[ATH11K_COUNTER_TYPE_MAX][ATH11K_HE_MCS_NUM];
 	u64 bw[ATH11K_COUNTER_TYPE_MAX][ATH11K_BW_NUM];
 	u64 nss[ATH11K_COUNTER_TYPE_MAX][ATH11K_NSS_NUM];
 	u64 gi[ATH11K_COUNTER_TYPE_MAX][ATH11K_GI_NUM];
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index c39b6e1d22c3..cff6a3f048ea 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -45,7 +45,14 @@ ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
 
 #define STATS_OP_FMT(name) tx_stats->stats[ATH11K_STATS_TYPE_##name]
 
-	if (txrate->flags & RATE_INFO_FLAGS_VHT_MCS) {
+	if (txrate->flags & RATE_INFO_FLAGS_HE_MCS) {
+		STATS_OP_FMT(SUCC).he[0][mcs] += peer_stats->succ_bytes;
+		STATS_OP_FMT(SUCC).he[1][mcs] += peer_stats->succ_pkts;
+		STATS_OP_FMT(FAIL).he[0][mcs] += peer_stats->failed_bytes;
+		STATS_OP_FMT(FAIL).he[1][mcs] += peer_stats->failed_pkts;
+		STATS_OP_FMT(RETRY).he[0][mcs] += peer_stats->retry_bytes;
+		STATS_OP_FMT(RETRY).he[1][mcs] += peer_stats->retry_pkts;
+	} else if (txrate->flags & RATE_INFO_FLAGS_VHT_MCS) {
 		STATS_OP_FMT(SUCC).vht[0][mcs] += peer_stats->succ_bytes;
 		STATS_OP_FMT(SUCC).vht[1][mcs] += peer_stats->succ_pkts;
 		STATS_OP_FMT(FAIL).vht[0][mcs] += peer_stats->failed_bytes;
@@ -73,7 +80,12 @@ ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
 	if (peer_stats->is_ampdu) {
 		tx_stats->ba_fails += peer_stats->ba_fails;
 
-		if (txrate->flags & RATE_INFO_FLAGS_MCS) {
+		if (txrate->flags & RATE_INFO_FLAGS_HE_MCS) {
+			STATS_OP_FMT(AMPDU).he[0][mcs] +=
+			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			STATS_OP_FMT(AMPDU).he[1][mcs] +=
+			peer_stats->succ_pkts + peer_stats->retry_pkts;
+		} else if (txrate->flags & RATE_INFO_FLAGS_MCS) {
 			STATS_OP_FMT(AMPDU).ht[0][mcs] +=
 			peer_stats->succ_bytes + peer_stats->retry_bytes;
 			STATS_OP_FMT(AMPDU).ht[1][mcs] +=
@@ -229,6 +241,14 @@ static ssize_t ath11k_dbg_sta_dump_tx_stats(struct file *file,
 			len += scnprintf(buf + len, size - len, "%s_%s\n",
 					 str_name[k],
 					 str[j]);
+			len += scnprintf(buf + len, size - len,
+					 " HE MCS %s\n",
+					 str[j]);
+			for (i = 0; i < ATH11K_HE_MCS_NUM; i++)
+				len += scnprintf(buf + len, size - len,
+						 "  %llu ",
+						 stats->he[j][i]);
+			len += scnprintf(buf + len, size - len, "\n");
 			len += scnprintf(buf + len, size - len,
 					 " VHT MCS %s\n",
 					 str[j]);
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 73865ce2b3ab..62820c20f7c1 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1817,7 +1817,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	status = IEEE80211_SKB_RXCB(msdu);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
-		   "rx skb %pK len %u peer %pM %s %s sn %u %s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %pK len %u peer %pM %s %s sn %u %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
 		   ieee80211_get_SA(hdr),
@@ -1828,6 +1828,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 		   (status->encoding == RX_ENC_LEGACY) ? "legacy" : "",
 		   (status->encoding == RX_ENC_HT) ? "ht" : "",
 		   (status->encoding == RX_ENC_VHT) ? "vht" : "",
+		   (status->encoding == RX_ENC_HE) ? "he" : "",
 		   (status->bw == RATE_INFO_BW_40) ? "40" : "",
 		   (status->bw == RATE_INFO_BW_80) ? "80" : "",
 		   (status->bw == RATE_INFO_BW_160) ? "160" : "",
-- 
2.20.1

