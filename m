Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35216B1064
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCHRrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 12:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCHRrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 12:47:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE73F58B59
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 09:47:21 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328CnafP032435;
        Wed, 8 Mar 2023 17:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6yOdiSpX/dZRLoYLd7e/zHruj9GhBiWPoEGQ1XKslbs=;
 b=dLR2ndGfr/RxUP7fqnC+fZDq1+IEx4AXKoRL3K+r0AkXozzBnvSowxtPRKQvLCvlbVOE
 ALp1re5+MJ+vLzusqQzIGgbZblPjsHZxsn9CS2Rm0TSSH3586ps1pph7a9n9sNY2wc2T
 K072AMk8BkkP3Nx/Q0esh2QLg7GkL/MqRFMJijsyJDQd6FpD79u9C/MmoY66vYpRMQ/J
 reXy3R0jTMo/CdS6lwqd54igLaDdaL0VK4qByuRyDQ6PyAjZLuqDI4tQnvWL0qbDogZX
 IVysCs67f6VoCtld90YQDFZGzqTLGb6ak9gm2qjKfIIy+ZwTtf2vvOF7sbsK37xO70Bg 4Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6femjasu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 17:47:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328HlD4c012133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 17:47:14 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 09:47:13 -0800
From:   Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: [PATCH 1/2] wifi: ath11k: fix null ptr dereference when tx offload is enabled
Date:   Wed, 8 Mar 2023 09:47:02 -0800
Message-ID: <20230308174703.12270-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
References: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x2KJJlAePzDCc6qpgtCfhvmGljMRfzbN
X-Proofpoint-ORIG-GUID: x2KJJlAePzDCc6qpgtCfhvmGljMRfzbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_11,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=962 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080152
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When tx offload is enabled, info->band from skb cb is 0. This
causes null pointer access at mac80211 when sband is accessed.

In offload case, ndo_hard_start will bypass mac80211 tx and no
function will set info->band in skb cb to correct value.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 26 ++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8afbba236935..0f3a32434970 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -320,6 +320,8 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
 	struct ath11k *ar;
+	struct ieee80211_vif *vif;
+	u8 flags = 0;
 
 	spin_lock(&tx_ring->tx_idr_lock);
 	msdu = idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
@@ -341,6 +343,14 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
+	if (!skb_cb->vif) {
+		dev_kfree_skb_any(msdu);
+		return;
+	}
+
+	flags = skb_cb->flags;
+	vif = skb_cb->vif;
+
 	memset(&info->status, 0, sizeof(info->status));
 
 	if (ts->acked) {
@@ -354,8 +364,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 		}
 	}
-
-	ieee80211_tx_status(ar->hw, msdu);
+	if (flags & ATH11K_SKB_HW_80211_ENCAP)
+		ieee80211_tx_status_8023(ar->hw, vif, msdu);
+	else
+		ieee80211_tx_status(ar->hw, msdu);
 }
 
 static void
@@ -524,6 +536,8 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
 	struct rate_info rate;
+	struct ieee80211_vif *vif;
+	u8 flags = 0;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -544,6 +558,9 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 		return;
 	}
 
+	flags = skb_cb->flags;
+	vif = skb_cb->vif;
+
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
 
@@ -610,7 +627,10 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 
 	spin_unlock_bh(&ab->base_lock);
 
-	ieee80211_tx_status_ext(ar->hw, &status);
+	if (flags & ATH11K_SKB_HW_80211_ENCAP)
+		ieee80211_tx_status_8023(ar->hw, vif, msdu);
+	else
+		ieee80211_tx_status_ext(ar->hw, &status);
 }
 
 static inline void ath11k_dp_tx_status_parse(struct ath11k_base *ab,
-- 
2.17.1

