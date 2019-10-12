Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8FD50B8
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfJLPso (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48654 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729272AbfJLPso (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:44 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdK-0005yf-5F; Sat, 12 Oct 2019 18:48:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:21 +0300
Message-Id: <20191012184707.2ab2a940997c.I13d6ae78602b2e54eb388ac33770e27357470db3@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012154828.9249-1-luca@coelho.fi>
References: <20191012154828.9249-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 09/16] iwlwifi: dbg_ini: implement time point handling
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Calculate active triggers list and implement time points handling.
Also allow to override the debug domain via iwl-dbg-cfg.ini by setting
FW_DBG_DOMAIN field.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  31 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   3 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  13 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 280 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   3 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +
 6 files changed, 321 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 21e1de9166cf..4d1b084da4b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -61,18 +61,7 @@
 #include <linux/bitops.h>
 
 #define IWL_FW_INI_MAX_CFG_NAME			64
-
-/**
- * enum iwl_fw_ini_dbg_domain - debug domains
- * allows to send host cmd or collect memory region if a given domain is enabled
- *
- * @IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON: the default domain, always on
- * @IWL_FW_INI_DBG_DOMAIN_REPORT_PS: power save domain
- */
-enum iwl_fw_ini_dbg_domain {
-	IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON = 0,
-	IWL_FW_INI_DBG_DOMAIN_REPORT_PS,
-}; /* FW_DEBUG_TLV_DOMAIN_API_E_VER_1 */
+#define IWL_FW_INI_DOMAIN_ALWAYS_ON		0
 
 /**
  * struct iwl_fw_ini_hcmd
@@ -652,4 +641,22 @@ enum iwl_fw_ini_time_point {
 	IWL_FW_INI_TIME_POINT_NUM,
 }; /* FW_TLV_DEBUG_TIME_POINT_API_E */
 
+/**
+ * enum iwl_fw_ini_trigger_apply_policy - Determines how to apply triggers
+ *
+ * @IWL_FW_INI_APPLY_POLICY_MATCH_TIME_POINT: match by time point
+ * @IWL_FW_INI_APPLY_POLICY_MATCH_DATA: match by trigger data
+ * @IWL_FW_INI_APPLY_POLICY_OVERRIDE_REGIONS: override regions mask.
+ *	Append otherwise
+ * @IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG: override trigger configuration
+ * @IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA: override trigger data.
+ *	Append otherwise
+ */
+enum iwl_fw_ini_trigger_apply_policy {
+	IWL_FW_INI_APPLY_POLICY_MATCH_TIME_POINT	= BIT(0),
+	IWL_FW_INI_APPLY_POLICY_MATCH_DATA		= BIT(1),
+	IWL_FW_INI_APPLY_POLICY_OVERRIDE_REGIONS	= BIT(8),
+	IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG		= BIT(9),
+	IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA		= BIT(10),
+};
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 1e4143327add..591c9f07a64c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2301,6 +2301,9 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	u32 occur, delay;
 	unsigned long idx;
 
+	if (test_bit(STATUS_GEN_ACTIVE_TRIGS, &fwrt->status))
+		return -EBUSY;
+
 	if (!iwl_fw_ini_trigger_on(fwrt, trig)) {
 		IWL_WARN(fwrt, "WRT: Trigger %d is not active, aborting dump\n",
 			 tp_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 6c2ade4c7a0c..87adbd3dd764 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -67,6 +67,8 @@
 #include "fw/api/paging.h"
 #include "iwl-eeprom-parse.h"
 
+#define IWL_FW_DBG_DOMAIN		IWL_FW_INI_DOMAIN_ALWAYS_ON
+
 struct iwl_fw_runtime_ops {
 	int (*dump_start)(void *ctx);
 	void (*dump_end)(void *ctx);
@@ -125,6 +127,14 @@ struct iwl_txf_iter_data {
 	u8 internal_txf;
 };
 
+/**
+ * enum iwl_fw_runtime_status - fw runtime status flags
+ * @STATUS_GEN_ACTIVE_TRIGS: generating active trigger list
+ */
+enum iwl_fw_runtime_status {
+	STATUS_GEN_ACTIVE_TRIGS,
+};
+
 /**
  * struct iwl_fw_runtime - runtime data for firmware
  * @fw: firmware image
@@ -138,6 +148,7 @@ struct iwl_txf_iter_data {
  * @smem_cfg: saved firmware SMEM configuration
  * @cur_fw_img: current firmware image, must be maintained by
  *	the driver by calling &iwl_fw_set_current_image()
+ * @status: &enum iwl_fw_runtime_status
  * @dump: debug dump data
  */
 struct iwl_fw_runtime {
@@ -158,6 +169,8 @@ struct iwl_fw_runtime {
 	/* memory configuration */
 	struct iwl_fwrt_shared_mem_cfg smem_cfg;
 
+	unsigned long status;
+
 	/* debug */
 	struct {
 		const struct iwl_fw_dump_desc *desc;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 651e1fee2763..1cec10a60cba 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -350,6 +350,12 @@ void iwl_dbg_tlv_free(struct iwl_trans *trans)
 			list_del(&tlv_node->list);
 			kfree(tlv_node);
 		}
+
+		list_for_each_entry_safe(tlv_node, tlv_node_tmp,
+					 &tp->active_trig_list, list) {
+			list_del(&tlv_node->list);
+			kfree(tlv_node);
+		}
 	}
 }
 
@@ -408,13 +414,285 @@ void iwl_dbg_tlv_init(struct iwl_trans *trans)
 
 		INIT_LIST_HEAD(&tp->trig_list);
 		INIT_LIST_HEAD(&tp->hcmd_list);
+		INIT_LIST_HEAD(&tp->active_trig_list);
+	}
+}
+
+static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
+				   struct list_head *hcmd_list)
+{
+	struct iwl_dbg_tlv_node *node;
+
+	list_for_each_entry(node, hcmd_list, list) {
+		struct iwl_fw_ini_hcmd_tlv *hcmd = (void *)node->tlv.data;
+		struct iwl_fw_ini_hcmd *hcmd_data = &hcmd->hcmd;
+		u32 domain = le32_to_cpu(hcmd->hdr.domain);
+		u16 hcmd_len = le32_to_cpu(node->tlv.length) - sizeof(*hcmd);
+		struct iwl_host_cmd cmd = {
+			.id = WIDE_ID(hcmd_data->group, hcmd_data->id),
+			.len = { hcmd_len, },
+			.data = { hcmd_data->data, },
+		};
+
+		if (domain != IWL_FW_INI_DOMAIN_ALWAYS_ON &&
+		    !(domain & fwrt->trans->dbg.domains_bitmap))
+			continue;
+
+		iwl_trans_send_cmd(fwrt->trans, &cmd);
+	}
+}
+
+static bool is_trig_data_contained(struct iwl_ucode_tlv *new,
+				   struct iwl_ucode_tlv *old)
+{
+	struct iwl_fw_ini_trigger_tlv *new_trig = (void *)new->data;
+	struct iwl_fw_ini_trigger_tlv *old_trig = (void *)old->data;
+	__le32 *new_data = new_trig->data, *old_data = old_trig->data;
+	u32 new_dwords_num = iwl_tlv_array_len(new, new_trig, data);
+	u32 old_dwords_num = iwl_tlv_array_len(new, new_trig, data);
+	int i, j;
+
+	for (i = 0; i < new_dwords_num; i++) {
+		bool match = false;
+
+		for (j = 0; j < old_dwords_num; j++) {
+			if (new_data[i] == old_data[j]) {
+				match = true;
+				break;
+			}
+		}
+		if (!match)
+			return false;
+	}
+
+	return true;
+}
+
+static int iwl_dbg_tlv_override_trig_node(struct iwl_fw_runtime *fwrt,
+					  struct iwl_ucode_tlv *trig_tlv,
+					  struct iwl_dbg_tlv_node *node)
+{
+	struct iwl_ucode_tlv *node_tlv = &node->tlv;
+	struct iwl_fw_ini_trigger_tlv *node_trig = (void *)node_tlv->data;
+	struct iwl_fw_ini_trigger_tlv *trig = (void *)trig_tlv->data;
+	u32 policy = le32_to_cpu(trig->apply_policy);
+	u32 size = le32_to_cpu(trig_tlv->length);
+	u32 trig_data_len = size - sizeof(*trig);
+	u32 offset = 0;
+
+	if (!(policy & IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA)) {
+		u32 data_len = le32_to_cpu(node_tlv->length) -
+			sizeof(*node_trig);
+
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Appending trigger data (time point %u)\n",
+			     le32_to_cpu(trig->time_point));
+
+		offset += data_len;
+		size += data_len;
+	} else {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Overriding trigger data (time point %u)\n",
+			     le32_to_cpu(trig->time_point));
+	}
+
+	if (size != le32_to_cpu(node_tlv->length)) {
+		struct list_head *prev = node->list.prev;
+		struct iwl_dbg_tlv_node *tmp;
+
+		list_del(&node->list);
+
+		tmp = krealloc(node, sizeof(*node) + size, GFP_KERNEL);
+		if (!tmp) {
+			IWL_WARN(fwrt,
+				 "WRT: No memory to override trigger (time point %u)\n",
+				 le32_to_cpu(trig->time_point));
+
+			list_add(&node->list, prev);
+
+			return -ENOMEM;
+		}
+
+		list_add(&tmp->list, prev);
+		node_tlv = &tmp->tlv;
+		node_trig = (void *)node_tlv->data;
+	}
+
+	memcpy(node_trig->data + offset, trig->data, trig_data_len);
+	node_tlv->length = cpu_to_le32(size);
+
+	if (policy & IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG) {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Overriding trigger configuration (time point %u)\n",
+			     le32_to_cpu(trig->time_point));
+
+		/* the first 11 dwords are configuration related */
+		memcpy(node_trig, trig, sizeof(__le32) * 11);
+	}
+
+	if (policy & IWL_FW_INI_APPLY_POLICY_OVERRIDE_REGIONS) {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Overriding trigger regions (time point %u)\n",
+			     le32_to_cpu(trig->time_point));
+
+		node_trig->regions_mask = trig->regions_mask;
+	} else {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Appending trigger regions (time point %u)\n",
+			     le32_to_cpu(trig->time_point));
+
+		node_trig->regions_mask |= trig->regions_mask;
+	}
+
+	return 0;
+}
+
+static int
+iwl_dbg_tlv_add_active_trigger(struct iwl_fw_runtime *fwrt,
+			       struct list_head *trig_list,
+			       struct iwl_ucode_tlv *trig_tlv)
+{
+	struct iwl_fw_ini_trigger_tlv *trig = (void *)trig_tlv->data;
+	struct iwl_dbg_tlv_node *node, *match = NULL;
+	u32 policy = le32_to_cpu(trig->apply_policy);
+
+	list_for_each_entry(node, trig_list, list) {
+		if (!(policy & IWL_FW_INI_APPLY_POLICY_MATCH_TIME_POINT))
+			break;
+
+		if (!(policy & IWL_FW_INI_APPLY_POLICY_MATCH_DATA) ||
+		    is_trig_data_contained(trig_tlv, &node->tlv)) {
+			match = node;
+			break;
+		}
 	}
+
+	if (!match) {
+		IWL_DEBUG_FW(fwrt, "WRT: Enabling trigger (time point %u)\n",
+			     le32_to_cpu(trig->time_point));
+		return iwl_dbg_tlv_add(trig_tlv, trig_list);
+	}
+
+	return iwl_dbg_tlv_override_trig_node(fwrt, trig_tlv, match);
+}
+
+static void
+iwl_dbg_tlv_gen_active_trig_list(struct iwl_fw_runtime *fwrt,
+				 struct iwl_dbg_tlv_time_point_data *tp)
+{
+	struct iwl_dbg_tlv_node *node, *tmp;
+	struct list_head *trig_list = &tp->trig_list;
+	struct list_head *active_trig_list = &tp->active_trig_list;
+
+	list_for_each_entry_safe(node, tmp, active_trig_list, list) {
+		list_del(&node->list);
+		kfree(node);
+	}
+
+	list_for_each_entry(node, trig_list, list) {
+		struct iwl_ucode_tlv *tlv = &node->tlv;
+		struct iwl_fw_ini_trigger_tlv *trig = (void *)tlv->data;
+		u32 domain = le32_to_cpu(trig->hdr.domain);
+
+		if (domain != IWL_FW_INI_DOMAIN_ALWAYS_ON &&
+		    !(domain & fwrt->trans->dbg.domains_bitmap))
+			continue;
+
+		iwl_dbg_tlv_add_active_trigger(fwrt, active_trig_list, tlv);
+	}
+}
+
+int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt, u32 new_domain)
+{
+	int i;
+
+	if (test_and_set_bit(STATUS_GEN_ACTIVE_TRIGS, &fwrt->status))
+		return -EBUSY;
+
+	iwl_fw_flush_dumps(fwrt);
+
+	fwrt->trans->dbg.domains_bitmap = new_domain;
+
+	IWL_DEBUG_FW(fwrt,
+		     "WRT: Generating active triggers list, domain 0x%x\n",
+		     fwrt->trans->dbg.domains_bitmap);
+
+	for (i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.time_point); i++) {
+		struct iwl_dbg_tlv_time_point_data *tp =
+			&fwrt->trans->dbg.time_point[i];
+
+		iwl_dbg_tlv_gen_active_trig_list(fwrt, tp);
+	}
+
+	clear_bit(STATUS_GEN_ACTIVE_TRIGS, &fwrt->status);
+
+	return 0;
+}
+
+static int
+iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt,
+		       struct list_head *active_trig_list,
+		       union iwl_dbg_tlv_tp_data *tp_data,
+		       bool (*data_check)(struct iwl_fw_runtime *fwrt,
+					  struct iwl_fwrt_dump_data *dump_data,
+					  union iwl_dbg_tlv_tp_data *tp_data,
+					  u32 trig_data))
+{
+	struct iwl_dbg_tlv_node *node;
+
+	list_for_each_entry(node, active_trig_list, list) {
+		struct iwl_fwrt_dump_data dump_data = {
+			.trig = (void *)node->tlv.data,
+		};
+		u32 num_data = iwl_tlv_array_len(&node->tlv, dump_data.trig,
+						 data);
+		int ret, i;
+
+		if (!num_data) {
+			ret = iwl_fw_dbg_ini_collect(fwrt, &dump_data);
+			if (ret)
+				return ret;
+		}
+
+		for (i = 0; i < num_data; i++) {
+			if (!data_check ||
+			    data_check(fwrt, &dump_data, tp_data,
+				       le32_to_cpu(dump_data.trig->data[i]))) {
+				ret = iwl_fw_dbg_ini_collect(fwrt, &dump_data);
+				if (ret)
+					return ret;
+
+				break;
+			}
+		}
+	}
+
+	return 0;
 }
 
 void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_time_point tp_id,
 			    union iwl_dbg_tlv_tp_data *tp_data)
 {
-	/* will be used later */
+	struct list_head *hcmd_list, *trig_list;
+
+	if (!iwl_trans_dbg_ini_valid(fwrt->trans) ||
+	    tp_id == IWL_FW_INI_TIME_POINT_INVALID ||
+	    tp_id >= IWL_FW_INI_TIME_POINT_NUM)
+		return;
+
+	hcmd_list = &fwrt->trans->dbg.time_point[tp_id].hcmd_list;
+	trig_list = &fwrt->trans->dbg.time_point[tp_id].active_trig_list;
+
+	switch (tp_id) {
+	case IWL_FW_INI_TIME_POINT_EARLY:
+		iwl_dbg_tlv_gen_active_trigs(fwrt, IWL_FW_DBG_DOMAIN);
+		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
+		break;
+	default:
+		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
+		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
+		break;
+	}
 }
 IWL_EXPORT_SYMBOL(iwl_dbg_tlv_time_point);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 64c0638998f2..f18946872569 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -85,10 +85,12 @@ union iwl_dbg_tlv_tp_data {
 /**
  * struct iwl_dbg_tlv_time_point_data
  * @trig_list: list of triggers
+ * @active_trig_list: list of active triggers
  * @hcmd_list: list of host commands
  */
 struct iwl_dbg_tlv_time_point_data {
 	struct list_head trig_list;
+	struct list_head active_trig_list;
 	struct list_head hcmd_list;
 };
 
@@ -103,6 +105,7 @@ void iwl_dbg_tlv_init(struct iwl_trans *trans);
 void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_time_point tp_id,
 			    union iwl_dbg_tlv_tp_data *tp_data);
+int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt, u32 new_domain);
 void iwl_dbg_tlv_del_timers(struct iwl_trans *trans);
 
 #endif /* __iwl_dbg_tlv_h__*/
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 63031c030600..59debf6e1b9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -724,6 +724,8 @@ struct iwl_self_init_dram {
  * @active_regions: active regions
  * @debug_info_tlv_list: list of debug info TLVs
  * @time_point: array of debug time points
+ * @domains_bitmap: bitmap of active domains other than
+ *	&IWL_FW_INI_DOMAIN_ALWAYS_ON
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -752,6 +754,8 @@ struct iwl_trans_debug {
 	struct list_head debug_info_tlv_list;
 	struct iwl_dbg_tlv_time_point_data
 		time_point[IWL_FW_INI_TIME_POINT_NUM];
+
+	u32 domains_bitmap;
 };
 
 /**
-- 
2.23.0

