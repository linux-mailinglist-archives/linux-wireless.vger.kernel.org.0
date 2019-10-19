Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0227EDD7B3
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfJSJjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50440 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbfJSJjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:16 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCc-0002fy-J3; Sat, 19 Oct 2019 12:39:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:58 +0300
Message-Id: <20191019093902.29823-6-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 08/12] iwlwifi: scan: Create function to build scan cmd
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

Currently, the code to build scan cmd is duplicated in
iwl_mvm_reg_scan_start and iwl_mvm_sched_scan_start.

Create a function to build this command, and call the function instead.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 538cd7b2018b..7ea395681c94 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1712,6 +1712,20 @@ static void iwl_mvm_fill_scan_type(struct iwl_mvm *mvm,
 	}
 }
 
+static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
+				  struct ieee80211_vif *vif,
+				  struct iwl_host_cmd *hcmd,
+				  struct iwl_mvm_scan_params *params,
+				  int type)
+{
+	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
+		hcmd->id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
+		return  iwl_mvm_scan_umac(mvm, vif, params, type);
+	}
+	hcmd->id = SCAN_OFFLOAD_REQUEST_CMD;
+	return  iwl_mvm_scan_lmac(mvm, vif, params);
+}
+
 int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   struct cfg80211_scan_request *req,
 			   struct ieee80211_scan_ies *ies)
@@ -1769,14 +1783,8 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
 
-	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
-		hcmd.id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
-		ret = iwl_mvm_scan_umac(mvm, vif, &params,
-					IWL_MVM_SCAN_REGULAR);
-	} else {
-		hcmd.id = SCAN_OFFLOAD_REQUEST_CMD;
-		ret = iwl_mvm_scan_lmac(mvm, vif, &params);
-	}
+	ret = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params,
+				     IWL_MVM_SCAN_REGULAR);
 
 	if (ret)
 		return ret;
@@ -1874,13 +1882,7 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 
 	iwl_mvm_build_scan_probe(mvm, vif, ies, &params);
 
-	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
-		hcmd.id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
-		ret = iwl_mvm_scan_umac(mvm, vif, &params, type);
-	} else {
-		hcmd.id = SCAN_OFFLOAD_REQUEST_CMD;
-		ret = iwl_mvm_scan_lmac(mvm, vif, &params);
-	}
+	ret = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
 
 	if (ret)
 		return ret;
-- 
2.23.0

