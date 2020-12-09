Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE59B2D4CB2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbgLIVSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:18:16 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35644 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388121AbgLIVRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:17:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pY-003Drx-MD; Wed, 09 Dec 2020 23:17:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:13 +0200
Message-Id: <iwlwifi.20201209231352.8e0ffce7f873.Ie526042c4d4b93d9116c90f53180cbadef0b32cb@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 09/47] iwlwifi: mvm: remove the read_nvm from iwl_run_init_mvm_ucode
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

If we already read the NVM, we don't need to read it again.
Make sure that this is the case with a WARNING.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 7 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6385b9641126..a31a77f828fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -647,7 +647,7 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 				    cmd_size, &phy_cfg_cmd);
 }
 
-int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
+int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 {
 	struct iwl_notification_wait calib_wait;
 	static const u16 init_complete[] = {
@@ -684,7 +684,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 	}
 
 	/* Read the NVM only at driver load time, no need to do this twice */
-	if (read_nvm) {
+	if (!mvm->nvm_data) {
 		ret = iwl_nvm_init(mvm);
 		if (ret) {
 			IWL_ERR(mvm, "Failed to read NVM: %d\n", ret);
@@ -1332,7 +1332,8 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 	if (iwl_mvm_has_unified_ucode(mvm))
 		return iwl_run_unified_mvm_ucode(mvm, false);
 
-	ret = iwl_run_init_mvm_ucode(mvm, false);
+	WARN_ON(!mvm->nvm_data);
+	ret = iwl_run_init_mvm_ucode(mvm);
 
 	if (ret) {
 		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", ret);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7159d1da3e77..a27ac3032218 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1481,7 +1481,7 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm);
  * MVM Methods
  ******************/
 /* uCode */
-int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm);
+int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm);
 
 /* Utils */
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f1c5b3a9c26f..da55133f1a2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -822,7 +822,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		goto out_free;
 
 	mutex_lock(&mvm->mutex);
-	err = iwl_run_init_mvm_ucode(mvm, true);
+	err = iwl_run_init_mvm_ucode(mvm);
 	if (err && err != -ERFKILL)
 		iwl_fw_dbg_error_collect(&mvm->fwrt, FW_DBG_TRIGGER_DRIVER);
 	if (!iwlmvm_mod_params.init_dbg || !err)
-- 
2.29.2

