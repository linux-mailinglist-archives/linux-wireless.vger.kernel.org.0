Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABC27E9FC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgI3Nbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730169AbgI3Nbb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:31 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCc-002MJ5-Vj; Wed, 30 Sep 2020 16:31:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:12 +0300
Message-Id: <iwlwifi.20200930161256.48a9cec2081b.Iaec1e29f738232adfe9e2ea8e9eb9b6ff0323ae1@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: mvm: Add FTM initiator RTT smoothing logic
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The overcome instabilities in the RTT results add smoothing logic
to the reported results. In short, the smoothing logic tracks the
RTT average of each responder for a period of time, and in case
a new RTT results is found to be a spur, the tracked RTT average
is reported instead of the current RTT measurement.

Smooth logic debug configuration using iwl-dbg-cfg.ini:

- MVM_FTM_INITIATOR_ENABLE_SMOOTH: Set to 1 to enable smoothing logic
 (default=0).
- MVM_FTM_INITIATOR_SMOOTH_ALPHA: A value between 0 - 100, defining
  the weight of the current RTT results vs. the RTT average tracked
  based on the previous results. A value of 100 means use only the
  current RTT results.
- MVM_FTM_INITIATOR_SMOOTH_AGE_SEC: The maximal time in seconds in which
  the RTT average tracked based on previous results is considered valid.
- MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT: if the current RTT is positive
  and below the RTT average by at least this value, report the average
  RTT instead of the current one. In units of picoseconds.
- MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT: if the current RTT is positive
  and above the RTT average by at least this value, report the average
  RTT instead of the current one. In units of picoseconds.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/constants.h    |   6 +
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 123 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 +
 5 files changed, 138 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 426ca1f86500..2487871eac73 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -159,5 +159,11 @@
 #define IWL_MVM_PHY_FILTER_CHAIN_B		0
 #define IWL_MVM_PHY_FILTER_CHAIN_C		0
 #define IWL_MVM_PHY_FILTER_CHAIN_D		0
+#define IWL_MVM_FTM_INITIATOR_ENABLE_SMOOTH     false
+#define IWL_MVM_FTM_INITIATOR_SMOOTH_ALPHA      40
+/*  20016 pSec is 6 meter RTT, meaning 3 meter range */
+#define IWL_MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT 20016
+#define IWL_MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT  20016
+#define IWL_MVM_FTM_INITIATOR_SMOOTH_AGE_SEC    2
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 7efc6cb2d610..65dc443f37df 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -76,6 +76,13 @@ struct iwl_mvm_loc_entry {
 	u8 buf[];
 };
 
+struct iwl_mvm_smooth_entry {
+	struct list_head list;
+	u8 addr[ETH_ALEN];
+	s64 rtt_avg;
+	u64 host_time;
+};
+
 static void iwl_mvm_ftm_reset(struct iwl_mvm *mvm)
 {
 	struct iwl_mvm_loc_entry *e, *t;
@@ -84,6 +91,7 @@ static void iwl_mvm_ftm_reset(struct iwl_mvm *mvm)
 	mvm->ftm_initiator.req_wdev = NULL;
 	memset(mvm->ftm_initiator.responses, 0,
 	       sizeof(mvm->ftm_initiator.responses));
+
 	list_for_each_entry_safe(e, t, &mvm->ftm_initiator.loc_list, list) {
 		list_del(&e->list);
 		kfree(e);
@@ -120,6 +128,30 @@ void iwl_mvm_ftm_restart(struct iwl_mvm *mvm)
 	iwl_mvm_ftm_reset(mvm);
 }
 
+void iwl_mvm_ftm_initiator_smooth_config(struct iwl_mvm *mvm)
+{
+	INIT_LIST_HEAD(&mvm->ftm_initiator.smooth.resp);
+
+	IWL_DEBUG_INFO(mvm,
+		       "enable=%u, alpha=%u, age_jiffies=%u, thresh=(%u:%u)\n",
+			IWL_MVM_FTM_INITIATOR_ENABLE_SMOOTH,
+			IWL_MVM_FTM_INITIATOR_SMOOTH_ALPHA,
+			IWL_MVM_FTM_INITIATOR_SMOOTH_AGE_SEC * HZ,
+			IWL_MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT,
+			IWL_MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT);
+}
+
+void iwl_mvm_ftm_initiator_smooth_stop(struct iwl_mvm *mvm)
+{
+	struct iwl_mvm_smooth_entry *se, *st;
+
+	list_for_each_entry_safe(se, st, &mvm->ftm_initiator.smooth.resp,
+				 list) {
+		list_del(&se->list);
+		kfree(se);
+	}
+}
+
 static int
 iwl_ftm_range_request_status_to_err(enum iwl_tof_range_request_status s)
 {
@@ -728,6 +760,95 @@ static int iwl_mvm_ftm_range_resp_valid(struct iwl_mvm *mvm, u8 request_id,
 	return 0;
 }
 
+static void iwl_mvm_ftm_rtt_smoothing(struct iwl_mvm *mvm,
+				      struct cfg80211_pmsr_result *res)
+{
+	struct iwl_mvm_smooth_entry *resp;
+	s64 rtt_avg, rtt = res->ftm.rtt_avg;
+	u32 undershoot, overshoot;
+	u8 alpha;
+	bool found;
+
+	if (!IWL_MVM_FTM_INITIATOR_ENABLE_SMOOTH)
+		return;
+
+	WARN_ON(rtt < 0);
+
+	if (res->status != NL80211_PMSR_STATUS_SUCCESS) {
+		IWL_DEBUG_INFO(mvm,
+			       ": %pM: ignore failed measurement. Status=%u\n",
+			       res->addr, res->status);
+		return;
+	}
+
+	found = false;
+	list_for_each_entry(resp, &mvm->ftm_initiator.smooth.resp, list) {
+		if (!memcmp(res->addr, resp->addr, ETH_ALEN)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		resp = kzalloc(sizeof(*resp), GFP_KERNEL);
+		if (!resp)
+			return;
+
+		memcpy(resp->addr, res->addr, ETH_ALEN);
+		list_add_tail(&resp->list, &mvm->ftm_initiator.smooth.resp);
+
+		resp->rtt_avg = rtt;
+
+		IWL_DEBUG_INFO(mvm, "new: %pM: rtt_avg=%lld\n",
+			       resp->addr, resp->rtt_avg);
+		goto update_time;
+	}
+
+	if (res->host_time - resp->host_time >
+	    IWL_MVM_FTM_INITIATOR_SMOOTH_AGE_SEC * 1000000000) {
+		resp->rtt_avg = rtt;
+
+		IWL_DEBUG_INFO(mvm, "expired: %pM: rtt_avg=%lld\n",
+			       resp->addr, resp->rtt_avg);
+		goto update_time;
+	}
+
+	/* Smooth the results based on the tracked RTT average */
+	undershoot = IWL_MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT;
+	overshoot = IWL_MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT;
+	alpha = IWL_MVM_FTM_INITIATOR_SMOOTH_ALPHA;
+
+	rtt_avg = (alpha * rtt + (100 - alpha) * resp->rtt_avg) / 100;
+
+	IWL_DEBUG_INFO(mvm,
+		       "%pM: prev rtt_avg=%lld, new rtt_avg=%lld, rtt=%lld\n",
+		       resp->addr, resp->rtt_avg, rtt_avg, rtt);
+
+	/*
+	 * update the responder's average RTT results regardless of
+	 * the under/over shoot logic below
+	 */
+	resp->rtt_avg = rtt_avg;
+
+	/* smooth the results */
+	if (rtt_avg > rtt && (rtt_avg - rtt) > undershoot) {
+		res->ftm.rtt_avg = rtt_avg;
+
+		IWL_DEBUG_INFO(mvm,
+			       "undershoot: val=%lld\n",
+			       (rtt_avg - rtt));
+	} else if (rtt_avg < rtt && (rtt - rtt_avg) >
+		   overshoot) {
+		res->ftm.rtt_avg = rtt_avg;
+		IWL_DEBUG_INFO(mvm,
+			       "overshoot: val=%lld\n",
+			       (rtt - rtt_avg));
+	}
+
+update_time:
+	resp->host_time = res->host_time;
+}
+
 static void iwl_mvm_debug_range_resp(struct iwl_mvm *mvm, u8 index,
 				     struct cfg80211_pmsr_result *res)
 {
@@ -865,6 +986,8 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 
 		iwl_mvm_ftm_get_lci_civic(mvm, &result);
 
+		iwl_mvm_ftm_rtt_smoothing(mvm, &result);
+
 		cfg80211_pmsr_report(mvm->ftm_initiator.req_wdev,
 				     mvm->ftm_initiator.req,
 				     &result, GFP_KERNEL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 4d4315bc669e..897249201b06 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1512,6 +1512,8 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	iwl_mvm_tas_init(mvm);
 	iwl_mvm_leds_sync(mvm);
 
+	iwl_mvm_ftm_initiator_smooth_config(mvm);
+
 	IWL_DEBUG_INFO(mvm, "RT uCode started.\n");
 	return 0;
  error:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 30e5a5b5664e..1c5f18d1b4c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1211,6 +1211,8 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 {
 	lockdep_assert_held(&mvm->mutex);
 
+	iwl_mvm_ftm_initiator_smooth_stop(mvm);
+
 	/* firmware counters are obviously reset now, but we shouldn't
 	 * partially track so also clear the fw_reset_accu counters.
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c57d45090715..ba1b74d10577 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1107,6 +1107,9 @@ struct iwl_mvm {
 		struct wireless_dev *req_wdev;
 		struct list_head loc_list;
 		int responses[IWL_MVM_TOF_MAX_APS];
+		struct {
+			struct list_head resp;
+		} smooth;
 	} ftm_initiator;
 
 	struct list_head resp_pasn_list;
@@ -2011,6 +2014,8 @@ void iwl_mvm_ftm_lc_notif(struct iwl_mvm *mvm,
 int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		      struct cfg80211_pmsr_request *request);
 void iwl_mvm_ftm_abort(struct iwl_mvm *mvm, struct cfg80211_pmsr_request *req);
+void iwl_mvm_ftm_initiator_smooth_config(struct iwl_mvm *mvm);
+void iwl_mvm_ftm_initiator_smooth_stop(struct iwl_mvm *mvm);
 
 /* TDLS */
 
-- 
2.28.0

