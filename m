Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B482D1ADADC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgDQKVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:21:52 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56562 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbgDQKVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:51 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO85-000Kba-AU; Fri, 17 Apr 2020 13:21:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:33 +0300
Message-Id: <iwlwifi.20200417131727.11883315579a.I4f59100e457c1079c5e4c90e4930d1fa62b7ddd7@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417102142.2173014-1-luca@coelho.fi>
References: <20200417102142.2173014-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/10] iwlwifi: scan: remove support for fw scan api v13
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

The fw already supports scan api v14 and the firmware version that
supports only v13 was not published, so we can remove support for v13 in
the driver.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 26 --------------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 36 -------------------
 2 files changed, 62 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 3d770f406c38..5cc33a1b7172 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1050,20 +1050,6 @@ struct iwl_scan_req_params_v12 {
 	struct iwl_scan_probe_params_v3 probe_params;
 } __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_12 */
 
-/**
- * struct iwl_scan_req_params_v13
- * @general_params: &struct iwl_scan_general_params_v10
- * @channel_params: &struct iwl_scan_channel_params_v4
- * @periodic_params: &struct iwl_scan_periodic_parms_v1
- * @probe_params: &struct iwl_scan_probe_params_v4
- */
-struct iwl_scan_req_params_v13 {
-	struct iwl_scan_general_params_v10 general_params;
-	struct iwl_scan_channel_params_v4 channel_params;
-	struct iwl_scan_periodic_parms_v1 periodic_params;
-	struct iwl_scan_probe_params_v4 probe_params;
-} __packed; /* SCAN_REQUEST_PARAMS_API_S_VER_13 */
-
 /**
  * struct iwl_scan_req_params_v14
  * @general_params: &struct iwl_scan_general_params_v10
@@ -1090,18 +1076,6 @@ struct iwl_scan_req_umac_v12 {
 	struct iwl_scan_req_params_v12 scan_params;
 } __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_12 */
 
-/**
- * struct iwl_scan_req_umac_v13
- * @uid: scan id, &enum iwl_umac_scan_uid_offsets
- * @ooc_priority: out of channel priority - &enum iwl_scan_priority
- * @scan_params: scan parameters
- */
-struct iwl_scan_req_umac_v13 {
-	__le32 uid;
-	__le32 ooc_priority;
-	struct iwl_scan_req_params_v13 scan_params;
-} __packed; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_13 */
-
 /**
  * struct iwl_scan_req_umac_v14
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 7a6ad1ff7055..bc48113f0568 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2051,40 +2051,6 @@ static int iwl_mvm_scan_umac_v12(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return 0;
 }
 
-static int iwl_mvm_scan_umac_v13(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-				 struct iwl_mvm_scan_params *params, int type,
-				 int uid)
-{
-	struct iwl_scan_req_umac_v13 *cmd = mvm->scan_cmd;
-	struct iwl_scan_req_params_v13 *scan_p = &cmd->scan_params;
-	int ret;
-	u16 gen_flags;
-	u32 bitmap_ssid = 0;
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
-	iwl_mvm_scan_umac_fill_probe_p_v4(params, &scan_p->probe_params,
-					  &bitmap_ssid);
-	iwl_mvm_scan_umac_fill_ch_p_v4(mvm, params, vif,
-				       &scan_p->channel_params, bitmap_ssid);
-
-	return 0;
-}
-
 static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				 struct iwl_mvm_scan_params *params, int type,
 				 int uid)
@@ -2235,7 +2201,6 @@ struct iwl_scan_umac_handler {
 static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	/* set the newest version first to shorten the list traverse time */
 	IWL_SCAN_UMAC_HANDLER(14),
-	IWL_SCAN_UMAC_HANDLER(13),
 	IWL_SCAN_UMAC_HANDLER(12),
 };
 
@@ -2594,7 +2559,6 @@ static int iwl_scan_req_umac_get_size(u8 scan_ver)
 {
 	switch (scan_ver) {
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(14);
-		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(13);
 		IWL_SCAN_REQ_UMAC_HANDLE_SIZE(12);
 	}
 
-- 
2.25.1

