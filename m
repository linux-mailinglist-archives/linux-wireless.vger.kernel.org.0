Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339B152872
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfFYJpF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54636 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728123AbfFYJpD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0b-0007Nv-Lk; Tue, 25 Jun 2019 12:45:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 08/12] iwlwifi: dbg_ini: support debug info TLV
Date:   Tue, 25 Jun 2019 12:44:48 +0300
Message-Id: <20190625094452.19034-9-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Add support to debug info TLV.
The TLV contains human readable naming of the FW image and the
debug configuration.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 22 +++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 65 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  | 13 ++--
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 ++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  1 +
 6 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index f4202bc231a6..aaf3974a9a20 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -291,6 +291,28 @@ struct iwl_fw_ini_trigger_tlv {
 	struct iwl_fw_ini_trigger trigger_config[];
 } __packed; /* FW_TLV_DEBUG_TRIGGERS_API_S_VER_1 */
 
+#define IWL_FW_INI_MAX_IMG_NAME_LEN 32
+#define IWL_FW_INI_MAX_DBG_CFG_NAME_LEN 64
+
+/**
+ * struct iwl_fw_ini_debug_info_tlv - (IWL_UCODE_TLV_TYPE_DEBUG_INFO)
+ *
+ * holds image name and debug configuration name
+ *
+ * @header: header
+ * @img_name_len: length of the image name string
+ * @img_name: image name string
+ * @dbg_cfg_name_len : length of the debug configuration name string
+ * @dbg_cfg_name: debug configuration name string
+ */
+struct iwl_fw_ini_debug_info_tlv {
+	struct iwl_fw_ini_header header;
+	__le32 img_name_len;
+	u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
+	__le32 dbg_cfg_name_len;
+	u8 dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
+} __packed; /* FW_DEBUG_TLV_INFO_API_S_VER_1 */
+
 /**
  * enum iwl_fw_ini_trigger_id
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2f6881bfcde6..806eb9847f72 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2373,6 +2373,38 @@ void iwl_fw_dbg_read_d3_debug_data(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_read_d3_debug_data);
 
+static void iwl_fw_dbg_info_apply(struct iwl_fw_runtime *fwrt,
+				  struct iwl_fw_ini_debug_info_tlv *dbg_info,
+				  bool ext, enum iwl_fw_ini_apply_point pnt)
+{
+	u32 img_name_len = le32_to_cpu(dbg_info->img_name_len);
+	u32 dbg_cfg_name_len = le32_to_cpu(dbg_info->dbg_cfg_name_len);
+	const char err_str[] =
+		"WRT: ext=%d. Invalid %s name length %d, expected %d\n";
+
+	if (img_name_len != IWL_FW_INI_MAX_IMG_NAME_LEN) {
+		IWL_WARN(fwrt, err_str, ext, "image", img_name_len,
+			 IWL_FW_INI_MAX_IMG_NAME_LEN);
+		return;
+	}
+
+	if (dbg_cfg_name_len != IWL_FW_INI_MAX_DBG_CFG_NAME_LEN) {
+		IWL_WARN(fwrt, err_str, ext, "debug cfg", dbg_cfg_name_len,
+			 IWL_FW_INI_MAX_DBG_CFG_NAME_LEN);
+		return;
+	}
+
+	if (ext) {
+		memcpy(fwrt->dump.external_dbg_cfg_name, dbg_info->dbg_cfg_name,
+		       sizeof(fwrt->dump.external_dbg_cfg_name));
+	} else {
+		memcpy(fwrt->dump.img_name, dbg_info->img_name,
+		       sizeof(fwrt->dump.img_name));
+		memcpy(fwrt->dump.internal_dbg_cfg_name, dbg_info->dbg_cfg_name,
+		       sizeof(fwrt->dump.internal_dbg_cfg_name));
+	}
+}
+
 static void
 iwl_fw_dbg_buffer_allocation(struct iwl_fw_runtime *fwrt, u32 size)
 {
@@ -2679,6 +2711,9 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 		u32 type = le32_to_cpu(tlv->type);
 
 		switch (type) {
+		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
+			iwl_fw_dbg_info_apply(fwrt, ini_tlv, ext, pnt);
+			break;
 		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION: {
 			struct iwl_fw_ini_allocation_data *buf_alloc = ini_tlv;
 
@@ -2714,22 +2749,34 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 	}
 }
 
+static void iwl_fw_dbg_ini_reset_cfg(struct iwl_fw_runtime *fwrt)
+{
+	int i;
+
+	for (i = 0; i < IWL_FW_INI_MAX_REGION_ID; i++)
+		fwrt->dump.active_regs[i] = NULL;
+
+	/* disable the triggers, used in recovery flow */
+	for (i = 0; i < IWL_FW_TRIGGER_ID_NUM; i++)
+		fwrt->dump.active_trigs[i].active = false;
+
+	memset(fwrt->dump.img_name, 0,
+	       sizeof(fwrt->dump.img_name));
+	memset(fwrt->dump.internal_dbg_cfg_name, 0,
+	       sizeof(fwrt->dump.internal_dbg_cfg_name));
+	memset(fwrt->dump.external_dbg_cfg_name, 0,
+	       sizeof(fwrt->dump.external_dbg_cfg_name));
+}
+
 void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_apply_point apply_point)
 {
 	void *data = &fwrt->trans->apply_points[apply_point];
-	int i;
 
 	IWL_DEBUG_FW(fwrt, "WRT: enabling apply point %d\n", apply_point);
 
-	if (apply_point == IWL_FW_INI_APPLY_EARLY) {
-		for (i = 0; i < IWL_FW_INI_MAX_REGION_ID; i++)
-			fwrt->dump.active_regs[i] = NULL;
-
-		/* disable the triggers, used in recovery flow */
-		for (i = 0; i < IWL_FW_TRIGGER_ID_NUM; i++)
-			fwrt->dump.active_trigs[i].active = false;
-	}
+	if (apply_point == IWL_FW_INI_APPLY_EARLY)
+		iwl_fw_dbg_ini_reset_cfg(fwrt);
 
 	_iwl_fw_dbg_apply_point(fwrt, data, apply_point, false);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index de9243d30135..71438c40a637 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -151,12 +151,13 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_FW_RECOVERY_INFO	= 57,
 	IWL_UCODE_TLV_FW_FSEQ_VERSION	= 60,
 
-	IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION	= IWL_UCODE_INI_TLV_GROUP + 0x1,
-	IWL_UCODE_TLV_DEBUG_BASE = IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION,
-	IWL_UCODE_TLV_TYPE_HCMD			= IWL_UCODE_INI_TLV_GROUP + 0x2,
-	IWL_UCODE_TLV_TYPE_REGIONS		= IWL_UCODE_INI_TLV_GROUP + 0x3,
-	IWL_UCODE_TLV_TYPE_TRIGGERS		= IWL_UCODE_INI_TLV_GROUP + 0x4,
-	IWL_UCODE_TLV_TYPE_DEBUG_FLOW		= IWL_UCODE_INI_TLV_GROUP + 0x5,
+	IWL_UCODE_TLV_DEBUG_BASE		= IWL_UCODE_INI_TLV_GROUP,
+	IWL_UCODE_TLV_TYPE_DEBUG_INFO		= IWL_UCODE_TLV_DEBUG_BASE + 0,
+	IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION	= IWL_UCODE_TLV_DEBUG_BASE + 1,
+	IWL_UCODE_TLV_TYPE_HCMD			= IWL_UCODE_TLV_DEBUG_BASE + 2,
+	IWL_UCODE_TLV_TYPE_REGIONS		= IWL_UCODE_TLV_DEBUG_BASE + 3,
+	IWL_UCODE_TLV_TYPE_TRIGGERS		= IWL_UCODE_TLV_DEBUG_BASE + 4,
+	IWL_UCODE_TLV_TYPE_DEBUG_FLOW		= IWL_UCODE_TLV_DEBUG_BASE + 5,
 	IWL_UCODE_TLV_DEBUG_MAX = IWL_UCODE_TLV_TYPE_DEBUG_FLOW,
 
 	/* TLVs 0x1000-0x2000 are for internal driver usage */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index e351ac7ae53b..07196a9fa5db 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -146,6 +146,10 @@ struct iwl_fw_runtime {
 		u32 umac_err_id;
 		void *fifo_iter;
 		struct timer_list periodic_trig;
+
+		u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
+		u8 internal_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
+		u8 external_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
 	} dump;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	struct {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index ba66f7fba064..fcc1c5c1d013 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -221,6 +221,7 @@ static int iwl_parse_fw_dbg_tlv(struct iwl_trans *trans, const u8 *data,
 		data += sizeof(*tlv) + ALIGN(tlv_len, 4);
 
 		switch (tlv_type) {
+		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
 		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
 		case IWL_UCODE_TLV_TYPE_HCMD:
 		case IWL_UCODE_TLV_TYPE_REGIONS:
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 852d3cbfc719..e14811ca75b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1137,6 +1137,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				IWL_ERROR_EVENT_TABLE_LMAC1;
 			break;
 			}
+		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
 		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
 		case IWL_UCODE_TLV_TYPE_HCMD:
 		case IWL_UCODE_TLV_TYPE_REGIONS:
-- 
2.20.1

