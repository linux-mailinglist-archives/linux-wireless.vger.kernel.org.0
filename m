Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D246D51AB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjDCT56 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjDCT54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 15:57:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB130F4
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 12:57:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333IsYuO028175;
        Mon, 3 Apr 2023 19:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=++7KqSne6CTp8VkCuoBNq4vl9orxSJ5KOeuiy55dgrU=;
 b=iKht6IeVZOH80GK8uXxUhb5uYyuLVXVH4aa2kxM3H8KYQBNDDOhLhdRYLs8IlMbR95A+
 68DS5nhAJ4YEMDR4l8vhAELZH+DiMEoCMBSRcMLDT5vK8nAYe21jNkVpJF/lxoPSirhK
 i0qwc3MKu5u2UxCZmVXB2OoreC1XjM6h1io8Q7JLioWwnl5WCGBRbR6p3OfpgGTjVrZY
 91IwJplpDxoXHwKi5ThFX6ETjSrPEhSrX6reWSrlPzO2OAqjfQZJvOIqpGAYqk9iVU8B
 MV9iQpz+OoA0aR4q49i+yTxX1yW2+y7s/QmMhFsp546SQ5yElTKruyp29nm3Im+U4dzH Gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqusu1hpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 19:57:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333Jvmmt012437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 19:57:48 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 12:57:48 -0700
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH V3 1/2] wifi: ath11k: fix tx status reporting in encap offload mode
Date:   Mon, 3 Apr 2023 12:57:37 -0700
Message-ID: <20230403195738.25367-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230403195738.25367-1-quic_pradeepc@quicinc.com>
References: <20230403195738.25367-1-quic_pradeepc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N9H5Kjr8zCow_-ePF-g1pHDD9vjG8DRp
X-Proofpoint-ORIG-GUID: N9H5Kjr8zCow_-ePF-g1pHDD9vjG8DRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=965 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030154
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
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

