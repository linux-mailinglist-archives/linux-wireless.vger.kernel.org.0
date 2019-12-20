Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB4E127B4E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfLTMvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54098 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727390AbfLTMvm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:42 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkq-0007lx-Bp; Fri, 20 Dec 2019 14:51:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:22 +0200
Message-Id: <20191220125124.1315679-10-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 09/11] iwlwifi: pcie: validate queue ID before array deref/bit ops
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Validate that the queue ID is in range before trying to use it as
an index or for test_bit() - the previous bug showed that this has
in fact happened, and it was lucky that we caught it there, had the
bit been set then we'd have actually used the value despite being
far out of range.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 8ca0250de99e..c3683cddc301 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -587,6 +587,10 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	int idx;
 	void *tfd;
 
+	if (WARN_ONCE(txq_id >= IWL_MAX_TVQM_QUEUES,
+		      "queue %d out of range", txq_id))
+		return -EINVAL;
+
 	if (WARN_ONCE(!test_bit(txq_id, trans_pcie->queue_used),
 		      "TX on unused queue %d\n", txq_id))
 		return -EINVAL;
@@ -1101,9 +1105,15 @@ void iwl_pcie_gen2_txq_free_memory(struct iwl_trans *trans,
 static void iwl_pcie_gen2_txq_free(struct iwl_trans *trans, int txq_id)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+	struct iwl_txq *txq;
 	int i;
 
+	if (WARN_ONCE(txq_id >= IWL_MAX_TVQM_QUEUES,
+		      "queue %d out of range", txq_id))
+		return;
+
+	txq = trans_pcie->txq[txq_id];
+
 	if (WARN_ON(!txq))
 		return;
 
@@ -1258,6 +1268,10 @@ void iwl_trans_pcie_dyn_txq_free(struct iwl_trans *trans, int queue)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
+	if (WARN(queue >= IWL_MAX_TVQM_QUEUES,
+		 "queue %d out of range", queue))
+		return;
+
 	/*
 	 * Upon HW Rfkill - we stop the device, and then stop the queues
 	 * in the op_mode. Just for the sake of the simplicity of the op_mode,
-- 
2.24.0

