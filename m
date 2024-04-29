Return-Path: <linux-wireless+bounces-6969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A688B5270
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 09:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B753E281DA7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 07:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25C14273;
	Mon, 29 Apr 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ES6sGDQs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F292134BF
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376202; cv=none; b=RVoAtAb1xFxAA2OXTPHUIb6Xny/odzDlWY45AkH21Ty4RSMYAjgx/3INKP5H9iPJFgD6Jij8vnWIA/r3s++uYd3yv5njme9/lGENJ2HSryCR+YPW+SfJkb+Yzl+3/mb7/g+pZ9vNaLNY2Khp+2GHT65nCforOZoUIxPXILw6v0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376202; c=relaxed/simple;
	bh=MY/uZ5Ju1C7wYB4lugJTm5Xq3y8CdFDHJ4bzb27UDtg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MZKxJsYXkDIxoOFLELHJlxjVrkKy1KuYS5u+anb/yr0anbsWhabquroRdbzkT/ZsJyqTJMlr7cMngThr2izX+ylfkSZNARS2E6F/AkeBczax2YIQem8wJaj3rykMY+FHq8X/j9iKcVItzUo3t3BoRe7BMHqakDor2YfCehW48Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ES6sGDQs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T5lO9h011455;
	Mon, 29 Apr 2024 07:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=aFeDMpM
	TO7LYMBAAOpVeWnz4ywTsiGmjjbhaDfsATek=; b=ES6sGDQsP60BVnS3nrrgQNL
	OA118KaS4bI1GGSAnoQ6zK7PX4oagvt/UgxQeuAl8C1hH0xyphOINpMe9TZVhYVK
	1pZdEhuCi/Bilm7NszXYq8hG1JSdbK7DTOKScnFHf3QGKVA6BCdp/4L5BJwCxy+W
	2ltNj5RzSK9TzVfZNPtaKqMQZjzk0aAVyAtwauONYGFmyE58UDbmDySNd+uu+tUk
	dAdVOLE3KgV6q8H11Xvbh3u4r5Ga+G3QVZl+09ut/CKanPdwZkIU1/vVZr5CFDwY
	sx/CNNiNBQPNwKM11hwcqjkimiH4uR+xlmlPLiSFbBSaOPMBA1QHi/KH0wXenLA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrt4ku067-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:36:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T7abDi002872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:36:37 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 00:36:35 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty
	<quic_vnaralas@quicinc.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCHv5] wifi: ath11k: skip status ring entry processing
Date: Mon, 29 Apr 2024 13:06:24 +0530
Message-ID: <20240429073624.736147-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: RaaYU4COtiL9AHZRojLd8MOfgTUgMAP0
X-Proofpoint-ORIG-GUID: RaaYU4COtiL9AHZRojLd8MOfgTUgMAP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_05,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=714
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290047

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
v5:
  * Updated copyright info in dp_rx.c and hal.c
v4:
  * Removed kernel reported compilation warning from Signed off place
v3:
  * Rebased on top of ToT
v2:
  * Fixed compilation warning Reported-by: kernel test robot <lkp@intel.com>

 drivers/net/wireless/ath/ath11k/dp_rx.c | 90 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/hal.c   | 16 ++++-
 drivers/net/wireless/ath/ath11k/hal.h   |  2 +
 3 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index afd481f5858f..e9919a2ef4fb 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/ieee80211.h>
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
index f3d04568c221..f02599bd1c36 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
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


