Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0D4A97B7
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358273AbiBDKZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37976 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358315AbiBDKZ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:27 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmP-0005zM-5S;
        Fri, 04 Feb 2022 12:25:26 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:25:11 +0200
Message-Id: <iwlwifi.20220204122220.940e45167283.I99ddfeda3d4a50d21cb18b826ccf84b21a76c487@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204102511.606112-1-luca@coelho.fi>
References: <20220204102511.606112-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/12] iwlwifi: mvm: Unify the scan iteration functions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

As there is not real need to iterate the active interfaces
twice.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 74 ++++++++-----------
 1 file changed, 32 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 9377549b1af5..76c38645fbd7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -168,17 +168,6 @@ iwl_mvm_scan_rate_n_flags(struct iwl_mvm *mvm, enum nl80211_band band,
 		return cpu_to_le32(IWL_RATE_6M_PLCP | tx_ant);
 }
 
-static void iwl_mvm_scan_condition_iterator(void *data, u8 *mac,
-					    struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int *global_cnt = data;
-
-	if (vif->type != NL80211_IFTYPE_P2P_DEVICE && mvmvif->phy_ctxt &&
-	    mvmvif->phy_ctxt->id < NUM_PHY_CTX)
-		*global_cnt += 1;
-}
-
 static enum iwl_mvm_traffic_load iwl_mvm_get_traffic_load(struct iwl_mvm *mvm)
 {
 	return mvm->tcm.result.global_load;
@@ -190,26 +179,31 @@ iwl_mvm_get_traffic_load_band(struct iwl_mvm *mvm, enum nl80211_band band)
 	return mvm->tcm.result.band_load[band];
 }
 
-struct iwl_is_dcm_with_go_iterator_data {
+struct iwl_mvm_scan_iter_data {
+	u32 global_cnt;
 	struct ieee80211_vif *current_vif;
 	bool is_dcm_with_p2p_go;
 };
 
-static void iwl_mvm_is_dcm_with_go_iterator(void *_data, u8 *mac,
-					    struct ieee80211_vif *vif)
+static void iwl_mvm_scan_iterator(void *_data, u8 *mac,
+				  struct ieee80211_vif *vif)
 {
-	struct iwl_is_dcm_with_go_iterator_data *data = _data;
-	struct iwl_mvm_vif *other_mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm_vif *curr_mvmvif =
-		iwl_mvm_vif_from_mac80211(data->current_vif);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_scan_iter_data *data = _data;
+	struct iwl_mvm_vif *curr_mvmvif;
 
-	/* exclude the given vif */
-	if (vif == data->current_vif)
+	if (vif->type != NL80211_IFTYPE_P2P_DEVICE && mvmvif->phy_ctxt &&
+	    mvmvif->phy_ctxt->id < NUM_PHY_CTX)
+		data->global_cnt += 1;
+
+	if (!data->current_vif || vif == data->current_vif)
 		return;
 
+	curr_mvmvif = iwl_mvm_vif_from_mac80211(data->current_vif);
+
 	if (vif->type == NL80211_IFTYPE_AP && vif->p2p &&
-	    other_mvmvif->phy_ctxt && curr_mvmvif->phy_ctxt &&
-	    other_mvmvif->phy_ctxt->id != curr_mvmvif->phy_ctxt->id)
+	    mvmvif->phy_ctxt && curr_mvmvif->phy_ctxt &&
+	    mvmvif->phy_ctxt->id != curr_mvmvif->phy_ctxt->id)
 		data->is_dcm_with_p2p_go = true;
 }
 
@@ -219,13 +213,18 @@ iwl_mvm_scan_type _iwl_mvm_get_scan_type(struct iwl_mvm *mvm,
 					 enum iwl_mvm_traffic_load load,
 					 bool low_latency)
 {
-	int global_cnt = 0;
+	struct iwl_mvm_scan_iter_data data = {
+		.current_vif = vif,
+		.is_dcm_with_p2p_go = false,
+		.global_cnt = 0,
+	};
 
 	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
-					    IEEE80211_IFACE_ITER_NORMAL,
-					    iwl_mvm_scan_condition_iterator,
-					    &global_cnt);
-	if (!global_cnt)
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   iwl_mvm_scan_iterator,
+						   &data);
+
+	if (!data.global_cnt)
 		return IWL_SCAN_TYPE_UNASSOC;
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
@@ -234,23 +233,14 @@ iwl_mvm_scan_type _iwl_mvm_get_scan_type(struct iwl_mvm *mvm,
 		    (!vif || vif->type != NL80211_IFTYPE_P2P_DEVICE))
 			return IWL_SCAN_TYPE_FRAGMENTED;
 
-		/* in case of DCM with GO where BSS DTIM interval < 220msec
+		/*
+		 * in case of DCM with GO where BSS DTIM interval < 220msec
 		 * set all scan requests as fast-balance scan
-		 * */
+		 */
 		if (vif && vif->type == NL80211_IFTYPE_STATION &&
-		    vif->bss_conf.dtim_period < 220) {
-			struct iwl_is_dcm_with_go_iterator_data data = {
-				.current_vif = vif,
-				.is_dcm_with_p2p_go = false,
-			};
-
-			ieee80211_iterate_active_interfaces_atomic(mvm->hw,
-						IEEE80211_IFACE_ITER_NORMAL,
-						iwl_mvm_is_dcm_with_go_iterator,
-						&data);
-			if (data.is_dcm_with_p2p_go)
-				return IWL_SCAN_TYPE_FAST_BALANCE;
-		}
+		    vif->bss_conf.dtim_period < 220 &&
+		    data.is_dcm_with_p2p_go)
+			return IWL_SCAN_TYPE_FAST_BALANCE;
 	}
 
 	if (load >= IWL_MVM_TRAFFIC_MEDIUM || low_latency)
-- 
2.34.1

