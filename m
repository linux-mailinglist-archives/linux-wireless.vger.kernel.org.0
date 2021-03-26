Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F134A606
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 11:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhCZK55 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 06:57:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43402 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230059AbhCZK5b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 06:57:31 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lPk9g-0003Gc-Dj; Fri, 26 Mar 2021 12:57:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Mar 2021 12:57:22 +0200
Message-Id: <iwlwifi.20210326125611.703288ea058d.I82a0312389032d07c3b478bef3e938e06bfa7df6@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326105723.211843-1-luca@coelho.fi>
References: <20210326105723.211843-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH v2 for v5.12 6/7] mvm: rfi: don't lock mvm->mutex when sending config command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

The mutex is already locked in iwl_mvm_mac_start.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Fixes: 21254908cbe9 ("iwlwifi: mvm: add RFI-M support")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 7 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c     | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 130760572262..34ddef97b099 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1786,10 +1786,13 @@ static ssize_t iwl_dbgfs_rfi_freq_table_write(struct iwl_mvm *mvm, char *buf,
 		return -EINVAL;
 
 	/* value zero triggers re-sending the default table to the device */
-	if (!op_id)
+	if (!op_id) {
+		mutex_lock(&mvm->mutex);
 		ret = iwl_rfi_send_config_cmd(mvm, NULL);
-	else
+		mutex_unlock(&mvm->mutex);
+	} else {
 		ret = -EOPNOTSUPP; /* in the future a new table will be added */
+	}
 
 	return ret ?: count;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
index 873919048143..0b818067067c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2020 Intel Corporation
+ * Copyright (C) 2020 - 2021 Intel Corporation
  */
 
 #include "mvm.h"
@@ -66,6 +66,8 @@ int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm, struct iwl_rfi_lut_entry *rfi_t
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_RFIM_SUPPORT))
 		return -EOPNOTSUPP;
 
+	lockdep_assert_held(&mvm->mutex);
+
 	/* in case no table is passed, use the default one */
 	if (!rfi_table) {
 		memcpy(cmd.table, iwl_rfi_table, sizeof(cmd.table));
@@ -75,9 +77,7 @@ int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm, struct iwl_rfi_lut_entry *rfi_t
 		cmd.oem = 1;
 	}
 
-	mutex_lock(&mvm->mutex);
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
-	mutex_unlock(&mvm->mutex);
 
 	if (ret)
 		IWL_ERR(mvm, "Failed to send RFI config cmd %d\n", ret);
-- 
2.31.0

