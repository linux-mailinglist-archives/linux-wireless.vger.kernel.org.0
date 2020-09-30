Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C372627EEE1
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgI3QUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:20:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731240AbgI3QUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:20:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNeps-002MPc-3d; Wed, 30 Sep 2020 19:20:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:54 +0300
Message-Id: <iwlwifi.20200930191738.6e1d2b8b4489.I9584bb40d44bf31131f57fdd32d5e8848d4fbdd8@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930161959.983283-1-luca@coelho.fi>
References: <20200930161959.983283-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: mvm: ignore the scan duration parameter
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The scan request may specify the request scan dwell time.
However, this value may not always be optimal (e.g. short dwell
time for a passive channel). This may happen in a scan request
as a result of beacon report request, in which the AP may request
an active scan, thus setting a short dwell time, but the station
will perform a passive scan due to regulatory.

Ignore the scan duration parameter and always use the internal
scan dwell time which should be optimal.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 55 ++++---------------
 1 file changed, 10 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 05e0686ff4e0..1fbb52713493 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -147,7 +147,7 @@ struct iwl_mvm_scan_params {
 	struct cfg80211_match_set *match_sets;
 	int n_scan_plans;
 	struct cfg80211_sched_scan_plan *scan_plans;
-	u32 measurement_dwell;
+	bool iter_notif;
 };
 
 static inline void *iwl_mvm_get_scan_req_umac_data(struct iwl_mvm *mvm)
@@ -337,33 +337,6 @@ iwl_mvm_scan_type iwl_mvm_get_scan_type_band(struct iwl_mvm *mvm,
 	return _iwl_mvm_get_scan_type(mvm, vif, load, low_latency);
 }
 
-static int
-iwl_mvm_get_measurement_dwell(struct iwl_mvm *mvm,
-			      struct cfg80211_scan_request *req,
-			      struct iwl_mvm_scan_params *params)
-{
-	u32 duration = scan_timing[params->type].max_out_time;
-
-	if (!req->duration)
-		return 0;
-
-	if (iwl_mvm_is_cdb_supported(mvm)) {
-		u32 hb_time = scan_timing[params->hb_type].max_out_time;
-
-		duration = min_t(u32, duration, hb_time);
-	}
-
-	if (req->duration_mandatory && req->duration > duration) {
-		IWL_DEBUG_SCAN(mvm,
-			       "Measurement scan - too long dwell %hu (max out time %u)\n",
-			       req->duration,
-			       duration);
-		return -EOPNOTSUPP;
-	}
-
-	return min_t(u32, (u32)req->duration, duration);
-}
-
 static inline bool iwl_mvm_rrm_scan_needed(struct iwl_mvm *mvm)
 {
 	/* require rrm scan whenever the fw supports it */
@@ -1333,10 +1306,8 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 	u8 active_dwell, passive_dwell;
 
 	timing = &scan_timing[params->type];
-	active_dwell = params->measurement_dwell ?
-		params->measurement_dwell : IWL_SCAN_DWELL_ACTIVE;
-	passive_dwell = params->measurement_dwell ?
-		params->measurement_dwell : IWL_SCAN_DWELL_PASSIVE;
+	active_dwell = IWL_SCAN_DWELL_ACTIVE;
+	passive_dwell = IWL_SCAN_DWELL_PASSIVE;
 
 	if (iwl_mvm_is_adaptive_dwell_supported(mvm)) {
 		cmd->v7.adwell_default_n_aps_social =
@@ -1389,8 +1360,7 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 			}
 		}
 	} else {
-		cmd->v1.extended_dwell = params->measurement_dwell ?
-			params->measurement_dwell : IWL_SCAN_DWELL_EXTENDED;
+		cmd->v1.extended_dwell = IWL_SCAN_DWELL_EXTENDED;
 		cmd->v1.active_dwell = active_dwell;
 		cmd->v1.passive_dwell = passive_dwell;
 		cmd->v1.fragmented_dwell = IWL_SCAN_DWELL_FRAGMENTED;
@@ -1443,10 +1413,8 @@ iwl_mvm_scan_umac_dwell_v10(struct iwl_mvm *mvm,
 	u8 active_dwell, passive_dwell;
 
 	timing = &scan_timing[params->type];
-	active_dwell = params->measurement_dwell ?
-		params->measurement_dwell : IWL_SCAN_DWELL_ACTIVE;
-	passive_dwell = params->measurement_dwell ?
-		params->measurement_dwell : IWL_SCAN_DWELL_PASSIVE;
+	active_dwell = IWL_SCAN_DWELL_ACTIVE;
+	passive_dwell = IWL_SCAN_DWELL_PASSIVE;
 
 	general_params->adwell_default_social_chn =
 		IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL;
@@ -1737,7 +1705,7 @@ static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 	if (!iwl_mvm_is_regular_scan(params))
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_PERIODIC;
 
-	if (params->measurement_dwell ||
+	if (params->iter_notif ||
 	    mvm->sched_scan_pass_all == SCHED_SCAN_PASS_ALL_ENABLED)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_V2_NTFY_ITER_COMPLETE;
 
@@ -1782,7 +1750,7 @@ static u16 iwl_mvm_scan_umac_flags(struct iwl_mvm *mvm,
 	if (!iwl_mvm_is_regular_scan(params))
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_PERIODIC;
 
-	if (params->measurement_dwell)
+	if (params->iter_notif)
 		flags |= IWL_UMAC_SCAN_GEN_FLAGS_ITER_COMPLETE;
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -2294,11 +2262,8 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_fill_scan_type(mvm, &params, vif);
 
-	ret = iwl_mvm_get_measurement_dwell(mvm, req, &params);
-	if (ret < 0)
-		return ret;
-
-	params.measurement_dwell = ret;
+	if (req->duration)
+		params.iter_notif = true;
 
 	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
 
-- 
2.28.0

