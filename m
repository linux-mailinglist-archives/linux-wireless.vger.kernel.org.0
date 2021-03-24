Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B97634802A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 19:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbhCXSPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 14:15:04 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:41044 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbhCXSOs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 14:14:48 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id BBAB813C2B9;
        Wed, 24 Mar 2021 11:14:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BBAB813C2B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1616609687;
        bh=j0m7Piusqsp71SICFPBqu933fiZ9w7Z/pDuofpGMRB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rz7tZyZM6CxQhzkmCszSADFyuMyiZXywlRZtZVP6Mu7/h+fiTMHsbyNOjN5ZQDq0T
         Z53xK/YG+ULJ5JSzKW2Q7B61i+Lr1lVkoQXZUTmOOYX/EFFCwtsdUnxYLGwYuCprV2
         FmJ6e656q8vcobJl9hbZKmX/K0q1zHJdjUafNCEY=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 5/6] mac80211:  Add some additional tx-stats to debugfs
Date:   Wed, 24 Mar 2021 11:14:40 -0700
Message-Id: <20210324181441.13755-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324181441.13755-1-greearb@candelatech.com>
References: <20210324181441.13755-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Give a better idea of TX behaviour.  Currently this code does not
deal with HE tx rates properly.  I'm not sure exactly where to
find that info, not sure that ax200 driver that I'm testing properly
provides it up to the tx-status logic.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs_sta.c | 24 ++++++++++++++++++-
 net/mac80211/rx.c          |  1 +
 net/mac80211/sta_info.h    | 16 +++++++++++++
 net/mac80211/status.c      | 47 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 9dd29fe94bde..ed6380bb6270 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -107,7 +107,7 @@ static ssize_t sta_stats_read(struct file *file, char __user *userbuf,
 {
 	struct sta_info *sta = file->private_data;
 	unsigned int len = 0;
-	const int buf_len = 8000;
+	const int buf_len = 12000;
 	char *buf = kzalloc(buf_len, GFP_KERNEL);
 	unsigned long sum;
 	char tmp[60];
@@ -186,6 +186,7 @@ static ssize_t sta_stats_read(struct file *file, char __user *userbuf,
 	PRINT_MY_STATS("rx-bw-40", rx_stats.msdu_40);
 	PRINT_MY_STATS("rx-bw-80", rx_stats.msdu_80);
 	PRINT_MY_STATS("rx-bw-160", rx_stats.msdu_160);
+	PRINT_MY_STATS("rx-bw-he-ru", rx_stats.msdu_he_ru);
 
 	PRINT_MY_STATS("rx-he-total", rx_stats.msdu_he_tot);
 	PRINT_MY_STATS("rx-he-su", rx_stats.msdu_he_su);
@@ -213,6 +214,27 @@ static ssize_t sta_stats_read(struct file *file, char __user *userbuf,
 		sprintf(tmp, "rx-rate-idx[%3i]", i);
 		PRINT_MY_STATS(tmp, rx_stats.msdu_rate_idx[i]);
 	}
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+	PRINT_MY_STATS("tx-bw-20", sta->tx_stats.msdu_20);
+	PRINT_MY_STATS("tx-bw-40", sta->tx_stats.msdu_40);
+	PRINT_MY_STATS("tx-bw-80", sta->tx_stats.msdu_80);
+	PRINT_MY_STATS("tx-bw-160", sta->tx_stats.msdu_160);
+	PRINT_MY_STATS("tx-bw-he-ru", sta->tx_stats.msdu_he_ru);
+
+	PRINT_MY_STATS("tx-vht", sta->tx_stats.msdu_vht);
+	PRINT_MY_STATS("tx-ht", sta->tx_stats.msdu_ht);
+	PRINT_MY_STATS("tx-legacy", sta->tx_stats.msdu_legacy);
+
+	for (i = 0; i < ARRAY_SIZE(sta->tx_stats.msdu_nss); i++) {
+		sprintf(tmp, "tx-msdu-nss[%i]", i);
+		PRINT_MY_STATS(tmp, sta->tx_stats.msdu_nss[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sta->tx_stats.msdu_rate_idx); i++) {
+		sprintf(tmp, "tx-rate-idx[%3i]", i);
+		PRINT_MY_STATS(tmp, sta->tx_stats.msdu_rate_idx[i]);
+	}
 #endif
 
 #undef PRINT_MY_STATS
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c83428b5bb5a..be05abc77292 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1767,6 +1767,7 @@ static void ieee80211_update_data_rx_stats(struct ieee80211_rx_data *rx,
 		stats->msdu_160++;
 		break;
 	case RATE_INFO_BW_HE_RU:
+		stats->msdu_he_ru++;
 		stats->msdu_he_ru_alloc[status->he_ru]++;
 		break;
 	};
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 90fcebf199ad..6fc6ad6248e6 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -445,6 +445,7 @@ struct ieee80211_sta_rx_stats {
 	u32 msdu_40;
 	u32 msdu_80;
 	u32 msdu_160;
+	u32 msdu_he_ru;
 	u32 msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_LAST];
 	u32 msdu_he_tot;
 	u32 msdu_he_su;
@@ -636,6 +637,21 @@ struct sta_info {
 		struct ieee80211_tx_rate last_rate;
 		struct rate_info last_rate_info;
 		u64 msdu[IEEE80211_NUM_TIDS + 1];
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+		/* these take liberty with how things are defined, and are
+		 * designed to give a rough idea of how things are going.
+		 */
+		u32 msdu_20;
+		u32 msdu_40;
+		u32 msdu_80;
+		u32 msdu_160;
+		u32 msdu_he_ru;
+		u32 msdu_vht;
+		u32 msdu_ht;
+		u32 msdu_legacy;
+		u32 msdu_nss[8];
+		u32 msdu_rate_idx[13];
+#endif
 	} tx_stats;
 	u16 tid_seq[IEEE80211_QOS_CTL_TID_MASK + 1];
 
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 3460154cf4fe..e7ee13f82355 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1112,6 +1112,9 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 
 	if (pubsta) {
 		struct ieee80211_sub_if_data *sdata = sta->sdata;
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+		bool do_stats = false;
+#endif
 
 		if (!acked && !noack_success)
 			sta->status_stats.retry_failed++;
@@ -1124,6 +1127,9 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 							acked, info->status.tx_time);
 
 			if (acked) {
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+				do_stats = true;
+#endif
 				sta->status_stats.last_ack = jiffies;
 
 				if (sta->status_stats.lost_packets)
@@ -1154,11 +1160,52 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 				return;
 			} else if (noack_success) {
 				/* nothing to do here, do not account as lost */
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+				do_stats = true;
+#endif
 			} else {
 				ieee80211_lost_packet(sta, info);
 			}
 		}
 
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+		if (do_stats && (rates_idx != -1)) {
+			u8 nss = 0;
+			u8 mcs = 0;
+			struct ieee80211_tx_rate *txrt = &(info->status.rates[rates_idx]);
+			if (txrt->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+				sta->tx_stats.msdu_40++;
+			else if (txrt->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+				sta->tx_stats.msdu_80++;
+			else if (txrt->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+				sta->tx_stats.msdu_160++;
+			else
+				sta->tx_stats.msdu_20++;
+
+			if (txrt->flags & IEEE80211_TX_RC_MCS) {
+				nss = (txrt->idx / 8);
+				mcs = txrt->idx - (nss * 8);
+				sta->tx_stats.msdu_ht++;
+			}
+			else if (txrt->flags & IEEE80211_TX_RC_VHT_MCS) {
+				mcs = ieee80211_rate_get_vht_mcs(txrt);
+				nss = ieee80211_rate_get_vht_nss(txrt);
+				nss -= 1;
+				sta->tx_stats.msdu_vht++;
+			}
+			else {
+				mcs = txrt->idx;
+				sta->tx_stats.msdu_legacy++;
+			}
+
+			if (nss > (ARRAY_SIZE(sta->tx_stats.msdu_nss) - 1))
+				nss = ARRAY_SIZE(sta->tx_stats.msdu_nss) - 1;
+			if (mcs > (ARRAY_SIZE(sta->tx_stats.msdu_rate_idx) - 1))
+				mcs = ARRAY_SIZE(sta->tx_stats.msdu_rate_idx) - 1;
+			sta->tx_stats.msdu_nss[nss]++;
+			sta->tx_stats.msdu_rate_idx[mcs]++;
+		}
+#endif
 		rate_control_tx_status(local, sband, status);
 		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
 			ieee80211s_update_metric(local, sta, status);
-- 
2.20.1

