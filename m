Return-Path: <linux-wireless+bounces-2654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F833840299
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 11:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F631F22A26
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797356B84;
	Mon, 29 Jan 2024 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="owAtD2hu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2756475
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523323; cv=none; b=IHODPgWE8qKUgz8UaqSgfJ19tb/bahnRkz+0llgWyEGHLU9JG8oTMILVLHcI9kThcGrDX8z2bpf2wX/MDQ/mmn4UrbGtMqFO0m+QVerAribsNyeUGkCO2hQKrFSlMFe8/Ovmsr/XDs7wD5RTQrBq9UtEmal3mImCR7WLua7E8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523323; c=relaxed/simple;
	bh=O9y8e3tTSHJWmcBvSTF4sXZ5OR4shegAEXNEAa2HpVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgBJHsDB8YPvQjDrnYqrjRbwOP37c6X/gjF/VFB8fYoFbrobhjfd3wEOjRglnJuoA4P27t8AJZC8h+FPJihp1bQL02mwjXwrjuSpot5LLITU+GRIjqUpbXBCNQFJXwoBl1tARg4GswhMmkaDkN041cVVCqPBlgBv8MBqizRODzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=owAtD2hu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T7qgGP007561;
	Mon, 29 Jan 2024 10:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=5ZFWy6Ia86sVDo32QBm2sjcSI6D9Q62bvpDG9ZTZiKw=; b=ow
	AtD2hukswcVcTt4eBo4TeN11PHmGWAg5/0W2/ttEPPaq590LTdTFa5HUZKw55JWb
	5pLQGmY2l/6veNveW75C5FZJoOyEF1pIiI7zLECCjekPOUyiwzeffEKKkgGYIyw0
	T2QFMVsdZRmMmVpfIsnMcq7pLRQoJtqYhN9dLm5pwuJ18zcAFSTzB71edbGQcCWi
	G7Q7Q91qeQF8S/oWSyrnbIrbQVNvA6IQYLPPxdQ4mf3Hlazy/QpttosL35xPUV4C
	M2CJm2RmhkMKhPajlmej+XLeY80n3PM6MN42W3CKnRftDXA+Q/dY3tlEHBe7PpXV
	nSoF9OQSAA8lYRDk0JJw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3dtrr3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:15:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TAFI8j020431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:15:18 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 02:15:17 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 04/11] wifi: ath12k: implement remain on channel for P2P mode
Date: Mon, 29 Jan 2024 18:14:46 +0800
Message-ID: <20240129101453.368494-5-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129101453.368494-1-quic_kangyang@quicinc.com>
References: <20240129101453.368494-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tsDgIcfWA51jdYEgSW47Tgk36eXFibZj
X-Proofpoint-ORIG-GUID: tsDgIcfWA51jdYEgSW47Tgk36eXFibZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290073

Implement remain on channel for p2p mode in ath12k_ops:
        ath12k_mac_op_remain_on_channel
        ath12k_mac_op_cancel_remain_on_channel

P2P device can trigger ROC scan. Then keep listening or sending management
frames on particular channels.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v5: no change.
v4: no change.
v3: use ath12k_ah_to_ar() to get ar.
v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright.

---
 drivers/net/wireless/ath/ath12k/core.c |   1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 119 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.c  |   4 +
 3 files changed, 124 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1baad3302157..ffe4fd6e36f5 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -950,6 +950,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		ath12k_mac_drain_tx(ar);
 		complete(&ar->scan.started);
 		complete(&ar->scan.completed);
+		complete(&ar->scan.on_channel);
 		complete(&ar->peer_assoc_done);
 		complete(&ar->peer_delete_done);
 		complete(&ar->install_key_done);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0b8eab9656ed..366bb5e5934b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7391,6 +7391,122 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 }
 
+static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
+						  struct ieee80211_vif *vif)
+{
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+
+	ar = ath12k_ah_to_ar(ah);
+
+	mutex_lock(&ar->conf_mutex);
+
+	spin_lock_bh(&ar->data_lock);
+	ar->scan.roc_notify = false;
+	spin_unlock_bh(&ar->data_lock);
+
+	ath12k_scan_abort(ar);
+
+	mutex_unlock(&ar->conf_mutex);
+
+	cancel_delayed_work_sync(&ar->scan.timeout);
+
+	return 0;
+}
+
+static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_channel *chan,
+					   int duration,
+					   enum ieee80211_roc_type type)
+{
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k *ar;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k_wmi_scan_req_arg arg;
+	int ret;
+	u32 scan_time_msec;
+
+	ar = ath12k_ah_to_ar(ah);
+
+	mutex_lock(&ar->conf_mutex);
+	spin_lock_bh(&ar->data_lock);
+	switch (ar->scan.state) {
+	case ATH12K_SCAN_IDLE:
+		reinit_completion(&ar->scan.started);
+		reinit_completion(&ar->scan.completed);
+		reinit_completion(&ar->scan.on_channel);
+		ar->scan.state = ATH12K_SCAN_STARTING;
+		ar->scan.is_roc = true;
+		ar->scan.vdev_id = arvif->vdev_id;
+		ar->scan.roc_freq = chan->center_freq;
+		ar->scan.roc_notify = true;
+		ret = 0;
+		break;
+	case ATH12K_SCAN_STARTING:
+	case ATH12K_SCAN_RUNNING:
+	case ATH12K_SCAN_ABORTING:
+		ret = -EBUSY;
+		break;
+	}
+	spin_unlock_bh(&ar->data_lock);
+
+	if (ret)
+		goto exit;
+
+	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;
+
+	memset(&arg, 0, sizeof(arg));
+	ath12k_wmi_start_scan_init(ar, &arg);
+	arg.num_chan = 1;
+	arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
+				GFP_KERNEL);
+	if (!arg.chan_list) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	arg.vdev_id = arvif->vdev_id;
+	arg.scan_id = ATH12K_SCAN_ID;
+	arg.chan_list[0] = chan->center_freq;
+	arg.dwell_time_active = scan_time_msec;
+	arg.dwell_time_passive = scan_time_msec;
+	arg.max_scan_time = scan_time_msec;
+	arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
+	arg.burst_duration = duration;
+
+	ret = ath12k_start_scan(ar, &arg);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to start roc scan: %d\n", ret);
+
+		spin_lock_bh(&ar->data_lock);
+		ar->scan.state = ATH12K_SCAN_IDLE;
+		spin_unlock_bh(&ar->data_lock);
+		goto free_chan_list;
+	}
+
+	ret = wait_for_completion_timeout(&ar->scan.on_channel, 3 * HZ);
+	if (ret == 0) {
+		ath12k_warn(ar->ab, "failed to switch to channel for roc scan\n");
+		ret = ath12k_scan_stop(ar);
+		if (ret)
+			ath12k_warn(ar->ab, "failed to stop scan: %d\n", ret);
+		ret = -ETIMEDOUT;
+		goto free_chan_list;
+	}
+
+	ieee80211_queue_delayed_work(hw, &ar->scan.timeout,
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
 static const struct ieee80211_ops ath12k_ops = {
 	.tx				= ath12k_mac_op_tx,
 	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
@@ -7425,6 +7541,8 @@ static const struct ieee80211_ops ath12k_ops = {
 	.get_survey			= ath12k_mac_op_get_survey,
 	.flush				= ath12k_mac_op_flush,
 	.sta_statistics			= ath12k_mac_op_sta_statistics,
+	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
+	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
 };
 
 static void ath12k_mac_update_ch_list(struct ath12k *ar,
@@ -7952,6 +8070,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->bss_survey_done);
 	init_completion(&ar->scan.started);
 	init_completion(&ar->scan.completed);
+	init_completion(&ar->scan.on_channel);
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	INIT_WORK(&ar->regd_update_work, ath12k_regd_update_work);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7b48f8a2e397..c7e732c6c145 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5050,6 +5050,8 @@ static void ath12k_wmi_event_scan_started(struct ath12k *ar)
 		break;
 	case ATH12K_SCAN_STARTING:
 		ar->scan.state = ATH12K_SCAN_RUNNING;
+		if (ar->scan.is_roc)
+			ieee80211_ready_on_channel(ath12k_ar_to_hw(ar));
 		complete(&ar->scan.started);
 		break;
 	}
@@ -5134,6 +5136,8 @@ static void ath12k_wmi_event_scan_foreign_chan(struct ath12k *ar, u32 freq)
 	case ATH12K_SCAN_RUNNING:
 	case ATH12K_SCAN_ABORTING:
 		ar->scan_channel = ieee80211_get_channel(hw->wiphy, freq);
+		if (ar->scan.is_roc && ar->scan.roc_freq == freq)
+			complete(&ar->scan.on_channel);
 		break;
 	}
 }
-- 
2.34.1


