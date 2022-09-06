Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F035AEC2D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiIFOKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbiIFOI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:08:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7AE85F8C
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471981; x=1694007981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDrSV8tX9zQNNnNIQiyGZucgO8HMjlnExUc5+3dy1l4=;
  b=UEXBg8dMRPJKCsVBjL6js06mR3sLp7KIAT9Vzfe9EilQ2lrWPWFtCm/G
   Utvc77BmpVPB+d+YfDA0rDV8SqkwQAqP672GdI0d7cOca24S5HgfcUi7O
   KWKykOy0B3JNpt9BCVaadX9yCEuputx57/IiiC5oFrOEvBodnba5PYQct
   9pJAZ5CJDhIEr59tI1Tf4oLbYqqK+05qD6sstDsVnJPDIpyvkjulRZuUK
   dXgUv2qEg30f9ATqVv5jAGtFg5P1Qm1ehpAZKOWe0q29wes2xtyMLVx8e
   fdQUVUsIOz/fXBPtneQIi8Adn+PvBxi0HzGV7zL16JKSUGDBABphry/d4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276989012"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276989012"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459889"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:42 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: mvm: Add support for wowlan info notification
Date:   Tue,  6 Sep 2022 16:42:12 +0300
Message-Id: <20220906161827.3ce8deefd929.Ieba8610e8bb4bec788076371ae38becb4a3d20d5@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

IMR (Isolated Memory Regions) is a mechanism to protect memory regions
from unwarranted access by agents in the system that should not have access
to that memory.

When IMR is enabled, pages in the DRAM will be located within the IMR
memory space, accessible only by the device.
As a side effect, during S4 (a.k.a hibernate) the IMR memory space
is not retained.

While the DRAM is saved to the disk and restored by the OS upon resume,
the IMR, which is hidden from the OS neither saved upon suspend nor
restored upon resume.

As a consequence of the above, it turned out that commands cannot
be sent as part of the resume flow, and so after ending
d3 the FW needs to use notifications instead of cmd-resp.

The resume flow becomes asynchronous, with a series
of notifications, starting with wowlan_info_notif, through
wowlan_pkt_notif and complete the resume flow by d3_end_notif.

This patch adds the support for wowlan info notification.

The wake packet has been removed from the wowlan info struct
and will be handled in a dedicated notification.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  39 ++-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 227 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 4 files changed, 230 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 4cd9ab23954e..7b2501fe50e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -766,6 +766,43 @@ struct iwl_wowlan_status_v12 {
 	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
 } __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_12 */
 
+/**
+ * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched patterns
+ * @reserved1: reserved
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @transmitted_ndps: number of transmitted neighbor discovery packets
+ * @received_beacons: number of received beacons
+ * @wake_packet_length: wakeup packet length
+ * @wake_packet_bufsize: wakeup packet buffer size
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *	in suspend state
+ * @station_id: station id
+ * @reserved2: reserved
+ */
+struct iwl_wowlan_info_notif {
+	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 reserved1;
+	__le16 qos_seq_ctr[8];
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	__le32 transmitted_ndps;
+	__le32 received_beacons;
+	__le32 wake_packet_length;
+	__le32 wake_packet_bufsize;
+	u8 tid_tear_down;
+	u8 station_id;
+	u8 reserved2[2];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_1 */
+
 /* TODO: NetDetect API */
 
 #endif /* __iwl_fw_api_d3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 5204aa94e72a..ae2263e2e293 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -3,7 +3,7 @@
  * Copyright (C) 2012-2014 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2021 Intel Corporation
+ * Copyright (C) 2021-2022 Intel Corporation
  */
 #ifndef __iwl_fw_api_offload_h__
 #define __iwl_fw_api_offload_h__
@@ -12,6 +12,11 @@
  * enum iwl_prot_offload_subcmd_ids - protocol offload commands
  */
 enum iwl_prot_offload_subcmd_ids {
+	/**
+	 * @WOWLAN_INFO_NOTIFICATION: Notification in &struct iwl_wowlan_info_notif
+	 */
+	WOWLAN_INFO_NOTIFICATION = 0xFD,
+
 	/**
 	 * @STORED_BEACON_NTF: &struct iwl_stored_beacon_notif
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 518755b756b4..f522cc105b53 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1995,6 +1995,30 @@ iwl_mvm_parse_wowlan_status_common(v7)
 iwl_mvm_parse_wowlan_status_common(v9)
 iwl_mvm_parse_wowlan_status_common(v12)
 
+static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
+					    struct iwl_wowlan_info_notif *data,
+					    struct iwl_wowlan_status_data *status,
+					    u32 len)
+{
+	u32 i;
+
+	if (len < sizeof(*data)) {
+		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
+		status = NULL;
+		return;
+	}
+
+	status->replay_ctr = le64_to_cpu(data->replay_ctr);
+	status->pattern_number = le16_to_cpu(data->pattern_number);
+	for (i = 0; i < IWL_MAX_TID_COUNT; i++)
+		status->qos_seq_ctr[i] =
+			le16_to_cpu(data->qos_seq_ctr[i]);
+	status->wakeup_reasons = le32_to_cpu(data->wakeup_reasons);
+	status->num_of_gtk_rekeys =
+		le32_to_cpu(data->num_of_gtk_rekeys);
+	status->received_beacons = le32_to_cpu(data->received_beacons);
+}
+
 static void iwl_mvm_convert_gtk_v2(struct iwl_wowlan_status_data *status,
 				   struct iwl_wowlan_gtk_status_v2 *data)
 {
@@ -2194,15 +2218,13 @@ iwl_mvm_get_wakeup_status(struct iwl_mvm *mvm, u8 sta_id)
 
 /* releases the MVM mutex */
 static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
-					 struct ieee80211_vif *vif)
+					 struct ieee80211_vif *vif,
+					 struct iwl_wowlan_status_data *status)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_wowlan_status_data *status;
 	int i;
 	bool keep;
 	struct iwl_mvm_sta *mvm_ap_sta;
 
-	status = iwl_mvm_get_wakeup_status(mvm, mvmvif->ap_sta_id);
 	if (!status)
 		goto out_unlock;
 
@@ -2212,7 +2234,7 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	/* still at hard-coded place 0 for D3 image */
 	mvm_ap_sta = iwl_mvm_sta_from_staid_protected(mvm, 0);
 	if (!mvm_ap_sta)
-		goto out_free;
+		goto out_unlock;
 
 	for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
 		u16 seq = status->qos_seq_ctr[i];
@@ -2235,11 +2257,8 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 
 	keep = iwl_mvm_setup_connection_keep(mvm, vif, status);
 
-	kfree(status);
 	return keep;
 
-out_free:
-	kfree(status);
 out_unlock:
 	mutex_unlock(&mvm->mutex);
 	return false;
@@ -2356,24 +2375,23 @@ static void iwl_mvm_query_set_freqs(struct iwl_mvm *mvm,
 }
 
 static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
-					    struct ieee80211_vif *vif)
+					    struct ieee80211_vif *vif,
+					    struct iwl_wowlan_status_data *status)
 {
 	struct cfg80211_wowlan_nd_info *net_detect = NULL;
 	struct cfg80211_wowlan_wakeup wakeup = {
 		.pattern_idx = -1,
 	};
 	struct cfg80211_wowlan_wakeup *wakeup_report = &wakeup;
-	struct iwl_wowlan_status_data *status;
 	struct iwl_mvm_nd_query_results query;
 	unsigned long matched_profiles;
 	u32 reasons = 0;
 	int i, n_matches, ret;
 
-	status = iwl_mvm_get_wakeup_status(mvm, IWL_MVM_INVALID_STA);
-	if (status) {
-		reasons = status->wakeup_reasons;
-		kfree(status);
-	}
+	if (WARN_ON(!status))
+		return;
+
+	reasons = status->wakeup_reasons;
 
 	if (reasons & IWL_WOWLAN_WAKEUP_BY_RFKILL_DEASSERTED)
 		wakeup.rfkill_release = true;
@@ -2504,16 +2522,142 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 	return false;
 }
 
+/**
+ * enum iwl_d3_notif - d3 notifications
+ * @IWL_D3_NOTIF_WOWLAN_INFO: WOWLAN_INFO_NOTIF was received
+ */
+enum iwl_d3_notif {
+	IWL_D3_NOTIF_WOWLAN_INFO =	BIT(0),
+};
+
+/* manage d3 resume data */
+struct iwl_d3_data {
+	struct iwl_wowlan_status_data *status;
+	bool test;
+	u32 notif_expected;	/* bitmap - see &enum iwl_d3_notif */
+	u32 notif_received;	/* bitmap - see &enum iwl_d3_notif */
+};
+
+/*
+ * This function assumes:
+ *	1. The mutex is already held.
+ *	2. The callee functions unlock the mutex.
+ */
+static void iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
+						struct ieee80211_vif *vif,
+						struct iwl_d3_data *d3_data,
+						bool test)
+{
+	lockdep_assert_held(&mvm->mutex);
+
+	/* if FW uses status notification, status shouldn't be NULL here */
+	if (!d3_data->status) {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+		d3_data->status = iwl_mvm_get_wakeup_status(mvm, mvm->net_detect ?
+							    IWL_MVM_INVALID_STA :
+							    mvmvif->ap_sta_id);
+	}
+
+	if (mvm->net_detect) {
+		iwl_mvm_query_netdetect_reasons(mvm, vif, d3_data->status);
+	} else {
+		bool keep = iwl_mvm_query_wakeup_reasons(mvm, vif,
+							 d3_data->status);
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+		if (keep)
+			mvm->keep_vif = vif;
+#endif
+
+		if (!test)
+			ieee80211_iterate_active_interfaces_mtx(mvm->hw,
+								IEEE80211_IFACE_ITER_NORMAL,
+								iwl_mvm_d3_disconnect_iter,
+								keep ? vif : NULL);
+	}
+}
+
+static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
+				  struct iwl_rx_packet *pkt, void *data)
+{
+	struct iwl_mvm *mvm =
+		container_of(notif_wait, struct iwl_mvm, notif_wait);
+	struct iwl_d3_data *d3_data = data;
+	u32 len;
+
+	switch (WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd)) {
+	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION): {
+		struct iwl_wowlan_info_notif *notif = (void *)pkt->data;
+
+		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
+			/* We might get two notifications due to dual bss */
+			IWL_DEBUG_WOWLAN(mvm,
+					 "Got additional wowlan info notification\n");
+			break;
+		}
+
+		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
+		len = iwl_rx_packet_payload_len(pkt);
+		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
+						len);
+		break;
+	}
+	default:
+		WARN_ON(1);
+	}
+
+	return d3_data->notif_received == d3_data->notif_expected;
+}
+
+#define IWL_MVM_D3_NOTIF_TIMEOUT (HZ / 5)
+
+static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
+				 struct iwl_d3_data *d3_data,
+				 enum iwl_d3_status *d3_status,
+				 bool test)
+{
+	static const u16 d3_resume_notif[] = {
+		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION)
+	};
+	struct iwl_notification_wait wait_d3_notif;
+	int ret;
+
+	iwl_init_notification_wait(&mvm->notif_wait, &wait_d3_notif,
+				   d3_resume_notif, ARRAY_SIZE(d3_resume_notif),
+				   iwl_mvm_wait_d3_notif, d3_data);
+
+	ret = iwl_trans_d3_resume(mvm->trans, d3_status, test, false);
+	if (ret) {
+		iwl_remove_notification(&mvm->notif_wait, &wait_d3_notif);
+		return ret;
+	}
+
+	if (*d3_status != IWL_D3_STATUS_ALIVE) {
+		IWL_INFO(mvm, "Device was reset during suspend\n");
+		iwl_remove_notification(&mvm->notif_wait, &wait_d3_notif);
+		return -ENOENT;
+	}
+
+	return iwl_wait_notification(&mvm->notif_wait, &wait_d3_notif,
+				     IWL_MVM_D3_NOTIF_TIMEOUT);
+}
+
 static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 {
 	struct ieee80211_vif *vif = NULL;
 	int ret = 1;
 	enum iwl_d3_status d3_status;
-	bool keep = false;
+	struct iwl_d3_data d3_data = {
+		.test = test,
+		.notif_expected = IWL_D3_NOTIF_WOWLAN_INFO,
+	};
 	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 	bool d0i3_first = fw_has_capa(&mvm->fw->ucode_capa,
 				      IWL_UCODE_TLV_CAPA_D0I3_END_FIRST);
+	/* currently disabled */
+	bool resume_notif_based = false;
 
 	mutex_lock(&mvm->mutex);
 
@@ -2537,7 +2681,20 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		goto err;
 	}
 
-	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test, !unified_image);
+	if (resume_notif_based) {
+		d3_data.status = kzalloc(sizeof(*d3_data.status), GFP_KERNEL);
+		if (!d3_data.status) {
+			IWL_ERR(mvm, "Failed to allocate wowlan status\n");
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = iwl_mvm_d3_notif_wait(mvm, &d3_data, &d3_status, test);
+	} else {
+		ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test,
+					  !unified_image);
+	}
+
 	if (ret)
 		goto err;
 
@@ -2546,7 +2703,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		goto err;
 	}
 
-	if (d0i3_first) {
+	if (d0i3_first && mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_22000) {
 		struct iwl_host_cmd cmd = {
 			.id = D0I3_END_CMD,
 			.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
@@ -2576,41 +2733,27 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		/*  Re-configure default SAR profile */
 		iwl_mvm_sar_select_profile(mvm, 1, 1);
 
-	if (mvm->net_detect) {
+	if (mvm->net_detect && unified_image) {
 		/* If this is a non-unified image, we restart the FW,
 		 * so no need to stop the netdetect scan.  If that
 		 * fails, continue and try to get the wake-up reasons,
 		 * but trigger a HW restart by keeping a failure code
 		 * in ret.
 		 */
-		if (unified_image)
-			ret = iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_NETDETECT,
-						false);
-
-		iwl_mvm_query_netdetect_reasons(mvm, vif);
-		/* has unlocked the mutex, so skip that */
-		goto out;
-	} else {
-		keep = iwl_mvm_query_wakeup_reasons(mvm, vif);
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-		if (keep)
-			mvm->keep_vif = vif;
-#endif
-		/* has unlocked the mutex, so skip that */
-		goto out_iterate;
+		ret = iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_NETDETECT,
+					false);
 	}
 
+	iwl_mvm_choose_query_wakeup_reasons(mvm, vif, &d3_data, d3_data.test);
+	/* has unlocked the mutex, so skip that */
+	goto out;
+
 err:
-	iwl_mvm_free_nd(mvm);
 	mutex_unlock(&mvm->mutex);
-
-out_iterate:
-	if (!test)
-		ieee80211_iterate_active_interfaces_mtx(mvm->hw,
-			IEEE80211_IFACE_ITER_NORMAL,
-			iwl_mvm_d3_disconnect_iter, keep ? vif : NULL);
-
 out:
+	kfree(d3_data.status);
+	iwl_mvm_free_nd(mvm);
+
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
 
 	/* no need to reset the device in unified images, if successful */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 7ed4f5a0abc3..e380ee841773 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -574,6 +574,7 @@ static const struct iwl_hcmd_names iwl_mvm_location_names[] = {
  * Access is done through binary search
  */
 static const struct iwl_hcmd_names iwl_mvm_prot_offload_names[] = {
+	HCMD_NAME(WOWLAN_INFO_NOTIFICATION),
 	HCMD_NAME(STORED_BEACON_NTF),
 };
 
-- 
2.35.3

