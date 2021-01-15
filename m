Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D3B2F7732
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAOLG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:06:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40332 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726534AbhAOLG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:06:56 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0Mvh-003hBK-9V; Fri, 15 Jan 2021 13:06:09 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:54 +0200
Message-Id: <iwlwifi.20210115130252.fb819e19530b.I0396f82922db66426f52fbb70d32a29c8fd66951@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115110558.1248847-1-luca@coelho.fi>
References: <20210115110558.1248847-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 08/12] iwlwifi: pcie: set LTR on more devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

To avoid completion timeouts during device boot, set up the
LTR timeouts on more devices - similar to what we had before
for AX210.

This also corrects the AX210 workaround to be done only on
discrete (non-integrated) devices, otherwise the registers
have no effect.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: edb625208d84 ("iwlwifi: pcie: set LTR to avoid completion timeout")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  6 +++
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 39 +++++++++++--------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 0b03fdedc1f7..1158e256f601 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -301,6 +301,12 @@
 #define RADIO_RSP_ADDR_POS		(6)
 #define RADIO_RSP_RD_CMD		(3)
 
+/* LTR control (Qu only) */
+#define HPM_MAC_LTR_CSR			0xa0348c
+#define HPM_MAC_LRT_ENABLE_ALL		0xf
+/* also uses CSR_LTR_* for values */
+#define HPM_UMAC_LTR			0xa03480
+
 /* FW monitor */
 #define MON_BUFF_SAMPLE_CTL		(0xa03c00)
 #define MON_BUFF_BASE_ADDR		(0xa03c1c)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index afe585228435..342a53e4488c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -75,6 +75,15 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 				 const struct fw_img *fw)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 ltr_val = CSR_LTR_LONG_VAL_AD_NO_SNOOP_REQ |
+		      u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
+				      CSR_LTR_LONG_VAL_AD_NO_SNOOP_SCALE) |
+		      u32_encode_bits(250,
+				      CSR_LTR_LONG_VAL_AD_NO_SNOOP_VAL) |
+		      CSR_LTR_LONG_VAL_AD_SNOOP_REQ |
+		      u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
+				      CSR_LTR_LONG_VAL_AD_SNOOP_SCALE) |
+		      u32_encode_bits(250, CSR_LTR_LONG_VAL_AD_SNOOP_VAL);
 	struct iwl_context_info_gen3 *ctxt_info_gen3;
 	struct iwl_prph_scratch *prph_scratch;
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl;
@@ -206,23 +215,19 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	iwl_set_bit(trans, CSR_CTXT_INFO_BOOT_CTRL,
 		    CSR_AUTO_FUNC_BOOT_ENA);
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
-		/*
-		 * The firmware initializes this again later (to a smaller
-		 * value), but for the boot process initialize the LTR to
-		 * ~250 usec.
-		 */
-		u32 val = CSR_LTR_LONG_VAL_AD_NO_SNOOP_REQ |
-			  u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
-					  CSR_LTR_LONG_VAL_AD_NO_SNOOP_SCALE) |
-			  u32_encode_bits(250,
-					  CSR_LTR_LONG_VAL_AD_NO_SNOOP_VAL) |
-			  CSR_LTR_LONG_VAL_AD_SNOOP_REQ |
-			  u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
-					  CSR_LTR_LONG_VAL_AD_SNOOP_SCALE) |
-			  u32_encode_bits(250, CSR_LTR_LONG_VAL_AD_SNOOP_VAL);
-
-		iwl_write32(trans, CSR_LTR_LONG_VAL_AD, val);
+	/*
+	 * To workaround hardware latency issues during the boot process,
+	 * initialize the LTR to ~250 usec (see ltr_val above).
+	 * The firmware initializes this again later (to a smaller value).
+	 */
+	if ((trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210 ||
+	     trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) &&
+	    !trans->trans_cfg->integrated) {
+		iwl_write32(trans, CSR_LTR_LONG_VAL_AD, ltr_val);
+	} else if (trans->trans_cfg->integrated &&
+		   trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000) {
+		iwl_write_prph(trans, HPM_MAC_LTR_CSR, HPM_MAC_LRT_ENABLE_ALL);
+		iwl_write_prph(trans, HPM_UMAC_LTR, ltr_val);
 	}
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-- 
2.29.2

