Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35043430950
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbhJQN2U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53846 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343688AbhJQN2T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6Ax-000YdS-0V; Sun, 17 Oct 2021 16:26:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:25:54 +0300
Message-Id: <iwlwifi.20211017162352.648931fe07e2.Ibf30f9b8e70536da93c4a574ace33d325d3f8da4@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017132604.480251-1-luca@coelho.fi>
References: <20211017132604.480251-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: BZ Family SW reset support
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Roee Goldfiner <roee.h.goldfiner@intel.com>

Previously added BZ reset wasn't taking into account the
call to iwl_trans_pcie_sw_reset which used a pre-BZ logic
to reset the device - enabling iwl_trans_pcie_sw_reset to
support BZ family made this reset redundant.

MAC_ACCESS clear shouldn't be called here but only when calling
_iwl_trans_pcie_stop_device which now support also BZ family.

Signed-off-by: Roee Goldfiner <roee.h.goldfiner@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 12 ----------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 24 ++++++++++++++-----
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 1ab8e29294a1..9983660c9079 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -163,18 +163,6 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	else
 		iwl_pcie_ctxt_info_free(trans);
 
-	/* Make sure (redundant) we've released our request to stay awake */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		iwl_clear_bit(trans, CSR_GP_CNTRL,
-			      CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
-	else
-		iwl_clear_bit(trans, CSR_GP_CNTRL,
-			      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
-
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-		iwl_set_bit(trans, CSR_GP_CNTRL,
-			    CSR_GP_CNTRL_REG_FLAG_SW_RESET);
-	}
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_gen2_apm_stop(trans, false);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 22393b724e98..12a402be2e06 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -129,7 +129,12 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 static void iwl_trans_pcie_sw_reset(struct iwl_trans *trans)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
-	iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_SW_RESET);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_SW_RESET);
+	else
+		iwl_set_bit(trans, CSR_RESET,
+			    CSR_RESET_REG_FLAG_SW_RESET);
 	usleep_range(5000, 6000);
 }
 
@@ -1209,8 +1214,12 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	}
 
 	/* Make sure (redundant) we've released our request to stay awake */
-	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+	else
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_apm_stop(trans, false);
@@ -2141,9 +2150,12 @@ static void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 
 	if (trans_pcie->cmd_hold_nic_awake)
 		goto out;
-
-	__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-				   CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
+					   CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+	else
+		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
+					   CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 	/*
 	 * Above we read the CSR_GP_CNTRL register, which will flush
 	 * any previous writes, but we need the write that clears the
-- 
2.33.0

