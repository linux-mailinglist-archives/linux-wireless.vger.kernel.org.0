Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980DB78D9B9
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjH3Sd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242438AbjH3Ibr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F771A6
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384304; x=1724920304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtgfQCRJY+o2ZJPziVu3rsTrR9FC438nK8y6P5p+2J8=;
  b=VaAXNqqEO80LHBIpQv7jqlqxug1uOvlKtAjvBghHhqn4iAgy/bMODbZR
   h5AFrPGQDE968S+F0GkMMqP1P3H/pl8I6yXfDOvK4iUJY3i12GcmF6lZS
   yIbj8KliW1nEL+HzoceT8BwvCfY/t5auaNGWzL3UrUXOjTOGogCgI5lFt
   eJ970xvSaJL3QN1V/ceTqxZ9S5mFB6cMUYtmGeY4tbFUNufgzJZKmr6aU
   hsEIt4AmhNLZT+nWIOAmUtSP9yIgXo22qM+5c4KCkQc6H2ADM7WRa4dgK
   LcXZxpr0qH5dTUSS5m2pwXMvn5br2Gm1wbh8NhY0WuMtyhNl86696i7SS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958992"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958992"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152332"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152332"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/16] wifi: iwlwifi: pcie: fix kernel-doc issues
Date:   Wed, 30 Aug 2023 11:30:57 +0300
Message-Id: <20230830112059.a11b39f9a07e.Ia7b189f003db8f6ccaf0a547e71c80e00b85fb5a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Fix various missing kernel-doc annotations etc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    | 51 +++++++++++++------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 0f6493dab8cb..e4b0c4543424 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -58,10 +58,7 @@ struct iwl_rx_mem_buffer {
 	bool invalid;
 };
 
-/**
- * struct isr_statistics - interrupt statistics
- *
- */
+/* interrupt statistics */
 struct isr_statistics {
 	u32 hw;
 	u32 sw;
@@ -127,6 +124,8 @@ struct iwl_rx_completion_desc_bz {
  * @used_bd_dma: physical address of buffer of used receive buffer descriptors (rbd)
  * @read: Shared index to newest available Rx buffer
  * @write: Shared index to oldest written Rx packet
+ * @write_actual: actual write pointer written to device, since we update in
+ *	blocks of 8 only
  * @free_count: Number of pre-allocated buffers in rx_free
  * @used_count: Number of RBDs handled to allocator to use for allocation
  * @write_actual:
@@ -135,10 +134,12 @@ struct iwl_rx_completion_desc_bz {
  * @need_update: flag to indicate we need to update read/write index
  * @rb_stts: driver's pointer to receive buffer status
  * @rb_stts_dma: bus address of receive buffer status
- * @lock:
+ * @lock: per-queue lock
  * @queue: actual rx queue. Not used for multi-rx queue.
  * @next_rb_is_fragment: indicates that the previous RB that we handled set
  *	the fragmented flag, so the next one is still another fragment
+ * @napi: NAPI struct for this queue
+ * @queue_size: size of this queue
  *
  * NOTE:  rx_free and rx_used are used as a FIFO for iwl_rx_mem_buffers
  */
@@ -188,7 +189,8 @@ struct iwl_rb_allocator {
 
 /**
  * iwl_get_closed_rb_stts - get closed rb stts from different structs
- * @rxq - the rxq to get the rb stts from
+ * @trans: transport pointer (for configuration)
+ * @rxq: the rxq to get the rb stts from
  */
 static inline __le16 iwl_get_closed_rb_stts(struct iwl_trans *trans,
 					    struct iwl_rxq *rxq)
@@ -243,6 +245,7 @@ enum iwl_image_response_code {
 	IWL_IMAGE_RESP_FAIL		= 2,
 };
 
+#ifdef CONFIG_IWLWIFI_DEBUGFS
 /**
  * struct cont_rec: continuous recording data structure
  * @prev_wr_ptr: the last address that was read in monitor_data
@@ -253,7 +256,6 @@ enum iwl_image_response_code {
  *	in &iwl_fw_mon_dbgfs_state enum
  * @mutex: locked while reading from monitor_data debugfs file
  */
-#ifdef CONFIG_IWLWIFI_DEBUGFS
 struct cont_rec {
 	u32 prev_wr_ptr;
 	u32 prev_wrap_cnt;
@@ -298,10 +300,6 @@ enum iwl_pcie_imr_status {
  * @prph_info_dma_addr: dma addr of prph info
  * @prph_scratch_dma_addr: dma addr of prph scratch
  * @ctxt_info_dma_addr: dma addr of context information
- * @init_dram: DRAM data of firmware image (including paging).
- *	Context information addresses will be taken from here.
- *	This is driver's local copy for keeping track of size and
- *	count for allocating and freeing the memory.
  * @iml: image loader image virtual address
  * @iml_dma_addr: image loader image DMA address
  * @trans: pointer to the generic transport area
@@ -321,10 +319,9 @@ enum iwl_pcie_imr_status {
  * @rx_buf_bytes: RX buffer (RB) size in bytes
  * @reg_lock: protect hw register access
  * @mutex: to protect stop_device / start_fw / start_hw
- * @cmd_in_flight: true when we have a host command in flight
-#ifdef CONFIG_IWLWIFI_DEBUGFS
  * @fw_mon_data: fw continuous recording data
-#endif
+ * @cmd_hold_nic_awake: indicates NIC is held awake for APMG workaround
+ *	during commands in flight
  * @msix_entries: array of MSI-X entries
  * @msix_enabled: true if managed to enable MSI-X
  * @shared_vec_mask: the type of causes the shared vector handles
@@ -344,8 +341,32 @@ enum iwl_pcie_imr_status {
  * @alloc_page: allocated page to still use parts of
  * @alloc_page_used: how much of the allocated page was already used (bytes)
  * @imr_status: imr dma state machine
- * @wait_queue_head_t: imr wait queue for dma completion
+ * @imr_waitq: imr wait queue for dma completion
  * @rf_name: name/version of the CRF, if any
+ * @use_ict: whether or not ICT (interrupt table) is used
+ * @ict_index: current ICT read index
+ * @ict_tbl: ICT table pointer
+ * @ict_tbl_dma: ICT table DMA address
+ * @inta_mask: interrupt (INT-A) mask
+ * @irq_lock: lock to synchronize IRQ handling
+ * @txq_memory: TXQ allocation array
+ * @sx_waitq: waitqueue for Sx transitions
+ * @sx_complete: completion for Sx transitions
+ * @pcie_dbg_dumped_once: indicates PCIe regs were dumped already
+ * @opmode_down: indicates opmode went away
+ * @num_rx_bufs: number of RX buffers to allocate/use
+ * @no_reclaim_cmds: special commands not using reclaim flow
+ *	(firmware workaround)
+ * @n_no_reclaim_cmds: number of special commands not using reclaim flow
+ * @affinity_mask: IRQ affinity mask for each RX queue
+ * @debug_rfkill: RF-kill debugging state, -1 for unset, 0/1 for radio
+ *	enable/disable
+ * @fw_reset_handshake: indicates FW reset handshake is needed
+ * @fw_reset_state: state of FW reset handshake
+ * @fw_reset_waitq: waitqueue for FW reset handshake
+ * @is_down: indicates the NIC is down
+ * @isr_stats: interrupt statistics
+ * @napi_dev: (fake) netdev for NAPI registration
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
-- 
2.38.1

