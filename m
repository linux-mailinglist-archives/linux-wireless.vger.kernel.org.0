Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E1A3F2A7E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbhHTLEE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 07:04:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57528 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239275AbhHTLEE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 07:04:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mH2J1-002IL4-I1; Fri, 20 Aug 2021 14:03:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 20 Aug 2021 14:03:09 +0300
Message-Id: <iwlwifi.20210820140104.4e2ebbbf4d4e.I3652584755b9ab44909ddcd09ff4d80c6690a1ad@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820110318.260751-1-luca@coelho.fi>
References: <20210820110318.260751-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 03/12] iwlwifi: move get pnvm file name to a separate function
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dror Moshe <drorx.moshe@intel.com>

Move code that generates the pnvm file name to a separate function,
so that it can be reused.

Signed-off-by: Dror Moshe <drorx.moshe@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 13 ++-----------
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 1de30bae7829..bbd8c31cbbec 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -223,19 +223,10 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 {
 	const struct firmware *pnvm;
-	char pnvm_name[64];
+	char pnvm_name[MAX_PNVM_NAME];
 	int ret;
 
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
+	iwl_pnvm_get_fs_name(trans, pnvm_name, sizeof(pnvm_name));
 
 	ret = firmware_request_nowarn(&pnvm, pnvm_name, trans->dev);
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
index 61d3d4e0b7d9..203c367dd4de 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
@@ -12,7 +12,27 @@
 
 #define MVM_UCODE_PNVM_TIMEOUT	(HZ / 4)
 
+#define MAX_PNVM_NAME  64
+
 int iwl_pnvm_load(struct iwl_trans *trans,
 		  struct iwl_notif_wait_data *notif_wait);
 
+static inline
+void iwl_pnvm_get_fs_name(struct iwl_trans *trans,
+			  u8 *pnvm_name, size_t max_len)
+{
+	int pre_len;
+
+	/*
+	 * The prefix unfortunately includes a hyphen at the end, so
+	 * don't add the dot here...
+	 */
+	snprintf(pnvm_name, max_len, "%spnvm", trans->cfg->fw_name_pre);
+
+	/* ...but replace the hyphen with the dot here. */
+	pre_len = strlen(trans->cfg->fw_name_pre);
+	if (pre_len < max_len && pre_len > 0)
+		pnvm_name[pre_len - 1] = '.';
+}
+
 #endif /* __IWL_PNVM_H__ */
-- 
2.33.0

