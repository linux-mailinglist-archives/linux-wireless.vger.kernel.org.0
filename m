Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4010749FAD0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348902AbiA1Net (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37858 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348939AbiA1Nes (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:48 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROn-0002DK-PY;
        Fri, 28 Jan 2022 15:34:46 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:29 +0200
Message-Id: <iwlwifi.20220128153014.e349104ecd94.Iadc937f475158b9437becdfefb361a97e7eaa934@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/13] iwlwifi: avoid void pointer arithmetic
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Avoid void pointer arithmetic since it's technically
undefined and causes warnings in some places that use
our code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      | 6 +++---
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      | 2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 7ad9cee925da..cef3f54908fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1992,7 +1992,7 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	u32 type = reg->type;
 	u32 id = le32_to_cpu(reg->id);
 	u32 num_of_ranges, i, size;
-	void *range;
+	u8 *range;
 
 	/*
 	 * The higher part of the ID from 2 is irrelevant for
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/paging.c b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
index 89ec3693c6ac..945bc4160cc9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -197,7 +197,7 @@ static int iwl_fill_paging_mem(struct iwl_fw_runtime *fwrt,
 		}
 
 		memcpy(page_address(block->fw_paging_block),
-		       image->sec[sec_idx].data + offset, len);
+		       (const u8 *)image->sec[sec_idx].data + offset, len);
 		block->fw_offs = image->sec[sec_idx].offset + offset;
 		dma_sync_single_for_device(fwrt->trans->dev,
 					   block->fw_paging_phys,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index b1dffcde4a9a..9f0e436f11f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1084,7 +1084,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 					sizeof(struct iwl_wowlan_kek_kck_material_cmd_v2);
 			/* skip the sta_id at the beginning */
 			_kek_kck_cmd = (void *)
-				((u8 *)_kek_kck_cmd) + sizeof(kek_kck_cmd.sta_id);
+				((u8 *)_kek_kck_cmd + sizeof(kek_kck_cmd.sta_id));
 		}
 
 		IWL_DEBUG_WOWLAN(mvm, "setting akm %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index d256652a6ce3..be11161bc57d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1945,7 +1945,7 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 		goto out;
 	}
 
-	ret = len - copy_to_user(user_buf, (void *)rsp->data + delta, len);
+	ret = len - copy_to_user(user_buf, (u8 *)rsp->data + delta, len);
 	*ppos += ret;
 
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index dde979b34533..fcbe7c3656ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -735,7 +735,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 		mvm->nvm_data->bands[0].n_channels = 1;
 		mvm->nvm_data->bands[0].n_bitrates = 1;
 		mvm->nvm_data->bands[0].bitrates =
-			(void *)mvm->nvm_data->channels + 1;
+			(void *)((u8 *)mvm->nvm_data->channels + 1);
 		mvm->nvm_data->bands[0].bitrates->hw_value = 10;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 64446a11ef98..40d0e6bf336b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -83,8 +83,8 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 	fraglen = len - hdrlen;
 
 	if (fraglen) {
-		int offset = (void *)hdr + hdrlen -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + hdrlen -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);
 
 		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
 				fraglen, rxb->truesize);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 295629c5c035..18f5b1b14ae7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -214,8 +214,8 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 	fraglen = len - headlen;
 
 	if (fraglen) {
-		int offset = (void *)hdr + headlen + pad_len -
-			     rxb_addr(rxb) + rxb_offset(rxb);
+		int offset = (u8 *)hdr + headlen + pad_len -
+			     (u8 *)rxb_addr(rxb) + rxb_offset(rxb);
 
 		skb_add_rx_frag(skb, 0, rxb_steal_page(rxb), offset,
 				fraglen, rxb->truesize);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index ce7afca36bbf..0ee766c6cff8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2158,7 +2158,7 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_scan_req_umac *cmd = mvm->scan_cmd;
 	struct iwl_scan_umac_chan_param *chan_param;
 	void *cmd_data = iwl_mvm_get_scan_req_umac_data(mvm);
-	void *sec_part = cmd_data + sizeof(struct iwl_scan_channel_cfg_umac) *
+	void *sec_part = (u8 *)cmd_data + sizeof(struct iwl_scan_channel_cfg_umac) *
 		mvm->fw->ucode_capa.n_scan_channels;
 	struct iwl_scan_req_umac_tail_v2 *tail_v2 =
 		(struct iwl_scan_req_umac_tail_v2 *)sec_part;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index a43e56c7689f..6dce36d32693 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -363,7 +363,7 @@ struct iwl_trans_pcie {
 
 	/* PCI bus related data */
 	struct pci_dev *pci_dev;
-	void __iomem *hw_base;
+	u8 __iomem *hw_base;
 
 	bool ucode_write_complete;
 	bool sx_complete;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 9e488f21fde2..21cddfc279d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -727,7 +727,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 			goto err;
 	}
 
-	rxq->rb_stts = trans_pcie->base_rb_stts + rxq->id * rb_stts_size;
+	rxq->rb_stts = (u8 *)trans_pcie->base_rb_stts + rxq->id * rb_stts_size;
 	rxq->rb_stts_dma =
 		trans_pcie->base_rb_stts_dma + rxq->id * rb_stts_size;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index ea6823b73b99..94efaddfdcc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2864,7 +2864,7 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 {
 	struct iwl_trans *trans = file->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	void *cpu_addr = (void *)trans->dbg.fw_mon.block, *curr_buf;
+	u8 *cpu_addr = (void *)trans->dbg.fw_mon.block, *curr_buf;
 	struct cont_rec *data = &trans_pcie->fw_mon_data;
 	u32 write_ptr_addr, wrap_cnt_addr, write_ptr, wrap_cnt;
 	ssize_t size, bytes_copied = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index abe80083fb9b..e3b69476f515 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -154,7 +154,7 @@ static int iwl_pcie_txq_build_tfd(struct iwl_trans *trans, struct iwl_txq *txq,
 	void *tfd;
 	u32 num_tbs;
 
-	tfd = txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
+	tfd = (u8 *)txq->tfds + trans->txqs.tfd.size * txq->write_ptr;
 
 	if (reset)
 		memset(tfd, 0, trans->txqs.tfd.size);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 0730657d54bf..e31ae5d0e26a 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -189,7 +189,7 @@ static struct page *get_workaround_page(struct iwl_trans *trans,
 		return NULL;
 
 	/* set the chaining pointer to the previous page if there */
-	*(void **)(page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
+	*(void **)((u8 *)page_address(ret) + PAGE_SIZE - sizeof(void *)) = *page_ptr;
 	*page_ptr = ret;
 
 	return ret;
@@ -314,7 +314,7 @@ struct iwl_tso_hdr_page *get_page_hdr(struct iwl_trans *trans, size_t len,
 		return NULL;
 	p->pos = page_address(p->page);
 	/* set the chaining pointer to NULL */
-	*(void **)(page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
+	*(void **)((u8 *)page_address(p->page) + PAGE_SIZE - sizeof(void *)) = NULL;
 out:
 	*page_ptr = p->page;
 	get_page(p->page);
@@ -963,7 +963,7 @@ void iwl_txq_free_tso_page(struct iwl_trans *trans, struct sk_buff *skb)
 	while (next) {
 		struct page *tmp = next;
 
-		next = *(void **)(page_address(next) + PAGE_SIZE -
+		next = *(void **)((u8 *)page_address(next) + PAGE_SIZE -
 				  sizeof(void *));
 		__free_page(tmp);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 20efc62acf13..19178c88bb22 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -41,7 +41,7 @@ static inline void *iwl_txq_get_tfd(struct iwl_trans *trans,
 	if (trans->trans_cfg->use_tfh)
 		idx = iwl_txq_get_cmd_index(txq, idx);
 
-	return txq->tfds + trans->txqs.tfd.size * idx;
+	return (u8 *)txq->tfds + trans->txqs.tfd.size * idx;
 }
 
 int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
-- 
2.34.1

