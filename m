Return-Path: <linux-wireless+bounces-17950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E1FA1CA8B
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0399C1881C4D
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732E18E362;
	Sun, 26 Jan 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRP+0vfN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9753B791;
	Sun, 26 Jan 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903701; cv=none; b=kVLYCGJVvnCiAYWpHHxPL2vCMEAC9kJ4pbq3WEccoqKtEE/+WOG9lvyMfpxcoSLkakw2dmlG8DSk/+V7sM3r57t5Z1/ZsAiwsCGhVIlUXS6B8dZoFZzkovPbgyrIs+m+eGzxbYMPyeti6nuYDvnORMzOvN2/IZYaZmQoGhuJ92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903701; c=relaxed/simple;
	bh=Uh8rUBUbHOuRXTqp6B4Bb4ndNDhZpfM2e8m/Mh2tUDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKLt1EAyicVCR4s6cGnD+t2wxR+C24lIQ2dojFi1/aIecCJDIlQnENfLHFThtz3BH/QB1QvJOQmOeidBCXZ9vNN3dZ0fqLwXTaQYRAsiCCtwZTJkyWrG1DPrhAsxyZPAW6fnzyMaZgulDcMqB1noRZHD+mv+2aXHFIRq6Y92Z8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRP+0vfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716FC4CED3;
	Sun, 26 Jan 2025 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903700;
	bh=Uh8rUBUbHOuRXTqp6B4Bb4ndNDhZpfM2e8m/Mh2tUDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRP+0vfNb0xrI9rgQEIKMoLcPYQ4XOPIkOMjxrIOyInXkIjEIzL15tRdecXLWufEa
	 FkMF6r+ZcfpwPWrarqsqq4OLLnK7djUcdNeZK0cd8dqLmlZ0FB4wfGldrpaE+kW6gQ
	 15UOYBctUGzVkZm9vtrP4L3zt/SJbSqKOpB6cPRQqrP5cXwYhHxmp9ULwXb6Cgzim7
	 wh1fBV+pOo4ws73TVExAd4FKR0PJxQAkbo6WES23irXerlS0RzwZZvfMP4sQ5XcIiv
	 2DwvHpk355L+lXnOlj60l2Gl9033/br6JfY4yJz4wgHhPypz0Njw2bkCJc31z94mlX
	 TXiRw5e4A7xYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	emmanuel.grumbach@intel.com,
	mukesh.sisodiya@intel.com,
	golan.ben.ami@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 20/35] wifi: iwlwifi: pcie: Add support for new device ids
Date: Sun, 26 Jan 2025 10:00:14 -0500
Message-Id: <20250126150029.953021-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>

[ Upstream commit 9b45ba3976945e8d53f2dd40541a66c690f12286 ]

Add support for new device-ids 0x2730 and 0x272F.

Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20241226174257.6a0db60436e7.I50a66544dde6c88acd9abe4b31badab96ef04cfc@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   | 167 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  10 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  16 ++
 4 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/dr.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 64c1233142451..a3052684b341f 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -11,7 +11,7 @@ iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-gen3.o
 iwlwifi-objs		+= pcie/trans-gen2.o pcie/tx-gen2.o
 iwlwifi-$(CONFIG_IWLDVM) += cfg/1000.o cfg/2000.o cfg/5000.o cfg/6000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o cfg/9000.o cfg/22000.o
-iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o cfg/bz.o cfg/sc.o
+iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o cfg/bz.o cfg/sc.o cfg/dr.o
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
new file mode 100644
index 0000000000000..ab7c0f8d54f42
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <linux/module.h>
+#include <linux/stringify.h>
+#include "iwl-config.h"
+#include "iwl-prph.h"
+#include "fw/api/txq.h"
+
+/* Highest firmware API version supported */
+#define IWL_DR_UCODE_API_MAX	96
+
+/* Lowest firmware API version supported */
+#define IWL_DR_UCODE_API_MIN	96
+
+/* NVM versions */
+#define IWL_DR_NVM_VERSION		0x0a1d
+
+/* Memory offsets and lengths */
+#define IWL_DR_DCCM_OFFSET		0x800000 /* LMAC1 */
+#define IWL_DR_DCCM_LEN			0x10000 /* LMAC1 */
+#define IWL_DR_DCCM2_OFFSET		0x880000
+#define IWL_DR_DCCM2_LEN		0x8000
+#define IWL_DR_SMEM_OFFSET		0x400000
+#define IWL_DR_SMEM_LEN			0xD0000
+
+#define IWL_DR_A_PE_A_FW_PRE		"iwlwifi-dr-a0-pe-a0"
+#define IWL_BR_A_PET_A_FW_PRE		"iwlwifi-br-a0-petc-a0"
+#define IWL_BR_A_PE_A_FW_PRE		"iwlwifi-br-a0-pe-a0"
+
+#define IWL_DR_A_PE_A_FW_MODULE_FIRMWARE(api) \
+	IWL_DR_A_PE_A_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_BR_A_PET_A_FW_MODULE_FIRMWARE(api) \
+	IWL_BR_A_PET_A_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_BR_A_PE_A_FW_MODULE_FIRMWARE(api) \
+	IWL_BR_A_PE_A_FW_PRE "-" __stringify(api) ".ucode"
+
+static const struct iwl_base_params iwl_dr_base_params = {
+	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
+	.num_of_queues = 512,
+	.max_tfd_queue_size = 65536,
+	.shadow_ram_support = true,
+	.led_compensation = 57,
+	.wd_timeout = IWL_LONG_WD_TIMEOUT,
+	.max_event_log_size = 512,
+	.shadow_reg_enable = true,
+	.pcie_l1_allowed = true,
+};
+
+#define IWL_DEVICE_DR_COMMON						\
+	.ucode_api_max = IWL_DR_UCODE_API_MAX,			\
+	.ucode_api_min = IWL_DR_UCODE_API_MIN,			\
+	.led_mode = IWL_LED_RF_STATE,					\
+	.nvm_hw_section_num = 10,					\
+	.non_shared_ant = ANT_B,					\
+	.dccm_offset = IWL_DR_DCCM_OFFSET,				\
+	.dccm_len = IWL_DR_DCCM_LEN,					\
+	.dccm2_offset = IWL_DR_DCCM2_OFFSET,				\
+	.dccm2_len = IWL_DR_DCCM2_LEN,				\
+	.smem_offset = IWL_DR_SMEM_OFFSET,				\
+	.smem_len = IWL_DR_SMEM_LEN,					\
+	.apmg_not_supported = true,					\
+	.trans.mq_rx_supported = true,					\
+	.vht_mu_mimo_supported = true,					\
+	.mac_addr_from_csr = 0x30,					\
+	.nvm_ver = IWL_DR_NVM_VERSION,				\
+	.trans.rf_id = true,						\
+	.trans.gen2 = true,						\
+	.nvm_type = IWL_NVM_EXT,					\
+	.dbgc_supported = true,						\
+	.min_umac_error_event_table = 0xD0000,				\
+	.d3_debug_data_base_addr = 0x401000,				\
+	.d3_debug_data_length = 60 * 1024,				\
+	.mon_smem_regs = {						\
+		.write_ptr = {						\
+			.addr = LDBG_M2S_BUF_WPTR,			\
+			.mask = LDBG_M2S_BUF_WPTR_VAL_MSK,		\
+	},								\
+		.cycle_cnt = {						\
+			.addr = LDBG_M2S_BUF_WRAP_CNT,			\
+			.mask = LDBG_M2S_BUF_WRAP_CNT_VAL_MSK,		\
+		},							\
+	},								\
+	.trans.umac_prph_offset = 0x300000,				\
+	.trans.device_family = IWL_DEVICE_FAMILY_DR,			\
+	.trans.base_params = &iwl_dr_base_params,			\
+	.min_txq_size = 128,						\
+	.gp2_reg_addr = 0xd02c68,					\
+	.min_ba_txq_size = IWL_DEFAULT_QUEUE_SIZE_EHT,			\
+	.mon_dram_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK,	\
+		},							\
+		.cycle_cnt = {						\
+			.addr = DBGC_DBGBUF_WRAP_AROUND,		\
+			.mask = 0xffffffff,				\
+		},							\
+		.cur_frag = {						\
+			.addr = DBGC_CUR_DBGBUF_STATUS,			\
+			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
+		},							\
+	},								\
+	.mon_dbgi_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGI_SRAM_FIFO_POINTERS,		\
+			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
+		},							\
+	}
+
+#define IWL_DEVICE_DR							\
+	IWL_DEVICE_DR_COMMON,						\
+	.uhb_supported = true,						\
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
+	.num_rbds = IWL_NUM_RBDS_DR_EHT,				\
+	.ht_params = &iwl_22000_ht_params
+
+/*
+ * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
+ * A-MPDU, with additional overhead to account for processing time.
+ */
+#define IWL_NUM_RBDS_DR_EHT		(512 * 16)
+
+const struct iwl_cfg_trans_params iwl_dr_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_DR,
+	.base_params = &iwl_dr_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.integrated = true,
+	.umac_prph_offset = 0x300000,
+	.xtal_latency = 12000,
+	.low_latency_xtal = true,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+};
+
+const char iwl_dr_name[] = "Intel(R) TBD Dr device";
+
+const struct iwl_cfg iwl_cfg_dr = {
+	.fw_name_mac = "dr",
+	IWL_DEVICE_DR,
+};
+
+const struct iwl_cfg_trans_params iwl_br_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_DR,
+	.base_params = &iwl_dr_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.gen2 = true,
+	.integrated = true,
+	.umac_prph_offset = 0x300000,
+	.xtal_latency = 12000,
+	.low_latency_xtal = true,
+	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
+};
+
+const char iwl_br_name[] = "Intel(R) TBD Br device";
+
+const struct iwl_cfg iwl_cfg_br = {
+	.fw_name_mac = "br",
+	IWL_DEVICE_DR,
+};
+
+MODULE_FIRMWARE(IWL_DR_A_PE_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BR_A_PET_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BR_A_PE_A_FW_MODULE_FIRMWARE(IWL_DR_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 17721bb47e251..89744dbedb4a5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -38,6 +38,7 @@ enum iwl_device_family {
 	IWL_DEVICE_FAMILY_AX210,
 	IWL_DEVICE_FAMILY_BZ,
 	IWL_DEVICE_FAMILY_SC,
+	IWL_DEVICE_FAMILY_DR,
 };
 
 /*
@@ -424,6 +425,8 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_SC2		0x49
 #define IWL_CFG_MAC_TYPE_SC2F		0x4A
 #define IWL_CFG_MAC_TYPE_BZ_W		0x4B
+#define IWL_CFG_MAC_TYPE_BR		0x4C
+#define IWL_CFG_MAC_TYPE_DR		0x4D
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
@@ -434,6 +437,7 @@ struct iwl_cfg {
 #define IWL_CFG_RF_TYPE_GF		0x10D
 #define IWL_CFG_RF_TYPE_FM		0x112
 #define IWL_CFG_RF_TYPE_WH		0x113
+#define IWL_CFG_RF_TYPE_PE		0x114
 
 #define IWL_CFG_RF_ID_TH		0x1
 #define IWL_CFG_RF_ID_TH1		0x1
@@ -506,6 +510,8 @@ extern const struct iwl_cfg_trans_params iwl_ma_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_bz_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_gl_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_sc_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_dr_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_br_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
 extern const char iwl9260_1_name[];
@@ -551,6 +557,8 @@ extern const char iwl_mtp_name[];
 extern const char iwl_sc_name[];
 extern const char iwl_sc2_name[];
 extern const char iwl_sc2f_name[];
+extern const char iwl_dr_name[];
+extern const char iwl_br_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
@@ -658,6 +666,8 @@ extern const struct iwl_cfg iwl_cfg_gl;
 extern const struct iwl_cfg iwl_cfg_sc;
 extern const struct iwl_cfg iwl_cfg_sc2;
 extern const struct iwl_cfg iwl_cfg_sc2f;
+extern const struct iwl_cfg iwl_cfg_dr;
+extern const struct iwl_cfg iwl_cfg_br;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8fb2aa2822421..9dd0e0a51ce5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -540,6 +540,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xE340, PCI_ANY_ID, iwl_sc_trans_cfg)},
 	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_trans_cfg)},
 	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_trans_cfg)},
+
+/* Dr devices */
+	{IWL_PCI_DEVICE(0x272F, PCI_ANY_ID, iwl_dr_trans_cfg)},
 #endif /* CONFIG_IWLMVM */
 
 	{0}
@@ -1182,6 +1185,19 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_sc2f, iwl_sc2f_name),
+/* Dr */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_DR, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_dr, iwl_dr_name),
+
+/* Br */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BR, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_br, iwl_br_name),
 #endif /* CONFIG_IWLMVM */
 };
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_dev_info_table);
-- 
2.39.5


