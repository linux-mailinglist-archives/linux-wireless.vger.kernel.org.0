Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F23D7C4FB6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbjJKKJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbjJKKIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6E1FE5
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018879; x=1728554879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zx4GRVGxjy085eDM3oJwSStPfIH7ehJV8ymw4aIiYu8=;
  b=Y0ZwAqt3pfB74Ir+uTf01n/p66eCtL9qBQnPWIV3veXmc3halW8o+wDK
   WA3lXc3Er5V6kUxUi9fL4+QqC8Cj+A9LOgni375T6BeqtEOfLGQooIi2Q
   ykNusimVBL32KePLNQeF55FQxbF4EzGBNbij9uOtY/epnwmCAsiyl2ma9
   3OlsTLEOAWxlkCY85Z7OzHsiJUlkz9YAJ6AP7UCpN0CMLzD6PyO/qmAen
   3emanSWgx4k/9VdZO6ca6SjMHegVvw+qajcdyLFfjkL3Q7CmmVP6TmhDj
   lwzDRTM8PTKbZYQRwPPSLSK23JtP1CIE4AnaFVfF3FpYgNQg5wuSv2Vgp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670592"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670592"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050276"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050276"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/16] wifi: iwlwifi: mvm: implement ROC version 3
Date:   Wed, 11 Oct 2023 13:07:22 +0300
Message-Id: <20231011130030.0cff02aecc16.If0a89ddc6b2339988ff51efa6709d4a883569969@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

Define the new API for ROC command and notification.
Use ROC version 3 command and notificaiton for hotspot.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  10 +-
 .../intel/iwlwifi/fw/api/time-event.h         |  57 ++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 131 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   5 +
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  50 ++++++-
 .../wireless/intel/iwlwifi/mvm/time-event.h   |   8 ++
 6 files changed, 229 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 184db5a6f06f..f15e6d64c298 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -57,6 +57,14 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @STA_DISABLE_TX_CMD: &struct iwl_mvm_sta_disable_tx_cmd
 	 */
 	STA_DISABLE_TX_CMD = 0xD,
+	/**
+	 * @ROC_CMD: &struct iwl_roc_req
+	 */
+	ROC_CMD = 0xE,
+	/**
+	 * @ROC_NOTIF: &struct iwl_roc_notif
+	 */
+	ROC_NOTIF = 0xF8,
 	/**
 	 * @SESSION_PROTECTION_NOTIF: &struct iwl_mvm_session_prot_notif
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index 7cc706731d70..f0d4056199a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -335,6 +335,63 @@ struct iwl_hs20_roc_res {
 	__le32 status;
 } __packed; /* HOT_SPOT_RSP_API_S_VER_1 */
 
+/*
+ * Activity types for the ROC command
+ * @ROC_ACTIVITY_HOTSPOT: ROC for hs20 activity
+ * @ROC_ACTIVITY_P2P_DISC: ROC for p2p discoverability activity
+ * @ROC_ACTIVITY_P2P_TXRX: ROC for p2p action frames activity
+ */
+enum iwl_roc_activity {
+	ROC_ACTIVITY_HOTSPOT,
+	ROC_ACTIVITY_P2P_DISC,
+	ROC_ACTIVITY_P2P_TXRX,
+	ROC_NUM_ACTIVITIES
+}; /* ROC_ACTIVITY_API_E_VER_1 */
+
+/*
+ * ROC command
+ *
+ * Command requests the firmware to remain on a channel for a certain duration.
+ *
+ * ( MAC_CONF_GROUP 0x3, ROC_CMD 0xE )
+ *
+ * @action: action to perform, see &enum iwl_ctxt_action
+ * @activity: type of activity, see &enum iwl_roc_activity
+ * @sta_id: station id, resumed during "Remain On Channel" activity.
+ * @channel_info: &struct iwl_fw_channel_info
+ * @node_addr: node MAC address for Rx filtering
+ * @reserved: align to a dword
+ * @max_delay: max delay the ROC can start in TU
+ * @duration: remain on channel duration in TU
+ */
+struct iwl_roc_req {
+	__le32 action;
+	__le32 activity;
+	__le32 sta_id;
+	struct iwl_fw_channel_info channel_info;
+	u8 node_addr[ETH_ALEN];
+	__le16 reserved;
+	__le32 max_delay;
+	__le32 duration;
+} __packed; /* ROC_CMD_API_S_VER_3 */
+
+/*
+ * ROC notification
+ *
+ * Notification when ROC startes and when ROC ended.
+ *
+ * ( MAC_CONF_GROUP 0x3, ROC_NOTIF 0xf8 )
+ *
+ * @status: true if ROC succeeded to start
+ * @start_end: true if ROC started, false if ROC ended
+ * @activity: notification to which activity - &enum iwl_roc_activity
+ */
+struct iwl_roc_notif {
+	__le32 success;
+	__le32 started;
+	__le32 activity;
+} __packed; /* ROC_NOTIF_API_S_VER_1 */
+
 /**
  * enum iwl_mvm_session_prot_conf_id - session protection's configurations
  * @SESSION_PROTECT_CONF_ASSOC: Start a session protection for association.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f33c8a00d326..387642ea2fff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4406,6 +4406,39 @@ static bool iwl_mvm_rx_aux_roc(struct iwl_notif_wait_data *notif_wait,
 #define AUX_ROC_MAX_DELAY MSEC_TO_TU(600)
 #define AUX_ROC_SAFETY_BUFFER MSEC_TO_TU(20)
 #define AUX_ROC_MIN_SAFETY_BUFFER MSEC_TO_TU(10)
+
+static void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
+					   u32 duration_ms,
+					   u32 *duration_tu,
+					   u32 *delay)
+{
+	u32 dtim_interval = vif->bss_conf.dtim_period *
+		vif->bss_conf.beacon_int;
+
+	*delay = AUX_ROC_MIN_DELAY;
+	*duration_tu = MSEC_TO_TU(duration_ms);
+
+	/*
+	 * If we are associated we want the delay time to be at least one
+	 * dtim interval so that the FW can wait until after the DTIM and
+	 * then start the time event, this will potentially allow us to
+	 * remain off-channel for the max duration.
+	 * Since we want to use almost a whole dtim interval we would also
+	 * like the delay to be for 2-3 dtim intervals, in case there are
+	 * other time events with higher priority.
+	 */
+	if (vif->cfg.assoc) {
+		*delay = min_t(u32, dtim_interval * 3, AUX_ROC_MAX_DELAY);
+		/* We cannot remain off-channel longer than the DTIM interval */
+		if (dtim_interval <= *duration_tu) {
+			*duration_tu = dtim_interval - AUX_ROC_SAFETY_BUFFER;
+			if (*duration_tu <= AUX_ROC_MIN_DURATION)
+				*duration_tu = dtim_interval -
+					AUX_ROC_MIN_SAFETY_BUFFER;
+		}
+	}
+}
+
 static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 				    struct ieee80211_channel *channel,
 				    struct ieee80211_vif *vif,
@@ -4416,8 +4449,6 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 	struct iwl_mvm_time_event_data *te_data = &mvmvif->hs_time_event_data;
 	static const u16 time_event_response[] = { HOT_SPOT_CMD };
 	struct iwl_notification_wait wait_time_event;
-	u32 dtim_interval = vif->bss_conf.dtim_period *
-		vif->bss_conf.beacon_int;
 	u32 req_dur, delay;
 	struct iwl_hs20_roc_req aux_roc_req = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
@@ -4438,29 +4469,7 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 	/* Set the time and duration */
 	tail->apply_time = cpu_to_le32(iwl_mvm_get_systime(mvm));
 
-	delay = AUX_ROC_MIN_DELAY;
-	req_dur = MSEC_TO_TU(duration);
-
-	/*
-	 * If we are associated we want the delay time to be at least one
-	 * dtim interval so that the FW can wait until after the DTIM and
-	 * then start the time event, this will potentially allow us to
-	 * remain off-channel for the max duration.
-	 * Since we want to use almost a whole dtim interval we would also
-	 * like the delay to be for 2-3 dtim intervals, in case there are
-	 * other time events with higher priority.
-	 */
-	if (vif->cfg.assoc) {
-		delay = min_t(u32, dtim_interval * 3, AUX_ROC_MAX_DELAY);
-		/* We cannot remain off-channel longer than the DTIM interval */
-		if (dtim_interval <= req_dur) {
-			req_dur = dtim_interval - AUX_ROC_SAFETY_BUFFER;
-			if (req_dur <= AUX_ROC_MIN_DURATION)
-				req_dur = dtim_interval -
-					AUX_ROC_MIN_SAFETY_BUFFER;
-		}
-	}
-
+	iwl_mvm_roc_duration_and_delay(vif, duration, &req_dur, &delay);
 	tail->duration = cpu_to_le32(req_dur);
 	tail->apply_time_max_delay = cpu_to_le32(delay);
 
@@ -4468,8 +4477,8 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 		     "ROC: Requesting to remain on channel %u for %ums\n",
 		     channel->hw_value, req_dur);
 	IWL_DEBUG_TE(mvm,
-		     "\t(requested = %ums, max_delay = %ums, dtim_interval = %ums)\n",
-		     duration, delay, dtim_interval);
+		     "\t(requested = %ums, max_delay = %ums)\n",
+		     duration, delay);
 
 	/* Set the node address */
 	memcpy(tail->node_addr, vif->addr, ETH_ALEN);
@@ -4527,6 +4536,48 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 	return res;
 }
 
+static int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
+			       struct ieee80211_channel *channel,
+			       struct ieee80211_vif *vif,
+			       int duration, u32 activity)
+{
+	int res;
+	u32 duration_tu, delay;
+	struct iwl_roc_req roc_req = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.activity = cpu_to_le32(activity),
+		.sta_id = cpu_to_le32(mvm->aux_sta.sta_id),
+	};
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* Set the channel info data */
+	iwl_mvm_set_chan_info(mvm, &roc_req.channel_info,
+			      channel->hw_value,
+			      iwl_mvm_phy_band_from_nl80211(channel->band),
+			      IWL_PHY_CHANNEL_MODE20, 0);
+
+	iwl_mvm_roc_duration_and_delay(vif, duration, &duration_tu,
+				       &delay);
+	roc_req.duration = cpu_to_le32(duration_tu);
+	roc_req.max_delay = cpu_to_le32(delay);
+
+	IWL_DEBUG_TE(mvm,
+		     "\t(requested = %ums, max_delay = %ums)\n",
+		     duration, delay);
+	IWL_DEBUG_TE(mvm,
+		     "Requesting to remain on channel %u for %utu\n",
+		     channel->hw_value, duration_tu);
+
+	/* Set the node address */
+	memcpy(roc_req.node_addr, vif->addr, ETH_ALEN);
+
+	res = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
+				   0, sizeof(roc_req), &roc_req);
+
+	return res;
+}
+
 static int iwl_mvm_add_aux_sta_for_hs20(struct iwl_mvm *mvm, u32 lmac_id)
 {
 	int ret = 0;
@@ -4577,6 +4628,29 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	return iwl_mvm_roc_common(hw, vif, channel, duration, type, &ops);
 }
 
+static int iwl_mvm_roc_station(struct iwl_mvm *mvm,
+			       struct ieee80211_channel *channel,
+			       struct ieee80211_vif *vif,
+			       int duration)
+{
+	int ret;
+	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, ROC_CMD);
+	u8 fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
+					  IWL_FW_CMD_VER_UNKNOWN);
+
+	if (fw_ver == IWL_FW_CMD_VER_UNKNOWN) {
+		ret = iwl_mvm_send_aux_roc_cmd(mvm, channel, vif, duration);
+	} else if (fw_ver == 3) {
+		ret = iwl_mvm_roc_add_cmd(mvm, channel, vif, duration,
+					  ROC_ACTIVITY_HOTSPOT);
+	} else {
+		ret = -EOPNOTSUPP;
+		IWL_ERR(mvm, "ROC command version %d mismatch!\n", fw_ver);
+	}
+
+	return ret;
+}
+
 /* Execute the common part for MLD and non-MLD modes */
 int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_channel *channel, int duration,
@@ -4608,8 +4682,7 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		/* Use aux roc framework (HS20) */
 		ret = ops->add_aux_sta_for_hs20(mvm, lmac_id);
 		if (!ret)
-			ret = iwl_mvm_send_aux_roc_cmd(mvm, channel,
-						       vif, duration);
+			ret = iwl_mvm_roc_station(mvm, channel, vif, duration);
 		goto out_unlock;
 	case NL80211_IFTYPE_P2P_DEVICE:
 		/* handle below */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 465090f67aaf..0fbecbf0c2d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -426,6 +426,9 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 		       WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION,
 		       iwl_mvm_time_sync_msmt_confirm_event, RX_HANDLER_SYNC,
 		       struct iwl_time_msmt_cfm_notify),
+	RX_HANDLER_GRP(MAC_CONF_GROUP, ROC_NOTIF,
+		       iwl_mvm_rx_roc_notif, RX_HANDLER_SYNC,
+		       struct iwl_roc_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -549,6 +552,8 @@ static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(AUX_STA_CMD),
 	HCMD_NAME(STA_REMOVE_CMD),
 	HCMD_NAME(STA_DISABLE_TX_CMD),
+	HCMD_NAME(ROC_CMD),
+	HCMD_NAME(ROC_NOTIF),
 	HCMD_NAME(SESSION_PROTECTION_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_START_NOTIF),
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 82b7560c0ad9..5cfdb2526d56 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -398,6 +398,22 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 	}
 }
 
+void iwl_mvm_rx_roc_notif(struct iwl_mvm *mvm,
+			  struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_roc_notif *notif = (void *)pkt->data;
+
+	if (le32_to_cpu(notif->success) && le32_to_cpu(notif->started) &&
+	    le32_to_cpu(notif->activity) == ROC_ACTIVITY_HOTSPOT) {
+		set_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status);
+		ieee80211_ready_on_channel(mvm->hw);
+	} else {
+		iwl_mvm_roc_finished(mvm);
+		ieee80211_remain_on_channel_expired(mvm->hw);
+	}
+}
+
 /*
  * Handle A Aux ROC time event
  */
@@ -1050,6 +1066,37 @@ void iwl_mvm_cleanup_roc_te(struct iwl_mvm *mvm)
 		__iwl_mvm_remove_time_event(mvm, te_data, &uid);
 }
 
+static void iwl_mvm_roc_rm_cmd(struct iwl_mvm *mvm, u32 activity)
+{
+	int ret;
+	struct iwl_roc_req roc_cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+		.activity = cpu_to_le32(activity),
+	};
+
+	lockdep_assert_held(&mvm->mutex);
+	ret = iwl_mvm_send_cmd_pdu(mvm,
+				   WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
+				   0, sizeof(roc_cmd), &roc_cmd);
+	WARN_ON(ret);
+}
+
+static void iwl_mvm_roc_station_remove(struct iwl_mvm *mvm,
+				       struct iwl_mvm_vif *mvmvif)
+{
+	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, ROC_CMD);
+	u8 fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
+					  IWL_FW_CMD_VER_UNKNOWN);
+
+	if (fw_ver == IWL_FW_CMD_VER_UNKNOWN)
+		iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
+					  &mvmvif->hs_time_event_data);
+	else if (fw_ver == 3)
+		iwl_mvm_roc_rm_cmd(mvm, ROC_ACTIVITY_HOTSPOT);
+	else
+		IWL_ERR(mvm, "ROC command version %d mismatch!\n", fw_ver);
+}
+
 void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif;
@@ -1064,8 +1111,7 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 							  mvmvif->time_event_data.id);
 			iwl_mvm_p2p_roc_finished(mvm);
 		} else {
-			iwl_mvm_remove_aux_roc_te(mvm, mvmvif,
-						  &mvmvif->hs_time_event_data);
+			iwl_mvm_roc_station_remove(mvm, mvmvif);
 			iwl_mvm_roc_finished(mvm);
 		}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
index cf24efce90d0..f77df939b6b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.h
@@ -100,6 +100,14 @@ void iwl_mvm_stop_session_protection(struct iwl_mvm *mvm,
 void iwl_mvm_rx_time_event_notif(struct iwl_mvm *mvm,
 				 struct iwl_rx_cmd_buffer *rxb);
 
+/**
+ * iwl_mvm_rx_roc_notif - handles %DISCOVERY_ROC_NTF.
+ * @mvm: the mvm component
+ * @rxb: RX buffer
+ */
+void iwl_mvm_rx_roc_notif(struct iwl_mvm *mvm,
+			  struct iwl_rx_cmd_buffer *rxb);
+
 /**
  * iwl_mvm_start_p2p_roc - start remain on channel for p2p device functionality
  * @mvm: the mvm component
-- 
2.38.1

