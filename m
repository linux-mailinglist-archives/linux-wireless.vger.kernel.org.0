Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB194AA7E0
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350307AbiBEJVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:54 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:38000 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345248AbiBEJVx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:53 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGR-0006b7-HF;
        Sat, 05 Feb 2022 11:21:52 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:37 +0200
Message-Id: <iwlwifi.20220205112029.699b4b9c2232.I0d7970d800a51fee5135946ee03a7d9e8a811893@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205092140.751171-1-luca@coelho.fi>
References: <20220205092140.751171-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: mvm: make iwl_mvm_reconfig_scd() static
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's no need to have this in a different place, it's
only used in a single C file (sta.c).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 33 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 34 +------------------
 3 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f6c69a4c1abf..b4c3a0dc9a39 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1946,10 +1946,6 @@ static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 
 void iwl_mvm_stop_device(struct iwl_mvm *mvm);
 
-/* Re-configure the SCD for a queue that has already been configured */
-int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
-			 int tid, int frame_limit, u16 ssn);
-
 /* Thermal management and CT-kill */
 void iwl_mvm_tt_tx_backoff(struct iwl_mvm *mvm, u32 backoff);
 void iwl_mvm_temp_notif(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 2cb1466ca8bd..cb993fe0bb2b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -596,6 +596,39 @@ static int iwl_mvm_get_shared_queue(struct iwl_mvm *mvm,
 	return queue;
 }
 
+/* Re-configure the SCD for a queue that has already been configured */
+static int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo,
+				int sta_id, int tid, int frame_limit, u16 ssn)
+{
+	struct iwl_scd_txq_cfg_cmd cmd = {
+		.scd_queue = queue,
+		.action = SCD_CFG_ENABLE_QUEUE,
+		.window = frame_limit,
+		.sta_id = sta_id,
+		.ssn = cpu_to_le16(ssn),
+		.tx_fifo = fifo,
+		.aggregate = (queue >= IWL_MVM_DQA_MIN_DATA_QUEUE ||
+			      queue == IWL_MVM_DQA_BSS_CLIENT_QUEUE),
+		.tid = tid,
+	};
+	int ret;
+
+	if (WARN_ON(iwl_mvm_has_new_tx_api(mvm)))
+		return -EINVAL;
+
+	if (WARN(mvm->queue_info[queue].tid_bitmap == 0,
+		 "Trying to reconfig unallocated queue %d\n", queue))
+		return -ENXIO;
+
+	IWL_DEBUG_TX_QUEUES(mvm, "Reconfig SCD for TXQ #%d\n", queue);
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, SCD_QUEUE_CFG, 0, sizeof(cmd), &cmd);
+	WARN_ONCE(ret, "Failed to re-configure queue %d on FIFO %d, ret=%d\n",
+		  queue, fifo, ret);
+
+	return ret;
+}
+
 /*
  * If a given queue has a higher AC than the TID stream that is being compared
  * to, the queue needs to be redirected to the lower AC. This function does that
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 2bb207ce5557..bc947733d982 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -240,38 +240,6 @@ u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx)
 	return last_idx;
 }
 
-int iwl_mvm_reconfig_scd(struct iwl_mvm *mvm, int queue, int fifo, int sta_id,
-			 int tid, int frame_limit, u16 ssn)
-{
-	struct iwl_scd_txq_cfg_cmd cmd = {
-		.scd_queue = queue,
-		.action = SCD_CFG_ENABLE_QUEUE,
-		.window = frame_limit,
-		.sta_id = sta_id,
-		.ssn = cpu_to_le16(ssn),
-		.tx_fifo = fifo,
-		.aggregate = (queue >= IWL_MVM_DQA_MIN_DATA_QUEUE ||
-			      queue == IWL_MVM_DQA_BSS_CLIENT_QUEUE),
-		.tid = tid,
-	};
-	int ret;
-
-	if (WARN_ON(iwl_mvm_has_new_tx_api(mvm)))
-		return -EINVAL;
-
-	if (WARN(mvm->queue_info[queue].tid_bitmap == 0,
-		 "Trying to reconfig unallocated queue %d\n", queue))
-		return -ENXIO;
-
-	IWL_DEBUG_TX_QUEUES(mvm, "Reconfig SCD for TXQ #%d\n", queue);
-
-	ret = iwl_mvm_send_cmd_pdu(mvm, SCD_QUEUE_CFG, 0, sizeof(cmd), &cmd);
-	WARN_ONCE(ret, "Failed to re-configure queue %d on FIFO %d, ret=%d\n",
-		  queue, fifo, ret);
-
-	return ret;
-}
-
 /**
  * iwl_mvm_send_lq_cmd() - Send link quality command
  * @mvm: Driver data.
-- 
2.34.1

