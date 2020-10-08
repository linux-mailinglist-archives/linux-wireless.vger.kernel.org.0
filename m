Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8D2876C7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgJHPKB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:10:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54468 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730889AbgJHPJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:09:58 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYK-002Qut-7e; Thu, 08 Oct 2020 18:09:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:40 +0300
Message-Id: <iwlwifi.20201008180656.a10e8b6bbcf9.Ib5d10b3d508a4d2d4e6b7b629af89d76f4f03d81@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008150949.331882-1-luca@coelho.fi>
References: <20201008150949.331882-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/13] iwlwifi: mvm: ring the doorbell and wait for PNVM load completion
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

When we receive a non-zero SKU_ID in the alive notification, we need
to ring the doorbell and wait for the FW to send us a PNVM load
complete notification before we continue the init phase.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 13 +++++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 51 +++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index b6c31f01ea9e..55573168444e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -90,6 +90,11 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	 * @TAS_CONFIG: &struct iwl_tas_config_cmd
 	 */
 	TAS_CONFIG = 0x3,
+
+	/**
+	 * @PNVM_INIT_COMPLETE_NTFY: &struct iwl_pnvm_init_complete_ntfy
+	 */
+	PNVM_INIT_COMPLETE_NTFY = 0xFE,
 };
 
 /**
@@ -476,4 +481,12 @@ struct iwl_lari_config_change_cmd {
 	__le32 config_bitmap;
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_1 */
 
+/**
+ * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
+ * @status: PNVM image loading status
+ */
+struct iwl_pnvm_init_complete_ntfy {
+	__le32 status;
+} __packed; /* PNVM_INIT_COMPLETE_NTFY_S_VER_1 */
+
 #endif /* __iwl_fw_api_nvm_reg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 8e254c0eda13..fa3f15778fc7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -460,6 +460,7 @@ enum {
 #define UREG_DOORBELL_TO_ISR6_NMI_BIT	BIT(0)
 #define UREG_DOORBELL_TO_ISR6_SUSPEND	BIT(18)
 #define UREG_DOORBELL_TO_ISR6_RESUME	BIT(19)
+#define UREG_DOORBELL_TO_ISR6_PNVM	BIT(20)
 
 #define FSEQ_ERROR_CODE			0xA340C8
 #define FSEQ_TOP_INIT_VERSION		0xA34038
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index fda86c582049..a8a10f84f45d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -79,6 +79,7 @@
 
 #define MVM_UCODE_ALIVE_TIMEOUT	HZ
 #define MVM_UCODE_CALIB_TIMEOUT	(2*HZ)
+#define MVM_UCODE_PNVM_TIMEOUT	(HZ / 10)
 
 #define UCODE_VALID_OK	cpu_to_le32(0x1)
 
@@ -305,6 +306,20 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	return true;
 }
 
+static bool iwl_pnvm_complete_fn(struct iwl_notif_wait_data *notif_wait,
+				 struct iwl_rx_packet *pkt, void *data)
+{
+	struct iwl_mvm *mvm =
+		container_of(notif_wait, struct iwl_mvm, notif_wait);
+	struct iwl_pnvm_init_complete_ntfy *pnvm_ntf = (void *)pkt->data;
+
+	IWL_DEBUG_FW(mvm,
+		     "PNVM complete notification received with status %d\n",
+		     le32_to_cpu(pnvm_ntf->status));
+
+	return true;
+}
+
 static bool iwl_wait_init_complete(struct iwl_notif_wait_data *notif_wait,
 				   struct iwl_rx_packet *pkt, void *data)
 {
@@ -328,6 +343,35 @@ static bool iwl_wait_phy_db_entry(struct iwl_notif_wait_data *notif_wait,
 	return false;
 }
 
+static int iwl_mvm_load_pnvm(struct iwl_mvm *mvm)
+{
+	struct iwl_notification_wait pnvm_wait;
+	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						PNVM_INIT_COMPLETE_NTFY) };
+
+	/* if the SKU_ID is empty, there's nothing to do */
+	if (!mvm->trans->sku_id[0] &&
+	    !mvm->trans->sku_id[1] &&
+	    !mvm->trans->sku_id[2])
+		return 0;
+
+	/*
+	 * TODO: phase 2: load the pnvm file, find the right section,
+	 * load it and set the right DMA pointer.
+	 */
+
+	iwl_init_notification_wait(&mvm->notif_wait, &pnvm_wait,
+				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
+				   iwl_pnvm_complete_fn, NULL);
+
+	/* kick the doorbell */
+	iwl_write_umac_prph(mvm->trans, UREG_DOORBELL_TO_ISR6,
+			    UREG_DOORBELL_TO_ISR6_PNVM);
+
+	return iwl_wait_notification(&mvm->notif_wait, &pnvm_wait,
+				     MVM_UCODE_PNVM_TIMEOUT);
+}
+
 static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 					 enum iwl_ucode_type ucode_type)
 {
@@ -416,6 +460,13 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 		return -EIO;
 	}
 
+	ret = iwl_mvm_load_pnvm(mvm);
+	if (ret) {
+		IWL_ERR(mvm, "Timeout waiting for PNVM load!\n");
+		iwl_fw_set_current_image(&mvm->fwrt, old_type);
+		return ret;
+	}
+
 	iwl_trans_fw_alive(mvm->trans, alive_data.scd_base_addr);
 
 	/*
-- 
2.28.0

