Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775FED5C32
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfJNHUc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:20:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49168 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730297AbfJNHUc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:20:32 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJuea-0007ae-9j; Mon, 14 Oct 2019 10:20:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Oct 2019 10:20:06 +0300
Message-Id: <20191014101813.275d63289cd3.I2fbc9069cd2cea2f4632bc0d90b4fc8aea888a04@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014072019.1254-1-luca@coelho.fi>
References: <20191014072019.1254-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 03/16] iwlwifi: dbg_ini: use new trigger TLV in dump flow
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Make dump flow use the new trigger TLV.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  37 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 178 +++++++-----------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  47 ++---
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  11 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  29 ++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   3 +
 6 files changed, 144 insertions(+), 161 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index dad0dea6725d..073a729cd4db 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -351,18 +351,37 @@ struct iwl_fw_ini_trigger {
 } __packed; /* FW_TLV_DEBUG_TRIGGER_CONFIG_API_S_VER_1 */
 
 /**
- * struct iwl_fw_ini_trigger_tlv - (IWL_UCODE_TLV_TYPE_TRIGGERS)
- * Triggers that hold memory regions to dump in case a trigger fires
+ * struct iwl_fw_ini_trigger_tlv - trigger TLV
  *
- * @header: header
- * @num_triggers: how many different triggers section and IDs are coming next
- * @trigger_config: list of trigger configurations
+ * Trigger that upon firing, determines what regions to collect
+ *
+ * @hdr: debug header
+ * @time_point: time point. One of &enum iwl_fw_ini_time_point
+ * @trigger_reason: trigger reason
+ * @apply_policy: uses &enum iwl_fw_ini_trigger_apply_policy
+ * @dump_delay: delay from trigger fire to dump, in usec
+ * @occurrences: max trigger fire occurrences allowed
+ * @reserved: unused
+ * @ignore_consec: ignore consecutive triggers, in usec
+ * @reset_fw: if non zero, will reset and reload the FW
+ * @multi_dut: initiate debug dump data on several DUTs
+ * @regions_mask: mask of regions to collect
+ * @data: trigger data
  */
 struct iwl_fw_ini_trigger_tlv {
-	struct iwl_fw_ini_header header;
-	__le32 num_triggers;
-	struct iwl_fw_ini_trigger trigger_config[];
-} __packed; /* FW_TLV_DEBUG_TRIGGERS_API_S_VER_1 */
+	struct iwl_fw_ini_header hdr;
+	__le32 time_point;
+	__le32 trigger_reason;
+	__le32 apply_policy;
+	__le32 dump_delay;
+	__le32 occurrences;
+	__le32 reserved;
+	__le32 ignore_consec;
+	__le32 reset_fw;
+	__le32 multi_dut;
+	__le64 regions_mask;
+	__le32 data[];
+} __packed; /* FW_TLV_DEBUG_TRIGGER_API_S_VER_1 */
 
 #define IWL_FW_INI_MAX_IMG_NAME_LEN 32
 #define IWL_FW_INI_MAX_DBG_CFG_NAME_LEN 64
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index d279d4e96c1b..0f9a3c221bd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1623,14 +1623,13 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 }
 
 static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
-			     struct iwl_fw_ini_trigger *trigger,
+			     struct iwl_fw_ini_trigger_tlv *trigger,
 			     struct list_head *list)
 {
 	struct iwl_fw_ini_dump_entry *entry;
 	struct iwl_fw_error_dump_data *tlv;
 	struct iwl_fw_ini_dump_info *dump;
-	u32 reg_ids_size = le32_to_cpu(trigger->num_regions) * sizeof(__le32);
-	u32 size = sizeof(*tlv) + sizeof(*dump) + reg_ids_size;
+	u32 size = sizeof(*tlv) + sizeof(*dump);
 
 	entry = kmalloc(sizeof(*entry) + size, GFP_KERNEL);
 	if (!entry)
@@ -1640,13 +1639,14 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 
 	tlv = (void *)entry->data;
 	tlv->type = cpu_to_le32(IWL_INI_DUMP_INFO_TYPE);
-	tlv->len = cpu_to_le32(sizeof(*dump) + reg_ids_size);
+	tlv->len = cpu_to_le32(size - sizeof(*tlv));
 
 	dump = (void *)tlv->data;
 
 	dump->version = cpu_to_le32(IWL_INI_DUMP_VER);
-	dump->trigger_id = trigger->trigger_id;
-	dump->is_external_cfg =
+	dump->time_point = trigger->time_point;
+	dump->trigger_reason = trigger->trigger_reason;
+	dump->external_cfg_state =
 		cpu_to_le32(fwrt->trans->dbg.external_ini_cfg);
 
 	dump->ver_type = cpu_to_le32(fwrt->dump.fw_ver.type);
@@ -1670,23 +1670,6 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	memcpy(dump->build_tag, fwrt->fw->human_readable,
 	       sizeof(dump->build_tag));
 
-	dump->img_name_len = cpu_to_le32(sizeof(dump->img_name));
-	memcpy(dump->img_name, fwrt->dump.img_name, sizeof(dump->img_name));
-
-	dump->internal_dbg_cfg_name_len =
-		cpu_to_le32(sizeof(dump->internal_dbg_cfg_name));
-	memcpy(dump->internal_dbg_cfg_name, fwrt->dump.internal_dbg_cfg_name,
-	       sizeof(dump->internal_dbg_cfg_name));
-
-	dump->external_dbg_cfg_name_len =
-		cpu_to_le32(sizeof(dump->external_dbg_cfg_name));
-
-	memcpy(dump->external_dbg_cfg_name, fwrt->dump.external_dbg_cfg_name,
-	       sizeof(dump->external_dbg_cfg_name));
-
-	dump->regions_num = trigger->num_regions;
-	memcpy(dump->region_ids, trigger->data, reg_ids_size);
-
 	/* add dump info TLV to the beginning of the list since it needs to be
 	 * the first TLV in the dump
 	 */
@@ -1745,39 +1728,36 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 };
 
 static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
-				struct iwl_fw_ini_trigger *trigger,
+				struct iwl_fwrt_dump_data *dump_data,
 				struct list_head *list)
 {
-	struct iwl_dump_ini_mem_ops empty_ops = {};
+	struct iwl_fw_ini_trigger_tlv *trigger = dump_data->trig;
 	struct iwl_dump_ini_region_data reg_data = {};
 	int i;
 	u32 size = 0;
+	u64 regions_mask = le64_to_cpu(trigger->regions_mask);
 
-	for (i = 0; i < le32_to_cpu(trigger->num_regions); i++) {
-		u32 reg_id = le32_to_cpu(trigger->data[i]), reg_type;
-		struct iwl_fw_ini_region_cfg *reg;
+	for (i = 0; i < 64; i++) {
+		u32 reg_type;
+		struct iwl_fw_ini_region_tlv *reg;
 
-		if (WARN_ON(reg_id >= ARRAY_SIZE(fwrt->dump.active_regs)))
+		if (!(BIT_ULL(i) & regions_mask))
 			continue;
 
-		reg = fwrt->dump.active_regs[reg_id];
-		if (!reg) {
+		reg_data.reg_tlv = fwrt->trans->dbg.active_regions[i];
+		if (!reg_data.reg_tlv) {
 			IWL_WARN(fwrt,
-				 "WRT: Unassigned region id %d, skipping\n",
-				 reg_id);
+				 "WRT: Unassigned region id %d, skipping\n", i);
 			continue;
 		}
 
-		/* currently the driver supports always on domain only */
-		if (le32_to_cpu(reg->domain) != IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON)
-			continue;
-
-		reg_type = le32_to_cpu(reg->region_type);
+		reg = (void *)reg_data.reg_tlv->data;
+		reg_type = le32_to_cpu(reg->type);
 		if (reg_type >= ARRAY_SIZE(iwl_dump_ini_region_ops))
 			continue;
 
 		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
-					 &empty_ops);
+					 &iwl_dump_ini_region_ops[reg_type]);
 	}
 
 	if (size)
@@ -1786,20 +1766,32 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	return size;
 }
 
+static bool iwl_fw_ini_trigger_on(struct iwl_fw_runtime *fwrt,
+				  struct iwl_fw_ini_trigger_tlv *trig)
+{
+	enum iwl_fw_ini_time_point tp_id = le32_to_cpu(trig->time_point);
+	u32 usec = le32_to_cpu(trig->ignore_consec);
+
+	if (!iwl_trans_dbg_ini_valid(fwrt->trans) ||
+	    tp_id == IWL_FW_INI_TIME_POINT_INVALID ||
+	    tp_id >= IWL_FW_INI_TIME_POINT_NUM ||
+	    iwl_fw_dbg_no_trig_window(fwrt, tp_id, usec))
+		return false;
+
+	return true;
+}
+
 static u32 iwl_dump_ini_file_gen(struct iwl_fw_runtime *fwrt,
-				 enum iwl_fw_ini_trigger_id trig_id,
+				 struct iwl_fwrt_dump_data *dump_data,
 				 struct list_head *list)
 {
+	struct iwl_fw_ini_trigger_tlv *trigger = dump_data->trig;
 	struct iwl_fw_ini_dump_entry *entry;
 	struct iwl_fw_ini_dump_file_hdr *hdr;
-	struct iwl_fw_ini_trigger *trigger;
 	u32 size;
 
-	if (!iwl_fw_ini_trigger_on(fwrt, trig_id))
-		return 0;
-
-	trigger = fwrt->dump.active_trigs[trig_id].trig;
-	if (!trigger || !le32_to_cpu(trigger->num_regions))
+	if (!trigger || !iwl_fw_ini_trigger_on(fwrt, trigger) ||
+	    !le64_to_cpu(trigger->regions_mask))
 		return 0;
 
 	entry = kmalloc(sizeof(*entry) + sizeof(*hdr), GFP_KERNEL);
@@ -1808,7 +1800,7 @@ static u32 iwl_dump_ini_file_gen(struct iwl_fw_runtime *fwrt,
 
 	entry->size = sizeof(*hdr);
 
-	size = iwl_dump_ini_trigger(fwrt, trigger, list);
+	size = iwl_dump_ini_trigger(fwrt, dump_data, list);
 	if (!size) {
 		kfree(entry);
 		return 0;
@@ -1880,14 +1872,18 @@ static void iwl_dump_ini_list_free(struct list_head *list)
 	}
 }
 
-static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt, u8 wk_idx)
+static void iwl_fw_error_dump_data_free(struct iwl_fwrt_dump_data *dump_data)
+{
+	dump_data->trig = NULL;
+}
+
+static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt,
+				  struct iwl_fwrt_dump_data *dump_data)
 {
-	enum iwl_fw_ini_trigger_id trig_id = fwrt->dump.wks[wk_idx].ini_trig_id;
 	struct list_head dump_list = LIST_HEAD_INIT(dump_list);
 	struct scatterlist *sg_dump_data;
-	u32 file_len;
+	u32 file_len = iwl_dump_ini_file_gen(fwrt, dump_data, &dump_list);
 
-	file_len = iwl_dump_ini_file_gen(fwrt, trig_id, &dump_list);
 	if (!file_len)
 		goto out;
 
@@ -1908,7 +1904,7 @@ static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	iwl_dump_ini_list_free(&dump_list);
 
 out:
-	fwrt->dump.wks[wk_idx].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
+	iwl_fw_error_dump_data_free(dump_data);
 }
 
 const struct iwl_fw_dump_desc iwl_dump_desc_assert = {
@@ -1923,15 +1919,9 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 			    bool monitor_only,
 			    unsigned int delay)
 {
-	u32 trig_type = le32_to_cpu(desc->trig_desc.type);
-	int ret;
-
 	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
-		ret = iwl_fw_dbg_ini_collect(fwrt, trig_type);
-		if (!ret)
-			iwl_fw_free_dump_desc(fwrt);
-
-		return ret;
+		iwl_fw_free_dump_desc(fwrt);
+		return 0;
 	}
 
 	/* use wks[0] since dump flow prior to ini does not need to support
@@ -2023,35 +2013,26 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect);
 
-int _iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
-			    enum iwl_fw_ini_trigger_id id)
+int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
+			   struct iwl_fwrt_dump_data *dump_data)
 {
-	struct iwl_fw_ini_active_triggers *active;
+	struct iwl_fw_ini_trigger_tlv *trig = dump_data->trig;
+	enum iwl_fw_ini_time_point tp_id = le32_to_cpu(trig->time_point);
 	u32 occur, delay;
 	unsigned long idx;
 
-	if (WARN_ON(!iwl_fw_ini_trigger_on(fwrt, id)))
-		return -EINVAL;
-
-	if (!iwl_fw_ini_trigger_on(fwrt, id)) {
+	if (!iwl_fw_ini_trigger_on(fwrt, trig)) {
 		IWL_WARN(fwrt, "WRT: Trigger %d is not active, aborting dump\n",
-			 id);
+			 tp_id);
 		return -EINVAL;
 	}
 
-	active = &fwrt->dump.active_trigs[id];
-	delay = le32_to_cpu(active->trig->dump_delay);
-	occur = le32_to_cpu(active->trig->occurrences);
+	delay = le32_to_cpu(trig->dump_delay);
+	occur = le32_to_cpu(trig->occurrences);
 	if (!occur)
 		return 0;
 
-	active->trig->occurrences = cpu_to_le32(--occur);
-
-	if (le32_to_cpu(active->trig->force_restart)) {
-		IWL_WARN(fwrt, "WRT: Force restart: trigger %d fired.\n", id);
-		iwl_force_nmi(fwrt->trans);
-		return 0;
-	}
+	trig->occurrences = cpu_to_le32(--occur);
 
 	/* Check there is an available worker.
 	 * ffz return value is undefined if no zero exists,
@@ -2066,36 +2047,15 @@ int _iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	    test_and_set_bit(fwrt->dump.wks[idx].idx, &fwrt->dump.active_wks))
 		return -EBUSY;
 
-	fwrt->dump.wks[idx].ini_trig_id = id;
+	memcpy(&fwrt->dump.wks[idx].dump_data, dump_data,
+	       sizeof(fwrt->dump.wks[idx].dump_data));
 
-	IWL_WARN(fwrt, "WRT: Collecting data: ini trigger %d fired.\n", id);
+	IWL_WARN(fwrt, "WRT: Collecting data: ini trigger %d fired.\n", tp_id);
 
 	schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
 
 	return 0;
 }
-IWL_EXPORT_SYMBOL(_iwl_fw_dbg_ini_collect);
-
-int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt, u32 legacy_trigger_id)
-{
-	int id;
-
-	switch (legacy_trigger_id) {
-	case FW_DBG_TRIGGER_FW_ASSERT:
-	case FW_DBG_TRIGGER_ALIVE_TIMEOUT:
-	case FW_DBG_TRIGGER_DRIVER:
-		id = IWL_FW_TRIGGER_ID_FW_ASSERT;
-		break;
-	case FW_DBG_TRIGGER_USER:
-		id = IWL_FW_TRIGGER_ID_USER_TRIGGER;
-		break;
-	default:
-		return -EIO;
-	}
-
-	return _iwl_fw_dbg_ini_collect(fwrt, id);
-}
-IWL_EXPORT_SYMBOL(iwl_fw_dbg_ini_collect);
 
 int iwl_fw_dbg_collect_trig(struct iwl_fw_runtime *fwrt,
 			    struct iwl_fw_dbg_trigger_tlv *trigger,
@@ -2104,6 +2064,9 @@ int iwl_fw_dbg_collect_trig(struct iwl_fw_runtime *fwrt,
 	int ret, len = 0;
 	char buf[64];
 
+	if (iwl_trans_dbg_ini_valid(fwrt->trans))
+		return 0;
+
 	if (fmt) {
 		va_list ap;
 
@@ -2207,7 +2170,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection start\n");
 	if (iwl_trans_dbg_ini_valid(fwrt->trans))
-		iwl_fw_error_ini_dump(fwrt, wk_idx);
+		iwl_fw_error_ini_dump(fwrt, &fwrt->dump.wks[wk_idx].dump_data);
 	else
 		iwl_fw_error_dump(fwrt);
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection done\n");
@@ -2220,11 +2183,10 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 
 void iwl_fw_error_dump_wk(struct work_struct *work)
 {
-	struct iwl_fw_runtime *fwrt;
-	typeof(fwrt->dump.wks[0]) *wks;
-
-	wks = container_of(work, typeof(fwrt->dump.wks[0]), wk.work);
-	fwrt = container_of(wks, struct iwl_fw_runtime, dump.wks[wks->idx]);
+	struct iwl_fwrt_wk_data *wks =
+		container_of(work, typeof(*wks), wk.work);
+	struct iwl_fw_runtime *fwrt =
+		container_of(wks, typeof(*fwrt), dump.wks[wks->idx]);
 
 	/* assumes the op mode mutex is locked in dump_start since
 	 * iwl_fw_dbg_collect_sync can't run in parallel
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index e3b5dd34643f..179f2905d56b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -114,9 +114,8 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 			    bool monitor_only, unsigned int delay);
 int iwl_fw_dbg_error_collect(struct iwl_fw_runtime *fwrt,
 			     enum iwl_fw_dbg_trigger trig_type);
-int _iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
-			    enum iwl_fw_ini_trigger_id id);
-int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt, u32 legacy_trigger_id);
+int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
+			   struct iwl_fwrt_dump_data *dump_data);
 int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 		       enum iwl_fw_dbg_trigger trig, const char *str,
 		       size_t len, struct iwl_fw_dbg_trigger_tlv *trigger);
@@ -222,29 +221,6 @@ _iwl_fw_dbg_trigger_on(struct iwl_fw_runtime *fwrt,
 	_iwl_fw_dbg_trigger_on((fwrt), (wdev), (id));		\
 })
 
-static inline bool
-iwl_fw_ini_trigger_on(struct iwl_fw_runtime *fwrt,
-		      enum iwl_fw_ini_trigger_id id)
-{
-	struct iwl_fw_ini_trigger *trig;
-	u32 usec;
-
-	if (!iwl_trans_dbg_ini_valid(fwrt->trans) ||
-	    id == IWL_FW_TRIGGER_ID_INVALID || id >= IWL_FW_TRIGGER_ID_NUM ||
-	    !fwrt->dump.active_trigs[id].active)
-		return false;
-
-	trig = fwrt->dump.active_trigs[id].trig;
-	usec = le32_to_cpu(trig->ignore_consec);
-
-	if (iwl_fw_dbg_no_trig_window(fwrt, id, usec)) {
-		IWL_WARN(fwrt, "Trigger %d fired in no-collect window\n", id);
-		return false;
-	}
-
-	return true;
-}
-
 static inline void
 _iwl_fw_dbg_trigger_simple_stop(struct iwl_fw_runtime *fwrt,
 				struct wireless_dev *wdev,
@@ -315,10 +291,8 @@ static inline void iwl_fw_flush_dumps(struct iwl_fw_runtime *fwrt)
 	int i;
 
 	iwl_dbg_tlv_del_timers(fwrt->trans);
-	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++) {
+	for (i = 0; i < IWL_FW_RUNTIME_DUMP_WK_NUM; i++)
 		flush_delayed_work(&fwrt->dump.wks[i].wk);
-		fwrt->dump.wks[i].ini_trig_id = IWL_FW_TRIGGER_ID_INVALID;
-	}
 }
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -381,12 +355,21 @@ static inline void iwl_fw_umac_set_alive_err_table(struct iwl_trans *trans,
 
 static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 {
-	if (iwl_trans_dbg_ini_valid(fwrt->trans) && fwrt->trans->dbg.hw_error) {
-		_iwl_fw_dbg_ini_collect(fwrt, IWL_FW_TRIGGER_ID_FW_HW_ERROR);
+	enum iwl_fw_ini_time_point tp_id;
+
+	if (!iwl_trans_dbg_ini_valid(fwrt->trans)) {
+		iwl_fw_dbg_collect_desc(fwrt, &iwl_dump_desc_assert, false, 0);
+		return;
+	}
+
+	if (fwrt->trans->dbg.hw_error) {
+		tp_id = IWL_FW_INI_TIME_POINT_FW_HW_ERROR;
 		fwrt->trans->dbg.hw_error = false;
 	} else {
-		iwl_fw_dbg_collect_desc(fwrt, &iwl_dump_desc_assert, false, 0);
+		tp_id = IWL_FW_INI_TIME_POINT_FW_ASSERT;
 	}
+
+	iwl_dbg_tlv_time_point(fwrt, tp_id, NULL);
 }
 
 void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 2e763678dbdb..2ccf04dacd52 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -381,10 +381,9 @@ struct iwl_fw_ini_error_dump_register {
 
 /* struct iwl_fw_ini_dump_info - ini dump information
  * @version: dump version
- * @trigger_id: trigger id that caused the dump collection
- * @trigger_reason: not supported yet
- * @is_external_cfg: 1 if an external debug configuration was loaded
- *	and 0 otherwise
+ * @time_point: time point that caused the dump collection
+ * @trigger_reason: reason of the trigger
+ * @external_cfg_state: &enum iwl_ini_cfg_state
  * @ver_type: FW version type
  * @ver_subtype: FW version subype
  * @hw_step: HW step
@@ -410,9 +409,9 @@ struct iwl_fw_ini_error_dump_register {
  */
 struct iwl_fw_ini_dump_info {
 	__le32 version;
-	__le32 trigger_id;
+	__le32 time_point;
 	__le32 trigger_reason;
-	__le32 is_external_cfg;
+	__le32 external_cfg_state;
 	__le32 ver_type;
 	__le32 ver_subtype;
 	__le32 hw_step;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index be436c18a047..f3c56a2c2531 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -90,6 +90,27 @@ struct iwl_fwrt_shared_mem_cfg {
 
 #define IWL_FW_RUNTIME_DUMP_WK_NUM 5
 
+/**
+ * struct iwl_fwrt_dump_data - dump data
+ * @trig: trigger the worker was scheduled upon
+ * @fw_pkt: packet received from FW
+ */
+struct iwl_fwrt_dump_data {
+	struct iwl_fw_ini_trigger_tlv *trig;
+	struct iwl_rx_packet *fw_pkt;
+};
+
+/**
+ * struct iwl_fwrt_wk_data - dump worker data struct
+ * @idx: index of the worker
+ * @wk: worker
+ */
+struct iwl_fwrt_wk_data  {
+	u8 idx;
+	struct delayed_work wk;
+	struct iwl_fwrt_dump_data dump_data;
+};
+
 /**
  * struct iwl_txf_iter_data - Tx fifo iterator data struct
  * @fifo: fifo number
@@ -141,17 +162,13 @@ struct iwl_fw_runtime {
 	struct {
 		const struct iwl_fw_dump_desc *desc;
 		bool monitor_only;
-		struct {
-			u8 idx;
-			enum iwl_fw_ini_trigger_id ini_trig_id;
-			struct delayed_work wk;
-		} wks[IWL_FW_RUNTIME_DUMP_WK_NUM];
+		struct iwl_fwrt_wk_data wks[IWL_FW_RUNTIME_DUMP_WK_NUM];
 		unsigned long active_wks;
 
 		u8 conf;
 
 		/* ts of the beginning of a non-collect fw dbg data period */
-		unsigned long non_collect_ts_start[IWL_FW_TRIGGER_ID_NUM];
+		unsigned long non_collect_ts_start[IWL_FW_INI_TIME_POINT_NUM];
 		u32 *d3_debug_data;
 		struct iwl_fw_ini_region_cfg *active_regs[IWL_FW_INI_MAX_REGION_ID];
 		struct iwl_fw_ini_active_triggers active_trigs[IWL_FW_TRIGGER_ID_NUM];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a31408188ed0..b1fb17515398 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -710,6 +710,7 @@ struct iwl_self_init_dram {
  * @fw_mon: address of the buffers for firmware monitor
  * @hw_error: equals true if hw error interrupt was received from the FW
  * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
+ * @active_regions: active regions
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -731,6 +732,8 @@ struct iwl_trans_debug {
 
 	bool hw_error;
 	enum iwl_fw_ini_buffer_location ini_dest;
+
+	struct iwl_ucode_tlv *active_regions[IWL_FW_INI_MAX_REGION_ID];
 };
 
 /**
-- 
2.23.0

