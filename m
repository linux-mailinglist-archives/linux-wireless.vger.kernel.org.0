Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01024193F50
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgCZMz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44230 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728260AbgCZMz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2d-00040Z-Q0; Thu, 26 Mar 2020 14:55:24 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:55:05 +0200
Message-Id: <iwlwifi.20200326145047.6fc5ccaa1a1f.I65210cf541af46e2675a8c764d5871f7f5b070d6@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326125510.621842-1-luca@coelho.fi>
References: <20200326125510.621842-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH 07/12] iwlwifi: scan: support FW APIs with variable number of profiles
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

The FW changed the maximum number of scan offload profiles to 8 in new
APIs.  Support it by changing the scan_offload_profile_cfg struct to be
more dynamic, so we can reuse most of the code and only change size of
the profiles array.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 31 +++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  5 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 40 +++++++++++++------
 5 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 2e70e4e752e1..3d770f406c38 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -95,6 +95,7 @@ struct iwl_ssid_ie {
 #define IWL_SCAN_MAX_BLACKLIST_LEN	64
 #define IWL_SCAN_SHORT_BLACKLIST_LEN	16
 #define IWL_SCAN_MAX_PROFILES		11
+#define IWL_SCAN_MAX_PROFILES_V2	8
 #define SCAN_OFFLOAD_PROBE_REQ_SIZE	512
 #define SCAN_NUM_BAND_PROBE_DATA_V_1	2
 #define SCAN_NUM_BAND_PROBE_DATA_V_2	3
@@ -160,8 +161,7 @@ struct iwl_scan_offload_profile {
 } __packed;
 
 /**
- * struct iwl_scan_offload_profile_cfg - SCAN_OFFLOAD_PROFILES_CFG_API_S_VER_1
- * @profiles:		profiles to search for match
+ * struct iwl_scan_offload_profile_cfg_data
  * @blacklist_len:	length of blacklist
  * @num_profiles:	num of profiles in the list
  * @match_notify:	clients waiting for match found notification
@@ -170,8 +170,7 @@ struct iwl_scan_offload_profile {
  * @any_beacon_notify:	clients waiting for match notification without match
  * @reserved:		reserved
  */
-struct iwl_scan_offload_profile_cfg {
-	struct iwl_scan_offload_profile profiles[IWL_SCAN_MAX_PROFILES];
+struct iwl_scan_offload_profile_cfg_data {
 	u8 blacklist_len;
 	u8 num_profiles;
 	u8 match_notify;
@@ -181,6 +180,26 @@ struct iwl_scan_offload_profile_cfg {
 	u8 reserved[2];
 } __packed;
 
+/**
+ * struct iwl_scan_offload_profile_cfg
+ * @profiles:	profiles to search for match
+ * @data:	the rest of the data for profile_cfg
+ */
+struct iwl_scan_offload_profile_cfg_v1 {
+	struct iwl_scan_offload_profile profiles[IWL_SCAN_MAX_PROFILES];
+	struct iwl_scan_offload_profile_cfg_data data;
+} __packed; /* SCAN_OFFLOAD_PROFILES_CFG_API_S_VER_1-2*/
+
+/**
+ * struct iwl_scan_offload_profile_cfg
+ * @profiles:	profiles to search for match
+ * @data:	the rest of the data for profile_cfg
+ */
+struct iwl_scan_offload_profile_cfg {
+	struct iwl_scan_offload_profile profiles[IWL_SCAN_MAX_PROFILES_V2];
+	struct iwl_scan_offload_profile_cfg_data data;
+} __packed; /* SCAN_OFFLOAD_PROFILES_CFG_API_S_VER_3*/
+
 /**
  * struct iwl_scan_schedule_lmac - schedule of scan offload
  * @delay:		delay between iterations, in seconds.
@@ -1169,7 +1188,7 @@ struct iwl_scan_offload_profiles_query_v1 {
 	u8 resume_while_scanning;
 	u8 self_recovery;
 	__le16 reserved;
-	struct iwl_scan_offload_profile_match_v1 matches[IWL_SCAN_MAX_PROFILES];
+	struct iwl_scan_offload_profile_match_v1 matches[0];
 } __packed; /* SCAN_OFFLOAD_PROFILES_QUERY_RSP_S_VER_2 */
 
 /**
@@ -1213,7 +1232,7 @@ struct iwl_scan_offload_profiles_query {
 	u8 resume_while_scanning;
 	u8 self_recovery;
 	__le16 reserved;
-	struct iwl_scan_offload_profile_match matches[IWL_SCAN_MAX_PROFILES];
+	struct iwl_scan_offload_profile_match matches[0];
 } __packed; /* SCAN_OFFLOAD_PROFILES_QUERY_RSP_S_VER_3 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 22a32eb10f01..122ca7624073 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1709,6 +1709,7 @@ iwl_mvm_netdetect_query_results(struct iwl_mvm *mvm,
 	};
 	int ret, len;
 	size_t query_len, matches_len;
+	int max_profiles = iwl_umac_scan_get_max_profiles(mvm->fw);
 
 	ret = iwl_mvm_send_cmd(mvm, &cmd);
 	if (ret) {
@@ -1720,11 +1721,11 @@ iwl_mvm_netdetect_query_results(struct iwl_mvm *mvm,
 		       IWL_UCODE_TLV_API_SCAN_OFFLOAD_CHANS)) {
 		query_len = sizeof(struct iwl_scan_offload_profiles_query);
 		matches_len = sizeof(struct iwl_scan_offload_profile_match) *
-			IWL_SCAN_MAX_PROFILES;
+			max_profiles;
 	} else {
 		query_len = sizeof(struct iwl_scan_offload_profiles_query_v1);
 		matches_len = sizeof(struct iwl_scan_offload_profile_match_v1) *
-			IWL_SCAN_MAX_PROFILES;
+			max_profiles;
 	}
 
 	len = iwl_rx_packet_payload_len(cmd.resp_pkt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c9c40965de4c..7aa1350b093e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -617,7 +617,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	hw->wiphy->max_sched_scan_reqs = 1;
 	hw->wiphy->max_sched_scan_ssids = PROBE_OPTION_MAX;
-	hw->wiphy->max_match_sets = IWL_SCAN_MAX_PROFILES;
+	hw->wiphy->max_match_sets = iwl_umac_scan_get_max_profiles(mvm->fw);
 	/* we create the 802.11 header and zero length SSID IE. */
 	hw->wiphy->max_sched_scan_ie_len =
 		SCAN_OFFLOAD_PROBE_REQ_SIZE - 24 - 2;
@@ -705,7 +705,8 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		mvm->wowlan.n_patterns = IWL_WOWLAN_MAX_PATTERNS;
 		mvm->wowlan.pattern_min_len = IWL_WOWLAN_MIN_PATTERN_LEN;
 		mvm->wowlan.pattern_max_len = IWL_WOWLAN_MAX_PATTERN_LEN;
-		mvm->wowlan.max_nd_match_sets = IWL_SCAN_MAX_PROFILES;
+		mvm->wowlan.max_nd_match_sets =
+			iwl_umac_scan_get_max_profiles(mvm->fw);
 		hw->wiphy->wowlan = &mvm->wowlan;
 	}
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d6ecc2d2bf21..afcf2b98a9cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2147,4 +2147,11 @@ iwl_mvm_set_chan_info_chandef(struct iwl_mvm *mvm,
 			      iwl_mvm_get_ctrl_pos(chandef));
 }
 
+static inline int iwl_umac_scan_get_max_profiles(const struct iwl_fw *fw)
+{
+	u8 ver = iwl_mvm_lookup_cmd_ver(fw, IWL_ALWAYS_LONG_GROUP,
+					SCAN_OFFLOAD_UPDATE_PROFILES_CMD);
+	return (ver == IWL_FW_CMD_VER_UNKNOWN || ver < 3) ?
+		IWL_SCAN_MAX_PROFILES : IWL_SCAN_MAX_PROFILES_V2;
+}
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 1fa74086a4f7..7a6ad1ff7055 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -594,11 +594,15 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 				   struct cfg80211_sched_scan_request *req)
 {
 	struct iwl_scan_offload_profile *profile;
-	struct iwl_scan_offload_profile_cfg *profile_cfg;
+	struct iwl_scan_offload_profile_cfg_v1 *profile_cfg_v1;
 	struct iwl_scan_offload_blacklist *blacklist;
+	struct iwl_scan_offload_profile_cfg_data *data;
+	int max_profiles = iwl_umac_scan_get_max_profiles(mvm->fw);
+	int profile_cfg_size = sizeof(*data) +
+		sizeof(*profile) * max_profiles;
 	struct iwl_host_cmd cmd = {
 		.id = SCAN_OFFLOAD_UPDATE_PROFILES_CMD,
-		.len[1] = sizeof(*profile_cfg),
+		.len[1] = profile_cfg_size,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 		.dataflags[1] = IWL_HCMD_DFL_NOCOPY,
 	};
@@ -606,7 +610,7 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 	int i;
 	int ret;
 
-	if (WARN_ON(req->n_match_sets > IWL_SCAN_MAX_PROFILES))
+	if (WARN_ON(req->n_match_sets > max_profiles))
 		return -EIO;
 
 	if (mvm->fw->ucode_capa.flags & IWL_UCODE_TLV_FLAGS_SHORT_BL)
@@ -618,27 +622,37 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 	if (!blacklist)
 		return -ENOMEM;
 
-	profile_cfg = kzalloc(sizeof(*profile_cfg), GFP_KERNEL);
-	if (!profile_cfg) {
+	profile_cfg_v1 = kzalloc(profile_cfg_size, GFP_KERNEL);
+	if (!profile_cfg_v1) {
 		ret = -ENOMEM;
 		goto free_blacklist;
 	}
 
 	cmd.data[0] = blacklist;
 	cmd.len[0] = sizeof(*blacklist) * blacklist_len;
-	cmd.data[1] = profile_cfg;
+	cmd.data[1] = profile_cfg_v1;
+
+	/* if max_profile is MAX_PROFILES_V2, we have the new API */
+	if (max_profiles == IWL_SCAN_MAX_PROFILES_V2) {
+		struct iwl_scan_offload_profile_cfg *profile_cfg =
+			(struct iwl_scan_offload_profile_cfg *)profile_cfg_v1;
+
+		data = &profile_cfg->data;
+	} else {
+		data = &profile_cfg_v1->data;
+	}
 
 	/* No blacklist configuration */
+	data->num_profiles = req->n_match_sets;
+	data->active_clients = SCAN_CLIENT_SCHED_SCAN;
+	data->pass_match = SCAN_CLIENT_SCHED_SCAN;
+	data->match_notify = SCAN_CLIENT_SCHED_SCAN;
 
-	profile_cfg->num_profiles = req->n_match_sets;
-	profile_cfg->active_clients = SCAN_CLIENT_SCHED_SCAN;
-	profile_cfg->pass_match = SCAN_CLIENT_SCHED_SCAN;
-	profile_cfg->match_notify = SCAN_CLIENT_SCHED_SCAN;
 	if (!req->n_match_sets || !req->match_sets[0].ssid.ssid_len)
-		profile_cfg->any_beacon_notify = SCAN_CLIENT_SCHED_SCAN;
+		data->any_beacon_notify = SCAN_CLIENT_SCHED_SCAN;
 
 	for (i = 0; i < req->n_match_sets; i++) {
-		profile = &profile_cfg->profiles[i];
+		profile = &profile_cfg_v1->profiles[i];
 		profile->ssid_index = i;
 		/* Support any cipher and auth algorithm */
 		profile->unicast_cipher = 0xff;
@@ -651,7 +665,7 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 	IWL_DEBUG_SCAN(mvm, "Sending scheduled scan profile config\n");
 
 	ret = iwl_mvm_send_cmd(mvm, &cmd);
-	kfree(profile_cfg);
+	kfree(profile_cfg_v1);
 free_blacklist:
 	kfree(blacklist);
 
-- 
2.25.1

