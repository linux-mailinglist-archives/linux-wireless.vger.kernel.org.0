Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4246845D
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 12:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384743AbhLDLO0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 06:14:26 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50384 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350310AbhLDLOZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 06:14:25 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtSwU-0017RD-21; Sat, 04 Dec 2021 13:10:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 13:10:45 +0200
Message-Id: <iwlwifi.20211204130722.392a4af559bc.Ib8f1e3b527453531c10bfd7f4b116d3e257c7f1f@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204111053.852455-1-luca@coelho.fi>
References: <20211204111053.852455-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: mvm: Add support for a new version of scan request command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The scan request command is identical in binary format to the previous
scan request command and the only change is now a previously reserved
octet is used to indicate new flags introduced in the command. Align
the code to support the new version and the previous one.

Later patches would add the specific handling for the new
flags.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 46 +++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 51 ++++++++++++-------
 2 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 37197ef3f22c..9aa7d0bbd64e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -659,6 +659,19 @@ enum iwl_umac_scan_general_flags_v2 {
 	IWL_UMAC_SCAN_GEN_FLAGS_V2_6GHZ_PASSIVE_SCAN_FILTER_IN = BIT(14),
 };
 
+/**
+ * enum iwl_umac_scan_general_params_flags2 - UMAC scan general flags2
+ *
+ * @IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_LB: scan event scheduling
+ *     should be aware of a P2P GO operation on the 2GHz band.
+ * @IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_HB: scan event scheduling
+ *     should be aware of a P2P GO operation on the 5GHz or 6GHz band.
+ */
+enum iwl_umac_scan_general_params_flags2 {
+	IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_LB = BIT(0),
+	IWL_UMAC_SCAN_GEN_PARAMS_FLAGS2_RESPECT_P2P_GO_HB = BIT(1),
+};
+
 /**
  * struct iwl_scan_channel_cfg_umac
  * @flags:		bitmap - 0-19:	directed scan to i'th ssid.
@@ -941,7 +954,7 @@ struct iwl_scan_channel_params_v6 {
 } __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_6 */
 
 /**
- * struct iwl_scan_general_params_v10
+ * struct iwl_scan_general_params_v11
  * @flags: &enum iwl_umac_scan_general_flags_v2
  * @reserved: reserved for future
  * @scan_start_mac_id: report the scan start TSF time according to this mac TSF
@@ -952,7 +965,8 @@ struct iwl_scan_channel_params_v6 {
  *                        for 5GHz channels
  * @adwell_default_social_chn: adaptive dwell default number of
  *                             APs per social channel
- * @reserved1: reserved for future
+ * @flags2: for version 11 see &enum iwl_umac_scan_general_params_flags2.
+ *     Otherwise reserved.
  * @adwell_max_budget: the maximal number of TUs that adaptive dwell
  *                     can add to the total scan time
  * @max_out_of_time: max out of serving channel time, per LMAC
@@ -963,7 +977,7 @@ struct iwl_scan_channel_params_v6 {
  * @num_of_fragments: number of fragments needed for full fragmented
  *                    scan coverage.
  */
-struct iwl_scan_general_params_v10 {
+struct iwl_scan_general_params_v11 {
 	__le16 flags;
 	u8 reserved;
 	u8 scan_start_mac_id;
@@ -971,14 +985,14 @@ struct iwl_scan_general_params_v10 {
 	u8 adwell_default_2g;
 	u8 adwell_default_5g;
 	u8 adwell_default_social_chn;
-	u8 reserved1;
+	u8 flags2;
 	__le16 adwell_max_budget;
 	__le32 max_out_of_time[SCAN_TWO_LMACS];
 	__le32 suspend_time[SCAN_TWO_LMACS];
 	__le32 scan_priority;
 	u8 passive_dwell[SCAN_TWO_LMACS];
 	u8 num_of_fragments[SCAN_TWO_LMACS];
-} __packed; /* SCAN_GENERAL_PARAMS_API_S_VER_10 */
+} __packed; /* SCAN_GENERAL_PARAMS_API_S_VER_11 and *_VER_10 */
 
 /**
  * struct iwl_scan_periodic_parms_v1
@@ -994,31 +1008,31 @@ struct iwl_scan_periodic_parms_v1 {
 
 /**
  * struct iwl_scan_req_params_v12
- * @general_params: &struct iwl_scan_general_params_v10
+ * @general_params: &struct iwl_scan_general_params_v11
  * @channel_params: &struct iwl_scan_channel_params_v4
  * @periodic_params: &struct iwl_scan_periodic_parms_v1
  * @probe_params: &struct iwl_scan_probe_params_v3
  */
 struct iwl_scan_req_params_v12 {
-	struct iwl_scan_general_params_v10 general_params;
+	struct iwl_scan_general_params_v11 general_params;
 	struct iwl_scan_channel_params_v4 channel_params;
 	struct iwl_scan_periodic_parms_v1 periodic_params;
 	struct iwl_scan_probe_params_v3 probe_params;
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_12 */
 
 /**
- * struct iwl_scan_req_params_v14
- * @general_params: &struct iwl_scan_general_params_v10
+ * struct iwl_scan_req_params_v15
+ * @general_params: &struct iwl_scan_general_params_v11
  * @channel_params: &struct iwl_scan_channel_params_v6
  * @periodic_params: &struct iwl_scan_periodic_parms_v1
  * @probe_params: &struct iwl_scan_probe_params_v4
  */
-struct iwl_scan_req_params_v14 {
-	struct iwl_scan_general_params_v10 general_params;
+struct iwl_scan_req_params_v15 {
+	struct iwl_scan_general_params_v11 general_params;
 	struct iwl_scan_channel_params_v6 channel_params;
 	struct iwl_scan_periodic_parms_v1 periodic_params;
 	struct iwl_scan_probe_params_v4 probe_params;
-} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_14 */
+} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_15 and *_VER_14 */
 
 /**
  * struct iwl_scan_req_umac_v12
@@ -1033,16 +1047,16 @@ struct iwl_scan_req_umac_v12 {
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_12 */
 
 /**
- * struct iwl_scan_req_umac_v14
+ * struct iwl_scan_req_umac_v15
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
  * @ooc_priority: out of channel priority - &enum iwl_scan_priority
  * @scan_params: scan parameters
  */
-struct iwl_scan_req_umac_v14 {
+struct iwl_scan_req_umac_v15 {
 	__le32 uid;
 	__le32 ooc_priority;
-	struct iwl_scan_req_params_v14 scan_params;
-} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_14 */
+	struct iwl_scan_req_params_v15 scan_params;
+} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_15 and *_VER_14 */
 
 /**
  * struct iwl_umac_scan_abort
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index a138b5c4cce8..54ec5eb6c763 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1394,8 +1394,8 @@ static u32 iwl_mvm_scan_umac_ooc_priority(struct iwl_mvm_scan_params *params)
 }
 
 static void
-iwl_mvm_scan_umac_dwell_v10(struct iwl_mvm *mvm,
-			    struct iwl_scan_general_params_v10 *general_params,
+iwl_mvm_scan_umac_dwell_v11(struct iwl_mvm *mvm,
+			    struct iwl_scan_general_params_v11 *general_params,
 			    struct iwl_mvm_scan_params *params)
 {
 	struct iwl_mvm_scan_timing_params *timing, *hb_timing;
@@ -2238,15 +2238,15 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 }
 
 static void
-iwl_mvm_scan_umac_fill_general_p_v10(struct iwl_mvm *mvm,
+iwl_mvm_scan_umac_fill_general_p_v11(struct iwl_mvm *mvm,
 				     struct iwl_mvm_scan_params *params,
 				     struct ieee80211_vif *vif,
-				     struct iwl_scan_general_params_v10 *gp,
+				     struct iwl_scan_general_params_v11 *gp,
 				     u16 gen_flags)
 {
 	struct iwl_mvm_vif *scan_vif = iwl_mvm_vif_from_mac80211(vif);
 
-	iwl_mvm_scan_umac_dwell_v10(mvm, gp, params);
+	iwl_mvm_scan_umac_dwell_v11(mvm, gp, params);
 
 	gp->flags = cpu_to_le16(gen_flags);
 
@@ -2350,7 +2350,7 @@ static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd->uid = cpu_to_le32(uid);
 
 	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
-	iwl_mvm_scan_umac_fill_general_p_v10(mvm, params, vif,
+	iwl_mvm_scan_umac_fill_general_p_v11(mvm, params, vif,
 					     &scan_p->general_params,
 					     gen_flags);
 
@@ -2367,12 +2367,13 @@ static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return 0;
 }
 
-static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-				 struct iwl_mvm_scan_params *params, int type,
-				 int uid)
+static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif,
+					   struct iwl_mvm_scan_params *params,
+					   int type, int uid, u32 version)
 {
-	struct iwl_scan_req_umac_v14 *cmd = mvm->scan_cmd;
-	struct iwl_scan_req_params_v14 *scan_p = &cmd->scan_params;
+	struct iwl_scan_req_umac_v15 *cmd = mvm->scan_cmd;
+	struct iwl_scan_req_params_v15 *scan_p = &cmd->scan_params;
 	struct iwl_scan_channel_params_v6 *cp = &scan_p->channel_params;
 	struct iwl_scan_probe_params_v4 *pb = &scan_p->probe_params;
 	int ret;
@@ -2385,7 +2386,7 @@ static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd->uid = cpu_to_le32(uid);
 
 	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
-	iwl_mvm_scan_umac_fill_general_p_v10(mvm, params, vif,
+	iwl_mvm_scan_umac_fill_general_p_v11(mvm, params, vif,
 					     &scan_p->general_params,
 					     gen_flags);
 
@@ -2425,6 +2426,20 @@ static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return 0;
 }
 
+static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 struct iwl_mvm_scan_params *params, int type,
+				 int uid)
+{
+	return iwl_mvm_scan_umac_v14_and_above(mvm, vif, params, type, uid, 14);
+}
+
+static int iwl_mvm_scan_umac_v15(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 struct iwl_mvm_scan_params *params, int type,
+				 int uid)
+{
+	return iwl_mvm_scan_umac_v14_and_above(mvm, vif, params, type, uid, 15);
+}
+
 static int iwl_mvm_num_scans(struct iwl_mvm *mvm)
 {
 	return hweight32(mvm->scan_status & IWL_MVM_SCAN_MASK);
@@ -2540,6 +2555,7 @@ struct iwl_scan_umac_handler {
 
 static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	/* set the newest version first to shorten the list traverse time */
+	IWL_SCAN_UMAC_HANDLER(15),
 	IWL_SCAN_UMAC_HANDLER(14),
 	IWL_SCAN_UMAC_HANDLER(12),
 };
@@ -2940,15 +2956,14 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 				     1 * HZ);
 }
 
-#define IWL_SCAN_REQ_UMAC_HANDLE_SIZE(_ver) {				\
-	case (_ver): return sizeof(struct iwl_scan_req_umac_v##_ver);	\
-}
-
 static int iwl_scan_req_umac_get_size(u8 scan_ver)
 {
 	switch (scan_ver) {
-		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(14);
-		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(12);
+	case 12:
+		return sizeof(struct iwl_scan_req_umac_v12);
+	case 14:
+	case 15:
+		return sizeof(struct iwl_scan_req_umac_v15);
 	}
 
 	return 0;
-- 
2.33.1

