Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01401309EEF
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 21:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhAaUdO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 15:33:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43196 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229987AbhAaUb4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 15:31:56 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6HMV-0041H2-E6; Sun, 31 Jan 2021 20:22:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 20:22:01 +0200
Message-Id: <iwlwifi.20210131201907.4a802b308a0f.I77855abbf6dc1a6edf9c914f3313a87bd78de4df@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131182212.929755-1-luca@coelho.fi>
References: <20210131182212.929755-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: mvm: add IML/ROM information for other HW families
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This makes it easier to debug IML/ROM errors for other HW families
as well.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  1 +
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 24 +++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 0b03fdedc1f7..9dd2d79f4d5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -359,6 +359,7 @@ enum {
 /* device family 22000 WPROT register */
 #define PREG_PRPH_WPROT_22000		0xA04D00
 
+#define SB_MODIFY_CFG_FLAG		0xA03088
 #define SB_CPU_1_STATUS			0xA01E30
 #define SB_CPU_2_STATUS			0xA01E34
 #define UMAG_SB_CPU_1_STATUS		0xA038C0
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 01a0fe86fd0d..b6b481ff1518 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -499,18 +499,33 @@ static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm *mvm, u8 lmac_num)
 static void iwl_mvm_dump_iml_error_log(struct iwl_mvm *mvm)
 {
 	struct iwl_trans *trans = mvm->trans;
-	u32 error;
+	u32 error, data1;
+
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+		error = UMAG_SB_CPU_2_STATUS;
+		data1 = UMAG_SB_CPU_1_STATUS;
+	} else if (mvm->trans->trans_cfg->device_family >=
+		   IWL_DEVICE_FAMILY_8000) {
+		error = SB_CPU_2_STATUS;
+		data1 = SB_CPU_1_STATUS;
+	} else {
+		return;
+	}
 
 	error = iwl_read_umac_prph(trans, UMAG_SB_CPU_2_STATUS);
 
 	IWL_ERR(trans, "IML/ROM dump:\n");
 
 	if (error & 0xFFFF0000)
-		IWL_ERR(trans, "IML/ROM SYSASSERT:\n");
+		IWL_ERR(trans, "0x%04X | IML/ROM SYSASSERT\n", error >> 16);
 
 	IWL_ERR(mvm, "0x%08X | IML/ROM error/state\n", error);
 	IWL_ERR(mvm, "0x%08X | IML/ROM data1\n",
-		iwl_read_umac_prph(trans, UMAG_SB_CPU_1_STATUS));
+		iwl_read_umac_prph(trans, data1));
+
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
+		IWL_ERR(mvm, "0x%08X | IML/ROM WFPM_AUTH_KEY_0\n",
+			iwl_read_umac_prph(trans, SB_MODIFY_CFG_FLAG));
 }
 
 void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
@@ -528,8 +543,7 @@ void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
 
 	iwl_mvm_dump_umac_error_log(mvm);
 
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		iwl_mvm_dump_iml_error_log(mvm);
+	iwl_mvm_dump_iml_error_log(mvm);
 
 	iwl_fw_error_print_fseq_regs(&mvm->fwrt);
 }
-- 
2.29.2

