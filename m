Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833792DEA0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfE2NkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 09:40:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54356 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727106AbfE2NkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 09:40:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVyoF-00080o-02; Wed, 29 May 2019 16:40:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4/7] iwlwifi: print fseq info upon fw assert
Date:   Wed, 29 May 2019 16:39:52 +0300
Message-Id: <20190529133955.31082-5-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133955.31082-1-luca@coelho.fi>
References: <20190529133955.31082-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Read fseq info from FW registers and print it upon fw assert.
The print is needed since the fseq version coming from the TLV might
not be the actual version that is used.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 39 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  2 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 15 ++++++-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  3 +-
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 5f52e40a2903..33d7bc5500db 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2747,3 +2747,42 @@ void iwl_fw_dbg_periodic_trig_handler(struct timer_list *t)
 			  jiffies + msecs_to_jiffies(collect_interval));
 	}
 }
+
+#define FSEQ_REG(x) { .addr = (x), .str = #x, }
+
+void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	unsigned long flags;
+	int i;
+	struct {
+		u32 addr;
+		const char *str;
+	} fseq_regs[] = {
+		FSEQ_REG(FSEQ_ERROR_CODE),
+		FSEQ_REG(FSEQ_TOP_INIT_VERSION),
+		FSEQ_REG(FSEQ_CNVIO_INIT_VERSION),
+		FSEQ_REG(FSEQ_OTP_VERSION),
+		FSEQ_REG(FSEQ_TOP_CONTENT_VERSION),
+		FSEQ_REG(FSEQ_ALIVE_TOKEN),
+		FSEQ_REG(FSEQ_CNVI_ID),
+		FSEQ_REG(FSEQ_CNVR_ID),
+		FSEQ_REG(CNVI_AUX_MISC_CHIP),
+		FSEQ_REG(CNVR_AUX_MISC_CHIP),
+		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM),
+		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR),
+	};
+
+	if (!iwl_trans_grab_nic_access(trans, &flags))
+		return;
+
+	IWL_ERR(fwrt, "Fseq Registers:\n");
+
+	for (i = 0; i < ARRAY_SIZE(fseq_regs); i++)
+		IWL_ERR(fwrt, "0x%08X | %s\n",
+			iwl_read_prph_no_grab(trans, fseq_regs[i].addr),
+			fseq_regs[i].str);
+
+	iwl_trans_release_nic_access(trans, &flags);
+}
+IWL_EXPORT_SYMBOL(iwl_fw_error_print_fseq_regs);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 2a9e560a906b..fd0ad220e961 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -471,4 +471,6 @@ static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 }
 
 void iwl_fw_dbg_periodic_trig_handler(struct timer_list *t);
+
+void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt);
 #endif  /* __iwl_fw_dbg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 925f308764bf..8d930bfe0727 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -395,7 +395,11 @@ enum {
 	WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK	= 0x80000000,
 };
 
-#define AUX_MISC_REG			0xA200B0
+#define CNVI_AUX_MISC_CHIP				0xA200B0
+#define CNVR_AUX_MISC_CHIP				0xA2B800
+#define CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM		0xA29890
+#define CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR	0xA29938
+
 enum {
 	HW_STEP_LOCATION_BITS = 24,
 };
@@ -447,4 +451,13 @@ enum {
 
 #define UREG_DOORBELL_TO_ISR6		0xA05C04
 #define UREG_DOORBELL_TO_ISR6_NMI_BIT	BIT(0)
+
+#define FSEQ_ERROR_CODE			0xA340C8
+#define FSEQ_TOP_INIT_VERSION		0xA34038
+#define FSEQ_CNVIO_INIT_VERSION		0xA3403C
+#define FSEQ_OTP_VERSION		0xA340FC
+#define FSEQ_TOP_CONTENT_VERSION	0xA340F4
+#define FSEQ_ALIVE_TOKEN		0xA340F0
+#define FSEQ_CNVI_ID			0xA3408C
+#define FSEQ_CNVR_ID			0xA34090
 #endif				/* __iwl_prph_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index b9914efc55c4..cc56ab88fb43 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -596,6 +596,8 @@ void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
 		iwl_mvm_dump_lmac_error_log(mvm, 1);
 
 	iwl_mvm_dump_umac_error_log(mvm);
+
+	iwl_fw_error_print_fseq_regs(&mvm->fwrt);
 }
 
 int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index e9d1075d91db..21da18af0155 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3546,7 +3546,8 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 			hw_step |= ENABLE_WFPM;
 			iwl_write_umac_prph_no_grab(trans, WFPM_CTRL_REG,
 						    hw_step);
-			hw_step = iwl_read_prph_no_grab(trans, AUX_MISC_REG);
+			hw_step = iwl_read_prph_no_grab(trans,
+							CNVI_AUX_MISC_CHIP);
 			hw_step = (hw_step >> HW_STEP_LOCATION_BITS) & 0xF;
 			if (hw_step == 0x3)
 				trans->hw_rev = (trans->hw_rev & 0xFFFFFFF3) |
-- 
2.20.1

