Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5633169F1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhBJPSP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:18:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45320 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232020AbhBJPSE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:18:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD9-0049kS-Tk; Wed, 10 Feb 2021 17:15:24 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:14 +0200
Message-Id: <iwlwifi.20210210171218.bab0e65c4909.I789f3eb577b216ad1688269e036ce9fa4880f532@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: mvm: get NVM later in the mvm_start flow
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We don't need the NVM until fairly late in the flow and
since this flow will be split soon, get the NVM later to
unite it with the parts that really need it.
Gather all what needs the NVM into a function.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 29 ++++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 130e78edd4ed..ebed82c590e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -667,6 +667,22 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 	return ret;
 }
 
+static int iwl_mvm_start_post_nvm(struct iwl_mvm *mvm)
+{
+	int ret;
+
+	iwl_mvm_toggle_tx_ant(mvm, &mvm->mgmt_last_antenna_idx);
+
+	ret = iwl_mvm_mac_setup_register(mvm);
+	if (ret)
+		return ret;
+	mvm->hw_registered = true;
+
+	iwl_mvm_dbgfs_register(mvm);
+
+	return 0;
+}
+
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
@@ -890,9 +906,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	scan_size = iwl_mvm_scan_size(mvm);
 
-	if (iwl_mvm_start_get_nvm(mvm))
-		goto out_free;
-
 	mvm->scan_cmd = kmalloc(scan_size, GFP_KERNEL);
 	if (!mvm->scan_cmd)
 		goto out_free;
@@ -913,15 +926,13 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	else
 		memset(&mvm->rx_stats, 0, sizeof(struct mvm_statistics_rx));
 
-	iwl_mvm_toggle_tx_ant(mvm, &mvm->mgmt_last_antenna_idx);
+	mvm->debugfs_dir = dbgfs_dir;
 
-	err = iwl_mvm_mac_setup_register(mvm);
-	if (err)
+	if (iwl_mvm_start_get_nvm(mvm))
 		goto out_thermal_exit;
-	mvm->hw_registered = true;
 
-	mvm->debugfs_dir = dbgfs_dir;
-	iwl_mvm_dbgfs_register(mvm);
+	if (iwl_mvm_start_post_nvm(mvm))
+		goto out_thermal_exit;
 
 	return op_mode;
 
-- 
2.30.0

