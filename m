Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75BD437741
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhJVMmF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 08:42:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52910 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232381AbhJVMmE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 08:42:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634906387; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=h2Gj8VlTkSADoYxgT4CXaGFGNlAPY0J4Tl+uiwCr9r4=; b=lzUFEBS+tDy/vIGgSP1dBINR7a+lt0W1/3w1P26OZ9EE5Rxp53mkG/4hlPoXC6z+qLiSbPWn
 DVePw5xRFQn5u4MTV5+mJCb4tefRS0K9QjIBY7Ae2q2gaVrEjFAulwpzuPfBK3HOBy1J1xHF
 ZiFj7h+1/094WvUDvnsGBHv7Ly8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6172b102b03398c06c35906b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 Oct 2021 12:39:30
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67231C43616; Fri, 22 Oct 2021 12:39:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97787C43617;
        Fri, 22 Oct 2021 12:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 97787C43617
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     ath11k@lists.infradead.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Sathishkumar Muruganandam <murugana@codeaurora.org>,
        Karthikeyan Kathirvel <kathirve@codeaurora.org>
Subject: [PATCH v3 2/3] ath11k: Add ROC support for wide band scan
Date:   Fri, 22 Oct 2021 18:07:07 +0530
Message-Id: <1634906227-22028-4-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
References: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
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

Co-developed-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Co-developed-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
Signed-off-by: Karthikeyan Kathirvel <kathirve@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 201 +++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c  |  59 +++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  |  27 ++++-
 4 files changed, 263 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b0d6922..b49b223 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1033,6 +1033,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		complete(&ar->vdev_delete_done);
 		complete(&ar->bss_survey_done);
 		complete(&ar->thermal.wmi_sync);
+		complete(&ar->scan.on_channel);
 
 		wake_up(&ar->dp.tx_empty_waitq);
 		idr_for_each(&ar->txmgmt_idr,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index fc2edef..3d197d8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3204,7 +3204,7 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct cfg80211_scan_request *req = &hw_req->req;
-	struct scan_req_params arg;
+	struct scan_req_params *arg = NULL;
 	int ret = 0;
 	int i;
 
@@ -3231,35 +3231,44 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;
 
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
-		arg.extraie.len = req->ie_len;
-		arg.extraie.ptr = kzalloc(req->ie_len, GFP_KERNEL);
-		memcpy(arg.extraie.ptr, req->ie, req->ie_len);
+		arg->extraie.ptr = kzalloc(req->ie_len, GFP_KERNEL);
+		if (!arg->extraie.ptr) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+		arg->extraie.len = req->ie_len;
+		memcpy(arg->extraie.ptr, req->ie, req->ie_len);
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
-		for (i = 0; i < arg.num_chan; i++)
-			arg.chan_list[i] = req->channels[i]->center_freq;
+		arg->chan_list.num_chan = req->n_channels;
+		for (i = 0; i < arg->chan_list.num_chan; i++)
+			arg->chan_list.chan[i].freq = req->channels[i]->center_freq;
 	}
 
-	ret = ath11k_start_scan(ar, &arg);
+	ret = ath11k_start_scan(ar, arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
 		spin_lock_bh(&ar->data_lock);
@@ -3269,12 +3278,14 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	/* Add a 200ms margin to account for event/command processing */
 	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
-				     msecs_to_jiffies(arg.max_scan_time +
+				     msecs_to_jiffies(arg->max_scan_time +
 						      ATH11K_MAC_SCAN_TIMEOUT_MSECS));
 
 exit:
-	if (req->ie_len)
-		kfree(arg.extraie.ptr);
+	if (arg) {
+		kfree(arg->extraie.ptr);
+		kfree(arg);
+	}
 
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
@@ -4059,6 +4070,153 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	return ret;
 }
 
+static void ath11k_mac_update_roc_params(struct cfg80211_chan_def *chandef,
+					 struct scan_req_params *arg)
+{
+	enum nl80211_band band;
+	enum nl80211_chan_width width;
+
+	band = chandef->chan->band;
+	width = chandef->width;
+	arg->freq = chandef->chan->center_freq;
+	arg->num_chan = 1;
+	arg->phymode = ath11k_phymodes[band][width];
+}
+
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
+	ath11k_mac_update_roc_params(chandef, arg);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "ath11k ROC arg freq %d phymode %d\n",
+		   arg->freq, arg->phymode);
+
+	if (arg->phymode) {
+		arg->scan_f_wide_band = true;
+		arg->scan_f_passive = true;
+		arg->chandef = chandef;
+		ret = ath11k_wmi_update_scan_chan_list(ar, arg);
+		if (ret)
+			goto exit;
+	}
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
@@ -7317,6 +7475,8 @@ static const struct ieee80211_ops ath11k_ops = {
 	.sta_set_txpwr			= ath11k_mac_op_sta_set_txpwr,
 	.sta_rc_update			= ath11k_mac_op_sta_rc_update,
 	.conf_tx                        = ath11k_mac_op_conf_tx,
+	.remain_on_channel              = ath11k_mac_op_remain_on_channel,
+	.cancel_remain_on_channel       = ath11k_mac_op_cancel_remain_on_channel,
 	.set_antenna			= ath11k_mac_op_set_antenna,
 	.get_antenna			= ath11k_mac_op_get_antenna,
 	.ampdu_action			= ath11k_mac_op_ampdu_action,
@@ -7868,6 +8028,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->scan.started);
 		init_completion(&ar->scan.completed);
 		init_completion(&ar->thermal.wmi_sync);
+		init_completion(&ar->scan.on_channel);
 
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
 		INIT_WORK(&ar->regd_update_work, ath11k_regd_update_work);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2fe32cb..c428a025 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2170,9 +2170,11 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	void *ptr;
 	int i, ret, len;
 	u32 *tmp_ptr;
+	u8 *phy_ptr;
 	u8 extraie_len_with_pad = 0;
 	struct hint_short_ssid *s_ssid = NULL;
 	struct hint_bssid *hint_bssid = NULL;
+	u8 phymode_roundup = 0;
 
 	len = sizeof(*cmd);
 
@@ -2202,6 +2204,18 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 		len += TLV_HDR_SIZE +
 		       params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
 
+	len += TLV_HDR_SIZE;
+	if (params->scan_f_en_ie_whitelist_in_probe)
+		len += params->ie_whitelist.num_vendor_oui *
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
@@ -2233,11 +2247,12 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	cmd->max_scan_time = params->max_scan_time;
 	cmd->probe_delay = params->probe_delay;
 	cmd->burst_duration = params->burst_duration;
-	cmd->num_chan = params->num_chan;
+	cmd->num_chan = params->chan_list.num_chan;
 	cmd->num_bssid = params->num_bssid;
 	cmd->num_ssids = params->num_ssids;
 	cmd->ie_len = params->extraie.len;
 	cmd->n_probes = params->n_probes;
+	cmd->num_vendor_oui = params->ie_whitelist.num_vendor_oui;
 
 	ptr += sizeof(*cmd);
 
@@ -2249,8 +2264,8 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	ptr += TLV_HDR_SIZE;
 	tmp_ptr = (u32 *)ptr;
 
-	for (i = 0; i < params->num_chan; ++i)
-		tmp_ptr[i] = params->chan_list[i];
+	for (i = 0; i < params->chan_list.num_chan; ++i)
+		tmp_ptr[i] = params->chan_list.chan[i].freq;
 
 	ptr += len;
 
@@ -2331,8 +2346,41 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 					&hint_bssid->bssid.addr[0]);
 			hint_bssid++;
 		}
+		ptr += len;
+	}
+
+	len = params->ie_whitelist.num_vendor_oui *
+	      sizeof(struct wmi_vendor_oui);
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+				 FIELD_PREP(WMI_TLV_LEN, len);
+	ptr += TLV_HDR_SIZE;
+
+	if (params->scan_f_en_ie_whitelist_in_probe) {
+		/* TODO: fill vendor OUIs for probe req ie whitelisting
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
@@ -4956,6 +5004,8 @@ static void ath11k_wmi_event_scan_started(struct ath11k *ar)
 		break;
 	case ATH11K_SCAN_STARTING:
 		ar->scan.state = ATH11K_SCAN_RUNNING;
+		if (ar->scan.is_roc)
+			ieee80211_ready_on_channel(ar->hw);
 		complete(&ar->scan.started);
 		break;
 	}
@@ -5038,6 +5088,9 @@ static void ath11k_wmi_event_scan_foreign_chan(struct ath11k *ar, u32 freq)
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
index aeec4e9..c3aa2fe 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3094,6 +3094,12 @@ struct wlan_ssid {
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
@@ -3228,6 +3234,22 @@ struct hint_bssid {
 	struct wmi_mac_addr bssid;
 };
 
+struct wmi_chan_info {
+	u32 freq;
+	u32 phymode;
+};
+
+struct wmi_chan_list {
+	u32 num_chan;
+	struct wmi_chan_info chan[WLAN_SCAN_MAX_NUM_CHANNELS];
+};
+
+struct wmi_probe_req_whitelist {
+	u32 ie_bitmap[WMI_IE_BITMAP_SIZE];
+	u32 num_vendor_oui;
+	u32 voui[PROBE_REQ_MAX_OUIS];
+};
+
 struct scan_req_params {
 	u32 scan_id;
 	u32 scan_req_id;
@@ -3290,7 +3312,7 @@ struct scan_req_params {
 			    scan_f_forced:1,
 			    scan_f_2ghz:1,
 			    scan_f_5ghz:1,
-			    scan_f_80mhz:1;
+			    scan_f_wide_band:1;
 		};
 		u32 scan_flags;
 	};
@@ -3300,7 +3322,7 @@ struct scan_req_params {
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 chan_list[WLAN_SCAN_MAX_NUM_CHANNELS];
+	struct wmi_chan_list chan_list;
 	u32 notify_scan_events;
 	struct wlan_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
 	struct wmi_mac_addr bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
@@ -3314,6 +3336,7 @@ struct scan_req_params {
 	u32 phymode;
 	u32 freq;
 	struct cfg80211_chan_def *chandef;
+	struct wmi_probe_req_whitelist ie_whitelist;
 };
 
 struct wmi_ssid_arg {
-- 
2.7.4

