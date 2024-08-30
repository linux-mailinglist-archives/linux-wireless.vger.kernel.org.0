Return-Path: <linux-wireless+bounces-12237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8DE96575B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 08:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A1DB22F49
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EDC145FE5;
	Fri, 30 Aug 2024 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ipLM3QK8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A8150989
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998196; cv=none; b=WES7gz9dIDZyvy7OGgAithdcz6BEvMRTyqa3EmP5dioBtQaNFK2hWoPUQBUl9qrm8YY/eEsxeUVT/gXHKqOkaoGan1xnms35ASM4YwwrFDfCl9eNKUjno7QexBIvMHuqpNeVio0F1Gkodumtiw5N7e6wWUyiKMWlhkIydjapX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998196; c=relaxed/simple;
	bh=bQhYe+hbWEkQSoo2Le2R3yNceNS/tDb8NDhkdE7+slM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CazgS/J4/7pqm6Ne9IHbuqh/Ey/8KJrSlLlMPzqYfVwsHuN2buu1ZLlzRbQZeg7K7PY3MukytHbdVTSrTxZ0ED7Da2nRdAGg9Qi23rraUtHgVnT8vrwMojZwoHA2lSbL/A73O3K542htah0yAidAiF5gAMREXKGjewtZTHK1WBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ipLM3QK8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGJh6T011674;
	Fri, 30 Aug 2024 06:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CNRyWc7Gu+aKw8DtiC+SP5aPneRFjH7g9C+Hhp3NV1s=; b=ipLM3QK8p7HxFOSX
	WIaHMlteB3hPjIa3g2Erf53bimSfvKWnDS6V84t99TFqoVO9y+y3/cCGQS0N2Oyp
	HcdYGMt1pCrcUdBlyCAN+swoH0+HhkFT0agP6+e9lEjCxtmTr584zJFnEoch9sdR
	1SUm+6zXcy5v5kmr2fkhzTInF0KmLkZcmjcmd5DAyw7zuB2Rn/vhOwK1whfsqbQ+
	tR29wtQIdMArrBsys2TwxXc09Fb26npxWEgdhH3RuOqW4qveAIXn+sk5WiOIxjCF
	8urzPXX9iO2Ta/96ZOl7VvXHD+81bj+IUaJeVp0f1EBwVVDNuk2cRtgw77Lym0jq
	SoZo5g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0qq1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U69npL029930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 06:09:49 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 23:09:47 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v4 8/8] wifi: mac80211: handle ieee80211_radar_detected() for MLO
Date: Fri, 30 Aug 2024 11:39:18 +0530
Message-ID: <20240830060918.2418701-9-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830060918.2418701-1-quic_adisi@quicinc.com>
References: <20240830060918.2418701-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: aXxNHsKK2amakjOreeYEak5nCpK8IVw5
X-Proofpoint-ORIG-GUID: aXxNHsKK2amakjOreeYEak5nCpK8IVw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300043

Currently DFS works under assumption there could be only one channel
context in the hardware. Hence, drivers just calls the function
ieee80211_radar_detected() passing the hardware structure. However, with
MLO, this obviously will not work since number of channel contexts will be
more than one and hence drivers would need to pass the channel information
as well on which the radar is detected.

Also, when radar is detected in one of the links, other link's CAC should
not be cancelled.

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
    which is marked with radar detected, cancel the ongoing CAC by calling
    ieee80211_dfs_cac_cancel() and then notify cfg80211 via
    cfg80211_radar_event().
  * To cancel the CAC, pass the channel context as well where radar is
    detected to ieee80211_dfs_cac_cancel(). This ensures that CAC is
    canceled only on the links using the provided context, leaving other
    links unaffected.

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
 include/net/mac80211.h                        |  5 +-
 net/mac80211/chan.c                           |  1 +
 net/mac80211/ieee80211_i.h                    |  5 +-
 net/mac80211/pm.c                             |  2 +-
 net/mac80211/util.c                           | 67 ++++++++++++++-----
 18 files changed, 75 insertions(+), 35 deletions(-)

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
index 2662092ee00a..87abfa547529 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8358,7 +8358,7 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 	if (ar->dfs_block_radar_events)
 		ath11k_info(ab, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ar->hw, NULL);
 
 exit:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a76413320dbf..2cd3ff9b0164 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6789,7 +6789,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
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
index 5fe9e4e26142..f0e528abb1b4 100644
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
index adfec877f392..954dff901b69 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6748,8 +6748,11 @@ void ieee80211_cqm_beacon_loss_notify(struct ieee80211_vif *vif, gfp_t gfp);
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
index b72e4036526b..cca6d14084d2 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -683,6 +683,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
 	ctx->conf.radio_idx = radio_idx;
+	ctx->radar_detected = false;
 	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
 
 	return ctx;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9c2c826ef90c..4f0390918b60 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -893,6 +893,8 @@ struct ieee80211_chanctx {
 	struct ieee80211_chan_req req;
 
 	struct ieee80211_chanctx_conf conf;
+
+	bool radar_detected;
 };
 
 struct mac80211_qos_map {
@@ -2649,7 +2651,8 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
 void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work);
-void ieee80211_dfs_cac_cancel(struct ieee80211_local *local);
+void ieee80211_dfs_cac_cancel(struct ieee80211_local *local,
+			      struct ieee80211_chanctx *chanctx);
 void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 				       struct wiphy_work *work);
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index d823d58303e8..7be52345f218 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -32,7 +32,7 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 
 	ieee80211_scan_cancel(local);
 
-	ieee80211_dfs_cac_cancel(local);
+	ieee80211_dfs_cac_cancel(local, NULL);
 
 	ieee80211_roc_purge(local, NULL);
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d29ea35d8142..f604bddd6204 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3467,12 +3467,17 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 	return ts;
 }
 
-void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
+/* Cancel CAC for the interfaces under the specified @local. If @ctx is
+ * also provided, only the interfaces using that ctx will be canceled.
+ */
+void ieee80211_dfs_cac_cancel(struct ieee80211_local *local,
+			      struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_link_data *link_data;
 	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	unsigned int link_id;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3482,7 +3487,18 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 		     link_id++) {
 			link_data = sdata_dereference(sdata->link[link_id],
 						      sdata);
-			if (!link_data)
+			link_conf =
+				rcu_dereference(sdata->vif.link_conf[link_id]);
+			if (!link_data || !link_conf)
+				continue;
+
+			chanctx_conf =
+				rcu_dereference_protected(link_conf->chanctx_conf,
+					  lockdep_is_held(&local->hw.wiphy->mtx));
+			if (!chanctx_conf)
+				continue;
+
+			if (ctx && &ctx->conf != link_conf->chanctx_conf)
 				continue;
 
 			wiphy_delayed_work_cancel(local->hw.wiphy,
@@ -3491,11 +3507,6 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 			if (!sdata->wdev.links[link_id].cac_started)
 				continue;
 
-			link_conf =
-				rcu_dereference(sdata->vif.link_conf[link_id]);
-			if (!link_conf)
-				continue;
-
 			chandef = link_conf->chanreq.oper;
 			ieee80211_link_release_channel(link_data);
 			cfg80211_cac_event(sdata->dev,
@@ -3511,9 +3522,8 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, radar_detected_work);
-	struct cfg80211_chan_def chandef = local->hw.conf.chandef;
+	struct cfg80211_chan_def chandef;
 	struct ieee80211_chanctx *ctx;
-	int num_chanctx = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -3521,25 +3531,48 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
 			continue;
 
-		num_chanctx++;
+		if (!ctx->radar_detected)
+			continue;
+
+		ctx->radar_detected = false;
+
 		chandef = ctx->conf.def;
+
+		ieee80211_dfs_cac_cancel(local, ctx);
+		cfg80211_radar_event(local->hw.wiphy, &chandef, GFP_KERNEL);
 	}
+}
 
-	ieee80211_dfs_cac_cancel(local);
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
 
-	if (num_chanctx > 1)
-		/* XXX: multi-channel is not supported yet */
-		WARN_ON(1);
-	else
-		cfg80211_radar_event(local->hw.wiphy, &chandef, GFP_KERNEL);
+	if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
+		return;
+
+	if (itr_data && itr_data != chanctx_conf)
+		return;
+
+	ctx->radar_detected = true;
 }
 
-void ieee80211_radar_detected(struct ieee80211_hw *hw)
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


