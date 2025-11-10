Return-Path: <linux-wireless+bounces-28735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B28DBC45F6C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888764E790F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B78306D47;
	Mon, 10 Nov 2025 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hGrNhWq3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F4301010
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771049; cv=none; b=dRBz1kLtWdtPfbfVc7vHModRffqcUeZcd480ASZj/+mtq6aMsJqM5l3Z+eLMCcGcX53cESmmtDRHoanBQM9lAEdh/yrocyCeiiPmcmKv8LcoQugnukyt/ig89AyvRtMulHW2OzeYmPhlB43VnCW5ikC/fIw80AkOoo+vsZnmagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771049; c=relaxed/simple;
	bh=NGK+xg38L0anr1L6GZhLprp3WSlZVl9DDVGDls7/VCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7J2BZGe6GDUr0KpnhFo8U2JQOPOZC9D7Ih8CjHZHLw6wq8SNXlo3qFKtljoejKg7nyHL/vQ+X81uDbLV577vYj+B3xYitWFVIrUxodZ0geju4IpHUMW+MNXjZtIZWrvX4hfzm1rCBMk3UvgGTyPdrSqYL9guMLf7gugUesZ4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hGrNhWq3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6SdRq2408341;
	Mon, 10 Nov 2025 10:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8c+X9TI/ML8
	b0z6LUEgFF5Pr0cPcvlc7R+JxW1ClBPI=; b=hGrNhWq3cbkIyattJKY2EGpcLO0
	7wIAEGE8dYgIjqZB2llFWKFsngsX8aaCaxXxp9qw6D+O6YuZsJ/F/I/eOENIaj5k
	oXsmCKPbwDjaPgoMIHAsVnwV1l+lAAq6PWXWQqElyMr2ekPhO59yDXbGoC8nrm+v
	SdYOf1QkaHADqycMg7MhsdyztegnpFlFFXGJZRhQAiFNIOuiCTft5Pk1HRd7NtC2
	mFKLA3/DdlP3UObz+T67caWaWxIFZASD0RU7jJbu9enVgXKs50ino5tNLS3/ZeOd
	IWeXWUEXanC4j+rfsNqYR9GSmYnty9sYL5gnxs0AWxysQAfddvG9k63zMXw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd8sp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbHtc008068;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbH0c008043;
	Mon, 10 Nov 2025 10:37:17 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbH9P008039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:17 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id 7E1D93E5; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 01/12] wifi: ath12k: Move monitor ring processing to Wi-Fi 7 module
Date: Mon, 10 Nov 2025 16:07:02 +0530
Message-Id: <20251110103713.3484779-2-quic_aloksing@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UZzROdWHYRAN73oh_Vh0uCmyA_i55UvS
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911c061 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=7YMBjcVPhgqYNKEdh-kA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UZzROdWHYRAN73oh_Vh0uCmyA_i55UvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfX5fQqjisg5/Ub
 oH4MGW4GE35L6zrwyVYSwdNsiuyJpO4ZtvYUAgelYGoW4FgBx+Va3Zy/OY6tuQB2Augygv22k/E
 vocUMhIpOIWC1TDxBI9MCRsA48fvSgzt2wzGtYLcahHz2tEJwty3rv7YbWV2eRaANvVFvoyV1Rc
 cMOlCAN1uOSFvrr+AJqeiRGdcCzWH3nr6nBs3xhhV3HiKh4RCIabMLaE1opBVKMYfkwQWIlccHb
 MjWjlRjjAJVz8PwSr57AuppQIpmr2+uoVvRffpcSx/VI7OFCcdG1MZKpUfpxoTZc03pLUVKTwWW
 WojfFjUF1Dj+fUHIslvtF1f1n1C6aiMEihxq1WOygKUuntK7HZj09BiSyPSapKZKz8yU/Wge2DX
 BYCVfcITnqjJRArbh/6uSFdH2spkPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Separate Wi-Fi 7-specific monitor-mode processing from common
ath12k data path code to improve modularity.

Move monitor status ring processing to wifi7/dp_mon.c:
- ath12k_dp_mon_srng_process()
- __ath12k_dp_mon_process_ring()
- ath12k_dp_mon_process_ring()

Rename the above to use the ath12k_wifi7_ prefix and
export helper functions required by the ath12k_wifi7 module.
Update the Wi-Fi 7 module Makefile to build dp_mon.o.

No functional changes are intended; this is preparatory refactoring
to isolate Wi-Fi 7 monitor-mode code from shared ath12k code.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 256 ++----------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  19 +-
 .../net/wireless/ath/ath12k/wifi7/Makefile    |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  16 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   1 +
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 244 +++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/dp_mon.h    |  17 ++
 7 files changed, 305 insertions(+), 249 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 0533d8bf9c1c..5e2bf24d6b7e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2541,7 +2541,7 @@ ath12k_dp_mon_parse_rx_dest_tlv(struct ath12k_pdev_dp *dp_pdev,
 	return 0;
 }
 
-static enum hal_rx_mon_status
+enum hal_rx_mon_status
 ath12k_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev, struct ath12k_mon_data *pmon,
 			    struct sk_buff *skb)
 {
@@ -2592,6 +2592,7 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev, struct ath12k_mon_da
 
 	return hal_status;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_parse_rx_dest);
 
 enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
@@ -2619,6 +2620,7 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
 
 	return hal_status;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_parse_mon_status);
 
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_mon_ring *buf_ring,
@@ -2694,6 +2696,7 @@ int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 	spin_unlock_bh(&srng->lock);
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_buf_replenish);
 
 int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
 					struct dp_rxdma_mon_ring *rx_ring,
@@ -3490,8 +3493,8 @@ ath12k_dp_mon_rx_update_peer_rate_table_stats(struct ath12k_rx_peer_stats *rx_st
 	stats->rx_rate[bw_idx][gi_idx][nss_idx][mcs_idx] += len;
 }
 
-static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_dp_link_peer *peer,
-						  struct hal_rx_mon_ppdu_info *ppdu_info)
+void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_dp_link_peer *peer,
+					   struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	struct ath12k_rx_peer_stats *rx_stats = peer->peer_stats.rx_stats;
 	u32 num_msdu;
@@ -3598,6 +3601,7 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_dp_link_peer *pe
 	ath12k_dp_mon_rx_update_peer_rate_table_stats(rx_stats, ppdu_info,
 						      NULL, num_msdu);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_update_peer_su_stats);
 
 void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info)
 {
@@ -3646,6 +3650,7 @@ void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info)
 	}
 	ppdu_info->ldpc = 1;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_process_ulofdma);
 
 static void
 ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
@@ -3746,7 +3751,7 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k_base *ab,
 						      user_stats, num_msdu);
 }
 
-static void
+void
 ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
 				      struct hal_rx_mon_ppdu_info *ppdu_info)
 {
@@ -3759,169 +3764,18 @@ ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
 	for (i = 0; i < num_users; i++)
 		ath12k_dp_mon_rx_update_user_stats(ab, ppdu_info, i);
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_update_peer_mu_stats);
 
-static void
+void
 ath12k_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 {
 	memset(ppdu_info, 0, sizeof(*ppdu_info));
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_memset_ppdu_info);
 
-int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
-			       struct napi_struct *napi)
-{
-	struct ath12k_dp *dp = pdev_dp->dp;
-	struct ath12k_base *ab = dp->ab;
-	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&pdev_dp->mon_data;
-	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	struct hal_mon_dest_desc *mon_dst_desc;
-	struct sk_buff *skb;
-	struct ath12k_skb_rxcb *rxcb;
-	struct dp_srng *mon_dst_ring;
-	struct hal_srng *srng;
-	struct dp_rxdma_mon_ring *buf_ring;
-	struct ath12k_dp_link_peer *peer;
-	struct sk_buff_head skb_list;
-	u64 cookie;
-	int num_buffs_reaped = 0, srng_id, buf_id;
-	u32 hal_status, end_offset, info0, end_reason;
-	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, pdev_dp->mac_id);
-
-	__skb_queue_head_init(&skb_list);
-	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, pdev_idx);
-	mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
-	buf_ring = &dp->rxdma_mon_buf_ring;
-
-	srng = &ab->hal.srng_list[mon_dst_ring->ring_id];
-	spin_lock_bh(&srng->lock);
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	while (likely(*budget)) {
-		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
-		if (unlikely(!mon_dst_desc))
-			break;
-
-		/* In case of empty descriptor, the cookie in the ring descriptor
-		 * is invalid. Therefore, this entry is skipped, and ring processing
-		 * continues.
-		 */
-		info0 = le32_to_cpu(mon_dst_desc->info0);
-		if (u32_get_bits(info0, HAL_MON_DEST_INFO0_EMPTY_DESC))
-			goto move_next;
-
-		cookie = le32_to_cpu(mon_dst_desc->cookie);
-		buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
-
-		spin_lock_bh(&buf_ring->idr_lock);
-		skb = idr_remove(&buf_ring->bufs_idr, buf_id);
-		spin_unlock_bh(&buf_ring->idr_lock);
-
-		if (unlikely(!skb)) {
-			ath12k_warn(ab, "monitor destination with invalid buf_id %d\n",
-				    buf_id);
-			goto move_next;
-		}
-
-		rxcb = ATH12K_SKB_RXCB(skb);
-		dma_unmap_single(ab->dev, rxcb->paddr,
-				 skb->len + skb_tailroom(skb),
-				 DMA_FROM_DEVICE);
-
-		end_reason = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_REASON);
-
-		/* HAL_MON_FLUSH_DETECTED implies that an rx flush received at the end of
-		 * rx PPDU and HAL_MON_PPDU_TRUNCATED implies that the PPDU got
-		 * truncated due to a system level error. In both the cases, buffer data
-		 * can be discarded
-		 */
-		if ((end_reason == HAL_MON_FLUSH_DETECTED) ||
-		    (end_reason == HAL_MON_PPDU_TRUNCATED)) {
-			ath12k_dbg(ab, ATH12K_DBG_DATA,
-				   "Monitor dest descriptor end reason %d", end_reason);
-			dev_kfree_skb_any(skb);
-			goto move_next;
-		}
-
-		/* Calculate the budget when the ring descriptor with the
-		 * HAL_MON_END_OF_PPDU to ensure that one PPDU worth of data is always
-		 * reaped. This helps to efficiently utilize the NAPI budget.
-		 */
-		if (end_reason == HAL_MON_END_OF_PPDU) {
-			*budget -= 1;
-			rxcb->is_end_of_ppdu = true;
-		}
-
-		end_offset = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_OFFSET);
-		if (likely(end_offset <= DP_RX_BUFFER_SIZE)) {
-			skb_put(skb, end_offset);
-		} else {
-			ath12k_warn(ab,
-				    "invalid offset on mon stats destination %u\n",
-				    end_offset);
-			skb_put(skb, DP_RX_BUFFER_SIZE);
-		}
-
-		__skb_queue_tail(&skb_list, skb);
-
-move_next:
-		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
-		ath12k_hal_srng_dst_get_next_entry(ab, srng);
-		num_buffs_reaped++;
-	}
-
-	ath12k_hal_srng_access_end(ab, srng);
-	spin_unlock_bh(&srng->lock);
-
-	if (!num_buffs_reaped)
-		return 0;
-
-	/* In some cases, one PPDU worth of data can be spread across multiple NAPI
-	 * schedules, To avoid losing existing parsed ppdu_info information, skip
-	 * the memset of the ppdu_info structure and continue processing it.
-	 */
-	if (!ppdu_info->ppdu_continuation)
-		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
-
-	while ((skb = __skb_dequeue(&skb_list))) {
-		hal_status = ath12k_dp_mon_rx_parse_mon_status(pdev_dp, pmon, skb, napi);
-		if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
-			ppdu_info->ppdu_continuation = true;
-			dev_kfree_skb_any(skb);
-			continue;
-		}
-
-		if (ppdu_info->peer_id == HAL_INVALID_PEERID)
-			goto free_skb;
-
-		rcu_read_lock();
-		peer = ath12k_dp_link_peer_find_by_peerid(pdev_dp, ppdu_info->peer_id);
-		if (!peer || !peer->sta) {
-			ath12k_dbg(ab, ATH12K_DBG_DATA,
-				   "failed to find the peer with monitor peer_id %d\n",
-				   ppdu_info->peer_id);
-			goto next_skb;
-		}
-
-		if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-			ath12k_dp_mon_rx_update_peer_su_stats(peer, ppdu_info);
-		} else if ((ppdu_info->fc_valid) &&
-			   (ppdu_info->ast_index != HAL_AST_IDX_INVALID)) {
-			ath12k_dp_mon_rx_process_ulofdma(ppdu_info);
-			ath12k_dp_mon_rx_update_peer_mu_stats(ab, ppdu_info);
-		}
-
-next_skb:
-		rcu_read_unlock();
-free_skb:
-		dev_kfree_skb_any(skb);
-		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
-	}
-
-	return num_buffs_reaped;
-}
-
-static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
-					     int *budget, struct sk_buff_head *skb_list)
+int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
+				      int *budget, struct sk_buff_head *skb_list)
 {
 	const struct ath12k_hw_hal_params *hal_params;
 	int buf_id, srng_id, num_buffs_reaped = 0;
@@ -4064,6 +3918,7 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 
 	return num_buffs_reaped;
 }
+EXPORT_SYMBOL(ath12k_dp_rx_reap_mon_status_ring);
 
 static u32
 ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
@@ -4259,8 +4114,8 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
  */
 #define MON_DEST_RING_STUCK_MAX_CNT 16
 
-static void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
-					  u32 quota, struct napi_struct *napi)
+void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
+				   u32 quota, struct napi_struct *napi)
 {
 	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
 	struct ath12k_pdev_mon_stats *rx_mon_stats;
@@ -4361,79 +4216,4 @@ static void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
 					    rx_bufs_used);
 	}
 }
-
-static int
-__ath12k_dp_mon_process_ring(struct ath12k *ar, int mac_id,
-			     struct napi_struct *napi, int *budget)
-{
-	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
-	struct ath12k_pdev_mon_stats *rx_mon_stats = &pmon->rx_mon_stats;
-	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	enum hal_rx_mon_status hal_status;
-	struct sk_buff_head skb_list;
-	int num_buffs_reaped;
-	struct sk_buff *skb;
-
-	__skb_queue_head_init(&skb_list);
-
-	num_buffs_reaped = ath12k_dp_rx_reap_mon_status_ring(ar->ab, mac_id,
-							     budget, &skb_list);
-	if (!num_buffs_reaped)
-		goto exit;
-
-	while ((skb = __skb_dequeue(&skb_list))) {
-		memset(ppdu_info, 0, sizeof(*ppdu_info));
-		ppdu_info->peer_id = HAL_INVALID_PEERID;
-
-		hal_status = ath12k_dp_mon_parse_rx_dest(&ar->dp, pmon, skb);
-
-		if (ar->monitor_started &&
-		    pmon->mon_ppdu_status == DP_PPDU_STATUS_START &&
-		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
-			rx_mon_stats->status_ppdu_done++;
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			ath12k_dp_rx_mon_dest_process(ar, mac_id, *budget, napi);
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
-		}
-
-		dev_kfree_skb_any(skb);
-	}
-
-exit:
-	return num_buffs_reaped;
-}
-
-int ath12k_dp_mon_process_ring(struct ath12k_dp *dp, int mac_id,
-			       struct napi_struct *napi, int budget,
-			       enum dp_monitor_mode monitor_mode)
-{
-	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(dp->hw_params, mac_id);
-	struct ath12k_pdev_dp *dp_pdev;
-	struct ath12k *ar;
-	int num_buffs_reaped = 0;
-
-	rcu_read_lock();
-
-	dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
-	if (!dp_pdev) {
-		rcu_read_unlock();
-		return 0;
-	}
-
-	if (dp->hw_params->rxdma1_enable) {
-		if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
-			num_buffs_reaped = ath12k_dp_mon_srng_process(dp_pdev, &budget,
-								      napi);
-	} else {
-		ar = ath12k_pdev_dp_to_ar(dp_pdev);
-
-		if (ar->monitor_started)
-			num_buffs_reaped =
-				__ath12k_dp_mon_process_ring(ar, mac_id, napi, &budget);
-	}
-
-	rcu_read_unlock();
-
-	return num_buffs_reaped;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_process_ring);
+EXPORT_SYMBOL(ath12k_dp_rx_mon_dest_process);
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 3e6ff4b0a6d9..689d7a0fff5c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -89,9 +89,6 @@ int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
 					struct dp_rxdma_mon_ring *rx_ring,
 					int req_entries);
-int ath12k_dp_mon_process_ring(struct ath12k_dp *dp, int mac_id,
-			       struct napi_struct *napi, int budget,
-			       enum dp_monitor_mode monitor_mode);
 struct sk_buff *ath12k_dp_mon_tx_alloc_skb(void);
 enum dp_mon_tx_tlv_status
 ath12k_dp_mon_tx_status_get_num_user(u16 tlv_tag,
@@ -104,6 +101,18 @@ ath12k_dp_mon_tx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
 				  struct napi_struct *napi,
 				  u32 ppdu_id);
 void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info);
-int ath12k_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
-			       struct napi_struct *napi);
+enum hal_rx_mon_status
+ath12k_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev, struct ath12k_mon_data *pmon,
+			    struct sk_buff *skb);
+int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
+				      int *budget, struct sk_buff_head *skb_list);
+void ath12k_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
+				   u32 quota, struct napi_struct *napi);
+void
+ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
+				      struct hal_rx_mon_ppdu_info *ppdu_info);
+void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_dp_link_peer *peer,
+					   struct hal_rx_mon_ppdu_info *ppdu_info);
+void
+ath12k_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/Makefile b/drivers/net/wireless/ath/ath12k/wifi7/Makefile
index 30258a1b313d..dcfa732bb95b 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/Makefile
+++ b/drivers/net/wireless/ath/ath12k/wifi7/Makefile
@@ -11,6 +11,7 @@ ath12k_wifi7-y += core.o \
 		  dp_rx.o \
 		  dp_tx.o \
 		  dp.o \
+		  dp_mon.o \
 		  hal.o \
 		  hal_qcn9274.o \
 		  hal_wcn7850.o
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index 30c27e005ed8..0b2c7f37c756 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -9,6 +9,7 @@
 #include "../dp_tx.h"
 #include "hal_desc.h"
 #include "../dp_mon.h"
+#include "dp_mon.h"
 #include "../dp_cmn.h"
 #include "dp_rx.h"
 #include "dp.h"
@@ -66,8 +67,9 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 
 				if (ring_mask & BIT(id)) {
 					work_done =
-					ath12k_dp_mon_process_ring(dp, id, napi, budget,
-								   0);
+					ath12k_wifi7_dp_mon_process_ring(dp, id, napi,
+									 budget,
+									 0);
 					budget -= work_done;
 					tot_work_done += work_done;
 					if (budget <= 0)
@@ -86,8 +88,9 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 
 				if (ring_mask & BIT(id)) {
 					work_done =
-					ath12k_dp_mon_process_ring(dp, id, napi, budget,
-								   monitor_mode);
+					ath12k_wifi7_dp_mon_process_ring(dp, id, napi,
+									 budget,
+									 monitor_mode);
 					budget -= work_done;
 					tot_work_done += work_done;
 
@@ -107,8 +110,9 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 
 				if (ring_mask & BIT(id)) {
 					work_done =
-					ath12k_dp_mon_process_ring(dp, id, napi, budget,
-								   monitor_mode);
+					ath12k_wifi7_dp_mon_process_ring(dp, id,
+									 napi, budget,
+									 monitor_mode);
 					budget -= work_done;
 					tot_work_done += work_done;
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.h b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
index 72fdfb368c99..a5f0941d34e2 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
@@ -12,6 +12,7 @@
 
 struct ath12k_base;
 struct ath12k_dp;
+enum dp_monitor_mode;
 
 struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab);
 void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
new file mode 100644
index 000000000000..4135ff5e8759
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "hal_desc.h"
+#include "../dp_mon.h"
+#include "dp_mon.h"
+#include "../debug.h"
+#include "hal_qcn9274.h"
+#include "dp_rx.h"
+#include "../peer.h"
+
+static int
+__ath12k_wifi7_dp_mon_process_ring(struct ath12k *ar, int mac_id,
+				   struct napi_struct *napi, int *budget)
+{
+	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&ar->dp.mon_data;
+	struct ath12k_pdev_mon_stats *rx_mon_stats = &pmon->rx_mon_stats;
+	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
+	enum hal_rx_mon_status hal_status;
+	struct sk_buff_head skb_list;
+	int num_buffs_reaped;
+	struct sk_buff *skb;
+
+	__skb_queue_head_init(&skb_list);
+
+	num_buffs_reaped = ath12k_dp_rx_reap_mon_status_ring(ar->ab, mac_id,
+							     budget, &skb_list);
+	if (!num_buffs_reaped)
+		goto exit;
+
+	while ((skb = __skb_dequeue(&skb_list))) {
+		memset(ppdu_info, 0, sizeof(*ppdu_info));
+		ppdu_info->peer_id = HAL_INVALID_PEERID;
+
+		hal_status = ath12k_dp_mon_parse_rx_dest(&ar->dp, pmon, skb);
+
+		if (ar->monitor_started &&
+		    pmon->mon_ppdu_status == DP_PPDU_STATUS_START &&
+		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
+			rx_mon_stats->status_ppdu_done++;
+			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
+			ath12k_dp_rx_mon_dest_process(ar, mac_id, *budget, napi);
+			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+		}
+
+		dev_kfree_skb_any(skb);
+	}
+
+exit:
+	return num_buffs_reaped;
+}
+
+static int
+ath12k_wifi7_dp_mon_srng_process(struct ath12k_pdev_dp *pdev_dp, int *budget,
+				 struct napi_struct *napi)
+{
+	struct ath12k_dp *dp = pdev_dp->dp;
+	struct ath12k_base *ab = dp->ab;
+	struct ath12k_mon_data *pmon = (struct ath12k_mon_data *)&pdev_dp->mon_data;
+	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
+	struct hal_mon_dest_desc *mon_dst_desc;
+	struct sk_buff *skb;
+	struct ath12k_skb_rxcb *rxcb;
+	struct dp_srng *mon_dst_ring;
+	struct hal_srng *srng;
+	struct dp_rxdma_mon_ring *buf_ring;
+	struct ath12k_dp_link_peer *peer;
+	struct sk_buff_head skb_list;
+	u64 cookie;
+	int num_buffs_reaped = 0, srng_id, buf_id;
+	u32 hal_status, end_offset, info0, end_reason;
+	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, pdev_dp->mac_id);
+
+	__skb_queue_head_init(&skb_list);
+	srng_id = ath12k_hw_mac_id_to_srng_id(ab->hw_params, pdev_idx);
+	mon_dst_ring = &pdev_dp->rxdma_mon_dst_ring[srng_id];
+	buf_ring = &dp->rxdma_mon_buf_ring;
+
+	srng = &ab->hal.srng_list[mon_dst_ring->ring_id];
+	spin_lock_bh(&srng->lock);
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	while (likely(*budget)) {
+		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
+		if (unlikely(!mon_dst_desc))
+			break;
+
+		/* In case of empty descriptor, the cookie in the ring descriptor
+		 * is invalid. Therefore, this entry is skipped, and ring processing
+		 * continues.
+		 */
+		info0 = le32_to_cpu(mon_dst_desc->info0);
+		if (u32_get_bits(info0, HAL_MON_DEST_INFO0_EMPTY_DESC))
+			goto move_next;
+
+		cookie = le32_to_cpu(mon_dst_desc->cookie);
+		buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
+
+		spin_lock_bh(&buf_ring->idr_lock);
+		skb = idr_remove(&buf_ring->bufs_idr, buf_id);
+		spin_unlock_bh(&buf_ring->idr_lock);
+
+		if (unlikely(!skb)) {
+			ath12k_warn(ab, "monitor destination with invalid buf_id %d\n",
+				    buf_id);
+			goto move_next;
+		}
+
+		rxcb = ATH12K_SKB_RXCB(skb);
+		dma_unmap_single(ab->dev, rxcb->paddr,
+				 skb->len + skb_tailroom(skb),
+				 DMA_FROM_DEVICE);
+
+		end_reason = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_REASON);
+
+		/* HAL_MON_FLUSH_DETECTED implies that an rx flush received at the end of
+		 * rx PPDU and HAL_MON_PPDU_TRUNCATED implies that the PPDU got
+		 * truncated due to a system level error. In both the cases, buffer data
+		 * can be discarded
+		 */
+		if ((end_reason == HAL_MON_FLUSH_DETECTED) ||
+		    (end_reason == HAL_MON_PPDU_TRUNCATED)) {
+			ath12k_dbg(ab, ATH12K_DBG_DATA,
+				   "Monitor dest descriptor end reason %d", end_reason);
+			dev_kfree_skb_any(skb);
+			goto move_next;
+		}
+
+		/* Calculate the budget when the ring descriptor with the
+		 * HAL_MON_END_OF_PPDU to ensure that one PPDU worth of data is always
+		 * reaped. This helps to efficiently utilize the NAPI budget.
+		 */
+		if (end_reason == HAL_MON_END_OF_PPDU) {
+			*budget -= 1;
+			rxcb->is_end_of_ppdu = true;
+		}
+
+		end_offset = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_OFFSET);
+		if (likely(end_offset <= DP_RX_BUFFER_SIZE)) {
+			skb_put(skb, end_offset);
+		} else {
+			ath12k_warn(ab,
+				    "invalid offset on mon stats destination %u\n",
+				    end_offset);
+			skb_put(skb, DP_RX_BUFFER_SIZE);
+		}
+
+		__skb_queue_tail(&skb_list, skb);
+
+move_next:
+		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
+		ath12k_hal_srng_dst_get_next_entry(ab, srng);
+		num_buffs_reaped++;
+	}
+
+	ath12k_hal_srng_access_end(ab, srng);
+	spin_unlock_bh(&srng->lock);
+
+	if (!num_buffs_reaped)
+		return 0;
+
+	/* In some cases, one PPDU worth of data can be spread across multiple NAPI
+	 * schedules, To avoid losing existing parsed ppdu_info information, skip
+	 * the memset of the ppdu_info structure and continue processing it.
+	 */
+	if (!ppdu_info->ppdu_continuation)
+		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
+
+	while ((skb = __skb_dequeue(&skb_list))) {
+		hal_status = ath12k_dp_mon_rx_parse_mon_status(pdev_dp, pmon, skb, napi);
+		if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
+			ppdu_info->ppdu_continuation = true;
+			dev_kfree_skb_any(skb);
+			continue;
+		}
+
+		if (ppdu_info->peer_id == HAL_INVALID_PEERID)
+			goto free_skb;
+
+		rcu_read_lock();
+		peer = ath12k_dp_link_peer_find_by_peerid(pdev_dp, ppdu_info->peer_id);
+		if (!peer || !peer->sta) {
+			ath12k_dbg(ab, ATH12K_DBG_DATA,
+				   "failed to find the peer with monitor peer_id %d\n",
+				   ppdu_info->peer_id);
+			goto next_skb;
+		}
+
+		if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
+			ath12k_dp_mon_rx_update_peer_su_stats(peer, ppdu_info);
+		} else if ((ppdu_info->fc_valid) &&
+			   (ppdu_info->ast_index != HAL_AST_IDX_INVALID)) {
+			ath12k_dp_mon_rx_process_ulofdma(ppdu_info);
+			ath12k_dp_mon_rx_update_peer_mu_stats(ab, ppdu_info);
+		}
+
+next_skb:
+		rcu_read_unlock();
+free_skb:
+		dev_kfree_skb_any(skb);
+		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
+	}
+
+	return num_buffs_reaped;
+}
+
+int ath12k_wifi7_dp_mon_process_ring(struct ath12k_dp *dp, int mac_id,
+				     struct napi_struct *napi, int budget,
+				     enum dp_monitor_mode monitor_mode)
+{
+	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(dp->hw_params, mac_id);
+	struct ath12k_pdev_dp *dp_pdev;
+	struct ath12k *ar;
+	int num_buffs_reaped = 0;
+
+	rcu_read_lock();
+
+	dp_pdev = ath12k_dp_to_pdev_dp(dp, pdev_idx);
+	if (!dp_pdev) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	if (dp->hw_params->rxdma1_enable) {
+		if (monitor_mode == ATH12K_DP_RX_MONITOR_MODE)
+			num_buffs_reaped = ath12k_wifi7_dp_mon_srng_process(dp_pdev,
+									    &budget,
+									    napi);
+	} else {
+		ar = ath12k_pdev_dp_to_ar(dp_pdev);
+
+		if (ar->monitor_started)
+			num_buffs_reaped =
+				__ath12k_wifi7_dp_mon_process_ring(ar, mac_id, napi,
+								   &budget);
+	}
+
+	rcu_read_unlock();
+
+	return num_buffs_reaped;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
new file mode 100644
index 000000000000..3cf82864c41c
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_DP_MON_WIFI7_H
+#define ATH12K_DP_MON_WIFI7_H
+
+#include "hw.h"
+
+enum dp_monitor_mode;
+
+int ath12k_wifi7_dp_mon_process_ring(struct ath12k_dp *dp, int mac_id,
+				     struct napi_struct *napi, int budget,
+				     enum dp_monitor_mode monitor_mode);
+#endif
-- 
2.34.1


