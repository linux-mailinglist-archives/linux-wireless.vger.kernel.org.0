Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348634FC61
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhCaJPl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:41 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43778 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234626AbhCaJPF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:15:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwG-00087q-Ku; Wed, 31 Mar 2021 12:15:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:49 +0300
Message-Id: <iwlwifi.20210331121101.deb71fce883a.I5eef009512f180e5974f3f491ff56c763cdcc878@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.5-pre1
Subject: [PATCH 09/12] iwlwifi: move iwl_configure_rxq to be used by other op_modes
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

All the op_modes need to send this command as well. Instead of
duplicating the code from mvm, put the code in a common place.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/init.c  | 59 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 61 +------------------
 3 files changed, 63 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index 986913f2fbd5..2ecec00db9da 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -10,6 +10,8 @@
 
 #include "fw/api/soc.h"
 #include "fw/api/commands.h"
+#include "fw/api/rx.h"
+#include "fw/api/datapath.h"
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 			const struct iwl_fw *fw,
@@ -95,3 +97,60 @@ int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt)
 	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_set_soc_latency);
+
+int iwl_configure_rxq(struct iwl_fw_runtime *fwrt)
+{
+	int i, num_queues, size, ret;
+	struct iwl_rfh_queue_config *cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DATA_PATH_GROUP, RFH_QUEUE_CONFIG_CMD),
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
+
+	/*
+	 * The default queue is configured via context info, so if we
+	 * have a single queue, there's nothing to do here.
+	 */
+	if (fwrt->trans->num_rx_queues == 1)
+		return 0;
+
+	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_22000)
+		return 0;
+
+	/* skip the default queue */
+	num_queues = fwrt->trans->num_rx_queues - 1;
+
+	size = struct_size(cmd, data, num_queues);
+
+	cmd = kzalloc(size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->num_queues = num_queues;
+
+	for (i = 0; i < num_queues; i++) {
+		struct iwl_trans_rxq_dma_data data;
+
+		cmd->data[i].q_num = i + 1;
+		iwl_trans_get_rxq_dma_data(fwrt->trans, i + 1, &data);
+
+		cmd->data[i].fr_bd_cb = cpu_to_le64(data.fr_bd_cb);
+		cmd->data[i].urbd_stts_wrptr =
+			cpu_to_le64(data.urbd_stts_wrptr);
+		cmd->data[i].ur_bd_cb = cpu_to_le64(data.ur_bd_cb);
+		cmd->data[i].fr_bd_wid = cpu_to_le32(data.fr_bd_wid);
+	}
+
+	hcmd.data[0] = cmd;
+	hcmd.len[0] = size;
+
+	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
+
+	kfree(cmd);
+
+	if (ret)
+		IWL_ERR(fwrt, "Failed to configure RX queues: %d\n", ret);
+
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_configure_rxq);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 0dba5444f2db..35af85a5430b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -190,5 +190,6 @@ void iwl_free_fw_paging(struct iwl_fw_runtime *fwrt);
 
 void iwl_get_shared_mem_conf(struct iwl_fw_runtime *fwrt);
 int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt);
+int iwl_configure_rxq(struct iwl_fw_runtime *fwrt);
 
 #endif /* __iwl_fw_runtime_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 4f297edd8e18..b8a25943a57d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -73,56 +73,6 @@ static int iwl_send_rss_cfg_cmd(struct iwl_mvm *mvm)
 	return iwl_mvm_send_cmd_pdu(mvm, RSS_CONFIG_CMD, 0, sizeof(cmd), &cmd);
 }
 
-static int iwl_configure_rxq(struct iwl_mvm *mvm)
-{
-	int i, num_queues, size, ret;
-	struct iwl_rfh_queue_config *cmd;
-	struct iwl_host_cmd hcmd = {
-		.id = WIDE_ID(DATA_PATH_GROUP, RFH_QUEUE_CONFIG_CMD),
-		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
-	};
-
-	/*
-	 * The default queue is configured via context info, so if we
-	 * have a single queue, there's nothing to do here.
-	 */
-	if (mvm->trans->num_rx_queues == 1)
-		return 0;
-
-	/* skip the default queue */
-	num_queues = mvm->trans->num_rx_queues - 1;
-
-	size = struct_size(cmd, data, num_queues);
-
-	cmd = kzalloc(size, GFP_KERNEL);
-	if (!cmd)
-		return -ENOMEM;
-
-	cmd->num_queues = num_queues;
-
-	for (i = 0; i < num_queues; i++) {
-		struct iwl_trans_rxq_dma_data data;
-
-		cmd->data[i].q_num = i + 1;
-		iwl_trans_get_rxq_dma_data(mvm->trans, i + 1, &data);
-
-		cmd->data[i].fr_bd_cb = cpu_to_le64(data.fr_bd_cb);
-		cmd->data[i].urbd_stts_wrptr =
-			cpu_to_le64(data.urbd_stts_wrptr);
-		cmd->data[i].ur_bd_cb = cpu_to_le64(data.ur_bd_cb);
-		cmd->data[i].fr_bd_wid = cpu_to_le32(data.fr_bd_wid);
-	}
-
-	hcmd.data[0] = cmd;
-	hcmd.len[0] = size;
-
-	ret = iwl_mvm_send_cmd(mvm, &hcmd);
-
-	kfree(cmd);
-
-	return ret;
-}
-
 static int iwl_mvm_send_dqa_cmd(struct iwl_mvm *mvm)
 {
 	struct iwl_dqa_enable_cmd dqa_cmd = {
@@ -1503,14 +1453,9 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	}
 
 	/* Init RSS configuration */
-	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
-		ret = iwl_configure_rxq(mvm);
-		if (ret) {
-			IWL_ERR(mvm, "Failed to configure RX queues: %d\n",
-				ret);
-			goto error;
-		}
-	}
+	ret = iwl_configure_rxq(&mvm->fwrt);
+	if (ret)
+		goto error;
 
 	if (iwl_mvm_has_new_rx_api(mvm)) {
 		ret = iwl_send_rss_cfg_cmd(mvm);
-- 
2.31.0

