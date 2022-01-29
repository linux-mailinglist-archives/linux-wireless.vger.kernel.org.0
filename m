Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F784A2E18
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiA2LQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37872 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237055AbiA2LQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:29 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDliT-0002ji-RH;
        Sat, 29 Jan 2022 13:16:27 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:12 +0200
Message-Id: <iwlwifi.20220129105618.6c31f6a2dcfc.If311c1d548bc5f7157a449e848ea01f71f5592eb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/12] iwlwifi: yoyo: fix DBGI_SRAM ini dump header.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rotem Saado <rotem.saado@intel.com>

DBGI SRAM is new type of monitor, therefore it should be
dump as monitor type with ini dump monitor header.

Signed-off-by: Rotem Saado <rotem.saado@intel.com>
Fixes: 89639e06d0f3 ("iwlwifi: yoyo: support for new DBGI_SRAM region")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  6 ++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 29 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  2 ++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 7fb209ec442d..22f33c074ac9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -300,6 +300,12 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 			.addr = DBGC_CUR_DBGBUF_STATUS,			\
 			.mask = DBGC_CUR_DBGBUF_STATUS_IDX_MSK,		\
 		},							\
+	},								\
+	.mon_dbgi_regs = {						\
+		.write_ptr = {						\
+			.addr = DBGI_SRAM_FIFO_POINTERS,		\
+			.mask = DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK,	\
+		},							\
 	}
 
 const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 5c0d094887fc..101d9085e835 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1696,6 +1696,17 @@ iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
 					    &fwrt->trans->cfg->mon_smem_regs);
 }
 
+static void *
+iwl_dump_ini_mon_dbgi_fill_header(struct iwl_fw_runtime *fwrt,
+				  struct iwl_dump_ini_region_data *reg_data,
+				  void *data, u32 data_len)
+{
+	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
+
+	return iwl_dump_ini_mon_fill_header(fwrt, reg_data, mon_dump,
+					    &fwrt->trans->cfg->mon_dbgi_regs);
+}
+
 static void *
 iwl_dump_ini_err_table_fill_header(struct iwl_fw_runtime *fwrt,
 				   struct iwl_dump_ini_region_data *reg_data,
@@ -1861,6 +1872,20 @@ iwl_dump_ini_mon_smem_get_size(struct iwl_fw_runtime *fwrt,
 	return size;
 }
 
+static u32 iwl_dump_ini_mon_dbgi_get_size(struct iwl_fw_runtime *fwrt,
+					  struct iwl_dump_ini_region_data *reg_data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 size = le32_to_cpu(reg->dev_addr.size);
+	u32 ranges = iwl_dump_ini_mem_ranges(fwrt, reg_data);
+
+	if (!size || !ranges)
+		return 0;
+
+	return sizeof(struct iwl_fw_ini_monitor_dump) + ranges *
+		(size + sizeof(struct iwl_fw_ini_error_dump_range));
+}
+
 static u32 iwl_dump_ini_txf_get_size(struct iwl_fw_runtime *fwrt,
 				     struct iwl_dump_ini_region_data *reg_data)
 {
@@ -2285,8 +2310,8 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 	},
 	[IWL_FW_INI_REGION_DBGI_SRAM] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
-		.get_size = iwl_dump_ini_mem_get_size,
-		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.get_size = iwl_dump_ini_mon_dbgi_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mon_dbgi_fill_header,
 		.fill_range = iwl_dump_ini_dbgi_sram_iter,
 	},
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f46ec44da1eb..2eb7f87672b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -408,6 +408,7 @@ struct iwl_cfg {
 	u32 min_ba_txq_size;
 	const struct iwl_fw_mon_regs mon_dram_regs;
 	const struct iwl_fw_mon_regs mon_smem_regs;
+	const struct iwl_fw_mon_regs mon_dbgi_regs;
 };
 
 #define IWL_CFG_ANY (~0)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 95b3dae7b504..186e22c4e6c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -358,6 +358,8 @@
 #define DBGI_SRAM_TARGET_ACCESS_CFG_RESET_ADDRESS_MSK	0x10000
 #define DBGI_SRAM_TARGET_ACCESS_RDATA_LSB		0x00A2E154
 #define DBGI_SRAM_TARGET_ACCESS_RDATA_MSB		0x00A2E158
+#define DBGI_SRAM_FIFO_POINTERS				0x00A2E148
+#define DBGI_SRAM_FIFO_POINTERS_WR_PTR_MSK		0x00000FFF
 
 enum {
 	ENABLE_WFPM = BIT(31),
-- 
2.34.1

