Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5691B857E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDYKFM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58218 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgDYKFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgM-000P3t-CX; Sat, 25 Apr 2020 13:05:10 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:50 +0300
Message-Id: <iwlwifi.20200425130140.c8548d7cc08a.I5059c410e628726cbce98d6311b690c632d00f97@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/11] iwlwifi: mvm: attempt to allocate smaller queues
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We currently attempt to allocate queues that are 512 entries long,
but that requires 32 KiB memory, which may not be available, at
least not contiguously. If we fail to allocate, attempt to use a
smaller queue all the way down to 16 entries (which fit into a
single page).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 23 +++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 1a210292f56c..3e16bd4190ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -744,16 +744,23 @@ static int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 		size = max_t(u32, IWL_MGMT_QUEUE_SIZE,
 			     mvm->trans->cfg->min_txq_size);
 	}
-	queue = iwl_trans_txq_alloc(mvm->trans,
-				    cpu_to_le16(TX_QUEUE_CFG_ENABLE_QUEUE),
-				    sta_id, tid, SCD_QUEUE_CFG, size, timeout);
 
-	if (queue < 0) {
-		IWL_DEBUG_TX_QUEUES(mvm,
-				    "Failed allocating TXQ for sta %d tid %d, ret: %d\n",
-				    sta_id, tid, queue);
+	do {
+		__le16 enable = cpu_to_le16(TX_QUEUE_CFG_ENABLE_QUEUE);
+
+		queue = iwl_trans_txq_alloc(mvm->trans, enable,
+					    sta_id, tid, SCD_QUEUE_CFG,
+					    size, timeout);
+
+		if (queue < 0)
+			IWL_DEBUG_TX_QUEUES(mvm,
+					    "Failed allocating TXQ of size %d for sta %d tid %d, ret: %d\n",
+					    size, sta_id, tid, queue);
+		size /= 2;
+	} while (queue < 0 && size >= 16);
+
+	if (queue < 0)
 		return queue;
-	}
 
 	IWL_DEBUG_TX_QUEUES(mvm, "Enabling TXQ #%d for sta %d tid %d\n",
 			    queue, sta_id, tid);
-- 
2.26.2

