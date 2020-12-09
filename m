Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2832D4CBC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbgLIVUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:20:07 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35754 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726877AbgLIVUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:20:06 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6ps-003Drx-4S; Wed, 09 Dec 2020 23:17:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:39 +0200
Message-Id: <iwlwifi.20201209231352.6207fdcc91a9.Ia71e766ead7560262f4bc6ad3da6f1117c498cd6@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 35/47] iwlwifi: pcie: clean up some rx code
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We don't need the sequence/index/cmd_index unless we're doing
reclaim, they're not even valid in the other cases. Move the
variables and their assignments into the right if statement
and combine the two if statements into a single one as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 5d5513d39809..e82356abd0c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1239,9 +1239,8 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 
 	while (offset + sizeof(u32) + sizeof(struct iwl_cmd_header) < max_len) {
 		struct iwl_rx_packet *pkt;
-		u16 sequence;
 		bool reclaim;
-		int index, cmd_index, len;
+		int len;
 		struct iwl_rx_cmd_buffer rxcb = {
 			._offset = rxb->offset + offset,
 			._rx_page_order = trans_pcie->rx_page_order,
@@ -1307,10 +1306,6 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 			}
 		}
 
-		sequence = le16_to_cpu(pkt->hdr.sequence);
-		index = SEQ_TO_INDEX(sequence);
-		cmd_index = iwl_txq_get_cmd_index(txq, index);
-
 		if (rxq->id == trans_pcie->def_rx_queue)
 			iwl_op_mode_rx(trans->op_mode, &rxq->napi,
 				       &rxcb);
@@ -1318,17 +1313,19 @@ static void iwl_pcie_rx_handle_rb(struct iwl_trans *trans,
 			iwl_op_mode_rx_rss(trans->op_mode, &rxq->napi,
 					   &rxcb, rxq->id);
 
-		if (reclaim) {
-			kfree_sensitive(txq->entries[cmd_index].free_buf);
-			txq->entries[cmd_index].free_buf = NULL;
-		}
-
 		/*
 		 * After here, we should always check rxcb._page_stolen,
 		 * if it is true then one of the handlers took the page.
 		 */
 
 		if (reclaim) {
+			u16 sequence = le16_to_cpu(pkt->hdr.sequence);
+			int index = SEQ_TO_INDEX(sequence);
+			int cmd_index = iwl_txq_get_cmd_index(txq, index);
+
+			kfree_sensitive(txq->entries[cmd_index].free_buf);
+			txq->entries[cmd_index].free_buf = NULL;
+
 			/* Invoke any callbacks, transfer the buffer to caller,
 			 * and fire off the (possibly) blocking
 			 * iwl_trans_send_cmd()
-- 
2.29.2

