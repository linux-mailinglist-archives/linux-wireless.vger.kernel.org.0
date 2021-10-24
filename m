Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F99A4389C3
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhJXPXI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58620 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229564AbhJXPXH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIi-000czj-LB; Sun, 24 Oct 2021 18:20:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:27 +0300
Message-Id: <iwlwifi.20211024181719.507212be427a.I36acb6ca84095963614be70dc944ba0d98ee770c@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: yoyo: support for ROM usniffer
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add handling of config set TLV for ROM usniffer
support.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 17 ++++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 92 ++++++++++++++++---
 2 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 0abed12df2cb..029ae64bf2b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -379,6 +379,23 @@ struct iwl_dram_info {
 	struct iwl_buf_alloc_cmd dram_frags[IWL_FW_INI_ALLOCATION_NUM - 1];
 } __packed; /* INIT_DRAM_FRAGS_ALLOCATIONS_S_VER_1 */
 
+/**
+ * struct iwl_dbgc1_info - DBGC1 address and size
+ *
+ * Driver will fill the dbcg1 address and size at address based on config TLV.
+ *
+ * @first_word: all 0 set as identifier
+ * @dbgc1_add_lsb: LSB bits of DBGC1 physical address
+ * @dbgc1_add_msb: MSB bits of DBGC1 physical address
+ * @dbgc1_size: DBGC1 size
+*/
+struct iwl_dbgc1_info {
+	__le32 first_word;
+	__le32 dbgc1_add_lsb;
+	__le32 dbgc1_add_msb;
+	__le32 dbgc1_size;
+} __packed; /* INIT_DRAM_FRAGS_ALLOCATIONS_S_VER_1 */
+
 /**
  * struct iwl_dbg_host_event_cfg_cmd
  * @enabled_severities: enabled severities
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index f487cc8b9fe0..7ab98b419cc1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -284,13 +284,6 @@ static int iwl_dbg_tlv_config_set(struct iwl_trans *trans,
 		return -EINVAL;
 	}
 
-	if (type != IWL_FW_INI_CONFIG_SET_TYPE_PERIPH_SCRATCH_HWM ||
-	    trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
-		IWL_DEBUG_FW(trans,
-			     "WRT: Config set type %u is not supported\n", type);
-		return -EINVAL;
-	}
-
 	return iwl_dbg_tlv_add(tlv, &trans->dbg.time_point[tp].config_list);
 }
 
@@ -812,18 +805,84 @@ static void iwl_dbg_tlv_apply_config(struct iwl_fw_runtime *fwrt,
 
 	list_for_each_entry(node, config_list, list) {
 		struct iwl_fw_ini_conf_set_tlv *config_list = (void *)node->tlv.data;
+		u32 count, address, value;
+		u32 len = (le32_to_cpu(node->tlv.length) - sizeof(*config_list)) / 8;
 		u32 type = le32_to_cpu(config_list->set_type);
+		u32 offset = le32_to_cpu(config_list->addr_offset);
 
 		switch (type) {
-			case IWL_FW_INI_CONFIG_SET_TYPE_PERIPH_SCRATCH_HWM: {
-				u32 debug_token_config =
-					le32_to_cpu(config_list->addr_val[0].value);
-
-				IWL_DEBUG_FW(fwrt, "WRT: Setting HWM debug token config: %u\n",
-					     debug_token_config);
-				fwrt->trans->dbg.ucode_preset = debug_token_config;
-				break;
+		case IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_PERIPHERY_MAC: {
+			if (!iwl_trans_grab_nic_access(fwrt->trans)) {
+				IWL_DEBUG_FW(fwrt, "WRT: failed to get nic access\n");
+				IWL_DEBUG_FW(fwrt, "WRT: skipping MAC PERIPHERY config\n");
+				continue;
+			}
+			IWL_DEBUG_FW(fwrt, "WRT:  MAC PERIPHERY config len: len %u\n", len);
+			for (count = 0; count < len; count++) {
+				address = le32_to_cpu(config_list->addr_val[count].address);
+				value = le32_to_cpu(config_list->addr_val[count].value);
+				iwl_trans_write_prph(fwrt->trans, address + offset, value);
+			}
+			iwl_trans_release_nic_access(fwrt->trans);
+		break;
+		}
+		case IWL_FW_INI_CONFIG_SET_TYPE_DEVICE_MEMORY: {
+			for (count = 0; count < len; count++) {
+				address = le32_to_cpu(config_list->addr_val[count].address);
+				value = le32_to_cpu(config_list->addr_val[count].value);
+				iwl_trans_write_mem32(fwrt->trans, address + offset, value);
+				IWL_DEBUG_FW(fwrt, "WRT: DEV_MEM: count %u, add: %u val: %u\n",
+					     count, address, value);
+			}
+		break;
+		}
+		case IWL_FW_INI_CONFIG_SET_TYPE_CSR: {
+			for (count = 0; count < len; count++) {
+				address = le32_to_cpu(config_list->addr_val[count].address);
+				value = le32_to_cpu(config_list->addr_val[count].value);
+				iwl_write32(fwrt->trans, address + offset, value);
+				IWL_DEBUG_FW(fwrt, "WRT: CSR: count %u, add: %u val: %u\n",
+					     count, address, value);
+			}
+		break;
+		}
+		case IWL_FW_INI_CONFIG_SET_TYPE_DBGC_DRAM_ADDR: {
+			struct iwl_dbgc1_info dram_info = {};
+			struct iwl_dram_data *frags = &fwrt->trans->dbg.fw_mon_ini[1].frags[0];
+			__le64 dram_base_addr = cpu_to_le64(frags->physical);
+			__le32 dram_size = cpu_to_le32(frags->size);
+			u64  dram_addr = le64_to_cpu(dram_base_addr);
+			u32 ret;
+
+			IWL_DEBUG_FW(fwrt, "WRT: dram_base_addr 0x%016llx, dram_size 0x%x\n",
+				     dram_base_addr, dram_size);
+			IWL_DEBUG_FW(fwrt, "WRT: config_list->addr_offset: %u\n",
+				     le32_to_cpu(config_list->addr_offset));
+			for (count = 0; count < len; count++) {
+				address = le32_to_cpu(config_list->addr_val[count].address);
+				dram_info.dbgc1_add_lsb =
+					cpu_to_le32((dram_addr & 0x00000000FFFFFFFFULL) + 0x400);
+				dram_info.dbgc1_add_msb =
+					cpu_to_le32((dram_addr & 0xFFFFFFFF00000000ULL) >> 32);
+				dram_info.dbgc1_size = cpu_to_le32(le32_to_cpu(dram_size) - 0x400);
+				ret = iwl_trans_write_mem(fwrt->trans,
+							  address + offset, &dram_info, 4);
+				if (ret) {
+					IWL_ERR(fwrt, "Failed to write dram_info to HW_SMEM\n");
+					break;
+				}
 			}
+			break;
+		}
+		case IWL_FW_INI_CONFIG_SET_TYPE_PERIPH_SCRATCH_HWM: {
+			u32 debug_token_config =
+				le32_to_cpu(config_list->addr_val[0].value);
+
+			IWL_DEBUG_FW(fwrt, "WRT: Setting HWM debug token config: %u\n",
+				     debug_token_config);
+			fwrt->trans->dbg.ucode_preset = debug_token_config;
+			break;
+		}
 		default:
 			break;
 		}
@@ -1229,6 +1288,7 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 	case IWL_FW_INI_TIME_POINT_AFTER_ALIVE:
 		iwl_dbg_tlv_apply_buffers(fwrt);
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
 		break;
 	case IWL_FW_INI_TIME_POINT_PERIODIC:
@@ -1239,11 +1299,13 @@ void _iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 	case IWL_FW_INI_TIME_POINT_MISSED_BEACONS:
 	case IWL_FW_INI_TIME_POINT_FW_DHC_NOTIFICATION:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data,
 				       iwl_dbg_tlv_check_fw_pkt);
 		break;
 	default:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
+		iwl_dbg_tlv_apply_config(fwrt, conf_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, sync, trig_list, tp_data, NULL);
 		break;
 	}
-- 
2.33.0

