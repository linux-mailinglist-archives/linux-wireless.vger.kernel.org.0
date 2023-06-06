Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A457723A7A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjFFHvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjFFHtB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:49:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104901BC7
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037488; x=1717573488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kyRpmBiiMWrkwLuMS6i7Hnzk7BoASTnPXaE/Vmi195M=;
  b=mHE8ZEjw8nJU8U/hyqw5ccuEM2t2Gucd9YOAnUBJ1j2/66N/TH3lmobr
   +xiUIoSwdmH28seJR5G5z+KO5ZWhEr2fKa+dkAbwv3XQ3XTt9pNHLwj9+
   8mDzX9Lf1cCxHPtY5s3I8gcJmiRJhfTEEpuE6KURmIqANrpeO3hAbWgCz
   GR35DSnlATyyvmTPlro1hhJeBms/uywfGU7Kpu6z790rbd/vWL2MR/4MA
   ZkQeLE4tRolgbErBvv2ysDvThfFeolhWDIYDJdINZHoDMO5xyzRRD4NaD
   F0G+VfIxrKoWgjKukZlXPP7f9x2UpFWUYej5OqQwMMjxjvHfEJHDfuzET
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419085"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419085"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516324"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516324"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/13] wifi: iwlwifi: Separate loading and setting of power reduce tables
Date:   Tue,  6 Jun 2023 10:43:04 +0300
Message-Id: <20230606103519.7695684dc848.I13626cd318e5d68efec9618b2045f52788bff114@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230606074310.889520-1-gregory.greenman@intel.com>
References: <20230606074310.889520-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

Take the part that copies the tables into DRAM, out of the method
that sets the prph_scratch to make the code cleaner. Each of the
operations will get more complex in the future when it will also
support larger power-reduce tables images.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  9 ++++--
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  5 ++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 28 +++++++++++--------
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 18 +++++++++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 +
 5 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 91e1faef76f6..bb6300469f4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -329,14 +329,17 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 			 */
 			trans->reduce_power_loaded = true;
 		} else {
-			ret = iwl_trans_set_reduce_power(trans, data, length);
-			if (ret)
+			ret = iwl_trans_load_reduce_power(trans, data, length);
+			if (ret) {
 				IWL_DEBUG_FW(trans,
-					     "Failed to set reduce power table %d\n",
+					     "Failed to load reduce power table %d\n",
 					     ret);
+				trans->reduce_power_loaded = true;
+			}
 			kfree(data);
 		}
 	}
+	iwl_trans_set_reduce_power(trans);
 
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index bbf4b18cd9de..e019aec027d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -292,8 +292,9 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 					   const struct iwl_ucode_capabilities *capa);
 void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 					   const struct iwl_ucode_capabilities *capa);
-int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
-						  const void *data, u32 len);
+int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
+						   const void *data, u32 len);
+void iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans);
 int iwl_trans_pcie_ctx_info_gen3_set_step(struct iwl_trans *trans,
 					  u32 mbx_addr_0_step, u32 mbx_addr_1_step);
 #endif /* __iwl_context_info_file_gen3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 541841bc8f21..888869d9c94a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -562,6 +562,8 @@ struct iwl_pnvm_image {
  * @load_pnvm: save the pnvm data in DRAM
  * @set_pnvm: set the pnvm data in the prph scratch buffer, inside the
  *	context info.
+ * @load_reduce_power: copy reduce power table to the corresponding DRAM memory
+ * @set_reduce_power: set reduce power table addresses in the sratch buffer
  * @interrupts: disable/enable interrupts to transport
  */
 struct iwl_trans_ops {
@@ -638,8 +640,11 @@ struct iwl_trans_ops {
 			 const struct iwl_ucode_capabilities *capa);
 	void (*set_pnvm)(struct iwl_trans *trans,
 			 const struct iwl_ucode_capabilities *capa);
-	int (*set_reduce_power)(struct iwl_trans *trans,
-				const void *data, u32 len);
+	int (*load_reduce_power)(struct iwl_trans *trans,
+				 const void *data,
+				 u32 len);
+	void (*set_reduce_power)(struct iwl_trans *trans);
+
 	void (*interrupts)(struct iwl_trans *trans, bool enable);
 	int (*imr_dma_data)(struct iwl_trans *trans,
 			    u32 dst_addr, u64 src_addr,
@@ -1554,18 +1559,17 @@ static inline void iwl_trans_set_pnvm(struct iwl_trans *trans,
 		trans->ops->set_pnvm(trans, capa);
 }
 
-static inline int iwl_trans_set_reduce_power(struct iwl_trans *trans,
-					     const void *data, u32 len)
+static inline int iwl_trans_load_reduce_power(struct iwl_trans *trans,
+					      const void *data,
+					      u32 len)
 {
-	if (trans->ops->set_reduce_power) {
-		int ret = trans->ops->set_reduce_power(trans, data, len);
-
-		if (ret)
-			return ret;
-	}
+	return trans->ops->load_reduce_power(trans, data, len);
+}
 
-	trans->reduce_power_loaded = true;
-	return 0;
+static inline void iwl_trans_set_reduce_power(struct iwl_trans *trans)
+{
+	if (trans->ops->set_reduce_power)
+		trans->ops->set_reduce_power(trans);
 }
 
 static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index e0477ca4ccc3..2619c868b51f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -442,8 +442,9 @@ void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 		iwl_pcie_set_continuous_pnvm(trans);
 }
 
-int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
-						  const void *data, u32 len)
+int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
+						   const void *data,
+						   u32 len)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
@@ -467,12 +468,21 @@ int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 			return ret;
 		}
 	}
+	return 0;
+}
+
+void iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
+		&trans_pcie->prph_scratch->ctrl_cfg;
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return;
 
 	prph_sc_ctrl->reduce_power_cfg.base_addr =
 		cpu_to_le64(trans_pcie->reduce_power_dram.physical);
 	prph_sc_ctrl->reduce_power_cfg.size =
 		cpu_to_le32(trans_pcie->reduce_power_dram.size);
-
-	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 5235a7517c53..55541c1be5d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3554,6 +3554,7 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	.rxq_dma_data = iwl_trans_pcie_rxq_dma_data,
 	.load_pnvm = iwl_trans_pcie_ctx_info_gen3_load_pnvm,
 	.set_pnvm = iwl_trans_pcie_ctx_info_gen3_set_pnvm,
+	.load_reduce_power = iwl_trans_pcie_ctx_info_gen3_load_reduce_power,
 	.set_reduce_power = iwl_trans_pcie_ctx_info_gen3_set_reduce_power,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	.debugfs_cleanup = iwl_trans_pcie_debugfs_cleanup,
-- 
2.38.1

