Return-Path: <linux-wireless+bounces-18979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00105A3737B
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C933616CFEE
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6418E05F;
	Sun, 16 Feb 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsbJRkdP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6318DB08
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699029; cv=none; b=MNOyPTYAzyv4zZaxwAj7taRwyLJ1uC2GSMQaTRBbyRmN3DGbHVrYTmk4Y4fLAkV/GJcRPIwz72QcrxCG4lfRrE+R3WjqxNqq1/zozKmLdHotwddVjwNs7Qm+TcIXS4gUrgoZfY4BJRYhMMmCKx/HGHbWY8GK8s62VABT3fq4hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699029; c=relaxed/simple;
	bh=8hXNhuFiAC3CI45Npuy3kdehu5tyqzxyCEOJo2Q+/CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clo+BYb9j3mzSqGob/S/sXqm0S6v1DPWuEy3rS5UlTXbxcmvQhw+ymYHke2aUHmiiidwTyxcscZL9M7Ox7aljjbGfVaWuVpYNRBRv5rsdoBd6ZahbQOiPf9PK9wnIW5Nd2xL6gwjw85zIz31K4p+9OhuQH+w7lTNVn5TrzjTwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsbJRkdP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699026; x=1771235026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8hXNhuFiAC3CI45Npuy3kdehu5tyqzxyCEOJo2Q+/CM=;
  b=NsbJRkdPFilIsvA9RB590IjbDuBdcKOeH06P4zSYSW+YPRBzBDjMzfGw
   df3sxg3Q8qXIq0Yx5SYRJpP/4ZWjx5HX4oqQmhdaQjZrVwyvyWIn8pe1Z
   9w/4bGnc5UycbwA7JxzUC3MN6BTixk6dkYPPu0s3MAOutTZq8EJRryrS6
   7rCJ0+EDAm6N1OM6WeSi9fYhQMY0fA6e1LI6bQOQsQoPXis+EUAqiLzAu
   Wrf2JR2UkUyTQAo9aikyQPRUSRua/bEVepspaodQP2xZ8yjTY7IdQD5gb
   t2MleZC5UCxJ6s/qVpBIXjxaq7EyszB4u9Up1EKRhwdMQaqf2TbPrKH/I
   Q==;
X-CSE-ConnectionGUID: DZd3z3mJTOScYxpA148CwQ==
X-CSE-MsgGUID: /ep8cN3fRnm4EOlIRUgFZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323371"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323371"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:46 -0800
X-CSE-ConnectionGUID: IPcQtCM2RIKnxB5T5ha+Rg==
X-CSE-MsgGUID: pyEXSLYmRZCuMooZ/t2WVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785227"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 08/42] wifi: iwlwifi: mld: add file fw.c
Date: Sun, 16 Feb 2025 11:42:47 +0200
Message-Id: <20250216111648.358e364ea3eb.I44dc2b28e071f3f127b360a4b63b10eb42a900fb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/fw.c | 536 ++++++++++++++++++++
 1 file changed, 536 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/fw.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/fw.c b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
new file mode 100644
index 000000000000..ec93af362cfc
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/fw.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#include "mld.h"
+
+#include "fw/api/alive.h"
+#include "fw/api/scan.h"
+#include "fw/api/rx.h"
+#include "fw/dbg.h"
+#include "fw/pnvm.h"
+#include "hcmd.h"
+#include "iwl-nvm-parse.h"
+#include "power.h"
+#include "mcc.h"
+#include "led.h"
+#include "coex.h"
+#include "regulatory.h"
+#include "thermal.h"
+
+static int iwl_mld_send_tx_ant_cfg(struct iwl_mld *mld)
+{
+	struct iwl_tx_ant_cfg_cmd cmd;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	cmd.valid = cpu_to_le32(iwl_mld_get_valid_tx_ant(mld));
+
+	IWL_DEBUG_FW(mld, "select valid tx ant: %u\n", cmd.valid);
+
+	return iwl_mld_send_cmd_pdu(mld, TX_ANT_CONFIGURATION_CMD, &cmd);
+}
+
+static int iwl_mld_send_rss_cfg_cmd(struct iwl_mld *mld)
+{
+	struct iwl_rss_config_cmd cmd = {
+		.flags = cpu_to_le32(IWL_RSS_ENABLE),
+		.hash_mask = BIT(IWL_RSS_HASH_TYPE_IPV4_TCP) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV4_UDP) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV4_PAYLOAD) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV6_TCP) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV6_UDP) |
+			     BIT(IWL_RSS_HASH_TYPE_IPV6_PAYLOAD),
+	};
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* Do not direct RSS traffic to Q 0 which is our fallback queue */
+	for (int i = 0; i < ARRAY_SIZE(cmd.indirection_table); i++)
+		cmd.indirection_table[i] =
+			1 + (i % (mld->trans->num_rx_queues - 1));
+	netdev_rss_key_fill(cmd.secret_key, sizeof(cmd.secret_key));
+
+	return iwl_mld_send_cmd_pdu(mld, RSS_CONFIG_CMD, &cmd);
+}
+
+static int iwl_mld_config_scan(struct iwl_mld *mld)
+{
+	struct iwl_scan_config cmd = {
+		.tx_chains = cpu_to_le32(iwl_mld_get_valid_tx_ant(mld)),
+		.rx_chains = cpu_to_le32(iwl_mld_get_valid_rx_ant(mld))
+	};
+
+	return iwl_mld_send_cmd_pdu(mld, WIDE_ID(LONG_GROUP, SCAN_CFG_CMD),
+				    &cmd);
+}
+
+static void iwl_mld_alive_imr_data(struct iwl_trans *trans,
+				   const struct iwl_imr_alive_info *imr_info)
+{
+	struct iwl_imr_data *imr_data = &trans->dbg.imr_data;
+
+	imr_data->imr_enable = le32_to_cpu(imr_info->enabled);
+	imr_data->imr_size = le32_to_cpu(imr_info->size);
+	imr_data->imr2sram_remainbyte = imr_data->imr_size;
+	imr_data->imr_base_addr = imr_info->base_addr;
+	imr_data->imr_curr_addr = le64_to_cpu(imr_data->imr_base_addr);
+
+	if (imr_data->imr_enable)
+		return;
+
+	for (int i = 0; i < ARRAY_SIZE(trans->dbg.active_regions); i++) {
+		struct iwl_fw_ini_region_tlv *reg;
+
+		if (!trans->dbg.active_regions[i])
+			continue;
+
+		reg = (void *)trans->dbg.active_regions[i]->data;
+
+		/* We have only one DRAM IMR region, so we
+		 * can break as soon as we find the first
+		 * one.
+		 */
+		if (reg->type == IWL_FW_INI_REGION_DRAM_IMR) {
+			trans->dbg.unsupported_region_msk |= BIT(i);
+			break;
+		}
+	}
+}
+
+static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
+			 struct iwl_rx_packet *pkt, void *data)
+{
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
+	struct iwl_mld *mld =
+		container_of(notif_wait, struct iwl_mld, notif_wait);
+	struct iwl_trans *trans = mld->trans;
+	u32 version = iwl_fw_lookup_notif_ver(mld->fw, LEGACY_GROUP,
+					      UCODE_ALIVE_NTFY, 0);
+	struct iwl_alive_ntf_v6 *palive;
+	bool *alive_valid = data;
+	struct iwl_umac_alive *umac;
+	struct iwl_lmac_alive *lmac1;
+	struct iwl_lmac_alive *lmac2 = NULL;
+	u32 lmac_error_event_table;
+	u32 umac_error_table;
+	u16 status;
+
+	if (version < 6 || version > 7 || pkt_len != sizeof(*palive))
+		return false;
+
+	palive = (void *)pkt->data;
+
+	iwl_mld_alive_imr_data(trans, &palive->imr);
+
+	umac = &palive->umac_data;
+	lmac1 = &palive->lmac_data[0];
+	lmac2 = &palive->lmac_data[1];
+	status = le16_to_cpu(palive->status);
+
+	trans->sku_id[0] = le32_to_cpu(palive->sku_id.data[0]);
+	trans->sku_id[1] = le32_to_cpu(palive->sku_id.data[1]);
+	trans->sku_id[2] = le32_to_cpu(palive->sku_id.data[2]);
+
+	IWL_DEBUG_FW(mld, "Got sku_id: 0x0%x 0x0%x 0x0%x\n",
+		     trans->sku_id[0], trans->sku_id[1], trans->sku_id[2]);
+
+	lmac_error_event_table =
+		le32_to_cpu(lmac1->dbg_ptrs.error_event_table_ptr);
+	iwl_fw_lmac1_set_alive_err_table(trans, lmac_error_event_table);
+
+	if (lmac2)
+		trans->dbg.lmac_error_event_table[1] =
+			le32_to_cpu(lmac2->dbg_ptrs.error_event_table_ptr);
+
+	umac_error_table = le32_to_cpu(umac->dbg_ptrs.error_info_addr) &
+		~FW_ADDR_CACHE_CONTROL;
+
+	if (umac_error_table >= trans->cfg->min_umac_error_event_table)
+		iwl_fw_umac_set_alive_err_table(trans, umac_error_table);
+	else
+		IWL_ERR(mld, "Not valid error log pointer 0x%08X\n",
+			umac_error_table);
+
+	*alive_valid = status == IWL_ALIVE_STATUS_OK;
+
+	IWL_DEBUG_FW(mld,
+		     "Alive ucode status 0x%04x revision 0x%01X 0x%01X\n",
+		     status, lmac1->ver_type, lmac1->ver_subtype);
+
+	if (lmac2)
+		IWL_DEBUG_FW(mld, "Alive ucode CDB\n");
+
+	IWL_DEBUG_FW(mld,
+		     "UMAC version: Major - 0x%x, Minor - 0x%x\n",
+		     le32_to_cpu(umac->umac_major),
+		     le32_to_cpu(umac->umac_minor));
+
+	if (version >= 7)
+		IWL_DEBUG_FW(mld, "FW alive flags 0x%x\n",
+			     le16_to_cpu(palive->flags));
+
+	iwl_fwrt_update_fw_versions(&mld->fwrt, lmac1, umac);
+
+	return true;
+}
+
+#define MLD_ALIVE_TIMEOUT		(2 * HZ)
+#define MLD_INIT_COMPLETE_TIMEOUT	(2 * HZ)
+
+static void iwl_mld_print_alive_notif_timeout(struct iwl_mld *mld)
+{
+	struct iwl_trans *trans = mld->trans;
+	struct iwl_pc_data *pc_data;
+	u8 count;
+
+	IWL_ERR(mld,
+		"SecBoot CPU1 Status: 0x%x, CPU2 Status: 0x%x\n",
+		iwl_read_umac_prph(trans, UMAG_SB_CPU_1_STATUS),
+		iwl_read_umac_prph(trans,
+				   UMAG_SB_CPU_2_STATUS));
+#define IWL_FW_PRINT_REG_INFO(reg_name) \
+	IWL_ERR(mld, #reg_name ": 0x%x\n", iwl_read_umac_prph(trans, reg_name))
+
+	IWL_FW_PRINT_REG_INFO(WFPM_LMAC1_PD_NOTIFICATION);
+
+	IWL_FW_PRINT_REG_INFO(HPM_SECONDARY_DEVICE_STATE);
+
+	/* print OTP info */
+	IWL_FW_PRINT_REG_INFO(WFPM_MAC_OTP_CFG7_ADDR);
+	IWL_FW_PRINT_REG_INFO(WFPM_MAC_OTP_CFG7_DATA);
+#undef IWL_FW_PRINT_REG_INFO
+
+	pc_data = trans->dbg.pc_data;
+	for (count = 0; count < trans->dbg.num_pc; count++, pc_data++)
+		IWL_ERR(mld, "%s: 0x%x\n", pc_data->pc_name,
+			pc_data->pc_address);
+}
+
+static int iwl_mld_load_fw_wait_alive(struct iwl_mld *mld)
+{
+	const struct fw_img *fw =
+		iwl_get_ucode_image(mld->fw, IWL_UCODE_REGULAR);
+	static const u16 alive_cmd[] = { UCODE_ALIVE_NTFY };
+	struct iwl_notification_wait alive_wait;
+	bool alive_valid = false;
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	iwl_init_notification_wait(&mld->notif_wait, &alive_wait,
+				   alive_cmd, ARRAY_SIZE(alive_cmd),
+				   iwl_alive_fn, &alive_valid);
+
+	iwl_dbg_tlv_time_point(&mld->fwrt, IWL_FW_INI_TIME_POINT_EARLY, NULL);
+
+	ret = iwl_trans_start_fw(mld->trans, fw, true);
+	if (ret) {
+		iwl_remove_notification(&mld->notif_wait, &alive_wait);
+		return ret;
+	}
+
+	ret = iwl_wait_notification(&mld->notif_wait, &alive_wait,
+				    MLD_ALIVE_TIMEOUT);
+
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			iwl_fw_dbg_error_collect(&mld->fwrt,
+						 FW_DBG_TRIGGER_ALIVE_TIMEOUT);
+		iwl_mld_print_alive_notif_timeout(mld);
+		goto alive_failure;
+	}
+
+	if (!alive_valid) {
+		IWL_ERR(mld, "Loaded firmware is not valid!\n");
+		ret = -EIO;
+		goto alive_failure;
+	}
+
+	iwl_trans_fw_alive(mld->trans, 0);
+
+	return 0;
+
+alive_failure:
+	iwl_trans_stop_device(mld->trans);
+	return ret;
+}
+
+int iwl_mld_run_fw_init_sequence(struct iwl_mld *mld)
+{
+	struct iwl_notification_wait init_wait;
+	struct iwl_init_extended_cfg_cmd init_cfg = {};
+	static const u16 init_complete[] = {
+		INIT_COMPLETE_NOTIF,
+	};
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_load_fw_wait_alive(mld);
+	if (ret)
+		return ret;
+
+	mld->trans->step_urm =
+		!!(iwl_read_umac_prph(mld->trans, CNVI_PMU_STEP_FLOW) &
+		   CNVI_PMU_STEP_FLOW_FORCE_URM);
+
+	ret = iwl_pnvm_load(mld->trans, &mld->notif_wait,
+			    &mld->fw->ucode_capa);
+	if (ret) {
+		IWL_ERR(mld, "Timeout waiting for PNVM load %d\n", ret);
+		goto init_failure;
+	}
+
+	iwl_dbg_tlv_time_point(&mld->fwrt, IWL_FW_INI_TIME_POINT_AFTER_ALIVE,
+			       NULL);
+
+	iwl_init_notification_wait(&mld->notif_wait,
+				   &init_wait,
+				   init_complete,
+				   ARRAY_SIZE(init_complete),
+				   NULL, NULL);
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(SYSTEM_GROUP, INIT_EXTENDED_CFG_CMD),
+				   &init_cfg);
+	if (ret) {
+		IWL_ERR(mld, "Failed to send init config command: %d\n", ret);
+		iwl_remove_notification(&mld->notif_wait, &init_wait);
+		goto init_failure;
+	}
+
+	ret = iwl_wait_notification(&mld->notif_wait, &init_wait,
+				    MLD_INIT_COMPLETE_TIMEOUT);
+	if (ret) {
+		IWL_ERR(mld, "Failed to get INIT_COMPLETE %d\n", ret);
+		goto init_failure;
+	}
+
+	if (!mld->nvm_data) {
+		mld->nvm_data = iwl_get_nvm(mld->trans, mld->fw, 0, 0);
+		if (IS_ERR(mld->nvm_data)) {
+			ret = PTR_ERR(mld->nvm_data);
+			mld->nvm_data = NULL;
+			IWL_ERR(mld, "Failed to read NVM: %d\n", ret);
+			goto init_failure;
+		}
+	}
+
+	return 0;
+
+init_failure:
+	iwl_trans_stop_device(mld->trans);
+	return ret;
+}
+
+int iwl_mld_load_fw(struct iwl_mld *mld)
+{
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_trans_start_hw(mld->trans);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_run_fw_init_sequence(mld);
+	if (ret)
+		return ret;
+
+	mld->fw_status.running = true;
+
+	return 0;
+}
+
+void iwl_mld_stop_fw(struct iwl_mld *mld)
+{
+	lockdep_assert_wiphy(mld->wiphy);
+
+	iwl_abort_notification_waits(&mld->notif_wait);
+
+	iwl_fw_dbg_stop_sync(&mld->fwrt);
+
+	iwl_trans_stop_device(mld->trans);
+
+	mld->fw_status.running = false;
+}
+
+static void iwl_mld_restart_disconnect_iter(void *data, u8 *mac,
+					    struct ieee80211_vif *vif)
+{
+	if (vif->type == NL80211_IFTYPE_STATION)
+		ieee80211_hw_restart_disconnect(vif);
+}
+
+void iwl_mld_send_recovery_cmd(struct iwl_mld *mld, u32 flags)
+{
+	u32 error_log_size = mld->fw->ucode_capa.error_log_size;
+	struct iwl_fw_error_recovery_cmd recovery_cmd = {
+		.flags = cpu_to_le32(flags),
+	};
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(SYSTEM_GROUP, FW_ERROR_RECOVERY_CMD),
+		.flags = CMD_WANT_SKB,
+		.data = {&recovery_cmd, },
+		.len = {sizeof(recovery_cmd), },
+	};
+	int ret;
+
+	/* no error log was defined in TLV */
+	if (!error_log_size)
+		return;
+
+	if (flags & ERROR_RECOVERY_UPDATE_DB) {
+		/* no buf was allocated upon NIC error */
+		if (!mld->error_recovery_buf)
+			return;
+
+		cmd.data[1] = mld->error_recovery_buf;
+		cmd.len[1] =  error_log_size;
+		cmd.dataflags[1] = IWL_HCMD_DFL_NOCOPY;
+		recovery_cmd.buf_size = cpu_to_le32(error_log_size);
+	}
+
+	ret = iwl_mld_send_cmd(mld, &cmd);
+
+	/* we no longer need the recovery buffer */
+	kfree(mld->error_recovery_buf);
+	mld->error_recovery_buf = NULL;
+
+	if (ret) {
+		IWL_ERR(mld, "Failed to send recovery cmd %d\n", ret);
+		return;
+	}
+
+	if (flags & ERROR_RECOVERY_UPDATE_DB) {
+		struct iwl_rx_packet *pkt = cmd.resp_pkt;
+		u32 pkt_len = iwl_rx_packet_payload_len(pkt);
+		u32 resp;
+
+		if (IWL_FW_CHECK(mld, pkt_len != sizeof(resp),
+				 "Unexpected recovery cmd response size %u (expected %zu)\n",
+				 pkt_len, sizeof(resp)))
+			goto out;
+
+		resp = le32_to_cpup((__le32 *)cmd.resp_pkt->data);
+		if (!resp)
+			goto out;
+
+		IWL_ERR(mld,
+			"Failed to send recovery cmd blob was invalid %d\n",
+			resp);
+
+		ieee80211_iterate_interfaces(mld->hw, 0,
+					     iwl_mld_restart_disconnect_iter,
+					     NULL);
+	}
+
+out:
+	iwl_free_resp(&cmd);
+}
+
+static int iwl_mld_config_fw(struct iwl_mld *mld)
+{
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	iwl_fw_disable_dbg_asserts(&mld->fwrt);
+	iwl_get_shared_mem_conf(&mld->fwrt);
+
+	ret = iwl_mld_send_tx_ant_cfg(mld);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_send_bt_init_conf(mld);
+	if (ret)
+		return ret;
+
+	ret = iwl_set_soc_latency(&mld->fwrt);
+	if (ret)
+		return ret;
+
+	iwl_mld_configure_lari(mld);
+
+	ret = iwl_mld_config_temp_report_ths(mld);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_THERMAL
+	ret = iwl_mld_config_ctdp(mld, mld->cooling_dev.cur_state,
+				  CTDP_CMD_OPERATION_START);
+	if (ret)
+		return ret;
+#endif
+
+	ret = iwl_configure_rxq(&mld->fwrt);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_send_rss_cfg_cmd(mld);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_config_scan(mld);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_update_device_power(mld, false);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_init_mcc(mld);
+	if (ret)
+		return ret;
+
+	if (mld->fw_status.in_hw_restart) {
+		iwl_mld_send_recovery_cmd(mld, ERROR_RECOVERY_UPDATE_DB);
+		iwl_mld_time_sync_fw_config(mld);
+	}
+
+	iwl_mld_led_config_fw(mld);
+
+	ret = iwl_mld_init_ppag(mld);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_init_sar(mld);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_init_sgom(mld);
+	if (ret)
+		return ret;
+
+	iwl_mld_init_tas(mld);
+	iwl_mld_init_uats(mld);
+
+	return 0;
+}
+
+int iwl_mld_start_fw(struct iwl_mld *mld)
+{
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	ret = iwl_mld_load_fw(mld);
+	if (IWL_FW_CHECK(mld, ret, "Failed to start firmware %d\n", ret)) {
+		iwl_fw_dbg_error_collect(&mld->fwrt, FW_DBG_TRIGGER_DRIVER);
+		goto error;
+	}
+
+	IWL_DEBUG_INFO(mld, "uCode started.\n");
+
+	ret = iwl_mld_config_fw(mld);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	iwl_mld_stop_fw(mld);
+	return ret;
+}
-- 
2.34.1


