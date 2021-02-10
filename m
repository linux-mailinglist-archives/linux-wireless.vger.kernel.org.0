Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5F316A10
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhBJPZC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:25:02 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45366 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231759AbhBJPYy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:24:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rLU-0049nr-13; Wed, 10 Feb 2021 17:24:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:23:53 +0200
Message-Id: <iwlwifi.20210210172142.072aa2e8bbc5.Ib351ee5da47a4cee60d44e66d32d2f6bba6f3150@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210152355.419776-1-luca@coelho.fi>
References: <20210210152355.419776-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 6/8] iwlwifi: pnvm: move file loading code to a separate function
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In preparation to support loading the PNVM from UEFI, move the
function that loads the PNVM from the filesystem to a separate
function.  This will make it easier to try to load from both places
later on.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 98 ++++++++++++--------
 1 file changed, 61 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 37ce4fe136c5..d515af8c1686 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
-/******************************************************************************
- *
- * Copyright(c) 2020 Intel Corporation
- *
- *****************************************************************************/
+/*
+ * Copyright(c) 2020-2021 Intel Corporation
+ */
 
 #include "iwl-drv.h"
 #include "pnvm.h"
@@ -221,9 +219,44 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 	return -ENOENT;
 }
 
+static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
+{
+	const struct firmware *pnvm;
+	char pnvm_name[64];
+	int ret;
+
+	/*
+	 * The prefix unfortunately includes a hyphen at the end, so
+	 * don't add the dot here...
+	 */
+	snprintf(pnvm_name, sizeof(pnvm_name), "%spnvm",
+		 trans->cfg->fw_name_pre);
+
+	/* ...but replace the hyphen with the dot here. */
+	if (strlen(trans->cfg->fw_name_pre) < sizeof(pnvm_name))
+		pnvm_name[strlen(trans->cfg->fw_name_pre) - 1] = '.';
+
+	ret = firmware_request_nowarn(&pnvm, pnvm_name, trans->dev);
+	if (ret) {
+		IWL_DEBUG_FW(trans, "PNVM file %s not found %d\n",
+			     pnvm_name, ret);
+		return ret;
+	}
+
+	*data = kmemdup(pnvm->data, pnvm->size, GFP_KERNEL);
+	if (!*data)
+		return -ENOMEM;
+
+	*len = pnvm->size;
+
+	return 0;
+}
+
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait)
 {
+	u8 *data;
+	size_t len;
 	struct iwl_notification_wait pnvm_wait;
 	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						PNVM_INIT_COMPLETE_NTFY) };
@@ -233,44 +266,35 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
 		return 0;
 
-	/* load from disk only if we haven't done it (or tried) before */
-	if (!trans->pnvm_loaded) {
-		const struct firmware *pnvm;
-		char pnvm_name[64];
+	/*
+	 * If we already loaded (or tried to load) it before, we just
+	 * need to set it again.
+	 */
+	if (trans->pnvm_loaded) {
+		ret = iwl_trans_set_pnvm(trans, NULL, 0);
+		if (ret)
+			return ret;
+		goto skip_parse;
+	}
 
+	/* Try to load the PNVM from the filesystem */
+	ret = iwl_pnvm_get_from_fs(trans, &data, &len);
+	if (ret) {
 		/*
-		 * The prefix unfortunately includes a hyphen at the end, so
-		 * don't add the dot here...
+		 * Pretend we've loaded it - at least we've tried and
+		 * couldn't load it at all, so there's no point in
+		 * trying again over and over.
 		 */
-		snprintf(pnvm_name, sizeof(pnvm_name), "%spnvm",
-			 trans->cfg->fw_name_pre);
-
-		/* ...but replace the hyphen with the dot here. */
-		if (strlen(trans->cfg->fw_name_pre) < sizeof(pnvm_name))
-			pnvm_name[strlen(trans->cfg->fw_name_pre) - 1] = '.';
-
-		ret = firmware_request_nowarn(&pnvm, pnvm_name, trans->dev);
-		if (ret) {
-			IWL_DEBUG_FW(trans, "PNVM file %s not found %d\n",
-				     pnvm_name, ret);
-			/*
-			 * Pretend we've loaded it - at least we've tried and
-			 * couldn't load it at all, so there's no point in
-			 * trying again over and over.
-			 */
-			trans->pnvm_loaded = true;
-		} else {
-			iwl_pnvm_parse(trans, pnvm->data, pnvm->size);
+		trans->pnvm_loaded = true;
 
-			release_firmware(pnvm);
-		}
-	} else {
-		/* if we already loaded, we need to set it again */
-		ret = iwl_trans_set_pnvm(trans, NULL, 0);
-		if (ret)
-			return ret;
+		goto skip_parse;
 	}
 
+	iwl_pnvm_parse(trans, data, len);
+
+	kfree(data);
+
+skip_parse:
 	iwl_init_notification_wait(notif_wait, &pnvm_wait,
 				   ntf_cmds, ARRAY_SIZE(ntf_cmds),
 				   iwl_pnvm_complete_fn, trans);
-- 
2.30.0

