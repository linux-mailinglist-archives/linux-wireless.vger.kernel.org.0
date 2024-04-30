Return-Path: <linux-wireless+bounces-7033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0CE8B6C07
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 09:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6A91C21C5F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0C1179A7;
	Tue, 30 Apr 2024 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i0dsm3/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BED3EA83
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463029; cv=none; b=MgAPC0zhs1juoIZ/sBldpNrFynA5h+HRobY1lVKTa/cnD89Fz0sTonKqOHTN/CHxzRL0cwXag25CL8shhi7bNd08xPrVgCWpmV+dZA0sMby5I+ikJ2TMvlkUvxgy2wqdjUSe67jQAh8gif66Y04uFjceAvqsdrtKnwHsJJ/zxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463029; c=relaxed/simple;
	bh=LnflfA4Q8WPb93+zXCDM8S37PljUxuKYo6o+m9idVTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruydGpXDEUG5umzJrdUpspG3CXh5YwO5tdk4aRSZMkveoOCHPlaDnEIOFzMaGQBot2ZUfanmxMlRzZZa1Eu/2vFrKNt//iFUgUhf9okz7McXBrdvGeE7y36CbFMGSvogB5Mh5SFIkoRj+j28AmXZ/OxTCCbaf1zlSnC40fvH2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i0dsm3/D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U4wmVd031496;
	Tue, 30 Apr 2024 07:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mUJediFVnhjm8YBUVSKR4kdl+5u1ESmlBE2KzIE5ruU=; b=i0
	dsm3/D42feP1YeNuT4kYYroI/mGNXKZsXkB04EhaG8+24Q9Yb2g9Zde0RPy/fjp9
	F85igIYWT12M44UikQY2CpbDxLOOoV9WsLU9OUtOb9RWD4GXyJuNa65vLhWLT9qw
	8zG8lqaVGI6HWMjc+1WeZKTY6IbwbGhExhce1Rx7Yyl5peNfpIrWgCC1iCgMbhUB
	q60PEpERAZ+0fLCZR+lA1zTwFuQrLCe4KoT0XqYTPe/pEX8m9/J8BIypzOM78N1I
	L/H4e6rWVv7PDkrGK4pXW6O/CRRDMK3H6dV+Ca0GHO9nUw2/Sqj2A+ev8VwsEYl+
	zYSHE675RMvARCiKubBQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtrep0m7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:43:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U7hfHO030202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 07:43:41 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 00:43:39 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sven Eckelmann <sven@narfation.org>,
        Sarika Sharma <quic_sarishar@quicinc.com>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
Subject: [PATCH v4 1/2] wifi: ath12k: Don't drop tx_status in failure case
Date: Tue, 30 Apr 2024 13:13:12 +0530
Message-ID: <20240430074313.885807-2-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430074313.885807-1-quic_kathirve@quicinc.com>
References: <20240430074313.885807-1-quic_kathirve@quicinc.com>
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
X-Proofpoint-GUID: QLTEUXSsDSGysyqZcMAjJRb9_zzAar0n
X-Proofpoint-ORIG-GUID: QLTEUXSsDSGysyqZcMAjJRb9_zzAar0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300055

From: Sven Eckelmann <sven@narfation.org>

When a station idles for a long time, hostapd will try to send
a QoS Null frame to the station as "poll". NL80211_CMD_PROBE_CLIENT
is used for this purpose.
And the skb will be added to ack_status_frame - waiting for a
completion via ieee80211_report_ack_skb().

But when the peer was already removed before the tx_complete arrives,
the peer will be missing. And when using dev_kfree_skb_any (instead
of going through mac80211), the entry will stay inside
ack_status_frames thus not clean up related information in its
internal data structures. This IDR will therefore run full after
8K request were generated for such clients.
At this point, the access point will then just stall and not allow
any new clients because idr_alloc() for ack_status_frame will fail.

ieee80211_free_txskb() on the other hand will (when required) call
ieee80211_report_ack_skb() and make sure that (when required) remove
the entry from the ack_status_frame and clean up related
information in its internal data structures.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Link: https://lore.kernel.org/r/20230802-ath11k-ack_status_leak-v2-1-c0af729d6229@narfation.org
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 9b6d7d72f57c..81a85d5946f5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -352,15 +352,15 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 	u8 pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
 
 	skb_cb = ATH12K_SKB_CB(msdu);
+	ar = ab->pdevs[pdev_id].ar;
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 	if (skb_cb->paddr_ext_desc)
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
 
-	dev_kfree_skb_any(msdu);
+	ieee80211_free_txskb(ar->ah->hw, msdu);
 
-	ar = ab->pdevs[pdev_id].ar;
 	if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 		wake_up(&ar->dp.tx_empty_waitq);
 }
@@ -448,6 +448,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 				       struct hal_tx_status *ts)
 {
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ar->ah;
 	struct ieee80211_tx_info *info;
 	struct ath12k_skb_cb *skb_cb;
 
@@ -466,12 +467,12 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	rcu_read_lock();
 
 	if (!rcu_dereference(ab->pdevs_active[ar->pdev_idx])) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ah->hw, msdu);
 		goto exit;
 	}
 
 	if (!skb_cb->vif) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ah->hw, msdu);
 		goto exit;
 	}
 
-- 
2.34.1


