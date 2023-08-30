Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9E78D9B1
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjH3Sdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbjH3Ibq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836B1A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384302; x=1724920302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/l7cuZTbttbaluyxy/Asr9BvIJbAh0Stk0+H+xoiGE=;
  b=YKWAvhSl4JNPZUrrrzX/9YxeB14KVhm56OwMRQen/lLOn8BfMFm5tFpN
   aJqANGUmY8MwhkGO6WofHB3NMtrYwWWqFPCk496hIwAQj9hblTeCdtGkP
   87310KPWJpNlHpFmM7ZjvmkfdveYAzq9BizO92kw9L60pRK2JhIwkvAhH
   wCQ/z1MGgnFjH/v7GiRmzp+J9VnVFFcKxvUqYgnAEIzokIStffTc9g+lV
   KxFlCFygIoWwYNkGER0mELRuk6fvOy+qaraGAIBKseLAl+KOEi16lpRwK
   CcWB/xgflQiQ8Ebtg3ZQN8rkxj/9AU9cd2iS1sIVLCsYTJ66wYTf9RG8S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958979"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958979"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152219"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152219"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:37 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/16] wifi: iwlwifi: dvm: remove kernel-doc warnings
Date:   Wed, 30 Aug 2023 11:30:56 +0300
Message-Id: <20230830112059.7178fb7c96fb.I6af1f291e306c50a3c4f5afcdc2ba0bbd4bea01f@changeid>
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

Mostly remove kernel-doc comment annotation since
the comments really aren't kernel-doc, and fix a
few other places.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/commands.h | 33 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  | 14 ++++----
 drivers/net/wireless/intel/iwlwifi/dvm/rs.h   | 12 +++----
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h   |  9 ++---
 4 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
index 75a4b8e26232..04864d3fda63 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014 Intel Corporation
+ * Copyright (C) 2005-2014, 2023 Intel Corporation
  */
 /*
  * Please use this file (commands.h) only for uCode API definitions.
@@ -270,7 +270,7 @@ enum {
 #define IWL_PWR_NUM_HT_OFDM_ENTRIES		24
 #define IWL_PWR_CCK_ENTRIES			2
 
-/**
+/*
  * struct tx_power_dual_stream
  *
  * Table entries in REPLY_TX_PWR_TABLE_CMD, REPLY_CHANNEL_SWITCH
@@ -281,7 +281,7 @@ struct tx_power_dual_stream {
 	__le32 dw;
 } __packed;
 
-/**
+/*
  * Command REPLY_TX_POWER_DBM_CMD = 0x98
  * struct iwlagn_tx_power_dbm_cmd
  */
@@ -295,7 +295,7 @@ struct iwlagn_tx_power_dbm_cmd {
 	u8 reserved;
 } __packed;
 
-/**
+/*
  * Command TX_ANT_CONFIGURATION_CMD = 0x98
  * This command is used to configure valid Tx antenna.
  * By default uCode concludes the valid antenna according to the radio flavor.
@@ -313,7 +313,7 @@ struct iwl_tx_ant_config_cmd {
 
 #define UCODE_VALID_OK	cpu_to_le32(0x1)
 
-/**
+/*
  * REPLY_ALIVE = 0x1 (response only, not a command)
  *
  * uCode issues this "alive" notification once the runtime image is ready
@@ -534,7 +534,7 @@ enum {
 /* transfer to host non bssid beacons in associated state */
 #define RXON_FILTER_BCON_AWARE_MSK      cpu_to_le32(1 << 6)
 
-/**
+/*
  * REPLY_RXON = 0x10 (command, has simple generic response)
  *
  * RXON tunes the radio tuner to a service channel, and sets up a number
@@ -681,6 +681,7 @@ struct iwl_csa_notification {
  * @aifsn:  Number of slots in Arbitration Interframe Space (before
  *          performing random backoff timing prior to Tx).  Device default 1.
  * @edca_txop:  Length of Tx opportunity, in uSecs.  Device default is 0.
+ * @reserved1: reserved for alignment
  *
  * Device will automatically increase contention window by (2*CW) + 1 for each
  * transmission retry.  Device uses cw_max as a bit mask, ANDed with new CW
@@ -791,9 +792,11 @@ struct iwl_keyinfo {
 
 /**
  * struct sta_id_modify
- * @addr[ETH_ALEN]: station's MAC address
+ * @addr: station's MAC address
+ * @reserved1: reserved for alignment
  * @sta_id: index of station in uCode's station table
  * @modify_mask: STA_MODIFY_*, 1: modify, 0: don't change
+ * @reserved2: reserved for alignment
  *
  * Driver selects unused table index when adding new station,
  * or the index to a pre-existing station entry when modifying that station.
@@ -1464,7 +1467,7 @@ struct iwl_compressed_ba_resp {
 #define  LINK_QUAL_ANT_MSK   (LINK_QUAL_ANT_A_MSK|LINK_QUAL_ANT_B_MSK)
 
 
-/**
+/*
  * struct iwl_link_qual_general_params
  *
  * Used in REPLY_TX_LINK_QUALITY_CMD
@@ -1507,7 +1510,7 @@ struct iwl_link_qual_general_params {
 #define LINK_QUAL_AGG_FRAME_LIMIT_MAX	(63)
 #define LINK_QUAL_AGG_FRAME_LIMIT_MIN	(0)
 
-/**
+/*
  * struct iwl_link_qual_agg_params
  *
  * Used in REPLY_TX_LINK_QUALITY_CMD
@@ -2040,7 +2043,7 @@ struct iwl_spectrum_notification {
  *
  *****************************************************************************/
 
-/**
+/*
  * struct iwl_powertable_cmd - Power Table Command
  * @flags: See below:
  *
@@ -2171,7 +2174,7 @@ struct iwl_ct_kill_throttling_config {
 #define SCAN_CHANNEL_TYPE_PASSIVE cpu_to_le32(0)
 #define SCAN_CHANNEL_TYPE_ACTIVE  cpu_to_le32(1)
 
-/**
+/*
  * struct iwl_scan_channel - entry in REPLY_SCAN_CMD channel table
  *
  * One for each channel in the scan list.
@@ -2210,7 +2213,7 @@ struct iwl_scan_channel {
 /* set number of direct probes __le32 type */
 #define IWL_SCAN_PROBE_MASK(n) 	cpu_to_le32((BIT(n) | (BIT(n) - BIT(1))))
 
-/**
+/*
  * struct iwl_ssid_ie - directed scan network information element
  *
  * Up to 20 of these may appear in REPLY_SCAN_CMD,
@@ -2560,6 +2563,7 @@ struct statistics_rx_bt {
  * @ant_a: current tx power on chain a in 1/2 dB step
  * @ant_b: current tx power on chain b in 1/2 dB step
  * @ant_c: current tx power on chain c in 1/2 dB step
+ * @reserved: reserved for alignment
  */
 struct statistics_tx_power {
 	u8 ant_a;
@@ -3006,7 +3010,7 @@ struct iwl_enhance_sensitivity_cmd {
 } __packed;
 
 
-/**
+/*
  * REPLY_PHY_CALIBRATION_CMD = 0xb0 (command, has simple generic response)
  *
  * This command sets the relative gains of agn device's 3 radio receiver chains.
@@ -3847,6 +3851,7 @@ struct iwlagn_wowlan_status {
  * @type:
  *   0 - BSS
  *   1 - PAN
+ * @reserved: reserved for alignment
  */
 struct iwl_wipan_slot {
 	__le16 width;
@@ -3874,6 +3879,8 @@ struct iwl_wipan_slot {
  *         uCode will perform leaving channel methods in context switch
  *         also when working in same channel mode
  * @num_slots: 1 - 10
+ * @slots: per-slot data
+ * @reserved: reserved for alignment
  */
 struct iwl_wipan_params_cmd {
 	__le16 flags;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index 1a9eadace188..25283e4b849f 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014, 2020 Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2020, 2023 Intel Corporation. All rights reserved.
  *****************************************************************************/
 /*
  * Please use this file (dev.h) for driver implementation definitions.
@@ -126,11 +126,11 @@ enum iwl_agg_state {
 
 /**
  * struct iwl_ht_agg - aggregation state machine
-
+ *
  * This structs holds the states for the BA agreement establishment and tear
  * down. It also holds the state during the BA session itself. This struct is
  * duplicated for each RA / TID.
-
+ *
  * @rate_n_flags: Rate at which Tx was attempted. Holds the data between the
  *	Tx response (REPLY_TX), and the block ack notification
  *	(REPLY_COMPRESSED_BA).
@@ -152,9 +152,9 @@ struct iwl_ht_agg {
 
 /**
  * struct iwl_tid_data - one for each RA / TID
-
+ *
  * This structs holds the states for each RA / TID.
-
+ *
  * @seq_number: the next WiFi sequence number to use
  * @next_reclaimed: the WiFi sequence number of the next packet to be acked.
  *	This is basically (last acked packet++).
@@ -195,7 +195,7 @@ struct iwl_station_priv {
 	u8 sta_id;
 };
 
-/**
+/*
  * struct iwl_vif_priv - driver's private per-interface information
  *
  * When mac80211 allocates a virtual interface, it can allocate
@@ -529,6 +529,7 @@ enum iwl_scan_type {
  *	relevant for 1000, 6000 and up
  * @struct iwl_sensitivity_ranges: range of sensitivity values
  * @use_rts_for_aggregation: use rts/cts protection for HT traffic
+ * @sens: sensitivity ranges pointer
  */
 struct iwl_hw_params {
 	u8  tx_chains_num;
@@ -547,6 +548,7 @@ struct iwl_hw_params {
  * @bt_prio_boost: default bt priority boost value
  * @agg_time_limit: maximum number of uSec in aggregation
  * @bt_sco_disable: uCode should not response to BT in SCO/ESCO mode
+ * @bt_session_2: indicates version 2 of the BT command is used
  */
 struct iwl_dvm_bt_params {
 	bool advanced_bt_coexist;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.h b/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
index 0b47f1993c5d..100cb932c6b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
- * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2003 - 2014, 2023 Intel Corporation. All rights reserved.
  *****************************************************************************/
 
 #ifndef __iwl_agn_rs_h__
@@ -269,7 +269,7 @@ struct iwl_rate_mcs_info {
 	char	mcs[IWL_MAX_MCS_DISPLAY_SIZE];
 };
 
-/**
+/*
  * struct iwl_rate_scale_data -- tx success history for one rate
  */
 struct iwl_rate_scale_data {
@@ -281,7 +281,7 @@ struct iwl_rate_scale_data {
 	unsigned long stamp;
 };
 
-/**
+/*
  * struct iwl_scale_tbl_info -- tx params and success history for all rates
  *
  * There are two of these in struct iwl_lq_sta,
@@ -311,7 +311,7 @@ struct iwl_traffic_load {
 	u8 head;			/* start of the circular buffer */
 };
 
-/**
+/*
  * struct iwl_lq_sta -- driver's rate scaling private structure
  *
  * Pointer to this gets passed back and forth between driver and mac80211.
@@ -379,7 +379,7 @@ static inline u8 first_antenna(u8 mask)
 void iwl_rs_rate_init(struct iwl_priv *priv, struct ieee80211_sta *sta,
 		      u8 sta_id);
 
-/**
+/*
  * iwl_rate_control_register - Register the rate control algorithm callbacks
  *
  * Since the rate control algorithm is hardware specific, there is no need
@@ -391,7 +391,7 @@ void iwl_rs_rate_init(struct iwl_priv *priv, struct ieee80211_sta *sta,
  */
 int iwlagn_rate_control_register(void);
 
-/**
+/*
  * iwl_rate_control_unregister - Unregister the rate control callbacks
  *
  * This should be called after calling ieee80211_unregister_hw, but before
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tt.h b/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
index 7ace052fc78a..23dfcda0dd86 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
- * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2007 - 2014, 2023 Intel Corporation. All rights reserved.
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -72,14 +72,15 @@ struct iwl_tt_trans {
  *		    when thermal throttling state != IWL_TI_0
  *		    the tt_power_mode should set to different
  *		    power mode based on the current tt state
- * @tt_previous_temperature: last measured temperature
- * @iwl_tt_restriction: ptr to restriction tbl, used by advance
+ * @tt_previous_temp: last measured temperature
+ * @restriction: ptr to restriction tbl, used by advance
  *		    thermal throttling to determine how many tx/rx streams
  *		    should be used in tt state; and can HT be enabled or not
- * @iwl_tt_trans: ptr to adv trans table, used by advance thermal throttling
+ * @transaction: ptr to adv trans table, used by advance thermal throttling
  *		    state transaction
  * @ct_kill_toggle: used to toggle the CSR bit when checking uCode temperature
  * @ct_kill_exit_tm: timer to exit thermal kill
+ * @ct_kill_waiting_tm: timer to enter thermal kill
  */
 struct iwl_tt_mgmt {
 	enum iwl_tt_state state;
-- 
2.38.1

