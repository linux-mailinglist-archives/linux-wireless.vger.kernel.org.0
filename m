Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCB59749
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfF1JUZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54710 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726531AbfF1JUY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3O-0001ny-E6; Fri, 28 Jun 2019 12:20:22 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 06/20] iwlwifi: fix module init error paths
Date:   Fri, 28 Jun 2019 12:19:54 +0300
Message-Id: <20190628092008.11049-7-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When the module fails to initialize for some reason, it
doesn't clean up properly. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index e14811ca75b3..2c7a3709a19f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1746,7 +1746,7 @@ IWL_EXPORT_SYMBOL(iwl_opmode_deregister);
 
 static int __init iwl_drv_init(void)
 {
-	int i;
+	int i, err;
 
 	mutex_init(&iwlwifi_opmode_table_mtx);
 
@@ -1761,7 +1761,17 @@ static int __init iwl_drv_init(void)
 	iwl_dbgfs_root = debugfs_create_dir(DRV_NAME, NULL);
 #endif
 
-	return iwl_pci_register_driver();
+	err = iwl_pci_register_driver();
+	if (err)
+		goto cleanup_debugfs;
+
+	return 0;
+
+cleanup_debugfs:
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	debugfs_remove_recursive(iwl_dbgfs_root);
+#endif
+	return err;
 }
 module_init(iwl_drv_init);
 
-- 
2.20.1

