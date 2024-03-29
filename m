Return-Path: <linux-wireless+bounces-5526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7B891379
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 07:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65411F2277F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 06:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8499E39FD3;
	Fri, 29 Mar 2024 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H4o0G3UQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4037152
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692593; cv=none; b=OIz0/rOErq7GuOXw1N94fOyBRJ3ILhkOn3vu4gwqsmo1YMXPeRaEQOX98NwC1tBJzd+vU95tjw+dUynR5gDYwyBJUHJ0arjbF/T1cBgFTVCbyVYlk4JFeuFFvJaHqstkhFE3f8hy4JkH14XP40OZMssjT6Ad7El2GdlhMzCs2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692593; c=relaxed/simple;
	bh=SJpFMYiSeJUdaD7OlwC2Sh8HzriDt3hlSGApt30VYvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tSEqxu9/yYrg4105NvpIVcW3Sk7v9u7Mxrf2IyPcscf5ed+T4w/SCfwCim7TGbUypjKmCiuoppTmOKlLXqFF4id//ipcnnN/V61CzmVz8Yc+racadFDrWPolkbyse3KjFgcR0mW5QYSzT7J2rYAWq5Tp3NsxKbd7NmQrIjciOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H4o0G3UQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T5at90030814;
	Fri, 29 Mar 2024 06:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=IXvho23lrfCt0ozepxfht/vZqAr9mxHYBoAnEtSbwP0=; b=H4
	o0G3UQEiRIvfSwt4Mp9vbFa2MMlkbq6B4uqE7XlmKxJRTbpdr1O2JmHxycDli0d9
	KIflW16GaDWFuoUWt6YDnVet8cmR+0qVKV6SK6LzmRWqNdeIm7bSmHex5L3LNyvp
	/u/67VZ4LcWd8iSNaXmDc6EDmslKDX12rFd7jxEjKrDRteM7gab5Xw6eCSTizCTT
	X4Igj/aEnfrJDkK47G0u/FElxflLx63Mtv3+feX9NeQalbd0OjP7UCrq+yop+kVo
	7J1gR6eeGgWUGQPIFYqN8u08wXQdEbC0VGF4p7Q/AS+nj9rUgZmliDdOqpqYxP2v
	1pu/M18sXFCgzRiOsR2w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5qkwg3hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 06:09:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T69mo5022141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 06:09:48 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 23:09:45 -0700
From: Nithyanantham P <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path
Date: Fri, 29 Mar 2024 11:39:22 +0530
Message-ID: <20240329060922.677091-1-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TOmZXpflr0_em-jiwFu5C0n1ndpSGhii
X-Proofpoint-GUID: TOmZXpflr0_em-jiwFu5C0n1ndpSGhii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_05,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 mlxlogscore=422 impostorscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290050

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, in the rx error data path, mac id is extracted from the
last 64bits of MSDU end description tag for each entry received in
the WBM error ring. Then, each entry will be updated into the MSDU
list for further processing. The extracted mac id is valid when a
single MSDU is not fragmented and received in the WBM error ring.

In scenarios where the size of a single MSDU received exceeds the
descriptor buffer size, resulting in fragmented or spillover MSDU
entries into the WBM error ring. In this case, the extracted mac id
from each spillover entry is invalid except the last spillover entry
of the MSDU. This invalid mac id leads to packet rejection.

To address this issue, check if the MSDU continuation flag is set,
then extract the valid mac id from the last spillover entry.
Propagate the valid mac id to all the spillover entries of the single
MSDU in the temporary MSDU list(scatter_msdu_list). Then, update this
into the MSDU list (msdu_list) for further processing.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 60 +++++++++++++++++++++----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index a593beecdd12..b1b50e14a492 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -239,6 +239,14 @@ static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_base *ab,
 	return ab->hal_rx_ops->rx_desc_get_msdu_src_link_id(desc);
 }
 
+static void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
+{
+	struct sk_buff *skb;
+
+	while ((skb = __skb_dequeue(skb_list)))
+		dev_kfree_skb_any(skb);
+}
+
 static int ath12k_dp_purge_mon_ring(struct ath12k_base *ab)
 {
 	int i, reaped = 0;
@@ -3742,19 +3750,20 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 	struct hal_rx_wbm_rel_info err_info;
 	struct hal_srng *srng;
 	struct sk_buff *msdu;
-	struct sk_buff_head msdu_list;
+	struct sk_buff_head msdu_list, scatter_msdu_list;
 	struct ath12k_skb_rxcb *rxcb;
 	void *rx_desc;
 	u8 mac_id;
 	int num_buffs_reaped = 0;
 	struct ath12k_rx_desc_info *desc_info;
 	int ret, pdev_id;
+	struct hal_rx_desc *msdu_data;
 
 	__skb_queue_head_init(&msdu_list);
+	__skb_queue_head_init(&scatter_msdu_list);
 
 	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
 	rx_ring = &dp->rx_refill_buf_ring;
-
 	spin_lock_bh(&srng->lock);
 
 	ath12k_hal_srng_access_begin(ab, srng);
@@ -3807,16 +3816,50 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 			continue;
 		}
 
+		msdu_data = (struct hal_rx_desc *)msdu->data;
 		rxcb->err_rel_src = err_info.err_rel_src;
 		rxcb->err_code = err_info.err_code;
-		rxcb->rx_desc = (struct hal_rx_desc *)msdu->data;
-
-		__skb_queue_tail(&msdu_list, msdu);
-
 		rxcb->is_first_msdu = err_info.first_msdu;
 		rxcb->is_last_msdu = err_info.last_msdu;
 		rxcb->is_continuation = err_info.continuation;
+		rxcb->rx_desc = msdu_data;
+
+		if (err_info.continuation) {
+			__skb_queue_tail(&scatter_msdu_list, msdu);
+		} else {
+			mac_id = ath12k_dp_rx_get_msdu_src_link(ab,
+								msdu_data);
+			if (mac_id >= MAX_RADIOS) {
+				dev_kfree_skb_any(msdu);
+
+				/* In any case continuation bit is set
+				 * in the previous record, cleanup scatter_msdu_list
+				 */
+				ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
+				continue;
+			}
+
+			if (!skb_queue_empty(&scatter_msdu_list)) {
+				struct sk_buff *msdu;
+
+				skb_queue_walk(&scatter_msdu_list, msdu) {
+					rxcb = ATH12K_SKB_RXCB(msdu);
+					rxcb->mac_id = mac_id;
+				}
+
+				skb_queue_splice_tail_init(&scatter_msdu_list,
+							   &msdu_list);
+			}
+
+			rxcb = ATH12K_SKB_RXCB(msdu);
+			rxcb->mac_id = mac_id;
+			__skb_queue_tail(&msdu_list, msdu);
+		}
 	}
+	/* In any case continuation bit is set in the
+	 * last record, cleanup scatter_msdu_list
+	 */
+	ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
 
 	ath12k_hal_srng_access_end(ab, srng);
 
@@ -3830,8 +3873,9 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 
 	rcu_read_lock();
 	while ((msdu = __skb_dequeue(&msdu_list))) {
-		mac_id = ath12k_dp_rx_get_msdu_src_link(ab,
-							(struct hal_rx_desc *)msdu->data);
+		rxcb = ATH12K_SKB_RXCB(msdu);
+		mac_id = rxcb->mac_id;
+
 		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
 		ar = ab->pdevs[pdev_id].ar;
 

base-commit: fe7e1b830cf3c0272aa4eaf367c4c7b29c169c3d
-- 
2.17.1


