Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC74A3580
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354543AbiA3JxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37904 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235729AbiA3JxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:14 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tT-0003JO-Ac;
        Sun, 30 Jan 2022 11:53:12 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:52:59 +0200
Message-Id: <iwlwifi.20220130115024.375b3a28d89e.Ia76e9bf13e26eb148abfebdaf859eab1b81d2af1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: fw: make dump_start callback void
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We never return errors there, so just make it void.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c     | 5 ++---
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c    | 4 +---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6e090f10b8eb..0a5d860e489e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2939,9 +2939,8 @@ void iwl_fw_error_dump_wk(struct work_struct *work)
 	/* assumes the op mode mutex is locked in dump_start since
 	 * iwl_fw_dbg_collect_sync can't run in parallel
 	 */
-	if (fwrt->ops && fwrt->ops->dump_start &&
-	    fwrt->ops->dump_start(fwrt->ops_ctx))
-		return;
+	if (fwrt->ops && fwrt->ops->dump_start)
+		fwrt->ops->dump_start(fwrt->ops_ctx);
 
 	iwl_fw_dbg_collect_sync(fwrt, wks->idx);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 3cb0ddbe3ab2..afc822cab674 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -16,7 +16,7 @@
 #include "fw/acpi.h"
 
 struct iwl_fw_runtime_ops {
-	int (*dump_start)(void *ctx);
+	void (*dump_start)(void *ctx);
 	void (*dump_end)(void *ctx);
 	bool (*fw_running)(void *ctx);
 	int (*send_hcmd)(void *ctx, struct iwl_host_cmd *host_cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 86dd2dc1a8ab..98326d06b3a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -639,13 +639,11 @@ static void iwl_mvm_tx_unblock_dwork(struct work_struct *work)
 	mutex_unlock(&mvm->mutex);
 }
 
-static int iwl_mvm_fwrt_dump_start(void *ctx)
+static void iwl_mvm_fwrt_dump_start(void *ctx)
 {
 	struct iwl_mvm *mvm = ctx;
 
 	mutex_lock(&mvm->mutex);
-
-	return 0;
 }
 
 static void iwl_mvm_fwrt_dump_end(void *ctx)
-- 
2.34.1

