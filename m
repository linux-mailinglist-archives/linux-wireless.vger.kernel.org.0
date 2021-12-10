Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1C46FD78
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhLJJQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:16:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50876 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234141AbhLJJQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:16:28 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvbxQ-001FED-OG; Fri, 10 Dec 2021 11:12:52 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 11:12:36 +0200
Message-Id: <iwlwifi.20211210110539.779d68490f68.I472c7d9cbaca46000a10ec18808ef54836b33a8a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210091245.289008-1-luca@coelho.fi>
References: <20211210091245.289008-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/10] iwlwifi: parse error tables from debug TLVs
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

With more things being added, we're no longer going to duplicate
the error tables from the debug TLVs nor send them at runtime.
Use the debug TLVs to find the locations of the error tables. As
we've never released firmware using IWL_UCODE_TLV_TCM_DEBUG_ADDRS
just remove that entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 11 +++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 60 +++++++++++++++----
 3 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 224525417424..62b527b3a6c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -386,7 +386,16 @@ enum iwl_fw_ini_region_type {
 	IWL_FW_INI_REGION_NUM
 }; /* FW_TLV_DEBUG_REGION_TYPE_API_E */
 
-#define IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_HW_SMEM	1
+enum iwl_fw_ini_region_device_memory_subtype {
+	IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_HW_SMEM = 1,
+	IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_UMAC_ERROR_TABLE = 5,
+	IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_LMAC_1_ERROR_TABLE = 7,
+	IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_LMAC_2_ERROR_TABLE = 10,
+	IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_TCM_1_ERROR_TABLE = 14,
+	IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_TCM_2_ERROR_TABLE = 16,
+	IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_RCM_1_ERROR_TABLE = 18,
+	IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_RCM_2_ERROR_TABLE = 20,
+}; /* FW_TLV_DEBUG_REGION_DEVICE_MEMORY_SUBTYPE_API_E */
 
 /**
  * enum iwl_fw_ini_time_point
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 3d572f5024bb..e4ebda64cd52 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -98,7 +98,6 @@ enum iwl_ucode_tlv_type {
 
 	IWL_UCODE_TLV_PNVM_VERSION		= 62,
 	IWL_UCODE_TLV_PNVM_SKU			= 64,
-	IWL_UCODE_TLV_TCM_DEBUG_ADDRS		= 65,
 
 	IWL_UCODE_TLV_SEC_TABLE_ADDR		= 66,
 	IWL_UCODE_TLV_D3_KEK_KCK_ADDR		= 67,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 40e8d7ed5615..e8550fe3b39c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -586,6 +586,51 @@ static void iwl_drv_set_dump_exclude(struct iwl_drv *drv,
 	excl->size = le32_to_cpu(fw->size);
 }
 
+static void iwl_parse_dbg_tlv_assert_tables(struct iwl_drv *drv,
+					    const struct iwl_ucode_tlv *tlv)
+{
+	const struct iwl_fw_ini_region_tlv *region;
+	u32 length = le32_to_cpu(tlv->length);
+	u32 addr;
+
+	if (length < offsetof(typeof(*region), special_mem) +
+		     sizeof(region->special_mem))
+		return;
+
+	region = (void *)tlv->data;
+	addr = le32_to_cpu(region->special_mem.base_addr);
+	addr += le32_to_cpu(region->special_mem.offset);
+	addr &= ~FW_ADDR_CACHE_CONTROL;
+
+	if (region->type != IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY)
+		return;
+
+	switch (region->sub_type) {
+	case IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_UMAC_ERROR_TABLE:
+		drv->trans->dbg.umac_error_event_table = addr;
+		drv->trans->dbg.error_event_table_tlv_status |=
+			IWL_ERROR_EVENT_TABLE_UMAC;
+		break;
+	case IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_LMAC_1_ERROR_TABLE:
+		drv->trans->dbg.lmac_error_event_table[0] = addr;
+		drv->trans->dbg.error_event_table_tlv_status |=
+			IWL_ERROR_EVENT_TABLE_LMAC1;
+		break;
+	case IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_LMAC_2_ERROR_TABLE:
+		drv->trans->dbg.lmac_error_event_table[1] = addr;
+		drv->trans->dbg.error_event_table_tlv_status |=
+			IWL_ERROR_EVENT_TABLE_LMAC2;
+		break;
+	case IWL_FW_INI_REGION_DEVICE_MEMORY_SUBTYPE_TCM_1_ERROR_TABLE:
+		drv->trans->dbg.tcm_error_event_table = addr;
+		drv->trans->dbg.error_event_table_tlv_status |=
+			IWL_ERROR_EVENT_TABLE_TCM;
+		break;
+	default:
+		break;
+	}
+}
+
 static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				const struct firmware *ucode_raw,
 				struct iwl_firmware_pieces *pieces,
@@ -1153,21 +1198,12 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				IWL_ERROR_EVENT_TABLE_LMAC1;
 			break;
 			}
-		case IWL_UCODE_TLV_TCM_DEBUG_ADDRS: {
-			struct iwl_fw_tcm_error_addr *ptr = (void *)tlv_data;
-
-			if (tlv_len != sizeof(*ptr))
-				goto invalid_tlv_len;
-			drv->trans->dbg.tcm_error_event_table =
-				le32_to_cpu(ptr->addr) & ~FW_ADDR_CACHE_CONTROL;
-			drv->trans->dbg.error_event_table_tlv_status |=
-				IWL_ERROR_EVENT_TABLE_TCM;
-			break;
-			}
+		case IWL_UCODE_TLV_TYPE_REGIONS:
+			iwl_parse_dbg_tlv_assert_tables(drv, tlv);
+			fallthrough;
 		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
 		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
 		case IWL_UCODE_TLV_TYPE_HCMD:
-		case IWL_UCODE_TLV_TYPE_REGIONS:
 		case IWL_UCODE_TLV_TYPE_TRIGGERS:
 		case IWL_UCODE_TLV_TYPE_CONF_SET:
 			if (iwlwifi_mod_params.enable_ini)
-- 
2.34.1

