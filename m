Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F354650756
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 06:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiLSFjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 00:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiLSFja (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 00:39:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15265598
        for <linux-wireless@vger.kernel.org>; Sun, 18 Dec 2022 21:39:27 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ5TQSZ007370;
        Mon, 19 Dec 2022 05:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=frGWEW0ltK9CzsASRaoZS0jVXsQRO+f8kCn38QpgLl8=;
 b=FPBTppt3PzM8wi+g8fp+4BHkgQDc2qTa2Hct0Kgl4ye35xnXPiIrrUo3UYe2KcmNM2dZ
 YCjUjv7dMjbkLuAiy+CO1UK1IX0JmFdBHsK+MfD9GsQR7deuFHIIJfqxeH+68lCKdSVC
 Rnmg7LqFK44j4MrstpdSFVZg4UB9AiRFpeihFni4HvCA86OWn+f7PkS9iaVEL9iMLey/
 m4AdioGKfAV6gLLX7KTC5xR96V/tiuoEg3xobkU4GZW490FYnjI9aeoeeyPVOvNE09e9
 i7ibYByyO0yYGac1qW8gPMnj5aB3AXEebxoiWxR2DYuxgGG7YASmIaG4c/H7t6GnR7tX RQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh5c7ugkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 05:39:17 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJ5dG9l026803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 05:39:16 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 18 Dec 2022 21:39:14 -0800
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Abinaya Kalaiselvan <quic_akalaise@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH] wifi: ath11k: Add tx ack signal support for mgmt packets
Date:   Mon, 19 Dec 2022 11:08:44 +0530
Message-ID: <20221219053844.4084486-1-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kOkHviDY8_NjXc0x27ac5haV2Ktphimd
X-Proofpoint-ORIG-GUID: kOkHviDY8_NjXc0x27ac5haV2Ktphimd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-18_13,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abinaya Kalaiselvan <quic_akalaise@quicinc.com>

Add support to notify tx ack signal values for mgmt
packets to userspace through NL interface.

Advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag
to enable this feature and it will be used for data
packets as well.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Abinaya Kalaiselvan <quic_akalaise@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hw.c  |  1 +
 drivers/net/wireless/ath/ath11k/mac.c |  5 +++++
 drivers/net/wireless/ath/ath11k/wmi.c | 27 ++++++++++++++++-----------
 drivers/net/wireless/ath/ath11k/wmi.h |  3 +++
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index ab8f0ccacc6b..60ac215e0678 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -201,6 +201,7 @@ static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 	config->twt_ap_pdev_count = ab->num_radios;
 	config->twt_ap_sta_count = 1000;
 	config->flag1 |= WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;
+	config->flag1 |= WMI_RSRC_CFG_FLAG1_ACK_RSSI;
 }
 
 static int ath11k_hw_mac_id_to_pdev_id_ipq8074(struct ath11k_hw_params *hw,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b198edba76eb..6b5198da7f4f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9079,6 +9079,11 @@ static int __ath11k_mac_register(struct ath11k *ar)
 		goto err_free_if_combs;
 	}
 
+	if (test_bit(WMI_TLV_SERVICE_TX_DATA_MGMT_ACK_RSSI,
+		     ar->ab->wmi_ab.svc_map))
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
+
 	ar->hw->queues = ATH11K_HW_MAX_QUEUES;
 	ar->hw->wiphy->tx_queue_len = ATH11K_QUEUE_LEN;
 	ar->hw->offchannel_tx_hw_queue = ATH11K_HW_MAX_QUEUES - 1;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2a8a3e3dcff6..0583d467421b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5221,8 +5221,8 @@ static int ath11k_pull_mgmt_rx_params_tlv(struct ath11k_base *ab,
 	return 0;
 }
 
-static int wmi_process_mgmt_tx_comp(struct ath11k *ar, u32 desc_id,
-				    u32 status)
+static int wmi_process_mgmt_tx_comp(struct ath11k *ar,
+				    struct wmi_mgmt_tx_compl_event *tx_compl_param)
 {
 	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
@@ -5230,24 +5230,29 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar, u32 desc_id,
 	int num_mgmt;
 
 	spin_lock_bh(&ar->txmgmt_idr_lock);
-	msdu = idr_find(&ar->txmgmt_idr, desc_id);
+	msdu = idr_find(&ar->txmgmt_idr, tx_compl_param->desc_id);
 
 	if (!msdu) {
 		ath11k_warn(ar->ab, "received mgmt tx compl for invalid msdu_id: %d\n",
-			    desc_id);
+			    tx_compl_param->desc_id);
 		spin_unlock_bh(&ar->txmgmt_idr_lock);
 		return -ENOENT;
 	}
 
-	idr_remove(&ar->txmgmt_idr, desc_id);
+	idr_remove(&ar->txmgmt_idr, tx_compl_param->desc_id);
 	spin_unlock_bh(&ar->txmgmt_idr_lock);
 
 	skb_cb = ATH11K_SKB_CB(msdu);
 	dma_unmap_single(ar->ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	info = IEEE80211_SKB_CB(msdu);
-	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status)
+	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) &&
+	    !tx_compl_param->status) {
 		info->flags |= IEEE80211_TX_STAT_ACK;
+		if (test_bit(WMI_TLV_SERVICE_TX_DATA_MGMT_ACK_RSSI,
+			     ar->ab->wmi_ab.svc_map))
+			info->status.ack_signal = tx_compl_param->ack_rssi;
+	}
 
 	ieee80211_tx_status_irqsafe(ar->hw, msdu);
 
@@ -5259,7 +5264,7 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar, u32 desc_id,
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
 		   "wmi mgmt tx comp pending %d desc id %d\n",
-		   num_mgmt, desc_id);
+		   num_mgmt, tx_compl_param->desc_id);
 
 	if (!num_mgmt)
 		wake_up(&ar->txmgmt_empty_waitq);
@@ -5292,6 +5297,7 @@ static int ath11k_pull_mgmt_tx_compl_param_tlv(struct ath11k_base *ab,
 	param->pdev_id = ev->pdev_id;
 	param->desc_id = ev->desc_id;
 	param->status = ev->status;
+	param->ack_rssi = ev->ack_rssi;
 
 	kfree(tb);
 	return 0;
@@ -7062,13 +7068,12 @@ static void ath11k_mgmt_tx_compl_event(struct ath11k_base *ab, struct sk_buff *s
 		goto exit;
 	}
 
-	wmi_process_mgmt_tx_comp(ar, tx_compl_param.desc_id,
-				 tx_compl_param.status);
+	wmi_process_mgmt_tx_comp(ar, &tx_compl_param);
 
 	ath11k_dbg(ab, ATH11K_DBG_MGMT,
-		   "mgmt tx compl ev pdev_id %d, desc_id %d, status %d",
+		   "mgmt tx compl ev pdev_id %d, desc_id %d, status %d ack_rssi %d",
 		   tx_compl_param.pdev_id, tx_compl_param.desc_id,
-		   tx_compl_param.status);
+		   tx_compl_param.status, tx_compl_param.ack_rssi);
 
 exit:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8f2c07d70a4a..31d14e15ebc1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2309,6 +2309,7 @@ struct wmi_init_cmd {
 } __packed;
 
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 BIT(5)
+#define WMI_RSRC_CFG_FLAG1_ACK_RSSI BIT(18)
 
 struct wmi_resource_config {
 	u32 tlv_header;
@@ -4541,6 +4542,8 @@ struct wmi_mgmt_tx_compl_event {
 	u32 desc_id;
 	u32 status;
 	u32 pdev_id;
+	u32 ppdu_id;
+	u32 ack_rssi;
 } __packed;
 
 struct wmi_scan_event {
-- 
2.25.1

