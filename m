Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64834292C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Mar 2021 00:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCSXj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 19:39:26 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:32868 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCSXi6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 19:38:58 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id ACE5A13C2B6;
        Fri, 19 Mar 2021 16:38:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ACE5A13C2B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1616197135;
        bh=H9/92mFXqYzGrgud6h8bpb3j19l3NYziPihWMRS93C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIy9BMk6zQECh4bfanUwVqZ0fKIfrGaoT6W1oP7ROO/LYLzILBfiWFbKEeCcLhjQI
         1zgIKZSa16VeK6244SwA30+5tUNOCy5soTErCACH08cwjeO2GZv2ymse5Kn8ldKUW7
         hixWVvjeLX38R4opjTiB7X37iAeVpGcEyzq+thns=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/3] mac80211:  Provide per-station stats in debugfs
Date:   Fri, 19 Mar 2021 16:38:49 -0700
Message-Id: <20210319233850.2238-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210319233850.2238-1-greearb@candelatech.com>
References: <20210319233850.2238-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Including per tid and per acs stats.

Nice for those who like to peer deep into the guts of a system.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs_sta.c | 88 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.c    | 33 ++++++++++++++
 net/mac80211/sta_info.h    |  4 ++
 3 files changed, 125 insertions(+)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 1deacce85177..374db61527a9 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -102,6 +102,93 @@ static ssize_t sta_flags_read(struct file *file, char __user *userbuf,
 }
 STA_OPS(flags);
 
+static ssize_t sta_stats_read(struct file *file, char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	struct sta_info *sta = file->private_data;
+	unsigned int len = 0;
+	const int buf_len = 8000;
+	char *buf = kzalloc(buf_len, GFP_KERNEL);
+	unsigned long sum;
+	char tmp[60];
+	int i;
+	struct ieee80211_sta_rx_stats rx_stats = {0};
+
+	if (!buf)
+		return -ENOMEM;
+
+	sta_accum_rx_stats(sta, &rx_stats);
+
+#define PRINT_MY_STATS(a, b) do {					\
+		len += scnprintf(buf + len, buf_len - len, "%30s %18lu\n", a, (unsigned long)(b)); \
+		if (len >= buf_len) {					\
+			goto done;					\
+		}							\
+	} while (0)
+
+#define PRINT_MY_STATS_S(a, b) do {					\
+		len += scnprintf(buf + len, buf_len - len, "%30s %18ld\n", a, (long)(b)); \
+		if (len >= buf_len) {					\
+			goto done;					\
+		}							\
+	} while (0)
+
+	PRINT_MY_STATS("rx-packets", rx_stats.packets);
+	PRINT_MY_STATS("rx-bytes", rx_stats.bytes);
+	PRINT_MY_STATS("rx-dup", rx_stats.num_duplicates);
+	PRINT_MY_STATS("rx-fragments", rx_stats.fragments);
+	PRINT_MY_STATS("rx-dropped", rx_stats.dropped);
+	PRINT_MY_STATS_S("rx-last-signal", rx_stats.last_signal);
+
+	for (i = 0; i<IEEE80211_MAX_CHAINS; i++) {
+		if (rx_stats.chains & (1<<i)) {
+			sprintf(tmp, "rx-last-signal-chain[%i]", i);
+			PRINT_MY_STATS_S(tmp, rx_stats.chain_signal_last[i]);
+		}
+	}
+	PRINT_MY_STATS("rx-last-rate-encoded", rx_stats.last_rate);
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	sum = sta->tx_stats.packets[0] + sta->tx_stats.packets[1]
+		+ sta->tx_stats.packets[2] + sta->tx_stats.packets[3];
+	PRINT_MY_STATS("tx-packets", sum);
+
+		sum = sta->tx_stats.bytes[0] + sta->tx_stats.bytes[1]
+		+ sta->tx_stats.bytes[2] + sta->tx_stats.bytes[3];
+	PRINT_MY_STATS("tx-bytes", sum);
+
+	/* per txq stats */
+	PRINT_MY_STATS("tx-packets-acs[VO]", sta->tx_stats.packets[IEEE80211_AC_VO]);
+	PRINT_MY_STATS("tx-packets-acs[VI]", sta->tx_stats.packets[IEEE80211_AC_VI]);
+	PRINT_MY_STATS("tx-packets-acs[BE]", sta->tx_stats.packets[IEEE80211_AC_BE]);
+	PRINT_MY_STATS("tx-packets-acs[BK]", sta->tx_stats.packets[IEEE80211_AC_BK]);
+
+	PRINT_MY_STATS("tx-bytes-acs[VO]", sta->tx_stats.bytes[IEEE80211_AC_VO]);
+	PRINT_MY_STATS("tx-bytes-acs[VI]", sta->tx_stats.bytes[IEEE80211_AC_VI]);
+	PRINT_MY_STATS("tx-bytes-acs[BE]", sta->tx_stats.bytes[IEEE80211_AC_BE]);
+	PRINT_MY_STATS("tx-bytes-acs[BK]", sta->tx_stats.bytes[IEEE80211_AC_BK]);
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+	for (i = 0; i<=IEEE80211_NUM_TIDS; i++) {
+		sprintf(tmp, "tx-msdu-tid[%2i]", i);
+		PRINT_MY_STATS(tmp, sta->tx_stats.msdu[i]);
+	}
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+	for (i = 0; i<=IEEE80211_NUM_TIDS; i++) {
+		sprintf(tmp, "rx-msdu-tid[%2i]", i);
+		PRINT_MY_STATS(tmp, rx_stats.msdu[i]);
+	}
+
+#undef PRINT_MY_STATS
+done:
+	i = simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+	kfree(buf);
+	return i;
+}
+STA_OPS(stats);
+
 static ssize_t sta_num_ps_buf_frames_read(struct file *file,
 					  char __user *userbuf,
 					  size_t count, loff_t *ppos)
@@ -1073,6 +1160,7 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 	sta->debugfs_dir = debugfs_create_dir(mac, stations_dir);
 
 	DEBUGFS_ADD(flags);
+	DEBUGFS_ADD(stats);
 	DEBUGFS_ADD(aid);
 	DEBUGFS_ADD(num_ps_buf_frames);
 	DEBUGFS_ADD(last_seq_ctrl);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index b096370b45b1..aa95db547465 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2650,6 +2650,39 @@ static void sta_update_codel_params(struct sta_info *sta, u32 thr)
 	}
 }
 
+void sta_accum_rx_stats(struct sta_info *sta,
+			struct ieee80211_sta_rx_stats *rx_stats)
+{
+	int cpu;
+	int i;
+
+	memcpy(rx_stats, &sta->rx_stats, sizeof(*rx_stats));
+
+	if (!sta->pcpu_rx_stats)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct ieee80211_sta_rx_stats *cpurxs;
+
+		cpurxs = per_cpu_ptr(sta->pcpu_rx_stats, cpu);
+		rx_stats->packets += cpurxs->packets;
+		if (time_after(cpurxs->last_rx, rx_stats->last_rx)) {
+			rx_stats->last_rx = cpurxs->last_rx;
+			rx_stats->last_signal = cpurxs->last_signal;
+			for (i = 0; i<IEEE80211_MAX_CHAINS; i++)
+				rx_stats->chain_signal_last[i] = cpurxs->chain_signal_last[i];
+			rx_stats->last_rate = cpurxs->last_rate;
+		}
+		rx_stats->num_duplicates += cpurxs->num_duplicates;
+		rx_stats->fragments += cpurxs->fragments;
+		rx_stats->dropped += cpurxs->dropped;
+		rx_stats->bytes += sta_get_stats_bytes(cpurxs);
+		for (i = 0; i<=IEEE80211_NUM_TIDS; i++) {
+			rx_stats->msdu[i] += sta_get_tidstats_msdu(cpurxs, i);
+		}
+	}
+}
+
 void ieee80211_sta_set_expected_throughput(struct ieee80211_sta *pubsta,
 					   u32 thr)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 897b4d12103e..a6b13d749ffa 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -422,6 +422,7 @@ struct mesh_sta {
 
 DECLARE_EWMA(signal, 10, 8)
 
+/* Update sta_accum_rx_stats if you change this structure. */
 struct ieee80211_sta_rx_stats {
 	unsigned long packets;
 	unsigned long last_rx;
@@ -907,4 +908,7 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
 	return r;
 }
 
+void sta_accum_rx_stats(struct sta_info *sta,
+			struct ieee80211_sta_rx_stats *rx_stats);
+
 #endif /* STA_INFO_H */
-- 
2.20.1

