Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F900130EFA
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAFIzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51398 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgAFIzR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:17 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAM-0007qa-RJ; Mon, 06 Jan 2020 10:55:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:58 +0200
Message-Id: <20200106085502.363205-9-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 08/12] iwlwifi: mvm: print out extended secboot status before dump
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Print out the secure boot status, extended by the PCs of LMACs
and the UMAC. This needs to be before dumping, as dumping will
corrupt the PC (if the NMI is handled), so move that down.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 27 ++++++++++++++-----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 14c8ba23f3b9..c21d99418af9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -430,6 +430,9 @@ enum aux_misc_master1_en {
 #define UMAG_SB_CPU_1_STATUS		0xA038C0
 #define UMAG_SB_CPU_2_STATUS		0xA038C4
 #define UMAG_GEN_HW_STATUS		0xA038C8
+#define UREG_UMAC_CURRENT_PC		0xa05c18
+#define UREG_LMAC1_CURRENT_PC		0xa05c1c
+#define UREG_LMAC2_CURRENT_PC		0xa05c20
 
 /* For UMAG_GEN_HW_STATUS reg check */
 enum {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index dd685f7eb410..67d414e5db19 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -353,22 +353,35 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	if (ret) {
 		struct iwl_trans *trans = mvm->trans;
 
-		if (ret == -ETIMEDOUT)
-			iwl_fw_dbg_error_collect(&mvm->fwrt,
-						 FW_DBG_TRIGGER_ALIVE_TIMEOUT);
-
-		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
+		if (trans->trans_cfg->device_family >=
+					IWL_DEVICE_FAMILY_22000) {
 			IWL_ERR(mvm,
 				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
 				iwl_read_umac_prph(trans, UMAG_SB_CPU_1_STATUS),
 				iwl_read_umac_prph(trans,
 						   UMAG_SB_CPU_2_STATUS));
-		else if (trans->trans_cfg->device_family >=
-			 IWL_DEVICE_FAMILY_8000)
+			IWL_ERR(mvm, "UMAC PC: 0x%x\n",
+				iwl_read_umac_prph(trans,
+						   UREG_UMAC_CURRENT_PC));
+			IWL_ERR(mvm, "LMAC PC: 0x%x\n",
+				iwl_read_umac_prph(trans,
+						   UREG_LMAC1_CURRENT_PC));
+			if (iwl_mvm_is_cdb_supported(mvm))
+				IWL_ERR(mvm, "LMAC2 PC: 0x%x\n",
+					iwl_read_umac_prph(trans,
+						UREG_LMAC2_CURRENT_PC));
+		} else if (trans->trans_cfg->device_family >=
+			   IWL_DEVICE_FAMILY_8000) {
 			IWL_ERR(mvm,
 				"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
 				iwl_read_prph(trans, SB_CPU_1_STATUS),
 				iwl_read_prph(trans, SB_CPU_2_STATUS));
+		}
+
+		if (ret == -ETIMEDOUT)
+			iwl_fw_dbg_error_collect(&mvm->fwrt,
+						 FW_DBG_TRIGGER_ALIVE_TIMEOUT);
+
 		iwl_fw_set_current_image(&mvm->fwrt, old_type);
 		return ret;
 	}
-- 
2.24.1

