Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D573277DBD2
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbjHPILl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbjHPILV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:11:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32749109
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692173480; x=1723709480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KsnNHkKgbYMDxgy15zkYwLWa314cMjrf9JwIjtHiY3I=;
  b=A/FrJ0gSNN1blO845cKQFQcQqG9ldaL0nMEA+7q1Rw3eIaFnJ8Jr5OXT
   fm3v+9i70JKhlMZU20DqtPe3l5sybQDl4hI1SZLgYYdjf6/5BM9iXbXM8
   P9CAzLvhfhrN+JdAY1xVv7vF4H58nLnTZy4BRfM5fu54n+z+qOfKWZllc
   uU5NUsAQ89TukimrAe4pVnrBEAG4RVQRutrDzlVWLEUqVx+Xb8ZvnDFz+
   xXSDaQJRD28lQyp7IhjcXPxcCA2p8Q+JwPEe3pHxooVq+VvMw11XkWw0Y
   RW4AaTLG1ogZPVLcmJLhuZzwAWJhJ5r+UBtkmbCtEDc/SVEq0fS4I3H3Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357447819"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="357447819"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769098799"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769098799"
Received: from mamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.226.187])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 01:11:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/12] wifi: iwlwifi: remove 'def_rx_queue' struct member
Date:   Wed, 16 Aug 2023 11:10:47 +0300
Message-Id: <20230816104355.e0c6fa57c162.I907bbb428cf99725f06a348c8dbce5d3dd877136@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816081054.245480-1-gregory.greenman@intel.com>
References: <20230816081054.245480-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is only ever initialized to zero, use a new define
for the default RX queue instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        | 2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 4 +---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 2 --
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index 4e4a60ddf9b2..41ab5a6e2dd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -565,6 +565,8 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
 #define RX_QUEUE_MASK                         255
 #define RX_QUEUE_SIZE_LOG                     8
 
+#define IWL_DEFAULT_RX_QUEUE			0
+
 /**
  * struct iwl_rb_status - reserve buffer status
  * 	host memory mapped FH registers
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 0adcf0e13e85..0f6493dab8cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2022 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -315,7 +315,6 @@ enum iwl_pcie_imr_status {
  * @ucode_write_complete: indicates that the ucode has been copied.
  * @ucode_write_waitq: wait queue for uCode load
  * @cmd_queue - command queue number
- * @def_rx_queue - default rx queue number
  * @rx_buf_size: Rx buffer size
  * @scd_set_active: should the transport configure the SCD for HCMD queue
  * @rx_page_order: page order for receive buffer size
@@ -398,7 +397,6 @@ struct iwl_trans_pcie {
 	wait_queue_head_t ucode_write_waitq;
 	wait_queue_head_t sx_waitq;
 
-	u8 def_rx_queue;
 	u8 n_no_reclaim_cmds;
 	u8 no_reclaim_cmds[MAX_NO_RECLAIM_CMDS];
 	u16 num_rx_bufs;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index f87b28edc267..4614acee9f7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1373,7 +1373,7 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 			}
 		}
 
-		if (rxq->id == trans_pcie->def_rx_queue)
+		if (rxq->id == IWL_DEFAULT_RX_QUEUE)
 			iwl_op_mode_rx(trans->op_mode, &rxq->napi,
 				       &rxcb);
 		else
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3e988da44973..2096f7158728 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3617,8 +3617,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 				       PCIE_LINK_STATE_CLKPM);
 	}
 
-	trans_pcie->def_rx_queue = 0;
-
 	pci_set_master(pdev);
 
 	addr_size = trans->txqs.tfd.addr_size;
-- 
2.38.1

