Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E03AE442
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFUHkG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48428 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229949AbhFUHkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEVA-001aFa-V3; Mon, 21 Jun 2021 10:37:50 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:36 +0300
Message-Id: <iwlwifi.20210621103449.259a33ba5074.I2e0bb142d2a9c412547cba89b62dd077b328fdc4@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621073740.1105911-1-luca@coelho.fi>
References: <20210621073740.1105911-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 5/9] iwlwifi: support loading the reduced power table from UEFI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This new feature allows OEMs to set a special reduced power table in a
UEFI variable, which we use to tell the firmware to change the TX
power tables.

Read the variable and store it in a dram block to pass it to the
firmware.  We do this as part of the PNVM loading flow.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  33 ++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 200 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  21 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  16 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  17 ++
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  34 +++
 .../wireless/intel/iwlwifi/pcie/internal.h    |   1 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   7 +
 9 files changed, 318 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index ef1a24504c8b..74e25a6ecc3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -52,7 +52,8 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_INIT_DATA		= 4,
 	IWL_UCODE_TLV_BOOT		= 5,
 	IWL_UCODE_TLV_PROBE_MAX_LEN	= 6, /* a u32 value */
-	IWL_UCODE_TLV_PAN		= 7,
+	IWL_UCODE_TLV_PAN		= 7, /* deprecated -- only used in DVM */
+	IWL_UCODE_TLV_MEM_DESC		= 7, /* replaces PAN in non-DVM */
 	IWL_UCODE_TLV_RUNT_EVTLOG_PTR	= 8,
 	IWL_UCODE_TLV_RUNT_EVTLOG_SIZE	= 9,
 	IWL_UCODE_TLV_RUNT_ERRLOG_PTR	= 10,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 565c19475155..2403490cbc26 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -17,15 +17,6 @@ struct iwl_pnvm_section {
 	const u8 data[];
 } __packed;
 
-struct pnvm_sku_package {
-	u8 rev;
-	u8 reserved1[3];
-	u32 total_size;
-	u8 n_skus;
-	u8 reserved2[11];
-	u8 data[];
-};
-
 static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
 				 struct iwl_rx_packet *pkt, void *data)
 {
@@ -322,6 +313,30 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	kfree(data);
 
 skip_parse:
+	data = NULL;
+	/* now try to get the reduce power table, if not loaded yet */
+	if (!trans->reduce_power_loaded) {
+		data = iwl_uefi_get_reduced_power(trans, &len);
+		if (IS_ERR_OR_NULL(data)) {
+			/*
+			 * Pretend we've loaded it - at least we've tried and
+			 * couldn't load it at all, so there's no point in
+			 * trying again over and over.
+			 */
+			trans->reduce_power_loaded = true;
+
+			goto skip_reduce_power;
+		}
+	}
+
+	ret = iwl_trans_set_reduce_power(trans, data, len);
+	if (ret)
+		IWL_DEBUG_FW(trans,
+			     "Failed to set reduce power table %d\n",
+			     ret);
+	kfree(data);
+
+skip_reduce_power:
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
 				   iwl_pnvm_complete_fn, trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index bdcdca178eda..a7c79d814aa4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -9,6 +9,7 @@
 #include "iwl-io.h"
 
 #include "fw/uefi.h"
+#include "fw/api/alive.h"
 #include <linux/efi.h>
 
 #define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
@@ -22,6 +23,8 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 	unsigned long package_size;
 	int err;
 
+	*len = 0;
+
 	pnvm_efivar = kzalloc(sizeof(*pnvm_efivar), GFP_KERNEL);
 	if (!pnvm_efivar)
 		return ERR_PTR(-ENOMEM);
@@ -40,7 +43,6 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 	data = kmalloc(package_size, GFP_KERNEL);
 	if (!data) {
 		data = ERR_PTR(-ENOMEM);
-		*len = 0;
 		goto out;
 	}
 
@@ -62,3 +64,199 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 
 	return data;
 }
+
+static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
+					   const u8 *data, size_t len)
+{
+	struct iwl_ucode_tlv *tlv;
+	u8 *reduce_power_data = NULL, *tmp;
+	u32 size = 0;
+
+	IWL_DEBUG_FW(trans, "Handling REDUCE_POWER section\n");
+
+	while (len >= sizeof(*tlv)) {
+		u32 tlv_len, tlv_type;
+
+		len -= sizeof(*tlv);
+		tlv = (void *)data;
+
+		tlv_len = le32_to_cpu(tlv->length);
+		tlv_type = le32_to_cpu(tlv->type);
+
+		if (len < tlv_len) {
+			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
+				len, tlv_len);
+			reduce_power_data = ERR_PTR(-EINVAL);
+			goto out;
+		}
+
+		data += sizeof(*tlv);
+
+		switch (tlv_type) {
+		case IWL_UCODE_TLV_MEM_DESC: {
+			IWL_DEBUG_FW(trans,
+				     "Got IWL_UCODE_TLV_MEM_DESC len %d\n",
+				     tlv_len);
+
+			IWL_DEBUG_FW(trans, "Adding data (size %d)\n", tlv_len);
+
+			tmp = krealloc(reduce_power_data, size + tlv_len, GFP_KERNEL);
+			if (!tmp) {
+				IWL_DEBUG_FW(trans,
+					     "Couldn't allocate (more) reduce_power_data\n");
+
+				reduce_power_data = ERR_PTR(-ENOMEM);
+				goto out;
+			}
+
+			reduce_power_data = tmp;
+
+			memcpy(reduce_power_data + size, data, tlv_len);
+
+			size += tlv_len;
+
+			break;
+		}
+		case IWL_UCODE_TLV_PNVM_SKU:
+			IWL_DEBUG_FW(trans,
+				     "New REDUCE_POWER section started, stop parsing.\n");
+			goto done;
+		default:
+			IWL_DEBUG_FW(trans, "Found TLV 0x%0x, len %d\n",
+				     tlv_type, tlv_len);
+			break;
+		}
+
+		len -= ALIGN(tlv_len, 4);
+		data += ALIGN(tlv_len, 4);
+	}
+
+done:
+	if (!size) {
+		IWL_DEBUG_FW(trans, "Empty REDUCE_POWER, skipping.\n");
+		reduce_power_data = ERR_PTR(-ENOENT);
+		goto out;
+	}
+
+	IWL_INFO(trans, "loaded REDUCE_POWER\n");
+
+out:
+	return reduce_power_data;
+}
+
+static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
+					 const u8 *data, size_t len)
+{
+	struct iwl_ucode_tlv *tlv;
+	void *sec_data;
+
+	IWL_DEBUG_FW(trans, "Parsing REDUCE_POWER data\n");
+
+	while (len >= sizeof(*tlv)) {
+		u32 tlv_len, tlv_type;
+
+		len -= sizeof(*tlv);
+		tlv = (void *)data;
+
+		tlv_len = le32_to_cpu(tlv->length);
+		tlv_type = le32_to_cpu(tlv->type);
+
+		if (len < tlv_len) {
+			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
+				len, tlv_len);
+			return ERR_PTR(-EINVAL);
+		}
+
+		if (tlv_type == IWL_UCODE_TLV_PNVM_SKU) {
+			struct iwl_sku_id *sku_id =
+				(void *)(data + sizeof(*tlv));
+
+			IWL_DEBUG_FW(trans,
+				     "Got IWL_UCODE_TLV_PNVM_SKU len %d\n",
+				     tlv_len);
+			IWL_DEBUG_FW(trans, "sku_id 0x%0x 0x%0x 0x%0x\n",
+				     le32_to_cpu(sku_id->data[0]),
+				     le32_to_cpu(sku_id->data[1]),
+				     le32_to_cpu(sku_id->data[2]));
+
+			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
+			len -= ALIGN(tlv_len, 4);
+
+			if (trans->sku_id[0] == le32_to_cpu(sku_id->data[0]) &&
+			    trans->sku_id[1] == le32_to_cpu(sku_id->data[1]) &&
+			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
+				sec_data = iwl_uefi_reduce_power_section(trans,
+									 data,
+									 len);
+				if (!IS_ERR(sec_data))
+					return sec_data;
+			} else {
+				IWL_DEBUG_FW(trans, "SKU ID didn't match!\n");
+			}
+		} else {
+			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
+			len -= ALIGN(tlv_len, 4);
+		}
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
+{
+	struct efivar_entry *reduce_power_efivar;
+	struct pnvm_sku_package *package;
+	void *data = NULL;
+	unsigned long package_size;
+	int err;
+
+	*len = 0;
+
+	reduce_power_efivar = kzalloc(sizeof(*reduce_power_efivar), GFP_KERNEL);
+	if (!reduce_power_efivar)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&reduce_power_efivar->var.VariableName, IWL_UEFI_REDUCED_POWER_NAME,
+	       sizeof(IWL_UEFI_REDUCED_POWER_NAME));
+	reduce_power_efivar->var.VendorGuid = IWL_EFI_VAR_GUID;
+
+	/*
+	 * TODO: we hardcode a maximum length here, because reading
+	 * from the UEFI is not working.  To implement this properly,
+	 * we have to call efivar_entry_size().
+	 */
+	package_size = IWL_HARDCODED_REDUCE_POWER_SIZE;
+
+	package = kmalloc(package_size, GFP_KERNEL);
+	if (!package) {
+		package = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	err = efivar_entry_get(reduce_power_efivar, NULL, &package_size, package);
+	if (err) {
+		IWL_DEBUG_FW(trans,
+			     "Reduced Power UEFI variable not found %d (len %lu)\n",
+			     err, package_size);
+		kfree(package);
+		data = ERR_PTR(err);
+		goto out;
+	}
+
+	IWL_DEBUG_FW(trans, "Read reduced power from UEFI with size %lu\n",
+		     package_size);
+	*len = package_size;
+
+	IWL_DEBUG_FW(trans, "rev %d, total_size %d, n_skus %d\n",
+		     package->rev, package->total_size, package->n_skus);
+
+	data = iwl_uefi_reduce_power_parse(trans, package->data,
+					   *len - sizeof(*package));
+
+	kfree(package);
+
+out:
+	kfree(reduce_power_efivar);
+
+	return data;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 48f1b54e3e76..45d0b36d79b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -4,7 +4,8 @@
  */
 
 
-#define IWL_UEFI_OEM_PNVM_NAME	L"UefiCnvWlanOemSignedPnvm"
+#define IWL_UEFI_OEM_PNVM_NAME		L"UefiCnvWlanOemSignedPnvm"
+#define IWL_UEFI_REDUCED_POWER_NAME	L"UefiCnvWlanReducedPower"
 
 /*
  * TODO: we have these hardcoded values that the caller must pass,
@@ -12,14 +13,30 @@
  * properly, we have to change iwl_pnvm_get_from_uefi() to call
  * efivar_entry_size() and return the value to the caller instead.
  */
-#define IWL_HARDCODED_PNVM_SIZE 4096
+#define IWL_HARDCODED_PNVM_SIZE		4096
+#define IWL_HARDCODED_REDUCE_POWER_SIZE	32768
+
+struct pnvm_sku_package {
+	u8 rev;
+	u32 total_size;
+	u8 n_skus;
+	u32 reserved[2];
+	u8 data[];
+} __packed;
 
 #ifdef CONFIG_EFI
 void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len);
+void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len);
 #else /* CONFIG_EFI */
 static inline
 void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline
+void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif /* CONFIG_EFI */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 518a1bc79584..e1fec23ac07f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -127,6 +127,17 @@ struct iwl_prph_scratch_rbd_cfg {
 	__le32 reserved;
 } __packed; /* PERIPH_SCRATCH_RBD_CFG_S */
 
+/*
+ * struct iwl_prph_scratch_uefi_cfg - prph scratch reduce power table
+ * @base_addr: reduce power table address
+ * @size: table size in dwords
+ */
+struct iwl_prph_scratch_uefi_cfg {
+	__le64 base_addr;
+	__le32 size;
+	__le32 reserved;
+} __packed; /* PERIPH_SCRATCH_UEFI_CFG_S */
+
 /*
  * struct iwl_prph_scratch_ctrl_cfg - prph scratch ctrl and config
  * @version: version information of context info and HW
@@ -141,6 +152,7 @@ struct iwl_prph_scratch_ctrl_cfg {
 	struct iwl_prph_scratch_pnvm_cfg pnvm_cfg;
 	struct iwl_prph_scratch_hwm_cfg hwm_cfg;
 	struct iwl_prph_scratch_rbd_cfg rbd_cfg;
+	struct iwl_prph_scratch_uefi_cfg reduce_power_cfg;
 } __packed; /* PERIPH_SCRATCH_CTRL_CFG_S */
 
 /*
@@ -151,7 +163,7 @@ struct iwl_prph_scratch_ctrl_cfg {
  */
 struct iwl_prph_scratch {
 	struct iwl_prph_scratch_ctrl_cfg ctrl_cfg;
-	__le32 reserved[16];
+	__le32 reserved[12];
 	struct iwl_context_info_dram dram;
 } __packed; /* PERIPH_SCRATCH_S */
 
@@ -249,5 +261,7 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive);
 
 int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 					  const void *data, u32 len);
+int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
+						  const void *data, u32 len);
 
 #endif /* __iwl_context_info_file_gen3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a642f5920146..81868d92ef66 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -589,6 +589,8 @@ struct iwl_trans_ops {
 	void (*debugfs_cleanup)(struct iwl_trans *trans);
 	void (*sync_nmi)(struct iwl_trans *trans);
 	int (*set_pnvm)(struct iwl_trans *trans, const void *data, u32 len);
+	int (*set_reduce_power)(struct iwl_trans *trans,
+				const void *data, u32 len);
 	void (*interrupts)(struct iwl_trans *trans, bool enable);
 };
 
@@ -959,6 +961,7 @@ struct iwl_trans {
 	bool pm_support;
 	bool ltr_enabled;
 	u8 pnvm_loaded:1;
+	u8 reduce_power_loaded:1;
 
 	const struct iwl_hcmd_arr *command_groups;
 	int command_groups_size;
@@ -1422,6 +1425,20 @@ static inline int iwl_trans_set_pnvm(struct iwl_trans *trans,
 	return 0;
 }
 
+static inline int iwl_trans_set_reduce_power(struct iwl_trans *trans,
+					     const void *data, u32 len)
+{
+	if (trans->ops->set_reduce_power) {
+		int ret = trans->ops->set_reduce_power(trans, data, len);
+
+		if (ret)
+			return ret;
+	}
+
+	trans->reduce_power_loaded = true;
+	return 0;
+}
+
 static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
 {
 	return trans->dbg.internal_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED ||
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index c69a1541e678..239a722cd79d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -302,3 +302,37 @@ int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 
 	return 0;
 }
+
+int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
+						  const void *data, u32 len)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
+		&trans_pcie->prph_scratch->ctrl_cfg;
+	int ret;
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return 0;
+
+	/* only allocate the DRAM if not allocated yet */
+	if (!trans->reduce_power_loaded) {
+		if (WARN_ON(prph_sc_ctrl->reduce_power_cfg.size))
+			return -EBUSY;
+
+		ret = iwl_pcie_ctxt_info_alloc_dma(trans, data, len,
+					   &trans_pcie->reduce_power_dram);
+		if (ret < 0) {
+			IWL_DEBUG_FW(trans,
+				     "Failed to allocate reduce power DMA %d.\n",
+				     ret);
+			return ret;
+		}
+	}
+
+	prph_sc_ctrl->reduce_power_cfg.base_addr =
+		cpu_to_le64(trans_pcie->reduce_power_dram.physical);
+	prph_sc_ctrl->reduce_power_cfg.size =
+		cpu_to_le32(trans_pcie->reduce_power_dram.size);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 69289e9f8d7e..cc550f6ef957 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -349,6 +349,7 @@ struct iwl_trans_pcie {
 	struct iwl_dma_ptr kw;
 
 	struct iwl_dram_data pnvm_dram;
+	struct iwl_dram_data reduce_power_dram;
 
 	struct iwl_txq *txq_memory;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a4d6988b50a6..86a8448ce86a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1955,6 +1955,12 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 				  trans_pcie->pnvm_dram.block,
 				  trans_pcie->pnvm_dram.physical);
 
+	if (trans_pcie->reduce_power_dram.size)
+		dma_free_coherent(trans->dev,
+				  trans_pcie->reduce_power_dram.size,
+				  trans_pcie->reduce_power_dram.block,
+				  trans_pcie->reduce_power_dram.physical);
+
 	mutex_destroy(&trans_pcie->mutex);
 	iwl_trans_free(trans);
 }
@@ -3430,6 +3436,7 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	.wait_txq_empty = iwl_trans_pcie_wait_txq_empty,
 	.rxq_dma_data = iwl_trans_pcie_rxq_dma_data,
 	.set_pnvm = iwl_trans_pcie_ctx_info_gen3_set_pnvm,
+	.set_reduce_power = iwl_trans_pcie_ctx_info_gen3_set_reduce_power,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.debugfs_cleanup = iwl_trans_pcie_debugfs_cleanup,
 #endif
-- 
2.32.0

