Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4072D4F62F4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiDFPLx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiDFPL1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:11:27 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876CA2B448A
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:11:22 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nc4Th-000pov-Uy;
        Wed, 06 Apr 2022 15:09:40 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net, kvalo@kernel.org
Cc:     luca@coelho.fi, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed,  6 Apr 2022 15:09:24 +0300
Message-Id: <iwlwifi.20220406145756.fb26dd85f17d.I9bf12c8ecfb3f17253a13dc48a48647ddd6e7855@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406120924.979792-1-luca@coelho.fi>
References: <20220406120924.979792-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 7/7] iwlwifi: mvm: report hardware timestamps in RX/TX status
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

For TM/FTM frames, report the hardware timestamps reported by the
fw as part of the RX/TX status. Since the fw reports the timestamps
in a dedicated notification (and not as part of the RX/TX status),
hold the frame until the fw timestamps notification is received.
Timestamping is enabled when a station is connected and disabled
when disconnected. For AP interface, only the first station will
have timestamping enabled since the fw only supports timestamping
for one peer.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  20 +-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 126 ++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  12 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   6 +
 .../wireless/intel/iwlwifi/mvm/time-sync.c    | 172 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/time-sync.h    |  30 +++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 11 files changed, 384 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index c78d2f1c722c..90f97032fc2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #ifndef __iwl_fw_api_commands_h__
 #define __iwl_fw_api_commands_h__
@@ -261,6 +261,24 @@ enum iwl_legacy_cmds {
 	 */
 	HOT_SPOT_CMD = 0x53,
 
+	/**
+	 * @WNM_80211V_TIMING_MEASUREMENT_NOTIFICATION: Time Sync
+	 *	measurement notification for TM/FTM. Sent on receipt of respective
+	 *	WNM action frame for TM protocol or public action frame for FTM
+	 *	protocol from peer device along with additional meta data specified in
+	 *	&struct iwl_time_msmt_notify
+	 */
+	WNM_80211V_TIMING_MEASUREMENT_NOTIFICATION = 0x67,
+
+	/**
+	 * @WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION: Time Sync
+	 *	measurement confirmation notification for TM/FTM. Sent on
+	 *	receipt of Ack from peer for previously Tx'ed TM/FTM
+	 *	action frame along with additional meta data specified in
+	 *	&struct iwl_time_msmt_cfm_notify
+	 */
+	WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION = 0x68,
+
 	/**
 	 * @SCAN_OFFLOAD_COMPLETE:
 	 * notification, &struct iwl_periodic_scan_complete
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 43619acc29fd..b085148dc7d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -26,6 +26,11 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	TRIGGER_RX_QUEUES_NOTIF_CMD = 0x2,
 
+	/**
+	 * @WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD: &struct iwl_time_sync_cfg_cmd
+	 */
+	WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD = 0x4,
+
 	/**
 	 * @STA_HE_CTXT_CMD: &struct iwl_he_sta_context_cmd
 	 */
@@ -142,7 +147,126 @@ enum iwl_channel_estimation_flags {
 };
 
 /**
- * struct iwl_channel_estimation_cfg - channel estimation reporting config
+ * struct iwl_time_sync_cfg_cmd - TM/FTM time sync measurement configuration
+ *
+ * @protocols: The type of frames to raise notifications for. A bitmap
+ *	of @iwl_time_sync_protocol_type
+ * @peer_addr: peer address with which TM/FTM measurements are required
+ * @reserved: for alignment
+ */
+struct iwl_time_sync_cfg_cmd {
+	__le32 protocols;
+	u8 peer_addr[ETH_ALEN];
+	u8 reserved[2];
+} __packed; /* WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD_API_S_VER_1 */
+
+/* PTP_CTX_MAX_DATA_SIZE_IN_API_D_VER_1 */
+#define PTP_CTX_MAX_DATA_SIZE   128
+
+/**
+ * struct iwl_time_msmt_ptp_ctx - Vendor specific information element
+ * to allow a space for flexibility for the userspace App
+ *
+ * @element_id: element id of vendor specific ie
+ * @length: length of vendor specific ie
+ * @reserved: for alignment
+ * @data: vendor specific data blob
+ */
+struct iwl_time_msmt_ptp_ctx {
+	u8 element_id;
+	u8 length;
+	__le16 reserved;
+	u8 data[PTP_CTX_MAX_DATA_SIZE];
+} __packed /* PTP_CTX_VER_1 */;
+
+/**
+ * struct iwl_time_msmt_notify - Time Sync measurement notification
+ * for TM/FTM, along with additional meta data.
+ *
+ * @peer_addr: peer address
+ * @reserved: for alignment
+ * @dialog_token: measurement flow dialog token number
+ * @followup_dialog_token: Measurement flow previous dialog token number
+ * @t1_hi: high dword of t1-time of the Tx'ed action frame departure on
+ *	sender side in units of 10 nano seconds
+ * @t1_lo: low dword of t1-time of the Tx'ed action frame departure on
+ *	sender side in units of 10 nano seconds
+ * @t1_max_err: maximum t1-time error in units of 10 nano seconds
+ * @t4_hi: high dword of t4-time of the Rx'ed action frame's Ack arrival on
+ *	sender side in units of 10 nano seconds
+ * @t4_lo: low dword of t4-time of the Rx'ed action frame's Ack arrival on
+ *	sender side in units of 10 nano seconds
+ * @t4_max_err: maximum t4-time error in units of 10 nano seconds
+ * @t2_hi: high dword of t2-time of the Rx'ed action frame arrival on
+ *	receiver side in units of 10 nano seconds
+ * @t2_lo: low dword of t2-time of the Rx'ed action frame arrival on
+ *	receiver side in units of 10 nano seconds
+ * @t2_max_err: maximum t2-time error in units of 10 nano seconds
+ * @t3_hi: high dword of t3-time of the Tx'ed action frame's Ack departure on
+ *	receiver side in units of 10 nano seconds
+ * @t3_lo: low dword of t3-time of the Tx'ed action frame's Ack departure on
+ *	receiver side in units of 10 nano seconds
+ * @t3_max_err: maximum t3-time error in units of 10 nano seconds
+ * @ptp: vendor specific information element
+ */
+struct iwl_time_msmt_notify {
+	u8 peer_addr[ETH_ALEN];
+	u8 reserved[2];
+	__le32 dialog_token;
+	__le32 followup_dialog_token;
+	__le32 t1_hi;
+	__le32 t1_lo;
+	__le32 t1_max_err;
+	__le32 t4_hi;
+	__le32 t4_lo;
+	__le32 t4_max_err;
+	__le32 t2_hi;
+	__le32 t2_lo;
+	__le32 t2_max_err;
+	__le32 t3_hi;
+	__le32 t3_lo;
+	__le32 t3_max_err;
+	struct iwl_time_msmt_ptp_ctx ptp;
+} __packed; /* WNM_80211V_TIMING_MEASUREMENT_NTFY_API_S_VER_1 */
+
+/**
+ * struct iwl_time_msmt_cfm_notify - Time Sync measurement confirmation
+ * notification for TM/FTM. Sent on receipt of 802.11 Ack from peer for the
+ * Tx'ed TM/FTM measurement action frame.
+ *
+ * @peer_addr: peer address
+ * @reserved: for alignment
+ * @dialog_token: measurement flow dialog token number
+ * @t1_hi: high dword of t1-time of the Tx'ed action frame departure on
+ *	sender side in units of 10 nano seconds
+ * @t1_lo: low dword of t1-time of the Tx'ed action frame departure on
+ *	sender side in units of 10 nano seconds
+ * @t1_max_err: maximum t1-time error in units of 10 nano seconds
+ * @t4_hi: high dword of t4-time of the Rx'ed action frame's Ack arrival on
+ *	sender side in units of 10 nano seconds
+ * @t4_lo: low dword of t4-time of the Rx'ed action frame's Ack arrival on
+ *	sender side in units of 10 nano seconds
+ * @t4_max_err: maximum t4-time error in units of 10 nano seconds
+ */
+struct iwl_time_msmt_cfm_notify {
+	u8 peer_addr[ETH_ALEN];
+	u8 reserved[2];
+	__le32 dialog_token;
+	__le32 t1_hi;
+	__le32 t1_lo;
+	__le32 t1_max_err;
+	__le32 t4_hi;
+	__le32 t4_lo;
+	__le32 t4_max_err;
+} __packed; /* WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NTFY_API_S_VER_1 */
+
+enum iwl_time_sync_protocol_type {
+	IWL_TIME_SYNC_PROTOCOL_TM       = BIT(0),
+	IWL_TIME_SYNC_PROTOCOL_FTM      = BIT(1),
+}; /* WNM_TIMING_ENABLED_PROTOCOL_API_E_VER_1 */
+
+/**
+ * struct iwl_channel_estimation_cfg_v1 - channel estimation reporting config
  */
 struct iwl_channel_estimation_cfg {
 	/**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index 11e814b7cad0..2421fc2251cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -6,7 +6,7 @@ iwlmvm-y += scan.o time-event.o rs.o rs-fw.o
 iwlmvm-y += power.o coex.o
 iwlmvm-y += tt.o offloading.o tdls.o
 iwlmvm-y += ftm-responder.o ftm-initiator.o
-iwlmvm-y += rfi.o
+iwlmvm-y += rfi.o time-sync.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 784d91281c02..3fcd47abe754 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -386,6 +386,10 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT);
 
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000)
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_HW_TIMESTAMP);
+
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	hw->wiphy->features |=
 		NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c6bc85d4600a..0a07e0674db0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -769,6 +769,12 @@ struct iwl_mvm_dqa_txq_info {
 	enum iwl_mvm_queue_status status;
 };
 
+struct iwl_time_sync_data {
+	struct sk_buff_head frame_list;
+	u8 peer_addr[ETH_ALEN];
+	bool active;
+};
+
 struct iwl_mvm {
 	/* for logger access */
 	struct device *dev;
@@ -1106,6 +1112,8 @@ struct iwl_mvm {
 	unsigned long last_reset_or_resume_time_jiffies;
 
 	bool sta_remove_requires_queue_remove;
+
+	struct iwl_time_sync_data time_sync;
 };
 
 /* Extract MVM priv from op_mode and _hw */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index b2f33ebdf485..27520436e830 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -29,6 +29,7 @@
 #include "fw-api.h"
 #include "fw/acpi.h"
 #include "fw/uefi.h"
+#include "time-sync.h"
 
 #define DRV_DESCRIPTION	"The new Intel(R) wireless AGN driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
@@ -401,6 +402,15 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(SYSTEM_GROUP, RFI_DEACTIVATE_NOTIF,
 		       iwl_rfi_deactivate_notif_handler, RX_HANDLER_ASYNC_UNLOCKED,
 		       struct iwl_rfi_deactivate_notif),
+
+	RX_HANDLER_GRP(LEGACY_GROUP,
+		       WNM_80211V_TIMING_MEASUREMENT_NOTIFICATION,
+		       iwl_mvm_time_sync_msmt_event, RX_HANDLER_SYNC,
+		       struct iwl_time_msmt_notify),
+	RX_HANDLER_GRP(LEGACY_GROUP,
+		       WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION,
+		       iwl_mvm_time_sync_msmt_confirm_event, RX_HANDLER_SYNC,
+		       struct iwl_time_msmt_cfm_notify),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -1316,6 +1326,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	else
 		memset(&mvm->rx_stats, 0, sizeof(struct mvm_statistics_rx));
 
+	iwl_mvm_init_time_sync(&mvm->time_sync);
+
 	mvm->debugfs_dir = dbgfs_dir;
 
 	mvm->mei_registered = !iwl_mei_register(mvm, &mei_ops);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 2c43a9989783..e66658c7b34e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -9,6 +9,7 @@
 #include "iwl-trans.h"
 #include "mvm.h"
 #include "fw-api.h"
+#include "time-sync.h"
 
 static void *iwl_mvm_skb_get_hdr(struct sk_buff *skb)
 {
@@ -2026,9 +2027,9 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		goto out;
 	}
 
-	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc))
-		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue,
-						sta);
+	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc) &&
+	    (likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2))))
+		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue, sta);
 out:
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index c7f9d3870f21..3faf74871ed2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -9,6 +9,7 @@
 #include "mvm.h"
 #include "sta.h"
 #include "rs.h"
+#include "time-sync.h"
 
 /*
  * New version of ADD_STA_sta command added new fields at the end of the
@@ -1763,6 +1764,9 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 		}
 	}
 
+	iwl_mvm_time_sync_config(mvm, sta->addr, IWL_TIME_SYNC_PROTOCOL_TM |
+						 IWL_TIME_SYNC_PROTOCOL_FTM);
+
 	rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
 
 	return 0;
@@ -1972,6 +1976,8 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 	spin_lock_bh(&mvm_sta->lock);
 	spin_unlock_bh(&mvm_sta->lock);
 
+	iwl_mvm_time_sync_sta_rm(mvm, sta);
+
 	ret = iwl_mvm_rm_sta_common(mvm, mvm_sta->sta_id);
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta->sta_id], NULL);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
new file mode 100644
index 000000000000..abe9a0ec61da
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#include "mvm.h"
+#include "time-sync.h"
+#include <linux/ieee80211.h>
+
+void iwl_mvm_init_time_sync(struct iwl_time_sync_data *data)
+{
+	skb_queue_head_init(&data->frame_list);
+}
+
+static bool iwl_mvm_is_skb_match(struct sk_buff *skb, u8 *addr, u8 dialog_token)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	u8 skb_dialog_token;
+
+	if (ieee80211_is_timing_measurement(skb))
+		skb_dialog_token = mgmt->u.action.u.wnm_timing_msr.dialog_token;
+	else
+		skb_dialog_token = mgmt->u.action.u.ftm.dialog_token;
+
+	if ((ether_addr_equal(mgmt->sa, addr) ||
+	     ether_addr_equal(mgmt->da, addr)) &&
+	    skb_dialog_token == dialog_token)
+		return true;
+
+	return false;
+}
+
+static struct sk_buff *iwl_mvm_time_sync_find_skb(struct iwl_mvm *mvm, u8 *addr,
+						  u8 dialog_token)
+{
+	struct sk_buff *skb;
+
+	/*
+	 * The queue is expected to have only one SKB. If there are other SKBs
+	 * in the queue, they did not get a time sync notification and are
+	 * probably obsolete by now, so drop them.
+	 */
+	while ((skb = skb_dequeue(&mvm->time_sync.frame_list))) {
+		if (iwl_mvm_is_skb_match(skb, addr, dialog_token))
+			break;
+
+		kfree_skb(skb);
+		skb = NULL;
+	}
+
+	return skb;
+}
+
+static inline u64 iwl_mvm_get_64_bit(__le32 high, __le32 low)
+{
+	return ((u64)le32_to_cpu(high) << 32) | le32_to_cpu(low);
+}
+
+void iwl_mvm_time_sync_msmt_event(struct iwl_mvm *mvm,
+				  struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_time_msmt_notify *notif = (void *)pkt->data;
+	struct ieee80211_rx_status *rx_status;
+	struct skb_shared_hwtstamps *shwt;
+	u64 ts_10ns;
+	struct sk_buff *skb =
+		iwl_mvm_time_sync_find_skb(mvm, notif->peer_addr,
+					   le32_to_cpu(notif->dialog_token));
+
+	if (!skb) {
+		IWL_DEBUG_INFO(mvm, "Time sync event but no pending skb\n");
+		return;
+	}
+
+	ts_10ns = iwl_mvm_get_64_bit(notif->t3_hi, notif->t3_lo);
+	rx_status = IEEE80211_SKB_RXCB(skb);
+	rx_status->ack_tx_hwtstamp = ktime_set(0, ts_10ns * 10);
+
+	ts_10ns = iwl_mvm_get_64_bit(notif->t2_hi, notif->t2_lo);
+	shwt = skb_hwtstamps(skb);
+	shwt->hwtstamp = ktime_set(0, ts_10ns * 10);
+
+	IWL_DEBUG_INFO(mvm,
+		       "Time sync: RX event - report frame t2=%llu t3=%llu\n",
+		       ktime_to_ns(shwt->hwtstamp),
+		       ktime_to_ns(rx_status->ack_tx_hwtstamp));
+	ieee80211_rx_napi(mvm->hw, NULL, skb, NULL);
+}
+
+void iwl_mvm_time_sync_msmt_confirm_event(struct iwl_mvm *mvm,
+					  struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_time_msmt_cfm_notify *notif = (void *)pkt->data;
+	struct ieee80211_tx_status status = {};
+	struct skb_shared_hwtstamps *shwt;
+	u64 ts_10ns;
+
+	status.skb =
+		iwl_mvm_time_sync_find_skb(mvm, notif->peer_addr,
+					   le32_to_cpu(notif->dialog_token));
+
+	if (!status.skb) {
+		IWL_DEBUG_INFO(mvm, "Time sync confirm but no pending skb\n");
+		return;
+	}
+
+	status.info = IEEE80211_SKB_CB(status.skb);
+
+	ts_10ns = iwl_mvm_get_64_bit(notif->t4_hi, notif->t4_lo);
+	status.ack_hwtstamp = ktime_set(0, ts_10ns * 10);
+
+	ts_10ns = iwl_mvm_get_64_bit(notif->t1_hi, notif->t1_lo);
+	shwt = skb_hwtstamps(status.skb);
+	shwt->hwtstamp = ktime_set(0, ts_10ns * 10);
+
+	IWL_DEBUG_INFO(mvm,
+		       "Time sync: TX event - report frame t1=%llu t4=%llu\n",
+		       ktime_to_ns(shwt->hwtstamp),
+		       ktime_to_ns(status.ack_hwtstamp));
+	ieee80211_tx_status_ext(mvm->hw, &status);
+}
+
+int iwl_mvm_time_sync_config(struct iwl_mvm *mvm, u8 *addr, u32 protocols)
+{
+	struct iwl_time_sync_cfg_cmd cmd = {};
+	int err;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/*
+	 * The fw only supports one peer. We do allow reconfiguration of the
+	 * same peer for cases of fw reset etc.
+	 */
+	if (mvm->time_sync.active &&
+	    !ether_addr_equal(addr, mvm->time_sync.peer_addr)) {
+		IWL_DEBUG_INFO(mvm, "Time sync: reject config for peer: %pM\n",
+			       addr);
+		return -ENOBUFS;
+	}
+
+	if (protocols & ~(IWL_TIME_SYNC_PROTOCOL_TM |
+			  IWL_TIME_SYNC_PROTOCOL_FTM))
+		return -EINVAL;
+
+	cmd.protocols = cpu_to_le32(protocols);
+
+	ether_addr_copy(cmd.peer_addr, addr);
+
+	err = iwl_mvm_send_cmd_pdu(mvm,
+				   WIDE_ID(DATA_PATH_GROUP,
+					   WNM_80211V_TIMING_MEASUREMENT_CONFIG_CMD),
+				   0, sizeof(cmd), &cmd);
+	if (err) {
+		IWL_ERR(mvm, "Failed to send time sync cfg cmd: %d\n", err);
+	} else {
+		mvm->time_sync.active = protocols != 0;
+		ether_addr_copy(mvm->time_sync.peer_addr, addr);
+		IWL_DEBUG_INFO(mvm, "Time sync: set peer addr=%pM\n", addr);
+	}
+
+	return err;
+}
+
+void iwl_mvm_time_sync_sta_rm(struct iwl_mvm *mvm, struct ieee80211_sta *sta)
+{
+	/* Disable time sync with this station */
+	iwl_mvm_time_sync_config(mvm, sta->addr, 0);
+
+	skb_queue_purge(&mvm->time_sync.frame_list);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h
new file mode 100644
index 000000000000..c43d1d0b25cb
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#ifndef __TIME_SYNC_H__
+#define __TIME_SYNC_H__
+
+#include "mvm.h"
+#include <linux/ieee80211.h>
+
+void iwl_mvm_init_time_sync(struct iwl_time_sync_data *data);
+void iwl_mvm_time_sync_msmt_event(struct iwl_mvm *mvm,
+				  struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_time_sync_msmt_confirm_event(struct iwl_mvm *mvm,
+					  struct iwl_rx_cmd_buffer *rxb);
+int iwl_mvm_time_sync_config(struct iwl_mvm *mvm, u8 *addr, u32 protocols);
+void iwl_mvm_time_sync_sta_rm(struct iwl_mvm *mvm, struct ieee80211_sta *sta);
+
+static inline
+bool iwl_mvm_time_sync_frame(struct iwl_mvm *mvm, struct sk_buff *skb, u8 *addr)
+{
+	if (ether_addr_equal(mvm->time_sync.peer_addr, addr) &&
+	    (ieee80211_is_timing_measurement(skb) || ieee80211_is_ftm(skb))) {
+		skb_queue_tail(&mvm->time_sync.frame_list, skb);
+		return true;
+	}
+
+	return false;
+}
+#endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 7763037b93ed..86ea8b1f64fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -14,6 +14,7 @@
 #include "iwl-eeprom-parse.h"
 #include "mvm.h"
 #include "sta.h"
+#include "time-sync.h"
 
 static void
 iwl_mvm_bar_check_trigger(struct iwl_mvm *mvm, const u8 *addr,
@@ -1624,7 +1625,8 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		info->status.status_driver_data[0] =
 			RS_DRV_DATA_PACK(lq_color, tx_resp->reduced_tpc);
 
-		ieee80211_tx_status(mvm->hw, skb);
+		if (likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr1)))
+			ieee80211_tx_status(mvm->hw, skb);
 	}
 
 	/* This is an aggregation queue or might become one, so we use
-- 
2.35.1

