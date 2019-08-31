Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8389A43C2
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfHaJtO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:49:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39676 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726890AbfHaJtO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:49:14 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400N-0002OQ-EU; Sat, 31 Aug 2019 12:49:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:49 +0300
Message-Id: <20190831094859.6391-10-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 09/19] iwlwifi: dbg_ini: verify debug TLVs at allocation phase
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Reimplement debug TLV allocation flow. The driver will check the
validity of the debug TLVs prior allocating space for them.
Any malformed or unsupported TLV will be skipped.
The TLV specific checks will be added in later patches.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  15 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 151 +++++++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  24 ++-
 5 files changed, 139 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3679ba89ea9d..6e5a3289e04a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1739,7 +1739,7 @@ static void iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	dump->version = cpu_to_le32(IWL_INI_DUMP_VER);
 	dump->trigger_id = trigger->trigger_id;
 	dump->is_external_cfg =
-		cpu_to_le32(fwrt->trans->dbg.external_ini_loaded);
+		cpu_to_le32(fwrt->trans->dbg.external_ini_cfg);
 
 	dump->ver_type = cpu_to_le32(fwrt->dump.fw_ver.type);
 	dump->ver_subtype = cpu_to_le32(fwrt->dump.fw_ver.subtype);
@@ -2855,17 +2855,22 @@ static void iwl_fw_dbg_ini_reset_cfg(struct iwl_fw_runtime *fwrt)
 void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_apply_point apply_point)
 {
-	void *data = &fwrt->trans->dbg.apply_points[apply_point];
+	void *data;
 
 	IWL_DEBUG_FW(fwrt, "WRT: enabling apply point %d\n", apply_point);
 
 	if (apply_point == IWL_FW_INI_APPLY_EARLY)
 		iwl_fw_dbg_ini_reset_cfg(fwrt);
 
-	_iwl_fw_dbg_apply_point(fwrt, data, apply_point, false);
+	if (fwrt->trans->dbg.internal_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
+		data = &fwrt->trans->dbg.apply_points[apply_point];
+		_iwl_fw_dbg_apply_point(fwrt, data, apply_point, false);
+	}
 
-	data = &fwrt->trans->dbg.apply_points_ext[apply_point];
-	_iwl_fw_dbg_apply_point(fwrt, data, apply_point, true);
+	if (fwrt->trans->dbg.external_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
+		data = &fwrt->trans->dbg.apply_points_ext[apply_point];
+		_iwl_fw_dbg_apply_point(fwrt, data, apply_point, true);
+	}
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_apply_point);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 7c1e76ee7ede..5b1644a70ace 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -63,46 +63,124 @@
 #include "iwl-trans.h"
 #include "iwl-dbg-tlv.h"
 
-void iwl_dbg_tlv_copy(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
-		      bool ext)
+/**
+ * enum iwl_dbg_tlv_type - debug TLV types
+ * @IWL_DBG_TLV_TYPE_DEBUG_INFO: debug info TLV
+ * @IWL_DBG_TLV_TYPE_BUF_ALLOC: buffer allocation TLV
+ * @IWL_DBG_TLV_TYPE_HCMD: host command TLV
+ * @IWL_DBG_TLV_TYPE_REGION: region TLV
+ * @IWL_DBG_TLV_TYPE_TRIGGER: trigger TLV
+ * @IWL_DBG_TLV_TYPE_NUM: number of debug TLVs
+ */
+enum iwl_dbg_tlv_type {
+	IWL_DBG_TLV_TYPE_DEBUG_INFO =
+		IWL_UCODE_TLV_TYPE_DEBUG_INFO - IWL_UCODE_TLV_DEBUG_BASE,
+	IWL_DBG_TLV_TYPE_BUF_ALLOC,
+	IWL_DBG_TLV_TYPE_HCMD,
+	IWL_DBG_TLV_TYPE_REGION,
+	IWL_DBG_TLV_TYPE_TRIGGER,
+	IWL_DBG_TLV_TYPE_NUM,
+};
+
+/**
+ * struct iwl_dbg_tlv_ver_data -  debug TLV version struct
+ * @min_ver: min version supported
+ * @max_ver: max version supported
+ */
+struct iwl_dbg_tlv_ver_data {
+	int min_ver;
+	int max_ver;
+};
+
+static const struct iwl_dbg_tlv_ver_data
+dbg_ver_table[IWL_DBG_TLV_TYPE_NUM] = {
+	[IWL_DBG_TLV_TYPE_DEBUG_INFO]	= {.min_ver = 1, .max_ver = 1,},
+	[IWL_DBG_TLV_TYPE_BUF_ALLOC]	= {.min_ver = 1, .max_ver = 1,},
+	[IWL_DBG_TLV_TYPE_HCMD]		= {.min_ver = 1, .max_ver = 1,},
+	[IWL_DBG_TLV_TYPE_REGION]	= {.min_ver = 1, .max_ver = 1,},
+	[IWL_DBG_TLV_TYPE_TRIGGER]	= {.min_ver = 1, .max_ver = 1,},
+};
+
+static int iwl_dbg_tlv_copy(struct iwl_ucode_tlv *tlv, struct list_head *list)
 {
-	struct iwl_apply_point_data *dbg_cfg, *tlv_copy;
-	struct iwl_fw_ini_header *header = (void *)&tlv->data[0];
-	u32 tlv_type = le32_to_cpu(tlv->type);
+	struct iwl_apply_point_data *tlv_copy;
 	u32 len = le32_to_cpu(tlv->length);
-	u32 apply_point = le32_to_cpu(header->apply_point);
 
-	if (le32_to_cpu(header->tlv_version) != 1)
-		return;
+	tlv_copy = kzalloc(sizeof(*tlv_copy) + len, GFP_KERNEL);
+	if (!tlv_copy)
+		return -ENOMEM;
 
-	if (WARN_ONCE(apply_point >= IWL_FW_INI_APPLY_NUM,
-		      "Invalid apply point %d\n", apply_point))
-		return;
+	INIT_LIST_HEAD(&tlv_copy->list);
+	memcpy(&tlv_copy->tlv, tlv, sizeof(*tlv) + len);
+
+	if (!list->next)
+		INIT_LIST_HEAD(list);
+
+	list_add_tail(&tlv_copy->list, list);
+
+	return 0;
+}
+
+static bool iwl_dbg_tlv_ver_support(struct iwl_ucode_tlv *tlv)
+{
+	struct iwl_fw_ini_header *hdr = (void *)&tlv->data[0];
+	u32 type = le32_to_cpu(tlv->type);
+	u32 tlv_idx = type - IWL_UCODE_TLV_DEBUG_BASE;
+	u32 ver = le32_to_cpu(hdr->tlv_version);
+
+	if (ver < dbg_ver_table[tlv_idx].min_ver ||
+	    ver > dbg_ver_table[tlv_idx].max_ver)
+		return false;
+
+	return true;
+}
+
+void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
+		       bool ext)
+{
+	struct iwl_fw_ini_header *hdr = (void *)&tlv->data[0];
+	u32 type = le32_to_cpu(tlv->type);
+	u32 pnt = le32_to_cpu(hdr->apply_point);
+	u32 tlv_idx = type - IWL_UCODE_TLV_DEBUG_BASE;
+	enum iwl_ini_cfg_state *cfg_state = ext ?
+		&trans->dbg.external_ini_cfg : &trans->dbg.internal_ini_cfg;
+	struct list_head *dbg_cfg_list = ext ?
+		&trans->dbg.apply_points_ext[pnt].list :
+		&trans->dbg.apply_points[pnt].list;
 
 	IWL_DEBUG_FW(trans, "WRT: read TLV 0x%x, apply point %d\n",
-		     tlv_type, apply_point);
+		     type, pnt);
 
-	if (ext)
-		dbg_cfg = &trans->dbg.apply_points_ext[apply_point];
-	else
-		dbg_cfg = &trans->dbg.apply_points[apply_point];
+	if (tlv_idx >= IWL_DBG_TLV_TYPE_NUM) {
+		IWL_ERR(trans, "WRT: Unsupported TLV 0x%x\n", type);
+		goto out_err;
+	}
 
-	tlv_copy = kzalloc(sizeof(*tlv_copy) + len, GFP_KERNEL);
-	if (!tlv_copy) {
-		IWL_ERR(trans, "WRT: No memory for TLV 0x%x, apply point %d\n",
-			tlv_type, apply_point);
-		return;
+	if (pnt >= IWL_FW_INI_APPLY_NUM) {
+		IWL_ERR(trans, "WRT: Invalid apply point %d\n", pnt);
+		goto out_err;
 	}
 
-	INIT_LIST_HEAD(&tlv_copy->list);
-	memcpy(&tlv_copy->tlv, tlv, sizeof(*tlv) + len);
+	if (!iwl_dbg_tlv_ver_support(tlv)) {
+		IWL_ERR(trans, "WRT: Unsupported TLV 0x%x version %u\n", type,
+			le32_to_cpu(hdr->tlv_version));
+		goto out_err;
+	}
 
-	if (!dbg_cfg->list.next)
-		INIT_LIST_HEAD(&dbg_cfg->list);
+	if (iwl_dbg_tlv_copy(tlv, dbg_cfg_list)) {
+		IWL_ERR(trans,
+			"WRT: Failed to allocate TLV 0x%x, apply point %d\n",
+			type, pnt);
+		goto out_err;
+	}
+
+	if (*cfg_state == IWL_INI_CFG_STATE_NOT_LOADED)
+		*cfg_state = IWL_INI_CFG_STATE_LOADED;
 
-	list_add_tail(&tlv_copy->list, &dbg_cfg->list);
+	return;
 
-	trans->dbg.ini_valid = true;
+out_err:
+	*cfg_state = IWL_INI_CFG_STATE_CORRUPTED;
 }
 
 static void iwl_dbg_tlv_free_list(struct list_head *list)
@@ -138,7 +216,6 @@ static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,
 				 size_t len)
 {
 	struct iwl_ucode_tlv *tlv;
-	enum iwl_ucode_tlv_type tlv_type;
 	u32 tlv_len;
 
 	while (len >= sizeof(*tlv)) {
@@ -146,7 +223,6 @@ static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,
 		tlv = (void *)data;
 
 		tlv_len = le32_to_cpu(tlv->length);
-		tlv_type = le32_to_cpu(tlv->type);
 
 		if (len < tlv_len) {
 			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
@@ -156,19 +232,7 @@ static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,
 		len -= ALIGN(tlv_len, 4);
 		data += sizeof(*tlv) + ALIGN(tlv_len, 4);
 
-		switch (tlv_type) {
-		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
-		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION:
-		case IWL_UCODE_TLV_TYPE_HCMD:
-		case IWL_UCODE_TLV_TYPE_REGIONS:
-		case IWL_UCODE_TLV_TYPE_TRIGGERS:
-		case IWL_UCODE_TLV_TYPE_DEBUG_FLOW:
-			iwl_dbg_tlv_copy(trans, tlv, true);
-			break;
-		default:
-			WARN_ONCE(1, "Invalid TLV %x\n", tlv_type);
-			break;
-		}
+		iwl_dbg_tlv_alloc(trans, tlv, true);
 	}
 
 	return 0;
@@ -179,7 +243,7 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 	const struct firmware *fw;
 	int res;
 
-	if (trans->dbg.external_ini_loaded || !iwlwifi_mod_params.enable_ini)
+	if (!iwlwifi_mod_params.enable_ini)
 		return;
 
 	res = request_firmware(&fw, "iwl-dbg-tlv.ini", dev);
@@ -188,6 +252,5 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 
 	iwl_dbg_tlv_parse_bin(trans, fw->data, fw->size);
 
-	trans->dbg.external_ini_loaded = true;
 	release_firmware(fw);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 72552de801d4..3a60590d274d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -77,7 +77,7 @@ struct iwl_apply_point_data {
 struct iwl_trans;
 void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans);
 void iwl_dbg_tlv_free(struct iwl_trans *trans);
-void iwl_dbg_tlv_copy(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
-		      bool ext);
+void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
+		       bool ext);
 
 #endif /* __iwl_dbg_tlv_h__*/
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 3792b421746e..1351f7fe5ae2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1153,7 +1153,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 		case IWL_UCODE_TLV_TYPE_TRIGGERS:
 		case IWL_UCODE_TLV_TYPE_DEBUG_FLOW:
 			if (iwlwifi_mod_params.enable_ini)
-				iwl_dbg_tlv_copy(drv->trans, tlv, false);
+				iwl_dbg_tlv_alloc(drv->trans, tlv, false);
 			break;
 		case IWL_UCODE_TLV_CMD_VERSIONS:
 			if (tlv_len % sizeof(struct iwl_fw_cmd_version)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 731ffb4a33af..09ed0dd163eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -650,6 +650,19 @@ enum iwl_plat_pm_mode {
 	IWL_PLAT_PM_MODE_D3,
 };
 
+/**
+ * enum iwl_ini_cfg_state
+ * @IWL_INI_CFG_STATE_NOT_LOADED: no debug cfg was given
+ * @IWL_INI_CFG_STATE_LOADED: debug cfg was found and loaded
+ * @IWL_INI_CFG_STATE_CORRUPTED: debug cfg was found and some of the TLVs
+ *	are corrupted. The rest of the debug TLVs will still be used
+ */
+enum iwl_ini_cfg_state {
+	IWL_INI_CFG_STATE_NOT_LOADED,
+	IWL_INI_CFG_STATE_LOADED,
+	IWL_INI_CFG_STATE_CORRUPTED,
+};
+
 /* Max time to wait for nmi interrupt */
 #define IWL_TRANS_NMI_TIMEOUT (HZ / 4)
 
@@ -691,8 +704,8 @@ struct iwl_self_init_dram {
  * @umac_error_event_table: addr of umac error table
  * @error_event_table_tlv_status: bitmap that indicates what error table
  *	pointers was recevied via TLV. uses enum &iwl_error_event_table_status
- * @external_ini_loaded: indicates if an external ini cfg was given
- * @ini_valid: indicates if debug ini mode is on
+ * @internal_ini_cfg: internal debug cfg state. Uses &enum iwl_ini_cfg_state
+ * @external_ini_cfg: external debug cfg state. Uses &enum iwl_ini_cfg_state
  * @num_blocks: number of blocks in fw_mon
  * @fw_mon: address of the buffers for firmware monitor
  * @is_alloc: bit i is set if buffer i was allocated
@@ -711,8 +724,8 @@ struct iwl_trans_debug {
 	u32 umac_error_event_table;
 	unsigned int error_event_table_tlv_status;
 
-	bool external_ini_loaded;
-	bool ini_valid;
+	enum iwl_ini_cfg_state internal_ini_cfg;
+	enum iwl_ini_cfg_state external_ini_cfg;
 
 	struct iwl_apply_point_data apply_points[IWL_FW_INI_APPLY_NUM];
 	struct iwl_apply_point_data apply_points_ext[IWL_FW_INI_APPLY_NUM];
@@ -1218,7 +1231,8 @@ static inline void iwl_trans_sync_nmi(struct iwl_trans *trans)
 
 static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
 {
-	return trans->dbg.ini_valid;
+	return trans->dbg.internal_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED ||
+		trans->dbg.external_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED;
 }
 
 /*****************************************************
-- 
2.23.0.rc1

