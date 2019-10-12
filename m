Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C845D50B5
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfJLPsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48642 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729354AbfJLPsm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:42 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdI-0005yf-6v; Sat, 12 Oct 2019 18:48:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:19 +0300
Message-Id: <20191012184707.8e267c37d3cd.I1c6a7ed1ce13d611d3c5f59d6b8d37bd3eb413cc@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012154828.9249-1-luca@coelho.fi>
References: <20191012154828.9249-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 07/16] iwlwifi: dbg_ini: use new API in dump info
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Make dump info region use new API.
debug_info_tlv_list list will be initialize in a future patch once the
driver will start using it.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 39 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 25 ++++++++++++
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 36 +++++++++--------
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 --
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  8 ++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +
 6 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 2754060dc4c6..9f110bf6b71b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -60,6 +60,8 @@
 
 #include <linux/bitops.h>
 
+#define IWL_FW_INI_MAX_CFG_NAME			64
+
 /**
  * struct iwl_fw_ini_header: Common Header for all debug group TLV's structures
  *
@@ -294,6 +296,21 @@ struct iwl_fw_ini_region_tlv {
 	__le32 addrs[];
 } __packed; /* FW_TLV_DEBUG_REGION_API_S_VER_1 */
 
+/**
+ * struct iwl_fw_ini_debug_info_tlv
+ *
+ * debug configuration name for a specific image
+ *
+ * @hdr: debug header
+ * @image_type: image type
+ * @debug_cfg_name: debug configuration name
+ */
+struct iwl_fw_ini_debug_info_tlv {
+	struct iwl_fw_ini_header hdr;
+	__le32 image_type;
+	u8 debug_cfg_name[IWL_FW_INI_MAX_CFG_NAME];
+} __packed; /* FW_TLV_DEBUG_INFO_API_S_VER_1 */
+
 /**
  * struct iwl_fw_ini_trigger
  *
@@ -380,28 +397,6 @@ struct iwl_fw_ini_trigger_tlv {
 	__le32 data[];
 } __packed; /* FW_TLV_DEBUG_TRIGGER_API_S_VER_1 */
 
-#define IWL_FW_INI_MAX_IMG_NAME_LEN 32
-#define IWL_FW_INI_MAX_DBG_CFG_NAME_LEN 64
-
-/**
- * struct iwl_fw_ini_debug_info_tlv - (IWL_UCODE_TLV_TYPE_DEBUG_INFO)
- *
- * holds image name and debug configuration name
- *
- * @header: header
- * @img_name_len: length of the image name string
- * @img_name: image name string
- * @dbg_cfg_name_len : length of the debug configuration name string
- * @dbg_cfg_name: debug configuration name string
- */
-struct iwl_fw_ini_debug_info_tlv {
-	struct iwl_fw_ini_header header;
-	__le32 img_name_len;
-	u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
-	__le32 dbg_cfg_name_len;
-	u8 dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
-} __packed; /* FW_DEBUG_TLV_INFO_API_S_VER_1 */
-
 /**
  * enum iwl_fw_ini_trigger_id
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ee555b8cf5bb..1e4143327add 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1864,7 +1864,15 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_dump_entry *entry;
 	struct iwl_fw_error_dump_data *tlv;
 	struct iwl_fw_ini_dump_info *dump;
+	struct iwl_dbg_tlv_node *node;
+	struct iwl_fw_ini_dump_cfg_name *cfg_name;
 	u32 size = sizeof(*tlv) + sizeof(*dump);
+	u32 num_of_cfg_names = 0;
+
+	list_for_each_entry(node, &fwrt->trans->dbg.debug_info_tlv_list, list) {
+		size += sizeof(*cfg_name);
+		num_of_cfg_names++;
+	}
 
 	entry = kmalloc(sizeof(*entry) + size, GFP_KERNEL);
 	if (!entry)
@@ -1901,10 +1909,27 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	dump->umac_major = cpu_to_le32(fwrt->dump.fw_ver.umac_major);
 	dump->umac_minor = cpu_to_le32(fwrt->dump.fw_ver.umac_minor);
 
+	dump->fw_mon_mode = cpu_to_le32(fwrt->trans->dbg.ini_dest);
+	dump->regions_mask = trigger->regions_mask;
+
 	dump->build_tag_len = cpu_to_le32(sizeof(dump->build_tag));
 	memcpy(dump->build_tag, fwrt->fw->human_readable,
 	       sizeof(dump->build_tag));
 
+	cfg_name = dump->cfg_names;
+	dump->num_of_cfg_names = cpu_to_le32(num_of_cfg_names);
+	list_for_each_entry(node, &fwrt->trans->dbg.debug_info_tlv_list, list) {
+		struct iwl_fw_ini_debug_info_tlv *debug_info =
+			(void *)node->tlv.data;
+
+		cfg_name->image_type = debug_info->image_type;
+		cfg_name->cfg_name_len =
+			cpu_to_le32(IWL_FW_INI_MAX_CFG_NAME);
+		memcpy(cfg_name->cfg_name, debug_info->debug_cfg_name,
+		       sizeof(cfg_name->cfg_name));
+		cfg_name++;
+	}
+
 	/* add dump info TLV to the beginning of the list since it needs to be
 	 * the first TLV in the dump
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 7be1c4b54503..a7bf17e5ca9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -379,6 +379,18 @@ struct iwl_fw_ini_error_dump_register {
 	__le32 data;
 } __packed;
 
+/**
+ * struct iwl_fw_ini_dump_cfg_name - configuration name
+ * @image_type: image type the configuration is related to
+ * @cfg_name_len: length of the configuration name
+ * @cfg_name: name of the configuraiton
+ */
+struct iwl_fw_ini_dump_cfg_name {
+	__le32 image_type;
+	__le32 cfg_name_len;
+	u8 cfg_name[IWL_FW_INI_MAX_CFG_NAME];
+} __packed;
+
 /* struct iwl_fw_ini_dump_info - ini dump information
  * @version: dump version
  * @time_point: time point that caused the dump collection
@@ -396,16 +408,12 @@ struct iwl_fw_ini_error_dump_register {
  * @lmac_minor: lmac minor version
  * @umac_major: umac major version
  * @umac_minor: umac minor version
+ * @fw_mon_mode: FW monitor mode &enum iwl_fw_ini_buffer_location
+ * @regions_mask: bitmap mask of regions ids in the dump
  * @build_tag_len: length of the build tag
  * @build_tag: build tag string
- * @img_name_len: length of the FW image name
- * @img_name: FW image name
- * @internal_dbg_cfg_name_len: length of the internal debug configuration name
- * @internal_dbg_cfg_name: internal debug configuration name
- * @external_dbg_cfg_name_len: length of the external debug configuration name
- * @external_dbg_cfg_name: external debug configuration name
- * @regions_num: number of region ids
- * @region_ids: region ids the trigger configured to collect
+ * @num_of_cfg_names: number of configuration name structs
+ * @cfg_names: configuration names
  */
 struct iwl_fw_ini_dump_info {
 	__le32 version;
@@ -424,16 +432,12 @@ struct iwl_fw_ini_dump_info {
 	__le32 lmac_minor;
 	__le32 umac_major;
 	__le32 umac_minor;
+	__le32 fw_mon_mode;
+	__le64 regions_mask;
 	__le32 build_tag_len;
 	u8 build_tag[FW_VER_HUMAN_READABLE_SZ];
-	__le32 img_name_len;
-	u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
-	__le32 internal_dbg_cfg_name_len;
-	u8 internal_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
-	__le32 external_dbg_cfg_name_len;
-	u8 external_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
-	__le32 regions_num;
-	__le32 region_ids[];
+	__le32 num_of_cfg_names;
+	struct iwl_fw_ini_dump_cfg_name cfg_names[];
 } __packed;
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index f3c56a2c2531..6c2ade4c7a0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -177,10 +177,6 @@ struct iwl_fw_runtime {
 
 		struct iwl_txf_iter_data txf_iter_data;
 
-		u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
-		u8 internal_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
-		u8 external_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
-
 		struct {
 			u8 type;
 			u8 subtype;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index e257ad358c94..521aa6ba17e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -65,11 +65,11 @@
 #include <linux/types.h>
 
 /**
- * struct iwl_apply_point_data
- * @list: list to go through the TLVs of the apply point
- * @tlv: a debug TLV
+ * struct iwl_dbg_tlv_node - debug TLV node
+ * @list: list of &struct iwl_dbg_tlv_node
+ * @tlv: debug TLV
  */
-struct iwl_apply_point_data {
+struct iwl_dbg_tlv_node {
 	struct list_head list;
 	struct iwl_ucode_tlv tlv;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b9ee6c83af87..9dd74fe9a0bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -722,6 +722,7 @@ struct iwl_self_init_dram {
  * @hw_error: equals true if hw error interrupt was received from the FW
  * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
  * @active_regions: active regions
+ * @debug_info_tlv_list: list of debug info TLVs
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -747,6 +748,7 @@ struct iwl_trans_debug {
 	enum iwl_fw_ini_buffer_location ini_dest;
 
 	struct iwl_ucode_tlv *active_regions[IWL_FW_INI_MAX_REGION_ID];
+	struct list_head debug_info_tlv_list;
 };
 
 /**
-- 
2.23.0

