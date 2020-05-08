Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531681CB16B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 16:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgEHOIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 10:08:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60328 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727882AbgEHOIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 10:08:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jX3fq-000WXw-AS; Fri, 08 May 2020 17:08:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  8 May 2020 17:08:01 +0300
Message-Id: <iwlwifi.20200508170402.a0be0d354c88.I59ea7f773caed85a66c61401066ae169008442e6@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508140802.558267-1-luca@coelho.fi>
References: <20200508140802.558267-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/11] iwlwifi: mvm: add support for range request version 10
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Range request version 10 keeps the same command size as version 9
but uses 2 reserved fields for the responder beacon interval and
station id (if exists).
For now, since the beacon interval of unassoc APs is unknown, use
a value of 100 TUs which is a common value for many APs.

While at it, remove the definition for CCMP_256 cipher, since this
is not supported.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  | 14 +++----
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 42 +++++++++++++++++--
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 7ffad19d80fd..1df2e497fabf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -550,13 +550,11 @@ struct iwl_tof_range_req_ap_entry_v4 {
 /**
  * enum iwl_location_cipher - location cipher selection
  * @IWL_LOCATION_CIPHER_CCMP_128: CCMP 128
- * @IWL_LOCATION_CIPHER_CCMP_256: CCMP 256
  * @IWL_LOCATION_CIPHER_GCMP_128: GCMP 128
  * @IWL_LOCATION_CIPHER_GCMP_256: GCMP 256
  */
 enum iwl_location_cipher {
 	IWL_LOCATION_CIPHER_CCMP_128,
-	IWL_LOCATION_CIPHER_CCMP_256,
 	IWL_LOCATION_CIPHER_GCMP_128,
 	IWL_LOCATION_CIPHER_GCMP_256,
 };
@@ -577,7 +575,8 @@ enum iwl_location_cipher {
  * @samples_per_burst: the number of FTMs pairs in single Burst (1-31);
  * @num_of_bursts: Recommended value to be sent to the AP. 2s Exponent of
  *	the number of measurement iterations (min 2^0 = 1, max 2^14)
- * @reserved: For alignment and future use
+ * @sta_id: the station id of the AP. Only relevant when associated to the AP,
+ *	otherwise should be set to &IWL_MVM_INVALID_STA.
  * @cipher: pairwise cipher suite for secured measurement.
  *          &enum iwl_location_cipher.
  * @hltk: HLTK to be used for secured 11az measurement
@@ -586,7 +585,8 @@ enum iwl_location_cipher {
  *         If &IWL_INITIATOR_AP_FLAGS_USE_CALIB is set, the fw will use the
  *         calibration value that corresponds to the rx bandwidth of the FTM
  *         frame.
- * @reserved2: For alignment and future use.
+ * @beacon_interval: beacon interval of the AP in TUs. Only required if
+ *	&IWL_INITIATOR_AP_FLAGS_TB is set.
  */
 struct iwl_tof_range_req_ap_entry {
 	__le32 initiator_ap_flags;
@@ -598,13 +598,13 @@ struct iwl_tof_range_req_ap_entry {
 	__le16 burst_period;
 	u8 samples_per_burst;
 	u8 num_of_bursts;
-	u8 reserved;
+	u8 sta_id;
 	u8 cipher;
 	u8 hltk[HLTK_11AZ_LEN];
 	u8 tk[TK_11AZ_LEN];
 	__le16 calib[IWL_TOF_BW_NUM];
-	__le16 reserved2;
-} __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_5 */
+	__le16 beacon_interval;
+} __packed; /* LOCATION_RANGE_REQ_AP_ENTRY_CMD_API_S_VER_6 */
 
 /**
  * enum iwl_tof_response_mode
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index aaa7dd1788b1..5ca45915cf7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -391,9 +391,27 @@ iwl_mvm_ftm_put_target_v3(struct iwl_mvm *mvm,
 }
 
 static int
-iwl_mvm_ftm_put_target(struct iwl_mvm *mvm,
+iwl_mvm_ftm_put_target_v4(struct iwl_mvm *mvm,
+			  struct cfg80211_pmsr_request_peer *peer,
+			  struct iwl_tof_range_req_ap_entry_v4 *target)
+{
+	int ret;
+
+	ret = iwl_mvm_ftm_target_chandef_v2(mvm, peer, &target->channel_num,
+					    &target->format_bw,
+					    &target->ctrl_ch_position);
+	if (ret)
+		return ret;
+
+	iwl_mvm_ftm_put_target_common(mvm, peer, (void *)target);
+
+	return 0;
+}
+
+static int
+iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       struct cfg80211_pmsr_request_peer *peer,
-		       struct iwl_tof_range_req_ap_entry_v4 *target)
+		       struct iwl_tof_range_req_ap_entry *target)
 {
 	int ret;
 
@@ -405,6 +423,20 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm,
 
 	iwl_mvm_ftm_put_target_common(mvm, peer, (void *)target);
 
+	if (vif->bss_conf.assoc &&
+	    !memcmp(peer->addr, vif->bss_conf.bssid, ETH_ALEN)) {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+		target->sta_id = mvmvif->ap_sta_id;
+	} else {
+		target->sta_id = IWL_MVM_INVALID_STA;
+	}
+
+	/*
+	 * TODO: Beacon interval is currently unknown, so use the common value
+	 * of 100 TUs.
+	 */
+	target->beacon_interval = cpu_to_le16(100);
 	return 0;
 }
 
@@ -496,7 +528,7 @@ static int iwl_mvm_ftm_start_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	for (i = 0; i < cmd.num_of_ap; i++) {
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
 
-		err = iwl_mvm_ftm_put_target(mvm, peer, &cmd.ap[i]);
+		err = iwl_mvm_ftm_put_target_v4(mvm, peer, &cmd.ap[i]);
 		if (err)
 			return err;
 	}
@@ -521,8 +553,9 @@ static int iwl_mvm_ftm_start_v9(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	for (i = 0; i < cmd.num_of_ap; i++) {
 		struct cfg80211_pmsr_request_peer *peer = &req->peers[i];
+		struct iwl_tof_range_req_ap_entry *target = &cmd.ap[i];
 
-		err = iwl_mvm_ftm_put_target(mvm, peer, (void *)&cmd.ap[i]);
+		err = iwl_mvm_ftm_put_target(mvm, vif, peer, target);
 		if (err)
 			return err;
 	}
@@ -548,6 +581,7 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 		switch (cmd_ver) {
 		case 9:
+		case 10:
 			err = iwl_mvm_ftm_start_v9(mvm, vif, req);
 			break;
 		case 8:
-- 
2.26.2

