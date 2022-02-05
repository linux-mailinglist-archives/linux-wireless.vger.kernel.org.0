Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B657E4AA7DA
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbiBEJVr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:47 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37984 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244133AbiBEJVq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:46 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGK-0006b7-4y;
        Sat, 05 Feb 2022 11:21:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:30 +0200
Message-Id: <iwlwifi.20220205112029.4412036f4889.Ied677fdd31765437e19905787708bd05f62663ba@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: mvm: Consider P2P GO operation during scan
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

A scan during active P2P GO operation, i.e., data traffic with
clients, can impact the throughput and latency of such traffic.
Thus, when scan is requested while there is an active P2P GO
and low latency is asserted:

- Ask the FW scan logic to respect the P2P GO activity during the
  scheduling of the scan operation to minimize the impact on the
  throughput and latency.
- Force scan to perform EBS before starting the scan to reduce the
  number of scanned channels.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 132 +++++++++++++++++-
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 76c38645fbd7..a4077053e374 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -97,6 +97,7 @@ struct iwl_mvm_scan_params {
 	u32 n_6ghz_params;
 	bool scan_6ghz;
 	bool enable_6ghz_passive;
+	bool respect_p2p_go, respect_p2p_go_hb;
 };
 
 static inline void *iwl_mvm_get_scan_req_umac_data(struct iwl_mvm *mvm)
@@ -1899,6 +1900,19 @@ static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
 	     iwl_mvm_is_scan_fragmented(params->hb_type)))
 		flags |= IWL_SCAN_CHANNEL_FLAG_EBS_FRAG;
 
+	/*
+	 * force EBS in case the scan is a fragmented and there is a need to take P2P
+	 * GO operation into consideration during scan operation.
+	 */
+	if ((!iwl_mvm_is_cdb_supported(mvm) &&
+	     iwl_mvm_is_scan_fragmented(params->type) && params->respect_p2p_go) ||
+	    (iwl_mvm_is_cdb_supported(mvm) &&
+	     iwl_mvm_is_scan_fragmented(params->hb_type) &&
+	     params->respect_p2p_go_hb)) {
+		IWL_DEBUG_SCAN(mvm, "Respect P2P GO. Force EBS\n");
+		flags |= IWL_SCAN_CHANNEL_FLAG_FORCE_EBS;
+	}
+
 	return flags;
 }
 
@@ -2049,6 +2063,26 @@ static u16 iwl_mvm_scan_umac_flags_v2(struct iwl_mvm *mvm,
 	return flags;
 }
 
+static u8 iwl_mvm_scan_umac_flags2(struct iwl_mvm *mvm,
+				   struct iwl_mvm_scan_params *params,
+				   struct ieee80211_vif *vif, int type)
+{
+	u8 flags = 0;
+
+	if (iwl_mvm_is_cdb_supported(mvm)) {
+		if (params->respect_p2p_go)
+			flags |= IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_LB;
+		if (params->respect_p2p_go_hb)
+			flags |= IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_HB;
+	} else {
+		if (params->respect_p2p_go)
+			flags = IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_LB |
+				IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_HB;
+	}
+
+	return flags;
+}
+
 static u16 iwl_mvm_scan_umac_flags(struct iwl_mvm *mvm,
 				   struct iwl_mvm_scan_params *params,
 				   struct ieee80211_vif *vif)
@@ -2251,13 +2285,17 @@ iwl_mvm_scan_umac_fill_general_p_v11(struct iwl_mvm *mvm,
 				     struct iwl_mvm_scan_params *params,
 				     struct ieee80211_vif *vif,
 				     struct iwl_scan_general_params_v11 *gp,
-				     u16 gen_flags)
+				     u16 gen_flags, u8 gen_flags2)
 {
 	struct iwl_mvm_vif *scan_vif = iwl_mvm_vif_from_mac80211(vif);
 
 	iwl_mvm_scan_umac_dwell_v11(mvm, gp, params);
 
+	IWL_DEBUG_SCAN(mvm, "Gerenal: flags=0x%x, flags2=0x%x\n",
+		       gen_flags, gen_flags2);
+
 	gp->flags = cpu_to_le16(gen_flags);
+	gp->flags2 = gen_flags2;
 
 	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC1)
 		gp->num_of_fragments[SCAN_LB_LMAC_IDX] = IWL_SCAN_NUM_OF_FRAGS;
@@ -2361,7 +2399,7 @@ static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
 	iwl_mvm_scan_umac_fill_general_p_v11(mvm, params, vif,
 					     &scan_p->general_params,
-					     gen_flags);
+					     gen_flags, 0);
 
 	ret = iwl_mvm_fill_scan_sched_params(params,
 					     scan_p->periodic_params.schedule,
@@ -2387,6 +2425,7 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 	struct iwl_scan_probe_params_v4 *pb = &scan_p->probe_params;
 	int ret;
 	u16 gen_flags;
+	u8 gen_flags2;
 	u32 bitmap_ssid = 0;
 
 	mvm->scan_uid_status[uid] = type;
@@ -2395,9 +2434,15 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 	cmd->uid = cpu_to_le32(uid);
 
 	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
+
+	if (version >= 15)
+		gen_flags2 = iwl_mvm_scan_umac_flags2(mvm, params, vif, type);
+	else
+		gen_flags2 = 0;
+
 	iwl_mvm_scan_umac_fill_general_p_v11(mvm, params, vif,
 					     &scan_p->general_params,
-					     gen_flags);
+					     gen_flags, gen_flags2);
 
 	ret = iwl_mvm_fill_scan_sched_params(params,
 					     scan_p->periodic_params.schedule,
@@ -2615,6 +2660,85 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 	return uid;
 }
 
+struct iwl_mvm_scan_respect_p2p_go_iter_data {
+	struct ieee80211_vif *current_vif;
+	bool p2p_go;
+	enum nl80211_band band;
+};
+
+static void iwl_mvm_scan_respect_p2p_go_iter(void *_data, u8 *mac,
+					     struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_scan_respect_p2p_go_iter_data *data = _data;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	/* exclude the given vif */
+	if (vif == data->current_vif)
+		return;
+
+	if (vif->type == NL80211_IFTYPE_AP && vif->p2p &&
+	    mvmvif->phy_ctxt->id < NUM_PHY_CTX &&
+	    (data->band == NUM_NL80211_BANDS ||
+	     mvmvif->phy_ctxt->channel->band == data->band))
+		data->p2p_go = true;
+}
+
+static bool _iwl_mvm_get_respect_p2p_go(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					bool low_latency,
+					enum nl80211_band band)
+{
+	struct iwl_mvm_scan_respect_p2p_go_iter_data data = {
+		.current_vif = vif,
+		.p2p_go = false,
+		.band = band,
+	};
+
+	if (!low_latency)
+		return false;
+
+	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   iwl_mvm_scan_respect_p2p_go_iter,
+						   &data);
+
+	return data.p2p_go;
+}
+
+static bool iwl_mvm_get_respect_p2p_go_band(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
+					    enum nl80211_band band)
+{
+	bool low_latency = iwl_mvm_low_latency_band(mvm, band);
+
+	return _iwl_mvm_get_respect_p2p_go(mvm, vif, low_latency, band);
+}
+
+static bool iwl_mvm_get_respect_p2p_go(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif)
+{
+	bool low_latency = iwl_mvm_low_latency(mvm);
+
+	return _iwl_mvm_get_respect_p2p_go(mvm, vif, low_latency,
+					   NUM_NL80211_BANDS);
+}
+
+static void iwl_mvm_fill_respect_p2p_go(struct iwl_mvm *mvm,
+					struct iwl_mvm_scan_params *params,
+					struct ieee80211_vif *vif)
+{
+	if (iwl_mvm_is_cdb_supported(mvm)) {
+		params->respect_p2p_go =
+			iwl_mvm_get_respect_p2p_go_band(mvm, vif,
+							NL80211_BAND_2GHZ);
+		params->respect_p2p_go_hb =
+			iwl_mvm_get_respect_p2p_go_band(mvm, vif,
+							NL80211_BAND_5GHZ);
+	} else {
+		params->respect_p2p_go = iwl_mvm_get_respect_p2p_go(mvm, vif);
+	}
+}
+
 int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct cfg80211_scan_request *req,
 			   struct ieee80211_scan_ies *ies)
@@ -2666,6 +2790,7 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	params.scan_6ghz_params = req->scan_6ghz_params;
 	params.scan_6ghz = req->scan_6ghz;
 	iwl_mvm_fill_scan_type(mvm, &params, vif);
+	iwl_mvm_fill_respect_p2p_go(mvm, &params, vif);
 
 	if (req->duration)
 		params.iter_notif = true;
@@ -2757,6 +2882,7 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 	params.scan_plans = req->scan_plans;
 
 	iwl_mvm_fill_scan_type(mvm, &params, vif);
+	iwl_mvm_fill_respect_p2p_go(mvm, &params, vif);
 
 	/* In theory, LMAC scans can handle a 32-bit delay, but since
 	 * waiting for over 18 hours to start the scan is a bit silly
-- 
2.34.1

