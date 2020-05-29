Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63071E760B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 08:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgE2Gjo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 02:39:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:34992 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgE2Gjn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 02:39:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jeYg9-000jvb-Ge; Fri, 29 May 2020 09:39:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 09:39:23 +0300
Message-Id: <iwlwifi.20200529092401.1f826d34339e.I23182a59bfbe089a1f659742d6fee6f64d2ed08c@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063931.80551-1-luca@coelho.fi>
References: <20200529063931.80551-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/11] iwlwifi: pcie: keep trans instead of trans_pcie in iwl_txq
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We used both the trans and the trans_pcie structures in
iwl_txq, so we can keep the trans structure instead.  This
helps with the refactoring of txq code out of pcie.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index b76c0396335a..3950f5784a15 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -332,7 +332,7 @@ struct iwl_pcie_first_tb_buf {
  * @entries: transmit entries (driver state)
  * @lock: queue lock
  * @stuck_timer: timer that fires if queue gets stuck
- * @trans_pcie: pointer back to transport (for timer)
+ * @trans: pointer back to transport (for timer)
  * @need_update: indicates need to update read/write index
  * @ampdu: true if this queue is an ampdu queue for an specific RA/TID
  * @wd_timeout: queue watchdog timeout (jiffies) - per queue
@@ -371,7 +371,7 @@ struct iwl_txq {
 	spinlock_t lock;
 	unsigned long frozen_expiry_remainder;
 	struct timer_list stuck_timer;
-	struct iwl_trans_pcie *trans_pcie;
+	struct iwl_trans *trans;
 	bool need_update;
 	bool frozen;
 	bool ampdu;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 9ff78bca460b..757cf4e9de33 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -183,8 +183,7 @@ void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr)
 static void iwl_pcie_txq_stuck_timer(struct timer_list *t)
 {
 	struct iwl_txq *txq = from_timer(txq, t, stuck_timer);
-	struct iwl_trans_pcie *trans_pcie = txq->trans_pcie;
-	struct iwl_trans *trans = iwl_trans_pcie_get_trans(trans_pcie);
+	struct iwl_trans *trans = txq->trans;
 
 	spin_lock(&txq->lock);
 	/* check if triggered erroneously */
@@ -535,7 +534,7 @@ int iwl_pcie_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq,
 		tfd_sz = trans_pcie->tfd_size * slots_num;
 
 	timer_setup(&txq->stuck_timer, iwl_pcie_txq_stuck_timer, 0);
-	txq->trans_pcie = trans_pcie;
+	txq->trans = trans;
 
 	txq->n_window = slots_num;
 
@@ -2129,7 +2128,8 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 				   u16 tb1_len)
 {
 	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
-	struct iwl_trans_pcie *trans_pcie = txq->trans_pcie;
+	struct iwl_trans_pcie *trans_pcie =
+		IWL_TRANS_GET_PCIE_TRANS(txq->trans);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
-- 
2.26.2

