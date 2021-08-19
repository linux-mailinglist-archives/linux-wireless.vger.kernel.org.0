Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B373F1D05
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbhHSPlZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:41:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56938 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240624AbhHSPlY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:41:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mGk9t-002Hje-3Z; Thu, 19 Aug 2021 18:40:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 19 Aug 2021 18:40:33 +0300
Message-Id: <iwlwifi.20210819183728.af9a24b82396.I53c5f82bd2d0f56fd699e3841c922082d99f1c90@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210819154035.72584-1-luca@coelho.fi>
References: <20210819154035.72584-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 09/11] iwlwifi: yoyo: support for new DBGI_SRAM region
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

new region handling is added  for dump collection.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  3 ++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 37 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  7 ++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 9d34c96c1692..d8b5870d6e9a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -129,6 +129,7 @@ struct iwl_fw_ini_region_internal_buffer {
  *	&IWL_FW_INI_REGION_PERIPHERY_PHY, &IWL_FW_INI_REGION_PERIPHERY_AUX,
  *	&IWL_FW_INI_REGION_PAGING, &IWL_FW_INI_REGION_CSR,
  *	&IWL_FW_INI_REGION_DRAM_IMR and &IWL_FW_INI_REGION_PCI_IOSF_CONFIG
+ *	&IWL_FW_INI_REGION_DBGI_SRAM, &FW_TLV_DEBUG_REGION_TYPE_DBGI_SRAM,
  * @fifos: fifos configuration. Used by &IWL_FW_INI_REGION_TXF and
  *	&IWL_FW_INI_REGION_RXF
  * @err_table: error table configuration. Used by
@@ -295,6 +296,7 @@ enum iwl_fw_ini_buffer_location {
  * @IWL_FW_INI_REGION_DRAM_IMR: IMR memory
  * @IWL_FW_INI_REGION_PCI_IOSF_CONFIG: PCI/IOSF config
  * @IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY: special device memory
+ * @IWL_FW_INI_REGION_DBGI_SRAM: periphery registers of DBGI SRAM
  * @IWL_FW_INI_REGION_NUM: number of region types
  */
 enum iwl_fw_ini_region_type {
@@ -316,6 +318,7 @@ enum iwl_fw_ini_region_type {
 	IWL_FW_INI_REGION_DRAM_IMR,
 	IWL_FW_INI_REGION_PCI_IOSF_CONFIG,
 	IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY,
+	IWL_FW_INI_REGION_DBGI_SRAM,
 	IWL_FW_INI_REGION_NUM
 }; /* FW_TLV_DEBUG_REGION_TYPE_API_E */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index f826e6c96095..6dcafd0a3d4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1517,6 +1517,37 @@ iwl_dump_ini_special_mem_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int
+iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
+			    struct iwl_dump_ini_region_data *reg_data,
+			    void *range_ptr, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	__le32 *val = range->data;
+	u32 prph_data;
+	int i;
+
+	if (!iwl_trans_grab_nic_access(fwrt->trans))
+		return -EBUSY;
+
+	range->range_data_size = reg->dev_addr.size;
+	iwl_write_prph_no_grab(fwrt->trans, DBGI_SRAM_TARGET_ACCESS_CFG,
+			       DBGI_SRAM_TARGET_ACCESS_CFG_RESET_ADDRESS_MSK);
+	for (i = 0; i < (le32_to_cpu(reg->dev_addr.size) / 4); i++) {
+		prph_data = iwl_read_prph(fwrt->trans, (i % 2) ?
+					  DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
+					  DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
+		if (prph_data == 0x5a5a5a5a) {
+			iwl_trans_release_nic_access(fwrt->trans);
+			return -EBUSY;
+		}
+		*val++ = cpu_to_le32(prph_data);
+	}
+	iwl_trans_release_nic_access(fwrt->trans);
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static int iwl_dump_ini_fw_pkt_iter(struct iwl_fw_runtime *fwrt,
 				    struct iwl_dump_ini_region_data *reg_data,
 				    void *range_ptr, int idx)
@@ -2189,6 +2220,12 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_mem_hdr = iwl_dump_ini_special_mem_fill_header,
 		.fill_range = iwl_dump_ini_special_mem_iter,
 	},
+	[IWL_FW_INI_REGION_DBGI_SRAM] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_dbgi_sram_iter,
+	},
 };
 
 static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 9a9e714bf9af..d0a7d58336a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -348,6 +348,13 @@
 #define RFIC_REG_RD			0xAD0470
 #define WFPM_CTRL_REG			0xA03030
 #define WFPM_GP2			0xA030B4
+
+/* DBGI SRAM Register details */
+#define DBGI_SRAM_TARGET_ACCESS_CFG			0x00A2E14C
+#define DBGI_SRAM_TARGET_ACCESS_CFG_RESET_ADDRESS_MSK	0x10000
+#define DBGI_SRAM_TARGET_ACCESS_RDATA_LSB		0x00A2E154
+#define DBGI_SRAM_TARGET_ACCESS_RDATA_MSB		0x00A2E158
+
 enum {
 	ENABLE_WFPM = BIT(31),
 	WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK	= 0x80000000,
-- 
2.33.0

