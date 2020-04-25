Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014071B857D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDYKFM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58212 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726271AbgDYKFL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgL-000P3t-Ij; Sat, 25 Apr 2020 13:05:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:49 +0300
Message-Id: <iwlwifi.20200425130140.c263b787b5ab.I059507a9760b1ce1d45d84dcaa91629a5cfb58e0@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/11] iwlwifi: pcie: allocate much smaller byte-count table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The hardware needs a byte-count table with the size of each frame
on the queue to build A-MPDUs, but:
 * newer generation no longer have the duplicated space at the end,
   they can deal with the wrap properly - and we don't even fill
   the dup anyway
 * we have a maximum queue size of 512 right now and don't use the
   theoretical hardware maximum of 65536.

Together, this reduces the byte count table DMA allocation from
64KiB (65536*2 + 64*2 rounded up) to 1 KiB (though that might be
rounded up to a full 4 KiB page by the allocator, not sure it can
share the allocations.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |  7 +++---
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 24 ++++++++++++-------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index bf673ce5f183..a8e988281eaf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -7,7 +7,7 @@
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,7 +29,7 @@
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -646,8 +646,7 @@ struct iwl_rb_status {
 #define TFD_QUEUE_CB_SIZE(x)	(ilog2(x) - 3)
 #define TFD_QUEUE_SIZE_BC_DUP	(64)
 #define TFD_QUEUE_BC_SIZE	(TFD_QUEUE_SIZE_MAX + TFD_QUEUE_SIZE_BC_DUP)
-#define TFD_QUEUE_BC_SIZE_GEN3	(TFD_QUEUE_SIZE_MAX_GEN3 + \
-				 TFD_QUEUE_SIZE_BC_DUP)
+#define TFD_QUEUE_BC_SIZE_GEN3	512
 #define IWL_TX_DMA_MASK        DMA_BIT_MASK(36)
 #define IWL_NUM_OF_TBS		20
 #define IWL_TFH_NUM_TBS		25
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index a30f6b080201..36f4e81eb70a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -20,7 +20,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -1272,17 +1272,25 @@ int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
 				     struct iwl_txq **intxq, int size,
 				     unsigned int timeout)
 {
+	size_t bc_tbl_size, bc_tbl_entries;
+	struct iwl_txq *txq;
 	int ret;
 
-	struct iwl_txq *txq;
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		bc_tbl_size = sizeof(struct iwl_gen3_bc_tbl);
+		bc_tbl_entries = bc_tbl_size / sizeof(u16);
+	} else {
+		bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
+		bc_tbl_entries = bc_tbl_size / sizeof(u16);
+	}
+
+	if (WARN_ON(size > bc_tbl_entries))
+		return -EINVAL;
+
 	txq = kzalloc(sizeof(*txq), GFP_KERNEL);
 	if (!txq)
 		return -ENOMEM;
-	ret = iwl_pcie_alloc_dma_ptr(trans, &txq->bc_tbl,
-				     (trans->trans_cfg->device_family >=
-				      IWL_DEVICE_FAMILY_AX210) ?
-				     sizeof(struct iwl_gen3_bc_tbl) :
-				     sizeof(struct iwlagn_scd_bc_tbl));
+	ret = iwl_pcie_alloc_dma_ptr(trans, &txq->bc_tbl, bc_tbl_size);
 	if (ret) {
 		IWL_ERR(trans, "Scheduler BC Table allocation failed\n");
 		kfree(txq);
-- 
2.26.2

