Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6851B552
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 03:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiEEBmq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 21:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiEEBmp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 21:42:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8A24A3D2
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 18:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651714747; x=1683250747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iky0TfHcm09L5bEkgcC6U4Gg3Ou5TlKMGqreqQj4/to=;
  b=mAA1JL1d4/BafI4txmZ2Bfqrpx4eV82bXbk8sU6c0l7Y/A+c5gZDjvj6
   Mu8CQ6fPfZtdGXllmYUE+y+W9zybShDeygUngeQ+xA/KisrbmAjWjWtkh
   SSKEvgncIFUdfGO+ldBAIqZt5XNiBudfEQmRiExVVWP6srt8HASYW+bga
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 May 2022 18:39:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:39:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 18:39:07 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 18:39:06 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] ath11k: Implement remain-on-channel support
Date:   Thu, 5 May 2022 09:38:49 +0800
Message-ID: <20220505013851.1548789-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505013851.1548789-1-quic_bqiang@quicinc.com>
References: <20220505013851.1548789-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add remain on channel support, it is needed in several
scenarios such as Passpoint etc.

Currently this is supported by QCA6390, WCN6855, IPQ8074,
IPQ6018 and QCN9074.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 115 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  |   4 +
 3 files changed, 120 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 01e1d494b527..412bec8f1daf 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1623,6 +1623,7 @@ static void ath11k_core_pre_reconfigure_recovery(struct ath11k_base *ab)
 		complete(&ar->completed_11d_scan);
 		complete(&ar->scan.started);
 		complete(&ar->scan.completed);
+		complete(&ar->scan.on_channel);
 		complete(&ar->peer_assoc_done);
 		complete(&ar->peer_delete_done);
 		complete(&ar->install_key_done);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1957e1713548..6e6b8562b481 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8345,6 +8345,118 @@ static int ath11k_mac_op_set_bios_sar_specs(struct ieee80211_hw *hw,
 	return ret;
 }
 
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
+static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_channel *chan,
+					   int duration,
+					   enum ieee80211_roc_type type)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct scan_req_params arg;
+	int ret;
+	u32 scan_time_msec;
+
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
+	spin_unlock_bh(&ar->data_lock);
+
+	if (ret)
+		goto exit;
+
+	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;
+
+	memset(&arg, 0, sizeof(arg));
+	ath11k_wmi_start_scan_init(ar, &arg);
+	arg.num_chan = 1;
+	arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
+				GFP_KERNEL);
+	if (!arg.chan_list) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	arg.vdev_id = arvif->vdev_id;
+	arg.scan_id = ATH11K_SCAN_ID;
+	arg.chan_list[0] = chan->center_freq;
+	arg.dwell_time_active = scan_time_msec;
+	arg.dwell_time_passive = scan_time_msec;
+	arg.max_scan_time = scan_time_msec;
+	arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
+	arg.scan_flags |= WMI_SCAN_FILTER_PROBE_REQ;
+	arg.burst_duration = duration;
+
+	ret = ath11k_start_scan(ar, &arg);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to start roc scan: %d\n", ret);
+
+		spin_lock_bh(&ar->data_lock);
+		ar->scan.state = ATH11K_SCAN_IDLE;
+		spin_unlock_bh(&ar->data_lock);
+		goto free_chan_list;
+	}
+
+	ret = wait_for_completion_timeout(&ar->scan.on_channel, 3 * HZ);
+	if (ret == 0) {
+		ath11k_warn(ar->ab, "failed to switch to channel for roc scan\n");
+		ret = ath11k_scan_stop(ar);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to stop scan: %d\n", ret);
+		ret = -ETIMEDOUT;
+		goto free_chan_list;
+	}
+
+	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
+				     msecs_to_jiffies(duration));
+
+	ret = 0;
+
+free_chan_list:
+	kfree(arg.chan_list);
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
 	.start                          = ath11k_mac_op_start,
@@ -8397,6 +8509,8 @@ static const struct ieee80211_ops ath11k_ops = {
 #endif
 
 	.set_sar_specs			= ath11k_mac_op_set_bios_sar_specs,
+	.remain_on_channel		= ath11k_mac_op_remain_on_channel,
+	.cancel_remain_on_channel	= ath11k_mac_op_cancel_remain_on_channel,
 };
 
 static void ath11k_mac_update_ch_list(struct ath11k *ar,
@@ -8986,6 +9100,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->bss_survey_done);
 		init_completion(&ar->scan.started);
 		init_completion(&ar->scan.completed);
+		init_completion(&ar->scan.on_channel);
 		init_completion(&ar->thermal.wmi_sync);
 
 		INIT_DELAYED_WORK(&ar->scan.timeout, ath11k_scan_timeout_work);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 1410114d1d5c..e99dede0ab55 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5264,6 +5264,8 @@ static void ath11k_wmi_event_scan_started(struct ath11k *ar)
 		break;
 	case ATH11K_SCAN_STARTING:
 		ar->scan.state = ATH11K_SCAN_RUNNING;
+		if (ar->scan.is_roc)
+			ieee80211_ready_on_channel(ar->hw);
 		complete(&ar->scan.started);
 		break;
 	}
@@ -5346,6 +5348,8 @@ static void ath11k_wmi_event_scan_foreign_chan(struct ath11k *ar, u32 freq)
 	case ATH11K_SCAN_RUNNING:
 	case ATH11K_SCAN_ABORTING:
 		ar->scan_channel = ieee80211_get_channel(ar->hw->wiphy, freq);
+		if (ar->scan.is_roc && ar->scan.roc_freq == freq)
+			complete(&ar->scan.on_channel);
 		break;
 	}
 }
-- 
2.25.1

