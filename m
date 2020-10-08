Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8812876E2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgJHPNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:13:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54618 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730943AbgJHPND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:13:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbH-002QxQ-Sm; Thu, 08 Oct 2020 18:13:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:46 +0300
Message-Id: <iwlwifi.20201008181047.232aa310693b.I03a18ffa4162753af38e759d88e27509007c7bca@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008151250.332346-1-luca@coelho.fi>
References: <20201008151250.332346-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/13] iwlwifi: move PNVM implementation to common code
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The PNVM code is generic and can be used by other opmodes.  Move it to
a common file and include it in the relevant opmodes.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile  |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 55 ++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h | 18 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 51 ++----------------
 4 files changed, 78 insertions(+), 48 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 85c6fed28f8e..14b0db28143b 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -16,7 +16,7 @@ iwlwifi-objs		+= iwl-trans.o
 iwlwifi-objs		+= queue/tx.o
 
 iwlwifi-objs		+= fw/img.o fw/notif-wait.o
-iwlwifi-objs		+= fw/dbg.o
+iwlwifi-objs		+= fw/dbg.o fw/pnvm.o
 iwlwifi-$(CONFIG_IWLMVM) += fw/paging.o fw/smem.o fw/init.o
 iwlwifi-$(CONFIG_ACPI) += fw/acpi.o
 iwlwifi-$(CONFIG_IWLWIFI_DEBUGFS) += fw/debugfs.o
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
new file mode 100644
index 000000000000..f6108fda8915
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/******************************************************************************
+ *
+ * Copyright(c) 2020 Intel Corporation
+ *
+ *****************************************************************************/
+
+#include "iwl-drv.h"
+#include "pnvm.h"
+#include "iwl-prph.h"
+#include "iwl-io.h"
+#include "fw/api/commands.h"
+#include "fw/api/nvm-reg.h"
+
+static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
+				 struct iwl_rx_packet *pkt, void *data)
+{
+	struct iwl_trans *trans = (struct iwl_trans *)data;
+	struct iwl_pnvm_init_complete_ntfy *pnvm_ntf = (void *)pkt->data;
+
+	IWL_DEBUG_FW(trans,
+		     "PNVM complete notification received with status %d\n",
+		     le32_to_cpu(pnvm_ntf->status));
+
+	return true;
+}
+
+int iwl_pnvm_load(struct iwl_trans *trans,
+		  struct iwl_notif_wait_data *notif_wait)
+{
+	struct iwl_notification_wait pnvm_wait;
+	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						PNVM_INIT_COMPLETE_NTFY) };
+
+	/* if the SKU_ID is empty, there's nothing to do */
+	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
+		return 0;
+
+	/*
+	 * TODO: phase 2: load the pnvm file, find the right section,
+	 * load it and set the right DMA pointer.
+	 */
+
+	iwl_init_notification_wait(notif_wait, &pnvm_wait,
+				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
+				   iwl_pnvm_complete_fn, trans);
+
+	/* kick the doorbell */
+	iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
+			    UREG_DOORBELL_TO_ISR6_PNVM);
+
+	return iwl_wait_notification(notif_wait, &pnvm_wait,
+				     MVM_UCODE_PNVM_TIMEOUT);
+}
+IWL_EXPORT_SYMBOL(iwl_pnvm_load);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
new file mode 100644
index 000000000000..e4f91bce222d
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/******************************************************************************
+ *
+ * Copyright(c) 2020 Intel Corporation
+ *
+ *****************************************************************************/
+
+#ifndef __IWL_PNVM_H__
+#define __IWL_PNVM_H__
+
+#include "fw/notif-wait.h"
+
+#define MVM_UCODE_PNVM_TIMEOUT	(HZ / 10)
+
+int iwl_pnvm_load(struct iwl_trans *trans,
+		  struct iwl_notif_wait_data *notif_wait);
+
+#endif /* __IWL_PNVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 9bce25a15df6..6385b9641126 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -70,6 +70,7 @@
 #include "iwl-io.h" /* for iwl_mvm_rx_card_state_notif */
 #include "iwl-prph.h"
 #include "fw/acpi.h"
+#include "fw/pnvm.h"
 
 #include "mvm.h"
 #include "fw/dbg.h"
@@ -77,9 +78,8 @@
 #include "iwl-modparams.h"
 #include "iwl-nvm-parse.h"
 
-#define MVM_UCODE_ALIVE_TIMEOUT	HZ
-#define MVM_UCODE_CALIB_TIMEOUT	(2*HZ)
-#define MVM_UCODE_PNVM_TIMEOUT	(HZ / 10)
+#define MVM_UCODE_ALIVE_TIMEOUT	(HZ)
+#define MVM_UCODE_CALIB_TIMEOUT	(2 * HZ)
 
 #define UCODE_VALID_OK	cpu_to_le32(0x1)
 
@@ -313,20 +313,6 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	return true;
 }
 
-static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
-				 struct iwl_rx_packet *pkt, void *data)
-{
-	struct iwl_mvm *mvm =
-		container_of(notif_wait, struct iwl_mvm, notif_wait);
-	struct iwl_pnvm_init_complete_ntfy *pnvm_ntf = (void *)pkt->data;
-
-	IWL_DEBUG_FW(mvm,
-		     "PNVM complete notification received with status %d\n",
-		     le32_to_cpu(pnvm_ntf->status));
-
-	return true;
-}
-
 static bool iwl_wait_init_complete(struct iwl_notif_wait_data *notif_wait,
 				   struct iwl_rx_packet *pkt, void *data)
 {
@@ -350,35 +336,6 @@ static bool iwl_wait_phy_db_entry(struct iwl_notif_wait_data *notif_wait,
 	return false;
 }
 
-static int iwl_mvm_load_pnvm(struct iwl_mvm *mvm)
-{
-	struct iwl_notification_wait pnvm_wait;
-	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						PNVM_INIT_COMPLETE_NTFY) };
-
-	/* if the SKU_ID is empty, there's nothing to do */
-	if (!mvm->trans->sku_id[0] &&
-	    !mvm->trans->sku_id[1] &&
-	    !mvm->trans->sku_id[2])
-		return 0;
-
-	/*
-	 * TODO: phase 2: load the pnvm file, find the right section,
-	 * load it and set the right DMA pointer.
-	 */
-
-	iwl_init_notification_wait(&mvm->notif_wait, &pnvm_wait,
-				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
-				   iwl_pnvm_complete_fn, NULL);
-
-	/* kick the doorbell */
-	iwl_write_umac_prph(mvm->trans, UREG_DOORBELL_TO_ISR6,
-			    UREG_DOORBELL_TO_ISR6_PNVM);
-
-	return iwl_wait_notification(&mvm->notif_wait, &pnvm_wait,
-				     MVM_UCODE_PNVM_TIMEOUT);
-}
-
 static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 					 enum iwl_ucode_type ucode_type)
 {
@@ -467,7 +424,7 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 		return -EIO;
 	}
 
-	ret = iwl_mvm_load_pnvm(mvm);
+	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait);
 	if (ret) {
 		IWL_ERR(mvm, "Timeout waiting for PNVM load!\n");
 		iwl_fw_set_current_image(&mvm->fwrt, old_type);
-- 
2.28.0

