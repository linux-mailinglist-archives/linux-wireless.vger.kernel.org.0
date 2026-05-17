Return-Path: <linux-wireless+bounces-36542-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCkOLsB1CWolbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36542-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:01:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF5355FD67
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CC57301841C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77152E8B9B;
	Sun, 17 May 2026 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lu0r1d3P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CCB2E1F06
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004834; cv=none; b=bQMc/pFe7I+sEPGy9KbqgE66doIpRMk6TyfIM6NELcX8Fwho2LYgLF1fsXnhAtAwX9Y+eeTm8KO+h7PEhgntFu78r2zC0YjVLx6Einydv4Xxd1zV15rBvjUj4uHE/l2WwiRX+2u0VVn83ALDhHPljqBuUcAJM5VGtaLz46CcCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004834; c=relaxed/simple;
	bh=z7nNcbK0nwwNk5a7HWv384DUDZfPRT5hbvRJIKyfMWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyujtaxnso6qGlbyS4zozE4polKlEtLjaMcsG5hrgzM6mOvYwnlyK5HfdRNZ9WktPRaFsxUjcRvO4fjaGU/Eo7IJXmSbJ3lElC6bzxH45cS9+Iw4cFscUd3jNtHtct292m5CH8AixwQmymciOO1KmL3ZiFv6EJ6iqdANA/BzwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lu0r1d3P; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004833; x=1810540833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z7nNcbK0nwwNk5a7HWv384DUDZfPRT5hbvRJIKyfMWg=;
  b=Lu0r1d3P25y+rq0zougZGb5SPjL47skt7O3GA/s35tlgVCv+m0rRe1SS
   MlHt/g7oQulvasDGa9C5MCKt1ag4JYMoiaNSK5iADzyXnrqg0ZoFn/Rqr
   yrXyZA0z6SqiLXq5NVAMGahyWrNUs821OxvdJ4oBAgB148lNGTCCT9zFy
   qvo4bLmScPn9nsk394I1Ps2aEI2hb2AymBIt3MxVCQmUKAvUVwt3ra55p
   fPSHISeHtV5VzbBJpLlD/HDJ4tcYLrzgnOrotuYC3WKmlZnUx71pac6eB
   kzZeIqOpLasddv8tqHa5o0eXRnMWGhV08j9anH1I6HUdsmuYwlaJsYAN9
   w==;
X-CSE-ConnectionGUID: tIIdZwRBSeGlit06xmIBsg==
X-CSE-MsgGUID: ykgtN4snTAmuj6OoKRNabA==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606958"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:32 -0700
X-CSE-ConnectionGUID: y67maJOdTqCH1HyU+L/4Qw==
X-CSE-MsgGUID: jb8QVOMoSy6ldl8Fu/35eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490437"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 06/15] wifi: iwlwifi: move pcie content to pcie internal transport
Date: Sun, 17 May 2026 10:59:50 +0300
Message-Id: <20260517100550.208921548b4b.I76b1ac8499275e6d231880861e3843278f278c34@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
References: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CF5355FD67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36542-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The iwl_txq, iwl_pcie_first_tb_buf and iwl_pcie_txq_entry don't need to
be exported to the op_mode in iwl-trans.h. Declare those in the
transport's internal header file to avoid pollution.
iwl_trans_pcie_send_hcmd can also be moved to the internal header file.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 105 +-----------------
 .../intel/iwlwifi/pcie/gen1_2/internal.h      | 105 +++++++++++++++++-
 2 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 61e4f4776dcb..c661807c6e6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -700,106 +700,6 @@ struct iwl_cmd_meta {
 	u32 tbs;
 };
 
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
- * @tfds: transmit frame descriptors (DMA memory)
- * @first_tb_bufs: start of command headers, including scratch buffers, for
- *	the writeback -- this is DMA memory and an array holding one buffer
- *	for each command on the queue
- * @first_tb_dma: DMA address for the first_tb_bufs start
- * @entries: transmit entries (driver state)
- * @lock: queue lock
- * @reclaim_lock: reclaim lock
- * @stuck_timer: timer that fires if queue gets stuck
- * @trans: pointer back to transport (for timer)
- * @need_update: indicates need to update read/write index
- * @ampdu: true if this queue is an ampdu queue for an specific RA/TID
- * @wd_timeout: queue watchdog timeout (jiffies) - per queue
- * @frozen: tx stuck queue timer is frozen
- * @frozen_expiry_remainder: remember how long until the timer fires
- * @block: queue is blocked
- * @bc_tbl: byte count table of the queue (relevant only for gen2 transport)
- * @write_ptr: 1-st empty entry (index) host_w
- * @read_ptr: last used entry (index) host_r
- * @dma_addr:  physical addr for BD's
- * @n_window: safe queue window
- * @id: queue id
- * @low_mark: low watermark, resume queue if free space more than this
- * @high_mark: high watermark, stop queue if free space less than this
- * @overflow_q: overflow queue for handling frames that didn't fit on HW queue
- * @overflow_tx: need to transmit from overflow
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
-	/* lock for syncing changes on the queue */
-	spinlock_t lock;
-	/* lock to prevent concurrent reclaim */
-	spinlock_t reclaim_lock;
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
 /**
  * struct iwl_trans_info - transport info for outside use
  * @name: the device name
@@ -1236,9 +1136,6 @@ enum iwl_reset_mode {
 void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode);
 void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans);
 
-int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
-			     struct iwl_host_cmd *cmd);
-
 /* Internal helper */
 static inline void iwl_trans_set_info(struct iwl_trans *trans,
 				      struct iwl_trans_info *info)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 7b7b35e442f9..24f8714eae9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2025 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -287,6 +287,106 @@ enum iwl_pcie_imr_status {
 	IMR_D2S_ERROR,
 };
 
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
+ * @tfds: transmit frame descriptors (DMA memory)
+ * @first_tb_bufs: start of command headers, including scratch buffers, for
+ *	the writeback -- this is DMA memory and an array holding one buffer
+ *	for each command on the queue
+ * @first_tb_dma: DMA address for the first_tb_bufs start
+ * @entries: transmit entries (driver state)
+ * @lock: queue lock
+ * @reclaim_lock: reclaim lock
+ * @stuck_timer: timer that fires if queue gets stuck
+ * @trans: pointer back to transport (for timer)
+ * @need_update: indicates need to update read/write index
+ * @ampdu: true if this queue is an ampdu queue for a specific RA/TID
+ * @wd_timeout: queue watchdog timeout (jiffies) - per queue
+ * @frozen: tx stuck queue timer is frozen
+ * @frozen_expiry_remainder: remember how long until the timer fires
+ * @block: queue is blocked
+ * @bc_tbl: byte count table of the queue (relevant only for gen2 transport)
+ * @write_ptr: 1-st empty entry (index) host_w
+ * @read_ptr: last used entry (index) host_r
+ * @dma_addr: physical addr for BDs
+ * @n_window: safe queue window
+ * @id: queue id
+ * @low_mark: low watermark, resume queue if free space more than this
+ * @high_mark: high watermark, stop queue if free space less than this
+ * @overflow_q: overflow queue for handling frames that didn't fit on HW queue
+ * @overflow_tx: need to transmit from overflow
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
+ * data is a window overlaid over the HW queue.
+ */
+struct iwl_txq {
+	void *tfds;
+	struct iwl_pcie_first_tb_buf *first_tb_bufs;
+	dma_addr_t first_tb_dma;
+	struct iwl_pcie_txq_entry *entries;
+	/* lock for syncing changes on the queue */
+	spinlock_t lock;
+	/* lock to prevent concurrent reclaim */
+	spinlock_t reclaim_lock;
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
+
 /**
  * struct iwl_pcie_txqs - TX queues data
  *
@@ -1153,6 +1253,9 @@ int iwl_trans_pcie_copy_imr(struct iwl_trans *trans,
 int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
 				struct iwl_trans_rxq_dma_data *data);
 
+int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans,
+			     struct iwl_host_cmd *cmd);
+
 static inline bool iwl_pcie_gen1_is_pm_supported(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-- 
2.34.1


