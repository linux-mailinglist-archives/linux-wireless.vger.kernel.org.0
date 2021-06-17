Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09153AAD0B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFQHLF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:11:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47870 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230075AbhFQHLE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm8z-001XeC-VC; Thu, 17 Jun 2021 10:08:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:41 +0300
Message-Id: <iwlwifi.20210617100544.cd1ef97b2c04.Iad42a59902a87a50b45b9ce88705863686a83b54@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617070852.496985-1-luca@coelho.fi>
References: <20210617070852.496985-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/12] iwlwifi: pcie: identify the RF module
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Identify and print out the RF module to be able to identify
(from logs and through debugfs) which one (and version) is
present on the system.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  4 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  5 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 71 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 18 +++++
 4 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 3ce77e4eb7e3..9a9e714bf9af 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -412,6 +412,8 @@ enum {
 #define UREG_DOORBELL_TO_ISR6_RESUME	BIT(19)
 #define UREG_DOORBELL_TO_ISR6_PNVM	BIT(20)
 
+#define CNVI_MBOX_C			0xA3400C
+
 #define FSEQ_ERROR_CODE			0xA340C8
 #define FSEQ_TOP_INIT_VERSION		0xA34038
 #define FSEQ_CNVIO_INIT_VERSION		0xA3403C
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 76a512cd2e5c..907781714680 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2020 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -317,6 +317,7 @@ struct cont_rec {
  * @alloc_page_lock: spinlock for the page allocator
  * @alloc_page: allocated page to still use parts of
  * @alloc_page_used: how much of the allocated page was already used (bytes)
+ * @rf_name: name/version of the CRF, if any
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
@@ -409,6 +410,8 @@ struct iwl_trans_pcie {
 	bool fw_reset_handshake;
 	bool fw_reset_done;
 	wait_queue_head_t fw_reset_waitq;
+
+	char rf_name[32];
 };
 
 static inline struct iwl_trans_pcie *
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 1bcd36e9e008..56162c4500d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -240,6 +240,75 @@ static int iwl_pcie_gen2_nic_init(struct iwl_trans *trans)
 	return 0;
 }
 
+static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	char *buf = trans_pcie->rf_name;
+	size_t buflen = sizeof(trans_pcie->rf_name);
+	size_t pos;
+	u32 version;
+
+	if (buf[0])
+		return;
+
+	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF):
+		pos = scnprintf(buf, buflen, "JF");
+		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_GF):
+		pos = scnprintf(buf, buflen, "GF");
+		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_GF4):
+		pos = scnprintf(buf, buflen, "GF4");
+		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HR):
+		pos = scnprintf(buf, buflen, "HR");
+		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HR1):
+		pos = scnprintf(buf, buflen, "HR1");
+		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HRCDB):
+		pos = scnprintf(buf, buflen, "HRCDB");
+		break;
+	default:
+		return;
+	}
+
+	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HR):
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HR1):
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_HRCDB):
+		version = iwl_read_prph(trans, CNVI_MBOX_C);
+		switch (version) {
+		case 0x20000:
+			pos += scnprintf(buf + pos, buflen - pos, " B3");
+			break;
+		case 0x120000:
+			pos += scnprintf(buf + pos, buflen - pos, " B5");
+			break;
+		default:
+			pos += scnprintf(buf + pos, buflen - pos,
+					 " (0x%x)", version);
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	pos += scnprintf(buf + pos, buflen - pos, ", rfid=0x%x",
+			 trans->hw_rf_id);
+
+	IWL_INFO(trans, "Detected RF %s\n", buf);
+
+	/*
+	 * also add a \n for debugfs - need to do it after printing
+	 * since our IWL_INFO machinery wants to see a static \n at
+	 * the end of the string
+	 */
+	pos += scnprintf(buf + pos, buflen - pos, "\n");
+}
+
 void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -263,6 +332,8 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	iwl_enable_interrupts(trans);
 	mutex_lock(&trans_pcie->mutex);
 	iwl_pcie_check_hw_rf_kill(trans);
+
+	iwl_pcie_get_rf_name(trans);
 	mutex_unlock(&trans_pcie->mutex);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 7417df7669d6..a4d6988b50a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2860,11 +2860,28 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 	return bytes_copied;
 }
 
+static ssize_t iwl_dbgfs_rf_read(struct file *file,
+				 char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (!trans_pcie->rf_name[0])
+		return -ENODEV;
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       trans_pcie->rf_name,
+				       strlen(trans_pcie->rf_name));
+}
+
 DEBUGFS_READ_WRITE_FILE_OPS(interrupt);
 DEBUGFS_READ_FILE_OPS(fh_reg);
 DEBUGFS_READ_FILE_OPS(rx_queue);
 DEBUGFS_WRITE_FILE_OPS(csr);
 DEBUGFS_READ_WRITE_FILE_OPS(rfkill);
+DEBUGFS_READ_FILE_OPS(rf);
+
 static const struct file_operations iwl_dbgfs_tx_queue_ops = {
 	.owner = THIS_MODULE,
 	.open = iwl_dbgfs_tx_queue_open,
@@ -2891,6 +2908,7 @@ void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans)
 	DEBUGFS_ADD_FILE(fh_reg, dir, 0400);
 	DEBUGFS_ADD_FILE(rfkill, dir, 0600);
 	DEBUGFS_ADD_FILE(monitor_data, dir, 0400);
+	DEBUGFS_ADD_FILE(rf, dir, 0400);
 }
 
 static void iwl_trans_pcie_debugfs_cleanup(struct iwl_trans *trans)
-- 
2.32.0

