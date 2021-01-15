Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816AE2F772C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbhAOLGx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:06:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726534AbhAOLGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:06:53 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0Mve-003hBK-2B; Fri, 15 Jan 2021 13:06:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:50 +0200
Message-Id: <iwlwifi.20210115130252.85ef56c4ef8c.I3b853ce041a0755d45e448035bef1837995d191b@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115110558.1248847-1-luca@coelho.fi>
References: <20210115110558.1248847-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 04/12] iwlwifi: pnvm: don't skip everything when not reloading
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Even if we don't reload the file from disk, we still need to
trigger the PNVM load flow with the device; fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 6972592850c0 ("iwlwifi: read and parse PNVM file")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 50 ++++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 6d8f7bff1243..ebd1a09a2fb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -224,40 +224,40 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait)
 {
-	const struct firmware *pnvm;
 	struct iwl_notification_wait pnvm_wait;
 	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						PNVM_INIT_COMPLETE_NTFY) };
-	char pnvm_name[64];
-	int ret;
 
 	/* if the SKU_ID is empty, there's nothing to do */
 	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
 		return 0;
 
-	/* if we already have it, nothing to do either */
-	if (trans->pnvm_loaded)
-		return 0;
+	/* load from disk only if we haven't done it before */
+	if (!trans->pnvm_loaded) {
+		const struct firmware *pnvm;
+		char pnvm_name[64];
+		int ret;
+
+		/*
+		 * The prefix unfortunately includes a hyphen at the end, so
+		 * don't add the dot here...
+		 */
+		snprintf(pnvm_name, sizeof(pnvm_name), "%spnvm",
+			 trans->cfg->fw_name_pre);
+
+		/* ...but replace the hyphen with the dot here. */
+		if (strlen(trans->cfg->fw_name_pre) < sizeof(pnvm_name))
+			pnvm_name[strlen(trans->cfg->fw_name_pre) - 1] = '.';
+
+		ret = firmware_request_nowarn(&pnvm, pnvm_name, trans->dev);
+		if (ret) {
+			IWL_DEBUG_FW(trans, "PNVM file %s not found %d\n",
+				     pnvm_name, ret);
+		} else {
+			iwl_pnvm_parse(trans, pnvm->data, pnvm->size);
 
-	/*
-	 * The prefix unfortunately includes a hyphen at the end, so
-	 * don't add the dot here...
-	 */
-	snprintf(pnvm_name, sizeof(pnvm_name), "%spnvm",
-		 trans->cfg->fw_name_pre);
-
-	/* ...but replace the hyphen with the dot here. */
-	if (strlen(trans->cfg->fw_name_pre) < sizeof(pnvm_name))
-		pnvm_name[strlen(trans->cfg->fw_name_pre) - 1] = '.';
-
-	ret = firmware_request_nowarn(&pnvm, pnvm_name, trans->dev);
-	if (ret) {
-		IWL_DEBUG_FW(trans, "PNVM file %s not found %d\n",
-			     pnvm_name, ret);
-	} else {
-		iwl_pnvm_parse(trans, pnvm->data, pnvm->size);
-
-		release_firmware(pnvm);
+			release_firmware(pnvm);
+		}
 	}
 
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
-- 
2.29.2

