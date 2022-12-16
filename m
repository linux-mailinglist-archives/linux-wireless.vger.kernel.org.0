Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0581A64E79E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 08:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiLPHNS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 02:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPHMn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 02:12:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A8A63DB
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 23:09:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG6Eslt006900;
        Fri, 16 Dec 2022 07:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=nKyh0uFz/ljdjBnoozXbUnYyuBFJYtSCJNST2jHi4J8=;
 b=GmzUCvgiz4pM7Sfgj8oLpCHd2oV+aTPN0r8Bvi8Q+xz5ZE1G1VvZ56sy3O6JBmT0ZQ1s
 NQLoDoo68TXdmbWR3ExbjSPTSg5j3a0kw78A9zrS0vTkTCCXDJfNg4nXPV6nb1MxrC8s
 G/2b01A6Ru76iiw2unBOpi4xZBnYBYgGA/kKY6RM11m4RNtdEKRQC1OTWPn+gqLYS3Tc
 klYpPu6cQBdh/g4OeQM79Vz0fB8tjxNqq8pqLhuaMD6lIilooyBF5L6lPK7nYBhBg8kI
 gOE6ODCAFvbIE5R9roMRFdmx4fku4dlbzEpIuCpC5oBnuEvV94L8QlIovks1IV/bDFBJ ng== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg6tet9t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 07:09:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BG79c53009555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 07:09:38 GMT
Received: from nmaran-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 15 Dec 2022 23:09:36 -0800
From:   Nagarajan Maran <quic_nmaran@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: radar bitmap support during radar detection.
Date:   Fri, 16 Dec 2022 12:39:18 +0530
Message-ID: <20221216070918.5969-3-quic_nmaran@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221216070918.5969-1-quic_nmaran@quicinc.com>
References: <20221216070918.5969-1-quic_nmaran@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _Wuf1WXCROkNdTFeOxFCoZk4RSeef8Kb
X-Proofpoint-GUID: _Wuf1WXCROkNdTFeOxFCoZk4RSeef8Kb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_03,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With the current implementation when radar is detected, the whole
configured DFS channels are moved to "unavailable" state(NOL).
However to move only the radar affected channels alone to NOL,
introducing two unsigned 16bit variables "cf1_radar_bitmap" and
"cf2_radar_bitmap" which denotes the radar(with a granularity of
20 MHz) in the first and the second part of the channel respectively.

The LSB of the radar bitmap corresponds to the lowest 20 MHz channel
of the configured channel bandwidth. Each bit set to "1" in this radar
bitmap indicates that radar is detected in that sub-channel. Pass
these radar bitmaps from driver to cfg80211 through the existing radar
detected workqueue, to move the affected channels alone to NOL. Change
the "ieee80211_radar_detected" API calls in drivers to address the new
parameters. With these radar bitmaps, we can support bandwidth
reduction and RX puncturing in the DFS Channels.

Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/debug.c          |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c            |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c            |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c            |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c            |  2 +-
 drivers/net/wireless/ath/ath9k/dfs.c             |  2 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c       |  2 +-
 drivers/net/wireless/mac80211_hwsim.c            |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c  |  2 +-
 drivers/net/wireless/ti/wl18xx/event.c           |  2 +-
 include/net/mac80211.h                           |  5 ++++-
 net/mac80211/ieee80211_i.h                       |  2 ++
 net/mac80211/util.c                              | 10 +++++++++-
 16 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index b9aea1510f7b..55bdd9daf451 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1773,7 +1773,7 @@ static ssize_t ath10k_write_simulate_radar(struct file *file,
 	if (!arvif->is_started)
 		return -EINVAL;
 
-	ieee80211_radar_detected(ar->hw);
+	ieee80211_radar_detected(ar->hw, 0, 0);
 
 	return count;
 }
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index ec8d5b29bc72..12c284d578a0 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -1442,7 +1442,7 @@ static void ath10k_recalc_radar_detection(struct ath10k *ar)
 		 * by indicating that radar was detected.
 		 */
 		ath10k_warn(ar, "failed to start CAC: %d\n", ret);
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ar->hw, 0, 0);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 980d4124fa28..b99ece354584 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3969,7 +3969,7 @@ static void ath10k_radar_detected(struct ath10k *ar)
 	if (ar->dfs_block_radar_events)
 		ath10k_info(ar, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ar->hw, 0, 0);
 }
 
 static void ath10k_radar_confirmation_work(struct work_struct *work)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2a8a3e3dcff6..7e1215d8988d 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7738,7 +7738,7 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 	if (ar->dfs_block_radar_events)
 		ath11k_info(ab, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ar->hw, 0, 0);
 
 exit:
 	kfree(tb);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 338082719631..d6769d0adecc 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6192,7 +6192,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 	if (ar->dfs_block_radar_events)
 		ath12k_info(ab, "DFS Radar detected, but ignored as requested\n");
 	else
-		ieee80211_radar_detected(ar->hw);
+		ieee80211_radar_detected(ar->hw, 0, 0);
 
 exit:
 	kfree(tb);
diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 11349218bc21..f98f025cbb9c 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -280,7 +280,7 @@ ath9k_dfs_process_radar_pulse(struct ath_softc *sc, struct pulse_event *pe)
 	if (!pd->add_pulse(pd, pe, NULL))
 		return;
 	DFS_STAT_INC(sc, radar_detected);
-	ieee80211_radar_detected(sc->hw);
+	ieee80211_radar_detected(sc->hw, 0, 0);
 }
 
 /*
diff --git a/drivers/net/wireless/ath/ath9k/dfs_debug.c b/drivers/net/wireless/ath/ath9k/dfs_debug.c
index 2a79c2fa8415..779844e8504c 100644
--- a/drivers/net/wireless/ath/ath9k/dfs_debug.c
+++ b/drivers/net/wireless/ath/ath9k/dfs_debug.c
@@ -122,7 +122,7 @@ static ssize_t write_file_simulate_radar(struct file *file,
 {
 	struct ath_softc *sc = file->private_data;
 
-	ieee80211_radar_detected(sc->hw);
+	ieee80211_radar_detected(sc->hw, 0, 0);
 
 	return count;
 }
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index c57c8903b7c0..872396a43bbc 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1008,7 +1008,7 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 {
 	struct mac80211_hwsim_data *data = dat;
 
-	ieee80211_radar_detected(data->hw);
+	ieee80211_radar_detected(data->hw, 0, 0);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 83f30305414d..6979c4bbefa5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -394,7 +394,7 @@ mt7615_mcu_rx_radar_detected(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (mt76_phy_dfs_state(mphy) < MT_DFS_STATE_CAC)
 		return;
 
-	ieee80211_radar_detected(mphy->hw);
+	ieee80211_radar_detected(mphy->hw, 0, 0);
 	dev->hw_pattern++;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index 024a5c0a5a57..0c6d7b93c585 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -630,7 +630,7 @@ static void mt76x02_dfs_tasklet(struct tasklet_struct *t)
 		radar_detected = mt76x02_dfs_check_detection(dev);
 		if (radar_detected) {
 			/* sw detector rx radar pattern */
-			ieee80211_radar_detected(dev->mt76.hw);
+			ieee80211_radar_detected(dev->mt76.hw, 0, 0);
 			mt76x02_dfs_detector_reset(dev);
 
 			return;
@@ -658,7 +658,7 @@ static void mt76x02_dfs_tasklet(struct tasklet_struct *t)
 
 		/* hw detector rx radar pattern */
 		dfs_pd->stats[i].hw_pattern++;
-		ieee80211_radar_detected(dev->mt76.hw);
+		ieee80211_radar_detected(dev->mt76.hw, 0, 0);
 		mt76x02_dfs_detector_reset(dev);
 
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b2652de082ba..d45550d8bdb6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -277,7 +277,7 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 						&dev->rdd2_chandef,
 						GFP_ATOMIC);
 	else
-		ieee80211_radar_detected(mphy->hw);
+		ieee80211_radar_detected(mphy->hw, 0, 0);
 	dev->hw_pattern++;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 04e1d10bbd21..05ca90ed06e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -344,7 +344,7 @@ mt7996_mcu_rx_radar_detected(struct mt7996_dev *dev, struct sk_buff *skb)
 						&dev->rdd2_chandef,
 						GFP_ATOMIC);
 	else
-		ieee80211_radar_detected(mphy->hw);
+		ieee80211_radar_detected(mphy->hw, 0, 0);
 	dev->hw_pattern++;
 }
 
diff --git a/drivers/net/wireless/ti/wl18xx/event.c b/drivers/net/wireless/ti/wl18xx/event.c
index 34d95f458e1a..a382fb8a26ae 100644
--- a/drivers/net/wireless/ti/wl18xx/event.c
+++ b/drivers/net/wireless/ti/wl18xx/event.c
@@ -142,7 +142,7 @@ int wl18xx_process_mailbox_events(struct wl1271 *wl)
 			    wl18xx_radar_type_decode(mbox->radar_type));
 
 		if (!wl->radar_debug_mode)
-			ieee80211_radar_detected(wl->hw);
+			ieee80211_radar_detected(wl->hw, 0, 0);
 	}
 
 	if (vector & PERIODIC_SCAN_REPORT_EVENT_ID) {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 689da327ce2e..233905187132 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6396,8 +6396,11 @@ void ieee80211_cqm_beacon_loss_notify(struct ieee80211_vif *vif, gfp_t gfp);
  * ieee80211_radar_detected - inform that a radar was detected
  *
  * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @cf1_radar_bitmap: denotes the bitmap of radar in the first part of channel.
+ * @cf2_radar_bitmap: denotes the bitmap of radar in the second part of channel.
  */
-void ieee80211_radar_detected(struct ieee80211_hw *hw);
+void ieee80211_radar_detected(struct ieee80211_hw *hw, u16 cf1_radar_bitmap,
+			      u16 cf2_radar_bitmap);
 
 /**
  * ieee80211_chswitch_done - Complete channel switch process
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 63ff0d2524b6..6eacc3325660 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1552,6 +1552,8 @@ struct ieee80211_local {
 	/* virtual monitor interface */
 	struct ieee80211_sub_if_data __rcu *monitor_sdata;
 	struct cfg80211_chan_def monitor_chandef;
+	u16 cf1_radar_bitmap;
+	u16 cf2_radar_bitmap;
 
 	/* extended capabilities provided by mac80211 */
 	u8 ext_capa[8];
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 6f5407038459..1c5109adff1b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4247,6 +4247,11 @@ void ieee80211_dfs_radar_detected_work(struct work_struct *work)
 	ieee80211_dfs_cac_cancel(local);
 	wiphy_unlock(local->hw.wiphy);
 
+	chandef.cf1_radar_bitmap = local->cf1_radar_bitmap;
+	chandef.cf2_radar_bitmap = local->cf2_radar_bitmap;
+	local->cf1_radar_bitmap = 0;
+	local->cf2_radar_bitmap = 0;
+
 	if (num_chanctx > 1)
 		/* XXX: multi-channel is not supported yet */
 		WARN_ON(1);
@@ -4254,9 +4259,12 @@ void ieee80211_dfs_radar_detected_work(struct work_struct *work)
 		cfg80211_radar_event(local->hw.wiphy, &chandef, GFP_KERNEL);
 }
 
-void ieee80211_radar_detected(struct ieee80211_hw *hw)
+void ieee80211_radar_detected(struct ieee80211_hw *hw, u16 cf1_radar_bitmap,
+			      u16 cf2_radar_bitmap)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	local->cf1_radar_bitmap = cf1_radar_bitmap;
+	local->cf2_radar_bitmap = cf2_radar_bitmap;
 
 	trace_api_radar_detected(local);
 
-- 
2.17.1

