Return-Path: <linux-wireless+bounces-9230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6995190E23B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049BE285A37
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84C4C635;
	Wed, 19 Jun 2024 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fC5Nct+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA6558B6
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770249; cv=none; b=rqYOtaRrqXIpMCrkC6D+ZwX8qjW6a+zJ5DcXS/ZZEN9hqfMcyNy8NAMxedd0NvmI/ehe/Yuk0vOmpc5Km9ec9TX9bXDbECzSXTvQoLGiLIGBxmE9K5//rPA45mFPaf1GeF8F23AQQE5J/XreST7pwaHXUdAk3O6AT4xe4Ima6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770249; c=relaxed/simple;
	bh=KP6PPIsAaBEmLfe4xQN/bfeaVpd1HI3mU8SVMfEst38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNlwwTqiT0/mhGGbK164nO0qtmMYr+79bv1fPo++Mty81SRNt0MKb+RgC/ZWyHYK0SeFR0+jB5fRPGud4Gsv14o0iF6AdQhPL/DaJqO+E1t2dj3SWI0sHM6W8vkJ0Cb2bvsdEzgKihUmzkvtgafSJ043Ly3PjU3vrSuXK4+KePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fC5Nct+1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILaiLL005118;
	Wed, 19 Jun 2024 04:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	frZ2/HaLWjGCDMN8R1S9Zm48D0g+1KZni2EbWMvlJy0=; b=fC5Nct+1hUM6h7dC
	A55j0s4foS1CXUojq5brDVV+Hqpaohph8h4kfqSPOd6VC+0uqIiDzltfdbcfGxbc
	HU5+Upx9aM5fY5rKLflKavtUqkNOMO+SUCtqPKhzW0oqWPk5JuFz42vEcRaRGg3M
	FWsA3PYDFnjwuNOUpfZaP/+F1gnSQ373+ZOM9gCODCvhadmGz2qKXECpx/+ynDkr
	ZvJPwOwuG1cat5533B9DPhGlU07agp7/V+1BK6Tt1xZpNMmEVh8/Mcuz3rovhEWL
	eEeYQ2sU82XeIALWYxLu1EBdJZGqo3wRbENkHNVL1pekvTB2sYwaSSlZlDlCOtcq
	IY+1aw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja78kfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J4AfB6013243
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:41 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 21:10:40 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 8/9] wifi: mac80211: handle ieee80211_radar_detected() for MLO
Date: Wed, 19 Jun 2024 09:39:58 +0530
Message-ID: <20240619040959.1457547-9-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619040959.1457547-1-quic_adisi@quicinc.com>
References: <20240619040959.1457547-1-quic_adisi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -tDBG4elYaxarPvWBjmn_Vscp4EH8Dve
X-Proofpoint-GUID: -tDBG4elYaxarPvWBjmn_Vscp4EH8Dve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190028

Currently DFS works under assumption there could be only one channel
context in the hardware. Hence, drivers just calls the function
ieee80211_radar_detected() passing the hardware structure. However, with
MLO, this obviously will not work since number of channel contexts will be
more than one and hence drivers would need to pass the channel information
as well on which the radar is detected.

Hence, in order to support DFS with MLO, do the following changes -
  * Add channel pointer as an argument to the function
    ieee80211_radar_detected(). During MLO, drivers would have to pass on
    which channel radar is detected.
  * In order to pass on this channel information to the radar detected
    worker later on, introduce a linked list 'radar_info' in the structure
    local.
  * When driver calls radar detected, a node is created and added to this
    list and work is scheduled. The work handler takes care to process each
    node and take further action.
  * This would also help in scenarios where there is split phy 5 GHz radio,
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
 net/mac80211/ieee80211_i.h                    |  6 ++
 net/mac80211/main.c                           |  8 +++
 net/mac80211/util.c                           | 64 ++++++++++++++++---
 17 files changed, 88 insertions(+), 25 deletions(-)

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
index 3bf67b2ecd6d..21109e0842f1 100644
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
index d6e1d1398cdb..013f46ab982a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6785,7 +6785,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
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
index c807bd8d928d..282d9eb336bb 100644
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
index 9599adf104b1..35fdd7df0a1e 100644
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
index 2c8578677800..bae7b2eeb02d 100644
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
index fbf24870209d..f405acdfd4e6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1137,7 +1137,7 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 {
 	struct mac80211_hwsim_data *data = dat;
 
-	ieee80211_radar_detected(data->hw);
+	ieee80211_radar_detected(data->hw, NULL);
 
 	return 0;
 }
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ecfa65ade226..f46f61c8e3db 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6724,8 +6724,11 @@ void ieee80211_cqm_beacon_loss_notify(struct ieee80211_vif *vif, gfp_t gfp);
  * ieee80211_radar_detected - inform that a radar was detected
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @radar_channel: Channel pointer on which radar is detected. Mandatory to
+ *	pass a valid pointer during MLO. For non-MLO %NULL can be passed
  */
-void ieee80211_radar_detected(struct ieee80211_hw *hw);
+void ieee80211_radar_detected(struct ieee80211_hw *hw,
+			      struct ieee80211_channel *radar_channel);
 
 /**
  * ieee80211_chswitch_done - Complete channel switch process
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4af0f9bd434d..0e6a54f03eb7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1329,6 +1329,11 @@ enum mac80211_scan_state {
 
 DECLARE_STATIC_KEY_FALSE(aql_disable);
 
+struct radar_info {
+	struct list_head list;
+	struct ieee80211_channel *channel;
+};
+
 struct ieee80211_local {
 	/* embed the driver visible part.
 	 * don't cast (use the static inlines below), but we keep
@@ -1430,6 +1435,7 @@ struct ieee80211_local {
 	bool wowlan;
 
 	struct wiphy_work radar_detected_work;
+	struct list_head radar_info_list;
 
 	/* number of RX chains the hardware has */
 	u8 rx_chains;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index c8cb091b5ea3..30b383f1e27d 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -943,6 +943,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	INIT_LIST_HEAD(&local->interfaces);
 	INIT_LIST_HEAD(&local->mon_list);
+	INIT_LIST_HEAD(&local->radar_info_list);
 
 	__hw_addr_init(&local->mc_list);
 
@@ -1638,6 +1639,7 @@ EXPORT_SYMBOL(ieee80211_register_hw);
 void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct radar_info *radar_info, *temp;
 
 	tasklet_kill(&local->tx_pending_tasklet);
 	tasklet_kill(&local->tasklet);
@@ -1673,6 +1675,12 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	ieee80211_clear_tx_pending(local);
 	rate_control_deinitialize(local);
 
+	list_for_each_entry_safe(radar_info, temp, &local->radar_info_list,
+				 list) {
+		list_del(&radar_info->list);
+		kfree(radar_info);
+	}
+
 	if (skb_queue_len(&local->skb_queue) ||
 	    skb_queue_len(&local->skb_queue_unreliable))
 		wiphy_warn(local->hw.wiphy, "skb_queue not empty\n");
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 3d34e07f441b..a39845465d2b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3488,12 +3488,12 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 	}
 }
 
-void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
-				       struct wiphy_work *work)
+static void
+ieee80211_dfs_handle_radar_detection(struct ieee80211_local *local,
+				     struct ieee80211_channel *radar_channel)
 {
-	struct ieee80211_local *local =
-		container_of(work, struct ieee80211_local, radar_detected_work);
 	struct cfg80211_chan_def chandef = local->hw.conf.chandef;
+	struct cfg80211_chan_def *radar_chandef = NULL;
 	struct ieee80211_chanctx *ctx;
 	int num_chanctx = 0;
 
@@ -3505,23 +3505,69 @@ void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
 
 		num_chanctx++;
 		chandef = ctx->conf.def;
+
+		if (radar_channel &&
+		    (chandef.chan == radar_channel))
+			radar_chandef = &ctx->conf.def;
 	}
 
 	ieee80211_dfs_cac_cancel(local);
 
-	if (num_chanctx > 1)
-		/* XXX: multi-channel is not supported yet */
-		WARN_ON(1);
-	else
+	if (num_chanctx > 1) {
+		if (local->hw.wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO) {
+			if (WARN_ON(!radar_chandef))
+				return;
+
+			cfg80211_radar_event(local->hw.wiphy, radar_chandef, GFP_KERNEL);
+		} else {
+			/* XXX: multi-channel is not supported yet */
+			WARN_ON(1);
+		}
+	} else {
 		cfg80211_radar_event(local->hw.wiphy, &chandef, GFP_KERNEL);
+	}
 }
 
-void ieee80211_radar_detected(struct ieee80211_hw *hw)
+void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
+				       struct wiphy_work *work)
+{
+	struct ieee80211_local *local =
+		container_of(work, struct ieee80211_local, radar_detected_work);
+	struct radar_info *radar_info, *temp;
+	struct ieee80211_channel *radar_channel;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (list_empty(&local->radar_info_list)) {
+		ieee80211_dfs_handle_radar_detection(local, NULL);
+		return;
+	}
+
+	list_for_each_entry_safe(radar_info, temp, &local->radar_info_list,
+				 list) {
+		radar_channel = radar_info->channel;
+		ieee80211_dfs_handle_radar_detection(local, radar_channel);
+		list_del(&radar_info->list);
+		kfree(radar_info);
+	}
+}
+
+void ieee80211_radar_detected(struct ieee80211_hw *hw,
+			      struct ieee80211_channel *radar_channel)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct radar_info *radar_info;
 
 	trace_api_radar_detected(local);
 
+	radar_info = kzalloc(sizeof(*radar_info), GFP_ATOMIC);
+	if (!radar_info)
+		return;
+
+	INIT_LIST_HEAD(&radar_info->list);
+	radar_info->channel = radar_channel;
+	list_add_tail(&radar_info->list, &local->radar_info_list);
+
 	wiphy_work_queue(hw->wiphy, &local->radar_detected_work);
 }
 EXPORT_SYMBOL(ieee80211_radar_detected);
-- 
2.34.1


