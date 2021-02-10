Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018383169E2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhBJPQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45256 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231650AbhBJPQH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:07 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD5-0049kS-7D; Wed, 10 Feb 2021 17:15:19 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:07 +0200
Message-Id: <iwlwifi.20210210171218.431f31a86ea0.I9db96647eb9c7142051e26cd5be3f52c5ffc5534@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: mvm: isolate the get nvm flow
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will soon be a bit more complicated. Take it out
to a function.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 37 +++++++++++++-------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index a690f3a67d7c..130e78edd4ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -645,6 +645,28 @@ static const struct iwl_fw_runtime_ops iwl_mvm_fwrt_ops = {
 	.d3_debug_enable = iwl_mvm_d3_debug_enable,
 };
 
+static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
+{
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+
+	ret = iwl_run_init_mvm_ucode(mvm);
+
+	if (ret && ret != -ERFKILL)
+		iwl_fw_dbg_error_collect(&mvm->fwrt, FW_DBG_TRIGGER_DRIVER);
+
+	if (!iwlmvm_mod_params.init_dbg || !ret)
+		iwl_mvm_stop_device(mvm);
+
+	mutex_unlock(&mvm->mutex);
+
+	if (ret < 0)
+		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", ret);
+
+	return ret;
+}
+
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
@@ -866,20 +888,11 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (err)
 		goto out_free;
 
-	mutex_lock(&mvm->mutex);
-	err = iwl_run_init_mvm_ucode(mvm);
-	if (err && err != -ERFKILL)
-		iwl_fw_dbg_error_collect(&mvm->fwrt, FW_DBG_TRIGGER_DRIVER);
-	if (!iwlmvm_mod_params.init_dbg || !err)
-		iwl_mvm_stop_device(mvm);
-	mutex_unlock(&mvm->mutex);
-	if (err < 0) {
-		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", err);
-		goto out_free;
-	}
-
 	scan_size = iwl_mvm_scan_size(mvm);
 
+	if (iwl_mvm_start_get_nvm(mvm))
+		goto out_free;
+
 	mvm->scan_cmd = kmalloc(scan_size, GFP_KERNEL);
 	if (!mvm->scan_cmd)
 		goto out_free;
-- 
2.30.0

