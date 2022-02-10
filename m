Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC04B1385
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiBJQwa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244845AbiBJQw3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:29 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5717DEE
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:30 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDO-000Bxy-Rx;
        Thu, 10 Feb 2022 18:22:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:25 +0200
Message-Id: <iwlwifi.20220210181930.8b352828f767.Ice4c91d8ea3e207914104e72801b87cd7f409ba7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210162234.285578-1-luca@coelho.fi>
References: <20220210162234.285578-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 02/11] iwlwifi: remove command ID argument from queue allocation
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The command ID here is always hard-coded to the same, so we
can remove it. In the future we actually need to make this
configurable, but that doesn't need to be on each call, it
can be done through the transport configuration.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 10 ++++------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   |  5 ++---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c  |  5 +++--
 drivers/net/wireless/intel/iwlwifi/queue/tx.h  |  5 ++---
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 6a4d3eafdc19..50342bf0a5d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -571,8 +571,7 @@ struct iwl_trans_ops {
 	/* 22000 functions */
 	int (*txq_alloc)(struct iwl_trans *trans,
 			 __le16 flags, u8 sta_id, u8 tid,
-			 int cmd_id, int size,
-			 unsigned int queue_wdg_timeout);
+			 int size, unsigned int queue_wdg_timeout);
 	void (*txq_free)(struct iwl_trans *trans, int queue);
 	int (*rxq_dma_data)(struct iwl_trans *trans, int queue,
 			    struct iwl_trans_rxq_dma_data *data);
@@ -1246,8 +1245,7 @@ iwl_trans_txq_free(struct iwl_trans *trans, int queue)
 static inline int
 iwl_trans_txq_alloc(struct iwl_trans *trans,
 		    __le16 flags, u8 sta_id, u8 tid,
-		    int cmd_id, int size,
-		    unsigned int wdg_timeout)
+		    int size, unsigned int wdg_timeout)
 {
 	might_sleep();
 
@@ -1260,7 +1258,7 @@ iwl_trans_txq_alloc(struct iwl_trans *trans,
 	}
 
 	return trans->ops->txq_alloc(trans, flags, sta_id, tid,
-				     cmd_id, size, wdg_timeout);
+				     size, wdg_timeout);
 }
 
 static inline void iwl_trans_txq_set_shared_mode(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index cb993fe0bb2b..bf3aca0b2fc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -783,9 +783,8 @@ static int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 	do {
 		__le16 enable = cpu_to_le16(TX_QUEUE_CFG_ENABLE_QUEUE);
 
-		queue = iwl_trans_txq_alloc(mvm->trans, enable,
-					    sta_id, tid, SCD_QUEUE_CFG,
-					    size, timeout);
+		queue = iwl_trans_txq_alloc(mvm->trans, enable, sta_id,
+					    tid, size, timeout);
 
 		if (queue < 0)
 			IWL_DEBUG_TX_QUEUES(mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 49625c679a5a..047092ea34fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -7,6 +7,7 @@
 
 #include "iwl-debug.h"
 #include "iwl-io.h"
+#include "fw/api/commands.h"
 #include "fw/api/tx.h"
 #include "queue/tx.h"
 #include "iwl-fh.h"
@@ -1185,7 +1186,7 @@ static int iwl_txq_alloc_response(struct iwl_trans *trans, struct iwl_txq *txq,
 }
 
 int iwl_txq_dyn_alloc(struct iwl_trans *trans, __le16 flags, u8 sta_id, u8 tid,
-		      int cmd_id, int size, unsigned int timeout)
+		      int size, unsigned int timeout)
 {
 	struct iwl_txq *txq;
 	struct iwl_tx_queue_cfg_cmd cmd = {
@@ -1194,7 +1195,7 @@ int iwl_txq_dyn_alloc(struct iwl_trans *trans, __le16 flags, u8 sta_id, u8 tid,
 		.tid = tid,
 	};
 	struct iwl_host_cmd hcmd = {
-		.id = cmd_id,
+		.id = SCD_QUEUE_CFG,
 		.len = { sizeof(cmd) },
 		.data = { &cmd, },
 		.flags = CMD_WANT_SKB,
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 7db675b89f8d..726dd001e65b 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2020-2021 Intel Corporation
+ * Copyright (C) 2020-2022 Intel Corporation
  */
 #ifndef __iwl_trans_queue_tx_h__
 #define __iwl_trans_queue_tx_h__
@@ -114,8 +114,7 @@ void iwl_txq_gen2_tfd_unmap(struct iwl_trans *trans,
 
 int iwl_txq_dyn_alloc(struct iwl_trans *trans,
 		      __le16 flags, u8 sta_id, u8 tid,
-		      int cmd_id, int size,
-		      unsigned int timeout);
+		      int size, unsigned int timeout);
 
 int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		    struct iwl_device_tx_cmd *dev_cmd, int txq_id);
-- 
2.34.1

