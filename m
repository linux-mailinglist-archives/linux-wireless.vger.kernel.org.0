Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA262A43CC
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfHaJwy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:52:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39736 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726323AbfHaJwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:52:54 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400P-0002OQ-1M; Sat, 31 Aug 2019 12:49:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:51 +0300
Message-Id: <20190831094859.6391-12-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 11/19] iwlwifi: dbg: align wrt log prints to the same format
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Align wrt log prints to the driver coding style
Remove the ext field from the log and print it at the beginning of the
apply point.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 87 +++++++++----------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 +-
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2d37628694d2..2a4c2e772d1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1688,7 +1688,7 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 	if (!size)
 		return;
 
-	IWL_DEBUG_FW(fwrt, "WRT: collecting region: id=%d, type=%d\n",
+	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n",
 		     le32_to_cpu(reg->region_id), type);
 
 	num_of_ranges = ops->get_num_of_ranges(fwrt, reg);
@@ -1705,7 +1705,7 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 	range = ops->fill_mem_hdr(fwrt, reg, header);
 	if (!range) {
 		IWL_ERR(fwrt,
-			"WRT: failed to fill region header: id=%d, type=%d\n",
+			"WRT: Failed to fill region header: id=%d, type=%d\n",
 			le32_to_cpu(reg->region_id), type);
 		memset(*data, 0, size);
 		return;
@@ -1716,7 +1716,7 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 
 		if (range_size < 0) {
 			IWL_ERR(fwrt,
-				"WRT: failed to dump region: id=%d, type=%d\n",
+				"WRT: Failed to dump region: id=%d, type=%d\n",
 				le32_to_cpu(reg->region_id), type);
 			memset(*data, 0, size);
 			return;
@@ -1805,7 +1805,7 @@ static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
 		reg = fwrt->dump.active_regs[reg_id];
 		if (!reg) {
 			IWL_WARN(fwrt,
-				 "WRT: unassigned region id %d, skipping\n",
+				 "WRT: Unassigned region id %d, skipping\n",
 				 reg_id);
 			continue;
 		}
@@ -2223,7 +2223,7 @@ int _iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	active->trig->occurrences = cpu_to_le32(--occur);
 
 	if (le32_to_cpu(active->trig->force_restart)) {
-		IWL_WARN(fwrt, "WRT: force restart: trigger %d fired.\n", id);
+		IWL_WARN(fwrt, "WRT: Force restart: trigger %d fired.\n", id);
 		iwl_force_nmi(fwrt->trans);
 		return 0;
 	}
@@ -2243,7 +2243,7 @@ int _iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 
 	fwrt->dump.wks[idx].ini_trig_id = id;
 
-	IWL_WARN(fwrt, "WRT: collecting data: ini trigger %d fired.\n", id);
+	IWL_WARN(fwrt, "WRT: Collecting data: ini trigger %d fired.\n", id);
 
 	schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
 
@@ -2380,12 +2380,12 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 		goto out;
 	}
 
-	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection start\n");
+	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection start\n");
 	if (iwl_trans_dbg_ini_valid(fwrt->trans))
 		iwl_fw_error_ini_dump(fwrt, wk_idx);
 	else
 		iwl_fw_error_dump(fwrt);
-	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection done\n");
+	IWL_DEBUG_FW_INFO(fwrt, "WRT: Data collection done\n");
 
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 
@@ -2538,7 +2538,7 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 	}
 
 	if (buf_location == IWL_FW_INI_LOCATION_SRAM_PATH) {
-		IWL_DEBUG_FW(trans, "WRT: applying SMEM buffer destination\n");
+		IWL_DEBUG_FW(trans, "WRT: Applying SMEM buffer destination\n");
 		/* set sram monitor by enabling bit 7 */
 		iwl_set_bit(fwrt->trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_BIT_MONITOR_SRAM);
@@ -2561,7 +2561,7 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 		return;
 
 	IWL_DEBUG_FW(trans,
-		     "WRT: applying DRAM buffer[%d] destination\n", block_idx);
+		     "WRT: Applying DRAM buffer[%d] destination\n", block_idx);
 
 	cmd->num_frags = cpu_to_le32(1);
 	cmd->fragments[0].address =
@@ -2574,8 +2574,7 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 }
 
 static void iwl_fw_dbg_send_hcmd(struct iwl_fw_runtime *fwrt,
-				 struct iwl_ucode_tlv *tlv,
-				 bool ext)
+				 struct iwl_ucode_tlv *tlv)
 {
 	struct iwl_fw_ini_hcmd_tlv *hcmd_tlv = (void *)&tlv->data[0];
 	struct iwl_fw_ini_hcmd *data = &hcmd_tlv->hcmd;
@@ -2591,45 +2590,41 @@ static void iwl_fw_dbg_send_hcmd(struct iwl_fw_runtime *fwrt,
 	if (le32_to_cpu(hcmd_tlv->domain) != IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON)
 		return;
 
-	IWL_DEBUG_FW(fwrt,
-		     "WRT: ext=%d. Sending host command id=0x%x, group=0x%x\n",
-		     ext, data->id, data->group);
+	IWL_DEBUG_FW(fwrt, "WRT: Sending host command id=0x%x, group=0x%x\n",
+		     data->id, data->group);
 
 	iwl_trans_send_cmd(fwrt->trans, &hcmd);
 }
 
 static void iwl_fw_dbg_update_regions(struct iwl_fw_runtime *fwrt,
 				      struct iwl_fw_ini_region_tlv *tlv,
-				      bool ext, enum iwl_fw_ini_apply_point pnt)
+				      enum iwl_fw_ini_apply_point pnt)
 {
 	void *iter = (void *)tlv->region_config;
 	int i, size = le32_to_cpu(tlv->num_regions);
 	const char *err_st =
-		"WRT: ext=%d. Invalid region %s %d for apply point %d\n";
+		"WRT: Invalid region %s %d for apply point %d\n";
 
 	for (i = 0; i < size; i++) {
 		struct iwl_fw_ini_region_cfg *reg = iter, **active;
 		int id = le32_to_cpu(reg->region_id);
 		u32 type = le32_to_cpu(reg->region_type);
 
-		if (WARN(id >= ARRAY_SIZE(fwrt->dump.active_regs), err_st, ext,
-			 "id", id, pnt))
+		if (WARN(id >= ARRAY_SIZE(fwrt->dump.active_regs), err_st, "id",
+			 id, pnt))
 			break;
 
 		if (WARN(type == 0 || type >= IWL_FW_INI_REGION_NUM, err_st,
-			 ext, "type", type, pnt))
+			 "type", type, pnt))
 			break;
 
 		active = &fwrt->dump.active_regs[id];
 
 		if (*active)
-			IWL_WARN(fwrt->trans,
-				 "WRT: ext=%d. Region id %d override\n",
-				 ext, id);
+			IWL_WARN(fwrt->trans, "WRT: Region id %d override\n",
+				 id);
 
-		IWL_DEBUG_FW(fwrt,
-			     "WRT: ext=%d. Activating region id %d\n",
-			     ext, id);
+		IWL_DEBUG_FW(fwrt, "WRT: Activating region id %d\n", id);
 
 		*active = reg;
 
@@ -2676,7 +2671,6 @@ static int iwl_fw_dbg_trig_realloc(struct iwl_fw_runtime *fwrt,
 
 static void iwl_fw_dbg_update_triggers(struct iwl_fw_runtime *fwrt,
 				       struct iwl_fw_ini_trigger_tlv *tlv,
-				       bool ext,
 				       enum iwl_fw_ini_apply_point apply_point)
 {
 	int i, size = le32_to_cpu(tlv->num_triggers);
@@ -2690,8 +2684,8 @@ static void iwl_fw_dbg_update_triggers(struct iwl_fw_runtime *fwrt,
 			sizeof(__le32);
 
 		if (WARN(id >= ARRAY_SIZE(fwrt->dump.active_trigs),
-			 "WRT: ext=%d. Invalid trigger id %d for apply point %d\n",
-			 ext, id, apply_point))
+			 "WRT: Invalid trigger id %d for apply point %d\n", id,
+			 apply_point))
 			break;
 
 		active = &fwrt->dump.active_trigs[id];
@@ -2699,9 +2693,7 @@ static void iwl_fw_dbg_update_triggers(struct iwl_fw_runtime *fwrt,
 		if (!active->active) {
 			size_t trig_size = sizeof(*trig) + trig_regs_size;
 
-			IWL_DEBUG_FW(fwrt,
-				     "WRT: ext=%d. Activating trigger %d\n",
-				     ext, id);
+			IWL_DEBUG_FW(fwrt, "WRT: Activating trigger %d\n", id);
 
 			if (iwl_fw_dbg_trig_realloc(fwrt, active, id,
 						    trig_size))
@@ -2722,14 +2714,14 @@ static void iwl_fw_dbg_update_triggers(struct iwl_fw_runtime *fwrt,
 
 			if (region_override) {
 				IWL_DEBUG_FW(fwrt,
-					     "WRT: ext=%d. Trigger %d regions override\n",
-					     ext, id);
+					     "WRT: Trigger %d regions override\n",
+					     id);
 
 				mem_to_add -= active_regs * sizeof(__le32);
 			} else {
 				IWL_DEBUG_FW(fwrt,
-					     "WRT: ext=%d. Trigger %d regions appending\n",
-					     ext, id);
+					     "WRT: Trigger %d regions appending\n",
+					     id);
 
 				offset += active_regs;
 				new_regs += active_regs;
@@ -2741,8 +2733,8 @@ static void iwl_fw_dbg_update_triggers(struct iwl_fw_runtime *fwrt,
 
 			if (conf_override) {
 				IWL_DEBUG_FW(fwrt,
-					     "WRT: ext=%d. Trigger %d configuration override\n",
-					     ext, id);
+					     "WRT: Trigger %d configuration override\n",
+					     id);
 
 				memcpy(active->trig, trig, sizeof(*trig));
 			}
@@ -2812,18 +2804,17 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 					ext, pnt);
 				break;
 			}
-			iwl_fw_dbg_send_hcmd(fwrt, tlv, ext);
+			iwl_fw_dbg_send_hcmd(fwrt, tlv);
 			break;
 		case IWL_UCODE_TLV_TYPE_REGIONS:
-			iwl_fw_dbg_update_regions(fwrt, ini_tlv, ext, pnt);
+			iwl_fw_dbg_update_regions(fwrt, ini_tlv, pnt);
 			break;
 		case IWL_UCODE_TLV_TYPE_TRIGGERS:
-			iwl_fw_dbg_update_triggers(fwrt, ini_tlv, ext, pnt);
+			iwl_fw_dbg_update_triggers(fwrt, ini_tlv, pnt);
 			break;
 		default:
-			WARN_ONCE(1,
-				  "WRT: ext=%d. Invalid TLV 0x%x for apply point\n",
-				  ext, type);
+			WARN_ONCE(1, "WRT: Invalid TLV 0x%x for apply point\n",
+				  type);
 			break;
 		}
 	}
@@ -2855,17 +2846,21 @@ void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 {
 	void *data;
 
-	IWL_DEBUG_FW(fwrt, "WRT: enabling apply point %d\n", apply_point);
-
 	if (apply_point == IWL_FW_INI_APPLY_EARLY)
 		iwl_fw_dbg_ini_reset_cfg(fwrt);
 
 	if (fwrt->trans->dbg.internal_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Enabling internal configuration apply point %d\n",
+			     apply_point);
 		data = &fwrt->trans->dbg.apply_points[apply_point];
 		_iwl_fw_dbg_apply_point(fwrt, data, apply_point, false);
 	}
 
 	if (fwrt->trans->dbg.external_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED) {
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Enabling external configuration apply point %d\n",
+			     apply_point);
 		data = &fwrt->trans->dbg.apply_points_ext[apply_point];
 		_iwl_fw_dbg_apply_point(fwrt, data, apply_point, true);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 41ecd1ede04b..90b3e26ee979 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -901,7 +901,7 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans)
 			return;
 
 		IWL_DEBUG_FW(trans,
-			     "WRT: applying DRAM buffer[0] destination\n");
+			     "WRT: Applying DRAM buffer[0] destination\n");
 		iwl_write_umac_prph(trans, MON_BUFF_BASE_ADDR_VER2,
 				    trans->dbg.fw_mon[0].physical >>
 				    MON_BUFF_SHIFT_VER2);
-- 
2.23.0.rc1

