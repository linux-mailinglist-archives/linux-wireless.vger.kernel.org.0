Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E662876EA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgJHPOg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:14:36 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54656 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730650AbgJHPOg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:14:36 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbK-002QxQ-5y; Thu, 08 Oct 2020 18:13:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:49 +0300
Message-Id: <iwlwifi.20201008181047.826bc607e57a.I1d93dd6e6651586878db57fac3e7c3f09d742c42@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/13] iwlwifi: read and parse PNVM file
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The driver looks for a PNVM file that contains FW configuration data
for each different HW combination.  The FW requests the data for a
certain SKU_ID and the driver tries to find it in the PNVM file.

Read the file, parse its contents and send it to the trans.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 223 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  12 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   6 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   5 +
 5 files changed, 241 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 1b7be350828d..02c64b988a13 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -146,7 +146,11 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_UMAC_DEBUG_ADDRS	= 54,
 	IWL_UCODE_TLV_LMAC_DEBUG_ADDRS	= 55,
 	IWL_UCODE_TLV_FW_RECOVERY_INFO	= 57,
-	IWL_UCODE_TLV_FW_FSEQ_VERSION	= 60,
+	IWL_UCODE_TLV_HW_TYPE			= 58,
+	IWL_UCODE_TLV_FW_FSEQ_VERSION		= 60,
+
+	IWL_UCODE_TLV_PNVM_VERSION		= 62,
+	IWL_UCODE_TLV_PNVM_SKU			= 64,
 
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index f6108fda8915..6d8f7bff1243 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -11,6 +11,12 @@
 #include "iwl-io.h"
 #include "fw/api/commands.h"
 #include "fw/api/nvm-reg.h"
+#include "fw/api/alive.h"
+
+struct iwl_pnvm_section {
+	__le32 offset;
+	const u8 data[];
+} __packed;
 
 static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
 				 struct iwl_rx_packet *pkt, void *data)
@@ -25,21 +31,234 @@ static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
 	return true;
 }
 
+static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
+				   size_t len)
+{
+	struct iwl_ucode_tlv *tlv;
+	u32 sha1 = 0;
+	u16 mac_type = 0, rf_id = 0;
+	u8 *pnvm_data = NULL, *tmp;
+	u32 size = 0;
+	int ret;
+
+	IWL_DEBUG_FW(trans, "Handling PNVM section\n");
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
+			ret = -EINVAL;
+			goto out;
+		}
+
+		data += sizeof(*tlv);
+
+		switch (tlv_type) {
+		case IWL_UCODE_TLV_PNVM_VERSION:
+			if (tlv_len < sizeof(__le32)) {
+				IWL_DEBUG_FW(trans,
+					     "Invalid size for IWL_UCODE_TLV_PNVM_VERSION (expected %zd, got %d)\n",
+					     sizeof(__le32), tlv_len);
+				break;
+			}
+
+			sha1 = le32_to_cpup((__le32 *)data);
+
+			IWL_DEBUG_FW(trans,
+				     "Got IWL_UCODE_TLV_PNVM_VERSION %0x\n",
+				     sha1);
+			break;
+		case IWL_UCODE_TLV_HW_TYPE:
+			if (tlv_len < 2 * sizeof(__le16)) {
+				IWL_DEBUG_FW(trans,
+					     "Invalid size for IWL_UCODE_TLV_HW_TYPE (expected %zd, got %d)\n",
+					     2 * sizeof(__le16), tlv_len);
+				break;
+			}
+
+			mac_type = le16_to_cpup((__le16 *)data);
+			rf_id = le16_to_cpup((__le16 *)(data + sizeof(__le16)));
+
+			IWL_DEBUG_FW(trans,
+				     "Got IWL_UCODE_TLV_HW_TYPE mac_type 0x%0x rf_id 0x%0x\n",
+				     mac_type, rf_id);
+
+			if (mac_type != CSR_HW_REV_TYPE(trans->hw_rev) ||
+			    rf_id != CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+				IWL_DEBUG_FW(trans,
+					     "HW mismatch, skipping PNVM section, mac_type 0x%0x, rf_id 0x%0x.\n",
+					     CSR_HW_REV_TYPE(trans->hw_rev), trans->hw_rf_id);
+				ret = -ENOENT;
+				goto out;
+			}
+
+			break;
+		case IWL_UCODE_TLV_SEC_RT: {
+			struct iwl_pnvm_section *section = (void *)data;
+			u32 data_len = tlv_len - sizeof(*section);
+
+			IWL_DEBUG_FW(trans,
+				     "Got IWL_UCODE_TLV_SEC_RT len %d\n",
+				     tlv_len);
+
+			/* TODO: remove, this is a deprecated separator */
+			if (le32_to_cpup((__le32 *)data) == 0xddddeeee) {
+				IWL_DEBUG_FW(trans, "Ignoring separator.\n");
+				break;
+			}
+
+			IWL_DEBUG_FW(trans, "Adding data (size %d)\n",
+				     data_len);
+
+			tmp = krealloc(pnvm_data, size + data_len, GFP_KERNEL);
+			if (!tmp) {
+				IWL_DEBUG_FW(trans,
+					     "Couldn't allocate (more) pnvm_data\n");
+
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			pnvm_data = tmp;
+
+			memcpy(pnvm_data + size, section->data, data_len);
+
+			size += data_len;
+
+			break;
+		}
+		case IWL_UCODE_TLV_PNVM_SKU:
+			IWL_DEBUG_FW(trans,
+				     "New PNVM section started, stop parsing.\n");
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
+		IWL_DEBUG_FW(trans, "Empty PNVM, skipping.\n");
+		ret = -ENOENT;
+		goto out;
+	}
+
+	IWL_INFO(trans, "loaded PNVM version 0x%0x\n", sha1);
+
+	ret = iwl_trans_set_pnvm(trans, pnvm_data, size);
+out:
+	kfree(pnvm_data);
+	return ret;
+}
+
+static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
+			  size_t len)
+{
+	struct iwl_ucode_tlv *tlv;
+
+	IWL_DEBUG_FW(trans, "Parsing PNVM file\n");
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
+			return -EINVAL;
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
+			if (trans->sku_id[0] == le32_to_cpu(sku_id->data[0]) &&
+			    trans->sku_id[1] == le32_to_cpu(sku_id->data[1]) &&
+			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
+				int ret;
+
+				data += sizeof(*tlv) + ALIGN(tlv_len, 4);
+				len -= ALIGN(tlv_len, 4);
+
+				ret = iwl_pnvm_handle_section(trans, data, len);
+				if (!ret)
+					return 0;
+			} else {
+				IWL_DEBUG_FW(trans, "SKU ID didn't match!\n");
+			}
+		} else {
+			data += sizeof(*tlv) + ALIGN(tlv_len, 4);
+			len -= ALIGN(tlv_len, 4);
+		}
+	}
+
+	return -ENOENT;
+}
+
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait)
 {
+	const struct firmware *pnvm;
 	struct iwl_notification_wait pnvm_wait;
 	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						PNVM_INIT_COMPLETE_NTFY) };
+	char pnvm_name[64];
+	int ret;
 
 	/* if the SKU_ID is empty, there's nothing to do */
 	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
 		return 0;
 
+	/* if we already have it, nothing to do either */
+	if (trans->pnvm_loaded)
+		return 0;
+
 	/*
-	 * TODO: phase 2: load the pnvm file, find the right section,
-	 * load it and set the right DMA pointer.
+	 * The prefix unfortunately includes a hyphen at the end, so
+	 * don't add the dot here...
 	 */
+	snprintf(pnvm_name, sizeof(pnvm_name), "%spnvm",
+		 trans->cfg->fw_name_pre);
+
+	/* ...but replace the hyphen with the dot here. */
+	if (strlen(trans->cfg->fw_name_pre) < sizeof(pnvm_name))
+		pnvm_name[strlen(trans->cfg->fw_name_pre) - 1] = '.';
+
+	ret = firmware_request_nowarn(&pnvm, pnvm_name, trans->dev);
+	if (ret) {
+		IWL_DEBUG_FW(trans, "PNVM file %s not found %d\n",
+			     pnvm_name, ret);
+	} else {
+		iwl_pnvm_parse(trans, pnvm->data, pnvm->size);
+
+		release_firmware(pnvm);
+	}
 
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 5dbb5d45304f..b70294e9d07b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -73,6 +73,7 @@
 #include "iwl-config.h"
 #include "fw/img.h"
 #include "iwl-op-mode.h"
+#include <linux/firmware.h>
 #include "fw/api/cmdhdr.h"
 #include "fw/api/txq.h"
 #include "fw/api/dbg-tlv.h"
@@ -1004,6 +1005,7 @@ struct iwl_trans {
 
 	bool pm_support;
 	bool ltr_enabled;
+	u8 pnvm_loaded:1;
 
 	const struct iwl_hcmd_arr *command_groups;
 	int command_groups_size;
@@ -1455,8 +1457,14 @@ static inline void iwl_trans_sync_nmi(struct iwl_trans *trans)
 static inline int iwl_trans_set_pnvm(struct iwl_trans *trans,
 				     const void *data, u32 len)
 {
-	if (trans->ops->set_pnvm)
-		return trans->ops->set_pnvm(trans, data, len);
+	if (trans->ops->set_pnvm) {
+		int ret = trans->ops->set_pnvm(trans, data, len);
+
+		if (ret)
+			return ret;
+	}
+
+	trans->pnvm_loaded = true;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 546a24408c63..a0352fa873d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -300,12 +300,6 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans)
 			  trans_pcie->prph_info_dma_addr);
 	trans_pcie->prph_info_dma_addr = 0;
 	trans_pcie->prph_info = NULL;
-	dma_free_coherent(trans->dev, trans_pcie->pnvm_dram.size,
-			  trans_pcie->pnvm_dram.block,
-			  trans_pcie->pnvm_dram.physical);
-	trans_pcie->pnvm_dram.size = 0;
-	trans_pcie->pnvm_dram.block = NULL;
-	trans_pcie->pnvm_dram.physical = 0;
 }
 
 int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index d25a215d5a04..d2e69ad53b27 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1980,6 +1980,11 @@ void iwl_trans_pcie_free(struct iwl_trans *trans)
 
 	iwl_pcie_free_fw_monitor(trans);
 
+	if (trans_pcie->pnvm_dram.size)
+		dma_free_coherent(trans->dev, trans_pcie->pnvm_dram.size,
+				  trans_pcie->pnvm_dram.block,
+				  trans_pcie->pnvm_dram.physical);
+
 	mutex_destroy(&trans_pcie->mutex);
 	iwl_trans_free(trans);
 }
-- 
2.28.0

