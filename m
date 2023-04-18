Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9311C6E5D5E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjDRJ2v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDRJ2t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD0F65B9
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810123; x=1713346123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69MK9Erzn+cDVftWq/UrBPW3VO6Y/giKHlSKRx8mJxs=;
  b=O/Zw5gCJLXymiG1YTd8V6FWY8DBJ14P3NFIwtBobaW7d51eU8FaVUEBx
   He+Tk3NKzvNRA9xTYXEZlTtbrx3kI4rAolGWZHYpueh83OvMEWEhzL4Kr
   vcWkVQ+FLUf5H0JLHLIoU4xWswKKkQ41/CklW2205waG+rHtlPB7l95yF
   0HDoTQv6hMHkNbQ1HrJdNxkEmWs4M4VAuEjwguJqVWSWLOgo9q1z269Vp
   GJpjExa6SJ4o/2ui5GNDCyPcGbj7f83TnTOP7UTq9cMgOpGVs5kcBzd+E
   qjJeJ+nn4C0ytzwBfP0CpFObNkNzjP5NlJDGlah+mwz20+8XoOkNCgPko
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341186"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341186"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511235"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511235"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/11] wifi: iwlwifi: modify scan request and results when in link protection
Date:   Tue, 18 Apr 2023 12:28:11 +0300
Message-Id: <20230418122405.c1b55de3d704.I3895eebe18b3b672607695c887d728e113fc85ec@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When CSME is connected and has link protection set, the driver must
connect to the same AP CSME is connected to.
When in link protection, modify scan request parameters to include
only the channel of the AP CSME is connected to and scan for the
same SSID. In addition, filter the scan results to include only
results from the same AP. This will make sure the driver will connect
to the same AP and will do it fast enough to keep the session alive.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 25 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 78 +++++++++++++++++++
 4 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 203eb7233c77..6e7470d3a826 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -826,6 +826,12 @@ struct iwl_time_sync_data {
 	bool active;
 };
 
+struct iwl_mei_scan_filter {
+	bool is_mei_limited_scan;
+	struct sk_buff_head scan_res;
+	struct work_struct scan_work;
+};
+
 struct iwl_mvm {
 	/* for logger access */
 	struct device *dev;
@@ -1177,6 +1183,8 @@ struct iwl_mvm {
 	bool pldr_sync;
 
 	struct iwl_time_sync_data time_sync;
+
+	struct iwl_mei_scan_filter mei_scan_filter;
 };
 
 /* Extract MVM priv from op_mode and _hw */
@@ -2304,6 +2312,7 @@ void iwl_mvm_event_frame_timeout_callback(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
 					  const struct ieee80211_sta *sta,
 					  u16 tid);
+void iwl_mvm_mei_scan_filter_init(struct iwl_mei_scan_filter *mei_scan_filter);
 
 void iwl_mvm_ptp_init(struct iwl_mvm *mvm);
 void iwl_mvm_ptp_remove(struct iwl_mvm *mvm);
@@ -2515,6 +2524,22 @@ static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm)
 					 sw_rfkill);
 }
 
+static inline bool iwl_mvm_mei_filter_scan(struct iwl_mvm *mvm,
+					   struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+
+	if (mvm->mei_scan_filter.is_mei_limited_scan &&
+	    (ieee80211_is_probe_resp(mgmt->frame_control) ||
+	     ieee80211_is_beacon(mgmt->frame_control))) {
+		skb_queue_tail(&mvm->mei_scan_filter.scan_res, skb);
+		schedule_work(&mvm->mei_scan_filter.scan_work);
+		return true;
+	}
+
+	return false;
+}
+
 void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
 					  bool forbidden);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 8bb865e708dc..26c3f00d6f7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1375,6 +1375,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	mvm->mei_registered = !iwl_mei_register(mvm, &mei_ops);
 
+	iwl_mvm_mei_scan_filter_init(&mvm->mei_scan_filter);
+
 	if (iwl_mvm_start_get_nvm(mvm)) {
 		/*
 		 * Getting NVM failed while CSME is the owner, but we are
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 542f6658f2d4..e1d02c260e69 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2588,10 +2588,10 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc) &&
-	    likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2)))
+	    likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2)) &&
+	    likely(!iwl_mvm_mei_filter_scan(mvm, skb)))
 		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue, sta,
 						link_sta);
-
 out:
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 1e20f9538640..fe7cb33d5593 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2624,6 +2624,80 @@ static const struct iwl_scan_umac_handler iwl_scan_umac_handlers[] = {
 	IWL_SCAN_UMAC_HANDLER(12),
 };
 
+static void iwl_mvm_mei_scan_work(struct work_struct *wk)
+{
+	struct iwl_mei_scan_filter *scan_filter =
+		container_of(wk, struct iwl_mei_scan_filter, scan_work);
+	struct iwl_mvm *mvm =
+		container_of(scan_filter, struct iwl_mvm, mei_scan_filter);
+	struct iwl_mvm_csme_conn_info *info;
+	struct sk_buff *skb;
+	u8 bssid[ETH_ALEN];
+
+	mutex_lock(&mvm->mutex);
+	info = iwl_mvm_get_csme_conn_info(mvm);
+	memcpy(bssid, info->conn_info.bssid, ETH_ALEN);
+	mutex_unlock(&mvm->mutex);
+
+	while ((skb = skb_dequeue(&scan_filter->scan_res))) {
+		struct ieee80211_mgmt *mgmt = (void *)skb->data;
+
+		if (!memcmp(mgmt->bssid, bssid, ETH_ALEN))
+			ieee80211_rx_irqsafe(mvm->hw, skb);
+		else
+			kfree_skb(skb);
+	}
+}
+
+void iwl_mvm_mei_scan_filter_init(struct iwl_mei_scan_filter *mei_scan_filter)
+{
+	skb_queue_head_init(&mei_scan_filter->scan_res);
+	INIT_WORK(&mei_scan_filter->scan_work, iwl_mvm_mei_scan_work);
+}
+
+/* In case CSME is connected and has link protection set, this function will
+ * override the scan request to scan only the associated channel and only for
+ * the associated SSID.
+ */
+static void iwl_mvm_mei_limited_scan(struct iwl_mvm *mvm,
+				     struct iwl_mvm_scan_params *params)
+{
+	struct iwl_mvm_csme_conn_info *info = iwl_mvm_get_csme_conn_info(mvm);
+	struct iwl_mei_conn_info *conn_info;
+	struct ieee80211_channel *chan;
+
+	if (!info) {
+		IWL_DEBUG_SCAN(mvm, "mei_limited_scan: no connection info\n");
+		return;
+	}
+
+	conn_info = &info->conn_info;
+	if (!info->conn_info.lp_state || !info->conn_info.ssid_len)
+		return;
+
+	if (!params->n_channels || !params->n_ssids)
+		return;
+
+	mvm->mei_scan_filter.is_mei_limited_scan = true;
+
+	chan = ieee80211_get_channel(mvm->hw->wiphy,
+				     ieee80211_channel_to_frequency(conn_info->channel,
+								    conn_info->band));
+	if (!chan) {
+		IWL_DEBUG_SCAN(mvm,
+			       "Failed to get CSME channel (chan=%u band=%u)\n",
+			       conn_info->channel, conn_info->band);
+		return;
+	}
+
+	params->n_channels = 1;
+	params->channels[0] = chan;
+
+	params->n_ssids = 1;
+	params->ssids[0].ssid_len = conn_info->ssid_len;
+	memcpy(params->ssids[0].ssid, conn_info->ssid, conn_info->ssid_len);
+}
+
 static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 				  struct ieee80211_vif *vif,
 				  struct iwl_host_cmd *hcmd,
@@ -2636,6 +2710,8 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 	lockdep_assert_held(&mvm->mutex);
 	memset(mvm->scan_cmd, 0, mvm->scan_cmd_size);
 
+	iwl_mvm_mei_limited_scan(mvm, params);
+
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN)) {
 		hcmd->id = SCAN_OFFLOAD_REQUEST_CMD;
 
@@ -2992,6 +3068,8 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 	u32 uid = __le32_to_cpu(notif->uid);
 	bool aborted = (notif->status == IWL_SCAN_OFFLOAD_ABORTED);
 
+	mvm->mei_scan_filter.is_mei_limited_scan = false;
+
 	if (WARN_ON(!(mvm->scan_uid_status[uid] & mvm->scan_status)))
 		return;
 
-- 
2.38.1

