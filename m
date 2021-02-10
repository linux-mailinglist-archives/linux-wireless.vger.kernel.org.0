Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0A3169E4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhBJPQR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45274 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231695AbhBJPQK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:10 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD7-0049kS-1f; Wed, 10 Feb 2021 17:15:21 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:10 +0200
Message-Id: <iwlwifi.20210210171218.32998850192a.Ic58d08cb6944ca55e343ff0032c82cfa7821e588@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/12] iwlwifi: mvm: Check ret code for iwl_mvm_load_nvm_to_nic
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Naik <abhishek.naik@intel.com>

Return value of the iwl_mvm_load_nvm_to_nic func is not analyzed. If load
NVM to nic func fails and NVM is not loaded to fw properly, then fw may
behave badly and lead to some strange issue. This commit will analyze
return value and if load NVM to nic has failed, then the error code is
sent to the previous func, which will trigger WRT log collection.
iwl_fw_dbg_error_collect() func collects dump only if tri type is
FW_DBG_TRIGGER_ALIVE_TIMEOUT. But when Load NVM to nic function fails
trig_type is FW_DBG_TRIGGER_DRIVER. This commit also has code changes to
collect dump when trig_type is FW_DBG_TRIGGER_DRIVER.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 811480eac5fa..504729663c35 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2447,7 +2447,8 @@ int iwl_fw_dbg_error_collect(struct iwl_fw_runtime *fwrt,
 		return -EIO;
 
 	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
-		if (trig_type != FW_DBG_TRIGGER_ALIVE_TIMEOUT)
+		if (trig_type != FW_DBG_TRIGGER_ALIVE_TIMEOUT &&
+		    trig_type != FW_DBG_TRIGGER_DRIVER)
 			return -EIO;
 
 		iwl_dbg_tlv_time_point(fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 4d5def7e2d8c..15e2773ce7e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -476,9 +476,13 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 
 	/* Load NVM to NIC if needed */
 	if (mvm->nvm_file_name) {
-		iwl_read_external_nvm(mvm->trans, mvm->nvm_file_name,
-				      mvm->nvm_sections);
-		iwl_mvm_load_nvm_to_nic(mvm);
+		ret = iwl_read_external_nvm(mvm->trans, mvm->nvm_file_name,
+					    mvm->nvm_sections);
+		if (ret)
+			goto error;
+		ret = iwl_mvm_load_nvm_to_nic(mvm);
+		if (ret)
+			goto error;
 	}
 
 	if (IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
@@ -659,8 +663,11 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 	}
 
 	/* In case we read the NVM from external file, load it to the NIC */
-	if (mvm->nvm_file_name)
-		iwl_mvm_load_nvm_to_nic(mvm);
+	if (mvm->nvm_file_name) {
+		ret = iwl_mvm_load_nvm_to_nic(mvm);
+		if (ret)
+			goto remove_notif;
+	}
 
 	WARN_ONCE(mvm->nvm_data->nvm_version < mvm->trans->cfg->nvm_ver,
 		  "Too old NVM version (0x%0x, required = 0x%0x)",
-- 
2.30.0

