Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD80127B48
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLTMvg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54054 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727394AbfLTMvf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHki-0007lx-N2; Fri, 20 Dec 2019 14:51:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:16 +0200
Message-Id: <20191220125124.1315679-4-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 03/11] iwlwifi: scan: remove support for fw scan api v11
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

The fw already support scan api v12,
v11 is not needed anymore.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 41 ----------------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 47 -------------------
 2 files changed, 88 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 408798f351c6..1b2b5fa56e19 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -921,21 +921,6 @@ struct iwl_scan_probe_params_v4 {
 
 #define SCAN_MAX_NUM_CHANS_V3 67
 
-/**
- * struct iwl_scan_channel_params_v3
- * @flags: channel flags &enum iwl_scan_channel_flags
- * @count: num of channels in scan request
- * @reserved: for future use and alignment
- * @channel_config: array of explicit channel configurations
- *                  for 2.4Ghz and 5.2Ghz bands
- */
-struct iwl_scan_channel_params_v3 {
-	u8 flags;
-	u8 count;
-	__le16 reserved;
-	struct iwl_scan_channel_cfg_umac channel_config[SCAN_MAX_NUM_CHANS_V3];
-} __packed; /* SCAN_CHANNEL_PARAMS_API_S_VER_3 */
-
 /**
  * struct iwl_scan_channel_params_v4
  * @flags: channel flags &enum iwl_scan_channel_flags
@@ -1010,20 +995,6 @@ struct iwl_scan_periodic_parms_v1 {
 	__le16 reserved;
 } __packed; /* SCAN_PERIODIC_PARAMS_API_S_VER_1 */
 
-/**
- * struct iwl_scan_req_params_v11
- * @general_params: &struct iwl_scan_general_params_v10
- * @channel_params: &struct iwl_scan_channel_params_v3
- * @periodic_params: &struct iwl_scan_periodic_parms_v1
- * @probe_params: &struct iwl_scan_probe_params_v3
- */
-struct iwl_scan_req_params_v11 {
-	struct iwl_scan_general_params_v10 general_params;
-	struct iwl_scan_channel_params_v3 channel_params;
-	struct iwl_scan_periodic_parms_v1 periodic_params;
-	struct iwl_scan_probe_params_v3 probe_params;
-} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_11 */
-
 /**
  * struct iwl_scan_req_params_v12
  * @general_params: &struct iwl_scan_general_params_v10
@@ -1052,18 +1023,6 @@ struct iwl_scan_req_params_v13 {
 	struct iwl_scan_probe_params_v4 probe_params;
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_13 */
 
-/**
- * struct iwl_scan_req_umac_v11
- * @uid: scan id, &enum iwl_umac_scan_uid_offsets
- * @ooc_priority: out of channel priority - &enum iwl_scan_priority
- * @scan_params: scan parameters
- */
-struct iwl_scan_req_umac_v11 {
-	__le32 uid;
-	__le32 ooc_priority;
-	struct iwl_scan_req_params_v11 scan_params;
-} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_11 */
-
 /**
  * struct iwl_scan_req_umac_v12
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index a046ac9fa852..c0c89d460700 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1906,20 +1906,6 @@ iwl_mvm_scan_umac_fill_probe_p_v4(struct iwl_mvm_scan_params *params,
 	iwl_scan_build_ssids(params, pp->direct_scan, bitmap_ssid);
 }
 
-static void
-iwl_mvm_scan_umac_fill_ch_p_v3(struct iwl_mvm *mvm,
-			       struct iwl_mvm_scan_params *params,
-			       struct ieee80211_vif *vif,
-			       struct iwl_scan_channel_params_v3 *cp)
-{
-	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
-	cp->count = params->n_channels;
-
-	iwl_mvm_umac_scan_cfg_channels(mvm, params->channels,
-				       params->n_channels, 0,
-				       cp->channel_config);
-}
-
 static void
 iwl_mvm_scan_umac_fill_ch_p_v4(struct iwl_mvm *mvm,
 			       struct iwl_mvm_scan_params *params,
@@ -1937,37 +1923,6 @@ iwl_mvm_scan_umac_fill_ch_p_v4(struct iwl_mvm *mvm,
 					  vif->type);
 }
 
-static int iwl_mvm_scan_umac_v11(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-				 struct iwl_mvm_scan_params *params, int type,
-				 int uid)
-{
-	struct iwl_scan_req_umac_v11 *cmd = mvm->scan_cmd;
-	struct iwl_scan_req_params_v11 *scan_p = &cmd->scan_params;
-	int ret;
-	u16 gen_flags;
-
-	mvm->scan_uid_status[uid] = type;
-
-	cmd->ooc_priority = cpu_to_le32(iwl_mvm_scan_umac_ooc_priority(params));
-	cmd->uid = cpu_to_le32(uid);
-
-	gen_flags = iwl_mvm_scan_umac_flags_v2(mvm, params, vif, type);
-	iwl_mvm_scan_umac_fill_general_p_v10(mvm, params, vif,
-					     &scan_p->general_params,
-					     gen_flags);
-
-	 ret = iwl_mvm_fill_scan_sched_params(params,
-					      scan_p->periodic_params.schedule,
-					      &scan_p->periodic_params.delay);
-	if (ret)
-		return ret;
-
-	iwl_mvm_scan_umac_fill_probe_p_v3(params, &scan_p->probe_params);
-	iwl_mvm_scan_umac_fill_ch_p_v3(mvm, params, vif,
-				       &scan_p->channel_params);
-
-	return 0;
-}
 
 static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				 struct iwl_mvm_scan_params *params, int type,
@@ -2152,7 +2107,6 @@ static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	/* set the newest version first to shorten the list traverse time */
 	IWL_SCAN_UMAC_HANDLER(13),
 	IWL_SCAN_UMAC_HANDLER(12),
-	IWL_SCAN_UMAC_HANDLER(11),
 };
 
 static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
@@ -2511,7 +2465,6 @@ static int iwl_scan_req_umac_get_size(u8 scan_ver)
 	switch (scan_ver) {
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(13);
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(12);
-		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(11);
 	}
 
 	return 0;
-- 
2.24.0

