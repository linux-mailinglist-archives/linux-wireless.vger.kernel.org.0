Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6581B8587
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgDYKFX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:23 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58290 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbgDYKFW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgS-000P3t-Mw; Sat, 25 Apr 2020 13:05:17 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:58 +0300
Message-Id: <iwlwifi.20200425130140.e78a59f70b1d.Ica656a98a4e4220d73edc97600edd680cbc97241@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/11] iwlwifi: pcie: skip fragmented receive buffers
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We don't really expect fragmented RBs, and don't seem to be seeing
them in practice since that would've caused a crash. Nevertheless,
we should be expecting the hardware to send them.

Parse the flag indicating a fragmented buffer, but then discard it
and any fragments thereof, at least for now. We need to do more
work in the higher layers to properly deal with this, since we may
not get "normal" firmware notifications that are fragmented, only
RX, and then we need to put it back together and add the necessary
API to report a chain of things to the higher layers, this doesn't
fit into the struct iwl_rx_cmd_buffer today.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 32 ++++++++++++++++---
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 43f81204c152..b76c0396335a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -189,6 +189,8 @@ struct iwl_rx_completion_desc {
  * @rb_stts_dma: bus address of receive buffer status
  * @lock:
  * @queue: actual rx queue. Not used for multi-rx queue.
+ * @next_rb_is_fragment: indicates that the previous RB that we handled set
+ *	the fragmented flag, so the next one is still another fragment
  *
  * NOTE:  rx_free and rx_used are used as a FIFO for iwl_rx_mem_buffers
  */
@@ -214,7 +216,7 @@ struct iwl_rxq {
 	u32 queue_size;
 	struct list_head rx_free;
 	struct list_head rx_used;
-	bool need_update;
+	bool need_update, next_rb_is_fragment;
 	void *rb_stts;
 	dma_addr_t rb_stts_dma;
 	spinlock_t lock;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 8c29071cb415..72d1cf27e6a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1427,7 +1427,8 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 }
 
 static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
-						  struct iwl_rxq *rxq, int i)
+						  struct iwl_rxq *rxq, int i,
+						  bool *join)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_rx_mem_buffer *rxb;
@@ -1441,10 +1442,12 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 		return rxb;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
 		vid = le16_to_cpu(rxq->cd[i].rbid);
-	else
+		*join = rxq->cd[i].flags & IWL_RX_CD_FLAGS_FRAGMENTED;
+	} else {
 		vid = le32_to_cpu(rxq->bd_32[i]) & 0x0FFF; /* 12-bit VID */
+	}
 
 	if (!vid || vid > RX_POOL_SIZE(trans_pcie->num_rx_bufs))
 		goto out_err;
@@ -1502,6 +1505,7 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
 		u32 rb_pending_alloc =
 			atomic_read(&trans_pcie->rba.req_pending) *
 			RX_CLAIM_REQ_ALLOC;
+		bool join = false;
 
 		if (unlikely(rb_pending_alloc >= rxq->queue_size / 2 &&
 			     !emergency)) {
@@ -1514,11 +1518,29 @@ static void iwl_pcie_rx_handle(struct iwl_trans *trans, int queue)
 
 		IWL_DEBUG_RX(trans, "Q %d: HW = %d, SW = %d\n", rxq->id, r, i);
 
-		rxb = iwl_pcie_get_rxb(trans, rxq, i);
+		rxb = iwl_pcie_get_rxb(trans, rxq, i, &join);
 		if (!rxb)
 			goto out;
 
-		iwl_pcie_rx_handle_rb(trans, rxq, rxb, emergency, i);
+		if (unlikely(join || rxq->next_rb_is_fragment)) {
+			rxq->next_rb_is_fragment = join;
+			/*
+			 * We can only get a multi-RB in the following cases:
+			 *  - firmware issue, sending a too big notification
+			 *  - sniffer mode with a large A-MSDU
+			 *  - large MTU frames (>2k)
+			 * since the multi-RB functionality is limited to newer
+			 * hardware that cannot put multiple entries into a
+			 * single RB.
+			 *
+			 * Right now, the higher layers aren't set up to deal
+			 * with that, so discard all of these.
+			 */
+			list_add_tail(&rxb->list, &rxq->rx_free);
+			rxq->free_count++;
+		} else {
+			iwl_pcie_rx_handle_rb(trans, rxq, rxb, emergency, i);
+		}
 
 		i = (i + 1) & (rxq->queue_size - 1);
 
-- 
2.26.2

