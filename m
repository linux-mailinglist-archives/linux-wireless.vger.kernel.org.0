Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE764EB4FA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 23:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiC2VEW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiC2VEU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 17:04:20 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E741890CF
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 14:02:35 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.137])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A9CD91C008C
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 21:02:33 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7AB3D1400AA
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 21:02:33 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0604113C2B0;
        Tue, 29 Mar 2022 14:02:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0604113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1648587753;
        bh=6DzSgyrmmuanq2zcRz3D2T/RmgnrSEQzR5aZ1pRjGoI=;
        h=From:To:Cc:Subject:Date:From;
        b=Wv2XuW1nszmTdxzH918PzYp76ZRk6Yca7eeGudxceCZeDHe8TtyW6K085MLABUxAw
         6sAlD1U6hiXqU25J18YvllZGhqTykUJ8lrBXLKoP9pQTMM/PIctCLP5CmVtRLi89FZ
         cu7vCs6mdL5qTWxMV4GIjCMNkGr9rJ+68CHU4JxE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211:  report per-chain signal values through ethtool.
Date:   Tue, 29 Mar 2022 14:02:28 -0700
Message-Id: <20220329210228.8137-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1648587754-nflT0baI4RC4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Combine them into a u64, each byte is one chain.
Re-work the way that APs averaged stats to be more
efficient.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/ethtool.c | 103 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 028ffe1a4d2d..10a9a30bcbf3 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -64,6 +64,7 @@ static const char ieee80211_gstrings_sta_stats[][ETH_GSTRING_LEN] = {
 	"tx_packets", "tx_bytes",
 	"tx_filtered", "tx_retry_failed", "tx_retries",
 	"sta_state", "txrate", "rxrate", "signal", "signal_beacon",
+	"signal_chains", "signal_chains_avg",
 	"channel", "noise", "ch_time", "ch_time_busy",
 	"ch_time_ext_busy", "ch_time_rx", "ch_time_tx"
 };
@@ -96,6 +97,7 @@ static void ieee80211_get_stats2(struct net_device *dev,
 	struct station_info sinfo;
 	struct survey_info survey;
 	int i, q;
+	int z;
 #define STA_STATS_SURVEY_LEN 7
 
 	memset(data, 0, sizeof(u64) * STA_STATS_LEN);
@@ -154,14 +156,49 @@ static void ieee80211_get_stats2(struct net_device *dev,
 		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG))
 			data[i] = (u8)sinfo.rx_beacon_signal_avg;
 		i++;
+
+		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
+			int mn = min_t(int, sizeof(u64), ARRAY_SIZE(sinfo.chain_signal));
+			u64 accum = (u8)sinfo.chain_signal[0];
+
+			mn = min_t(int, mn, sinfo.chains);
+			for (z = 1; z < mn; z++) {
+				u64 csz = sinfo.chain_signal[z] & 0xFF;
+				u64 cs = csz << (8 * z);
+
+				accum |= cs;
+			}
+			data[i] = accum;
+		}
+		i++;
+
+		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)) {
+			int mn = min_t(int, sizeof(u64), ARRAY_SIZE(sinfo.chain_signal_avg));
+			u64 accum = (u8)sinfo.chain_signal_avg[0];
+
+			for (z = 1; z < mn; z++) {
+				u64 csz = sinfo.chain_signal_avg[z] & 0xFF;
+				u64 cs = csz << (8 * z);
+
+				accum |= cs;
+			}
+			data[i] = accum;
+		}
+		i++;
 	} else {
 		int amt_tx = 0;
 		int amt_rx = 0;
 		int amt_sig = 0;
+		s16 amt_accum_chain[8] = {0};
+		s16 amt_accum_chain_avg[8] = {0};
 		s64 tx_accum = 0;
 		s64 rx_accum = 0;
 		s64 sig_accum = 0;
 		s64 sig_accum_beacon = 0;
+		s64 sig_accum_chain[8] = {0};
+		s64 sig_accum_chain_avg[8] = {0};
+		int start_accum_idx = 0;
+
 		list_for_each_entry(sta, &local->sta_list, list) {
 			/* Make sure this station belongs to the proper dev */
 			if (sta->sdata->dev != dev)
@@ -173,35 +210,48 @@ static void ieee80211_get_stats2(struct net_device *dev,
 			ADD_STA_STATS(sta);
 
 			i++; /* skip sta state */
+			start_accum_idx = i;
 
 			if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
 				tx_accum += 100000ULL *
 					cfg80211_calculate_bitrate(&sinfo.txrate);
 				amt_tx++;
 			}
-			if (amt_tx)
-				data[i] = mac_div(tx_accum, amt_tx);
-			i++;
 
 			if (sinfo.filled & BIT(NL80211_STA_INFO_RX_BITRATE)) {
 				rx_accum += 100000ULL *
 					cfg80211_calculate_bitrate(&sinfo.rxrate);
 				amt_rx++;
 			}
-			if (amt_rx)
-				data[i] = mac_div(rx_accum, amt_rx);
-			i++;
 
 			if (sinfo.filled & BIT(NL80211_STA_INFO_SIGNAL_AVG)) {
 				sig_accum += sinfo.signal_avg;
 				sig_accum_beacon += sinfo.rx_beacon_signal_avg;
 				amt_sig++;
 			}
-			if (amt_sig) {
-				data[i] = (mac_div(sig_accum, amt_sig) & 0xFF);
-				data[i+1] = (mac_div(sig_accum_beacon, amt_sig) & 0xFF);
+
+			if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) {
+				int mn = min_t(int, sizeof(u64), ARRAY_SIZE(sinfo.chain_signal));
+
+				mn = min_t(int, mn, sinfo.chains);
+				for (z = 0; z < mn; z++) {
+					sig_accum_chain[z] += sinfo.chain_signal[z];
+					amt_accum_chain[z]++;
+				}
 			}
-			i += 2;
+			i++;
+
+			if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG)) {
+				int mn;
+
+				mn = min_t(int, sizeof(u64), ARRAY_SIZE(sinfo.chain_signal_avg));
+				mn = min_t(int, mn, sinfo.chains);
+				for (z = 0; z < mn; z++) {
+					sig_accum_chain_avg[z] += sinfo.chain_signal_avg[z];
+					amt_accum_chain_avg[z]++;
+				}
+			}
+			i++;
 
 			/*pr_err("sta: %p (%s) sig_accum: %ld  amt-sig: %d filled: 0x%x:%08x rpt-sig-avg: %d  i: %d  div: %d sinfo.signal_avg: %d\n",
 			       sta, sta->sdata->name, (long)(sig_accum), amt_sig, (u32)(sinfo.filled >> 32),
@@ -209,6 +259,39 @@ static void ieee80211_get_stats2(struct net_device *dev,
 			       sinfo.signal_avg);*/
 
 		}
+
+		/* Do averaging */
+		i = start_accum_idx;
+
+		if (amt_tx)
+			data[i] = mac_div(tx_accum, amt_tx);
+		i++;
+
+		if (amt_rx)
+			data[i] = mac_div(rx_accum, amt_rx);
+		i++;
+
+		if (amt_sig) {
+			data[i] = (mac_div(sig_accum, amt_sig) & 0xFF);
+			data[i + 1] = (mac_div(sig_accum_beacon, amt_sig) & 0xFF);
+		}
+		i += 2;
+
+		for (z = 0; z < sizeof(u64); z++) {
+			if (amt_accum_chain[z]) {
+				u64 val = mac_div(sig_accum_chain[z], amt_accum_chain[z]);
+
+				val |= 0xFF;
+				data[i] |= (val << (z * 8));
+			}
+			if (amt_accum_chain_avg[z]) {
+				u64 val = mac_div(sig_accum_chain_avg[z], amt_accum_chain_avg[z]);
+
+				val |= 0xFF;
+				data[i + 1] |= (val << (z * 8));
+			}
+		}
+		i += 2;
 	}
 
 do_survey:
-- 
2.20.1

