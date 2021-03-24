Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2537A34802C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 19:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhCXSPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 14:15:06 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:41038 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbhCXSOs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 14:14:48 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 687DA13C2B6;
        Wed, 24 Mar 2021 11:14:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 687DA13C2B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1616609687;
        bh=9anrpGMFPrtenbHLp7Ou8376bO0ule6SVzQr+CiWFAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTQEMIVozcvEWA45Gbm3lFWx/QXoDhLRdF6tOidqbN6L6VXLRtWb4JuFxROTMOw32
         S8pYuSR1mxEhLsBHmZqDOX/0q6RPfnl/BdhcKzODkvaPgMrt97VBRh8vN2kHfDoAhF
         oNCwVKdsNhq7DpUMLkHHfwwbo6MdXLK2H+acVT1I=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 3/6] mac80211:  Provide detailed station rx stats.
Date:   Wed, 24 Mar 2021 11:14:38 -0700
Message-Id: <20210324181441.13755-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324181441.13755-1-greearb@candelatech.com>
References: <20210324181441.13755-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This provides histograms of different encoding types,
nss, rate-idx, and some ofdma related stats.  The goal
is general visibility into what is going on with rate
control, ofdma, etc.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/uapi/linux/nl80211.h |  1 +
 net/mac80211/Kconfig         | 11 ++++++++
 net/mac80211/debugfs_sta.c   | 30 ++++++++++++++++++++
 net/mac80211/rx.c            | 55 ++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.c      | 16 +++++++++++
 net/mac80211/sta_info.h      | 17 +++++++++++
 6 files changed, 130 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 55e7be30a930..8f548a599134 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3269,6 +3269,7 @@ enum nl80211_he_ru_alloc {
 	NL80211_RATE_INFO_HE_RU_ALLOC_484,
 	NL80211_RATE_INFO_HE_RU_ALLOC_996,
 	NL80211_RATE_INFO_HE_RU_ALLOC_2x996,
+	NL80211_RATE_INFO_HE_RU_ALLOC_LAST /* new entries before this */
 };
 
 /**
diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 51ec8256b7fa..b0ebb64b3950 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -295,6 +295,17 @@ config MAC80211_DEBUG_COUNTERS
 
 	  If unsure, say N.
 
+config MAC80211_DEBUG_STA_COUNTERS
+	bool "Extra Station TX/RX statistics"
+	depends on MAC80211_DEBUG_MENU
+	depends on MAC80211_DEBUGFS
+	help
+	  Selecting this option causes mac80211 to keep additional
+	  and very verbose station-specific TX and RX statistics
+	  These will be exposed in debugfs.
+
+	  If unsure, say N.
+
 config MAC80211_STA_HASH_MAX_SIZE
 	int "Station hash table maximum size" if MAC80211_DEBUG_MENU
 	default 0
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 374db61527a9..f29e937aec5c 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -181,6 +181,36 @@ static ssize_t sta_stats_read(struct file *file, char __user *userbuf,
 		PRINT_MY_STATS(tmp, rx_stats.msdu[i]);
 	}
 
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+	PRINT_MY_STATS("rx-bw-20", rx_stats.msdu_20);
+	PRINT_MY_STATS("rx-bw-40", rx_stats.msdu_40);
+	PRINT_MY_STATS("rx-bw-80", rx_stats.msdu_80);
+	PRINT_MY_STATS("rx-bw-160", rx_stats.msdu_160);
+
+	PRINT_MY_STATS("rx-he-total", rx_stats.msdu_he_tot);
+	PRINT_MY_STATS("rx-vht", rx_stats.msdu_vht);
+	PRINT_MY_STATS("rx-ht", rx_stats.msdu_ht);
+	PRINT_MY_STATS("rx-legacy", rx_stats.msdu_legacy);
+
+	PRINT_MY_STATS("rx-he-ru-alloc[   26]", rx_stats.msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_26]);
+	PRINT_MY_STATS("rx-he-ru-alloc[   52]", rx_stats.msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_52]);
+	PRINT_MY_STATS("rx-he-ru-alloc[  106]", rx_stats.msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_106]);
+	PRINT_MY_STATS("rx-he-ru-alloc[  242]", rx_stats.msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_242]);
+	PRINT_MY_STATS("rx-he-ru-alloc[  484]", rx_stats.msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_484]);
+	PRINT_MY_STATS("rx-he-ru-alloc[  996]", rx_stats.msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_996]);
+	PRINT_MY_STATS("rx-he-ru-alloc[2x996]", rx_stats.msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_2x996]);
+
+	for (i = 0; i < ARRAY_SIZE(rx_stats.msdu_nss); i++) {
+		sprintf(tmp, "rx-msdu-nss[%i]", i);
+		PRINT_MY_STATS(tmp, rx_stats.msdu_nss[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(rx_stats.msdu_rate_idx); i++) {
+		sprintf(tmp, "rx-rate-idx[%3i]", i);
+		PRINT_MY_STATS(tmp, rx_stats.msdu_rate_idx[i]);
+	}
+#endif
+
 #undef PRINT_MY_STATS
 done:
 	i = simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4a64c2183a27..01117e2d1f27 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1718,6 +1718,11 @@ static void ieee80211_update_data_rx_stats(struct ieee80211_rx_data *rx,
 					   struct ieee80211_rx_status *status,
 					   int skb_len)
 {
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+	u8 nss;
+	u8 rix;
+#endif
+
 	stats->fragments++;
 	stats->packets++;
 	stats->last_rx = jiffies;
@@ -1732,6 +1737,56 @@ static void ieee80211_update_data_rx_stats(struct ieee80211_rx_data *rx,
 	stats->msdu[rx->seqno_idx]++;
 	stats->bytes += skb_len;
 	u64_stats_update_end(&stats->syncp);
+
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+	/* This code has a lot in common with ieee80211_add_rx_radiotap_header */
+	switch (status->bw) {
+	case RATE_INFO_BW_20:
+		stats->msdu_20++;
+		break;
+	case RATE_INFO_BW_40:
+		stats->msdu_40++;
+		break;
+	case RATE_INFO_BW_80:
+		stats->msdu_80++;
+		break;
+	case RATE_INFO_BW_160:
+		stats->msdu_160++;
+		break;
+	case RATE_INFO_BW_HE_RU:
+		stats->msdu_he_ru_alloc[status->he_ru]++;
+		break;
+	};
+
+	nss = status->nss - 1;
+	rix = status->rate_idx;
+
+	if (status->encoding == RX_ENC_HE) {
+		stats->msdu_he_tot++;
+	}
+	else if (status->encoding == RX_ENC_VHT) {
+		stats->msdu_vht++;
+	}
+	else if (status->encoding == RX_ENC_HT) {
+		stats->msdu_ht++;
+		/* Convert HT MCS to mimic what is done for VHT */
+		nss = status->rate_idx / 8;
+		rix = status->rate_idx - (status->rate_idx * 8);
+	}
+	else {
+		stats->msdu_legacy++;
+	}
+
+	if (nss >= (ARRAY_SIZE(stats->msdu_nss) - 1))
+		stats->msdu_nss[ARRAY_SIZE(stats->msdu_nss) - 1]++;
+	else
+		stats->msdu_nss[nss]++;
+
+	if (rix >= (ARRAY_SIZE(stats->msdu_rate_idx) - 1))
+		stats->msdu_rate_idx[ARRAY_SIZE(stats->msdu_rate_idx) - 1]++;
+	else
+		stats->msdu_rate_idx[rix]++;
+#endif
 }
 
 static ieee80211_rx_result debug_noinline
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa95db547465..765993802fec 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2680,6 +2680,22 @@ void sta_accum_rx_stats(struct sta_info *sta,
 		for (i = 0; i<=IEEE80211_NUM_TIDS; i++) {
 			rx_stats->msdu[i] += sta_get_tidstats_msdu(cpurxs, i);
 		}
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+		rx_stats->msdu_20 += cpurxs->msdu_20;
+		rx_stats->msdu_40 += cpurxs->msdu_40;
+		rx_stats->msdu_80 += cpurxs->msdu_80;
+		rx_stats->msdu_160 += cpurxs->msdu_160;
+		for (i = 0; i<NL80211_RATE_INFO_HE_RU_ALLOC_LAST; i++)
+			rx_stats->msdu_he_ru_alloc[i] += cpurxs->msdu_he_ru_alloc[i];
+		rx_stats->msdu_he_tot += cpurxs->msdu_he_tot;
+		rx_stats->msdu_vht += cpurxs->msdu_vht;
+		rx_stats->msdu_ht += cpurxs->msdu_ht;
+		rx_stats->msdu_legacy += cpurxs->msdu_legacy;
+		for (i = 0; i < ARRAY_SIZE(rx_stats->msdu_nss); i++)
+			rx_stats->msdu_nss[i] += cpurxs->msdu_nss[i];
+		for (i = 0; i < ARRAY_SIZE(rx_stats->msdu_rate_idx); i++)
+			rx_stats->msdu_rate_idx[i] += cpurxs->msdu_rate_idx[i];
+#endif
 	}
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index a6b13d749ffa..e205a8a06ae7 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -436,6 +436,23 @@ struct ieee80211_sta_rx_stats {
 	struct u64_stats_sync syncp;
 	u64 bytes;
 	u64 msdu[IEEE80211_NUM_TIDS + 1];
+
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+	/* these take liberty with how things are defined, and are
+	 * designed to give a rough idea of how things are going.
+	 */
+	u32 msdu_20;
+	u32 msdu_40;
+	u32 msdu_80;
+	u32 msdu_160;
+	u32 msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_LAST];
+	u32 msdu_he_tot;
+	u32 msdu_vht;
+	u32 msdu_ht;
+	u32 msdu_legacy;
+	u32 msdu_nss[8];
+	u32 msdu_rate_idx[13];
+#endif
 };
 
 /*
-- 
2.20.1

