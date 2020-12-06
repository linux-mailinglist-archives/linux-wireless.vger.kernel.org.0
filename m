Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C581D2D019F
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 09:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgLFIYh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 03:24:37 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34720 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726318AbgLFIYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 03:24:37 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klpJ4-003A2r-QA; Sun, 06 Dec 2020 10:22:11 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 10:21:59 +0200
Message-Id: <iwlwifi.20201206100942.872b5b736b23.I572eb69dc3738319310c9cbe03a36d942f4f68f7@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206082159.440198-1-luca@coelho.fi>
References: <20201206082159.440198-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: mvm: move iwl_mvm_stop_device() out of line
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This function has grown quite a bit over time, move it
out of line before we grow it even further.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 11 +----------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7e28a088f3e6..de43ffff0a5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1946,16 +1946,7 @@ static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 		~BIT(IWL_MVM_DQA_CMD_QUEUE));
 }
 
-static inline void iwl_mvm_stop_device(struct iwl_mvm *mvm)
-{
-	lockdep_assert_held(&mvm->mutex);
-	iwl_fw_cancel_timestamp(&mvm->fwrt);
-	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
-	iwl_fw_dbg_stop_sync(&mvm->fwrt);
-	iwl_trans_stop_device(mvm->trans);
-	iwl_free_fw_paging(&mvm->fwrt);
-	iwl_fw_dump_conf_clear(&mvm->fwrt);
-}
+void iwl_mvm_stop_device(struct iwl_mvm *mvm);
 
 /* Re-configure the SCD for a queue that has already been configured */
 int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 517ca5b8ce66..e54c48af1913 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -874,6 +874,20 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	return NULL;
 }
 
+void iwl_mvm_stop_device(struct iwl_mvm *mvm)
+{
+	lockdep_assert_held(&mvm->mutex);
+
+	iwl_fw_cancel_timestamp(&mvm->fwrt);
+
+	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
+
+	iwl_fw_dbg_stop_sync(&mvm->fwrt);
+	iwl_trans_stop_device(mvm->trans);
+	iwl_free_fw_paging(&mvm->fwrt);
+	iwl_fw_dump_conf_clear(&mvm->fwrt);
+}
+
 static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-- 
2.29.2

