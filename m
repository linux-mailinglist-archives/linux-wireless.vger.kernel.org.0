Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E13130EF4
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAFIzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:13 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51364 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbgAFIzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:13 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAI-0007qa-SP; Mon, 06 Jan 2020 10:55:11 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:53 +0200
Message-Id: <20200106085502.363205-4-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 03/12] iwlwifi: yoyo: remove unnecessary active triggers status flag
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Now that we can't change the domain at runtime anymore, we don't have
to protect the active trigger status.  Remove it.  Additionally, we
don't need to flush the dumps at this point anymore, since this only
runs during initialization and there shouldn't be any dumps running.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c      |  3 ---
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h  | 11 -----------
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c | 14 +-------------
 3 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index c8bc6b9b53a4..09daf0f1f6f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2353,9 +2353,6 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	u32 occur, delay;
 	unsigned long idx;
 
-	if (test_bit(STATUS_GEN_ACTIVE_TRIGS, &fwrt->status))
-		return -EBUSY;
-
 	if (!iwl_fw_ini_trigger_on(fwrt, trig)) {
 		IWL_WARN(fwrt, "WRT: Trigger %d is not active, aborting dump\n",
 			 tp_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index c24575ff0e54..1b4bca717e79 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -129,14 +129,6 @@ struct iwl_txf_iter_data {
 	u8 internal_txf;
 };
 
-/**
- * enum iwl_fw_runtime_status - fw runtime status flags
- * @STATUS_GEN_ACTIVE_TRIGS: generating active trigger list
- */
-enum iwl_fw_runtime_status {
-	STATUS_GEN_ACTIVE_TRIGS,
-};
-
 /**
  * struct iwl_fw_runtime - runtime data for firmware
  * @fw: firmware image
@@ -150,7 +142,6 @@ enum iwl_fw_runtime_status {
  * @smem_cfg: saved firmware SMEM configuration
  * @cur_fw_img: current firmware image, must be maintained by
  *	the driver by calling &iwl_fw_set_current_image()
- * @status: &enum iwl_fw_runtime_status
  * @dump: debug dump data
  */
 struct iwl_fw_runtime {
@@ -171,8 +162,6 @@ struct iwl_fw_runtime {
 	/* memory configuration */
 	struct iwl_fwrt_shared_mem_cfg smem_cfg;
 
-	unsigned long status;
-
 	/* debug */
 	struct {
 		const struct iwl_fw_dump_desc *desc;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 79c8c8057c2d..4acb24f8fc11 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -891,15 +891,10 @@ static void
 iwl_dbg_tlv_gen_active_trig_list(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dbg_tlv_time_point_data *tp)
 {
-	struct iwl_dbg_tlv_node *node, *tmp;
+	struct iwl_dbg_tlv_node *node;
 	struct list_head *trig_list = &tp->trig_list;
 	struct list_head *active_trig_list = &tp->active_trig_list;
 
-	list_for_each_entry_safe(node, tmp, active_trig_list, list) {
-		list_del(&node->list);
-		kfree(node);
-	}
-
 	list_for_each_entry(node, trig_list, list) {
 		struct iwl_ucode_tlv *tlv = &node->tlv;
 		struct iwl_fw_ini_trigger_tlv *trig = (void *)tlv->data;
@@ -918,11 +913,6 @@ static int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt,
 {
 	int i;
 
-	if (test_and_set_bit(STATUS_GEN_ACTIVE_TRIGS, &fwrt->status))
-		return -EBUSY;
-
-	iwl_fw_flush_dumps(fwrt);
-
 	fwrt->trans->dbg.domains_bitmap = new_domain;
 
 	IWL_DEBUG_FW(fwrt,
@@ -936,8 +926,6 @@ static int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt,
 		iwl_dbg_tlv_gen_active_trig_list(fwrt, tp);
 	}
 
-	clear_bit(STATUS_GEN_ACTIVE_TRIGS, &fwrt->status);
-
 	return 0;
 }
 
-- 
2.24.1

