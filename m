Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C756277282
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgIXNhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:37:15 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52080 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727846AbgIXNhP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLRDu-002IGj-8T; Thu, 24 Sep 2020 16:23:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Sep 2020 16:23:37 +0300
Message-Id: <iwlwifi.20200924162105.1e3027abd0b5.Ie9f672983796586671a4374bf6dcda846875b690@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924132339.337310-1-luca@coelho.fi>
References: <20200924132339.337310-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 5/7] iwlwifi: move bc_table_dword to a common trans header
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The bc_table_dword code is not directly related to the PCIe transport,
so move the structures it uses to the common iwl-trans.h header.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  | 9 ++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 868aa3b0f797..209ec3949679 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -913,6 +913,7 @@ struct iwl_txq {
 /**
  * struct iwl_trans_txqs - transport tx queues data
  *
+ * @bc_table_dword: true if the BC table expects DWORD (as opposed to bytes)
  * @queue_used - bit mask of used queues
  * @queue_stopped - bit mask of stopped queues
  */
@@ -922,6 +923,8 @@ struct iwl_trans_txqs {
 	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
 	struct dma_pool *bc_pool;
 	size_t bc_tbl_size;
+	bool bc_table_dword;
+
 	struct {
 		u8 fifo;
 		u8 q_id;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 9873b63301f6..d58f8ade3d42 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -378,7 +378,6 @@ struct cont_rec {
  * @cmd_queue - command queue number
  * @def_rx_queue - default rx queue number
  * @rx_buf_size: Rx buffer size
- * @bc_table_dword: true if the BC table expects DWORD (as opposed to bytes)
  * @scd_set_active: should the transport configure the SCD for HCMD queue
  * @sw_csum_tx: if true, then the transport will compute the csum of the TXed
  *	frame.
@@ -466,7 +465,6 @@ struct iwl_trans_pcie {
 	u16 num_rx_bufs;
 
 	enum iwl_amsdu_size rx_buf_size;
-	bool bc_table_dword;
 	bool scd_set_active;
 	bool sw_csum_tx;
 	bool pcie_dbg_dumped_once;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 994f17616159..29c5e71b5495 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1928,7 +1928,7 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		trans_pcie->supported_dma_mask = DMA_BIT_MASK(11);
 
-	trans_pcie->bc_table_dword = trans_cfg->bc_table_dword;
+	trans->txqs.bc_table_dword = trans_cfg->bc_table_dword;
 	trans_pcie->scd_set_active = trans_cfg->scd_set_active;
 	trans_pcie->sw_csum_tx = trans_cfg->sw_csum_tx;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 328b48597770..051bf37b4536 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -86,11 +86,10 @@ void iwl_pcie_gen2_tx_stop(struct iwl_trans *trans)
 /*
  * iwl_pcie_txq_update_byte_tbl - Set up entry in Tx byte-count array
  */
-static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
+static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans *trans,
 					  struct iwl_txq *txq, u16 byte_cnt,
 					  int num_tbs)
 {
-	struct iwl_trans *trans = iwl_trans_pcie_get_trans(trans_pcie);
 	int idx = iwl_pcie_get_cmd_index(txq, txq->write_ptr);
 	u8 filled_tfd_size, num_fetch_chunks;
 	u16 len = byte_cnt;
@@ -115,7 +114,7 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 		struct iwl_gen3_bc_tbl *scd_bc_tbl_gen3 = txq->bc_tbl.addr;
 
 		/* Starting from AX210, the HW expects bytes */
-		WARN_ON(trans_pcie->bc_table_dword);
+		WARN_ON(trans->txqs.bc_table_dword);
 		WARN_ON(len > 0x3FFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 14));
 		scd_bc_tbl_gen3->tfd_offset[idx] = bc_ent;
@@ -123,7 +122,7 @@ static void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 		struct iwlagn_scd_bc_tbl *scd_bc_tbl = txq->bc_tbl.addr;
 
 		/* Before AX210, the HW expects DW */
-		WARN_ON(!trans_pcie->bc_table_dword);
+		WARN_ON(!trans->txqs.bc_table_dword);
 		len = DIV_ROUND_UP(len, 4);
 		WARN_ON(len > 0xFFF);
 		bc_ent = cpu_to_le16(len | (num_fetch_chunks << 12));
@@ -784,7 +783,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	}
 
 	/* Set up entry for this TFD in Tx byte-count array */
-	iwl_pcie_gen2_update_byte_tbl(trans_pcie, txq, cmd_len,
+	iwl_pcie_gen2_update_byte_tbl(trans, txq, cmd_len,
 				      iwl_pcie_gen2_get_num_tbs(trans, tfd));
 
 	/* start timer if queue currently empty */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 63773d6f79b2..b9308700a2a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -231,7 +231,7 @@ static void iwl_pcie_txq_update_byte_cnt_tbl(struct iwl_trans *trans,
 		len += IEEE80211_WEP_IV_LEN + IEEE80211_WEP_ICV_LEN;
 		break;
 	}
-	if (trans_pcie->bc_table_dword)
+	if (trans->txqs.bc_table_dword)
 		len = DIV_ROUND_UP(len, 4);
 
 	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
-- 
2.28.0

