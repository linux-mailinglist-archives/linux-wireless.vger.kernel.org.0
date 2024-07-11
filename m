Return-Path: <linux-wireless+bounces-10180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D469B92DEF7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 05:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0499E1C21366
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387A208A1;
	Thu, 11 Jul 2024 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KU5E6Vcy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31546525
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669969; cv=none; b=Ve6/J0T1fgBE4Arn/RGrGIafO96Xl6+W8Hijox6OJa4YlKSPRlhXAdBBZ0mZagDUBHCbFC7v7vppXD25HPH2V+C/I+oC6lrBN0e1Uvm9hViVXaD/460gVBSsHLSVPzFK5SDZ9d5AHTeDMU8G8/T0eI+YE9HRl0sLPco3ZgGDv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669969; c=relaxed/simple;
	bh=y4b/ySGOFH33jNEC3E7u2GJhv+ViuX3/mhcT093Lhr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfuRHGKV87GasVPbmeHvNNC2iAzajQGuO5Iotbfobdts1lYWYgFEbK1g4cEBt3gyrk2LT9s2089Me9rrRteUmZ2BV25Lb78Qb3Kpsoa6/RBko9R/isQxmFBxKZCpZjXQt6wDjBnol7TPrTf37Qk/F8JHxpvjmYSM/gH1vj7BAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KU5E6Vcy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B33Sfx004533;
	Thu, 11 Jul 2024 03:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6AuYOVti//bhcZDhyIofJ3VHcpuORkchFSCLu0bbkX0=; b=KU5E6Vcyj85clz4J
	eBM2sjsXbZ2RQOV83KIbA/6+im7yMaPhW3ietUfVkpGPqwMx6EbYrp6IqAhvJ53K
	mpFTatdL4OKpAVFtX6rgwb964f52XsmEAt+M0bN1luYzAlIb+7ac9dXDC3L6p8vu
	TBDvYoga3nkQ8rQGy1LYahSXMHzjvUEfgw0hSLdFuCK0ehnOJsVmyvpp8ium+HQz
	UPKlUVDOf+ughHK1+tWGRveoIiein8m0WMVYVhHMZMd5KryL6sfg9cQktnqJRCuX
	E4dPg7tmS2bXfFxwk5XiBKrZMI0D7fAnbrH3inIh4EcMf7B1vuhxNzHVBVm2bOu7
	/egfXQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3hjr62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 03:52:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B3qPgs002580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 03:52:25 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 20:52:23 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v3 8/8] wifi: mac80211: handle ieee80211_radar_detected() for MLO
Date: Thu, 11 Jul 2024 09:21:47 +0530
Message-ID: <20240711035147.1896538-9-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711035147.1896538-1-quic_adisi@quicinc.com>
References: <20240711035147.1896538-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KeYHbwIGLJ_SWFFEbZWuBRqKutjW5eZf
X-Proofpoint-GUID: KeYHbwIGLJ_SWFFEbZWuBRqKutjW5eZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_20,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110024

Currently DFS works under assumption there could be only one channel
context in the hardware. Hence, drivers just calls the function
ieee80211_radar_detected() passing the hardware structure. However, with
MLO, this obviously will not work since number of channel contexts will be
more than one and hence drivers would need to pass the channel information
as well on which the radar is detected.

Hence, in order to support DFS with MLO, do the following changes -
  * Add channel context conf pointer as an argument to the function
    ieee80211_radar_detected(). During MLO, drivers would have to pass on
    which channel context conf radar is detected. Otherwise, drivers could
    just pass NULL.
  * ieee80211_radar_detected() will iterate over all channel contexts
    present and
  	* if channel context conf is passed, only mark that as radar
  	  detected
  	* if NULL is passed, then mark all channel contexts as radar
  	  detected
  	* Then as usual, schedule the radar detected work.
  * In the worker, go over all the contexts again and for all such context
    which is marked with radar detected, add it to a local linked list.
  * Cancel the ongoing CAC.
  * If number of contexts found marked with radar is more than one and if
    the wiphy does not support MLO flag, throw a warning and return.
  * Process the local linked list and call the radar event for each entry.

This would also help in scenarios where there is split phy 5 GHz radio,
which is capable of DFS channels in both lower and upper band. In this
case, simultaneous radars can be detected.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/debug.c       |  4 +-
 drivers/net/wireless/ath/ath10k/mac.c         |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c         |  2 +-
 drivers/net/wireless/ath/ath9k/dfs.c          |  2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 drivers/net/wireless/ti/wl18xx/event.c        |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/mac80211.h                        |  7 +-
 net/mac80211/chan.c                           |  1 +
 net/mac80211/ieee80211_i.h                    |  5 ++
 net/mac80211/util.c                           | 71 ++++++++++++++++---
 17 files changed, 89 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index b93a64bf8190..35bfe7232e95 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1774,7 +1774,7 @@ static ssize_t ath10k_write_simulate_radar(struct file *file,
 	if (!arvif->is_started)
 		return -EINVAL;
 
-	ieee80211_radar_detected(ar->hw);
+	ieee80211_radar_detected(ar->hw, NULL);
 
 	return count;
 }
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a5da32e87106..646e1737d4c4 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -1437,7 +1437,7 @@ static void ath10k_recalc_radar_detection(struct ath10k *ar)
 		 * by indicating that radar was detected.
 		 */
 		ath10k_warn(ar, "failed to start CAC: %d\n", ret);
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ar->hw, NULL);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index fe2344598364..4861179b2217 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3990,7 +3990,7 @@ static void ath10k_radar_detected(struct ath10k *ar)
 	if (ar->dfs_block_radar_events)
 		ath10k_info(ar, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ar->hw, NULL);
 }
 
 static void ath10k_radar_confirmation_work(struct work_struct *work)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 38f175dd1557..8839825c22fa 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8356,7 +8356,7 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 	if (ar->dfs_block_radar_events)
 		ath11k_info(ab, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ar->hw, NULL);
 
 exit:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9f6be557365e..350a87aa93ec 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6788,7 +6788,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 	if (ar->dfs_block_radar_events)
 		ath12k_info(ab, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ath12k_ar_to_hw(ar));
+		ieee80211_radar_detected(ath12k_ar_to_hw(ar), NULL);
 
 exit:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 11349218bc21..3689e12db9f7 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -280,7 +280,7 @@ ath9k_dfs_process_radar_pulse(struct ath_softc *sc, struct pulse_event *pe)
 	if (!pd->add_pulse(pd, pe, NULL))
 		return;
 	DFS_STAT_INC(sc, radar_detected);
-	ieee80211_radar_detected(sc->hw);
+	ieee80211_radar_detected(sc->hw, NULL);
 }
 
 /*
diff --git a/drivers/net/wireless/ath/ath9k/dfs_debug.c b/drivers/net/wireless/ath/ath9k/dfs_debug.c
index 8e18e9b4ef48..426caa057396 100644
--- a/drivers/net/wireless/ath/ath9k/dfs_debug.c
+++ b/drivers/net/wireless/ath/ath9k/dfs_debug.c
@@ -116,7 +116,7 @@ static ssize_t write_file_simulate_radar(struct file *file,
 {
 	struct ath_softc *sc = file->private_data;
 
-	ieee80211_radar_detected(sc->hw);
+	ieee80211_radar_detected(sc->hw, NULL);
 
 	return count;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index d50d967828be..53c8ebe179dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -394,7 +394,7 @@ mt7615_mcu_rx_radar_detected(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (mt76_phy_dfs_state(mphy) < MT_DFS_STATE_CAC)
 		return;
 
-	ieee80211_radar_detected(mphy->hw);
+	ieee80211_radar_detected(mphy->hw, NULL);
 	dev->hw_pattern++;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index 024a5c0a5a57..7a07636d09c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -630,7 +630,7 @@ static void mt76x02_dfs_tasklet(struct tasklet_struct *t)
 		radar_detected = mt76x02_dfs_check_detection(dev);
 		if (radar_detected) {
 			/* sw detector rx radar pattern */
-			ieee80211_radar_detected(dev->mt76.hw);
+			ieee80211_radar_detected(dev->mt76.hw, NULL);
 			mt76x02_dfs_detector_reset(dev);
 
 			return;
@@ -658,7 +658,7 @@ static void mt76x02_dfs_tasklet(struct tasklet_struct *t)
 
 		/* hw detector rx radar pattern */
 		dfs_pd->stats[i].hw_pattern++;
-		ieee80211_radar_detected(dev->mt76.hw);
+		ieee80211_radar_detected(dev->mt76.hw, NULL);
 		mt76x02_dfs_detector_reset(dev);
 
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2185cd24e2e1..5f180851060d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -293,7 +293,7 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 						&dev->rdd2_chandef,
 						GFP_ATOMIC);
 	else
-		ieee80211_radar_detected(mphy->hw);
+		ieee80211_radar_detected(mphy->hw, NULL);
 	dev->hw_pattern++;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2e4fa9f48dfb..f8921546a5e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -371,7 +371,7 @@ mt7996_mcu_rx_radar_detected(struct mt7996_dev *dev, struct sk_buff *skb)
 						&dev->rdd2_chandef,
 						GFP_ATOMIC);
 	else
-		ieee80211_radar_detected(mphy->hw);
+		ieee80211_radar_detected(mphy->hw, NULL);
 	dev->hw_pattern++;
 }
 
diff --git a/drivers/net/wireless/ti/wl18xx/event.c b/drivers/net/wireless/ti/wl18xx/event.c
index 34d95f458e1a..a9f090e15cbb 100644
--- a/drivers/net/wireless/ti/wl18xx/event.c
+++ b/drivers/net/wireless/ti/wl18xx/event.c
@@ -142,7 +142,7 @@ int wl18xx_process_mailbox_events(struct wl1271 *wl)
 			    wl18xx_radar_type_decode(mbox->radar_type));
 
 		if (!wl->radar_debug_mode)
-			ieee80211_radar_detected(wl->hw);
+			ieee80211_radar_detected(wl->hw, NULL);
 	}
 
 	if (vector & PERIODIC_SCAN_REPORT_EVENT_ID) {
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 714e1f04b0cb..d08fff9d26cf 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1146,7 +1146,7 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 {
 	struct mac80211_hwsim_data *data = dat;
 
-	ieee80211_radar_detected(data->hw);
+	ieee80211_radar_detected(data->hw, NULL);
 
 	return 0;
 }
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e78ccbe38d6d..a4f2fcf35ce1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -257,6 +257,7 @@ struct ieee80211_chan_req {
  *	after RTS/CTS handshake to receive SMPS MIMO transmissions;
  *	this will always be >= @rx_chains_static.
  * @radar_enabled: whether radar detection is enabled on this channel.
+ * @radar_detected: whether radar got detected on this channel.
  * @drv_priv: data area for driver use, will always be aligned to
  *	sizeof(void *), size is determined in hw information.
  */
@@ -269,6 +270,7 @@ struct ieee80211_chanctx_conf {
 	u8 rx_chains_static, rx_chains_dynamic;
 
 	bool radar_enabled;
+	bool radar_detected;
 
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
@@ -6716,8 +6718,11 @@ void ieee80211_cqm_beacon_loss_notify(struct ieee80211_vif *vif, gfp_t gfp);
  * ieee80211_radar_detected - inform that a radar was detected
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @chanctx_conf: Channel context on which radar is detected. Mandatory to
+ *	pass a valid pointer during MLO. For non-MLO %NULL can be passed
  */
-void ieee80211_radar_detected(struct ieee80211_hw *hw);
+void ieee80211_radar_detected(struct ieee80211_hw *hw,
+			      struct ieee80211_chanctx_conf *chanctx_conf);
 
 /**
  * ieee80211_chswitch_done - Complete channel switch process
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e8567723e94d..60417357dc91 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -681,6 +681,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
 	ctx->conf.radio_idx = radio_idx;
+	ctx->conf.radar_detected = false;
 	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
 
 	return ctx;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a2d7c7ee7ce3..7323f81e3d3c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1329,6 +1329,11 @@ enum mac80211_scan_state {
 
 DECLARE_STATIC_KEY_FALSE(aql_disable);
 
+struct radar_info {
+	struct list_head list;
+	struct cfg80211_chan_def chandef;
+};
+
 struct ieee80211_local {
 	/* embed the driver visible part.
 	 * don't cast (use the static inlines below), but we keep
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 59dde0393f81..ecda005edcd2 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3495,35 +3495,88 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, radar_detected_work);
-	struct cfg80211_chan_def chandef = local->hw.conf.chandef;
+	struct radar_info *radar_info, *temp;
+	struct list_head radar_info_list;
 	struct ieee80211_chanctx *ctx;
+	bool trigger_event = true;
 	int num_chanctx = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	INIT_LIST_HEAD(&radar_info_list);
+
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		num_chanctx++;
-		chandef = ctx->conf.def;
+		if (ctx->conf.radar_detected) {
+			ctx->conf.radar_detected = false;
+			num_chanctx++;
+
+			radar_info = kzalloc(sizeof(*radar_info), GFP_KERNEL);
+			if (WARN_ON(!radar_info))
+				continue;
+
+			INIT_LIST_HEAD(&radar_info->list);
+			radar_info->chandef = ctx->conf.def;
+			list_add_tail(&radar_info->list, &radar_info_list);
+		}
 	}
 
 	ieee80211_dfs_cac_cancel(local);
 
-	if (num_chanctx > 1)
-		/* XXX: multi-channel is not supported yet */
-		WARN_ON(1);
-	else
-		cfg80211_radar_event(local->hw.wiphy, &chandef, GFP_KERNEL);
+	if (num_chanctx > 1) {
+		/* XXX: multi-channel is not supported yet in case of non-MLO */
+		if (WARN_ON(!(wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)))
+			trigger_event = false;
+	}
+
+	/* this will clear the nodes which were created and added above.
+	 * trigger_event decides whether to trigger the radar event or not
+	 */
+	list_for_each_entry_safe(radar_info, temp, &radar_info_list,
+				 list) {
+		if (trigger_event)
+			cfg80211_radar_event(local->hw.wiphy,
+					     &radar_info->chandef,
+					     GFP_KERNEL);
+		kfree(radar_info);
+	}
 }
 
-void ieee80211_radar_detected(struct ieee80211_hw *hw)
+static void
+ieee80211_radar_mark_chan_ctx_iterator(struct ieee80211_hw *hw,
+				       struct ieee80211_chanctx_conf *chanctx_conf,
+				       void *data)
+{
+	struct ieee80211_chanctx *ctx =
+		container_of(chanctx_conf, struct ieee80211_chanctx,
+			     conf);
+	struct ieee80211_chanctx_conf *itr_data =
+		(struct ieee80211_chanctx_conf *)data;
+
+	if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
+		return;
+
+	if (itr_data) {
+		if (itr_data == chanctx_conf)
+			chanctx_conf->radar_detected = true;
+		return;
+	}
+
+	chanctx_conf->radar_detected = true;
+}
+
+void ieee80211_radar_detected(struct ieee80211_hw *hw,
+			      struct ieee80211_chanctx_conf *chanctx_conf)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	trace_api_radar_detected(local);
 
+	ieee80211_iter_chan_contexts_atomic(hw, ieee80211_radar_mark_chan_ctx_iterator,
+					    chanctx_conf);
+
 	wiphy_work_queue(hw->wiphy, &local->radar_detected_work);
 }
 EXPORT_SYMBOL(ieee80211_radar_detected);
-- 
2.34.1


