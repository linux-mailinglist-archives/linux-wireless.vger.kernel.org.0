Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18285127A58
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLTL4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:56:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:53978 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727252AbfLTL4v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:51 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGtj-0007ip-P1; Fri, 20 Dec 2019 13:56:48 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:33 +0200
Message-Id: <20191220115638.1299888-6-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115638.1299888-1-luca@coelho.fi>
References: <20191220115638.1299888-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 05/10] iwlwifi: pcie: allocate smaller dev_cmd for TX headers
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

As noted in the previous commit, due to the way we allocate the
dev_cmd headers with 324 byte size, and 4/8 byte alignment, the
part we use of them (bytes 20..40-68) could still cross a page
and thus 2^32 boundary.

Address this by using alignment to ensure that the allocation
cannot cross a page boundary, on hardware that's affected. To
make that not cause more memory consumption, reduce the size of
the allocations to the necessary size - we go from 324 bytes in
each allocation to 60/68 on gen2 depending on family, and ~120
or so on gen1 (so on gen1 it's a pure reduction in size, since
we don't need alignment there).

To avoid size and clearing issues, add a new structure that's
just the header, and use kmem_cache_zalloc().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |  3 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 10 +++---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 26 +++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 15 +++------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  6 ++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 32 ++++++++++++++-----
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 21 ++++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 20 ++++++------
 8 files changed, 84 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index cd73fc5cfcbb..fd454836adbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -267,7 +267,7 @@ int iwlagn_tx_skb(struct iwl_priv *priv,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct iwl_station_priv *sta_priv = NULL;
 	struct iwl_rxon_context *ctx = &priv->contexts[IWL_RXON_CTX_BSS];
-	struct iwl_device_cmd *dev_cmd;
+	struct iwl_device_tx_cmd *dev_cmd;
 	struct iwl_tx_cmd *tx_cmd;
 	__le16 fc;
 	u8 hdr_len;
@@ -348,7 +348,6 @@ int iwlagn_tx_skb(struct iwl_priv *priv,
 	if (unlikely(!dev_cmd))
 		goto drop_unlock_priv;
 
-	memset(dev_cmd, 0, sizeof(*dev_cmd));
 	dev_cmd->hdr.cmd = REPLY_TX;
 	tx_cmd = (struct iwl_tx_cmd *) dev_cmd->payload;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 28bdc9a9617e..f91197e4ae40 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -66,7 +66,9 @@
 
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_trans_ops *ops)
+				  const struct iwl_trans_ops *ops,
+				  unsigned int cmd_pool_size,
+				  unsigned int cmd_pool_align)
 {
 	struct iwl_trans *trans;
 #ifdef CONFIG_LOCKDEP
@@ -90,10 +92,8 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 		 "iwl_cmd_pool:%s", dev_name(trans->dev));
 	trans->dev_cmd_pool =
 		kmem_cache_create(trans->dev_cmd_pool_name,
-				  sizeof(struct iwl_device_cmd),
-				  sizeof(void *),
-				  SLAB_HWCACHE_ALIGN,
-				  NULL);
+				  cmd_pool_size, cmd_pool_align,
+				  SLAB_HWCACHE_ALIGN, NULL);
 	if (!trans->dev_cmd_pool)
 		return NULL;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 8cadad7364ac..e33df5ad00e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -193,6 +193,18 @@ struct iwl_device_cmd {
 	};
 } __packed;
 
+/**
+ * struct iwl_device_tx_cmd - buffer for TX command
+ * @hdr: the header
+ * @payload: the payload placeholder
+ *
+ * The actual structure is sized dynamically according to need.
+ */
+struct iwl_device_tx_cmd {
+	struct iwl_cmd_header hdr;
+	u8 payload[];
+} __packed;
+
 #define TFD_MAX_PAYLOAD_SIZE (sizeof(struct iwl_device_cmd))
 
 /*
@@ -544,7 +556,7 @@ struct iwl_trans_ops {
 	int (*send_cmd)(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
 
 	int (*tx)(struct iwl_trans *trans, struct sk_buff *skb,
-		  struct iwl_device_cmd *dev_cmd, int queue);
+		  struct iwl_device_tx_cmd *dev_cmd, int queue);
 	void (*reclaim)(struct iwl_trans *trans, int queue, int ssn,
 			struct sk_buff_head *skbs);
 
@@ -948,22 +960,22 @@ iwl_trans_dump_data(struct iwl_trans *trans, u32 dump_mask)
 	return trans->ops->dump_data(trans, dump_mask);
 }
 
-static inline struct iwl_device_cmd *
+static inline struct iwl_device_tx_cmd *
 iwl_trans_alloc_tx_cmd(struct iwl_trans *trans)
 {
-	return kmem_cache_alloc(trans->dev_cmd_pool, GFP_ATOMIC);
+	return kmem_cache_zalloc(trans->dev_cmd_pool, GFP_ATOMIC);
 }
 
 int iwl_trans_send_cmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
 
 static inline void iwl_trans_free_tx_cmd(struct iwl_trans *trans,
-					 struct iwl_device_cmd *dev_cmd)
+					 struct iwl_device_tx_cmd *dev_cmd)
 {
 	kmem_cache_free(trans->dev_cmd_pool, dev_cmd);
 }
 
 static inline int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
-			       struct iwl_device_cmd *dev_cmd, int queue)
+			       struct iwl_device_tx_cmd *dev_cmd, int queue)
 {
 	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
 		return -EIO;
@@ -1271,7 +1283,9 @@ static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
  *****************************************************/
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_trans_ops *ops);
+				  const struct iwl_trans_ops *ops,
+				  unsigned int cmd_pool_size,
+				  unsigned int cmd_pool_align);
 void iwl_trans_free(struct iwl_trans *trans);
 
 /*****************************************************
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index dc5c02fbc65a..80052ad1fa6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -490,13 +490,13 @@ static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 /*
  * Allocates and sets the Tx cmd the driver data pointers in the skb
  */
-static struct iwl_device_cmd *
+static struct iwl_device_tx_cmd *
 iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 		      struct ieee80211_tx_info *info, int hdrlen,
 		      struct ieee80211_sta *sta, u8 sta_id)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct iwl_device_cmd *dev_cmd;
+	struct iwl_device_tx_cmd *dev_cmd;
 	struct iwl_tx_cmd *tx_cmd;
 
 	dev_cmd = iwl_trans_alloc_tx_cmd(mvm->trans);
@@ -504,11 +504,6 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (unlikely(!dev_cmd))
 		return NULL;
 
-	/* Make sure we zero enough of dev_cmd */
-	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen2) > sizeof(*tx_cmd));
-	BUILD_BUG_ON(sizeof(struct iwl_tx_cmd_gen3) > sizeof(*tx_cmd));
-
-	memset(dev_cmd, 0, sizeof(dev_cmd->hdr) + sizeof(*tx_cmd));
 	dev_cmd->hdr.cmd = TX_CMD;
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
@@ -597,7 +592,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 }
 
 static void iwl_mvm_skb_prepare_status(struct sk_buff *skb,
-				       struct iwl_device_cmd *cmd)
+				       struct iwl_device_tx_cmd *cmd)
 {
 	struct ieee80211_tx_info *skb_info = IEEE80211_SKB_CB(skb);
 
@@ -716,7 +711,7 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info info;
-	struct iwl_device_cmd *dev_cmd;
+	struct iwl_device_tx_cmd *dev_cmd;
 	u8 sta_id;
 	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
 	__le16 fc = hdr->frame_control;
@@ -1078,7 +1073,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct iwl_mvm_sta *mvmsta;
-	struct iwl_device_cmd *dev_cmd;
+	struct iwl_device_tx_cmd *dev_cmd;
 	__le16 fc;
 	u16 seq_number = 0;
 	u8 tid = IWL_MAX_TID_COUNT;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 3688911ce3df..04361ecf31bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -305,7 +305,7 @@ struct iwl_cmd_meta {
 #define IWL_FIRST_TB_SIZE_ALIGN ALIGN(IWL_FIRST_TB_SIZE, 64)
 
 struct iwl_pcie_txq_entry {
-	struct iwl_device_cmd *cmd;
+	void *cmd;
 	struct sk_buff *skb;
 	/* buffer to free after command completes */
 	const void *free_buf;
@@ -688,7 +688,7 @@ void iwl_trans_pcie_txq_set_shared_mode(struct iwl_trans *trans, u32 txq_id,
 void iwl_trans_pcie_log_scd_error(struct iwl_trans *trans,
 				  struct iwl_txq *txq);
 int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
-		      struct iwl_device_cmd *dev_cmd, int txq_id);
+		      struct iwl_device_tx_cmd *dev_cmd, int txq_id);
 void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans);
 int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
 void iwl_pcie_cmdq_reclaim(struct iwl_trans *trans, int txq_id, int idx);
@@ -1107,7 +1107,7 @@ int iwl_trans_pcie_dyn_txq_alloc(struct iwl_trans *trans,
 				 unsigned int timeout);
 void iwl_trans_pcie_dyn_txq_free(struct iwl_trans *trans, int queue);
 int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
-			   struct iwl_device_cmd *dev_cmd, int txq_id);
+			   struct iwl_device_tx_cmd *dev_cmd, int txq_id);
 int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
 				  struct iwl_host_cmd *cmd);
 void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a0677131634d..91fa439d1255 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -79,6 +79,7 @@
 #include "iwl-agn-hw.h"
 #include "fw/error-dump.h"
 #include "fw/dbg.h"
+#include "fw/api/tx.h"
 #include "internal.h"
 #include "iwl-fh.h"
 
@@ -3460,19 +3461,34 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 {
 	struct iwl_trans_pcie *trans_pcie;
 	struct iwl_trans *trans;
-	int ret, addr_size;
+	int ret, addr_size, txcmd_size, txcmd_align;
+	const struct iwl_trans_ops *ops = &trans_ops_pcie_gen2;
+
+	if (!cfg_trans->gen2) {
+		ops = &trans_ops_pcie;
+		txcmd_size = sizeof(struct iwl_tx_cmd);
+		txcmd_align = sizeof(void *);
+	} else if (cfg_trans->device_family < IWL_DEVICE_FAMILY_AX210) {
+		txcmd_size = sizeof(struct iwl_tx_cmd_gen2);
+		txcmd_align = 64;
+	} else {
+		txcmd_size = sizeof(struct iwl_tx_cmd_gen3);
+		txcmd_align = 128;
+	}
+
+	txcmd_size += sizeof(struct iwl_cmd_header);
+	txcmd_size += 36; /* biggest possible 802.11 header */
+
+	/* Ensure device TX cmd cannot reach/cross a page boundary in gen2 */
+	if (WARN_ON(cfg_trans->gen2 && txcmd_size >= txcmd_align))
+		return ERR_PTR(-EINVAL);
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (cfg_trans->gen2)
-		trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie),
-					&pdev->dev, &trans_ops_pcie_gen2);
-	else
-		trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie),
-					&pdev->dev, &trans_ops_pcie);
-
+	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev, ops,
+				txcmd_size, txcmd_align);
 	if (!trans)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 090c1156bc21..4adda83d5f02 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -365,7 +365,8 @@ static int iwl_pcie_gen2_set_tb_with_wa(struct iwl_trans *trans,
 static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 				     struct sk_buff *skb,
 				     struct iwl_tfh_tfd *tfd, int start_len,
-				     u8 hdr_len, struct iwl_device_cmd *dev_cmd)
+				     u8 hdr_len,
+				     struct iwl_device_tx_cmd *dev_cmd)
 {
 #ifdef CONFIG_INET
 	struct iwl_tx_cmd_gen2 *tx_cmd = (void *)dev_cmd->payload;
@@ -496,7 +497,7 @@ static int iwl_pcie_gen2_build_amsdu(struct iwl_trans *trans,
 static struct
 iwl_tfh_tfd *iwl_pcie_gen2_build_tx_amsdu(struct iwl_trans *trans,
 					  struct iwl_txq *txq,
-					  struct iwl_device_cmd *dev_cmd,
+					  struct iwl_device_tx_cmd *dev_cmd,
 					  struct sk_buff *skb,
 					  struct iwl_cmd_meta *out_meta,
 					  int hdr_len,
@@ -533,6 +534,10 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx_amsdu(struct iwl_trans *trans,
 	tb_phys = dma_map_single(trans->dev, tb1_addr, len, DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
 		goto out_err;
+	/*
+	 * No need for _with_wa(), we ensure (via alignment) that the data
+	 * here can never cross or end at a page boundary.
+	 */
 	iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, len);
 
 	if (iwl_pcie_gen2_build_amsdu(trans, skb, tfd,
@@ -580,7 +585,7 @@ static int iwl_pcie_gen2_tx_add_frags(struct iwl_trans *trans,
 static struct
 iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
 				    struct iwl_txq *txq,
-				    struct iwl_device_cmd *dev_cmd,
+				    struct iwl_device_tx_cmd *dev_cmd,
 				    struct sk_buff *skb,
 				    struct iwl_cmd_meta *out_meta,
 				    int hdr_len,
@@ -625,6 +630,10 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
 	tb_phys = dma_map_single(trans->dev, tb1_addr, tb1_len, DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
 		goto out_err;
+	/*
+	 * No need for _with_wa(), we ensure (via alignment) that the data
+	 * here can never cross or end at a page boundary.
+	 */
 	iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, tb1_len);
 	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd), &dev_cmd->hdr,
 			     IWL_FIRST_TB_SIZE + tb1_len, hdr_len);
@@ -671,7 +680,7 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(struct iwl_trans *trans,
 static
 struct iwl_tfh_tfd *iwl_pcie_gen2_build_tfd(struct iwl_trans *trans,
 					    struct iwl_txq *txq,
-					    struct iwl_device_cmd *dev_cmd,
+					    struct iwl_device_tx_cmd *dev_cmd,
 					    struct sk_buff *skb,
 					    struct iwl_cmd_meta *out_meta)
 {
@@ -711,7 +720,7 @@ struct iwl_tfh_tfd *iwl_pcie_gen2_build_tfd(struct iwl_trans *trans,
 }
 
 int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
-			   struct iwl_device_cmd *dev_cmd, int txq_id)
+			   struct iwl_device_tx_cmd *dev_cmd, int txq_id)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_cmd_meta *out_meta;
@@ -736,7 +745,7 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 		/* don't put the packet on the ring, if there is no room */
 		if (unlikely(iwl_queue_space(trans, txq) < 3)) {
-			struct iwl_device_cmd **dev_cmd_ptr;
+			struct iwl_device_tx_cmd **dev_cmd_ptr;
 
 			dev_cmd_ptr = (void *)((u8 *)skb->cb +
 					       trans_pcie->dev_cmd_offs);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index ba37b780dec4..b0eb52b4951b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -213,8 +213,8 @@ static void iwl_pcie_txq_update_byte_cnt_tbl(struct iwl_trans *trans,
 	u8 sec_ctl = 0;
 	u16 len = byte_cnt + IWL_TX_CRC_SIZE + IWL_TX_DELIMITER_SIZE;
 	__le16 bc_ent;
-	struct iwl_tx_cmd *tx_cmd =
-		(void *)txq->entries[txq->write_ptr].cmd->payload;
+	struct iwl_device_tx_cmd *dev_cmd = txq->entries[txq->write_ptr].cmd;
+	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
 	u8 sta_id = tx_cmd->sta_id;
 
 	scd_bc_tbl = trans_pcie->scd_bc_tbls.addr;
@@ -257,8 +257,8 @@ static void iwl_pcie_txq_inval_byte_cnt_tbl(struct iwl_trans *trans,
 	int read_ptr = txq->read_ptr;
 	u8 sta_id = 0;
 	__le16 bc_ent;
-	struct iwl_tx_cmd *tx_cmd =
-		(void *)txq->entries[read_ptr].cmd->payload;
+	struct iwl_device_tx_cmd *dev_cmd = txq->entries[read_ptr].cmd;
+	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
 
 	WARN_ON(read_ptr >= TFD_QUEUE_SIZE_MAX);
 
@@ -1202,7 +1202,7 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 
 		while (!skb_queue_empty(&overflow_skbs)) {
 			struct sk_buff *skb = __skb_dequeue(&overflow_skbs);
-			struct iwl_device_cmd *dev_cmd_ptr;
+			struct iwl_device_tx_cmd *dev_cmd_ptr;
 
 			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
 						 trans_pcie->dev_cmd_offs);
@@ -2125,7 +2125,8 @@ static void iwl_compute_pseudo_hdr_csum(void *iph, struct tcphdr *tcph,
 static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_txq *txq, u8 hdr_len,
 				   struct iwl_cmd_meta *out_meta,
-				   struct iwl_device_cmd *dev_cmd, u16 tb1_len)
+				   struct iwl_device_tx_cmd *dev_cmd,
+				   u16 tb1_len)
 {
 	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
 	struct iwl_trans_pcie *trans_pcie = txq->trans_pcie;
@@ -2303,7 +2304,8 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_txq *txq, u8 hdr_len,
 				   struct iwl_cmd_meta *out_meta,
-				   struct iwl_device_cmd *dev_cmd, u16 tb1_len)
+				   struct iwl_device_tx_cmd *dev_cmd,
+				   u16 tb1_len)
 {
 	/* No A-MSDU without CONFIG_INET */
 	WARN_ON(1);
@@ -2313,7 +2315,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 #endif /* CONFIG_INET */
 
 int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
-		      struct iwl_device_cmd *dev_cmd, int txq_id)
+		      struct iwl_device_tx_cmd *dev_cmd, int txq_id)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct ieee80211_hdr *hdr;
@@ -2370,7 +2372,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 		/* don't put the packet on the ring, if there is no room */
 		if (unlikely(iwl_queue_space(trans, txq) < 3)) {
-			struct iwl_device_cmd **dev_cmd_ptr;
+			struct iwl_device_tx_cmd **dev_cmd_ptr;
 
 			dev_cmd_ptr = (void *)((u8 *)skb->cb +
 					       trans_pcie->dev_cmd_offs);
-- 
2.24.0

