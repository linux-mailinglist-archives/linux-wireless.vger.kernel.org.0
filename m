Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6152877
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfFYJpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54658 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727729AbfFYJpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0c-0007Nv-Lo; Tue, 25 Jun 2019 12:45:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 10/12] iwlwifi: dbg_ini: implement dump info collection
Date:   Tue, 25 Jun 2019 12:44:50 +0300
Message-Id: <20190625094452.19034-11-luca@coelho.fi>
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

The info struct contains data about the FW, HW, RF and the debug
configuration.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 67 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   | 18 +++++
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 62 +++++++++++++++++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  9 +++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 +
 5 files changed, 158 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 806eb9847f72..0c366009389e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1723,6 +1723,65 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 	*data = iwl_fw_error_next_data(*data);
 }
 
+static void iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
+			      struct iwl_fw_ini_trigger *trigger,
+			      struct iwl_fw_error_dump_data **data)
+{
+	struct iwl_fw_ini_dump_info *dump = (void *)(*data)->data;
+	u32 reg_ids_size = le32_to_cpu(trigger->num_regions) * sizeof(__le32);
+
+	(*data)->type = cpu_to_le32(IWL_INI_DUMP_INFO_TYPE);
+	(*data)->len = cpu_to_le32(sizeof(*dump) + reg_ids_size);
+
+	dump->version = cpu_to_le32(IWL_INI_DUMP_VER);
+	dump->trigger_id = trigger->trigger_id;
+	dump->is_external_cfg = cpu_to_le32(fwrt->trans->external_ini_loaded);
+
+	dump->ver_type = cpu_to_le32(fwrt->dump.fw_ver.type);
+	dump->ver_subtype = cpu_to_le32(fwrt->dump.fw_ver.subtype);
+
+	dump->hw_step = cpu_to_le32(CSR_HW_REV_STEP(fwrt->trans->hw_rev));
+	dump->hw_type = cpu_to_le32(CSR_HW_REV_TYPE(fwrt->trans->hw_rev));
+
+	dump->rf_id_flavor =
+		cpu_to_le32(CSR_HW_RFID_FLAVOR(fwrt->trans->hw_rf_id));
+	dump->rf_id_dash = cpu_to_le32(CSR_HW_RFID_DASH(fwrt->trans->hw_rf_id));
+	dump->rf_id_step = cpu_to_le32(CSR_HW_RFID_STEP(fwrt->trans->hw_rf_id));
+	dump->rf_id_type = cpu_to_le32(CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id));
+
+	dump->lmac_major = cpu_to_le32(fwrt->dump.fw_ver.lmac_major);
+	dump->lmac_minor = cpu_to_le32(fwrt->dump.fw_ver.lmac_minor);
+	dump->umac_major = cpu_to_le32(fwrt->dump.fw_ver.umac_major);
+	dump->umac_minor = cpu_to_le32(fwrt->dump.fw_ver.umac_minor);
+
+	dump->build_tag_len = cpu_to_le32(sizeof(dump->build_tag));
+	memcpy(dump->build_tag, fwrt->fw->human_readable,
+	       sizeof(dump->build_tag));
+
+	dump->img_name_len = cpu_to_le32(sizeof(dump->img_name));
+	memcpy(dump->img_name, fwrt->dump.img_name, sizeof(dump->img_name));
+
+	dump->internal_dbg_cfg_name_len =
+		cpu_to_le32(sizeof(dump->internal_dbg_cfg_name));
+	memcpy(dump->internal_dbg_cfg_name, fwrt->dump.internal_dbg_cfg_name,
+	       sizeof(dump->internal_dbg_cfg_name));
+
+	dump->external_dbg_cfg_name_len =
+		cpu_to_le32(sizeof(dump->external_dbg_cfg_name));
+
+	/* dump info size is allocated in iwl_fw_ini_get_trigger_len.
+	 * The driver allocates (sizeof(*dump) + reg_ids_size) so it is safe to
+	 * use reg_ids_size
+	 */
+	memcpy(dump->external_dbg_cfg_name, fwrt->dump.external_dbg_cfg_name,
+	       sizeof(dump->external_dbg_cfg_name));
+
+	dump->regions_num = trigger->num_regions;
+	memcpy(dump->region_ids, trigger->data, reg_ids_size);
+
+	*data = iwl_fw_error_next_data(*data);
+}
+
 static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
 				      struct iwl_fw_ini_trigger *trigger)
 {
@@ -1800,6 +1859,12 @@ static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
 			break;
 		}
 	}
+
+	/* add dump info size */
+	if (ret_size)
+		ret_size += hdr_len + sizeof(struct iwl_fw_ini_dump_info) +
+			(le32_to_cpu(trigger->num_regions) * sizeof(__le32));
+
 	return ret_size;
 }
 
@@ -1809,6 +1874,8 @@ static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
 {
 	int i, num = le32_to_cpu(trigger->num_regions);
 
+	iwl_dump_ini_info(fwrt, trigger, data);
+
 	for (i = 0; i < num; i++) {
 		u32 reg_id = le32_to_cpu(trigger->data[i]);
 		struct iwl_fw_ini_region_cfg *reg;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 37d5171213c2..d009c0aa95d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -73,6 +73,7 @@
 #include "error-dump.h"
 #include "api/commands.h"
 #include "api/dbg-tlv.h"
+#include "api/alive.h"
 
 /**
  * struct iwl_fw_dump_desc - describes the dump
@@ -477,4 +478,21 @@ static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 }
 
 void iwl_fw_dbg_periodic_trig_handler(struct timer_list *t);
+
+static inline void iwl_fwrt_update_fw_versions(struct iwl_fw_runtime *fwrt,
+					       struct iwl_lmac_alive *lmac,
+					       struct iwl_umac_alive *umac)
+{
+	if (lmac) {
+		fwrt->dump.fw_ver.type = lmac->ver_type;
+		fwrt->dump.fw_ver.subtype = lmac->ver_subtype;
+		fwrt->dump.fw_ver.lmac_major = le32_to_cpu(lmac->ucode_major);
+		fwrt->dump.fw_ver.lmac_minor = le32_to_cpu(lmac->ucode_minor);
+	}
+
+	if (umac) {
+		fwrt->dump.fw_ver.umac_major = le32_to_cpu(umac->umac_major);
+		fwrt->dump.fw_ver.umac_minor = le32_to_cpu(umac->umac_minor);
+	}
+}
 #endif  /* __iwl_fw_dbg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 50c5840644d0..00a45ea85b69 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -284,6 +284,9 @@ struct iwl_fw_error_dump_mem {
  */
 #define IWL_INI_DUMP_VER 1
 
+/* Use bit 31 as dump info type to avoid colliding with region types */
+#define IWL_INI_DUMP_INFO_TYPE BIT(31)
+
 /**
  * struct iwl_fw_ini_fifo_hdr - fifo range header
  * @fifo_num: the fifo number. In case of umac rx fifo, set BIT(31) to
@@ -354,6 +357,65 @@ struct iwl_fw_ini_error_dump_register {
 	__le32 data;
 } __packed;
 
+/* struct iwl_fw_ini_dump_info - ini dump information
+ * @version: dump version
+ * @trigger_id: trigger id that caused the dump collection
+ * @trigger_reason: not supported yet
+ * @is_external_cfg: 1 if an external debug configuration was loaded
+ *	and 0 otherwise
+ * @ver_type: FW version type
+ * @ver_subtype: FW version subype
+ * @hw_step: HW step
+ * @hw_type: HW type
+ * @rf_id_flavor: HW RF id flavor
+ * @rf_id_dash: HW RF id dash
+ * @rf_id_step: HW RF id step
+ * @rf_id_type: HW RF id type
+ * @lmac_major: lmac major version
+ * @lmac_minor: lmac minor version
+ * @umac_major: umac major version
+ * @umac_minor: umac minor version
+ * @build_tag_len: length of the build tag
+ * @build_tag: build tag string
+ * @img_name_len: length of the FW image name
+ * @img_name: FW image name
+ * @internal_dbg_cfg_name_len: length of the internal debug configuration name
+ * @internal_dbg_cfg_name: internal debug configuration name
+ * @external_dbg_cfg_name_len: length of the external debug configuration name
+ * @external_dbg_cfg_name: external debug configuration name
+ * @regions_num: number of region ids
+ * @region_ids: region ids the trigger configured to collect
+ */
+struct iwl_fw_ini_dump_info {
+	__le32 version;
+	__le32 trigger_id;
+	__le32 trigger_reason;
+	__le32 is_external_cfg;
+	__le32 ver_type;
+	__le32 ver_subtype;
+	__le32 hw_step;
+	__le32 hw_type;
+	__le32 rf_id_flavor;
+	__le32 rf_id_dash;
+	__le32 rf_id_step;
+	__le32 rf_id_type;
+	__le32 lmac_major;
+	__le32 lmac_minor;
+	__le32 umac_major;
+	__le32 umac_minor;
+	__le32 build_tag_len;
+	u8 build_tag[FW_VER_HUMAN_READABLE_SZ];
+	__le32 img_name_len;
+	u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
+	__le32 internal_dbg_cfg_name_len;
+	u8 internal_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
+	__le32 external_dbg_cfg_name_len;
+	u8 external_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
+	__le32 regions_num;
+	__le32 region_ids[];
+
+} __packed;
+
 /**
  * struct iwl_fw_error_dump_rb - content of an Receive Buffer
  * @index: the index of the Receive Buffer in the Rx queue
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 07196a9fa5db..406ef73992c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -150,6 +150,15 @@ struct iwl_fw_runtime {
 		u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
 		u8 internal_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
 		u8 external_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
+
+		struct {
+			u8 type;
+			u8 subtype;
+			u32 lmac_major;
+			u32 lmac_minor;
+			u32 umac_major;
+			u32 umac_minor;
+		} fw_ver;
 	} dump;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	struct {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ab68b5d53ec9..78dc37bf4fa7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -276,6 +276,8 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		     le32_to_cpu(umac->umac_major),
 		     le32_to_cpu(umac->umac_minor));
 
+	iwl_fwrt_update_fw_versions(&mvm->fwrt, lmac1, umac);
+
 	return true;
 }
 
-- 
2.20.1

