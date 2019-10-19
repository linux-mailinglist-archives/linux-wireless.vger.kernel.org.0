Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FDDD7E2
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfJSKDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 06:03:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50524 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbfJSKDl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 06:03:41 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlaF-0002jL-8C; Sat, 19 Oct 2019 13:03:39 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 13:03:30 +0300
Message-Id: <20191019125846.280bb029994e.I6522581e30e1a824aabf9fa48149153be4e15317@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019100331.21322-1-luca@coelho.fi>
References: <20191019100331.21322-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 4/5] iwlwifi: pcie: add workaround for power gating in integrated 22000
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add a workaround that forces power gating to be enabled on integrated
22000 devices.  This improves power saving in certain situations.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  5 ++++
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 25 +++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index cb4c5514a556..695bbaa86273 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -279,6 +279,7 @@
  *         Indicates MAC is entering a power-saving sleep power-down.
  *         Not a good time to access device-internal resources.
  */
+#define CSR_GP_CNTRL_REG_FLAG_INIT_DONE		     (0x00000004)
 #define CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP         (0x00000010)
 #define CSR_GP_CNTRL_REG_FLAG_XTAL_ON		     (0x00000400)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index f47e0f97acf8..23c25a7665f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -449,6 +449,11 @@ enum {
 #define PERSISTENCE_BIT			BIT(12)
 #define PREG_WFPM_ACCESS		BIT(12)
 
+#define HPM_HIPM_GEN_CFG			0xA03458
+#define HPM_HIPM_GEN_CFG_CR_PG_EN		BIT(0)
+#define HPM_HIPM_GEN_CFG_CR_SLP_EN		BIT(1)
+#define HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE	BIT(10)
+
 #define UREG_DOORBELL_TO_ISR6		0xA05C04
 #define UREG_DOORBELL_TO_ISR6_NMI_BIT	BIT(0)
 #define UREG_DOORBELL_TO_ISR6_SUSPEND	BIT(18)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index df8455f14e4d..ca3bb4d65b00 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -57,6 +57,24 @@
 #include "internal.h"
 #include "fw/dbg.h"
 
+static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
+{
+	iwl_set_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			  HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
+	udelay(20);
+	iwl_set_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			  HPM_HIPM_GEN_CFG_CR_PG_EN |
+			  HPM_HIPM_GEN_CFG_CR_SLP_EN);
+	udelay(20);
+	iwl_clear_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			    HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
+
+	iwl_trans_sw_reset(trans);
+	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+
+	return 0;
+}
+
 /*
  * Start up NIC's basic functionality after it has been reset
  * (e.g. after platform boot, or shutdown via iwl_pcie_apm_stop())
@@ -92,6 +110,13 @@ int iwl_pcie_gen2_apm_init(struct iwl_trans *trans)
 
 	iwl_pcie_apm_config(trans);
 
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
+	    trans->cfg->integrated) {
+		ret = iwl_pcie_gen2_force_power_gating(trans);
+		if (ret)
+			return ret;
+	}
+
 	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
 	if (ret)
 		return ret;
-- 
2.23.0

