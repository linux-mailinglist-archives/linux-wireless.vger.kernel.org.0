Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A6D50B7
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfJLPso (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48648 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729274AbfJLPso (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:44 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdJ-0005yf-22; Sat, 12 Oct 2019 18:48:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:20 +0300
Message-Id: <20191012184707.3a24e06ea0a8.I471d6d0273cf1d2c71d19fd4f5bd508332be12fd@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012154828.9249-1-luca@coelho.fi>
References: <20191012154828.9249-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 08/16] iwlwifi: dbg_ini: add TLV allocation new API support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Add new debug TLVs API preprocessing.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  50 ++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 224 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  11 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   3 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +
 6 files changed, 256 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 9f110bf6b71b..21e1de9166cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -62,19 +62,6 @@
 
 #define IWL_FW_INI_MAX_CFG_NAME			64
 
-/**
- * struct iwl_fw_ini_header: Common Header for all debug group TLV's structures
- *
- * @tlv_version: version info
- * @apply_point: &enum iwl_fw_ini_apply_point
- * @data: TLV data followed
- */
-struct iwl_fw_ini_header {
-	__le32 tlv_version;
-	__le32 apply_point;
-	u8 data[];
-} __packed; /* FW_DEBUG_TLV_HEADER_S */
-
 /**
  * enum iwl_fw_ini_dbg_domain - debug domains
  * allows to send host cmd or collect memory region if a given domain is enabled
@@ -103,22 +90,17 @@ struct iwl_fw_ini_hcmd {
 } __packed; /* FW_DEBUG_TLV_HCMD_DATA_API_S_VER_1 */
 
 /**
- * struct iwl_fw_ini_hcmd_tlv - (IWL_UCODE_TLV_TYPE_HCMD)
- * Generic Host command pass through TLV
+ * struct iwl_fw_ini_header - Common Header for all ini debug TLV's structures
  *
- * @header: header
- * @domain: send command only if the specific domain is enabled
- *	&enum iwl_fw_ini_dbg_domain
- * @period_msec: period in which the hcmd will be sent to FW. Measured in msec
- *	(0 = one time command).
- * @hcmd: a variable length host-command to be sent to apply the configuration.
+ * @version: TLV version
+ * @domain: domain of the TLV. One of &enum iwl_fw_ini_dbg_domain
+ * @data: TLV data
  */
-struct iwl_fw_ini_hcmd_tlv {
-	struct iwl_fw_ini_header header;
+struct iwl_fw_ini_header {
+	__le32 version;
 	__le32 domain;
-	__le32 period_msec;
-	struct iwl_fw_ini_hcmd hcmd;
-} __packed; /* FW_DEBUG_TLV_HCMD_API_S_VER_1 */
+	u8 data[];
+} __packed; /* FW_TLV_DEBUG_HEADER_S_VER_1 */
 
 #define IWL_FW_INI_MAX_REGION_ID	64
 #define IWL_FW_INI_MAX_NAME		32
@@ -397,6 +379,22 @@ struct iwl_fw_ini_trigger_tlv {
 	__le32 data[];
 } __packed; /* FW_TLV_DEBUG_TRIGGER_API_S_VER_1 */
 
+/**
+ * struct iwl_fw_ini_hcmd_tlv - Generic Host command pass through TLV
+ *
+ * @hdr: debug header
+ * @time_point: time point. One of &enum iwl_fw_ini_time_point
+ * @period_msec: interval at which the hcmd will be sent to the FW.
+ *	Measured in msec (0 = one time command)
+ * @hcmd: a variable length host-command to be sent to apply the configuration
+ */
+struct iwl_fw_ini_hcmd_tlv {
+	struct iwl_fw_ini_header hdr;
+	__le32 time_point;
+	__le32 period_msec;
+	struct iwl_fw_ini_hcmd hcmd;
+} __packed; /* FW_TLV_DEBUG_HCMD_API_S_VER_1 */
+
 /**
  * enum iwl_fw_ini_trigger_id
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 423cc0cf8e78..105fd37f7da5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -93,7 +93,7 @@ struct iwl_ucode_header {
 	} u;
 };
 
-#define IWL_UCODE_INI_TLV_GROUP	0x1000000
+#define IWL_UCODE_TLV_DEBUG_BASE	0x1000005
 
 /*
  * new TLV uCode file layout
@@ -151,7 +151,6 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_FW_RECOVERY_INFO	= 57,
 	IWL_UCODE_TLV_FW_FSEQ_VERSION	= 60,
 
-	IWL_UCODE_TLV_DEBUG_BASE		= IWL_UCODE_INI_TLV_GROUP,
 	IWL_UCODE_TLV_TYPE_DEBUG_INFO		= IWL_UCODE_TLV_DEBUG_BASE + 0,
 	IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION	= IWL_UCODE_TLV_DEBUG_BASE + 1,
 	IWL_UCODE_TLV_TYPE_HCMD			= IWL_UCODE_TLV_DEBUG_BASE + 2,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 3d7f8ff8ef58..651e1fee2763 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -104,12 +104,27 @@ dbg_ver_table[IWL_DBG_TLV_TYPE_NUM] = {
 	[IWL_DBG_TLV_TYPE_TRIGGER]	= {.min_ver = 1, .max_ver = 1,},
 };
 
+static int iwl_dbg_tlv_add(struct iwl_ucode_tlv *tlv, struct list_head *list)
+{
+	u32 len = le32_to_cpu(tlv->length);
+	struct iwl_dbg_tlv_node *node;
+
+	node = kzalloc(sizeof(*node) + len, GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	memcpy(&node->tlv, tlv, sizeof(node->tlv) + len);
+	list_add_tail(&node->list, list);
+
+	return 0;
+}
+
 static bool iwl_dbg_tlv_ver_support(struct iwl_ucode_tlv *tlv)
 {
 	struct iwl_fw_ini_header *hdr = (void *)&tlv->data[0];
 	u32 type = le32_to_cpu(tlv->type);
 	u32 tlv_idx = type - IWL_UCODE_TLV_DEBUG_BASE;
-	u32 ver = le32_to_cpu(hdr->tlv_version);
+	u32 ver = le32_to_cpu(hdr->version);
 
 	if (ver < dbg_ver_table[tlv_idx].min_ver ||
 	    ver > dbg_ver_table[tlv_idx].max_ver)
@@ -118,27 +133,169 @@ static bool iwl_dbg_tlv_ver_support(struct iwl_ucode_tlv *tlv)
 	return true;
 }
 
+static int iwl_dbg_tlv_alloc_debug_info(struct iwl_trans *trans,
+					struct iwl_ucode_tlv *tlv)
+{
+	struct iwl_fw_ini_debug_info_tlv *debug_info = (void *)tlv->data;
+
+	if (le32_to_cpu(tlv->length) != sizeof(*debug_info))
+		return -EINVAL;
+
+	IWL_DEBUG_FW(trans, "WRT: Loading debug cfg: %s\n",
+		     debug_info->debug_cfg_name);
+
+	return iwl_dbg_tlv_add(tlv, &trans->dbg.debug_info_tlv_list);
+}
+
+static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
+				       struct iwl_ucode_tlv *tlv)
+{
+	struct iwl_fw_ini_allocation_tlv *alloc = (void *)tlv->data;
+	u32 buf_location = le32_to_cpu(alloc->buf_location);
+	u32 alloc_id = le32_to_cpu(alloc->alloc_id);
+
+	if (le32_to_cpu(tlv->length) != sizeof(*alloc) ||
+	    (buf_location != IWL_FW_INI_LOCATION_SRAM_PATH &&
+	     buf_location != IWL_FW_INI_LOCATION_DRAM_PATH))
+		return -EINVAL;
+
+	if ((buf_location == IWL_FW_INI_LOCATION_SRAM_PATH &&
+	     alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1) ||
+	    (buf_location == IWL_FW_INI_LOCATION_DRAM_PATH &&
+	     (alloc_id == IWL_FW_INI_ALLOCATION_INVALID ||
+	      alloc_id >= IWL_FW_INI_ALLOCATION_NUM))) {
+		IWL_ERR(trans,
+			"WRT: Invalid allocation id %u for allocation TLV\n",
+			alloc_id);
+		return -EINVAL;
+	}
+
+	trans->dbg.fw_mon_cfg[alloc_id] = *alloc;
+
+	return 0;
+}
+
+static int iwl_dbg_tlv_alloc_hcmd(struct iwl_trans *trans,
+				  struct iwl_ucode_tlv *tlv)
+{
+	struct iwl_fw_ini_hcmd_tlv *hcmd = (void *)tlv->data;
+	u32 tp = le32_to_cpu(hcmd->time_point);
+
+	if (le32_to_cpu(tlv->length) <= sizeof(*hcmd))
+		return -EINVAL;
+
+	/* Host commands can not be sent in early time point since the FW
+	 * is not ready
+	 */
+	if (tp == IWL_FW_INI_TIME_POINT_INVALID ||
+	    tp >= IWL_FW_INI_TIME_POINT_NUM ||
+	    tp == IWL_FW_INI_TIME_POINT_EARLY) {
+		IWL_ERR(trans,
+			"WRT: Invalid time point %u for host command TLV\n",
+			tp);
+		return -EINVAL;
+	}
+
+	return iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].hcmd_list);
+}
+
+static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
+				    struct iwl_ucode_tlv *tlv)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)tlv->data;
+	struct iwl_ucode_tlv **active_reg;
+	u32 id = le32_to_cpu(reg->id);
+	u32 type = le32_to_cpu(reg->type);
+	u32 tlv_len = sizeof(*tlv) + le32_to_cpu(tlv->length);
+
+	if (le32_to_cpu(tlv->length) < sizeof(*reg))
+		return -EINVAL;
+
+	if (id >= IWL_FW_INI_MAX_REGION_ID) {
+		IWL_ERR(trans, "WRT: Invalid region id %u\n", id);
+		return -EINVAL;
+	}
+
+	if (type <= IWL_FW_INI_REGION_INVALID ||
+	    type >= IWL_FW_INI_REGION_NUM) {
+		IWL_ERR(trans, "WRT: Invalid region type %u\n", type);
+		return -EINVAL;
+	}
+
+	active_reg = &trans->dbg.active_regions[id];
+	if (*active_reg) {
+		IWL_WARN(trans, "WRT: Overriding region id %u\n", id);
+
+		kfree(*active_reg);
+	}
+
+	*active_reg = kmemdup(tlv, tlv_len, GFP_KERNEL);
+	if (!*active_reg)
+		return -ENOMEM;
+
+	IWL_DEBUG_FW(trans, "WRT: Enabling region id %u type %u\n", id, type);
+
+	return 0;
+}
+
+static int iwl_dbg_tlv_alloc_trigger(struct iwl_trans *trans,
+				     struct iwl_ucode_tlv *tlv)
+{
+	struct iwl_fw_ini_trigger_tlv *trig = (void *)tlv->data;
+	u32 tp = le32_to_cpu(trig->time_point);
+
+	if (le32_to_cpu(tlv->length) < sizeof(*trig))
+		return -EINVAL;
+
+	if (tp <= IWL_FW_INI_TIME_POINT_INVALID ||
+	    tp >= IWL_FW_INI_TIME_POINT_NUM) {
+		IWL_ERR(trans,
+			"WRT: Invalid time point %u for trigger TLV\n",
+			tp);
+		return -EINVAL;
+	}
+
+	if (!le32_to_cpu(trig->occurrences))
+		trig->occurrences = cpu_to_le32(-1);
+
+	return iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].trig_list);
+}
+
+static int (*dbg_tlv_alloc[])(struct iwl_trans *trans,
+			      struct iwl_ucode_tlv *tlv) = {
+	[IWL_DBG_TLV_TYPE_DEBUG_INFO]	= iwl_dbg_tlv_alloc_debug_info,
+	[IWL_DBG_TLV_TYPE_BUF_ALLOC]	= iwl_dbg_tlv_alloc_buf_alloc,
+	[IWL_DBG_TLV_TYPE_HCMD]		= iwl_dbg_tlv_alloc_hcmd,
+	[IWL_DBG_TLV_TYPE_REGION]	= iwl_dbg_tlv_alloc_region,
+	[IWL_DBG_TLV_TYPE_TRIGGER]	= iwl_dbg_tlv_alloc_trigger,
+};
+
 void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 		       bool ext)
 {
 	struct iwl_fw_ini_header *hdr = (void *)&tlv->data[0];
 	u32 type = le32_to_cpu(tlv->type);
-	u32 pnt = le32_to_cpu(hdr->apply_point);
 	u32 tlv_idx = type - IWL_UCODE_TLV_DEBUG_BASE;
 	enum iwl_ini_cfg_state *cfg_state = ext ?
 		&trans->dbg.external_ini_cfg : &trans->dbg.internal_ini_cfg;
+	int ret;
 
-	IWL_DEBUG_FW(trans, "WRT: read TLV 0x%x, apply point %d\n",
-		     type, pnt);
-
-	if (tlv_idx >= IWL_DBG_TLV_TYPE_NUM) {
-		IWL_ERR(trans, "WRT: Unsupported TLV 0x%x\n", type);
+	if (tlv_idx >= ARRAY_SIZE(dbg_tlv_alloc) || !dbg_tlv_alloc[tlv_idx]) {
+		IWL_ERR(trans, "WRT: Unsupported TLV type 0x%x\n", type);
 		goto out_err;
 	}
 
 	if (!iwl_dbg_tlv_ver_support(tlv)) {
 		IWL_ERR(trans, "WRT: Unsupported TLV 0x%x version %u\n", type,
-			le32_to_cpu(hdr->tlv_version));
+			le32_to_cpu(hdr->version));
+		goto out_err;
+	}
+
+	ret = dbg_tlv_alloc[tlv_idx](trans, tlv);
+	if (ret) {
+		IWL_ERR(trans,
+			"WRT: Failed to allocate TLV 0x%x, ret %d, (ext=%d)\n",
+			type, ret, ext);
 		goto out_err;
 	}
 
@@ -159,7 +316,41 @@ IWL_EXPORT_SYMBOL(iwl_dbg_tlv_del_timers);
 
 void iwl_dbg_tlv_free(struct iwl_trans *trans)
 {
-	/* will be used again later */
+	struct iwl_dbg_tlv_node *tlv_node, *tlv_node_tmp;
+	int i;
+
+	iwl_dbg_tlv_del_timers(trans);
+
+	for (i = 0; i < ARRAY_SIZE(trans->dbg.active_regions); i++) {
+		struct iwl_ucode_tlv **active_reg =
+			&trans->dbg.active_regions[i];
+
+		kfree(*active_reg);
+		*active_reg = NULL;
+	}
+
+	list_for_each_entry_safe(tlv_node, tlv_node_tmp,
+				 &trans->dbg.debug_info_tlv_list, list) {
+		list_del(&tlv_node->list);
+		kfree(tlv_node);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(trans->dbg.time_point); i++) {
+		struct iwl_dbg_tlv_time_point_data *tp =
+			&trans->dbg.time_point[i];
+
+		list_for_each_entry_safe(tlv_node, tlv_node_tmp, &tp->trig_list,
+					 list) {
+			list_del(&tlv_node->list);
+			kfree(tlv_node);
+		}
+
+		list_for_each_entry_safe(tlv_node, tlv_node_tmp, &tp->hcmd_list,
+					 list) {
+			list_del(&tlv_node->list);
+			kfree(tlv_node);
+		}
+	}
 }
 
 static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,
@@ -205,6 +396,21 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 	release_firmware(fw);
 }
 
+void iwl_dbg_tlv_init(struct iwl_trans *trans)
+{
+	int i;
+
+	INIT_LIST_HEAD(&trans->dbg.debug_info_tlv_list);
+
+	for (i = 0; i < ARRAY_SIZE(trans->dbg.time_point); i++) {
+		struct iwl_dbg_tlv_time_point_data *tp =
+			&trans->dbg.time_point[i];
+
+		INIT_LIST_HEAD(&tp->trig_list);
+		INIT_LIST_HEAD(&tp->hcmd_list);
+	}
+}
+
 void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_time_point tp_id,
 			    union iwl_dbg_tlv_tp_data *tp_data)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 521aa6ba17e2..64c0638998f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -82,6 +82,16 @@ union iwl_dbg_tlv_tp_data {
 	struct iwl_rx_packet *fw_pkt;
 };
 
+/**
+ * struct iwl_dbg_tlv_time_point_data
+ * @trig_list: list of triggers
+ * @hcmd_list: list of host commands
+ */
+struct iwl_dbg_tlv_time_point_data {
+	struct list_head trig_list;
+	struct list_head hcmd_list;
+};
+
 struct iwl_trans;
 struct iwl_fw_runtime;
 
@@ -89,6 +99,7 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans);
 void iwl_dbg_tlv_free(struct iwl_trans *trans);
 void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 		       bool ext);
+void iwl_dbg_tlv_init(struct iwl_trans *trans);
 void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_time_point tp_id,
 			    union iwl_dbg_tlv_tp_data *tp_data);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9dd74fe9a0bb..63031c030600 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -723,6 +723,7 @@ struct iwl_self_init_dram {
  * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
  * @active_regions: active regions
  * @debug_info_tlv_list: list of debug info TLVs
+ * @time_point: array of debug time points
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -749,6 +750,8 @@ struct iwl_trans_debug {
 
 	struct iwl_ucode_tlv *active_regions[IWL_FW_INI_MAX_REGION_ID];
 	struct list_head debug_info_tlv_list;
+	struct iwl_dbg_tlv_time_point_data
+		time_point[IWL_FW_INI_TIME_POINT_NUM];
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 871b0b9244f9..cd1091704de0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3614,6 +3614,8 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	mutex_init(&trans_pcie->fw_mon_data.mutex);
 #endif
 
+	iwl_dbg_tlv_init(trans);
+
 	return trans;
 
 out_free_ict:
-- 
2.23.0

