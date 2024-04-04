Return-Path: <linux-wireless+bounces-5874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27E8989BB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63BA290BB6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9D12A16B;
	Thu,  4 Apr 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SmWgXzpH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B094129A7D
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240187; cv=none; b=LfISzV3IVzsWFS9xzGxbqCfeUtF7wSoIXsxi0M86734CTx2NzfsvM8cMNZ5byAmOnyKid3dFa9tWsFw/z0uexDK1J3rPh5ckQsope74+dAEDIEwmaYMHri+f10vL/zdqoECJWbd2fpO6joRjYB+v/+yxrKU2mG3KuMvTHXx3Ht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240187; c=relaxed/simple;
	bh=BFuc2Lq4U5GQAYy5gLFSI1jQ3RyQD1warCOGb8JVO+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PAzr2xxbrbnHI1J7BDE/iGfAVE1Y3z51LOAvi1qnMjQogwk+R1+iJH/pB1DHwDdIRZlFJjNov3Rhuqx0rp88BAdpQqPgajN2OEz1NfVaMo6vVZMHe2eQdDpN5zvbXWC8nF9DJY5bwN5r6NTSMyQakTYcHZj2vZ2Bw5FLcxmHg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SmWgXzpH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434CpgpO019614;
	Thu, 4 Apr 2024 14:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=MJ5crcrRYqFS2u+k7JLRK7iWlhpCOd4410/QX1u009o=; b=Sm
	WgXzpHAAvY2fhMsRh+eeDhwkvK0wYQoMpIB0pxTZOvl+3c1lJebqU9+MgzguSNYL
	xtP35d0en2LzqQn5WnZKnso9bGsxlT3n7sI9Gql09CZn5mTjCtEfDHRfrxQDvOkq
	snMTROo6aD/uPOH3AWbt6gg6NIcxpRBJyPmgTqC8YVhUYlCtAeQsyIH0bNHatQlC
	aaZNgn98Esn7cH667rHddNT1ZRGv1FgebUrk0zd/muwFbe0DC3//NTA5MEz48xQe
	durA25g2HNIwSGSSrYNOGVIPy1hRj7zdUInkJJaQ8ojDSLHgMy1yYNqOrmWpGJ76
	OzDiHADAmzZd36xEJ0zQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en39nk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 14:16:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434EGJ3x022226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 14:16:19 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 07:16:17 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH v3] wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path
Date: Thu, 4 Apr 2024 19:45:38 +0530
Message-ID: <20240404141538.1277258-1-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f6YAOA-d9EM2JUNbFfv_FY4B9kp9PqUy
X-Proofpoint-ORIG-GUID: f6YAOA-d9EM2JUNbFfv_FY4B9kp9PqUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=460 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040098

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
v3:
 - email name change suggested by kalle 
v2:
 - Signed-off change 
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


