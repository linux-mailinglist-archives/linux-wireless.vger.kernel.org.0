Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57094C5212
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 00:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiBYX3Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 18:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYX3X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 18:29:23 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7092512341F
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 15:28:50 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.178])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C95D5A0072
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 23:28:48 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8EA76B00073
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 23:28:48 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C519213C2B1;
        Fri, 25 Feb 2022 15:28:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C519213C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1645831726;
        bh=SOgNkJ+tVvxCbhPn62IQ55zzD8Q07mwJTViJe/ax/KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDONa9t1yTukSa/M6tVt+2HceAxQZyR13YPHV5f9OgfP1hPG4OdE06HjkVNeFHq5X
         +i7gLInYYIfr+xpvpXSG27KG0CiaQ4V0hvehmfS6sPZnHLYdRRi5QGpnqlQsk01KzE
         ZuswufbHGrKmhtw29ZdKgu3jwxGJPEId291iirR0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] iwlwifi:  RX signal improvements.
Date:   Fri, 25 Feb 2022 15:28:42 -0800
Message-Id: <20220225232842.32028-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220225232842.32028-1-greearb@candelatech.com>
References: <20220225232842.32028-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1645831729-Yj5OanO9O2gZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Sum up multi-chain signals instead of just taking the maximum value.
This gives more correct total on-air signal value.

And, the firmware managed averages do not match expected per-packet values,
so ignore those for MQ drivers and instead calculate averages in the driver
and report that.

Combined with the previous patch, this gives better looking RX signal report:

	signal:  	-39 [-42, -41] dBm
	signal avg:	-39 [-42, -41] dBm
	beacon signal avg:	-46 dBm

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 38 ++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 34 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 41 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  5 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  7 ++++
 6 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 959ad85e3430..c11b20d847f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4869,9 +4869,32 @@ static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-	if (mvmsta->avg_energy) {
-		sinfo->signal_avg = -(s8)mvmsta->avg_energy;
+	if (iwl_mvm_has_new_rx_api(mvm)) { /* rxmq logic */
+		/* Grab chain signal avg, mac80211 cannot do it because
+		 * this driver uses RSS.  Grab signal_avg here too because firmware
+		 * appears go not do DB summing and/or has other bugs. --Ben
+		 */
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+		sinfo->signal_avg = -ewma_signal_read(&mvmsta->rx_avg_signal);
+
+		if (!mvmvif->bf_data.bf_enabled) {
+			/* The firmware reliably reports different signal (2db weaker in my case)
+			 * than if I calculate it from the rx-status.  So, fill that here.
+			 * Beacons are only received if you turn off beacon filtering, however.
+			 */
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
+			sinfo->rx_beacon_signal_avg = -ewma_signal_read(&mvmsta->rx_avg_beacon_signal);
+		}
+
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
+		sinfo->chain_signal_avg[0] = -ewma_signal_read(&mvmsta->rx_avg_chain_signal[0]);
+		sinfo->chain_signal_avg[1] = -ewma_signal_read(&mvmsta->rx_avg_chain_signal[1]);
+	}
+	else {
+		if (mvmsta->avg_energy) {
+			sinfo->signal_avg = -(s8)mvmsta->avg_energy;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+		}
 	}
 
 	if (iwl_mvm_has_tlc_offload(mvm)) {
@@ -4899,10 +4922,13 @@ static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->rx_beacon = mvmvif->beacon_stats.num_beacons +
 			   mvmvif->beacon_stats.accu_num_beacons;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX);
-	if (mvmvif->beacon_stats.avg_signal) {
-		/* firmware only reports a value after RXing a few beacons */
-		sinfo->rx_beacon_signal_avg = mvmvif->beacon_stats.avg_signal;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
+
+	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))) {
+		if (mvmvif->beacon_stats.avg_signal) {
+			/* firmware only reports a value after RXing a few beacons */
+			sinfo->rx_beacon_signal_avg = mvmvif->beacon_stats.avg_signal;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
+		}
 	}
  unlock:
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index cd5645c3d15c..421094477edd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2150,4 +2150,38 @@ enum iwl_location_cipher iwl_mvm_cipher_to_location_cipher(u32 cipher)
 		return IWL_LOCATION_CIPHER_INVALID;
 	}
 }
+
+static inline int iwl_mvm_sum_sigs_2(int a, int b)
+{
+       int diff;
+
+       /* S8_MIN means value-is-not-set */
+       if (b == S8_MIN)
+               return a;
+       if (a == S8_MIN)
+               return b;
+
+       if (a >= b) {
+               /* a is largest value, add to it. */
+               diff = a - b;
+               if (diff == 0)
+                       return a + 3;
+               else if (diff <= 2)
+                       return a + 2;
+               else if (diff <= 6)
+                       return a + 1;
+               return a;
+       } else {
+               /* b is largest value, add to it. */
+               diff = b - a;
+               if (diff == 0)
+                       return b + 3;
+               else if (diff <= 2)
+                       return b + 2;
+               else if (diff <= 6)
+                       return b + 1;
+               return b;
+       }
+}
+
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index d22f40a5354d..e8d753e855e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -114,7 +114,9 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 	energy_b = (val & IWL_RX_INFO_ENERGY_ANT_B_MSK) >>
 						IWL_RX_INFO_ENERGY_ANT_B_POS;
 	energy_b = energy_b ? -energy_b : S8_MIN;
-	max_energy = max(energy_a, energy_b);
+
+	/* use DB summing to get better RSSI reporting */
+	max_energy = iwl_mvm_sum_sigs_2(energy_a, energy_b);
 
 	IWL_DEBUG_STATS(mvm, "energy In A %d B %d  , and max %d\n",
 			energy_a, energy_b, max_energy);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 31a8c5083f61..489f8a843f82 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -278,14 +278,26 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 					struct ieee80211_rx_status *rx_status,
 					u32 rate_n_flags, int energy_a,
-					int energy_b)
+					int energy_b, struct ieee80211_sta *sta,
+					bool is_beacon, bool my_beacon)
 {
 	int max_energy;
 	u32 rate_flags = rate_n_flags;
+	struct iwl_mvm_sta *mvmsta = NULL;
+
+	if (sta && !(is_beacon && !my_beacon)) {
+		mvmsta = iwl_mvm_sta_from_mac80211(sta);
+		if (energy_a)
+			ewma_signal_add(&mvmsta->rx_avg_chain_signal[0], energy_a);
+		if (energy_b)
+			ewma_signal_add(&mvmsta->rx_avg_chain_signal[1], energy_b);
+	}
 
 	energy_a = energy_a ? -energy_a : S8_MIN;
 	energy_b = energy_b ? -energy_b : S8_MIN;
-	max_energy = max(energy_a, energy_b);
+
+	/* use DB summing to get better RSSI reporting */
+	max_energy = iwl_mvm_sum_sigs_2(energy_a, energy_b);
 
 	IWL_DEBUG_STATS(mvm, "energy In A %d B %d, and max %d\n",
 			energy_a, energy_b, max_energy);
@@ -295,6 +307,15 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 		(rate_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
 	rx_status->chain_signal[0] = energy_a;
 	rx_status->chain_signal[1] = energy_b;
+
+	if (mvmsta) {
+		if (is_beacon) {
+			if (my_beacon)
+				ewma_signal_add(&mvmsta->rx_avg_beacon_signal, -max_energy);
+		} else {
+			ewma_signal_add(&mvmsta->rx_avg_signal, -max_energy);
+		}
+	}
 }
 
 static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
@@ -1685,6 +1706,8 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	};
 	u32 format;
 	bool is_sgi;
+	bool is_beacon;
+	bool my_beacon = false;
 
 	if (unlikely(test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)))
 		return;
@@ -1828,8 +1851,6 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 	rx_status->freq = ieee80211_channel_to_frequency(channel,
 							 rx_status->band);
-	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags, energy_a,
-				    energy_b);
 
 	/* update aggregation data for monitor sake on default queue */
 	if (!queue && (phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
@@ -1878,6 +1899,16 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		goto out;
 	}
 
+	is_beacon = ieee80211_is_beacon(hdr->frame_control);
+	if (is_beacon && sta) {
+		/* see if it is beacon destined for us */
+		if (memcmp(sta->addr, hdr->addr2, ETH_ALEN) == 0)
+			my_beacon = true;
+	}
+
+	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags, energy_a,
+				    energy_b, sta, is_beacon, my_beacon);
+
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 		struct ieee80211_vif *tx_blocked_vif =
@@ -2138,7 +2169,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	rx_status->freq = ieee80211_channel_to_frequency(channel,
 							 rx_status->band);
 	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags, energy_a,
-				    energy_b);
+				    energy_b, sta, false, false);
 
 	rcu_read_lock();
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index a64874c05ced..e54051830f1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1577,6 +1577,11 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 
 	spin_lock_init(&mvm_sta->lock);
 
+	ewma_signal_init(&mvm_sta->rx_avg_chain_signal[0]);
+	ewma_signal_init(&mvm_sta->rx_avg_chain_signal[1]);
+	ewma_signal_init(&mvm_sta->rx_avg_signal);
+	ewma_signal_init(&mvm_sta->rx_avg_beacon_signal);
+
 	/* if this is a HW restart re-alloc existing queues */
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		struct iwl_mvm_int_sta tmp_sta = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 32b4d1935788..4c86e33e1667 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <net/mac80211.h>
 #include <linux/wait.h>
+#include <linux/average.h>
 
 #include "iwl-trans.h" /* for IWL_MAX_TID_COUNT */
 #include "fw-api.h" /* IWL_MVM_STATION_COUNT_MAX */
@@ -18,6 +19,9 @@
 struct iwl_mvm;
 struct iwl_mvm_vif;
 
+/* This makes us a 'struct ewma_signal {' object. */
+DECLARE_EWMA(signal, 10, 8);
+
 /**
  * DOC: DQA - Dynamic Queue Allocation -introduction
  *
@@ -415,6 +419,9 @@ struct iwl_mvm_sta {
 	u8 sleep_tx_count;
 	u8 avg_energy;
 	u8 tx_ant;
+	struct ewma_signal rx_avg_chain_signal[2];
+	struct ewma_signal rx_avg_signal;
+	struct ewma_signal rx_avg_beacon_signal;
 };
 
 u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data);
-- 
2.20.1

