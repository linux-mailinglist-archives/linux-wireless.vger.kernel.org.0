Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23726316A0F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhBJPZA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:25:00 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45348 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231690AbhBJPYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:24:46 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rLS-0049nr-8r; Wed, 10 Feb 2021 17:23:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:23:50 +0200
Message-Id: <iwlwifi.20210210172142.622546a3566f.I659a8b9aa944d213c4ba446e142d74f3f6db9c64@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210152355.419776-1-luca@coelho.fi>
References: <20210210152355.419776-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 3/8] iwlwifi: pnvm: set the PNVM again if it was already loaded
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

When the interface goes up, we have already loaded the PNVM during
init, so we don't load it anymore.  But we still need to set the PNVM
values in the context so that the FW can load it again.

Call set_pnvm when the PNVM is already loaded and change the
trans_pcie implementation to accept a second call to set_pnvm when we
have already allocated and, in this case, only set the values without
allocating again.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 6972592850c0 ("iwlwifi: read and parse PNVM file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  7 ++++++-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 21 +++++++++++--------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 895a907acdf0..1e16f83b402b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -227,6 +227,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	struct iwl_notification_wait pnvm_wait;
 	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						PNVM_INIT_COMPLETE_NTFY) };
+	int ret;
 
 	/* if the SKU_ID is empty, there's nothing to do */
 	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
@@ -236,7 +237,6 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	if (!trans->pnvm_loaded) {
 		const struct firmware *pnvm;
 		char pnvm_name[64];
-		int ret;
 
 		/*
 		 * The prefix unfortunately includes a hyphen at the end, so
@@ -264,6 +264,11 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 
 			release_firmware(pnvm);
 		}
+	} else {
+		/* if we already loaded, we need to set it again */
+		ret = iwl_trans_set_pnvm(trans, NULL, 0);
+		if (ret)
+			return ret;
 	}
 
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 5b5134dd49af..8fba190e84cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -298,17 +298,20 @@ int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return 0;
 
-	ret = iwl_pcie_ctxt_info_alloc_dma(trans, data, len,
-					   &trans_pcie->pnvm_dram);
-	if (ret < 0) {
-		IWL_DEBUG_FW(trans, "Failed to allocate PNVM DMA %d.\n",
-			     ret);
-		return ret;
+	/* only allocate the DRAM if not allocated yet */
+	if (!trans->pnvm_loaded) {
+		if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
+			return -EBUSY;
+
+		ret = iwl_pcie_ctxt_info_alloc_dma(trans, data, len,
+						   &trans_pcie->pnvm_dram);
+		if (ret < 0) {
+			IWL_DEBUG_FW(trans, "Failed to allocate PNVM DMA %d.\n",
+				     ret);
+			return ret;
+		}
 	}
 
-	if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
-		return -EBUSY;
-
 	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
 		cpu_to_le64(trans_pcie->pnvm_dram.physical);
 	prph_sc_ctrl->pnvm_cfg.pnvm_size =
-- 
2.30.0

