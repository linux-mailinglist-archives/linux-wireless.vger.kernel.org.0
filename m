Return-Path: <linux-wireless+bounces-3357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA0784E5C9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5479EB22837
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B49382D65;
	Thu,  8 Feb 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCvhNiiv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB7823DE
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411562; cv=none; b=sg3YPnEV+1pe2X4Ws5efNKgJPZcxf3PgNmbTE/BGwKpMAwgl4X+D78k4wq6ttUx/3J88087JwktL+T5nl9DB+/qYPLz+pIggW3kW3SdbQc+lC/2IA/dtWogfU/pYfW5q6x5LMm+kjeDwakpDlXgzps7J0gbMqK9JWD/TyxM8n+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411562; c=relaxed/simple;
	bh=KktplIFUzvB4YaTIa7rTyLhMu4QYGU6v9+S4+xnKuMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmN14snklNHxSki+pcTecPv/4rlj0aLpIPoE8tw7dvlAT4pAn3s4tlpg2CedOgdIZGEnueZYLOl44hq1lhEDrmLJj5rY5bN66Qp3Autz60UlWla9VNhL/Jq3gEx+Dm/C91kmtvIPOOt6XW8eM2Ema+2dxVuZmeX380UWLR5FOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCvhNiiv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411561; x=1738947561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KktplIFUzvB4YaTIa7rTyLhMu4QYGU6v9+S4+xnKuMw=;
  b=OCvhNiivE1z/K+XU79SCxA+xh2z6A1vugfvaF6YOCWJ1aNSavYMt+6AL
   We9iGdxBnf5LWR+ANIUN9Cr0rO0CFbYsa4L32zLjTaNLE8KSz8CWRm/Y5
   lQVB87LtCROGYFCnQ4GyMnngDWQ3VKvco4hIQ2SBAyHOeePL3B6dq6rJJ
   kdxHg3pxKv1fmuobOuePMeWmmNcEpO50iE5txOEGS5Ssxbjadixvxb6gA
   CM+vhBN3FMhys/BTUSLFlgl9DpWwLYt25FDVxva1WH1z/8ncTBiSIBUJ6
   BOa8sau2qiN6ntePghhky17ZPgP3hAy/6ooCeuekd+rOmzSXKP/ncb6mN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1404022"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1404022"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318871"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/13] wifi: iwlwifi: iwl-trans.h: clean up kernel-doc
Date: Thu,  8 Feb 2024 18:58:45 +0200
Message-Id: <20240208185302.a66b5cad363b.I3ee4522ac34c3e5984fce5c1cb677fb3db7a965b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add missing kernel-doc, fix annotations, etc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 64 +++++++++++++++----
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 3047ffc24415..b93cef7b2330 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -519,6 +519,7 @@ struct iwl_pnvm_image {
  *	Must be atomic
  * @reclaim: free packet until ssn. Returns a list of freed packets.
  *	Must be atomic
+ * @set_q_ptrs: set queue pointers internally, after D3 when HW state changed
  * @txq_enable: setup a queue. To setup an AC queue, use the
  *	iwl_trans_ac_txq_enable wrapper. fw_alive must have been called before
  *	this one. The op_mode must not configure the HCMD queue. The scheduler
@@ -528,6 +529,8 @@ struct iwl_pnvm_image {
  *	hardware scheduler bug. May sleep.
  * @txq_disable: de-configure a Tx queue to send AMPDUs
  *	Must be atomic
+ * @txq_alloc: Allocate a new TX queue, may sleep.
+ * @txq_free: Free a previously allocated TX queue.
  * @txq_set_shared_mode: change Tx queue shared/unshared marking
  * @wait_tx_queues_empty: wait until tx queues are empty. May sleep.
  * @wait_txq_empty: wait until specific tx queue is empty. May sleep.
@@ -547,23 +550,27 @@ struct iwl_pnvm_image {
  *	the op_mode. May be called several times before start_fw, can't be
  *	called after that.
  * @set_pmi: set the power pmi state
+ * @sw_reset: trigger software reset of the NIC
  * @grab_nic_access: wake the NIC to be able to access non-HBUS regs.
  *	Sleeping is not allowed between grab_nic_access and
  *	release_nic_access.
  * @release_nic_access: let the NIC go to sleep. The "flags" parameter
  *	must be the same one that was sent before to the grab_nic_access.
- * @set_bits_mask - set SRAM register according to value and mask.
+ * @set_bits_mask: set SRAM register according to value and mask.
  * @dump_data: return a vmalloc'ed buffer with debug data, maybe containing last
  *	TX'ed commands and similar. The buffer will be vfree'd by the caller.
  *	Note that the transport must fill in the proper file headers.
  * @debugfs_cleanup: used in the driver unload flow to make a proper cleanup
  *	of the trans debugfs
+ * @sync_nmi: trigger a firmware NMI and wait for it to complete
  * @load_pnvm: save the pnvm data in DRAM
  * @set_pnvm: set the pnvm data in the prph scratch buffer, inside the
  *	context info.
  * @load_reduce_power: copy reduce power table to the corresponding DRAM memory
  * @set_reduce_power: set reduce power table addresses in the sratch buffer
  * @interrupts: disable/enable interrupts to transport
+ * @imr_dma_data: set up IMR DMA
+ * @rxq_dma_data: retrieve RX queue DMA data, see @struct iwl_trans_rxq_dma_data
  */
 struct iwl_trans_ops {
 
@@ -775,7 +782,7 @@ struct iwl_self_init_dram {
  * @imr_size: imr dram size received from fw
  * @sram_addr: sram address from debug tlv
  * @sram_size: sram size from debug tlv
- * @imr2sram_remainbyte`: size remained after each dma transfer
+ * @imr2sram_remainbyte: size remained after each dma transfer
  * @imr_curr_addr: current dst address used during dma transfer
  * @imr_base_addr: imr address received from fw
  */
@@ -822,12 +829,16 @@ struct iwl_pc_data {
  * @fw_mon: DRAM buffer for firmware monitor
  * @hw_error: equals true if hw error interrupt was received from the FW
  * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
+ * @unsupported_region_msk: unsupported regions out of active_regions
  * @active_regions: active regions
  * @debug_info_tlv_list: list of debug info TLVs
  * @time_point: array of debug time points
  * @periodic_trig_list: periodic triggers list
  * @domains_bitmap: bitmap of active domains other than &IWL_FW_INI_DOMAIN_ALWAYS_ON
  * @ucode_preset: preset based on ucode
+ * @restart_required: indicates debug restart is required
+ * @last_tp_resetfw: last handling of reset during debug timepoint
+ * @imr_data: IMR debug data allocation
  * @dump_file_name_ext: dump file name extension
  * @dump_file_name_ext_valid: dump file name extension if valid or not
  * @num_pc: number of program counter for cpu
@@ -930,6 +941,7 @@ struct iwl_pcie_first_tb_buf {
  * @wd_timeout: queue watchdog timeout (jiffies) - per queue
  * @frozen: tx stuck queue timer is frozen
  * @frozen_expiry_remainder: remember how long until the timer fires
+ * @block: queue is blocked
  * @bc_tbl: byte count table of the queue (relevant only for gen2 transport)
  * @write_ptr: 1-st empty entry (index) host_w
  * @read_ptr: last used entry (index) host_r
@@ -938,6 +950,8 @@ struct iwl_pcie_first_tb_buf {
  * @id: queue id
  * @low_mark: low watermark, resume queue if free space more than this
  * @high_mark: high watermark, stop queue if free space less than this
+ * @overflow_q: overflow queue for handling frames that didn't fit on HW queue
+ * @overflow_tx: need to transmit from overflow
  *
  * A Tx queue consists of circular buffer of BDs (a.k.a. TFDs, transmit frame
  * descriptors) and required locking structures.
@@ -990,10 +1004,19 @@ struct iwl_txq {
  * @bc_table_dword: true if the BC table expects DWORD (as opposed to bytes)
  * @page_offs: offset from skb->cb to mac header page pointer
  * @dev_cmd_offs: offset from skb->cb to iwl_device_tx_cmd pointer
- * @queue_used - bit mask of used queues
- * @queue_stopped - bit mask of stopped queues
+ * @queue_used: bit mask of used queues
+ * @queue_stopped: bit mask of stopped queues
+ * @txq: array of TXQ data structures representing the TXQs
  * @scd_bc_tbls: gen1 pointer to the byte count table of the scheduler
  * @queue_alloc_cmd_ver: queue allocation command version
+ * @bc_pool: bytecount DMA allocations pool
+ * @bc_tbl_size: bytecount table size
+ * @tso_hdr_page: page allocated (per CPU) for A-MSDU headers when doing TSO
+ *	(and similar usage)
+ * @tfd: TFD data
+ * @tfd.max_tbs: max number of buffers per TFD
+ * @tfd.size: TFD size
+ * @tfd.addr_size: TFD/TB address size
  */
 struct iwl_trans_txqs {
 	unsigned long queue_used[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
@@ -1026,27 +1049,35 @@ struct iwl_trans_txqs {
 /**
  * struct iwl_trans - transport common data
  *
- * @csme_own - true if we couldn't get ownership on the device
- * @ops - pointer to iwl_trans_ops
- * @op_mode - pointer to the op_mode
+ * @csme_own: true if we couldn't get ownership on the device
+ * @ops: pointer to iwl_trans_ops
+ * @op_mode: pointer to the op_mode
  * @trans_cfg: the trans-specific configuration part
- * @cfg - pointer to the configuration
- * @drv - pointer to iwl_drv
+ * @cfg: pointer to the configuration
+ * @drv: pointer to iwl_drv
+ * @state: current device state
  * @status: a bit-mask of transport status flags
- * @dev - pointer to struct device * that represents the device
+ * @dev: pointer to struct device * that represents the device
  * @max_skb_frags: maximum number of fragments an SKB can have when transmitted.
  *	0 indicates that frag SKBs (NETIF_F_SG) aren't supported.
- * @hw_rf_id a u32 with the device RF ID
- * @hw_crf_id a u32 with the device CRF ID
- * @hw_wfpm_id a u32 with the device wfpm ID
+ * @hw_rf_id: a u32 with the device RF ID
+ * @hw_cnv_id: a u32 with the device CNV ID
+ * @hw_crf_id: a u32 with the device CRF ID
+ * @hw_wfpm_id: a u32 with the device wfpm ID
  * @hw_id: a u32 with the ID of the device / sub-device.
  *	Set during transport allocation.
  * @hw_id_str: a string with info about HW ID. Set during transport allocation.
+ * @sku_id: the SKU identifier (for PNVM matching)
+ * @pnvm_loaded: indicates PNVM was loaded
+ * @hw_rev: the revision data of the HW
  * @hw_rev_step: The mac step of the HW
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
  * @fail_to_parse_pnvm_image: set to true if pnvm parsing failed
+ * @reduce_power_loaded: indicates reduced power section was loaded
  * @failed_to_load_reduce_power_image: set to true if pnvm loading failed
+ * @command_groups: pointer to command group name list array
+ * @command_groups_size: array size of @command_groups
  * @wide_cmd_header: true when ucode supports wide command header format
  * @wait_command_queue: wait queue for sync commands
  * @num_rx_queues: number of RX queues allocated by the transport;
@@ -1055,13 +1086,19 @@ struct iwl_trans_txqs {
  * @iml: a pointer to the image loader itself
  * @dev_cmd_pool: pool for Tx cmd allocation - for internal use only.
  *	The user should use iwl_trans_{alloc,free}_tx_cmd.
+ * @dev_cmd_pool_name: name for the TX command allocation pool
+ * @dbgfs_dir: iwlwifi debugfs base dir for this device
+ * @sync_cmd_lockdep_map: lockdep map for checking sync commands
  * @rx_mpdu_cmd: MPDU RX command ID, must be assigned by opmode before
  *	starting the firmware, used for tracing
  * @rx_mpdu_cmd_hdr_size: used for tracing, amount of data before the
  *	start of the 802.11 header in the @rx_mpdu_cmd
+ * @dbg: additional debug data, see &struct iwl_trans_debug
+ * @init_dram: FW initialization DMA data
  * @system_pm_mode: the system-wide power management mode in use.
  *	This mode is set dynamically, depending on the WoWLAN values
  *	configured from the userspace at runtime.
+ * @name: the device name
  * @txqs: transport tx queues data.
  * @mbx_addr_0_step: step address data 0
  * @mbx_addr_1_step: step address data 1
@@ -1071,6 +1108,7 @@ struct iwl_trans_txqs {
  * @reduced_cap_sku: reduced capability supported SKU
  * @no_160: device not supporting 160 MHz
  * @step_urm: STEP is in URM, no support for MCS>9 in 320 MHz
+ * @trans_specific: data for the specific transport this is allocated for/with
  */
 struct iwl_trans {
 	bool csme_own;
-- 
2.34.1


