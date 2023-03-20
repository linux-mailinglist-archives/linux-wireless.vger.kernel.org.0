Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C26C0EFA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 11:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCTKf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 06:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCTKee (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 06:34:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B319C41
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679308446; x=1710844446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YnNN8Kqqk3yykvCoynyqT8gONe5NTGYhyH2FWy096Vo=;
  b=Yj3rSKlXkyStfRfnQ6dhlBpIDa3jW4VzV//8wtrMi3w8NwyvGpgGyYNL
   KDaHmjNqt2OlmE2fvKTL8PuSNC8wwX3p2GEEEWitiqKf31Ujg6msTVTH9
   ciheUE9KPIEERpAsrDGlFOQM4au9DyWFV19dhvq0Wsi9m5RedAbYGpotK
   7ACGluR2XiJcOsEROMoiaHQy2Hy8Pg8mj9uPUG0qSECaU/DqCbde2Je68
   Bx9XwNjKD1kamSuZYT2e8sxy1xAu6wcse6g+4t1UPEgoJ+QwhU9hhE+5g
   AIe6qKYQsGa3p6lhlKOLuG3uWoy8a4PxgRRUoSXTDEqEwIAJL8CFb+udz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="326997899"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="326997899"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713523661"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713523661"
Received: from ranikhou-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.179.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:33:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/18] wifi: iwlwifi: mvm: implement PHC clock adjustments
Date:   Mon, 20 Mar 2023 12:33:07 +0200
Message-Id: <20230320122330.f59750deeee4.I110a7e3ac3c6d39d9dbe1fe77001e3f5bc3814eb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230320103319.1309442-1-gregory.greenman@intel.com>
References: <20230320103319.1309442-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Implement the following PHC operations:
1. adjtime - for adding an offset to the PHC clock time.
2. adjfine - for adjusting the PHC clock frequency.
3. gettime64 - for getting the PHC clock time. This function returns
   the time as adjusted by adjtime and adjfine.

The adjusted time will also be used for time sync frames timestamping.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  21 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  | 127 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/time-sync.c    |  28 ++--
 3 files changed, 158 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b6b73164357d..2cd86237bc14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -775,10 +775,26 @@ struct iwl_mvm_dqa_txq_info {
 struct ptp_data {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_info;
-	/* keeps track of GP2 wrap-around */
+
+	struct delayed_work dwork;
+
+	/* The last GP2 reading from the hw */
 	u32 last_gp2;
+
+	/* number of wraparounds since scale_update_adj_time_ns */
 	u32 wrap_counter;
-	struct delayed_work dwork;
+
+	/* GP2 time when the scale was last updated */
+	u32 scale_update_gp2;
+
+	/* Adjusted time when the scale was last updated in nanoseconds */
+	u64 scale_update_adj_time_ns;
+
+	/* clock frequency offset, scaled to 65536000000 */
+	u64 scaled_freq;
+
+	/* Delta between hardware clock and ptp clock in nanoseconds */
+	s64 delta;
 };
 
 struct iwl_time_sync_data {
@@ -2144,6 +2160,7 @@ void iwl_mvm_event_frame_timeout_callback(struct iwl_mvm *mvm,
 
 void iwl_mvm_ptp_init(struct iwl_mvm *mvm);
 void iwl_mvm_ptp_remove(struct iwl_mvm *mvm);
+u64 iwl_mvm_ptp_get_adj_time(struct iwl_mvm *mvm, u64 base_time);
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b);
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm);
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
index 10f23c8b1dd4..1eafaaed415d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -6,12 +6,31 @@
 #include "mvm.h"
 #include "iwl-debug.h"
 #include <linux/timekeeping.h>
+#include <linux/math64.h>
 
 #define IWL_PTP_GP2_WRAP	0x100000000ULL
 #define IWL_PTP_WRAP_TIME	(3600 * HZ)
 
+/* The scaled_ppm parameter is ppm (parts per million) with a 16-bit fractional
+ * part, which means that a value of 1 in one of those fields actually means
+ * 2^-16 ppm, and 2^16=65536 is 1 ppm.
+ */
+#define SCALE_FACTOR	65536000000ULL
+#define IWL_PTP_WRAP_THRESHOLD_USEC	(5000)
+
 static void iwl_mvm_ptp_update_new_read(struct iwl_mvm *mvm, u32 gp2)
 {
+	/* If the difference is above the threshold, assume it's a wraparound.
+	 * Otherwise assume it's an old read and ignore it.
+	 */
+	if (gp2 < mvm->ptp_data.last_gp2 &&
+	    mvm->ptp_data.last_gp2 - gp2 < IWL_PTP_WRAP_THRESHOLD_USEC) {
+		IWL_DEBUG_INFO(mvm,
+			       "PTP: ignore old read (gp2=%u, last_gp2=%u)\n",
+			       gp2, mvm->ptp_data.last_gp2);
+		return;
+	}
+
 	if (gp2 < mvm->ptp_data.last_gp2) {
 		mvm->ptp_data.wrap_counter++;
 		IWL_DEBUG_INFO(mvm,
@@ -23,6 +42,45 @@ static void iwl_mvm_ptp_update_new_read(struct iwl_mvm *mvm, u32 gp2)
 	schedule_delayed_work(&mvm->ptp_data.dwork, IWL_PTP_WRAP_TIME);
 }
 
+u64 iwl_mvm_ptp_get_adj_time(struct iwl_mvm *mvm, u64 base_time_ns)
+{
+	struct ptp_data *data = &mvm->ptp_data;
+	u64 last_gp2_ns = mvm->ptp_data.scale_update_gp2 * NSEC_PER_USEC;
+	u64 res;
+	u64 diff;
+
+	iwl_mvm_ptp_update_new_read(mvm,
+				    div64_u64(base_time_ns, NSEC_PER_USEC));
+
+	IWL_DEBUG_INFO(mvm, "base_time_ns=%llu, wrap_counter=%u\n",
+		       (unsigned long long)base_time_ns, data->wrap_counter);
+
+	base_time_ns = base_time_ns +
+		(data->wrap_counter * IWL_PTP_GP2_WRAP * NSEC_PER_USEC);
+
+	/* It is possible that a GP2 timestamp was received from fw before the
+	 * last scale update. Since we don't know how to scale - ignore it.
+	 */
+	if (base_time_ns < last_gp2_ns) {
+		IWL_DEBUG_INFO(mvm, "Time before scale update - ignore\n");
+		return 0;
+	}
+
+	diff = base_time_ns - last_gp2_ns;
+	IWL_DEBUG_INFO(mvm, "diff ns=%llu\n", (unsigned long long)diff);
+
+	diff = mul_u64_u64_div_u64(diff, data->scaled_freq,
+				   SCALE_FACTOR);
+	IWL_DEBUG_INFO(mvm, "scaled diff ns=%llu\n", (unsigned long long)diff);
+
+	res = data->scale_update_adj_time_ns + data->delta + diff;
+
+	IWL_DEBUG_INFO(mvm, "base=%llu delta=%lld adj=%llu\n",
+		       (unsigned long long)base_time_ns, (long long)data->delta,
+		       (unsigned long long)res);
+	return res;
+}
+
 static int
 iwl_mvm_get_crosstimestamp_fw(struct iwl_mvm *mvm, u32 *gp2, u64 *sys_time)
 {
@@ -96,10 +154,7 @@ iwl_mvm_phc_get_crosstimestamp(struct ptp_clock_info *ptp,
 				      &sys_time);
 	}
 
-	iwl_mvm_ptp_update_new_read(mvm, gp2);
-
-	gp2_ns = (gp2 + (mvm->ptp_data.wrap_counter * IWL_PTP_GP2_WRAP)) *
-		NSEC_PER_USEC;
+	gp2_ns = iwl_mvm_ptp_get_adj_time(mvm, (u64)gp2 * NSEC_PER_USEC);
 
 	IWL_INFO(mvm, "Got Sync Time: GP2:%u, last_GP2: %u, GP2_ns: %lld, sys_time: %lld\n",
 		 gp2, mvm->ptp_data.last_gp2, gp2_ns, (s64)sys_time);
@@ -125,6 +180,66 @@ static void iwl_mvm_ptp_work(struct work_struct *wk)
 	mutex_unlock(&mvm->mutex);
 }
 
+static int iwl_mvm_ptp_gettime(struct ptp_clock_info *ptp,
+			       struct timespec64 *ts)
+{
+	struct iwl_mvm *mvm = container_of(ptp, struct iwl_mvm,
+					   ptp_data.ptp_clock_info);
+	u64 gp2;
+	u64 ns;
+
+	mutex_lock(&mvm->mutex);
+	gp2 = iwl_mvm_get_systime(mvm);
+	ns = iwl_mvm_ptp_get_adj_time(mvm, gp2 * NSEC_PER_USEC);
+	mutex_unlock(&mvm->mutex);
+
+	*ts = ns_to_timespec64(ns);
+	return 0;
+}
+
+static int iwl_mvm_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct iwl_mvm *mvm = container_of(ptp, struct iwl_mvm,
+					   ptp_data.ptp_clock_info);
+	struct ptp_data *data = container_of(ptp, struct ptp_data,
+					     ptp_clock_info);
+
+	mutex_lock(&mvm->mutex);
+	data->delta += delta;
+	IWL_DEBUG_INFO(mvm, "delta=%lld, new delta=%lld\n", (long long)delta,
+		       (long long)data->delta);
+	mutex_unlock(&mvm->mutex);
+	return 0;
+}
+
+static int iwl_mvm_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct iwl_mvm *mvm = container_of(ptp, struct iwl_mvm,
+					   ptp_data.ptp_clock_info);
+	struct ptp_data *data = &mvm->ptp_data;
+	u32 gp2;
+
+	mutex_lock(&mvm->mutex);
+
+	/* Must call _iwl_mvm_ptp_get_adj_time() before updating
+	 * data->scale_update_gp2 or data->scaled_freq since
+	 * scale_update_adj_time_ns should reflect the previous scaled_freq.
+	 */
+	gp2 = iwl_mvm_get_systime(mvm);
+	data->scale_update_adj_time_ns =
+		iwl_mvm_ptp_get_adj_time(mvm, gp2 * NSEC_PER_USEC);
+	data->scale_update_gp2 = gp2;
+	data->wrap_counter = 0;
+	data->delta = 0;
+
+	data->scaled_freq = SCALE_FACTOR + scaled_ppm;
+	IWL_DEBUG_INFO(mvm, "adjfine: scaled_ppm=%ld new=%llu\n",
+		       scaled_ppm, (unsigned long long)data->scaled_freq);
+
+	mutex_unlock(&mvm->mutex);
+	return 0;
+}
+
 /* iwl_mvm_ptp_init - initialize PTP for devices which support it.
  * @mvm: internal mvm structure, see &struct iwl_mvm.
  *
@@ -140,6 +255,10 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
 	mvm->ptp_data.ptp_clock_info.max_adj = 0x7fffffff;
 	mvm->ptp_data.ptp_clock_info.getcrosststamp =
 					iwl_mvm_phc_get_crosstimestamp;
+	mvm->ptp_data.ptp_clock_info.adjfine = iwl_mvm_ptp_adjfine;
+	mvm->ptp_data.ptp_clock_info.adjtime = iwl_mvm_ptp_adjtime;
+	mvm->ptp_data.ptp_clock_info.gettime64 = iwl_mvm_ptp_gettime;
+	mvm->ptp_data.scaled_freq = SCALE_FACTOR;
 
 	/* Give a short 'friendly name' to identify the PHC clock */
 	snprintf(mvm->ptp_data.ptp_clock_info.name,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
index b42e58e5ff24..434d27a44dea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
@@ -66,19 +66,22 @@ void iwl_mvm_time_sync_msmt_event(struct iwl_mvm *mvm,
 	struct sk_buff *skb =
 		iwl_mvm_time_sync_find_skb(mvm, notif->peer_addr,
 					   le32_to_cpu(notif->dialog_token));
+	u64 adj_time;
 
 	if (!skb) {
 		IWL_DEBUG_INFO(mvm, "Time sync event but no pending skb\n");
 		return;
 	}
 
-	ts_10ns = iwl_mvm_get_64_bit(notif->t3_hi, notif->t3_lo);
-	rx_status = IEEE80211_SKB_RXCB(skb);
-	rx_status->ack_tx_hwtstamp = ktime_set(0, ts_10ns * 10);
-
 	ts_10ns = iwl_mvm_get_64_bit(notif->t2_hi, notif->t2_lo);
+	adj_time = iwl_mvm_ptp_get_adj_time(mvm, ts_10ns * 10);
 	shwt = skb_hwtstamps(skb);
-	shwt->hwtstamp = ktime_set(0, ts_10ns * 10);
+	shwt->hwtstamp = ktime_set(0, adj_time);
+
+	ts_10ns = iwl_mvm_get_64_bit(notif->t3_hi, notif->t3_lo);
+	adj_time = iwl_mvm_ptp_get_adj_time(mvm, ts_10ns * 10);
+	rx_status = IEEE80211_SKB_RXCB(skb);
+	rx_status->ack_tx_hwtstamp = ktime_set(0, adj_time);
 
 	IWL_DEBUG_INFO(mvm,
 		       "Time sync: RX event - report frame t2=%llu t3=%llu\n",
@@ -94,7 +97,7 @@ void iwl_mvm_time_sync_msmt_confirm_event(struct iwl_mvm *mvm,
 	struct iwl_time_msmt_cfm_notify *notif = (void *)pkt->data;
 	struct ieee80211_tx_status status = {};
 	struct skb_shared_hwtstamps *shwt;
-	u64 ts_10ns;
+	u64 ts_10ns, adj_time;
 
 	status.skb =
 		iwl_mvm_time_sync_find_skb(mvm, notif->peer_addr,
@@ -105,14 +108,15 @@ void iwl_mvm_time_sync_msmt_confirm_event(struct iwl_mvm *mvm,
 		return;
 	}
 
-	status.info = IEEE80211_SKB_CB(status.skb);
-
-	ts_10ns = iwl_mvm_get_64_bit(notif->t4_hi, notif->t4_lo);
-	status.ack_hwtstamp = ktime_set(0, ts_10ns * 10);
-
 	ts_10ns = iwl_mvm_get_64_bit(notif->t1_hi, notif->t1_lo);
+	adj_time = iwl_mvm_ptp_get_adj_time(mvm, ts_10ns * 10);
 	shwt = skb_hwtstamps(status.skb);
-	shwt->hwtstamp = ktime_set(0, ts_10ns * 10);
+	shwt->hwtstamp = ktime_set(0, adj_time);
+
+	ts_10ns = iwl_mvm_get_64_bit(notif->t4_hi, notif->t4_lo);
+	adj_time = iwl_mvm_ptp_get_adj_time(mvm, ts_10ns * 10);
+	status.info = IEEE80211_SKB_CB(status.skb);
+	status.ack_hwtstamp = ktime_set(0, adj_time);
 
 	IWL_DEBUG_INFO(mvm,
 		       "Time sync: TX event - report frame t1=%llu t4=%llu\n",
-- 
2.38.1

