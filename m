Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D2078D9CB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbjH3SeG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242434AbjH3Ibf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD21A6
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384292; x=1724920292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=33viBlyat5dDa9zgWP3YdDa6Trh+vTCd/J9XYUCmfPM=;
  b=jyq7bYPaSjGc9NKw6ehnGHBUxTi3zhHvd5d4lrAqkLytOgVv0R/cnOIy
   qLBvzGZ8G1XjfTVe1tjcLIIf0yBflFbPuANabFCWDTnfs9KCfBUfr1ieK
   Qq/GdutbNcOLRTV8zzisXLdXPZ5nBrOc+DovXMJNqdOfF9V0s6UVbPTTI
   /dZDKvXxFv/6zs8UnJ/I6excR/qWv+5jXI5y7bwaL7k3FwY4YvZQ7Fvmi
   OwilEPU58gz3ORVb9Ke8ZkrLdv6weRZvW3j9lgB6F8GRWTj+ZFugx6drp
   xV7VH0tRvYWvJCV5MNlthTNyLsEt8pJuXSkqVffmB9L0eKcLbsOV8e1de
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958909"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958909"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152056"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152056"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/16] wifi: iwlwifi: fix some kernel-doc issues
Date:   Wed, 30 Aug 2023 11:30:53 +0300
Message-Id: <20230830112059.2edc4d82f717.Ic7c6f1153939903b067062c9aec8fb70e0a2c30d@changeid>
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

Fix kernel-doc issues.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h     |  7 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/notif-wait.h  |  3 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h     |  5 -----
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h  |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h        |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.h   |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h         | 13 +++++++------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h      |  9 ++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |  4 ++--
 9 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
index 1a84a4081e7c..34d664023473 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2020-2021 Intel Corporation
+ * Copyright (C) 2020-2021, 2023 Intel Corporation
  */
 #ifndef __iwl_fw_api_rfi_h__
 #define __iwl_fw_api_rfi_h__
@@ -25,8 +25,9 @@ struct iwl_rfi_lut_entry {
 /**
  * struct iwl_rfi_config_cmd - RFI configuration table
  *
- * @entry: a table can have 24 frequency/channel mappings
+ * @table: a table can have 24 frequency/channel mappings
  * @oem: specifies if this is the default table or set by OEM
+ * @reserved: (reserved/padding)
  */
 struct iwl_rfi_config_cmd {
 	struct iwl_rfi_lut_entry table[IWL_RFI_LUT_SIZE];
@@ -35,7 +36,7 @@ struct iwl_rfi_config_cmd {
 } __packed; /* RFI_CONFIG_CMD_API_S_VER_1 */
 
 /**
- * iwl_rfi_freq_table_status - status of the frequency table query
+ * enum iwl_rfi_freq_table_status - status of the frequency table query
  * @RFI_FREQ_TABLE_OK: can be used
  * @RFI_FREQ_TABLE_DVFS_NOT_READY: DVFS is not ready yet, should try later
  * @RFI_FREQ_TABLE_DISABLED: the feature is disabled in FW
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/notif-wait.h b/drivers/net/wireless/intel/iwlwifi/fw/notif-wait.h
index 49e8ba11b6a8..0e49794911c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/notif-wait.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/notif-wait.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014 Intel Corporation
+ * Copyright (C) 2005-2014, 2023 Intel Corporation
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_notif_wait_h__
@@ -25,6 +25,7 @@ struct iwl_notif_wait_data {
  *	returns true, the wait is over, if it returns false then
  *	the waiter stays blocked. If no function is given, any
  *	of the listed commands will unblock the waiter.
+ * @fn_data: pointer to pass to the @fn's data argument
  * @cmds: command IDs
  * @n_cmds: number of command IDs
  * @triggered: waiter should be woken up
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 241a9e3f2a1a..90bebdf85c06 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -250,7 +250,6 @@ enum iwl_cfg_trans_ltr_delay {
  * RFID can be read before deciding the remaining parameters to use.
  *
  * @base_params: pointer to basic parameters
- * @csr: csr flags and addresses that are different across devices
  * @device_family: the device family
  * @umac_prph_offset: offset to add to UMAC periphery address
  * @xtal_latency: power up latency to get the xtal stabilized
@@ -319,7 +318,6 @@ struct iwl_fw_mon_regs {
  * @non_shared_ant: the antenna that is for WiFi only
  * @nvm_ver: NVM version
  * @nvm_calib_ver: NVM calibration version
- * @lib: pointer to the lib ops
  * @ht_params: point to ht parameters
  * @led_mode: 0=blinking, 1=On(RF On)/Off(RF Off)
  * @rx_with_siso_diversity: 1x1 device with rx antenna diversity
@@ -344,15 +342,12 @@ struct iwl_fw_mon_regs {
  * @nvm_type: see &enum iwl_nvm_type
  * @d3_debug_data_base_addr: base address where D3 debug data is stored
  * @d3_debug_data_length: length of the D3 debug data
- * @bisr_workaround: BISR hardware workaround (for 22260 series devices)
  * @min_txq_size: minimum number of slots required in a TX queue
  * @uhb_supported: ultra high band channels supported
  * @min_ba_txq_size: minimum number of slots required in a TX queue which
  *	based on hardware support (HE - 256, EHT - 1K).
  * @num_rbds: number of receive buffer descriptors to use
  *	(only used for multi-queue capable devices)
- * @mac_addr_csr_base: CSR base register for MAC address access, if not set
- *	assume 0x380
  *
  * We enable the driver to be backward compatible wrt. hardware features.
  * API differences in uCode shouldn't be handled here but through TLVs
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 96bf353469b8..8a377b41e26a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018, 2020-2022 Intel Corporation
+ * Copyright (C) 2018, 2020-2023 Intel Corporation
  */
 #ifndef __iwl_context_info_file_gen3_h__
 #define __iwl_context_info_file_gen3_h__
@@ -44,7 +44,7 @@ enum iwl_prph_scratch_mtr_format {
  * @IWL_PRPH_SCRATCH_EDBG_DEST_ST_ARBITER: use st arbiter, mainly for
  *	multicomm.
  * @IWL_PRPH_SCRATCH_EDBG_DEST_TB22DTF: route debug data to SoC HW
- * @IWL_PRPH_SCTATCH_RB_SIZE_4K: Use 4K RB size (the default is 2K)
+ * @IWL_PRPH_SCRATCH_RB_SIZE_4K: Use 4K RB size (the default is 2K)
  * @IWL_PRPH_SCRATCH_MTR_MODE: format used for completion - 0: for
  *	completion descriptor, 1 for responses (legacy)
  * @IWL_PRPH_SCRATCH_MTR_FORMAT: a mask for the size of the tfd.
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 6c19989e4ab7..3d1a27ba35c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -56,7 +56,7 @@ struct iwl_cfg;
 /**
  * iwl_drv_start - start the drv
  *
- * @trans_ops: the ops of the transport
+ * @trans: the transport
  *
  * starts the driver: fetches the firmware. This should be called by bus
  * specific system flows implementations. For example, the bus specific probe
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
index 0e8ca761d24b..34a178a2eb5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018, 2020-2022 Intel Corporation
+ * Copyright (C) 2005-2014, 2018, 2020-2023 Intel Corporation
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  */
 #ifndef __iwl_eeprom_parse_h__
@@ -61,7 +61,7 @@ struct iwl_nvm_data {
 /**
  * iwl_parse_eeprom_data - parse EEPROM data and return values
  *
- * @dev: device pointer we're parsing for, for debug only
+ * @trans: ransport we're parsing for, for debug only
  * @cfg: device configuration for parsing and overrides
  * @eeprom: the EEPROM data
  * @eeprom_size: length of the EEPROM data
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index 41ab5a6e2dd3..e0400ba2ab74 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -681,12 +681,13 @@ struct iwl_tfh_tb {
 
 /**
  * struct iwl_tfd - Transmit Frame Descriptor (TFD)
- * @ __reserved1[3] reserved
- * @ num_tbs 0-4 number of active tbs
- *	     5   reserved
- *	     6-7 padding (not used)
- * @ tbs[20]	transmit frame buffer descriptors
- * @ __pad	padding
+ * @__reserved1: reserved
+ * @num_tbs:
+ *  0-4 number of active tbs
+ *  5   reserved
+ *  6-7 padding (not used)
+ * @tbs: transmit frame buffer descriptors
+ * @__pad: padding
  */
 struct iwl_tfd {
 	u8 __reserved1[3];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 1b3c976d19fe..aa77cd4cc8d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -109,6 +109,7 @@ static inline u32 iwl_rx_packet_payload_len(const struct iwl_rx_packet *pkt)
  * @CMD_ASYNC: Return right away and don't wait for the response
  * @CMD_WANT_SKB: Not valid with CMD_ASYNC. The caller needs the buffer of
  *	the response. The caller needs to call iwl_free_resp when done.
+ * @CMD_SEND_IN_RFKILL: Send the command even if the NIC is in RF-kill.
  * @CMD_WANT_ASYNC_CALLBACK: the op_mode's async callback function must be
  *	called after this command completes. Valid only with CMD_ASYNC.
  * @CMD_SEND_IN_D3: Allow the command to be sent in D3 mode, relevant to
@@ -738,6 +739,7 @@ struct iwl_dram_data {
 };
 
 /**
+ * struct iwl_dram_regions - DRAM regions container structure
  * @drams: array of several DRAM areas that contains the pnvm and power
  *	reduction table payloads.
  * @n_regions: number of DRAM regions that were allocated
@@ -866,8 +868,7 @@ struct iwl_trans_debug {
 	u64 unsupported_region_msk;
 	struct iwl_ucode_tlv *active_regions[IWL_FW_INI_MAX_REGION_ID];
 	struct list_head debug_info_tlv_list;
-	struct iwl_dbg_tlv_time_point_data
-		time_point[IWL_FW_INI_TIME_POINT_NUM];
+	struct iwl_dbg_tlv_time_point_data time_point[IWL_FW_INI_TIME_POINT_NUM];
 	struct list_head periodic_trig_list;
 
 	u32 domains_bitmap;
@@ -920,7 +921,6 @@ struct iwl_pcie_first_tb_buf {
 
 /**
  * struct iwl_txq - Tx Queue for DMA
- * @q: generic Rx/Tx queue descriptor
  * @tfds: transmit frame descriptors (DMA memory)
  * @first_tb_bufs: start of command headers, including scratch buffers, for
  *	the writeback -- this is DMA memory and an array holding one buffer
@@ -1064,11 +1064,10 @@ struct iwl_trans_txqs {
  *	starting the firmware, used for tracing
  * @rx_mpdu_cmd_hdr_size: used for tracing, amount of data before the
  *	start of the 802.11 header in the @rx_mpdu_cmd
- * @dflt_pwr_limit: default power limit fetched from the platform (ACPI)
  * @system_pm_mode: the system-wide power management mode in use.
  *	This mode is set dynamically, depending on the WoWLAN values
  *	configured from the userspace at runtime.
- * @iwl_trans_txqs: transport tx queues data.
+ * @txqs: transport tx queues data.
  * @mbx_addr_0_step: step address data 0
  * @mbx_addr_1_step: step address data 1
  * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index dda13f4351c3..ae0a7cd093e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -218,7 +218,7 @@ enum iwl_bt_force_ant_mode {
 };
 
 /**
- * struct iwl_mvm_low_latency_force - low latency force mode set by debugfs
+ * enum iwl_mvm_low_latency_force - low latency force mode set by debugfs
  * @LOW_LATENCY_FORCE_UNSET: unset force mode
  * @LOW_LATENCY_FORCE_ON: for low latency on
  * @LOW_LATENCY_FORCE_OFF: for low latency off
@@ -232,7 +232,7 @@ enum iwl_mvm_low_latency_force {
 };
 
 /**
-* struct iwl_mvm_low_latency_cause - low latency set causes
+* enum iwl_mvm_low_latency_cause - low latency set causes
 * @LOW_LATENCY_TRAFFIC: indicates low latency traffic was detected
 * @LOW_LATENCY_DEBUGFS: low latency mode set from debugfs
 * @LOW_LATENCY_VCMD: low latency mode set from vendor command
-- 
2.38.1

