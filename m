Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAAD4A3584
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354554AbiA3JxR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37912 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354545AbiA3JxQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:16 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tW-0003JO-8O;
        Sun, 30 Jan 2022 11:53:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:53:03 +0200
Message-Id: <iwlwifi.20220130115024.d53f2a7a9614.I7441559451d54b39dc0daeb4c31e5dce19d4d83e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130095306.790573-1-luca@coelho.fi>
References: <20220130095306.790573-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: avoid variable shadowing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Change a few places to not shadow variables.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c     |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c      |  2 --
 drivers/net/wireless/intel/iwlwifi/queue/tx.c    |  6 +++---
 drivers/net/wireless/intel/iwlwifi/queue/tx.h    | 10 +++++-----
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 5a60aab662d6..1e884dc31f46 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -825,11 +825,11 @@ static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
 }
 
 static void iwl_dbg_tlv_apply_config(struct iwl_fw_runtime *fwrt,
-				     struct list_head *config_list)
+				     struct list_head *conf_list)
 {
 	struct iwl_dbg_tlv_node *node;
 
-	list_for_each_entry(node, config_list, list) {
+	list_for_each_entry(node, conf_list, list) {
 		struct iwl_fw_ini_conf_set_tlv *config_list = (void *)node->tlv.data;
 		u32 count, address, value;
 		u32 len = (le32_to_cpu(node->tlv.length) - sizeof(*config_list)) / 8;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index c8ffe31ca124..11b4dd447bc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1041,12 +1041,12 @@ static bool iwl_mvm_remove_inactive_tids(struct iwl_mvm *mvm,
 	 * Remove the ones that did.
 	 */
 	for_each_set_bit(tid, &tid_bitmap, IWL_MAX_TID_COUNT + 1) {
-		u16 tid_bitmap;
+		u16 q_tid_bitmap;
 
 		mvmsta->tid_data[tid].txq_id = IWL_MVM_INVALID_QUEUE;
 		mvm->queue_info[queue].tid_bitmap &= ~BIT(tid);
 
-		tid_bitmap = mvm->queue_info[queue].tid_bitmap;
+		q_tid_bitmap = mvm->queue_info[queue].tid_bitmap;
 
 		/*
 		 * We need to take into account a situation in which a TXQ was
@@ -1059,7 +1059,7 @@ static bool iwl_mvm_remove_inactive_tids(struct iwl_mvm *mvm,
 		 * Mark this queue in the right bitmap, we'll send the command
 		 * to the firmware later.
 		 */
-		if (!(tid_bitmap & BIT(mvm->queue_info[queue].txq_tid)))
+		if (!(q_tid_bitmap & BIT(mvm->queue_info[queue].txq_tid)))
 			set_bit(queue, changetid_queues);
 
 		IWL_DEBUG_TX_QUEUES(mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6428ee4e764e..071f25a0404c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1603,8 +1603,6 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 			seq_ctl = le16_to_cpu(hdr->seq_ctrl);
 
 		if (unlikely(!seq_ctl)) {
-			struct ieee80211_hdr *hdr = (void *)skb->data;
-
 			/*
 			 * If it is an NDP, we can't update next_reclaim since
 			 * its sequence control is 0. Note that for that same
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index e12d36a25652..f80bea04e31b 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1307,10 +1307,10 @@ static inline dma_addr_t iwl_txq_gen1_tfd_tb_get_addr(struct iwl_trans *trans,
 	dma_addr_t hi_len;
 
 	if (trans->trans_cfg->use_tfh) {
-		struct iwl_tfh_tfd *tfd = _tfd;
-		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
+		struct iwl_tfh_tfd *tfh_tfd = _tfd;
+		struct iwl_tfh_tb *tfh_tb = &tfh_tfd->tbs[idx];
 
-		return (dma_addr_t)(le64_to_cpu(tb->addr));
+		return (dma_addr_t)(le64_to_cpu(tfh_tb->addr));
 	}
 
 	tfd = _tfd;
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 19178c88bb22..7db675b89f8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -137,9 +137,9 @@ static inline u8 iwl_txq_gen1_tfd_get_num_tbs(struct iwl_trans *trans,
 	struct iwl_tfd *tfd;
 
 	if (trans->trans_cfg->use_tfh) {
-		struct iwl_tfh_tfd *tfd = _tfd;
+		struct iwl_tfh_tfd *tfh_tfd = _tfd;
 
-		return le16_to_cpu(tfd->num_tbs) & 0x1f;
+		return le16_to_cpu(tfh_tfd->num_tbs) & 0x1f;
 	}
 
 	tfd = (struct iwl_tfd *)_tfd;
@@ -153,10 +153,10 @@ static inline u16 iwl_txq_gen1_tfd_tb_get_len(struct iwl_trans *trans,
 	struct iwl_tfd_tb *tb;
 
 	if (trans->trans_cfg->use_tfh) {
-		struct iwl_tfh_tfd *tfd = _tfd;
-		struct iwl_tfh_tb *tb = &tfd->tbs[idx];
+		struct iwl_tfh_tfd *tfh_tfd = _tfd;
+		struct iwl_tfh_tb *tfh_tb = &tfh_tfd->tbs[idx];
 
-		return le16_to_cpu(tb->tb_len);
+		return le16_to_cpu(tfh_tb->tb_len);
 	}
 
 	tfd = (struct iwl_tfd *)_tfd;
-- 
2.34.1

