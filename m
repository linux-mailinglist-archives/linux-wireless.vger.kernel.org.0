Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C47D236B
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjJVO4R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjJVO4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17B8A4
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986572; x=1729522572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gmBVDPPC9onZENU/oiN1YH82T0i2h0zQam4xCsrnthQ=;
  b=agx4mBcPUyF4pbOeEi0G5OfAzM5uVppqlmVInMIfscC6bspF33tsgcL8
   /DIGbQpeRiLrvUnmtN8GnHWXaUsWlcaKShBjncbjs/Ta5MIFAwJXhfHjQ
   j/tt8tFzRJOim+moE9wVWvIzNygI0AIi877SFYYHHY0F4gSKkpczcVpQc
   oAD1PJiNvQKBuIoZ5/FbM2AIHQnBt/gkZRfKJuVwxN4YTnBdIWmQb0xzM
   whk82NGPNQVzML9PyNWC4ZELuRp80t8zJ9Nr9McN5HwqgEatN+64sBJIR
   6pMzWNSgjg+CkgHxm2EKmdnWx22xZ8zLXovJn7MIgIRc/uZnnWCl3Qo5T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925845"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925845"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556183"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:54:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/10] wifi: iwlwifi: mvm: implement new firmware API for statistics
Date:   Sun, 22 Oct 2023 17:55:47 +0300
Message-Id: <20231022173519.8cc7df0ebff2.If1dcb57145841c5b3c68ed112bbfcd0201f7acc3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

The new firmware API uses a new command and notification,
the command configures in which statistics types driver is
interested and the notification is sent periodically.
An additional change in the API is that most of the statistics
data is accumulated and reported by the firmware per MLO link.
Implement new command and notification handlers and adjust to
per-link statistics.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  30 ++++
 .../net/wireless/intel/iwlwifi/fw/api/stats.h | 153 +++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  46 +++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  12 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  24 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 157 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  61 +++++++
 8 files changed, 451 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 13cb0d53a1a3..7544c4cb1a30 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -30,6 +30,8 @@
  * @REGULATORY_AND_NVM_GROUP: regulatory/NVM group, uses command IDs from
  *	&enum iwl_regulatory_and_nvm_subcmd_ids
  * @DEBUG_GROUP: Debug group, uses command IDs from &enum iwl_debug_cmds
+ * @STATISTICS_GROUP: Statistics group, uses command IDs from
+ *	&enum iwl_statistics_subcmd_ids
  */
 enum iwl_mvm_command_groups {
 	LEGACY_GROUP = 0x0,
@@ -44,6 +46,7 @@ enum iwl_mvm_command_groups {
 	PROT_OFFLOAD_GROUP = 0xb,
 	REGULATORY_AND_NVM_GROUP = 0xc,
 	DEBUG_GROUP = 0xf,
+	STATISTICS_GROUP = 0x10,
 };
 
 /**
@@ -616,10 +619,37 @@ enum iwl_system_subcmd_ids {
 	 */
 	SYSTEM_FEATURES_CONTROL_CMD = 0xd,
 
+	/**
+	 * @SYSTEM_STATISTICS_CMD: &struct iwl_system_statistics_cmd
+	 */
+	SYSTEM_STATISTICS_CMD = 0xf,
+
+	/**
+	 * @SYSTEM_STATISTICS_END_NOTIF: &struct iwl_system_statistics_end_notif
+	 */
+	SYSTEM_STATISTICS_END_NOTIF = 0xfd,
+
 	/**
 	 * @RFI_DEACTIVATE_NOTIF: &struct iwl_rfi_deactivate_notif
 	 */
 	RFI_DEACTIVATE_NOTIF = 0xff,
 };
 
+/**
+ * enum iwl_statistics_subcmd_ids - Statistics group command IDs
+ */
+enum iwl_statistics_subcmd_ids {
+	/**
+	 * @STATISTICS_OPER_NOTIF: Notification about operational
+	 *	statistics &struct iwl_system_statistics_notif_oper
+	 */
+	STATISTICS_OPER_NOTIF = 0x0,
+
+	/**
+	 * @STATISTICS_OPER_PART1_NOTIF: Notification about operational part1
+	 *	statistics &struct iwl_system_statistics_part1_notif_oper
+	 */
+	STATISTICS_OPER_PART1_NOTIF = 0x1,
+};
+
 #endif /* __iwl_fw_api_commands_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 898e62326e6c..2271b19213fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -1,12 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020 - 2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020 - 2021, 2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_stats_h__
 #define __iwl_fw_api_stats_h__
 #include "mac.h"
+#include "mac-cfg.h"
 
 struct mvm_statistics_dbg {
 	__le32 burst_check;
@@ -411,6 +412,49 @@ struct iwl_statistics_cmd {
 
 #define MAX_BCAST_FILTER_NUM		8
 
+/**
+ * enum iwl_statistics_notify_type_id - type_id used in system statistics
+ *	command
+ * @IWL_STATS_NTFY_TYPE_ID_OPER: request legacy statistics
+ * @IWL_STATS_NTFY_TYPE_ID_OPER_PART1: request operational part1 statistics
+ * @IWL_STATS_NTFY_TYPE_ID_OPER_PART2: request operational part2 statistics
+ * @IWL_STATS_NTFY_TYPE_ID_OPER_PART3: request operational part3 statistics
+ * @IWL_STATS_NTFY_TYPE_ID_OPER_PART4: request operational part4 statistics
+ */
+enum iwl_statistics_notify_type_id {
+	IWL_STATS_NTFY_TYPE_ID_OPER		= BIT(0),
+	IWL_STATS_NTFY_TYPE_ID_OPER_PART1	= BIT(1),
+	IWL_STATS_NTFY_TYPE_ID_OPER_PART2	= BIT(2),
+	IWL_STATS_NTFY_TYPE_ID_OPER_PART3	= BIT(3),
+	IWL_STATS_NTFY_TYPE_ID_OPER_PART4	= BIT(4),
+};
+
+/**
+ * enum iwl_statistics_cfg_flags - cfg_mask used in system statistics command
+ * @IWL_STATS_CFG_FLG_DISABLE_NTFY_MSK: 0 for enable, 1 for disable
+ * @IWL_STATS_CFG_FLG_ON_DEMAND_NTFY_MSK: 0 for periodic, 1 for on-demand
+ * @IWL_STATS_CFG_FLG_RESET_MSK: 0 for reset statistics after
+ *	sending the notification, 1 for do not reset statistics after sending
+ *	the notification
+ */
+enum iwl_statistics_cfg_flags {
+	IWL_STATS_CFG_FLG_DISABLE_NTFY_MSK	= BIT(0),
+	IWL_STATS_CFG_FLG_ON_DEMAND_NTFY_MSK	= BIT(1),
+	IWL_STATS_CFG_FLG_RESET_MSK		= BIT(2),
+};
+
+/**
+ * struct iwl_system_statistics_cmd - system statistics command
+ * @cfg_mask: configuration mask, &enum iwl_statistics_cfg_flags
+ * @config_time_sec: time in sec for periodic notification
+ * @type_id_mask: type_id masks, &enum iwl_statistics_notify_type_id
+ */
+struct iwl_system_statistics_cmd {
+	__le32 cfg_mask;
+	__le32 config_time_sec;
+	__le32 type_id_mask;
+} __packed; /* STATISTICS_FW_CMD_API_S_VER_1 */
+
 /**
  * enum iwl_fw_statistics_type
  *
@@ -447,7 +491,49 @@ struct iwl_statistics_ntfy_hdr {
 }; /* STATISTICS_NTFY_HDR_API_S_VER_1 */
 
 /**
- * struct iwl_statistics_ntfy_per_mac
+ * struct iwl_stats_ntfy_per_link
+ *
+ * @beacon_filter_average_energy: Average energy [-dBm] of the 2
+ *	 antennas.
+ * @air_time: air time
+ * @beacon_counter: all beacons (both filtered and not filtered)
+ * @beacon_average_energy: Average energy [-dBm] of all beacons
+ *	(both filtered and not filtered)
+ * @beacon_rssi_a: beacon RSSI on antenna A
+ * @beacon_rssi_b: beacon RSSI on antenna B
+ * @rx_bytes: RX byte count
+ */
+struct iwl_stats_ntfy_per_link {
+	__le32 beacon_filter_average_energy;
+	__le32 air_time;
+	__le32 beacon_counter;
+	__le32 beacon_average_energy;
+	__le32 beacon_rssi_a;
+	__le32 beacon_rssi_b;
+	__le32 rx_bytes;
+} __packed; /* STATISTICS_NTFY_PER_LINK_API_S_VER_1 */
+
+/**
+ * struct iwl_stats_ntfy_part1_per_link
+ *
+ * @rx_time: rx time
+ * @tx_time: tx time
+ * @rx_action: action frames handled by FW
+ * @tx_action: action frames generated and transmitted by FW
+ * @cca_defers: cca defer count
+ * @beacon_filtered: filtered out beacons
+ */
+struct iwl_stats_ntfy_part1_per_link {
+	__le64 rx_time;
+	__le64 tx_time;
+	__le32 rx_action;
+	__le32 tx_action;
+	__le32 cca_defers;
+	__le32 beacon_filtered;
+} __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_PART1_PER_LINK_API_S_VER_1 */
+
+/**
+ * struct iwl_stats_ntfy_per_mac
  *
  * @beacon_filter_average_energy: Average energy [-dBm] of the 2
  *	 antennas.
@@ -459,7 +545,7 @@ struct iwl_statistics_ntfy_hdr {
  * @beacon_rssi_b: beacon RSSI on antenna B
  * @rx_bytes: RX byte count
  */
-struct iwl_statistics_ntfy_per_mac {
+struct iwl_stats_ntfy_per_mac {
 	__le32 beacon_filter_average_energy;
 	__le32 air_time;
 	__le32 beacon_counter;
@@ -470,7 +556,7 @@ struct iwl_statistics_ntfy_per_mac {
 } __packed; /* STATISTICS_NTFY_PER_MAC_API_S_VER_1 */
 
 #define IWL_STATS_MAX_BW_INDEX 5
-/** struct iwl_statistics_ntfy_per_phy
+/** struct iwl_stats_ntfy_per_phy
  * @channel_load: channel load
  * @channel_load_by_us: device contribution to MCLM
  * @channel_load_not_by_us: other devices' contribution to MCLM
@@ -485,7 +571,7 @@ struct iwl_statistics_ntfy_per_mac {
  *	per channel BW. note BACK counted as 1
  * @last_tx_ch_width_indx: last txed frame channel width index
  */
-struct iwl_statistics_ntfy_per_phy {
+struct iwl_stats_ntfy_per_phy {
 	__le32 channel_load;
 	__le32 channel_load_by_us;
 	__le32 channel_load_not_by_us;
@@ -499,23 +585,62 @@ struct iwl_statistics_ntfy_per_phy {
 } __packed; /* STATISTICS_NTFY_PER_PHY_API_S_VER_1 */
 
 /**
- * struct iwl_statistics_ntfy_per_sta
+ * struct iwl_stats_ntfy_per_sta
  *
  * @average_energy: in fact it is minus the energy..
  */
-struct iwl_statistics_ntfy_per_sta {
+struct iwl_stats_ntfy_per_sta {
 	__le32 average_energy;
 } __packed; /* STATISTICS_NTFY_PER_STA_API_S_VER_1 */
 
-#define IWL_STATS_MAX_PHY_OPERTINAL 3
+#define IWL_STATS_MAX_PHY_OPERATIONAL 3
+#define IWL_STATS_MAX_FW_LINKS	(IWL_MVM_FW_MAX_LINK_ID + 1)
+
+/**
+ * struct iwl_system_statistics_notif_oper
+ *
+ * @time_stamp: time when the notification is sent from firmware
+ * @per_link: per link statistics, &struct iwl_stats_ntfy_per_link
+ * @per_phy: per phy statistics, &struct iwl_stats_ntfy_per_phy
+ * @per_sta: per sta statistics, &struct iwl_stats_ntfy_per_sta
+ */
+struct iwl_system_statistics_notif_oper {
+	__le32 time_stamp;
+	struct iwl_stats_ntfy_per_link per_link[IWL_STATS_MAX_FW_LINKS];
+	struct iwl_stats_ntfy_per_phy per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
+	struct iwl_stats_ntfy_per_sta per_sta[IWL_MVM_STATION_COUNT_MAX];
+} __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_API_S_VER_3 */
+
+/**
+ * struct iwl_system_statistics_part1_notif_oper
+ *
+ * @time_stamp: time when the notification is sent from firmware
+ * @per_link: per link statistics &struct iwl_stats_ntfy_part1_per_link
+ * @per_phy_crc_error_stats: per phy crc error statistics
+ */
+struct iwl_system_statistics_part1_notif_oper {
+	__le32 time_stamp;
+	struct iwl_stats_ntfy_part1_per_link per_link[IWL_STATS_MAX_FW_LINKS];
+	__le32 per_phy_crc_error_stats[IWL_STATS_MAX_PHY_OPERATIONAL];
+} __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_PART1_API_S_VER_4 */
+
+/**
+ * struct iwl_system_statistics_end_notif
+ *
+ * @time_stamp: time when the notification is sent from firmware
+ */
+struct iwl_system_statistics_end_notif {
+	__le32 time_stamp;
+} __packed; /* STATISTICS_FW_NTFY_END_API_S_VER_1 */
+
 /**
  * struct iwl_statistics_operational_ntfy
  *
  * @hdr: general statistics header
  * @flags: bitmap of possible notification structures
- * @per_mac_stats: per mac statistics, &struct iwl_statistics_ntfy_per_mac
- * @per_phy_stats: per phy statistics, &struct iwl_statistics_ntfy_per_phy
- * @per_sta_stats: per sta statistics, &struct iwl_statistics_ntfy_per_sta
+ * @per_mac: per mac statistics, &struct iwl_stats_ntfy_per_mac
+ * @per_phy: per phy statistics, &struct iwl_stats_ntfy_per_phy
+ * @per_sta: per sta statistics, &struct iwl_stats_ntfy_per_sta
  * @rx_time: rx time
  * @tx_time: usec the radio is transmitting.
  * @on_time_rf: The total time in usec the RF is awake.
@@ -524,9 +649,9 @@ struct iwl_statistics_ntfy_per_sta {
 struct iwl_statistics_operational_ntfy {
 	struct iwl_statistics_ntfy_hdr hdr;
 	__le32 flags;
-	struct iwl_statistics_ntfy_per_mac per_mac_stats[MAC_INDEX_AUX];
-	struct iwl_statistics_ntfy_per_phy per_phy_stats[IWL_STATS_MAX_PHY_OPERTINAL];
-	struct iwl_statistics_ntfy_per_sta per_sta_stats[IWL_MVM_STATION_COUNT_MAX];
+	struct iwl_stats_ntfy_per_mac per_mac[MAC_INDEX_AUX];
+	struct iwl_stats_ntfy_per_phy per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
+	struct iwl_stats_ntfy_per_sta per_sta[IWL_MVM_STATION_COUNT_MAX];
 	__le64 rx_time;
 	__le64 tx_time;
 	__le64 on_time_rf;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bb330f1b5d9e..a64600f0ed9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1539,6 +1539,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
+	int i;
 
 	mutex_lock(&mvm->mutex);
 
@@ -1555,8 +1556,9 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	/* make sure that beacon statistics don't go backwards with FW reset */
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		mvmvif->deflink.beacon_stats.accu_num_beacons +=
-			mvmvif->deflink.beacon_stats.num_beacons;
+		for_each_mvm_vif_valid_link(mvmvif, i)
+			mvmvif->link[i]->beacon_stats.accu_num_beacons +=
+				mvmvif->link[i]->beacon_stats.num_beacons;
 
 	/* Allocate resources for the MAC context, and add it to the fw  */
 	ret = iwl_mvm_mac_ctxt_init(mvm, vif);
@@ -2581,6 +2583,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
+	int i;
 
 	/*
 	 * Re-calculate the tsf id, as the leader-follower relations depend
@@ -2627,8 +2630,9 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 		if (vif->cfg.assoc) {
 			/* clear statistics to get clean beacon counter */
 			iwl_mvm_request_statistics(mvm, true);
-			memset(&mvmvif->deflink.beacon_stats, 0,
-			       sizeof(mvmvif->deflink.beacon_stats));
+			for_each_mvm_vif_valid_link(mvmvif, i)
+				memset(&mvmvif->link[i]->beacon_stats, 0,
+				       sizeof(mvmvif->link[i]->beacon_stats));
 
 			/* add quota for this interface */
 			ret = iwl_mvm_update_quotas(mvm, true, NULL);
@@ -5726,7 +5730,11 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 			   struct survey_info *survey)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int ret;
+	int ret = 0;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(SYSTEM_GROUP,
+						   SYSTEM_STATISTICS_CMD),
+					   IWL_FW_CMD_VER_UNKNOWN);
 
 	memset(survey, 0, sizeof(*survey));
 
@@ -5746,13 +5754,8 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 			goto out;
 	}
 
-	survey->filled = SURVEY_INFO_TIME |
-			 SURVEY_INFO_TIME_RX |
-			 SURVEY_INFO_TIME_TX |
-			 SURVEY_INFO_TIME_SCAN;
-	survey->time = mvm->accu_radio_stats.on_time_rf +
-		       mvm->radio_stats.on_time_rf;
-	do_div(survey->time, USEC_PER_MSEC);
+	survey->filled = SURVEY_INFO_TIME_RX |
+			 SURVEY_INFO_TIME_TX;
 
 	survey->time_rx = mvm->accu_radio_stats.rx_time +
 			  mvm->radio_stats.rx_time;
@@ -5762,11 +5765,20 @@ int iwl_mvm_mac_get_survey(struct ieee80211_hw *hw, int idx,
 			  mvm->radio_stats.tx_time;
 	do_div(survey->time_tx, USEC_PER_MSEC);
 
+	/* the new fw api doesn't support the following fields */
+	if (cmd_ver != IWL_FW_CMD_VER_UNKNOWN)
+		goto out;
+
+	survey->filled |= SURVEY_INFO_TIME |
+			  SURVEY_INFO_TIME_SCAN;
+	survey->time = mvm->accu_radio_stats.on_time_rf +
+		       mvm->radio_stats.on_time_rf;
+	do_div(survey->time, USEC_PER_MSEC);
+
 	survey->time_scan = mvm->accu_radio_stats.on_time_scan +
 			    mvm->radio_stats.on_time_scan;
 	do_div(survey->time_scan, USEC_PER_MSEC);
 
-	ret = 0;
  out:
 	mutex_unlock(&mvm->mutex);
 	return ret;
@@ -5915,6 +5927,7 @@ void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	int i;
 
 	if (mvmsta->deflink.avg_energy) {
 		sinfo->signal_avg = -(s8)mvmsta->deflink.avg_energy;
@@ -5943,8 +5956,11 @@ void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 	if (iwl_mvm_request_statistics(mvm, false))
 		goto unlock;
 
-	sinfo->rx_beacon = mvmvif->deflink.beacon_stats.num_beacons +
-			   mvmvif->deflink.beacon_stats.accu_num_beacons;
+	sinfo->rx_beacon = 0;
+	for_each_mvm_vif_valid_link(mvmvif, i)
+		sinfo->rx_beacon += mvmvif->link[i]->beacon_stats.num_beacons +
+			mvmvif->link[i]->beacon_stats.accu_num_beacons;
+
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX);
 	if (mvmvif->deflink.beacon_stats.avg_signal) {
 		/* firmware only reports a value after RXing a few beacons */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 407b34a224c1..c953824f55ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -10,6 +10,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
+	int i;
 
 	mutex_lock(&mvm->mutex);
 
@@ -22,8 +23,9 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
 	/* make sure that beacon statistics don't go backwards with FW reset */
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		mvmvif->deflink.beacon_stats.accu_num_beacons +=
-			mvmvif->deflink.beacon_stats.num_beacons;
+		for_each_mvm_vif_valid_link(mvmvif, i)
+			mvmvif->link[i]->beacon_stats.accu_num_beacons +=
+				mvmvif->link[i]->beacon_stats.num_beacons;
 
 	/* Allocate resources for the MAC context, and add it to the fw  */
 	ret = iwl_mvm_mac_ctxt_init(mvm, vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 760cebf22fee..f2af3e571409 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1194,6 +1194,8 @@ struct iwl_mvm {
 	struct iwl_time_sync_data time_sync;
 
 	struct iwl_mei_scan_filter mei_scan_filter;
+
+	bool statistics_clear;
 };
 
 /* Extract MVM priv from op_mode and _hw */
@@ -1685,6 +1687,16 @@ static inline void iwl_mvm_wait_for_async_handlers(struct iwl_mvm *mvm)
 }
 
 /* Statistics */
+void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
+					 struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_handle_rx_system_oper_part1_stats(struct iwl_mvm *mvm,
+					       struct iwl_rx_cmd_buffer *rxb);
+static inline void
+iwl_mvm_handle_rx_system_end_stats_notif(struct iwl_mvm *mvm,
+					 struct iwl_rx_cmd_buffer *rxb)
+{
+}
+
 void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 				  struct iwl_rx_packet *pkt);
 void iwl_mvm_rx_statistics(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 45fe2b0979fb..8bba59d83b30 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -322,6 +322,19 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_NO_SIZE(STATISTICS_NOTIFICATION, iwl_mvm_rx_statistics,
 			   RX_HANDLER_ASYNC_LOCKED),
 
+	RX_HANDLER_GRP(STATISTICS_GROUP, STATISTICS_OPER_NOTIF,
+		       iwl_mvm_handle_rx_system_oper_stats,
+		       RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_system_statistics_notif_oper),
+	RX_HANDLER_GRP(STATISTICS_GROUP, STATISTICS_OPER_PART1_NOTIF,
+		       iwl_mvm_handle_rx_system_oper_part1_stats,
+		       RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_system_statistics_part1_notif_oper),
+	RX_HANDLER_GRP(SYSTEM_GROUP, SYSTEM_STATISTICS_END_NOTIF,
+		       iwl_mvm_handle_rx_system_end_stats_notif,
+		       RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_system_statistics_end_notif),
+
 	RX_HANDLER(BA_WINDOW_STATUS_NOTIFICATION_ID,
 		   iwl_mvm_window_status_notif, RX_HANDLER_SYNC,
 		   struct iwl_ba_window_status_notif),
@@ -538,6 +551,8 @@ static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
 	HCMD_NAME(RFI_GET_FREQ_TABLE_CMD),
 	HCMD_NAME(SYSTEM_FEATURES_CONTROL_CMD),
 	HCMD_NAME(RFI_DEACTIVATE_NOTIF),
+	HCMD_NAME(SYSTEM_STATISTICS_CMD),
+	HCMD_NAME(SYSTEM_STATISTICS_END_NOTIF),
 };
 
 /* Please keep this array *SORTED* by hex value.
@@ -591,6 +606,14 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(RX_QUEUES_NOTIFICATION),
 };
 
+/* Please keep this array *SORTED* by hex value.
+ * Access is done through binary search
+ */
+static const struct iwl_hcmd_names iwl_mvm_statistics_names[] = {
+	HCMD_NAME(STATISTICS_OPER_NOTIF),
+	HCMD_NAME(STATISTICS_OPER_PART1_NOTIF),
+};
+
 /* Please keep this array *SORTED* by hex value.
  * Access is done through binary search
  */
@@ -645,6 +668,7 @@ static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 	[PROT_OFFLOAD_GROUP] = HCMD_ARR(iwl_mvm_prot_offload_names),
 	[REGULATORY_AND_NVM_GROUP] =
 		HCMD_ARR(iwl_mvm_regulatory_and_nvm_names),
+	[STATISTICS_GROUP] = HCMD_ARR(iwl_mvm_statistics_names),
 };
 
 /* this forward declaration can avoid to export the function */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 542c192698a4..8caa971770c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -553,7 +553,7 @@ struct iwl_mvm_stat_data {
 struct iwl_mvm_stat_data_all_macs {
 	struct iwl_mvm *mvm;
 	__le32 flags;
-	struct iwl_statistics_ntfy_per_mac *per_mac_stats;
+	struct iwl_stats_ntfy_per_mac *per_mac;
 };
 
 static void iwl_mvm_update_vif_sig(struct ieee80211_vif *vif, int sig)
@@ -658,7 +658,7 @@ static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
 					   struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_stat_data_all_macs *data = _data;
-	struct iwl_statistics_ntfy_per_mac *mac_stats;
+	struct iwl_stats_ntfy_per_mac *mac_stats;
 	int sig;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	u16 vif_id = mvmvif->id;
@@ -669,7 +669,7 @@ static void iwl_mvm_stat_iterator_all_macs(void *_data, u8 *mac,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	mac_stats = &data->per_mac_stats[vif_id];
+	mac_stats = &data->per_mac[vif_id];
 
 	mvmvif->deflink.beacon_stats.num_beacons =
 		le32_to_cpu(mac_stats->beacon_counter);
@@ -759,7 +759,7 @@ iwl_mvm_stats_ver_15(struct iwl_mvm *mvm,
 	struct iwl_mvm_stat_data_all_macs data = {
 		.mvm = mvm,
 		.flags = stats->flags,
-		.per_mac_stats = stats->per_mac_stats,
+		.per_mac = stats->per_mac,
 	};
 
 	ieee80211_iterate_active_interfaces(mvm->hw,
@@ -828,6 +828,142 @@ static bool iwl_mvm_verify_stats_len(struct iwl_mvm *mvm,
 	return true;
 }
 
+static void
+iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
+				struct iwl_stats_ntfy_per_link *per_link)
+{
+	u32 air_time[MAC_INDEX_AUX] = {};
+	u32 rx_bytes[MAC_INDEX_AUX] = {};
+	int fw_link_id;
+
+	for (fw_link_id = 0; fw_link_id < ARRAY_SIZE(mvm->link_id_to_link_conf);
+	     fw_link_id++) {
+		struct iwl_stats_ntfy_per_link *link_stats;
+		struct ieee80211_bss_conf *bss_conf;
+		struct iwl_mvm_vif *mvmvif;
+		int link_id;
+		int sig;
+
+		bss_conf = iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, fw_link_id,
+							       false);
+		if (!bss_conf)
+			continue;
+
+		if (bss_conf->vif->type != NL80211_IFTYPE_STATION)
+			continue;
+
+		link_id = bss_conf->link_id;
+		if (link_id >= ARRAY_SIZE(mvmvif->link))
+			continue;
+
+		mvmvif = iwl_mvm_vif_from_mac80211(bss_conf->vif);
+		if (!mvmvif || !mvmvif->link[link_id])
+			continue;
+
+		link_stats = &per_link[fw_link_id];
+
+		mvmvif->link[link_id]->beacon_stats.num_beacons =
+			le32_to_cpu(link_stats->beacon_counter);
+
+		/* we basically just use the u8 to store 8 bits and then treat
+		 * it as a s8 whenever we take it out to a different type.
+		 */
+		mvmvif->link[link_id]->beacon_stats.avg_signal =
+			-le32_to_cpu(link_stats->beacon_average_energy);
+
+		/* make sure that beacon statistics don't go backwards with TCM
+		 * request to clear statistics
+		 */
+		if (mvm->statistics_clear)
+			mvmvif->link[link_id]->beacon_stats.accu_num_beacons +=
+				mvmvif->link[link_id]->beacon_stats.num_beacons;
+
+		sig = -le32_to_cpu(link_stats->beacon_filter_average_energy);
+		iwl_mvm_update_vif_sig(bss_conf->vif, sig);
+
+		if (WARN_ONCE(mvmvif->id >= MAC_INDEX_AUX,
+			      "invalid mvmvif id: %d", mvmvif->id))
+			continue;
+
+		air_time[mvmvif->id] +=
+			le32_to_cpu(per_link[fw_link_id].air_time);
+		rx_bytes[mvmvif->id] +=
+			le32_to_cpu(per_link[fw_link_id].rx_bytes);
+	}
+
+	/* Don't update in case the statistics are not cleared, since
+	 * we will end up counting twice the same airtime, once in TCM
+	 * request and once in statistics notification.
+	 */
+	if (mvm->statistics_clear) {
+		__le32 air_time_le[MAC_INDEX_AUX];
+		__le32 rx_bytes_le[MAC_INDEX_AUX];
+		int vif_id;
+
+		for (vif_id = 0; vif_id < ARRAY_SIZE(air_time_le); vif_id++) {
+			air_time_le[vif_id] = cpu_to_le32(air_time[vif_id]);
+			rx_bytes_le[vif_id] = cpu_to_le32(rx_bytes[vif_id]);
+		}
+
+		iwl_mvm_update_tcm_from_stats(mvm, air_time_le, rx_bytes_le);
+	}
+}
+
+void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
+					 struct iwl_rx_cmd_buffer *rxb)
+{
+	u8 average_energy[IWL_MVM_STATION_COUNT_MAX];
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_system_statistics_notif_oper *stats;
+	int i;
+	u32 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, STATISTICS_GROUP,
+						STATISTICS_OPER_NOTIF, 0);
+
+	if (notif_ver != 3) {
+		IWL_FW_CHECK_FAILED(mvm,
+				    "Oper stats notif ver %d is not supported\n",
+				    notif_ver);
+		return;
+	}
+
+	stats = (void *)&pkt->data;
+	iwl_mvm_stat_iterator_all_links(mvm, stats->per_link);
+
+	for (i = 0; i < ARRAY_SIZE(average_energy); i++)
+		average_energy[i] =
+			le32_to_cpu(stats->per_sta[i].average_energy);
+
+	ieee80211_iterate_stations_atomic(mvm->hw, iwl_mvm_stats_energy_iter,
+					  average_energy);
+}
+
+void iwl_mvm_handle_rx_system_oper_part1_stats(struct iwl_mvm *mvm,
+					       struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_system_statistics_part1_notif_oper *part1_stats;
+	int i;
+	u32 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, STATISTICS_GROUP,
+						STATISTICS_OPER_PART1_NOTIF, 0);
+
+	if (notif_ver != 4) {
+		IWL_FW_CHECK_FAILED(mvm,
+				    "Part1 stats notif ver %d is not supported\n",
+				    notif_ver);
+		return;
+	}
+
+	part1_stats = (void *)&pkt->data;
+	mvm->radio_stats.rx_time = 0;
+	mvm->radio_stats.tx_time = 0;
+	for (i = 0; i < ARRAY_SIZE(part1_stats->per_link); i++) {
+		mvm->radio_stats.rx_time +=
+			le64_to_cpu(part1_stats->per_link[i].rx_time);
+		mvm->radio_stats.tx_time +=
+			le64_to_cpu(part1_stats->per_link[i].tx_time);
+	}
+}
+
 static void
 iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
 				 struct iwl_rx_packet *pkt)
@@ -887,11 +1023,11 @@ iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
 
 		for (i = 0; i < ARRAY_SIZE(average_energy); i++)
 			average_energy[i] =
-				le32_to_cpu(stats->per_sta_stats[i].average_energy);
+				le32_to_cpu(stats->per_sta[i].average_energy);
 
 		for (i = 0; i < ARRAY_SIZE(air_time); i++) {
-			air_time[i] = stats->per_mac_stats[i].air_time;
-			rx_bytes[i] = stats->per_mac_stats[i].rx_bytes;
+			air_time[i] = stats->per_mac[i].air_time;
+			rx_bytes[i] = stats->per_mac[i].rx_bytes;
 		}
 	}
 
@@ -917,6 +1053,13 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 	__le32 *bytes, *air_time, flags;
 	int expected_size;
 	u8 *energy;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(SYSTEM_GROUP,
+						   SYSTEM_STATISTICS_CMD),
+					   IWL_FW_CMD_VER_UNKNOWN);
+
+	if (cmd_ver != IWL_FW_CMD_VER_UNKNOWN)
+		return;
 
 	/* From ver 14 and up we use TLV statistics format */
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 48016b4343d2..91286018a69d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -342,6 +342,60 @@ static bool iwl_wait_stats_complete(struct iwl_notif_wait_data *notif_wait,
 	return true;
 }
 
+static int iwl_mvm_request_system_statistics(struct iwl_mvm *mvm, bool clear,
+					     u8 cmd_ver)
+{
+	struct iwl_system_statistics_cmd system_cmd = {
+		.cfg_mask = clear ?
+			    cpu_to_le32(IWL_STATS_CFG_FLG_ON_DEMAND_NTFY_MSK) :
+			    cpu_to_le32(IWL_STATS_CFG_FLG_RESET_MSK |
+					IWL_STATS_CFG_FLG_ON_DEMAND_NTFY_MSK),
+		.type_id_mask = cpu_to_le32(IWL_STATS_NTFY_TYPE_ID_OPER |
+					    IWL_STATS_NTFY_TYPE_ID_OPER_PART1),
+	};
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(SYSTEM_GROUP, SYSTEM_STATISTICS_CMD),
+		.len[0] = sizeof(system_cmd),
+		.data[0] = &system_cmd,
+	};
+	struct iwl_notification_wait stats_wait;
+	static const u16 stats_complete[] = {
+		WIDE_ID(SYSTEM_GROUP, SYSTEM_STATISTICS_END_NOTIF),
+	};
+	int ret;
+
+	if (cmd_ver != 1) {
+		IWL_FW_CHECK_FAILED(mvm,
+				    "Invalid system statistics command version:%d\n",
+				    cmd_ver);
+		return -EOPNOTSUPP;
+	}
+
+	iwl_init_notification_wait(&mvm->notif_wait, &stats_wait,
+				   stats_complete, ARRAY_SIZE(stats_complete),
+				   NULL, NULL);
+
+	mvm->statistics_clear = clear;
+	ret = iwl_mvm_send_cmd(mvm, &cmd);
+	if (ret) {
+		iwl_remove_notification(&mvm->notif_wait, &stats_wait);
+		return ret;
+	}
+
+	/* 500ms for OPERATIONAL, PART1 and END notification should be enough
+	 * for FW to collect data from all LMACs and send
+	 * STATISTICS_NOTIFICATION to host
+	 */
+	ret = iwl_wait_notification(&mvm->notif_wait, &stats_wait, HZ / 2);
+	if (ret)
+		return ret;
+
+	if (clear)
+		iwl_mvm_accu_radio_stats(mvm);
+
+	return ret;
+}
+
 int iwl_mvm_request_statistics(struct iwl_mvm *mvm, bool clear)
 {
 	struct iwl_statistics_cmd scmd = {
@@ -353,8 +407,15 @@ int iwl_mvm_request_statistics(struct iwl_mvm *mvm, bool clear)
 		.len[0] = sizeof(scmd),
 		.data[0] = &scmd,
 	};
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(SYSTEM_GROUP,
+						   SYSTEM_STATISTICS_CMD),
+					   IWL_FW_CMD_VER_UNKNOWN);
 	int ret;
 
+	if (cmd_ver != IWL_FW_CMD_VER_UNKNOWN)
+		return iwl_mvm_request_system_statistics(mvm, clear, cmd_ver);
+
 	/* From version 15 - STATISTICS_NOTIFICATION, the reply for
 	 * STATISTICS_CMD is empty, and the response is with
 	 * STATISTICS_NOTIFICATION notification
-- 
2.38.1

