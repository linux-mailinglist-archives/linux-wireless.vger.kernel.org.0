Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3EA6F3168
	for <lists+linux-wireless@lfdr.de>; Mon,  1 May 2023 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjEANHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 09:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEANHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 09:07:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0918E
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 06:07:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341AtGvS011133
        for <linux-wireless@vger.kernel.org>; Mon, 1 May 2023 13:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Yb41jroayvgIiwbV5ke2qLUrVfrx57ndmqDf87YsWFA=;
 b=KcotXfcgcysgBQ3C5VvKJRbY9IUPu4Nyu5opEXKHNr+kB2K/1405rwh4cq58bX9g6jNO
 bH6K9TYwg8UofWR5icfRrkCIO208okqSgyN++fG8FWcgzcdrU1tAuQHvKyYSYXKwji13
 KfnPEVeJQzzDeJk1QkAsd18lf2lpzg69CU+a440f8qh5WOmAQnDdIf//S9TuiPktCrJe
 KXs/WMnN+OVLMbvPNAJc990N8dsC03ll9fzLCfRlnetpFtoo2IfbWis+HOzDbnwcj16e
 12CsWGZW5u0T2hl+af3fPrJuEW9sPCkO+tm8q0+GwakvCiCVrnnTQ70mhnRv7SoADcsE OQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8umg3gej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 01 May 2023 13:07:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341D7axG016912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 1 May 2023 13:07:36 GMT
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 May 2023 06:07:34 -0700
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath11k-review.external@qti.qualcomm.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Add mac80211 based AQL support in ath11k
Date:   Mon, 1 May 2023 18:37:25 +0530
Message-ID: <20230501130725.7171-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eFNvAhAKu67VceKSgP5E_BXKHUe4g0r2
X-Proofpoint-ORIG-GUID: eFNvAhAKu67VceKSgP5E_BXKHUe4g0r2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_06,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add wake_tx_queue mac op to support AQL and support
txq dequeueing from mac80211. Also implement a
simple scheduler for pulling all skbs from txqs
of all AC's at the end of tx completion NAPI.

Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 11 ++++
 drivers/net/wireless/ath/ath11k/mac.c   | 70 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/mac.h   |  1 +
 3 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 08a28464eb7a..bb1fed197707 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -681,12 +681,14 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 	struct ath11k_dp *dp = &ab->dp;
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
 	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
+	bool mac_id_scheduled[MAX_RADIOS];
 	struct sk_buff *msdu;
 	struct hal_tx_status ts = { 0 };
 	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
 	u32 *desc;
 	u32 msdu_id;
 	u8 mac_id;
+	int i;
 
 	spin_lock_bh(&status_ring->lock);
 
@@ -751,6 +753,15 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 			wake_up(&ar->dp.tx_empty_waitq);
 
 		ath11k_dp_tx_complete_msdu(ar, msdu, &ts);
+		mac_id_scheduled[mac_id] = true;
+	}
+
+	/* Schedule remaining Tx packets for the radio */
+	for (i = 0; i <  MAX_RADIOS; i++) {
+		if (!mac_id_scheduled[i])
+			continue;
+		ar = ab->pdevs[i].ar;
+		ath11k_mac_tx_push_pending(ar);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1c93f1afccc5..4dc76b5ba77f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5907,9 +5907,9 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
 	return 0;
 }
 
-static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
-			     struct ieee80211_tx_control *control,
-			     struct sk_buff *skb)
+static void ath11k_mac_tx(struct ieee80211_hw *hw,
+			  struct ieee80211_sta *sta,
+			  struct sk_buff *skb)
 {
 	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
 	struct ath11k *ar = hw->priv;
@@ -5944,8 +5944,8 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
-	if (control->sta)
-		arsta = (struct ath11k_sta *)control->sta->drv_priv;
+	if (sta)
+		arsta = (struct ath11k_sta *)sta->drv_priv;
 
 	ret = ath11k_dp_tx(ar, arvif, arsta, skb);
 	if (unlikely(ret)) {
@@ -5954,6 +5954,62 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	}
 }
 
+static void ath11k_mac_schedule_txq(struct ieee80211_hw *hw, u32 ac)
+{
+	struct ieee80211_txq *txq;
+	struct sk_buff *skb;
+
+	ieee80211_txq_schedule_start(hw, ac);
+	while ((txq = ieee80211_next_txq(hw, ac))) {
+		while ((skb = ieee80211_tx_dequeue_ni(hw, txq)))
+			ath11k_mac_tx(hw, txq->sta, skb);
+
+		ieee80211_return_txq(hw, txq, false);
+	}
+	ieee80211_txq_schedule_end(hw, ac);
+}
+
+void ath11k_mac_tx_push_pending(struct ath11k *ar)
+{
+	struct ieee80211_hw *hw = ar->hw;
+	u32 ac;
+
+	rcu_read_lock();
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
+		ath11k_mac_schedule_txq(hw, ac);
+
+	rcu_read_unlock();
+}
+
+static void ath11k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
+					struct ieee80211_txq *txq)
+{
+	u8 ac;
+	struct sk_buff *skb;
+
+	ac = txq->ac;
+	ieee80211_txq_schedule_start(hw, ac);
+	txq = ieee80211_next_txq(hw, ac);
+
+	if (!txq)
+		goto out;
+
+	while ((skb = ieee80211_tx_dequeue_ni(hw, txq)))
+		ath11k_mac_tx(hw, txq->sta, skb);
+
+	ieee80211_return_txq(hw, txq, false);
+
+out:
+	ieee80211_txq_schedule_end(hw, ac);
+}
+
+static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
+			     struct ieee80211_tx_control *control,
+			     struct sk_buff *skb)
+{
+	ath11k_mac_tx(hw, control->sta, skb);
+}
+
 void ath11k_mac_drain_tx(struct ath11k *ar)
 {
 	/* make sure rcu-protected mac80211 tx path itself is drained */
@@ -8763,7 +8819,7 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
-	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
+	.wake_tx_queue			= ath11k_mac_op_wake_tx_queue,
 	.start                          = ath11k_mac_op_start,
 	.stop                           = ath11k_mac_op_stop,
 	.reconfig_complete              = ath11k_mac_op_reconfig_complete,
@@ -9263,6 +9319,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	    ab->hw_params.bios_sar_capa)
 		ar->hw->wiphy->sar_capa = ab->hw_params.bios_sar_capa;
 
+	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
+
 	ret = ieee80211_register_hw(ar->hw);
 	if (ret) {
 		ath11k_err(ar->ab, "ieee80211 registration failed: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 0231783ad754..15517e9a3408 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -175,4 +175,5 @@ int ath11k_mac_wait_tx_complete(struct ath11k *ar);
 int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
 				 enum wmi_sta_keepalive_method method,
 				 u32 interval);
+void ath11k_mac_tx_push_pending(struct ath11k *ar);
 #endif

base-commit: 12f167f02a1abe2c8817496a902de00758285b92
-- 
2.17.1

