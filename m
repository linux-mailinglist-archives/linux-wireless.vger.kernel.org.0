Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1CB2AA3FD
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKGIuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:50:22 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58806 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728324AbgKGIuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:50:19 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kbJvN-002on9-6P; Sat, 07 Nov 2020 10:50:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  7 Nov 2020 10:50:10 +0200
Message-Id: <iwlwifi.20201107104557.d83d591c05ba.I42885c9fb500bc08b9a4c07c4ff3d436cc7a3c84@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107085011.57943-1-luca@coelho.fi>
References: <20201107085011.57943-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 5/6] iwlwifi: pcie: set LTR to avoid completion timeout
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On some platforms, the preset values aren't correct and then we may
get a completion timeout in the firmware. Change the LTR configuration
to avoid that. The firmware will do some more complex reinit of this
later, but for the boot process we use ~250usec.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  | 10 ++++++++++
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 20 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index cb9e8e189a1a..1d48c7d7fffd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -147,6 +147,16 @@
 #define CSR_MAC_SHADOW_REG_CTL2		(CSR_BASE + 0x0AC)
 #define CSR_MAC_SHADOW_REG_CTL2_RX_WAKE	0xFFFF
 
+/* LTR control (since IWL_DEVICE_FAMILY_22000) */
+#define CSR_LTR_LONG_VAL_AD			(CSR_BASE + 0x0D4)
+#define CSR_LTR_LONG_VAL_AD_NO_SNOOP_REQ	0x80000000
+#define CSR_LTR_LONG_VAL_AD_NO_SNOOP_SCALE	0x1c000000
+#define CSR_LTR_LONG_VAL_AD_NO_SNOOP_VAL	0x03ff0000
+#define CSR_LTR_LONG_VAL_AD_SNOOP_REQ		0x00008000
+#define CSR_LTR_LONG_VAL_AD_SNOOP_SCALE		0x00001c00
+#define CSR_LTR_LONG_VAL_AD_SNOOP_VAL		0x000003ff
+#define CSR_LTR_LONG_VAL_AD_SCALE_USEC		2
+
 /* GIO Chicken Bits (PCI Express bus link power management) */
 #define CSR_GIO_CHICKEN_BITS    (CSR_BASE+0x100)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index a0352fa873d9..5512e3c630c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -252,6 +252,26 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 	iwl_set_bit(trans, CSR_CTXT_INFO_BOOT_CTRL,
 		    CSR_AUTO_FUNC_BOOT_ENA);
+
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
+		/*
+		 * The firmware initializes this again later (to a smaller
+		 * value), but for the boot process initialize the LTR to
+		 * ~250 usec.
+		 */
+		u32 val = CSR_LTR_LONG_VAL_AD_NO_SNOOP_REQ |
+			  u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
+					  CSR_LTR_LONG_VAL_AD_NO_SNOOP_SCALE) |
+			  u32_encode_bits(250,
+					  CSR_LTR_LONG_VAL_AD_NO_SNOOP_VAL) |
+			  CSR_LTR_LONG_VAL_AD_SNOOP_REQ |
+			  u32_encode_bits(CSR_LTR_LONG_VAL_AD_SCALE_USEC,
+					  CSR_LTR_LONG_VAL_AD_SNOOP_SCALE) |
+			  u32_encode_bits(250, CSR_LTR_LONG_VAL_AD_SNOOP_VAL);
+
+		iwl_write32(trans, CSR_LTR_LONG_VAL_AD, val);
+	}
+
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_CPU_INIT_RUN, 1);
 	else
-- 
2.28.0

