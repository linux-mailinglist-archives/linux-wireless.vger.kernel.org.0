Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B54E2EFE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 18:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351811AbiCURYo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351800AbiCURYn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 13:24:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472F16BFA1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647883396; x=1679419396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=v+8Jv0xjRh0he1ceXQBpcbudn/EzVD/RCU8bxLktqsE=;
  b=fT7GHT4IstW+2A5uJCWC6qwk8PxSoMMS5BrEeXMziklqOhsB3wlanD1P
   cygQgTXj7QoW13FSoVO1YEnpaD13pPLja/KB+bab1CXSwO8fFZoYxUi4T
   3fUFc3sAcbYtU+nbvejp+4sb8NUVj9qdVz1bUS/Uudou2kriHKXcLVlus
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 10:23:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:23:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 10:23:11 -0700
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 03:17:31 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH v4 3/3] ath11k: Add ROC support for wide band scan
Date:   Mon, 21 Mar 2022 15:46:37 +0530
Message-ID: <1647857797-19749-4-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647857797-19749-1-git-send-email-quic_ppranees@quicinc.com>
References: <1647857797-19749-1-git-send-email-quic_ppranees@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wide Band Scan allows to perform off-channel scan on requested channel/
frequency along with corresponding phy mode/bandwidth (40MHz, 80MHz).

Doing wide band scan instead of normal 20MHz scan before spectral dump,
allows to fetch FFT reports for the complete requested bandwidth
(40MHz, 80MHz).

Below are the FW expectations and configs from host to request
Wide Band Scan,

1. SCAN_PHYMODE_SUPPORT WMI service bit advertised from FW.

2. SCAN_CHAN_LIST_CMD updated with the phymode and other channel params
   of the requested channel to do wide band scan.

3. START_SCAN_CMD updated with all the seven supported TLVs and PHYMODE
   TLV being the last. PHYMODE TLV holds the (wmi_phy_mode + 1) value
   corresponding to wide band scan channel. Scan flags scan_f_wide_band
   and scan_f_passive need to be set for wide band scan request from
   host.

This new ops callback (ath11k_mac_op_remain_on_channel) for ROC will
holds the cfg80211_chan_def of the requested channel from which we
update the center frequencies and phymode params needed for
SCAN_CHAN_LIST_CMD and START_SCAN_CMD to FW.

Below are use cases of Wide Band Scan,

1. In case of phy running both AP and monitor vifs, wide band scan on
   a different channel along with phymode (40MHz, 80MHz) captures
   those off-channel data frames to monitor vif.

2. Doing wide band scan instead of normal 20MHz scan before spectral
   dump, allows to fetch FFT reports for the complete requested
   bandwidth (40MHz, 80MHz).

Since wide band scan is the AP mode feature and this support is
enabled when firmware advertise SCAN_PHYMODE_SUPPORT wmi service bit,
it will not affect QCA6390.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00156-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 213 ++++++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/wmi.c  |  59 ++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  |  24 +++-
 4 files changed, 261 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 5d570a2..85d21f1 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1297,6 +1297,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		complete(&ar->vdev_delete_done);
 		complete(&ar->bss_survey_done);
 		complete(&ar->thermal.wmi_sync);
+		complete(&ar->scan.on_channel);
 
 		wake_up(&ar->dp.tx_empty_waitq);
 		idr_for_each(&ar->txmgmt_idr,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index bde669c..bf83569 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3568,7 +3568,7 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct cfg80211_scan_request *req = &hw_req->req;
-	struct scan_req_params arg;
+	struct scan_req_params *arg = NULL;
 	int ret = 0;
 	int i;
 
@@ -3615,52 +3615,56 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 			   "mac wait 11d channel list time left %ld\n", time_left);
 	}
 
-	memset(&arg, 0, sizeof(arg));
-	ath11k_wmi_start_scan_init(ar, &arg);
-	arg.vdev_id = arvif->vdev_id;
-	arg.scan_id = ATH11K_SCAN_ID;
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ath11k_wmi_start_scan_init(ar, arg);
+	arg->vdev_id = arvif->vdev_id;
+	arg->scan_id = ATH11K_SCAN_ID;
 
 	if (req->ie_len) {
-		arg.extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
-		if (!arg.extraie.ptr) {
+		arg->extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
+		if (!arg->extraie.ptr) {
 			ret = -ENOMEM;
 			goto exit;
 		}
-		arg.extraie.len = req->ie_len;
+		arg->extraie.len = req->ie_len;
 	}
 
 	if (req->n_ssids) {
-		arg.num_ssids = req->n_ssids;
-		for (i = 0; i < arg.num_ssids; i++) {
-			arg.ssid[i].length  = req->ssids[i].ssid_len;
-			memcpy(&arg.ssid[i].ssid, req->ssids[i].ssid,
+		arg->num_ssids = req->n_ssids;
+		for (i = 0; i < arg->num_ssids; i++) {
+			arg->ssid[i].length  = req->ssids[i].ssid_len;
+			memcpy(&arg->ssid[i].ssid, req->ssids[i].ssid,
 			       req->ssids[i].ssid_len);
 		}
 	} else {
-		arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
+		arg->scan_flags |= WMI_SCAN_FLAG_PASSIVE;
 	}
 
 	if (req->n_channels) {
-		arg.num_chan = req->n_channels;
-		arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
-					GFP_KERNEL);
-
-		if (!arg.chan_list) {
+		arg->num_chan = req->n_channels;
+		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
+					 GFP_KERNEL);
+		if (!arg->chan_list) {
 			ret = -ENOMEM;
 			goto exit;
 		}
 
-		for (i = 0; i < arg.num_chan; i++)
-			arg.chan_list[i] = req->channels[i]->center_freq;
+		for (i = 0; i < arg->num_chan; i++)
+			arg->chan_list[i] = req->channels[i]->center_freq;
 	}
 
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
-		arg.scan_f_add_spoofed_mac_in_probe = 1;
-		ether_addr_copy(arg.mac_addr.addr, req->mac_addr);
-		ether_addr_copy(arg.mac_mask.addr, req->mac_addr_mask);
+		arg->scan_f_add_spoofed_mac_in_probe = 1;
+		ether_addr_copy(arg->mac_addr.addr, req->mac_addr);
+		ether_addr_copy(arg->mac_mask.addr, req->mac_addr_mask);
 	}
 
-	ret = ath11k_start_scan(ar, &arg);
+	ret = ath11k_start_scan(ar, arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
 		spin_lock_bh(&ar->data_lock);
@@ -3670,15 +3674,11 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	/* Add a 200ms margin to account for event/command processing */
 	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
-				     msecs_to_jiffies(arg.max_scan_time +
+				     msecs_to_jiffies(arg->max_scan_time +
 						      ATH11K_MAC_SCAN_TIMEOUT_MSECS));
 
 exit:
-	kfree(arg.chan_list);
-
-	if (req->ie_len)
-		kfree(arg.extraie.ptr);
-
+	kfree(arg);
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
@@ -4478,6 +4478,152 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	return ret;
 }
 
+#define ATH11K_ROC_TIMEOUT_HZ (3 * HZ)
+
+static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct cfg80211_chan_def *chandef,
+					   int duration,
+					   enum ieee80211_roc_type type)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct ieee80211_channel *chan;
+	struct scan_req_params *arg;
+	int ret;
+	u32 scan_time_msec;
+
+	if (!test_bit(WMI_TLV_SERVICE_SCAN_PHYMODE_SUPPORT,
+		      ar->ab->wmi_ab.svc_map)) {
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "ROC feature not supported!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!chandef || !chandef->chan) {
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "null chandef !\n");
+		return -EINVAL;
+	}
+
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg)
+		return -ENOMEM;
+
+	chan = chandef->chan;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "chandef chan %d, duration %d\n",
+		   chan->center_freq, duration);
+	mutex_lock(&ar->conf_mutex);
+
+	spin_lock_bh(&ar->data_lock);
+	switch (ar->scan.state) {
+	case ATH11K_SCAN_IDLE:
+		reinit_completion(&ar->scan.started);
+		reinit_completion(&ar->scan.completed);
+		reinit_completion(&ar->scan.on_channel);
+		ar->scan.state = ATH11K_SCAN_STARTING;
+		ar->scan.is_roc = true;
+		ar->scan.vdev_id = arvif->vdev_id;
+		ar->scan.roc_freq = chan->center_freq;
+		ar->scan.roc_notify = true;
+		ret = 0;
+		break;
+	case ATH11K_SCAN_STARTING:
+	case ATH11K_SCAN_RUNNING:
+	case ATH11K_SCAN_ABORTING:
+		ret = -EBUSY;
+		break;
+	}
+
+	spin_unlock_bh(&ar->data_lock);
+
+	if (ret)
+		goto exit;
+
+	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;
+
+	ath11k_wmi_start_scan_init(ar, arg);
+	arg->vdev_id = arvif->vdev_id;
+	arg->scan_id = ATH11K_SCAN_ID;
+	arg->dwell_time_active = scan_time_msec;
+	arg->dwell_time_passive = scan_time_msec;
+	arg->max_scan_time = scan_time_msec;
+	arg->burst_duration = duration;
+
+	arg->phymode = ath11k_phymodes[chandef->chan->band][chandef->width];
+	if (arg->phymode) {
+		arg->scan_f_wide_band = true;
+		arg->scan_f_passive = true;
+		arg->chandef = chandef;
+		arg->num_chan = 1;
+		ret = ath11k_reg_update_chan_list(ar, arg);
+		if (ret)
+			goto exit;
+	}
+
+	if (arg->num_chan) {
+		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
+					 GFP_KERNEL);
+		if (!arg->chan_list) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		arg->chan_list[0] = chandef->chan->center_freq;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "ath11k ROC arg freq %d phymode %d\n",
+		   arg->chandef->chan->center_freq, arg->phymode);
+
+	ret = ath11k_start_scan(ar, arg);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to start roc scan: %d\n", ret);
+		spin_lock_bh(&ar->data_lock);
+		ar->scan.state = ATH11K_SCAN_IDLE;
+		spin_unlock_bh(&ar->data_lock);
+		goto exit;
+	}
+
+	ret = wait_for_completion_timeout(&ar->scan.on_channel, ATH11K_ROC_TIMEOUT_HZ);
+	if (ret == 0) {
+		ath11k_warn(ar->ab, "failed to switch to channel for roc scan\n");
+		ret = ath11k_scan_stop(ar);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to stop scan: %d\n", ret);
+
+		ret = -ETIMEDOUT;
+		goto exit;
+	}
+
+	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
+				     msecs_to_jiffies(arg->max_scan_time +
+				     ATH11K_MAC_SCAN_TIMEOUT_MSECS));
+	ret = 0;
+exit:
+	kfree(arg);
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static int ath11k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
+						  struct ieee80211_vif *vif)
+{
+	struct ath11k *ar = hw->priv;
+
+	mutex_lock(&ar->conf_mutex);
+
+	spin_lock_bh(&ar->data_lock);
+	ar->scan.roc_notify = false;
+	spin_unlock_bh(&ar->data_lock);
+
+	ath11k_scan_abort(ar);
+
+	mutex_unlock(&ar->conf_mutex);
+
+	cancel_delayed_work_sync(&ar->scan.timeout);
+
+	return 0;
+}
+
 static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -8088,6 +8234,8 @@ static const struct ieee80211_ops ath11k_ops = {
 	.sta_set_txpwr			= ath11k_mac_op_sta_set_txpwr,
 	.sta_rc_update			= ath11k_mac_op_sta_rc_update,
 	.conf_tx                        = ath11k_mac_op_conf_tx,
+	.remain_on_channel              = ath11k_mac_op_remain_on_channel,
+	.cancel_remain_on_channel       = ath11k_mac_op_cancel_remain_on_channel,
 	.set_antenna			= ath11k_mac_op_set_antenna,
 	.get_antenna			= ath11k_mac_op_get_antenna,
 	.ampdu_action			= ath11k_mac_op_ampdu_action,
@@ -8423,6 +8571,10 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
 
+	if (test_bit(WMI_TLV_SERVICE_SCAN_PHYMODE_SUPPORT,
+		     ar->ab->wmi_ab.svc_map))
+		ieee80211_hw_set(ar->hw, SUPPORTS_EXT_REMAIN_ON_CHAN);
+
 	if (ath11k_frame_mode == ATH11K_HW_TXRX_ETHERNET) {
 		ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 		ieee80211_hw_set(ar->hw, SUPPORTS_RX_DECAP_OFFLOAD);
@@ -8653,6 +8805,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->scan.started);
 		init_completion(&ar->scan.completed);
 		init_completion(&ar->thermal.wmi_sync);
+		init_completion(&ar->scan.on_channel);
 
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
 		INIT_WORK(&ar->regd_update_work, ath11k_regd_update_work);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b4f86c4..d818713 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2108,9 +2108,9 @@ ath11k_wmi_copy_scan_event_cntrl_flags(struct wmi_start_scan_cmd *cmd,
 		cmd->scan_ctrl_flags |=  WMI_SCAN_ADD_SPOOF_MAC_IN_PROBE_REQ;
 	if (param->scan_f_add_rand_seq_in_probe)
 		cmd->scan_ctrl_flags |=  WMI_SCAN_RANDOM_SEQ_NO_IN_PROBE_REQ;
-	if (param->scan_f_en_ie_whitelist_in_probe)
+	if (param->scan_f_en_ie_list_in_probe)
 		cmd->scan_ctrl_flags |=
-			 WMI_SCAN_ENABLE_IE_WHTELIST_IN_PROBE_REQ;
+			 WMI_SCAN_ENABLE_IE_LIST_IN_PROBE_REQ;
 
 	/* for adaptive scan mode using 3 bits (21 - 23 bits) */
 	WMI_SCAN_SET_DWELL_MODE(cmd->scan_ctrl_flags,
@@ -2132,6 +2132,8 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	u16 extraie_len_with_pad = 0;
 	struct hint_short_ssid *s_ssid = NULL;
 	struct hint_bssid *hint_bssid = NULL;
+	u8 *phy_ptr;
+	u8 phymode_roundup = 0;
 
 	len = sizeof(*cmd);
 
@@ -2161,6 +2163,18 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 		len += TLV_HDR_SIZE +
 		       params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
 
+	len += TLV_HDR_SIZE;
+	if (params->scan_f_en_ie_list_in_probe)
+		len += params->ie_list.num_vendor_oui *
+		       sizeof(struct wmi_vendor_oui);
+
+	len += TLV_HDR_SIZE;
+	if (params->scan_f_wide_band)
+		phymode_roundup =
+			roundup(params->num_chan * sizeof(u8),
+				sizeof(u32));
+	len += phymode_roundup;
+
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
@@ -2192,11 +2206,12 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	cmd->max_scan_time = params->max_scan_time;
 	cmd->probe_delay = params->probe_delay;
 	cmd->burst_duration = params->burst_duration;
-	cmd->num_chan = params->num_chan;
+	cmd->num_chan = params->num_chan;
 	cmd->num_bssid = params->num_bssid;
 	cmd->num_ssids = params->num_ssids;
 	cmd->ie_len = params->extraie.len;
 	cmd->n_probes = params->n_probes;
+	cmd->num_vendor_oui = params->ie_list.num_vendor_oui;
 	ether_addr_copy(cmd->mac_addr.addr, params->mac_addr.addr);
 	ether_addr_copy(cmd->mac_mask.addr, params->mac_mask.addr);
 
@@ -2292,8 +2307,41 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 					&hint_bssid->bssid.addr[0]);
 			hint_bssid++;
 		}
+		ptr += len;
+	}
+
+	len = params->ie_list.num_vendor_oui *
+	      sizeof(struct wmi_vendor_oui);
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+				 FIELD_PREP(WMI_TLV_LEN, len);
+	ptr += TLV_HDR_SIZE;
+
+	if (params->scan_f_en_ie_list_in_probe) {
+		/* TODO: fill vendor OUIs for probe req ie listing
+		 * currently added for FW TLV validation
+		 */
 	}
 
+	ptr += len;
+
+	len = phymode_roundup;
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+				 FIELD_PREP(WMI_TLV_LEN, len);
+	ptr += TLV_HDR_SIZE;
+
+	/* Wide Band Scan */
+	if (params->scan_f_wide_band) {
+		phy_ptr = (u8 *)ptr;
+		/* Add PHY mode TLV for wide band scan with phymode + 1 value
+		 * so that phymode '0' is ignored by FW as default value.
+		 */
+		for (i = 0; i < params->num_chan; ++i)
+			phy_ptr[i] = params->phymode + 1;
+	}
+	ptr += phymode_roundup;
+
 	ret = ath11k_wmi_cmd_send(wmi, skb,
 				  WMI_START_SCAN_CMDID);
 	if (ret) {
@@ -5256,6 +5304,8 @@ static void ath11k_wmi_event_scan_started(struct ath11k *ar)
 		break;
 	case ATH11K_SCAN_STARTING:
 		ar->scan.state = ATH11K_SCAN_RUNNING;
+		if (ar->scan.is_roc)
+			ieee80211_ready_on_channel(ar->hw);
 		complete(&ar->scan.started);
 		break;
 	}
@@ -5338,6 +5388,9 @@ static void ath11k_wmi_event_scan_foreign_chan(struct ath11k *ar, u32 freq)
 	case ATH11K_SCAN_RUNNING:
 	case ATH11K_SCAN_ABORTING:
 		ar->scan_channel = ieee80211_get_channel(ar->hw->wiphy, freq);
+
+		if (ar->scan.is_roc && ar->scan.roc_freq == freq)
+			complete(&ar->scan.on_channel);
 		break;
 	}
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 89a743b..b8ad2f4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3104,6 +3104,12 @@ struct wlan_ssid {
 };
 
 #define WMI_IE_BITMAP_SIZE             8
+#define PROBE_REQ_MAX_OUIS	       16
+
+struct wmi_vendor_oui {
+	u32 tlv_header;
+	u32 oui_type_subtype; /* vendor OUI type and subtype */
+};
 
 #define WMI_SCAN_MAX_NUM_SSID                0x0A
 /* prefix used by scan requestor ids on the host */
@@ -3211,7 +3217,7 @@ struct  wmi_start_scan_cmd {
 #define WMI_SCAN_FLAG_HALF_RATE_SUPPORT      0x20000
 #define WMI_SCAN_FLAG_QUARTER_RATE_SUPPORT   0x40000
 #define WMI_SCAN_RANDOM_SEQ_NO_IN_PROBE_REQ 0x80000
-#define WMI_SCAN_ENABLE_IE_WHTELIST_IN_PROBE_REQ 0x100000
+#define WMI_SCAN_ENABLE_IE_LIST_IN_PROBE_REQ 0x100000
 
 #define WMI_SCAN_DWELL_MODE_MASK 0x00E00000
 #define WMI_SCAN_DWELL_MODE_SHIFT        21
@@ -3238,6 +3244,17 @@ struct hint_bssid {
 	struct wmi_mac_addr bssid;
 };
 
+struct wmi_chan_info {
+	u32 freq;
+	u32 phymode;
+};
+
+struct wmi_probe_req_ie_list {
+	u32 ie_bitmap[WMI_IE_BITMAP_SIZE];
+	u32 num_vendor_oui;
+	u32 voui[PROBE_REQ_MAX_OUIS];
+};
+
 struct scan_req_params {
 	u32 scan_id;
 	u32 scan_req_id;
@@ -3296,11 +3313,11 @@ struct scan_req_params {
 			    scan_f_add_ds_ie_in_probe:1,
 			    scan_f_add_spoofed_mac_in_probe:1,
 			    scan_f_add_rand_seq_in_probe:1,
-			    scan_f_en_ie_whitelist_in_probe:1,
+			    scan_f_en_ie_list_in_probe:1,
 			    scan_f_forced:1,
 			    scan_f_2ghz:1,
 			    scan_f_5ghz:1,
-			    scan_f_80mhz:1;
+			    scan_f_wide_band:1;
 		};
 		u32 scan_flags;
 	};
@@ -3325,6 +3342,7 @@ struct scan_req_params {
 	struct wmi_mac_addr mac_mask;
 	u32 phymode;
 	struct cfg80211_chan_def *chandef;
+	struct wmi_probe_req_ie_list ie_list;
 };
 
 struct wmi_ssid_arg {
-- 
2.7.4

