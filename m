Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C2D130EF7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAFIzQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:16 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51386 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbgAFIzP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:15 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAL-0007qa-16; Mon, 06 Jan 2020 10:55:13 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:56 +0200
Message-Id: <20200106085502.363205-7-luca@coelho.fi>
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
Subject: [PATCH 06/12] iwlwifi: yoyo: check for the domain on all TLV types during init
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Now that we don't have dynamically changing domains anymore, we can
simply skip all the TLVs with domains that are not enabled.  To do so,
remove the checks from the functions that handle the TLVs when a
timepoint is reached to the top allocation function.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 22 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  2 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 ++
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 1b4bca717e79..f8c6ed823bc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -69,7 +69,7 @@
 #include "iwl-eeprom-parse.h"
 #include "fw/acpi.h"
 
-#define IWL_FW_DBG_DOMAIN		IWL_FW_INI_DOMAIN_ALWAYS_ON
+#define IWL_FW_DBG_DOMAIN		IWL_TRANS_FW_DBG_DOMAIN(fwrt->trans)
 
 struct iwl_fw_runtime_ops {
 	int (*dump_start)(void *ctx);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 31a0e885faf6..eaf64ca3a134 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -290,10 +290,19 @@ void iwl_dbg_tlv_alloc(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 	struct iwl_fw_ini_header *hdr = (void *)&tlv->data[0];
 	u32 type = le32_to_cpu(tlv->type);
 	u32 tlv_idx = type - IWL_UCODE_TLV_DEBUG_BASE;
+	u32 domain = le32_to_cpu(hdr->domain);
 	enum iwl_ini_cfg_state *cfg_state = ext ?
 		&trans->dbg.external_ini_cfg : &trans->dbg.internal_ini_cfg;
 	int ret;
 
+	if (domain != IWL_FW_INI_DOMAIN_ALWAYS_ON &&
+	    !(domain & trans->dbg.domains_bitmap)) {
+		IWL_DEBUG_FW(trans,
+			     "WRT: Skipping TLV with disabled domain 0x%0x (0x%0x)\n",
+			     domain, trans->dbg.domains_bitmap);
+		return;
+	}
+
 	if (tlv_idx >= ARRAY_SIZE(dbg_tlv_alloc) || !dbg_tlv_alloc[tlv_idx]) {
 		IWL_ERR(trans, "WRT: Unsupported TLV type 0x%x\n", type);
 		goto out_err;
@@ -660,7 +669,6 @@ static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
 	list_for_each_entry(node, hcmd_list, list) {
 		struct iwl_fw_ini_hcmd_tlv *hcmd = (void *)node->tlv.data;
 		struct iwl_fw_ini_hcmd *hcmd_data = &hcmd->hcmd;
-		u32 domain = le32_to_cpu(hcmd->hdr.domain);
 		u16 hcmd_len = le32_to_cpu(node->tlv.length) - sizeof(*hcmd);
 		struct iwl_host_cmd cmd = {
 			.id = WIDE_ID(hcmd_data->group, hcmd_data->id),
@@ -668,10 +676,6 @@ static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
 			.data = { hcmd_data->data, },
 		};
 
-		if (domain != IWL_FW_INI_DOMAIN_ALWAYS_ON &&
-		    !(domain & fwrt->trans->dbg.domains_bitmap))
-			continue;
-
 		iwl_trans_send_cmd(fwrt->trans, &cmd);
 	}
 }
@@ -897,12 +901,6 @@ iwl_dbg_tlv_gen_active_trig_list(struct iwl_fw_runtime *fwrt,
 
 	list_for_each_entry(node, trig_list, list) {
 		struct iwl_ucode_tlv *tlv = &node->tlv;
-		struct iwl_fw_ini_trigger_tlv *trig = (void *)tlv->data;
-		u32 domain = le32_to_cpu(trig->hdr.domain);
-
-		if (domain != IWL_FW_INI_DOMAIN_ALWAYS_ON &&
-		    !(domain & fwrt->trans->dbg.domains_bitmap))
-			continue;
 
 		iwl_dbg_tlv_add_active_trigger(fwrt, active_trig_list, tlv);
 	}
@@ -981,8 +979,6 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 	enum iwl_fw_ini_buffer_location *ini_dest = &fwrt->trans->dbg.ini_dest;
 	int ret, i;
 
-	fwrt->trans->dbg.domains_bitmap = IWL_FW_DBG_DOMAIN;
-
 	IWL_DEBUG_FW(fwrt,
 		     "WRT: Generating active triggers list, domain 0x%x\n",
 		     fwrt->trans->dbg.domains_bitmap);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4096ccf58b07..c6cb5e1a1bd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1647,6 +1647,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 	drv->trans->dbgfs_dir = debugfs_create_dir("trans", drv->dbgfs_drv);
 #endif
 
+	drv->trans->dbg.domains_bitmap = IWL_TRANS_FW_DBG_DOMAIN(drv->trans);
+
 	ret = iwl_request_firmware(drv, true);
 	if (ret) {
 		IWL_ERR(trans, "Couldn't request the fw\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 872cda2be0f6..58bee4442e20 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -112,6 +112,8 @@
  *	6) Eventually, the free function will be called.
  */
 
+#define IWL_TRANS_FW_DBG_DOMAIN(trans)	IWL_FW_INI_DOMAIN_ALWAYS_ON
+
 #define FH_RSCSR_FRAME_SIZE_MSK		0x00003FFF	/* bits 0-13 */
 #define FH_RSCSR_FRAME_INVALID		0x55550000
 #define FH_RSCSR_FRAME_ALIGN		0x40
-- 
2.24.1

