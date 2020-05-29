Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3331E760F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgE2Gjt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 02:39:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:35022 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbgE2Gjs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 02:39:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jeYgC-000jvb-RX; Fri, 29 May 2020 09:39:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 09:39:27 +0300
Message-Id: <iwlwifi.20200529092401.d9d0082b8369.I8298f6e83804c1ea99217a79d95d23ef68b184d4@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063931.80551-1-luca@coelho.fi>
References: <20200529063931.80551-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/11] iwlwifi: move iwl_txq and substructures to a common trans header
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The txq code is not directly related to the PCIe transport, so move the
structures it uses to the common iwl-trans.h header.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 107 ++++++++++++++++++
 .../wireless/intel/iwlwifi/pcie/internal.h    | 107 ------------------
 2 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index bba527b339b5..57361b27351e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -795,6 +795,113 @@ struct iwl_trans_debug {
 	u32 domains_bitmap;
 };
 
+struct iwl_dma_ptr {
+	dma_addr_t dma;
+	void *addr;
+	size_t size;
+};
+
+struct iwl_cmd_meta {
+	/* only for SYNC commands, iff the reply skb is wanted */
+	struct iwl_host_cmd *source;
+	u32 flags;
+	u32 tbs;
+};
+
+/*
+ * The FH will write back to the first TB only, so we need to copy some data
+ * into the buffer regardless of whether it should be mapped or not.
+ * This indicates how big the first TB must be to include the scratch buffer
+ * and the assigned PN.
+ * Since PN location is 8 bytes at offset 12, it's 20 now.
+ * If we make it bigger then allocations will be bigger and copy slower, so
+ * that's probably not useful.
+ */
+#define IWL_FIRST_TB_SIZE	20
+#define IWL_FIRST_TB_SIZE_ALIGN ALIGN(IWL_FIRST_TB_SIZE, 64)
+
+struct iwl_pcie_txq_entry {
+	void *cmd;
+	struct sk_buff *skb;
+	/* buffer to free after command completes */
+	const void *free_buf;
+	struct iwl_cmd_meta meta;
+};
+
+struct iwl_pcie_first_tb_buf {
+	u8 buf[IWL_FIRST_TB_SIZE_ALIGN];
+};
+
+/**
+ * struct iwl_txq - Tx Queue for DMA
+ * @q: generic Rx/Tx queue descriptor
+ * @tfds: transmit frame descriptors (DMA memory)
+ * @first_tb_bufs: start of command headers, including scratch buffers, for
+ *	the writeback -- this is DMA memory and an array holding one buffer
+ *	for each command on the queue
+ * @first_tb_dma: DMA address for the first_tb_bufs start
+ * @entries: transmit entries (driver state)
+ * @lock: queue lock
+ * @stuck_timer: timer that fires if queue gets stuck
+ * @trans: pointer back to transport (for timer)
+ * @need_update: indicates need to update read/write index
+ * @ampdu: true if this queue is an ampdu queue for an specific RA/TID
+ * @wd_timeout: queue watchdog timeout (jiffies) - per queue
+ * @frozen: tx stuck queue timer is frozen
+ * @frozen_expiry_remainder: remember how long until the timer fires
+ * @bc_tbl: byte count table of the queue (relevant only for gen2 transport)
+ * @write_ptr: 1-st empty entry (index) host_w
+ * @read_ptr: last used entry (index) host_r
+ * @dma_addr:  physical addr for BD's
+ * @n_window: safe queue window
+ * @id: queue id
+ * @low_mark: low watermark, resume queue if free space more than this
+ * @high_mark: high watermark, stop queue if free space less than this
+ *
+ * A Tx queue consists of circular buffer of BDs (a.k.a. TFDs, transmit frame
+ * descriptors) and required locking structures.
+ *
+ * Note the difference between TFD_QUEUE_SIZE_MAX and n_window: the hardware
+ * always assumes 256 descriptors, so TFD_QUEUE_SIZE_MAX is always 256 (unless
+ * there might be HW changes in the future). For the normal TX
+ * queues, n_window, which is the size of the software queue data
+ * is also 256; however, for the command queue, n_window is only
+ * 32 since we don't need so many commands pending. Since the HW
+ * still uses 256 BDs for DMA though, TFD_QUEUE_SIZE_MAX stays 256.
+ * This means that we end up with the following:
+ *  HW entries: | 0 | ... | N * 32 | ... | N * 32 + 31 | ... | 255 |
+ *  SW entries:           | 0      | ... | 31          |
+ * where N is a number between 0 and 7. This means that the SW
+ * data is a window overlayed over the HW queue.
+ */
+struct iwl_txq {
+	void *tfds;
+	struct iwl_pcie_first_tb_buf *first_tb_bufs;
+	dma_addr_t first_tb_dma;
+	struct iwl_pcie_txq_entry *entries;
+	/* lock for syncing changes on the queue */
+	spinlock_t lock;
+	unsigned long frozen_expiry_remainder;
+	struct timer_list stuck_timer;
+	struct iwl_trans *trans;
+	bool need_update;
+	bool frozen;
+	bool ampdu;
+	int block;
+	unsigned long wd_timeout;
+	struct sk_buff_head overflow_q;
+	struct iwl_dma_ptr bc_tbl;
+
+	int write_ptr;
+	int read_ptr;
+	dma_addr_t dma_addr;
+	int n_window;
+	u32 id;
+	int low_mark;
+	int high_mark;
+
+	bool overflow_tx;
+};
 /**
  * struct iwl_trans - transport common data
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 3950f5784a15..3c6a119aede4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -246,12 +246,6 @@ struct iwl_rb_allocator {
 	struct work_struct rx_alloc;
 };
 
-struct iwl_dma_ptr {
-	dma_addr_t dma;
-	void *addr;
-	size_t size;
-};
-
 /**
  * iwl_queue_inc_wrap - increment queue index, wrap back to beginning
  * @index -- current index
@@ -290,107 +284,6 @@ static inline int iwl_queue_dec_wrap(struct iwl_trans *trans, int index)
 		(trans->trans_cfg->base_params->max_tfd_queue_size - 1);
 }
 
-struct iwl_cmd_meta {
-	/* only for SYNC commands, iff the reply skb is wanted */
-	struct iwl_host_cmd *source;
-	u32 flags;
-	u32 tbs;
-};
-
-/*
- * The FH will write back to the first TB only, so we need to copy some data
- * into the buffer regardless of whether it should be mapped or not.
- * This indicates how big the first TB must be to include the scratch buffer
- * and the assigned PN.
- * Since PN location is 8 bytes at offset 12, it's 20 now.
- * If we make it bigger then allocations will be bigger and copy slower, so
- * that's probably not useful.
- */
-#define IWL_FIRST_TB_SIZE	20
-#define IWL_FIRST_TB_SIZE_ALIGN ALIGN(IWL_FIRST_TB_SIZE, 64)
-
-struct iwl_pcie_txq_entry {
-	void *cmd;
-	struct sk_buff *skb;
-	/* buffer to free after command completes */
-	const void *free_buf;
-	struct iwl_cmd_meta meta;
-};
-
-struct iwl_pcie_first_tb_buf {
-	u8 buf[IWL_FIRST_TB_SIZE_ALIGN];
-};
-
-/**
- * struct iwl_txq - Tx Queue for DMA
- * @q: generic Rx/Tx queue descriptor
- * @tfds: transmit frame descriptors (DMA memory)
- * @first_tb_bufs: start of command headers, including scratch buffers, for
- *	the writeback -- this is DMA memory and an array holding one buffer
- *	for each command on the queue
- * @first_tb_dma: DMA address for the first_tb_bufs start
- * @entries: transmit entries (driver state)
- * @lock: queue lock
- * @stuck_timer: timer that fires if queue gets stuck
- * @trans: pointer back to transport (for timer)
- * @need_update: indicates need to update read/write index
- * @ampdu: true if this queue is an ampdu queue for an specific RA/TID
- * @wd_timeout: queue watchdog timeout (jiffies) - per queue
- * @frozen: tx stuck queue timer is frozen
- * @frozen_expiry_remainder: remember how long until the timer fires
- * @bc_tbl: byte count table of the queue (relevant only for gen2 transport)
- * @write_ptr: 1-st empty entry (index) host_w
- * @read_ptr: last used entry (index) host_r
- * @dma_addr:  physical addr for BD's
- * @n_window: safe queue window
- * @id: queue id
- * @low_mark: low watermark, resume queue if free space more than this
- * @high_mark: high watermark, stop queue if free space less than this
- *
- * A Tx queue consists of circular buffer of BDs (a.k.a. TFDs, transmit frame
- * descriptors) and required locking structures.
- *
- * Note the difference between TFD_QUEUE_SIZE_MAX and n_window: the hardware
- * always assumes 256 descriptors, so TFD_QUEUE_SIZE_MAX is always 256 (unless
- * there might be HW changes in the future). For the normal TX
- * queues, n_window, which is the size of the software queue data
- * is also 256; however, for the command queue, n_window is only
- * 32 since we don't need so many commands pending. Since the HW
- * still uses 256 BDs for DMA though, TFD_QUEUE_SIZE_MAX stays 256.
- * This means that we end up with the following:
- *  HW entries: | 0 | ... | N * 32 | ... | N * 32 + 31 | ... | 255 |
- *  SW entries:           | 0      | ... | 31          |
- * where N is a number between 0 and 7. This means that the SW
- * data is a window overlayed over the HW queue.
- */
-struct iwl_txq {
-	void *tfds;
-	struct iwl_pcie_first_tb_buf *first_tb_bufs;
-	dma_addr_t first_tb_dma;
-	struct iwl_pcie_txq_entry *entries;
-	spinlock_t lock;
-	unsigned long frozen_expiry_remainder;
-	struct timer_list stuck_timer;
-	struct iwl_trans *trans;
-	bool need_update;
-	bool frozen;
-	bool ampdu;
-	int block;
-	unsigned long wd_timeout;
-	struct sk_buff_head overflow_q;
-	struct iwl_dma_ptr bc_tbl;
-
-	int write_ptr;
-	int read_ptr;
-	dma_addr_t dma_addr;
-	int n_window;
-	u32 id;
-	int low_mark;
-	int high_mark;
-
-	bool overflow_tx;
-};
-
 static inline dma_addr_t
 iwl_pcie_get_first_tb_dma(struct iwl_txq *txq, int idx)
 {
-- 
2.26.2

