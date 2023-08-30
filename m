Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990CA78D9BC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjH3SeA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbjH3Ibu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088161A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384307; x=1724920307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CvWSzazAb+dGIR9Cl8OZJcrZSo3MZ0l2lElpiuKxpNI=;
  b=IKkw2pQ1OUQd4BMEMPavB2tsQRE2eeDfdJvxzCwLZ9f8tTvsJIb5LPEx
   +MT0ZB7ACM8kqb0hViYbRFZGg+GT07T+kfLjgGI9tFFbFX7rhUK263lIB
   hcrTq+oG1hfyyqrxolsuAjv4BYgXbA8GcQ7Q9eGF5Go3KIdozX7m7NB/C
   gXBiZyE5ARFxRpIdIx05Zrg7Xnkl7Wr4Gje8JJ5Y6gfAYBVMZ+B1Zl2n0
   rIAjKrTYZICQIiwnBTMGeR57w4ZCGtjbmbr0wWhlsVOCexOwbUXXhw9qp
   aeAKXPCPIBIriik+HCpJdHraRmVvjYg5YatchjQ9TP7/vOGsVf4YPUd+Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461959015"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461959015"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152364"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152364"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/16] wifi: iwlwifi: mvm: fix kernel-doc
Date:   Wed, 30 Aug 2023 11:30:58 +0300
Message-Id: <20230830112059.4ce1159b51ab.I2021ae335f6b8e50ee2c1c78a79c5eac1c1aa103@changeid>
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

Fix kernel-doc, adding various documentation, but in some
cases (notably rate scaling) just removing the erroneous
comment format.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 24 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   | 23 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 ++--
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  9 ++++---
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ae0a7cd093e5..bbc552170c9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -127,9 +127,9 @@ struct iwl_mvm_time_event_data {
 
 /**
  * enum iwl_power_scheme
- * @IWL_POWER_LEVEL_CAM - Continuously Active Mode
- * @IWL_POWER_LEVEL_BPS - Balanced Power Save (default)
- * @IWL_POWER_LEVEL_LP  - Low Power
+ * @IWL_POWER_SCHEME_CAM: Continuously Active Mode
+ * @IWL_POWER_SCHEME_BPS: Balanced Power Save (default)
+ * @IWL_POWER_SCHEME_LP: Low Power
  */
 enum iwl_power_scheme {
 	IWL_POWER_SCHEME_CAM = 1,
@@ -302,7 +302,11 @@ struct iwl_probe_resp_data {
  * @queue_params: QoS params for this MAC
  * @mgmt_queue: queue number for unbufferable management frames
  * @igtk: the current IGTK programmed into the firmware
+ * @active: indicates the link is active in FW (for sanity checking)
+ * @cab_queue: content-after-beacon (multicast) queue
  * @listen_lmac: indicates this link is allocated to the listen LMAC
+ * @mcast_sta: multicast station
+ * @phy_ctxt: phy context allocated to this link, if any
  */
 struct iwl_mvm_vif_link_info {
 	u8 bssid[ETH_ALEN];
@@ -342,6 +346,7 @@ struct iwl_mvm_vif_link_info {
 
 /**
  * struct iwl_mvm_vif - data per Virtual Interface, it is a MAC context
+ * @mvm: pointer back to the mvm struct
  * @id: between 0 and 3
  * @color: to solve races upon MAC addition and removal
  * @associated: indicates that we're currently associated, used only for
@@ -364,6 +369,13 @@ struct iwl_mvm_vif_link_info {
  * @csa_failed: CSA failed to schedule time event, report an error later
  * @csa_bcn_pending: indicates that we are waiting for a beacon on a new channel
  * @features: hw features active for this vif
+ * @ap_beacon_time: AP beacon time for synchronisation (on older FW)
+ * @bcn_prot: beacon protection data (keys; FIXME: needs to be per link)
+ * @bf_data: beacon filtering data
+ * @deflink: default link data for use in non-MLO
+ * @link: link data for each link in MLO
+ * @esr_active: indicates eSR mode is active
+ * @pm_enabled: indicates powersave is enabled
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -689,15 +701,17 @@ __aligned(roundup_pow_of_two(sizeof(struct _iwl_mvm_reorder_buf_entry)))
  * struct iwl_mvm_baid_data - BA session data
  * @sta_mask: current station mask for the BAID
  * @tid: tid of the session
- * @baid baid of the session
+ * @baid: baid of the session
  * @timeout: the timeout set in the addba request
  * @entries_per_queue: # of buffers per queue, this actually gets
  *	aligned up to avoid cache line sharing between queues
  * @last_rx: last rx jiffies, updated only if timeout passed from last update
  * @session_timer: timer to check if BA session expired, runs at 2 * timeout
+ * @rcu_ptr: BA data RCU protected access
+ * @rcu_head: RCU head for freeing this data
  * @mvm: mvm pointer, needed for timer context
  * @reorder_buf: reorder buffer, allocated per queue
- * @reorder_buf_data: data
+ * @entries: data
  */
 struct iwl_mvm_baid_data {
 	struct rcu_head rcu_head;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
index 1ca375a5cf6b..376b23b409dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.h
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright (C) 2003 - 2014, 2018 - 2022 Intel Corporation
+ * Copyright (C) 2003 - 2014, 2018 - 2023 Intel Corporation
  *****************************************************************************/
 
 #ifndef __rs_h__
@@ -203,18 +203,12 @@ struct rs_rate {
 /**
  * struct iwl_lq_sta_rs_fw - rate and related statistics for RS in FW
  * @last_rate_n_flags: last rate reported by FW
- * @max_agg_bufsize: the maximal size of the AGG buffer for this station
- * @sta_id: the id of the station
-#ifdef CONFIG_MAC80211_DEBUGFS
- * @dbg_fixed_rate: for debug, use fixed rate if not 0
- * @dbg_agg_frame_count_lim: for debug, max number of frames in A-MPDU
-#endif
+ * @pers.sta_id: the id of the station
  * @chains: bitmask of chains reported in %chain_signal
  * @chain_signal: per chain signal strength
  * @last_rssi: last rssi reported
  * @drv: pointer back to the driver data
  */
-
 struct iwl_lq_sta_rs_fw {
 	/* last tx rate_n_flags */
 	u32 last_rate_n_flags;
@@ -223,7 +217,14 @@ struct iwl_lq_sta_rs_fw {
 	struct lq_sta_pers_rs_fw {
 		u32 sta_id;
 #ifdef CONFIG_MAC80211_DEBUGFS
+		/**
+		 * @dbg_fixed_rate: for debug, use fixed rate if not 0
+		 */
 		u32 dbg_fixed_rate;
+		/**
+		 * @dbg_agg_frame_count_lim: for debug, max number of
+		 *	frames in A-MPDU
+		 */
 		u16 dbg_agg_frame_count_lim;
 #endif
 		u8 chains;
@@ -233,7 +234,7 @@ struct iwl_lq_sta_rs_fw {
 	} pers;
 };
 
-/**
+/*
  * struct iwl_rate_scale_data -- tx success history for one rate
  */
 struct iwl_rate_scale_data {
@@ -275,7 +276,7 @@ struct rs_rate_stats {
 	u64 total;
 };
 
-/**
+/*
  * struct iwl_scale_tbl_info -- tx params and success history for all rates
  *
  * There are two of these in struct iwl_lq_sta,
@@ -296,7 +297,7 @@ enum {
 	RS_STATE_STAY_IN_COLUMN,
 };
 
-/**
+/*
  * struct iwl_lq_sta -- driver's rate scaling private structure
  *
  * Pointer to this gets passed back and forth between driver and mac80211.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 7364346a1209..7738fdf1d336 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -356,6 +356,7 @@ struct iwl_mvm_link_sta {
 
 /**
  * struct iwl_mvm_sta - representation of a station in the driver
+ * @vif: the interface the station belongs to
  * @tfd_queue_msk: the tfd queues used by the station
  * @mac_id_n_color: the MAC context this station is linked to
  * @tid_disable_agg: bitmap: if bit(tid) is set, the fw won't send ampdus for
@@ -380,6 +381,7 @@ struct iwl_mvm_link_sta {
  * @amsdu_enabled: bitmap of TX AMSDU allowed TIDs.
  *	In case TLC offload is not active it is either 0xFFFF or 0.
  * @max_amsdu_len: max AMSDU length
+ * @sleeping: indicates the station is sleeping (when not offloaded to FW)
  * @agg_tids: bitmap of tids whose status is operational aggregated (IWL_AGG_ON)
  * @sleeping: sta sleep transitions in power management
  * @sleep_tx_count: the number of frames that we told the firmware to let out
@@ -389,7 +391,6 @@ struct iwl_mvm_link_sta {
  *	the BA window. To be used for UAPSD only.
  * @ptk_pn: per-queue PTK PN data structures
  * @dup_data: per queue duplicate packet detection data
- * @deferred_traffic_tid_map: indication bitmap of deferred traffic per-TID
  * @tx_ant: the index of the antenna to use for data tx to this station. Only
  *	used during connection establishment (e.g. for the 4 way handshake
  *	exchange).
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
index 989a5319fb21..cf24efce90d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2019-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2020, 2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  */
 #ifndef __time_event_h__
@@ -134,7 +134,7 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 /**
  * iwl_mvm_remove_time_event - general function to clean up of time event
  * @mvm: the mvm component
- * @vif: the vif to which the time event belongs
+ * @mvmvif: the vif to which the time event belongs
  * @te_data: the time event data that corresponds to that time event
  *
  * This function can be used to cancel a time event regardless its type.
@@ -195,7 +195,8 @@ iwl_mvm_te_scheduled(struct iwl_mvm_time_event_data *te_data)
  * iwl_mvm_schedule_session_protection - schedule a session protection
  * @mvm: the mvm component
  * @vif: the virtual interface for which the protection issued
- * @duration: the duration of the protection
+ * @duration: the requested duration of the protection
+ * @min_duration: the minimum duration of the protection
  * @wait_for_notif: if true, will block until the start of the protection
  */
 void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
@@ -205,6 +206,8 @@ void iwl_mvm_schedule_session_protection(struct iwl_mvm *mvm,
 
 /**
  * iwl_mvm_rx_session_protect_notif - handles %SESSION_PROTECTION_NOTIF
+ * @mvm: the mvm component
+ * @rxb: the RX buffer containing the notification
  */
 void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 				      struct iwl_rx_cmd_buffer *rxb);
-- 
2.38.1

