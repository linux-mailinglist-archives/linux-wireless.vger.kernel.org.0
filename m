Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C571A6D2DC8
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 04:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjDACuL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjDACuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 22:50:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85A12049
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 19:50:08 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3312o2vd020695;
        Sat, 1 Apr 2023 02:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=++7KqSne6CTp8VkCuoBNq4vl9orxSJ5KOeuiy55dgrU=;
 b=FY7ff0uE8q176wuwdu7lLWMZXTYKKMm6VhLKEjIXY1F7FgOK3hpHlNkrbT1SMJ3RoRS7
 ZMH/l50hocMLChUXTdIrovfBvqWIovPFNqnUeA4O6uXHpfrA4sl5SRIbCS58PbMGjszb
 3e8dvZ5WdLhFikX66a+SvhDfJD2cYQaN2EVbcCyh+LdFykToLEbsuQNq861MECDrk4QA
 91fHNrqE5+6GLStRRrpPqw7pNMUwILdU2AbdOiGhoUo1TQ4+Vqs2cKOrz4Cl5BfBlXul
 hpb9MV/JAR4OGma/4AA0yw+Kkg4LSe7lUWGNSaPGxMXEBxG6ntmboIlKjd9i8yUvQIVb Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pnu6cu3sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Apr 2023 02:50:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3312o1qJ015511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Apr 2023 02:50:01 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 31 Mar 2023 19:50:01 -0700
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH V2 1/2] wifi: ath11k: fix tx status reporting in encap offload mode
Date:   Fri, 31 Mar 2023 19:49:31 -0700
Message-ID: <20230401024932.11722-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230401024932.11722-1-quic_pradeepc@quicinc.com>
References: <20230401024932.11722-1-quic_pradeepc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oLUNe5StrQem3-o8Adva6wKbiU1flB-2
X-Proofpoint-ORIG-GUID: oLUNe5StrQem3-o8Adva6wKbiU1flB-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=969 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304010023
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_tx_status() treats packets in 802.11 frame format and
tries to extract sta address from packet header. When tx encap
offload is enabled, this becomes invalid operation. Hence, switch
to using ieee80211_tx_status_ext() after filling in station
address for handling both 802.11 and 802.3 frames.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp.h    |  3 +++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 29 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.h |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index be9eafc872b3..fb5c9e4b8ad2 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -303,12 +303,15 @@ struct ath11k_dp {
 
 #define HTT_TX_WBM_COMP_STATUS_OFFSET 8
 
+#define HTT_INVALID_PEER_ID	0xffff
 /* HTT tx completion is overlaid in wbm_release_ring */
 #define HTT_TX_WBM_COMP_INFO0_STATUS		GENMASK(12, 9)
 #define HTT_TX_WBM_COMP_INFO0_REINJECT_REASON	GENMASK(16, 13)
 #define HTT_TX_WBM_COMP_INFO0_REINJECT_REASON	GENMASK(16, 13)
 
 #define HTT_TX_WBM_COMP_INFO1_ACK_RSSI		GENMASK(31, 24)
+#define HTT_TX_WBM_COMP_INFO2_SW_PEER_ID	GENMASK(15, 0)
+#define HTT_TX_WBM_COMP_INFO2_VALID		BIT(21)
 
 struct htt_tx_wbm_completion {
 	u32 info0;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8afbba236935..391e5a724727 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -316,10 +316,12 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 				 struct dp_tx_ring *tx_ring,
 				 struct ath11k_dp_htt_wbm_tx_status *ts)
 {
+	struct ieee80211_tx_status status = { 0 };
 	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
 	struct ath11k *ar;
+	struct ath11k_peer *peer;
 
 	spin_lock(&tx_ring->tx_idr_lock);
 	msdu = idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
@@ -341,6 +343,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
+	if (!skb_cb->vif) {
+		dev_kfree_skb_any(msdu);
+		return;
+	}
 	memset(&info->status, 0, sizeof(info->status));
 
 	if (ts->acked) {
@@ -355,7 +361,23 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 		}
 	}
 
-	ieee80211_tx_status(ar->hw, msdu);
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath11k_dbg(ab, ATH11K_DBG_DATA,
+			   "dp_tx: failed to find the peer with peer_id %d\n",
+			    ts->peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		dev_kfree_skb_any(msdu);
+		return;
+	}
+	spin_unlock_bh(&ab->base_lock);
+
+	status.sta = peer->sta;
+	status.info = info;
+	status.skb = msdu;
+
+	ieee80211_tx_status_ext(ar->hw, &status);
 }
 
 static void
@@ -379,6 +401,11 @@ ath11k_dp_tx_process_htt_tx_complete(struct ath11k_base *ab,
 		ts.msdu_id = msdu_id;
 		ts.ack_rssi = FIELD_GET(HTT_TX_WBM_COMP_INFO1_ACK_RSSI,
 					status_desc->info1);
+		if (FIELD_GET(HTT_TX_WBM_COMP_INFO2_VALID, status_desc->info2))
+			ts.peer_id = FIELD_GET(HTT_TX_WBM_COMP_INFO2_SW_PEER_ID,
+					       status_desc->info2);
+		else
+			ts.peer_id = HTT_INVALID_PEER_ID;
 		ath11k_dp_tx_htt_tx_complete_buf(ab, tx_ring, &ts);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
index e87d65bfbf06..68a21ea9b934 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -13,6 +13,7 @@ struct ath11k_dp_htt_wbm_tx_status {
 	u32 msdu_id;
 	bool acked;
 	int ack_rssi;
+	u16 peer_id;
 };
 
 void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts);
-- 
2.17.1

