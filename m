Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A969277280
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgIXNhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:37:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52074 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727846AbgIXNhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:08 -0400
X-Greylist: delayed 805 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 09:37:08 EDT
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLRDr-002IGj-HG; Thu, 24 Sep 2020 16:23:44 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Sep 2020 16:23:34 +0300
Message-Id: <iwlwifi.20200924162105.862ef88d1ab2.Iba220a962b5d6d05c030b9275d97a89202d055dc@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924132339.337310-1-luca@coelho.fi>
References: <20200924132339.337310-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 2/7] iwlwifi: iwl-trans: move all txcmd init to trans alloc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

txcmd fields is not directly related to the PCIe transport,
so move to the common iwl_trans_alloc function.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  7 ++---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 28 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  7 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  3 --
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 22 ++-------------
 5 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 82d59b5a5f8c..de2e2ca7a3ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -5,9 +5,8 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,9 +26,8 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2012 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -61,6 +59,7 @@
 
 #ifndef __iwl_fw_api_tx_h__
 #define __iwl_fw_api_tx_h__
+#include <linux/ieee80211.h>
 
 /**
  * enum iwl_tx_flags - bitmasks for tx_flags in TX command
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index f91197e4ae40..4a61ab56d728 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -7,6 +7,7 @@
  *
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,6 +29,7 @@
  *
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -60,6 +62,7 @@
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
 
+#include "fw/api/tx.h"
 #include "iwl-trans.h"
 #include "iwl-drv.h"
 #include "iwl-fh.h"
@@ -67,10 +70,10 @@
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
 				  const struct iwl_trans_ops *ops,
-				  unsigned int cmd_pool_size,
-				  unsigned int cmd_pool_align)
+				  const struct iwl_cfg_trans_params *cfg_trans)
 {
 	struct iwl_trans *trans;
+	int txcmd_size, txcmd_align;
 #ifdef CONFIG_LOCKDEP
 	static struct lock_class_key __key;
 #endif
@@ -79,6 +82,25 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 	if (!trans)
 		return NULL;
 
+	trans->trans_cfg = cfg_trans;
+	if (!cfg_trans->gen2) {
+		txcmd_size = sizeof(struct iwl_tx_cmd);
+		txcmd_align = sizeof(void *);
+	} else if (cfg_trans->device_family < IWL_DEVICE_FAMILY_AX210) {
+		txcmd_size = sizeof(struct iwl_tx_cmd_gen2);
+		txcmd_align = 64;
+	} else {
+		txcmd_size = sizeof(struct iwl_tx_cmd_gen3);
+		txcmd_align = 128;
+	}
+
+	txcmd_size += sizeof(struct iwl_cmd_header);
+	txcmd_size += 36; /* biggest possible 802.11 header */
+
+	/* Ensure device TX cmd cannot reach/cross a page boundary in gen2 */
+	if (WARN_ON(cfg_trans->gen2 && txcmd_size >= txcmd_align))
+		return ERR_PTR(-EINVAL);
+
 #ifdef CONFIG_LOCKDEP
 	lockdep_init_map(&trans->sync_cmd_lockdep_map, "sync_cmd_lockdep_map",
 			 &__key, 0);
@@ -92,7 +114,7 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 		 "iwl_cmd_pool:%s", dev_name(trans->dev));
 	trans->dev_cmd_pool =
 		kmem_cache_create(trans->dev_cmd_pool_name,
-				  cmd_pool_size, cmd_pool_align,
+				  txcmd_size, txcmd_align,
 				  SLAB_HWCACHE_ALIGN, NULL);
 	if (!trans->dev_cmd_pool)
 		return NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 32ea4c3c7d23..d17eafe31e41 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1436,10 +1436,9 @@ static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
  * transport helper functions
  *****************************************************/
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
-				  struct device *dev,
-				  const struct iwl_trans_ops *ops,
-				  unsigned int cmd_pool_size,
-				  unsigned int cmd_pool_align);
+			  struct device *dev,
+			  const struct iwl_trans_ops *ops,
+			  const struct iwl_cfg_trans_params *cfg_trans);
 void iwl_trans_free(struct iwl_trans *trans);
 
 /*****************************************************
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 72bb2b38e5b6..d84afe0013a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1002,9 +1002,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
 
-	/* the trans_cfg should never change, so set it now */
-	iwl_trans->trans_cfg = trans;
-
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
 
 	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a59684e82713..43adb6646366 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3502,34 +3502,18 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 {
 	struct iwl_trans_pcie *trans_pcie;
 	struct iwl_trans *trans;
-	int ret, addr_size, txcmd_size, txcmd_align;
+	int ret, addr_size;
 	const struct iwl_trans_ops *ops = &trans_ops_pcie_gen2;
 
-	if (!cfg_trans->gen2) {
+	if (!cfg_trans->gen2)
 		ops = &trans_ops_pcie;
-		txcmd_size = sizeof(struct iwl_tx_cmd);
-		txcmd_align = sizeof(void *);
-	} else if (cfg_trans->device_family < IWL_DEVICE_FAMILY_AX210) {
-		txcmd_size = sizeof(struct iwl_tx_cmd_gen2);
-		txcmd_align = 64;
-	} else {
-		txcmd_size = sizeof(struct iwl_tx_cmd_gen3);
-		txcmd_align = 128;
-	}
-
-	txcmd_size += sizeof(struct iwl_cmd_header);
-	txcmd_size += 36; /* biggest possible 802.11 header */
-
-	/* Ensure device TX cmd cannot reach/cross a page boundary in gen2 */
-	if (WARN_ON(cfg_trans->gen2 && txcmd_size >= txcmd_align))
-		return ERR_PTR(-EINVAL);
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ERR_PTR(ret);
 
 	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev, ops,
-				txcmd_size, txcmd_align);
+				cfg_trans);
 	if (!trans)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.28.0

