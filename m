Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3237F21CE
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 00:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjKTX6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 18:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKTX6p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 18:58:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBBAC
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 15:58:42 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKNiOIt008012;
        Mon, 20 Nov 2023 23:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=iIOsr+Oc6RR7yThdcqDp7tmyW3n4O2KqOa9s+XtgHTk=;
 b=X+NtZRuF8/hwufxGtJ1GG/ZvhZH3GQlFHHPSOpaMH5B2AEmQ+wc8DRv7SUb3vsPJc3R2
 yBHWiZXkTpUWB5eRYJxArU5RZzGGuIxqOXQDCsx95m9dB7OG3uYTnwRmIIDlH9SItp97
 LloN5t7uYOfuXYHaSHvHO1JwJy99HFZnipcUqSwdZuT6L+1Sj3gSV3Q+1tnUfRnAhHFr
 fGnStqMLrdtoT2Pxy/7vkqr8KchwV6qZE0v6MIzswmalTAfqq9e3pWJzkwD+1G9rlm16
 iVS4IIyezJx5SRn+mx2WODcdCDMY2RKIkP3K/8zkaF2MvSYAySHumWxDthVZOYGvVlxo 0w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug26ttb00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 23:58:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKNwUTe032543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 23:58:30 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 15:58:28 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: Optimize the mac80211 hw data access
Date:   Tue, 21 Nov 2023 05:28:11 +0530
Message-ID: <20231120235812.2602198-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120235812.2602198-1-quic_periyasa@quicinc.com>
References: <20231120235812.2602198-1-quic_periyasa@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -4uWAg06eyF_ZHYfbgM1hd3HJazWwAxX
X-Proofpoint-GUID: -4uWAg06eyF_ZHYfbgM1hd3HJazWwAxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently mac80211 hw data is accessed by convert the hw to radio (ar)
structure and then radio to hw structure which is not necessary in some
places where mac80211 hw data is already present. So in that kind of
places avoid the conversion and directly access the mac80211 hw data.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 14 +++++++-------
 drivers/net/wireless/ath/ath12k/reg.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fc0d14ea328e..a85862ba134e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4987,7 +4987,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to queue management frame %d\n",
 				    ret);
-			ieee80211_free_txskb(ar->hw, skb);
+			ieee80211_free_txskb(hw, skb);
 		}
 		return;
 	}
@@ -4995,7 +4995,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	ret = ath12k_dp_tx(ar, arvif, skb);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
-		ieee80211_free_txskb(ar->hw, skb);
+		ieee80211_free_txskb(hw, skb);
 	}
 }
 
@@ -5596,7 +5596,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 		goto err_peer_del;
 
 	param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
-	param_value = ar->hw->wiphy->rts_threshold;
+	param_value = hw->wiphy->rts_threshold;
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    param_id, param_value);
 	if (ret) {
@@ -6836,7 +6836,7 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 			return ret;
 		}
-		ieee80211_iterate_stations_atomic(ar->hw,
+		ieee80211_iterate_stations_atomic(hw,
 						  ath12k_mac_disable_peer_fixed_rate,
 						  arvif);
 	} else if (ath12k_mac_bitrate_mask_get_single_nss(ar, band, mask,
@@ -6882,14 +6882,14 @@ ath12k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			return -EINVAL;
 		}
 
-		ieee80211_iterate_stations_atomic(ar->hw,
+		ieee80211_iterate_stations_atomic(hw,
 						  ath12k_mac_disable_peer_fixed_rate,
 						  arvif);
 
 		mutex_lock(&ar->conf_mutex);
 
 		arvif->bitrate_mask = *mask;
-		ieee80211_iterate_stations_atomic(ar->hw,
+		ieee80211_iterate_stations_atomic(hw,
 						  ath12k_mac_set_bitrate_mask_iter,
 						  arvif);
 
@@ -6927,7 +6927,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 		ath12k_warn(ar->ab, "pdev %d successfully recovered\n",
 			    ar->pdev->pdev_id);
 		ar->state = ATH12K_STATE_ON;
-		ieee80211_wake_queues(ar->hw);
+		ieee80211_wake_queues(hw);
 
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 5c006256c82a..b7fe4a6e7873 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -28,11 +28,11 @@ static const struct ieee80211_regdomain ath12k_world_regd = {
 	}
 };
 
-static bool ath12k_regdom_changes(struct ath12k *ar, char *alpha2)
+static bool ath12k_regdom_changes(struct ieee80211_hw *hw, char *alpha2)
 {
 	const struct ieee80211_regdomain *regd;
 
-	regd = rcu_dereference_rtnl(ar->hw->wiphy->regd);
+	regd = rcu_dereference_rtnl(hw->wiphy->regd);
 	/* This can happen during wiphy registration where the previous
 	 * user request is received before we update the regd received
 	 * from firmware.
@@ -71,7 +71,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 		return;
 	}
 
-	if (!ath12k_regdom_changes(ar, request->alpha2)) {
+	if (!ath12k_regdom_changes(hw, request->alpha2)) {
 		ath12k_dbg(ar->ab, ATH12K_DBG_REG, "Country is already set\n");
 		return;
 	}
-- 
2.34.1

