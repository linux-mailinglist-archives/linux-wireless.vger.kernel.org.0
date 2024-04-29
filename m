Return-Path: <linux-wireless+bounces-6967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9308B5254
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 09:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF6D1F21A91
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3AD13AEE;
	Mon, 29 Apr 2024 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OuoKULnb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB5134DE
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375662; cv=none; b=KxatvyHGyjYICKe5mC3Rud2RqtT0j46zprjfAgVmZPXimBYtepXfNwNbzUjOUc3AGchMHIU+DFwbCftbltD4bCIIeWwiFMJIFlEdoR4g4W+dc5wTIjm7277Hx8hLdgh0pYDFS5vqNk1kheIvElKLVYNxwmjliktrYvEls9XX3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375662; c=relaxed/simple;
	bh=vDZ3iizoQzk+FdPTfdnyaL1qvKTvSJ0C1qBvMQvtV0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AEwoPjAznQd+Tu6UmlpD/KsQ7dbVE44tTqeeWcPs9Fjw33zmzUP0a/gKvfTdtGUbyajaDvvde2av2jDzuAM7BJYLYsugdWuBepIAMBmSxP0D1EeWgg/razM9sC/nfph/Cu/RWFVHewd7QYAf5V7RzQVarJd9Mfz1G6qrl7qknzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OuoKULnb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T5L8Hp024225;
	Mon, 29 Apr 2024 07:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Qb3/qj8
	BDdjM2l978ZwujkPeSakWiXeuXcjnYbqnHtE=; b=OuoKULnblweFYDjf9fuamAj
	uFAtKuJ+ZJORtXN6u1xHT/ELxSDqb5OyTFMjgsNvnIDKEeGomX4MqIFy1K4llzHA
	MVG6OhhGPOJH932bO3QLcLGO9AY1jL/Rz0heE7AAuqtmugOb1uREqGzQ9kCXMaY2
	GwSPWXlskMZ+TbwY7FoDiC2l+IIxarLDizvwQr1oo1KIbor9PilF5gGlckO5+YT4
	1qhlRTOIaix4erJ7lcjA6u52L+sQK7GZtyIOuVbXI/7KuAVZmjE8kDo7AVBVOTct
	E5m1+An5ADcMurU0iM9d8cUvoAxKKLEoBp795MmSV95phsYBEG9ZJxm9M/MBvGQ=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrthtax3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:27:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T7RbHs020134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:27:37 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 00:27:35 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty
	<quic_vnaralas@quicinc.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCHv4] wifi: ath11k: skip status ring entry processing
Date: Mon, 29 Apr 2024 12:57:23 +0530
Message-ID: <20240429072723.712841-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cZm5ZGuEdnQE80NE20GK7CWGW2m8OWvY
X-Proofpoint-GUID: cZm5ZGuEdnQE80NE20GK7CWGW2m8OWvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_04,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=719 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290047

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

If STATUS_BUFFER_DONE is not set for a monitor status ring entry,
we don't process the status ring until STATUS_BUFFER_DONE set
for that status ring entry.

During LMAC reset it may happen that hardware will not write
STATUS_BUFFER_DONE tlv in status buffer, in that case we end up
waiting for STATUS_BUFFER_DONE leading to backpressure on monitor
status ring.

To fix the issue, when HP(Head Pointer) + 1 entry is peeked and if DMA
is not done and if HP + 2 entry's DMA done is set,
replenish HP + 1 entry and start processing in next interrupt.
If HP + 2 entry's DMA done is not set, poll onto HP + 1 entry DMA
done to be set.

Also, during monitor attach HP points to the end of the ring and
TP(Tail Pointer) points to the start of the ring.
Using ath11k_hal_srng_src_peek() may result in processing invalid buffer
for the very first interrupt. Since, HW starts writing buffer from TP.

To avoid this issue call ath11k_hal_srng_src_next_peek() instead of
calling ath11k_hal_srng_src_peek().

Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
v4:
  * Removed kernel reported compilation warning from Signed off place
v3:
  * Rebased on top of ToT
v2:
  * Fixed compilation warning Reported-by: kernel test robot <lkp@intel.com>

 drivers/net/wireless/ath/ath11k/dp_rx.c | 88 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/hal.c   | 14 ++++
 drivers/net/wireless/ath/ath11k/hal.h   |  2 +
 3 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index afd481f5858f..79b7f4996f5d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2990,11 +2990,52 @@ ath11k_dp_rx_mon_update_status_buf_state(struct ath11k_mon_data *pmon,
 	}
 }
 
+static enum dp_mon_status_buf_state
+ath11k_dp_rx_mon_handle_status_buf_done(struct ath11k_base *ab, struct hal_srng *srng,
+					struct dp_rxdma_ring *rx_ring)
+{
+	struct ath11k_skb_rxcb *rxcb;
+	struct hal_tlv_hdr *tlv;
+	struct sk_buff *skb;
+	void *status_desc;
+	dma_addr_t paddr;
+	u32 cookie;
+	int buf_id;
+	u8 rbm;
+
+	status_desc = ath11k_hal_srng_src_next_peek(ab, srng);
+	if (!status_desc)
+		return DP_MON_STATUS_NO_DMA;
+
+	ath11k_hal_rx_buf_addr_info_get(status_desc, &paddr, &cookie, &rbm);
+
+	buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID, cookie);
+
+	spin_lock_bh(&rx_ring->idr_lock);
+	skb = idr_find(&rx_ring->bufs_idr, buf_id);
+	spin_unlock_bh(&rx_ring->idr_lock);
+
+	if (!skb)
+		return DP_MON_STATUS_NO_DMA;
+
+	rxcb = ATH11K_SKB_RXCB(skb);
+	dma_sync_single_for_cpu(ab->dev, rxcb->paddr,
+				skb->len + skb_tailroom(skb),
+				DMA_FROM_DEVICE);
+
+	tlv = (struct hal_tlv_hdr *)skb->data;
+	if (FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl) != HAL_RX_STATUS_BUFFER_DONE)
+		return DP_MON_STATUS_NO_DMA;
+
+	return DP_MON_STATUS_REPLINISH;
+}
+
 static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 					     int *budget, struct sk_buff_head *skb_list)
 {
 	struct ath11k *ar;
 	const struct ath11k_hw_hal_params *hal_params;
+	enum dp_mon_status_buf_state reap_status;
 	struct ath11k_pdev_dp *dp;
 	struct dp_rxdma_ring *rx_ring;
 	struct ath11k_mon_data *pmon;
@@ -3022,8 +3063,7 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 	ath11k_hal_srng_access_begin(ab, srng);
 	while (*budget) {
 		*budget -= 1;
-		rx_mon_status_desc =
-			ath11k_hal_srng_src_peek(ab, srng);
+		rx_mon_status_desc = ath11k_hal_srng_src_peek(ab, srng);
 		if (!rx_mon_status_desc) {
 			pmon->buf_state = DP_MON_STATUS_REPLINISH;
 			break;
@@ -3057,15 +3097,43 @@ static int ath11k_dp_rx_reap_mon_status_ring(struct ath11k_base *ab, int mac_id,
 				ath11k_warn(ab, "mon status DONE not set %lx, buf_id %d\n",
 					    FIELD_GET(HAL_TLV_HDR_TAG,
 						      tlv->tl), buf_id);
-				/* If done status is missing, hold onto status
-				 * ring until status is done for this status
-				 * ring buffer.
-				 * Keep HP in mon_status_ring unchanged,
-				 * and break from here.
-				 * Check status for same buffer for next time
+				/* RxDMA status done bit might not be set even
+				 * though tp is moved by HW.
 				 */
-				pmon->buf_state = DP_MON_STATUS_NO_DMA;
-				break;
+
+				/* If done status is missing:
+				 * 1. As per MAC team's suggestion,
+				 *    when HP + 1 entry is peeked and if DMA
+				 *    is not done and if HP + 2 entry's DMA done
+				 *    is set. skip HP + 1 entry and
+				 *    start processing in next interrupt.
+				 * 2. If HP + 2 entry's DMA done is not set,
+				 *    poll onto HP + 1 entry DMA done to be set.
+				 *    Check status for same buffer for next time
+				 *    dp_rx_mon_status_srng_process
+				 */
+
+				reap_status = ath11k_dp_rx_mon_handle_status_buf_done(ab, srng,
+										      rx_ring);
+				if (reap_status == DP_MON_STATUS_NO_DMA) {
+					continue;
+				} else if (reap_status == DP_MON_STATUS_REPLINISH) {
+					ath11k_warn(ab, "mon status DONE not set %lx, buf_id %d\n",
+						    FIELD_GET(HAL_TLV_HDR_TAG, tlv->tl),
+						    buf_id);
+
+					spin_lock_bh(&rx_ring->idr_lock);
+					idr_remove(&rx_ring->bufs_idr, buf_id);
+					spin_unlock_bh(&rx_ring->idr_lock);
+
+					dma_unmap_single(ab->dev, rxcb->paddr,
+							 skb->len + skb_tailroom(skb),
+							 DMA_FROM_DEVICE);
+
+					dev_kfree_skb_any(skb);
+					pmon->buf_state = DP_MON_STATUS_REPLINISH;
+					goto move_next;
+				}
 			}
 
 			spin_lock_bh(&rx_ring->idr_lock);
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index f3d04568c221..dbba45c22dc6 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -796,6 +796,20 @@ u32 *ath11k_hal_srng_src_get_next_reaped(struct ath11k_base *ab,
 	return desc;
 }
 
+u32 *ath11k_hal_srng_src_next_peek(struct ath11k_base *ab, struct hal_srng *srng)
+{
+	u32 next_hp;
+
+	lockdep_assert_held(&srng->lock);
+
+	next_hp = (srng->u.src_ring.hp + srng->entry_size) % srng->ring_size;
+
+	if (next_hp != srng->u.src_ring.cached_tp)
+		return srng->ring_base_vaddr + next_hp;
+
+	return NULL;
+}
+
 u32 *ath11k_hal_srng_src_peek(struct ath11k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index e453c137385e..dc8bbe073017 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -947,6 +947,8 @@ u32 *ath11k_hal_srng_dst_peek(struct ath11k_base *ab, struct hal_srng *srng);
 int ath11k_hal_srng_dst_num_free(struct ath11k_base *ab, struct hal_srng *srng,
 				 bool sync_hw_ptr);
 u32 *ath11k_hal_srng_src_peek(struct ath11k_base *ab, struct hal_srng *srng);
+u32 *ath11k_hal_srng_src_next_peek(struct ath11k_base *ab,
+				   struct hal_srng *srng);
 u32 *ath11k_hal_srng_src_get_next_reaped(struct ath11k_base *ab,
 					 struct hal_srng *srng);
 u32 *ath11k_hal_srng_src_reap_next(struct ath11k_base *ab,

base-commit: bf99bc7423e18aa3475ef00a7a6fb773c31ce6df
-- 
2.34.1


