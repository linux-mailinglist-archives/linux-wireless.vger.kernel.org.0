Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01A3E1275
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhHEKTy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:19:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51206 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240012AbhHEKTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTR-00240Q-F1; Thu, 05 Aug 2021 13:19:39 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:24 +0300
Message-Id: <iwlwifi.20210805130823.9130db608b77.I352cbc35fefd98cc00aa0c69ea43863942aa62f5@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805101934.431479-1-luca@coelho.fi>
References: <20210805101934.431479-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 02/12] iwlwifi: mvm: d3: remove fixed cmd_flags argument
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We only ever pass cmd_flags == CMD_ASYNC, so might as well
not have the argument. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 23 ++++++++-------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 14c24f3e0717..0d87de66bf8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -745,8 +745,7 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
-					    struct ieee80211_vif *vif,
-					    u32 cmd_flags)
+					    struct ieee80211_vif *vif)
 {
 	struct iwl_wowlan_kek_kck_material_cmd_v4 kek_kck_cmd = {};
 	struct iwl_wowlan_kek_kck_material_cmd_v4 *_kek_kck_cmd = &kek_kck_cmd;
@@ -772,10 +771,9 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	 * required locks.
 	 */
 	/*
-	 * Note that currently we don't propagate cmd_flags
-	 * to the iterator. In case of key_data.configure_keys,
-	 * all the configured commands are SYNC, and
-	 * iwl_mvm_wowlan_program_keys() will take care of
+	 * Note that currently we don't use CMD_ASYNC in the iterator.
+	 * In case of key_data.configure_keys, all the configured commands
+	 * are SYNC, and iwl_mvm_wowlan_program_keys() will take care of
 	 * locking/unlocking mvm->mutex.
 	 */
 	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_program_keys,
@@ -806,8 +804,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		}
 
 		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
-					   cmd_flags,
-					   size,
+					   CMD_ASYNC, size,
 					   key_data.rsc_tsc);
 
 		if (ret)
@@ -841,7 +838,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 			/* send relevant data according to CMD version */
 			ret = iwl_mvm_send_cmd_pdu(mvm,
 						   WOWLAN_TKIP_PARAM,
-						   cmd_flags, size,
+						   CMD_ASYNC, size,
 						   &tkip_data.tkip);
 			if (ret)
 				goto out;
@@ -885,10 +882,8 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		IWL_DEBUG_WOWLAN(mvm, "setting akm %d\n",
 				 mvmvif->rekey_data.akm);
 
-		ret = iwl_mvm_send_cmd_pdu(mvm,
-					   WOWLAN_KEK_KCK_MATERIAL, cmd_flags,
-					   cmd_size,
-					   _kek_kck_cmd);
+		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_KEK_KCK_MATERIAL,
+					   CMD_ASYNC, cmd_size, _kek_kck_cmd);
 		if (ret)
 			goto out;
 	}
@@ -927,7 +922,7 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 	 * that isn't really a problem though.
 	 */
 	mutex_unlock(&mvm->mutex);
-	ret = iwl_mvm_wowlan_config_key_params(mvm, vif, CMD_ASYNC);
+	ret = iwl_mvm_wowlan_config_key_params(mvm, vif);
 	mutex_lock(&mvm->mutex);
 	if (ret)
 		return ret;
-- 
2.32.0

