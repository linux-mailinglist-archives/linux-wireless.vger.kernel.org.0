Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D73AE443
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFUHkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48436 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230052AbhFUHkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEVC-001aFa-71; Mon, 21 Jun 2021 10:37:52 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:37 +0300
Message-Id: <iwlwifi.20210621103449.b82b60d81346.Ide3b688107f6a59c7fc7eb1d8f2002b0a5c1f2d2@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621073740.1105911-1-luca@coelho.fi>
References: <20210621073740.1105911-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 6/9] iwlwifi: move error dump to fw utils
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Conceptually, this belongs more into the firmware utils
rather than the mvm opmode, so move the collection and
output there.

Note that this slightly changes the format of the Status
line.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  38 --
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 358 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 310 ---------------
 6 files changed, 368 insertions(+), 351 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dump.c

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 12ce156c2e9d..dab41f0fdea7 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -16,7 +16,7 @@ iwlwifi-objs		+= iwl-trans.o
 iwlwifi-objs		+= queue/tx.o
 
 iwlwifi-objs		+= fw/img.o fw/notif-wait.o
-iwlwifi-objs		+= fw/dbg.o fw/pnvm.o
+iwlwifi-objs		+= fw/dbg.o fw/pnvm.o fw/dump.o
 iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
 iwlwifi-$(CONFIG_EFI)	+= fw/uefi.o
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 5a534d70f253..df7c55e06f54 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2759,44 +2759,6 @@ void iwl_fw_dbg_stop_sync(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_stop_sync);
 
-#define FSEQ_REG(x) { .addr = (x), .str = #x, }
-
-void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
-{
-	struct iwl_trans *trans = fwrt->trans;
-	int i;
-	struct {
-		u32 addr;
-		const char *str;
-	} fseq_regs[] = {
-		FSEQ_REG(FSEQ_ERROR_CODE),
-		FSEQ_REG(FSEQ_TOP_INIT_VERSION),
-		FSEQ_REG(FSEQ_CNVIO_INIT_VERSION),
-		FSEQ_REG(FSEQ_OTP_VERSION),
-		FSEQ_REG(FSEQ_TOP_CONTENT_VERSION),
-		FSEQ_REG(FSEQ_ALIVE_TOKEN),
-		FSEQ_REG(FSEQ_CNVI_ID),
-		FSEQ_REG(FSEQ_CNVR_ID),
-		FSEQ_REG(CNVI_AUX_MISC_CHIP),
-		FSEQ_REG(CNVR_AUX_MISC_CHIP),
-		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM),
-		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR),
-	};
-
-	if (!iwl_trans_grab_nic_access(trans))
-		return;
-
-	IWL_ERR(fwrt, "Fseq Registers:\n");
-
-	for (i = 0; i < ARRAY_SIZE(fseq_regs); i++)
-		IWL_ERR(fwrt, "0x%08X | %s\n",
-			iwl_read_prph_no_grab(trans, fseq_regs[i].addr),
-			fseq_regs[i].str);
-
-	iwl_trans_release_nic_access(trans);
-}
-IWL_EXPORT_SYMBOL(iwl_fw_error_print_fseq_regs);
-
 static int iwl_fw_dbg_suspend_resume_hcmd(struct iwl_trans *trans, bool suspend)
 {
 	struct iwl_dbg_suspend_resume_cmd cmd = {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 49fa2f5f8c7e..c0e84ef84f5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2019, 2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -321,4 +321,6 @@ static inline void iwl_fwrt_update_fw_versions(struct iwl_fw_runtime *fwrt,
 		fwrt->dump.fw_ver.umac_minor = le32_to_cpu(umac->umac_minor);
 	}
 }
+
+void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt);
 #endif  /* __iwl_fw_dbg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
new file mode 100644
index 000000000000..66f86d2a7cca
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
+ * Copyright (C) 2015-2017 Intel Deutschland GmbH
+ */
+#include <linux/devcoredump.h>
+#include "iwl-drv.h"
+#include "runtime.h"
+#include "dbg.h"
+#include "debugfs.h"
+#include "iwl-io.h"
+#include "iwl-prph.h"
+#include "iwl-csr.h"
+
+/*
+ * Note: This structure is read from the device with IO accesses,
+ * and the reading already does the endian conversion. As it is
+ * read with u32-sized accesses, any members with a different size
+ * need to be ordered correctly though!
+ */
+struct iwl_error_event_table_v1 {
+	u32 valid;		/* (nonzero) valid, (0) log is empty */
+	u32 error_id;		/* type of error */
+	u32 pc;			/* program counter */
+	u32 blink1;		/* branch link */
+	u32 blink2;		/* branch link */
+	u32 ilink1;		/* interrupt link */
+	u32 ilink2;		/* interrupt link */
+	u32 data1;		/* error-specific data */
+	u32 data2;		/* error-specific data */
+	u32 data3;		/* error-specific data */
+	u32 bcon_time;		/* beacon timer */
+	u32 tsf_low;		/* network timestamp function timer */
+	u32 tsf_hi;		/* network timestamp function timer */
+	u32 gp1;		/* GP1 timer register */
+	u32 gp2;		/* GP2 timer register */
+	u32 gp3;		/* GP3 timer register */
+	u32 ucode_ver;		/* uCode version */
+	u32 hw_ver;		/* HW Silicon version */
+	u32 brd_ver;		/* HW board version */
+	u32 log_pc;		/* log program counter */
+	u32 frame_ptr;		/* frame pointer */
+	u32 stack_ptr;		/* stack pointer */
+	u32 hcmd;		/* last host command header */
+	u32 isr0;		/* isr status register LMPM_NIC_ISR0:
+				 * rxtx_flag */
+	u32 isr1;		/* isr status register LMPM_NIC_ISR1:
+				 * host_flag */
+	u32 isr2;		/* isr status register LMPM_NIC_ISR2:
+				 * enc_flag */
+	u32 isr3;		/* isr status register LMPM_NIC_ISR3:
+				 * time_flag */
+	u32 isr4;		/* isr status register LMPM_NIC_ISR4:
+				 * wico interrupt */
+	u32 isr_pref;		/* isr status register LMPM_NIC_PREF_STAT */
+	u32 wait_event;		/* wait event() caller address */
+	u32 l2p_control;	/* L2pControlField */
+	u32 l2p_duration;	/* L2pDurationField */
+	u32 l2p_mhvalid;	/* L2pMhValidBits */
+	u32 l2p_addr_match;	/* L2pAddrMatchStat */
+	u32 lmpm_pmg_sel;	/* indicate which clocks are turned on
+				 * (LMPM_PMG_SEL) */
+	u32 u_timestamp;	/* indicate when the date and time of the
+				 * compilation */
+	u32 flow_handler;	/* FH read/write pointers, RX credit */
+} __packed /* LOG_ERROR_TABLE_API_S_VER_1 */;
+
+struct iwl_error_event_table {
+	u32 valid;		/* (nonzero) valid, (0) log is empty */
+	u32 error_id;		/* type of error */
+	u32 trm_hw_status0;	/* TRM HW status */
+	u32 trm_hw_status1;	/* TRM HW status */
+	u32 blink2;		/* branch link */
+	u32 ilink1;		/* interrupt link */
+	u32 ilink2;		/* interrupt link */
+	u32 data1;		/* error-specific data */
+	u32 data2;		/* error-specific data */
+	u32 data3;		/* error-specific data */
+	u32 bcon_time;		/* beacon timer */
+	u32 tsf_low;		/* network timestamp function timer */
+	u32 tsf_hi;		/* network timestamp function timer */
+	u32 gp1;		/* GP1 timer register */
+	u32 gp2;		/* GP2 timer register */
+	u32 fw_rev_type;	/* firmware revision type */
+	u32 major;		/* uCode version major */
+	u32 minor;		/* uCode version minor */
+	u32 hw_ver;		/* HW Silicon version */
+	u32 brd_ver;		/* HW board version */
+	u32 log_pc;		/* log program counter */
+	u32 frame_ptr;		/* frame pointer */
+	u32 stack_ptr;		/* stack pointer */
+	u32 hcmd;		/* last host command header */
+	u32 isr0;		/* isr status register LMPM_NIC_ISR0:
+				 * rxtx_flag */
+	u32 isr1;		/* isr status register LMPM_NIC_ISR1:
+				 * host_flag */
+	u32 isr2;		/* isr status register LMPM_NIC_ISR2:
+				 * enc_flag */
+	u32 isr3;		/* isr status register LMPM_NIC_ISR3:
+				 * time_flag */
+	u32 isr4;		/* isr status register LMPM_NIC_ISR4:
+				 * wico interrupt */
+	u32 last_cmd_id;	/* last HCMD id handled by the firmware */
+	u32 wait_event;		/* wait event() caller address */
+	u32 l2p_control;	/* L2pControlField */
+	u32 l2p_duration;	/* L2pDurationField */
+	u32 l2p_mhvalid;	/* L2pMhValidBits */
+	u32 l2p_addr_match;	/* L2pAddrMatchStat */
+	u32 lmpm_pmg_sel;	/* indicate which clocks are turned on
+				 * (LMPM_PMG_SEL) */
+	u32 u_timestamp;	/* indicate when the date and time of the
+				 * compilation */
+	u32 flow_handler;	/* FH read/write pointers, RX credit */
+} __packed /* LOG_ERROR_TABLE_API_S_VER_3 */;
+
+/*
+ * UMAC error struct - relevant starting from family 8000 chip.
+ * Note: This structure is read from the device with IO accesses,
+ * and the reading already does the endian conversion. As it is
+ * read with u32-sized accesses, any members with a different size
+ * need to be ordered correctly though!
+ */
+struct iwl_umac_error_event_table {
+	u32 valid;		/* (nonzero) valid, (0) log is empty */
+	u32 error_id;		/* type of error */
+	u32 blink1;		/* branch link */
+	u32 blink2;		/* branch link */
+	u32 ilink1;		/* interrupt link */
+	u32 ilink2;		/* interrupt link */
+	u32 data1;		/* error-specific data */
+	u32 data2;		/* error-specific data */
+	u32 data3;		/* error-specific data */
+	u32 umac_major;
+	u32 umac_minor;
+	u32 frame_pointer;	/* core register 27*/
+	u32 stack_pointer;	/* core register 28 */
+	u32 cmd_header;		/* latest host cmd sent to UMAC */
+	u32 nic_isr_pref;	/* ISR status register */
+} __packed;
+
+#define ERROR_START_OFFSET  (1 * sizeof(u32))
+#define ERROR_ELEM_SIZE     (7 * sizeof(u32))
+
+static void iwl_fwrt_dump_umac_error_log(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	struct iwl_umac_error_event_table table = {};
+	u32 base = fwrt->trans->dbg.umac_error_event_table;
+
+	if (!base &&
+	    !(fwrt->trans->dbg.error_event_table_tlv_status &
+	      IWL_ERROR_EVENT_TABLE_UMAC))
+		return;
+
+	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
+
+	if (table.valid)
+		fwrt->dump.umac_err_id = table.error_id;
+
+	if (ERROR_START_OFFSET <= table.valid * ERROR_ELEM_SIZE) {
+		IWL_ERR(trans, "Start IWL Error Log Dump:\n");
+		IWL_ERR(trans, "Transport status: 0x%08lX, valid: %d\n",
+			fwrt->trans->status, table.valid);
+	}
+
+	IWL_ERR(fwrt, "0x%08X | %s\n", table.error_id,
+		iwl_fw_lookup_assert_desc(table.error_id));
+	IWL_ERR(fwrt, "0x%08X | umac branchlink1\n", table.blink1);
+	IWL_ERR(fwrt, "0x%08X | umac branchlink2\n", table.blink2);
+	IWL_ERR(fwrt, "0x%08X | umac interruptlink1\n", table.ilink1);
+	IWL_ERR(fwrt, "0x%08X | umac interruptlink2\n", table.ilink2);
+	IWL_ERR(fwrt, "0x%08X | umac data1\n", table.data1);
+	IWL_ERR(fwrt, "0x%08X | umac data2\n", table.data2);
+	IWL_ERR(fwrt, "0x%08X | umac data3\n", table.data3);
+	IWL_ERR(fwrt, "0x%08X | umac major\n", table.umac_major);
+	IWL_ERR(fwrt, "0x%08X | umac minor\n", table.umac_minor);
+	IWL_ERR(fwrt, "0x%08X | frame pointer\n", table.frame_pointer);
+	IWL_ERR(fwrt, "0x%08X | stack pointer\n", table.stack_pointer);
+	IWL_ERR(fwrt, "0x%08X | last host cmd\n", table.cmd_header);
+	IWL_ERR(fwrt, "0x%08X | isr status reg\n", table.nic_isr_pref);
+}
+
+static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_num)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	struct iwl_error_event_table table = {};
+	u32 val, base = fwrt->trans->dbg.lmac_error_event_table[lmac_num];
+
+	if (fwrt->cur_fw_img == IWL_UCODE_INIT) {
+		if (!base)
+			base = fwrt->fw->init_errlog_ptr;
+	} else {
+		if (!base)
+			base = fwrt->fw->inst_errlog_ptr;
+	}
+
+	if (base < 0x400000) {
+		IWL_ERR(fwrt,
+			"Not valid error log pointer 0x%08X for %s uCode\n",
+			base,
+			(fwrt->cur_fw_img == IWL_UCODE_INIT)
+			? "Init" : "RT");
+		return;
+	}
+
+	/* check if there is a HW error */
+	val = iwl_trans_read_mem32(trans, base);
+	if (((val & ~0xf) == 0xa5a5a5a0) || ((val & ~0xf) == 0x5a5a5a50)) {
+		int err;
+
+		IWL_ERR(trans, "HW error, resetting before reading\n");
+
+		/* reset the device */
+		iwl_trans_sw_reset(trans);
+
+		err = iwl_finish_nic_init(trans, trans->trans_cfg);
+		if (err)
+			return;
+	}
+
+	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
+
+	if (table.valid)
+		fwrt->dump.lmac_err_id[lmac_num] = table.error_id;
+
+	if (ERROR_START_OFFSET <= table.valid * ERROR_ELEM_SIZE) {
+		IWL_ERR(trans, "Start IWL Error Log Dump:\n");
+		IWL_ERR(trans, "Transport status: 0x%08lX, valid: %d\n",
+			fwrt->trans->status, table.valid);
+	}
+
+	/* Do not change this output - scripts rely on it */
+
+	IWL_ERR(fwrt, "Loaded firmware version: %s\n", fwrt->fw->fw_version);
+
+	IWL_ERR(fwrt, "0x%08X | %-28s\n", table.error_id,
+		iwl_fw_lookup_assert_desc(table.error_id));
+	IWL_ERR(fwrt, "0x%08X | trm_hw_status0\n", table.trm_hw_status0);
+	IWL_ERR(fwrt, "0x%08X | trm_hw_status1\n", table.trm_hw_status1);
+	IWL_ERR(fwrt, "0x%08X | branchlink2\n", table.blink2);
+	IWL_ERR(fwrt, "0x%08X | interruptlink1\n", table.ilink1);
+	IWL_ERR(fwrt, "0x%08X | interruptlink2\n", table.ilink2);
+	IWL_ERR(fwrt, "0x%08X | data1\n", table.data1);
+	IWL_ERR(fwrt, "0x%08X | data2\n", table.data2);
+	IWL_ERR(fwrt, "0x%08X | data3\n", table.data3);
+	IWL_ERR(fwrt, "0x%08X | beacon time\n", table.bcon_time);
+	IWL_ERR(fwrt, "0x%08X | tsf low\n", table.tsf_low);
+	IWL_ERR(fwrt, "0x%08X | tsf hi\n", table.tsf_hi);
+	IWL_ERR(fwrt, "0x%08X | time gp1\n", table.gp1);
+	IWL_ERR(fwrt, "0x%08X | time gp2\n", table.gp2);
+	IWL_ERR(fwrt, "0x%08X | uCode revision type\n", table.fw_rev_type);
+	IWL_ERR(fwrt, "0x%08X | uCode version major\n", table.major);
+	IWL_ERR(fwrt, "0x%08X | uCode version minor\n", table.minor);
+	IWL_ERR(fwrt, "0x%08X | hw version\n", table.hw_ver);
+	IWL_ERR(fwrt, "0x%08X | board version\n", table.brd_ver);
+	IWL_ERR(fwrt, "0x%08X | hcmd\n", table.hcmd);
+	IWL_ERR(fwrt, "0x%08X | isr0\n", table.isr0);
+	IWL_ERR(fwrt, "0x%08X | isr1\n", table.isr1);
+	IWL_ERR(fwrt, "0x%08X | isr2\n", table.isr2);
+	IWL_ERR(fwrt, "0x%08X | isr3\n", table.isr3);
+	IWL_ERR(fwrt, "0x%08X | isr4\n", table.isr4);
+	IWL_ERR(fwrt, "0x%08X | last cmd Id\n", table.last_cmd_id);
+	IWL_ERR(fwrt, "0x%08X | wait_event\n", table.wait_event);
+	IWL_ERR(fwrt, "0x%08X | l2p_control\n", table.l2p_control);
+	IWL_ERR(fwrt, "0x%08X | l2p_duration\n", table.l2p_duration);
+	IWL_ERR(fwrt, "0x%08X | l2p_mhvalid\n", table.l2p_mhvalid);
+	IWL_ERR(fwrt, "0x%08X | l2p_addr_match\n", table.l2p_addr_match);
+	IWL_ERR(fwrt, "0x%08X | lmpm_pmg_sel\n", table.lmpm_pmg_sel);
+	IWL_ERR(fwrt, "0x%08X | timestamp\n", table.u_timestamp);
+	IWL_ERR(fwrt, "0x%08X | flow_handler\n", table.flow_handler);
+}
+
+static void iwl_fwrt_dump_iml_error_log(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	u32 error, data1;
+
+	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+		error = UMAG_SB_CPU_2_STATUS;
+		data1 = UMAG_SB_CPU_1_STATUS;
+	} else if (fwrt->trans->trans_cfg->device_family >=
+		   IWL_DEVICE_FAMILY_8000) {
+		error = SB_CPU_2_STATUS;
+		data1 = SB_CPU_1_STATUS;
+	} else {
+		return;
+	}
+
+	error = iwl_read_umac_prph(trans, UMAG_SB_CPU_2_STATUS);
+
+	IWL_ERR(trans, "IML/ROM dump:\n");
+
+	if (error & 0xFFFF0000)
+		IWL_ERR(trans, "0x%04X | IML/ROM SYSASSERT\n", error >> 16);
+
+	IWL_ERR(fwrt, "0x%08X | IML/ROM error/state\n", error);
+	IWL_ERR(fwrt, "0x%08X | IML/ROM data1\n",
+		iwl_read_umac_prph(trans, data1));
+
+	if (fwrt->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
+		IWL_ERR(fwrt, "0x%08X | IML/ROM WFPM_AUTH_KEY_0\n",
+			iwl_read_umac_prph(trans, SB_MODIFY_CFG_FLAG));
+}
+
+#define FSEQ_REG(x) { .addr = (x), .str = #x, }
+
+static void iwl_fwrt_dump_fseq_regs(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	int i;
+	struct {
+		u32 addr;
+		const char *str;
+	} fseq_regs[] = {
+		FSEQ_REG(FSEQ_ERROR_CODE),
+		FSEQ_REG(FSEQ_TOP_INIT_VERSION),
+		FSEQ_REG(FSEQ_CNVIO_INIT_VERSION),
+		FSEQ_REG(FSEQ_OTP_VERSION),
+		FSEQ_REG(FSEQ_TOP_CONTENT_VERSION),
+		FSEQ_REG(FSEQ_ALIVE_TOKEN),
+		FSEQ_REG(FSEQ_CNVI_ID),
+		FSEQ_REG(FSEQ_CNVR_ID),
+		FSEQ_REG(CNVI_AUX_MISC_CHIP),
+		FSEQ_REG(CNVR_AUX_MISC_CHIP),
+		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM),
+		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR),
+	};
+
+	if (!iwl_trans_grab_nic_access(trans))
+		return;
+
+	IWL_ERR(fwrt, "Fseq Registers:\n");
+
+	for (i = 0; i < ARRAY_SIZE(fseq_regs); i++)
+		IWL_ERR(fwrt, "0x%08X | %s\n",
+			iwl_read_prph_no_grab(trans, fseq_regs[i].addr),
+			fseq_regs[i].str);
+
+	iwl_trans_release_nic_access(trans);
+}
+
+void iwl_fwrt_dump_error_logs(struct iwl_fw_runtime *fwrt)
+{
+	if (!test_bit(STATUS_DEVICE_ENABLED, &fwrt->trans->status)) {
+		IWL_ERR(fwrt,
+			"DEVICE_ENABLED bit is not set. Aborting dump.\n");
+		return;
+	}
+
+	iwl_fwrt_dump_lmac_error_log(fwrt, 0);
+	if (fwrt->trans->dbg.lmac_error_event_table[1])
+		iwl_fwrt_dump_lmac_error_log(fwrt, 1);
+	iwl_fwrt_dump_umac_error_log(fwrt);
+	iwl_fwrt_dump_iml_error_log(fwrt);
+	iwl_fwrt_dump_fseq_regs(fwrt);
+}
+IWL_EXPORT_SYMBOL(iwl_fwrt_dump_error_logs);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7be747738016..7b08a4a86cee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1472,7 +1472,12 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 			       struct ieee80211_tx_rate *r);
 u8 iwl_mvm_mac80211_idx_to_hwrate(int rate_idx);
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac);
-void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm);
+
+static inline void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
+{
+	iwl_fwrt_dump_error_logs(&mvm->fwrt);
+}
+
 u8 first_antenna(u8 mask);
 u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx);
 void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, int clock_type, u32 *gp2,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 0e8ad798ab57..4a3d2971a98b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -238,316 +238,6 @@ u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx)
 	return last_idx;
 }
 
-/*
- * Note: This structure is read from the device with IO accesses,
- * and the reading already does the endian conversion. As it is
- * read with u32-sized accesses, any members with a different size
- * need to be ordered correctly though!
- */
-struct iwl_error_event_table_v1 {
-	u32 valid;		/* (nonzero) valid, (0) log is empty */
-	u32 error_id;		/* type of error */
-	u32 pc;			/* program counter */
-	u32 blink1;		/* branch link */
-	u32 blink2;		/* branch link */
-	u32 ilink1;		/* interrupt link */
-	u32 ilink2;		/* interrupt link */
-	u32 data1;		/* error-specific data */
-	u32 data2;		/* error-specific data */
-	u32 data3;		/* error-specific data */
-	u32 bcon_time;		/* beacon timer */
-	u32 tsf_low;		/* network timestamp function timer */
-	u32 tsf_hi;		/* network timestamp function timer */
-	u32 gp1;		/* GP1 timer register */
-	u32 gp2;		/* GP2 timer register */
-	u32 gp3;		/* GP3 timer register */
-	u32 ucode_ver;		/* uCode version */
-	u32 hw_ver;		/* HW Silicon version */
-	u32 brd_ver;		/* HW board version */
-	u32 log_pc;		/* log program counter */
-	u32 frame_ptr;		/* frame pointer */
-	u32 stack_ptr;		/* stack pointer */
-	u32 hcmd;		/* last host command header */
-	u32 isr0;		/* isr status register LMPM_NIC_ISR0:
-				 * rxtx_flag */
-	u32 isr1;		/* isr status register LMPM_NIC_ISR1:
-				 * host_flag */
-	u32 isr2;		/* isr status register LMPM_NIC_ISR2:
-				 * enc_flag */
-	u32 isr3;		/* isr status register LMPM_NIC_ISR3:
-				 * time_flag */
-	u32 isr4;		/* isr status register LMPM_NIC_ISR4:
-				 * wico interrupt */
-	u32 isr_pref;		/* isr status register LMPM_NIC_PREF_STAT */
-	u32 wait_event;		/* wait event() caller address */
-	u32 l2p_control;	/* L2pControlField */
-	u32 l2p_duration;	/* L2pDurationField */
-	u32 l2p_mhvalid;	/* L2pMhValidBits */
-	u32 l2p_addr_match;	/* L2pAddrMatchStat */
-	u32 lmpm_pmg_sel;	/* indicate which clocks are turned on
-				 * (LMPM_PMG_SEL) */
-	u32 u_timestamp;	/* indicate when the date and time of the
-				 * compilation */
-	u32 flow_handler;	/* FH read/write pointers, RX credit */
-} __packed /* LOG_ERROR_TABLE_API_S_VER_1 */;
-
-struct iwl_error_event_table {
-	u32 valid;		/* (nonzero) valid, (0) log is empty */
-	u32 error_id;		/* type of error */
-	u32 trm_hw_status0;	/* TRM HW status */
-	u32 trm_hw_status1;	/* TRM HW status */
-	u32 blink2;		/* branch link */
-	u32 ilink1;		/* interrupt link */
-	u32 ilink2;		/* interrupt link */
-	u32 data1;		/* error-specific data */
-	u32 data2;		/* error-specific data */
-	u32 data3;		/* error-specific data */
-	u32 bcon_time;		/* beacon timer */
-	u32 tsf_low;		/* network timestamp function timer */
-	u32 tsf_hi;		/* network timestamp function timer */
-	u32 gp1;		/* GP1 timer register */
-	u32 gp2;		/* GP2 timer register */
-	u32 fw_rev_type;	/* firmware revision type */
-	u32 major;		/* uCode version major */
-	u32 minor;		/* uCode version minor */
-	u32 hw_ver;		/* HW Silicon version */
-	u32 brd_ver;		/* HW board version */
-	u32 log_pc;		/* log program counter */
-	u32 frame_ptr;		/* frame pointer */
-	u32 stack_ptr;		/* stack pointer */
-	u32 hcmd;		/* last host command header */
-	u32 isr0;		/* isr status register LMPM_NIC_ISR0:
-				 * rxtx_flag */
-	u32 isr1;		/* isr status register LMPM_NIC_ISR1:
-				 * host_flag */
-	u32 isr2;		/* isr status register LMPM_NIC_ISR2:
-				 * enc_flag */
-	u32 isr3;		/* isr status register LMPM_NIC_ISR3:
-				 * time_flag */
-	u32 isr4;		/* isr status register LMPM_NIC_ISR4:
-				 * wico interrupt */
-	u32 last_cmd_id;	/* last HCMD id handled by the firmware */
-	u32 wait_event;		/* wait event() caller address */
-	u32 l2p_control;	/* L2pControlField */
-	u32 l2p_duration;	/* L2pDurationField */
-	u32 l2p_mhvalid;	/* L2pMhValidBits */
-	u32 l2p_addr_match;	/* L2pAddrMatchStat */
-	u32 lmpm_pmg_sel;	/* indicate which clocks are turned on
-				 * (LMPM_PMG_SEL) */
-	u32 u_timestamp;	/* indicate when the date and time of the
-				 * compilation */
-	u32 flow_handler;	/* FH read/write pointers, RX credit */
-} __packed /* LOG_ERROR_TABLE_API_S_VER_3 */;
-
-/*
- * UMAC error struct - relevant starting from family 8000 chip.
- * Note: This structure is read from the device with IO accesses,
- * and the reading already does the endian conversion. As it is
- * read with u32-sized accesses, any members with a different size
- * need to be ordered correctly though!
- */
-struct iwl_umac_error_event_table {
-	u32 valid;		/* (nonzero) valid, (0) log is empty */
-	u32 error_id;		/* type of error */
-	u32 blink1;		/* branch link */
-	u32 blink2;		/* branch link */
-	u32 ilink1;		/* interrupt link */
-	u32 ilink2;		/* interrupt link */
-	u32 data1;		/* error-specific data */
-	u32 data2;		/* error-specific data */
-	u32 data3;		/* error-specific data */
-	u32 umac_major;
-	u32 umac_minor;
-	u32 frame_pointer;	/* core register 27*/
-	u32 stack_pointer;	/* core register 28 */
-	u32 cmd_header;		/* latest host cmd sent to UMAC */
-	u32 nic_isr_pref;	/* ISR status register */
-} __packed;
-
-#define ERROR_START_OFFSET  (1 * sizeof(u32))
-#define ERROR_ELEM_SIZE     (7 * sizeof(u32))
-
-static void iwl_mvm_dump_umac_error_log(struct iwl_mvm *mvm)
-{
-	struct iwl_trans *trans = mvm->trans;
-	struct iwl_umac_error_event_table table = {};
-	u32 base = mvm->trans->dbg.umac_error_event_table;
-
-	if (!base &&
-	    !(mvm->trans->dbg.error_event_table_tlv_status &
-	      IWL_ERROR_EVENT_TABLE_UMAC))
-		return;
-
-	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
-
-	if (table.valid)
-		mvm->fwrt.dump.umac_err_id = table.error_id;
-
-	if (ERROR_START_OFFSET <= table.valid * ERROR_ELEM_SIZE) {
-		IWL_ERR(trans, "Start IWL Error Log Dump:\n");
-		IWL_ERR(trans, "Status: 0x%08lX, count: %d\n",
-			mvm->status, table.valid);
-	}
-
-	IWL_ERR(mvm, "0x%08X | %s\n", table.error_id,
-		iwl_fw_lookup_assert_desc(table.error_id));
-	IWL_ERR(mvm, "0x%08X | umac branchlink1\n", table.blink1);
-	IWL_ERR(mvm, "0x%08X | umac branchlink2\n", table.blink2);
-	IWL_ERR(mvm, "0x%08X | umac interruptlink1\n", table.ilink1);
-	IWL_ERR(mvm, "0x%08X | umac interruptlink2\n", table.ilink2);
-	IWL_ERR(mvm, "0x%08X | umac data1\n", table.data1);
-	IWL_ERR(mvm, "0x%08X | umac data2\n", table.data2);
-	IWL_ERR(mvm, "0x%08X | umac data3\n", table.data3);
-	IWL_ERR(mvm, "0x%08X | umac major\n", table.umac_major);
-	IWL_ERR(mvm, "0x%08X | umac minor\n", table.umac_minor);
-	IWL_ERR(mvm, "0x%08X | frame pointer\n", table.frame_pointer);
-	IWL_ERR(mvm, "0x%08X | stack pointer\n", table.stack_pointer);
-	IWL_ERR(mvm, "0x%08X | last host cmd\n", table.cmd_header);
-	IWL_ERR(mvm, "0x%08X | isr status reg\n", table.nic_isr_pref);
-}
-
-static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm *mvm, u8 lmac_num)
-{
-	struct iwl_trans *trans = mvm->trans;
-	struct iwl_error_event_table table = {};
-	u32 val, base = mvm->trans->dbg.lmac_error_event_table[lmac_num];
-
-	if (mvm->fwrt.cur_fw_img == IWL_UCODE_INIT) {
-		if (!base)
-			base = mvm->fw->init_errlog_ptr;
-	} else {
-		if (!base)
-			base = mvm->fw->inst_errlog_ptr;
-	}
-
-	if (base < 0x400000) {
-		IWL_ERR(mvm,
-			"Not valid error log pointer 0x%08X for %s uCode\n",
-			base,
-			(mvm->fwrt.cur_fw_img == IWL_UCODE_INIT)
-			? "Init" : "RT");
-		return;
-	}
-
-	/* check if there is a HW error */
-	val = iwl_trans_read_mem32(trans, base);
-	if (((val & ~0xf) == 0xa5a5a5a0) || ((val & ~0xf) == 0x5a5a5a50)) {
-		int err;
-
-		IWL_ERR(trans, "HW error, resetting before reading\n");
-
-		/* reset the device */
-		iwl_trans_sw_reset(trans);
-
-		err = iwl_finish_nic_init(trans, trans->trans_cfg);
-		if (err)
-			return;
-	}
-
-	iwl_trans_read_mem_bytes(trans, base, &table, sizeof(table));
-
-	if (table.valid)
-		mvm->fwrt.dump.lmac_err_id[lmac_num] = table.error_id;
-
-	if (ERROR_START_OFFSET <= table.valid * ERROR_ELEM_SIZE) {
-		IWL_ERR(trans, "Start IWL Error Log Dump:\n");
-		IWL_ERR(trans, "Status: 0x%08lX, count: %d\n",
-			mvm->status, table.valid);
-	}
-
-	/* Do not change this output - scripts rely on it */
-
-	IWL_ERR(mvm, "Loaded firmware version: %s\n", mvm->fw->fw_version);
-
-	IWL_ERR(mvm, "0x%08X | %-28s\n", table.error_id,
-		iwl_fw_lookup_assert_desc(table.error_id));
-	IWL_ERR(mvm, "0x%08X | trm_hw_status0\n", table.trm_hw_status0);
-	IWL_ERR(mvm, "0x%08X | trm_hw_status1\n", table.trm_hw_status1);
-	IWL_ERR(mvm, "0x%08X | branchlink2\n", table.blink2);
-	IWL_ERR(mvm, "0x%08X | interruptlink1\n", table.ilink1);
-	IWL_ERR(mvm, "0x%08X | interruptlink2\n", table.ilink2);
-	IWL_ERR(mvm, "0x%08X | data1\n", table.data1);
-	IWL_ERR(mvm, "0x%08X | data2\n", table.data2);
-	IWL_ERR(mvm, "0x%08X | data3\n", table.data3);
-	IWL_ERR(mvm, "0x%08X | beacon time\n", table.bcon_time);
-	IWL_ERR(mvm, "0x%08X | tsf low\n", table.tsf_low);
-	IWL_ERR(mvm, "0x%08X | tsf hi\n", table.tsf_hi);
-	IWL_ERR(mvm, "0x%08X | time gp1\n", table.gp1);
-	IWL_ERR(mvm, "0x%08X | time gp2\n", table.gp2);
-	IWL_ERR(mvm, "0x%08X | uCode revision type\n", table.fw_rev_type);
-	IWL_ERR(mvm, "0x%08X | uCode version major\n", table.major);
-	IWL_ERR(mvm, "0x%08X | uCode version minor\n", table.minor);
-	IWL_ERR(mvm, "0x%08X | hw version\n", table.hw_ver);
-	IWL_ERR(mvm, "0x%08X | board version\n", table.brd_ver);
-	IWL_ERR(mvm, "0x%08X | hcmd\n", table.hcmd);
-	IWL_ERR(mvm, "0x%08X | isr0\n", table.isr0);
-	IWL_ERR(mvm, "0x%08X | isr1\n", table.isr1);
-	IWL_ERR(mvm, "0x%08X | isr2\n", table.isr2);
-	IWL_ERR(mvm, "0x%08X | isr3\n", table.isr3);
-	IWL_ERR(mvm, "0x%08X | isr4\n", table.isr4);
-	IWL_ERR(mvm, "0x%08X | last cmd Id\n", table.last_cmd_id);
-	IWL_ERR(mvm, "0x%08X | wait_event\n", table.wait_event);
-	IWL_ERR(mvm, "0x%08X | l2p_control\n", table.l2p_control);
-	IWL_ERR(mvm, "0x%08X | l2p_duration\n", table.l2p_duration);
-	IWL_ERR(mvm, "0x%08X | l2p_mhvalid\n", table.l2p_mhvalid);
-	IWL_ERR(mvm, "0x%08X | l2p_addr_match\n", table.l2p_addr_match);
-	IWL_ERR(mvm, "0x%08X | lmpm_pmg_sel\n", table.lmpm_pmg_sel);
-	IWL_ERR(mvm, "0x%08X | timestamp\n", table.u_timestamp);
-	IWL_ERR(mvm, "0x%08X | flow_handler\n", table.flow_handler);
-}
-
-static void iwl_mvm_dump_iml_error_log(struct iwl_mvm *mvm)
-{
-	struct iwl_trans *trans = mvm->trans;
-	u32 error, data1;
-
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
-		error = UMAG_SB_CPU_2_STATUS;
-		data1 = UMAG_SB_CPU_1_STATUS;
-	} else if (mvm->trans->trans_cfg->device_family >=
-		   IWL_DEVICE_FAMILY_8000) {
-		error = SB_CPU_2_STATUS;
-		data1 = SB_CPU_1_STATUS;
-	} else {
-		return;
-	}
-
-	error = iwl_read_umac_prph(trans, UMAG_SB_CPU_2_STATUS);
-
-	IWL_ERR(trans, "IML/ROM dump:\n");
-
-	if (error & 0xFFFF0000)
-		IWL_ERR(trans, "0x%04X | IML/ROM SYSASSERT\n", error >> 16);
-
-	IWL_ERR(mvm, "0x%08X | IML/ROM error/state\n", error);
-	IWL_ERR(mvm, "0x%08X | IML/ROM data1\n",
-		iwl_read_umac_prph(trans, data1));
-
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000)
-		IWL_ERR(mvm, "0x%08X | IML/ROM WFPM_AUTH_KEY_0\n",
-			iwl_read_umac_prph(trans, SB_MODIFY_CFG_FLAG));
-}
-
-void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
-{
-	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
-		IWL_ERR(mvm,
-			"DEVICE_ENABLED bit is not set. Aborting dump.\n");
-		return;
-	}
-
-	iwl_mvm_dump_lmac_error_log(mvm, 0);
-
-	if (mvm->trans->dbg.lmac_error_event_table[1])
-		iwl_mvm_dump_lmac_error_log(mvm, 1);
-
-	iwl_mvm_dump_umac_error_log(mvm);
-
-	iwl_mvm_dump_iml_error_log(mvm);
-
-	iwl_fw_error_print_fseq_regs(&mvm->fwrt);
-}
-
 int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
 			 int tid, int frame_limit, u16 ssn)
 {
-- 
2.32.0

