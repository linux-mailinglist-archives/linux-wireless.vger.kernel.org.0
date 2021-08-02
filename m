Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8D63DDFB3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhHBS7O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51018 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230382AbhHBS7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:14 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9R-001ySl-NP; Mon, 02 Aug 2021 21:59:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:50 +0300
Message-Id: <iwlwifi.20210802215208.928c7983f014.Ic5ba92d98946c1b4640280a05dcfd75119c0f0c0@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802185856.175567-1-luca@coelho.fi>
References: <20210802185856.175567-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/10] iwlwifi: read MAC address from correct place on Bz
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On Bz devices, the MAC address CSRs changed from 0x380 to 0x30.
Change the boolean configuration "mac_addr_from_csr" to hold the
base address instead, and set it correctly for the different
devices using this feature.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 42 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  6 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  | 10 ++---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 10 +++--
 5 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index a3ff7001e1c3..cb4c1d23fc92 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -154,7 +154,7 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.apmg_not_supported = true,					\
 	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = true,					\
+	.mac_addr_from_csr = 0x380,					\
 	.ht_params = &iwl_22000_ht_params,				\
 	.nvm_ver = IWL_22000_NVM_VERSION,				\
 	.trans.use_tfh = true,						\
@@ -215,8 +215,46 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
+#define IWL_DEVICE_BZ_COMMON						\
+	.ucode_api_max = IWL_22000_UCODE_API_MAX,			\
+	.ucode_api_min = IWL_22000_UCODE_API_MIN,			\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.nvm_hw_section_num = 10,					\
+	.non_shared_ant = ANT_B,					\
+	.dccm_offset = IWL_22000_DCCM_OFFSET,				\
+	.dccm_len = IWL_22000_DCCM_LEN,					\
+	.dccm2_offset = IWL_22000_DCCM2_OFFSET,				\
+	.dccm2_len = IWL_22000_DCCM2_LEN,				\
+	.smem_offset = IWL_22000_SMEM_OFFSET,				\
+	.smem_len = IWL_22000_SMEM_LEN,					\
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
+	.apmg_not_supported = true,					\
+	.trans.mq_rx_supported = true,					\
+	.vht_mu_mimo_supported = true,					\
+	.mac_addr_from_csr = 0x30,					\
+	.ht_params = &iwl_22000_ht_params,				\
+	.nvm_ver = IWL_22000_NVM_VERSION,				\
+	.trans.use_tfh = true,						\
+	.trans.rf_id = true,						\
+	.trans.gen2 = true,						\
+	.nvm_type = IWL_NVM_EXT,					\
+	.dbgc_supported = true,						\
+	.min_umac_error_event_table = 0x400000,				\
+	.d3_debug_data_base_addr = 0x401000,				\
+	.d3_debug_data_length = 60 * 1024,				\
+	.mon_smem_regs = {						\
+		.write_ptr = {						\
+			.addr = LDBG_M2S_BUF_WPTR,			\
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
+	},								\
+		.cycle_cnt = {						\
+			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
+		},							\
+	}
+
 #define IWL_DEVICE_BZ							\
-	IWL_DEVICE_22000_COMMON,					\
+	IWL_DEVICE_BZ_COMMON,						\
 	.trans.umac_prph_offset = 0x300000,				\
 	.trans.device_family = IWL_DEVICE_FAMILY_BZ,			\
 	.trans.base_params = &iwl_ax210_base_params,			\
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 871533beff30..7a7ca06d46c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -89,7 +89,7 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.apmg_not_supported = true,					\
 	.num_rbds = 512,						\
 	.vht_mu_mimo_supported = true,					\
-	.mac_addr_from_csr = true,					\
+	.mac_addr_from_csr = 0x380,					\
 	.nvm_type = IWL_NVM_EXT,					\
 	.dbgc_supported = true,						\
 	.min_umac_error_event_table = 0x800000,				\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 82e49ead3a44..7eb534df5331 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -322,7 +322,7 @@ struct iwl_fw_mon_regs {
  * @host_interrupt_operation_mode: device needs host interrupt operation
  *	mode set
  * @nvm_hw_section_num: the ID of the HW NVM section
- * @mac_addr_from_csr: read HW address from CSR registers
+ * @mac_addr_from_csr: read HW address from CSR registers at this offset
  * @features: hw features, any combination of feature_passlist
  * @pwr_tx_backoffs: translation table between power limits and backoffs
  * @max_tx_agg_size: max TX aggregation size of the ADDBA request/response
@@ -344,6 +344,8 @@ struct iwl_fw_mon_regs {
  *	supports 256 BA aggregation
  * @num_rbds: number of receive buffer descriptors to use
  *	(only used for multi-queue capable devices)
+ * @mac_addr_csr_base: CSR base register for MAC address access, if not set
+ *	assume 0x380
  *
  * We enable the driver to be backward compatible wrt. hardware features.
  * API differences in uCode shouldn't be handled here but through TLVs
@@ -379,7 +381,7 @@ struct iwl_cfg {
 	    internal_wimax_coex:1,
 	    host_interrupt_operation_mode:1,
 	    high_temp:1,
-	    mac_addr_from_csr:1,
+	    mac_addr_from_csr:10,
 	    lp_xtal_workaround:1,
 	    disable_dummy_notification:1,
 	    apmg_not_supported:1,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 47e5a17c0f48..004a1b02bea8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -604,10 +604,10 @@ enum msix_hw_int_causes {
  *                     HW address related registers                          *
  *****************************************************************************/
 
-#define CSR_ADDR_BASE			(0x380)
-#define CSR_MAC_ADDR0_OTP		(CSR_ADDR_BASE)
-#define CSR_MAC_ADDR1_OTP		(CSR_ADDR_BASE + 4)
-#define CSR_MAC_ADDR0_STRAP		(CSR_ADDR_BASE + 8)
-#define CSR_MAC_ADDR1_STRAP		(CSR_ADDR_BASE + 0xC)
+#define CSR_ADDR_BASE(trans)			((trans)->cfg->mac_addr_from_csr)
+#define CSR_MAC_ADDR0_OTP(trans)		(CSR_ADDR_BASE(trans) + 0x00)
+#define CSR_MAC_ADDR1_OTP(trans)		(CSR_ADDR_BASE(trans) + 0x04)
+#define CSR_MAC_ADDR0_STRAP(trans)		(CSR_ADDR_BASE(trans) + 0x08)
+#define CSR_MAC_ADDR1_STRAP(trans)		(CSR_ADDR_BASE(trans) + 0x0c)
 
 #endif /* !__iwl_csr_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index a6de34358a3f..2fbb7cdf00a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -964,8 +964,10 @@ static void iwl_flip_hw_address(__le32 mac_addr0, __le32 mac_addr1, u8 *dest)
 static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 					struct iwl_nvm_data *data)
 {
-	__le32 mac_addr0 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR0_STRAP));
-	__le32 mac_addr1 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR1_STRAP));
+	__le32 mac_addr0 = cpu_to_le32(iwl_read32(trans,
+						  CSR_MAC_ADDR0_STRAP(trans)));
+	__le32 mac_addr1 = cpu_to_le32(iwl_read32(trans,
+						  CSR_MAC_ADDR1_STRAP(trans)));
 
 	iwl_flip_hw_address(mac_addr0, mac_addr1, data->hw_addr);
 	/*
@@ -975,8 +977,8 @@ static void iwl_set_hw_address_from_csr(struct iwl_trans *trans,
 	if (is_valid_ether_addr(data->hw_addr))
 		return;
 
-	mac_addr0 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR0_OTP));
-	mac_addr1 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR1_OTP));
+	mac_addr0 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR0_OTP(trans)));
+	mac_addr1 = cpu_to_le32(iwl_read32(trans, CSR_MAC_ADDR1_OTP(trans)));
 
 	iwl_flip_hw_address(mac_addr0, mac_addr1, data->hw_addr);
 }
-- 
2.32.0

