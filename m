Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072AD2F91E1
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbhAQLMV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:12:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40632 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728149AbhAQLLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:34 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xD-003sZv-W1; Sun, 17 Jan 2021 13:10:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:32 +0200
Message-Id: <iwlwifi.20210117130510.4de9c363b0b5.I709b7e6f73a7537c53f22d7418927691259de8a8@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/11] iwlwifi: mvm: handle CCA-EXT delay firmware notification
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If there are frequent CCA delays due to the extension channel
as detected by the firmware, and we're on 2.4 GHz, then handle
this by disconnecting (with a reconnect hint).

When we disconnect, we'll also update our capabilities to use
only 20 MHz on the next connection (if it's on 2.4 GHz) as to
avoid the use of the extension channel that has too much noise.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 18 ++++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 39 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 68 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 30 ++++++++
 5 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index b472f08b06e6..d299bba3aa54 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -52,6 +52,12 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	CHEST_COLLECTOR_FILTER_CONFIG_CMD = 0x14,
 
+	/**
+	 * @MONITOR_NOTIF: Datapath monitoring notification, using
+	 *	&struct iwl_datapath_monitor_notif
+	 */
+	MONITOR_NOTIF = 0xF4,
+
 	/**
 	 * @RX_NO_DATA_NOTIF: &struct iwl_rx_no_data
 	 */
@@ -153,4 +159,14 @@ struct iwl_channel_estimation_cfg {
 	__le64 frame_types;
 } __packed; /* CHEST_COLLECTOR_FILTER_CMD_API_S_VER_1 */
 
+enum iwl_datapath_monitor_notif_type {
+	IWL_DP_MON_NOTIF_TYPE_EXT_CCA,
+};
+
+struct iwl_datapath_monitor_notif {
+	__le32 type;
+	u8 mac_id;
+	u8 reserved[3];
+} __packed; /* MONITOR_NTF_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_datapath_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index da32937ba9a7..b323e44fb565 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3009,6 +3009,39 @@ static void iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
 	mvmvif->he_ru_2mhz_block = !iter_data.tolerated;
 }
 
+static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,
+					       struct ieee80211_vif *vif)
+{
+	struct ieee80211_supported_band *sband;
+	const struct ieee80211_sta_he_cap *he_cap;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (!mvm->cca_40mhz_workaround)
+		return;
+
+	/* decrement and check that we reached zero */
+	mvm->cca_40mhz_workaround--;
+	if (mvm->cca_40mhz_workaround)
+		return;
+
+	sband = mvm->hw->wiphy->bands[NL80211_BAND_2GHZ];
+
+	sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband,
+					     ieee80211_vif_type_p2p(vif));
+
+	if (he_cap) {
+		/* we know that ours is writable */
+		struct ieee80211_sta_he_cap *he = (void *)he_cap;
+
+		he->he_cap_elem.phy_cap_info[0] |=
+			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+	}
+}
+
 static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta,
@@ -3048,6 +3081,12 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		 * No need to make sure deferred TX indication is off since the
 		 * worker will already remove it if it was on
 		 */
+
+		/*
+		 * Additionally, reset the 40 MHz capability if we disconnected
+		 * from the AP now.
+		 */
+		iwl_mvm_reset_cca_40mhz_workaround(mvm, vif);
 	}
 
 	mutex_lock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 28b118f3d73d..e13fe0e0025f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -796,6 +796,8 @@ struct iwl_mvm {
 	bool hw_registered;
 	bool rfkill_safe_init_done;
 
+	u8 cca_40mhz_workaround;
+
 	u32 ampdu_ref;
 	bool ampdu_toggle;
 
@@ -1998,6 +2000,7 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 				     u32 size);
 void iwl_mvm_reorder_timer_expired(struct timer_list *t);
 struct ieee80211_vif *iwl_mvm_get_bss_vif(struct iwl_mvm *mvm);
+struct ieee80211_vif *iwl_mvm_get_vif_by_macid(struct iwl_mvm *mvm, u32 macid);
 bool iwl_mvm_is_vif_assoc(struct iwl_mvm *mvm);
 
 #define MVM_TCM_PERIOD_MSEC 500
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 27527a3440af..a1c7572285dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -146,6 +146,70 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 				       ~APMG_PS_CTRL_EARLY_PWR_OFF_RESET_DIS);
 }
 
+static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
+				     struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_datapath_monitor_notif *notif = (void *)pkt->data;
+	struct ieee80211_supported_band *sband;
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_vif *vif;
+
+	if (notif->type != cpu_to_le32(IWL_DP_MON_NOTIF_TYPE_EXT_CCA))
+		return;
+
+	vif = iwl_mvm_get_vif_by_macid(mvm, notif->mac_id);
+	if (!vif || vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (!vif->bss_conf.chandef.chan ||
+	    vif->bss_conf.chandef.chan->band != NL80211_BAND_2GHZ ||
+	    vif->bss_conf.chandef.width < NL80211_CHAN_WIDTH_40)
+		return;
+
+	if (!vif->bss_conf.assoc)
+		return;
+
+	/* this shouldn't happen *again*, ignore it */
+	if (mvm->cca_40mhz_workaround)
+		return;
+
+	/*
+	 * We'll decrement this on disconnect - so set to 2 since we'll
+	 * still have to disconnect from the current AP first.
+	 */
+	mvm->cca_40mhz_workaround = 2;
+
+	/*
+	 * This capability manipulation isn't really ideal, but it's the
+	 * easiest choice - otherwise we'd have to do some major changes
+	 * in mac80211 to support this, which isn't worth it. This does
+	 * mean that userspace may have outdated information, but that's
+	 * actually not an issue at all.
+	 */
+	sband = mvm->hw->wiphy->bands[NL80211_BAND_2GHZ];
+
+	WARN_ON(!sband->ht_cap.ht_supported);
+	WARN_ON(!(sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40));
+	sband->ht_cap.cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband,
+					     ieee80211_vif_type_p2p(vif));
+
+	if (he_cap) {
+		/* we know that ours is writable */
+		struct ieee80211_sta_he_cap *he = (void *)he_cap;
+
+		WARN_ON(!he->has_he);
+		WARN_ON(!(he->he_cap_elem.phy_cap_info[0] &
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G));
+		he->he_cap_elem.phy_cap_info[0] &=
+			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+	}
+
+	ieee80211_disconnect(vif, true);
+}
+
 /**
  * enum iwl_rx_handler_context context for Rx handler
  * @RX_HANDLER_SYNC : this means that it will be called in the Rx path
@@ -291,6 +355,9 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(MAC_CONF_GROUP, CHANNEL_SWITCH_NOA_NOTIF,
 		       iwl_mvm_channel_switch_noa_notif,
 		       RX_HANDLER_SYNC, struct iwl_channel_switch_noa_notif),
+	RX_HANDLER_GRP(DATA_PATH_GROUP, MONITOR_NOTIF,
+		       iwl_mvm_rx_monitor_notif, RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_datapath_monitor_notif),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -435,6 +502,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(RFH_QUEUE_CONFIG_CMD),
 	HCMD_NAME(TLC_MNG_CONFIG_CMD),
 	HCMD_NAME(CHEST_COLLECTOR_FILTER_CONFIG_CMD),
+	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(STA_PM_NOTIF),
 	HCMD_NAME(MU_GROUP_MGMT_NOTIF),
 	HCMD_NAME(RX_QUEUES_NOTIFICATION),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index ee2e0cb47584..cf1bee04041a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -832,6 +832,36 @@ struct ieee80211_vif *iwl_mvm_get_bss_vif(struct iwl_mvm *mvm)
 	return bss_iter_data.vif;
 }
 
+struct iwl_bss_find_iter_data {
+	struct ieee80211_vif *vif;
+	u32 macid;
+};
+
+static void iwl_mvm_bss_find_iface_iterator(void *_data, u8 *mac,
+					    struct ieee80211_vif *vif)
+{
+	struct iwl_bss_find_iter_data *data = _data;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (mvmvif->id == data->macid)
+		data->vif = vif;
+}
+
+struct ieee80211_vif *iwl_mvm_get_vif_by_macid(struct iwl_mvm *mvm, u32 macid)
+{
+	struct iwl_bss_find_iter_data data = {
+		.macid = macid,
+	};
+
+	lockdep_assert_held(&mvm->mutex);
+
+	ieee80211_iterate_active_interfaces_atomic(
+		mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
+		iwl_mvm_bss_find_iface_iterator, &data);
+
+	return data.vif;
+}
+
 struct iwl_sta_iter_data {
 	bool assoc;
 };
-- 
2.29.2

