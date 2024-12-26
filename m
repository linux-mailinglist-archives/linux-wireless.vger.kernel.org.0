Return-Path: <linux-wireless+bounces-16817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76B9FCBAB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF511883303
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575A143C63;
	Thu, 26 Dec 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcdSgDpf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C3145335
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227930; cv=none; b=bY/lbkW00lPZK++vAB9hBphirHfP5T09miwVpVXDDPS7QSaVr99QOTCM04+eqJBBIDS4j2qqACE6n2BknuirAJW5mCL/Jc2Xvi5jP0DKn8uVPQgjuiAjhSE4ij/lGDt0AcRylRyL8K5mySeTyLq4u/aYFH2t57b/Plb0iido9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227930; c=relaxed/simple;
	bh=ENb9C85Y/fyyQquoGgEhj2dLMcT6viE35mnzqWKVCqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzK1gtE7+hXhUo9Fd/WDfnN+cBeAZYxxw9qapg4jgpnRCVQqELASKD4hYt8IaKa2SxgoOJKLoDjFZqkdrpeHK6VSHa/p6XM4ca91SW12ycqn+Ne4zxpJZFBi/R2l3jKcGoYjEyKN3IF5y2x+1oUCkl283uXDnMZ9YY9aGJNWF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcdSgDpf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227929; x=1766763929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ENb9C85Y/fyyQquoGgEhj2dLMcT6viE35mnzqWKVCqI=;
  b=HcdSgDpfC2Bj9mETCl9pdU7MatzXPhanXfMmZ8nLEbSC3fitO4MMaXL8
   CGS/xaFAWo7sWllBL29+JVlEu3zgW90ocFJTtZ6PoCCSPLrTKW0q/2v2O
   LeOw+cwV75O9rayg6194vslNwbyAaIdtzQ3pejJHuNHaSoLMfUo9DXZY6
   k9XpDAPb/aWUDbVAsObHsmcuP4fh44Ii1KqkJt3m4gs+0ZnAlu4GU1/9Y
   ZLzIgm7KWFAmyKwj5PKcdqc1qUVxhPX96A+xlBC78xXVwvd9Sllfu/P6n
   7CLi80fHfNliukubd9KrY3CngciL8axQ2y2DoWRt8G/bAYL/BQX/qk3rA
   A==;
X-CSE-ConnectionGUID: sOPTIWPWSq+xPCKv56f1sg==
X-CSE-MsgGUID: td3ZazE0SPG2FXhm4u+G5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878158"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878158"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:29 -0800
X-CSE-ConnectionGUID: TyGVkI8yRg63ZhYKP7xGQw==
X-CSE-MsgGUID: Uj5RHCnNQVaQ8aXyD4jOhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99778008"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	"Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: pcie: Add support for new device ids
Date: Thu, 26 Dec 2024 17:44:53 +0200
Message-Id: <20241226174257.6a0db60436e7.I50a66544dde6c88acd9abe4b31badab96ef04cfc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: "Somashekhar(Som)" <somashekhar.puttagangaiah@intel.com>

Add support for new device-ids 0x2730 and 0x272F.

Signed-off-by: Somashekhar(Som) <somashekhar.puttagangaiah@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   | 167 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  10 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  16 ++
 4 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/dr.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 8d118ee92698..19c4ce6f2465 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -12,7 +12,7 @@ iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-gen3.o
 iwlwifi-objs		+= pcie/trans-gen2.o pcie/tx-gen2.o
 iwlwifi-$(CONFIG_IWLDVM) += cfg/1000.o cfg/2000.o cfg/5000.o cfg/6000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o cfg/9000.o cfg/22000.o
-iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o cfg/bz.o cfg/sc.o
+iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o cfg/bz.o cfg/sc.o cfg/dr.o
 iwlwifi-objs		+= iwl-dbg-tlv.o
 iwlwifi-objs		+= iwl-trans.o
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
new file mode 100644
index 000000000000..ab7c0f8d54f4
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
index 34c91deca57b..88444d6c10e5 100644
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
@@ -550,6 +556,8 @@ extern const char iwl_mtp_name[];
 extern const char iwl_sc_name[];
 extern const char iwl_sc2_name[];
 extern const char iwl_sc2f_name[];
+extern const char iwl_dr_name[];
+extern const char iwl_br_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
@@ -657,6 +665,8 @@ extern const struct iwl_cfg iwl_cfg_gl;
 extern const struct iwl_cfg iwl_cfg_sc;
 extern const struct iwl_cfg iwl_cfg_sc2;
 extern const struct iwl_cfg iwl_cfg_sc2f;
+extern const struct iwl_cfg iwl_cfg_dr;
+extern const struct iwl_cfg iwl_cfg_br;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 805fb249a0c6..8297d56815fa 100644
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
@@ -1147,6 +1150,19 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
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
2.34.1


