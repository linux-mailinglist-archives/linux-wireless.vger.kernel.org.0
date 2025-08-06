Return-Path: <linux-wireless+bounces-26172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7186B1C4B9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 13:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FBA1886FC1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF43AC1C;
	Wed,  6 Aug 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSgNX3Tc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0B23B605
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479090; cv=none; b=ME++vjezCLmXs3VBXdwhBofqOhVsLOCLllHQGYQmBy9T8eaZiIwc3xaiCmu6z94djt4zNuhg2TtkBVtKrhEgHfPFfXf3CelaHqjbDepOwJ+Ce30pH8fqnJjn1ift0p+HMp43Oma7YaUVsnjoWZ9SQfiM0jZUl3TtzI6Hxb3RgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479090; c=relaxed/simple;
	bh=QbkrFSHRG/MrZAu+d2ZncqO7ZjHmmGa8hfkIjYe3h3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRuzLUEXl/AoH8uwmS0oaNQ7vcJIfBW/i3o+2I7CiQWmy5rOErzOFFfiEws58JCCzCxCB5L8qBOmN6pviJiT0BDXUHI4p2Y220TLeTJr9J9tKmqhr60dH0vDY6Zcn6H8uFK7OxUSjYnKf4L9CX+h/qsvJgwuk+bPWtpfEVOTtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSgNX3Tc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765Fk5A020222
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 11:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uOMsl6jT7rkoyahXCKAukm9qtoPnbV3yJfbpBKFhuSg=; b=NSgNX3TcujLhl+Sj
	dVZhrtKspO2SanSARNV+8u0ZnoOykYhCN6C87ILvE8vL0Q4Aklm8jMC3eUzkT3j+
	jmytBiQKF3dufhDgqB3F/E2+3Gw2kbDrnDyNLDZ9Yom/0elCGubNoISEBwE8vZFC
	pVIKzzUFkglZvt9FumdZRh8f/pTaPg6NDj1gKZ+FLFo+exxyUWd5z1Ozlxvxy781
	ixGs9QFb1yS5977GowLWyTzRV3Rzb17I5H3yl74k+/yUjy1gD9epy6/+67p2cOOX
	0vEtodBYjBDuFoyO1qwpI6wf6d0OxKT3BRgyOqvqOJ/IVrNy46aTbQ9yanXQvGGU
	rGBngA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1ahta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 11:18:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2c36951518so8909634a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 04:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479087; x=1755083887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOMsl6jT7rkoyahXCKAukm9qtoPnbV3yJfbpBKFhuSg=;
        b=vJsmuLTtW/MMdh8OFTv+DHuRIS09+hgERT9hvckTw/y9hKAX4NWFuy3qU2IpDwGxX5
         UMwLwODezg2D4XNXCnGrTZDPy0OIu9U2plojvzqxwlkbTfrb15SKz9cGYhsAO4OCwv/o
         S02xAzrKE/QP5XnCa6zBzknaTNmrvcUyoFl4yhpQnCsSJE1M0yrKFTVo3W8jVg5nqZ41
         VPeQ/prUFHY8+ywuHqlEQkY0OnCAF4riCVKGEdBWowA4zG8XbTtaDVBDpLobWsGcQSYm
         A22iwgIakBPwDU6jdO6XA89c24FxSkYpCD+hub/Y3Ld1PUG5pkq4EN5OjTxTp17GgYKr
         vfqg==
X-Gm-Message-State: AOJu0YyQ5jZLbIWv5B34zaNp7pAHGK6U1sv2cRqpQt1ebJ+ErKFB5uwi
	eiCQFIke/MeDYORJtNPJAXFhIZNyA7xDrBxt2wKHuWnAGMIuLq863VAGOfd3Z+60t4l7aIvQre2
	98hyB/gRnxHt0aKLan1K5mZKnQAr3pPsUHErX07ZGaHRYsIZakuaXY9SfVEQx7xTSkMD1rw==
X-Gm-Gg: ASbGncvlSqYTVjc6ip0+QumntFrRn2t2kB23WpuW+Q72O74qSzUKCNdIU38r4epwzlu
	qrviaSQ/TN2TzoeKR8OJaKhe0mNZWJDB7RsnufoBWrTVCz2RyWI9P8cc+SFsJtyHO/6kHDmA0ni
	Q3qR8321q2nlv6Np1zh5xDUA4dHOQ267VEx3+93wQrOJ+lDPUZTk/tjtv+zhjp2js62H8inevgy
	OgvnBuiRdz+8YvF18TOitNAT1tz3nN7ESEHpjAcLrMOBXLMzhJGB2YmrGLlPumb3ulssX+INEBj
	CIGzyAZuykyHeIv6hLI7r/UQGJ23ZJiimmizHwBwHuF1WJCpGL9m73gfpyeNvv9aqUipdwCJxP6
	EhZbzyHHooFNQBq6yN7Oq40BhYNXnbp5BAwy2iqtzGg/XGrQXhUwsOp0LA3DVfYaU00F4U7b6dg
	==
X-Received: by 2002:a05:6a21:32a1:b0:232:7628:9968 with SMTP id adf61e73a8af0-24031203937mr3742403637.1.1754479086596;
        Wed, 06 Aug 2025 04:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcK9ZWhZjDTWiOKh8SKRjgnlUUexbYnkmCB4iulX6pKzscfNhEIDLK5/0FLu3hHeAlth8Zdw==
X-Received: by 2002:a05:6a21:32a1:b0:232:7628:9968 with SMTP id adf61e73a8af0-24031203937mr3742358637.1.1754479086046;
        Wed, 06 Aug 2025 04:18:06 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9dafsm12984111a12.23.2025.08.06.04.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:18:05 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-current 5/7] wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures
Date: Wed,  6 Aug 2025 16:47:48 +0530
Message-Id: <20250806111750.3214584-6-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXyZbWpzoOFvAH
 psIxsg2M7ScoeinGAQvZB34tV8xJU4JFpQksuB4KyEptmJ2XYHCL6i65px+KZSWW0zrGQv+r+Op
 rJBRriYO7LXhZT55gpJ+tAwQPhZLX1q+/iBo3VURB5yKCjSDP3VQMSCmDP1zJU/1E7pnlsQ0715
 LzFrWS/+4TeDL/3VA7WmlcGokQFfChS8tJLMWbTrh0tptryvomyMjp8tSpzOYxW2CbDJAlTJyEB
 9x+29q/Lc7KB5nPsctZwPBqkj6h/bZ1KvGkPLRHOJWJqQI/N7gXVe9Z1yzTgw7Ec5CTINN4rIj+
 0VgkzY0+WLpuCCHY/YPLW0r1ZaLYrDlOJEFbmb0dBhIyR2CY/LXpVAVOdB95IDrWmibmCwWcxfE
 aUjvg9zD
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=689339f0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hy-VHpZSMFNzY5TzzOoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: PdO_tEirkOWvUIFfQsFYcekDeWgdtGdf
X-Proofpoint-GUID: PdO_tEirkOWvUIFfQsFYcekDeWgdtGdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>

During stress test scenarios, when the REO command ring becomes full,
the RX queue update command issued during peer deletion fails due to
insufficient space. In response, the host performs a dma_unmap and
frees the associated memory. However, the hardware still retains a
reference to the same memory address. If the kernel later reallocates
this address, unaware that the hardware is still using it, it can
lead to memory corruption-since the host might access or modify
memory that is still actively referenced by the hardware.

Implement a retry mechanism for the HAL_REO_CMD_UPDATE_RX_QUEUE
command during TID deletion to prevent memory corruption. Introduce
a new list, reo_cmd_update_rx_queue_list, in the struct ath12k_dp to
track pending RX queue updates. Protect this list with
reo_rxq_flush_lock, which also ensures synchronized access to
reo_cmd_cache_flush_list. Defer memory release until hardware
confirms the virtual address is no longer in use, avoiding immediate
deallocation on command failure. Release memory for pending RX queue
updates via ath12k_dp_rx_reo_cmd_list_cleanup() on system reset
if hardware confirmation is not received.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Co-developed-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    |   2 +
 drivers/net/wireless/ath/ath12k/dp.h    |  10 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c | 190 +++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/dp_rx.h |   8 +
 4 files changed, 150 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index f893fce6d9bd..4a54b8c35311 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1745,7 +1745,9 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 
 	INIT_LIST_HEAD(&dp->reo_cmd_list);
 	INIT_LIST_HEAD(&dp->reo_cmd_cache_flush_list);
+	INIT_LIST_HEAD(&dp->reo_cmd_update_rx_queue_list);
 	spin_lock_init(&dp->reo_cmd_lock);
+	spin_lock_init(&dp->reo_rxq_flush_lock);
 
 	dp->reo_cmd_cache_flush_count = 0;
 	dp->idle_link_rbm = ath12k_dp_get_idle_link_rbm(ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 10093b451588..4ffec6ad7d8d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -389,15 +389,19 @@ struct ath12k_dp {
 	struct dp_srng reo_dst_ring[DP_REO_DST_RING_MAX];
 	struct dp_tx_ring tx_ring[DP_TCL_NUM_RING_MAX];
 	struct hal_wbm_idle_scatter_list scatter_list[DP_IDLE_SCATTER_BUFS_MAX];
-	struct list_head reo_cmd_list;
+	struct list_head reo_cmd_update_rx_queue_list;
 	struct list_head reo_cmd_cache_flush_list;
 	u32 reo_cmd_cache_flush_count;
-
 	/* protects access to below fields,
-	 * - reo_cmd_list
+	 * - reo_cmd_update_rx_queue_list
 	 * - reo_cmd_cache_flush_list
 	 * - reo_cmd_cache_flush_count
 	 */
+	spinlock_t reo_rxq_flush_lock;
+	struct list_head reo_cmd_list;
+	/* protects access to below fields,
+	 * - reo_cmd_list
+	 */
 	spinlock_t reo_cmd_lock;
 	struct ath12k_hp_update_timer reo_cmd_timer;
 	struct ath12k_hp_update_timer tx_ring_timer[DP_TCL_NUM_RING_MAX];
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index fbebc79024cf..9a62ef52cd6d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -608,14 +608,15 @@ void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 	struct ath12k_dp *dp = &ab->dp;
 	struct ath12k_dp_rx_reo_cmd *cmd, *tmp;
 	struct ath12k_dp_rx_reo_cache_flush_elem *cmd_cache, *tmp_cache;
+	struct dp_reo_update_rx_queue_elem *cmd_queue, *tmp_queue;
 
-	spin_lock_bh(&dp->reo_cmd_lock);
-	list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
-		list_del(&cmd->list);
-		ath12k_dp_rx_tid_cleanup(ab, &cmd->data.qbuf);
-		kfree(cmd);
+	spin_lock_bh(&dp->reo_rxq_flush_lock);
+	list_for_each_entry_safe(cmd_queue, tmp_queue, &dp->reo_cmd_update_rx_queue_list,
+				 list) {
+		list_del(&cmd_queue->list);
+		ath12k_dp_rx_tid_cleanup(ab, &cmd_queue->rx_tid.qbuf);
+		kfree(cmd_queue);
 	}
-
 	list_for_each_entry_safe(cmd_cache, tmp_cache,
 				 &dp->reo_cmd_cache_flush_list, list) {
 		list_del(&cmd_cache->list);
@@ -623,6 +624,14 @@ void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 		ath12k_dp_rx_tid_cleanup(ab, &cmd_cache->data.qbuf);
 		kfree(cmd_cache);
 	}
+	spin_unlock_bh(&dp->reo_rxq_flush_lock);
+
+	spin_lock_bh(&dp->reo_cmd_lock);
+	list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
+		list_del(&cmd->list);
+		ath12k_dp_rx_tid_cleanup(ab, &cmd->data.qbuf);
+		kfree(cmd);
+	}
 	spin_unlock_bh(&dp->reo_cmd_lock);
 }
 
@@ -724,6 +733,61 @@ static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
 	}
 }
 
+static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u16 tid)
+{
+	struct ath12k_reo_queue_ref *qref;
+	struct ath12k_dp *dp = &ab->dp;
+	bool ml_peer = false;
+
+	if (!ab->hw_params->reoq_lut_support)
+		return;
+
+	if (peer_id & ATH12K_PEER_ML_ID_VALID) {
+		peer_id &= ~ATH12K_PEER_ML_ID_VALID;
+		ml_peer = true;
+	}
+
+	if (ml_peer)
+		qref = (struct ath12k_reo_queue_ref *)dp->ml_reoq_lut.vaddr +
+				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
+	else
+		qref = (struct ath12k_reo_queue_ref *)dp->reoq_lut.vaddr +
+				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
+
+	qref->info0 = u32_encode_bits(0, BUFFER_ADDR_INFO0_ADDR);
+	qref->info1 = u32_encode_bits(0, BUFFER_ADDR_INFO1_ADDR) |
+		      u32_encode_bits(tid, DP_REO_QREF_NUM);
+}
+
+static void ath12k_dp_rx_process_reo_cmd_update_rx_queue_list(struct ath12k_dp *dp)
+{
+	struct ath12k_base *ab = dp->ab;
+	struct dp_reo_update_rx_queue_elem *elem, *tmp;
+
+	spin_lock_bh(&dp->reo_rxq_flush_lock);
+
+	list_for_each_entry_safe(elem, tmp, &dp->reo_cmd_update_rx_queue_list, list) {
+		if (elem->rx_tid.active)
+			continue;
+
+		if (ath12k_dp_rx_tid_delete_handler(ab, &elem->rx_tid))
+			break;
+
+		ath12k_peer_rx_tid_qref_reset(ab,
+					      elem->is_ml_peer ? elem->ml_peer_id :
+					      elem->peer_id,
+					      elem->rx_tid.tid);
+
+		if (ab->hw_params->reoq_lut_support)
+			ath12k_hal_reo_shared_qaddr_cache_clear(ab);
+
+		list_del(&elem->list);
+		kfree(elem);
+	}
+
+	spin_unlock_bh(&dp->reo_rxq_flush_lock);
+}
+
 static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 				      enum hal_reo_cmd_status status)
 {
@@ -740,6 +804,13 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 		return;
 	}
 
+	/* Retry the HAL_REO_CMD_UPDATE_RX_QUEUE command for entries
+	 * in the pending queue list marked TID as inactive
+	 */
+	spin_lock_bh(&dp->ab->base_lock);
+	ath12k_dp_rx_process_reo_cmd_update_rx_queue_list(dp);
+	spin_unlock_bh(&dp->ab->base_lock);
+
 	elem = kzalloc(sizeof(*elem), GFP_ATOMIC);
 	if (!elem)
 		goto free_desc;
@@ -747,7 +818,7 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 	elem->ts = jiffies;
 	memcpy(&elem->data, rx_tid, sizeof(*rx_tid));
 
-	spin_lock_bh(&dp->reo_cmd_lock);
+	spin_lock_bh(&dp->reo_rxq_flush_lock);
 	list_add_tail(&elem->list, &dp->reo_cmd_cache_flush_list);
 	dp->reo_cmd_cache_flush_count++;
 
@@ -759,23 +830,11 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 			       msecs_to_jiffies(ATH12K_DP_RX_REO_DESC_FREE_TIMEOUT_MS))) {
 			list_del(&elem->list);
 			dp->reo_cmd_cache_flush_count--;
-
-			/* Unlock the reo_cmd_lock before using ath12k_dp_reo_cmd_send()
-			 * within ath12k_dp_reo_cache_flush. The reo_cmd_cache_flush_list
-			 * is used in only two contexts, one is in this function called
-			 * from napi and the other in ath12k_dp_free during core destroy.
-			 * Before dp_free, the irqs would be disabled and would wait to
-			 * synchronize. Hence there wouldn’t be any race against add or
-			 * delete to this list. Hence unlock-lock is safe here.
-			 */
-			spin_unlock_bh(&dp->reo_cmd_lock);
-
 			ath12k_dp_reo_cache_flush(ab, &elem->data);
 			kfree(elem);
-			spin_lock_bh(&dp->reo_cmd_lock);
 		}
 	}
-	spin_unlock_bh(&dp->reo_cmd_lock);
+	spin_unlock_bh(&dp->reo_rxq_flush_lock);
 
 	return;
 free_desc:
@@ -827,57 +886,38 @@ static void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u
 	ath12k_hal_reo_shared_qaddr_cache_clear(ab);
 }
 
-static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u16 tid)
+static void ath12k_dp_mark_tid_as_inactive(struct ath12k_dp *dp, int peer_id, u8 tid)
 {
-	struct ath12k_reo_queue_ref *qref;
-	struct ath12k_dp *dp = &ab->dp;
-	bool ml_peer = false;
+	struct dp_reo_update_rx_queue_elem *elem;
+	struct ath12k_dp_rx_tid_rxq *rx_tid;
 
-	if (!ab->hw_params->reoq_lut_support)
-		return;
-
-	if (peer_id & ATH12K_PEER_ML_ID_VALID) {
-		peer_id &= ~ATH12K_PEER_ML_ID_VALID;
-		ml_peer = true;
+	spin_lock_bh(&dp->reo_rxq_flush_lock);
+	list_for_each_entry(elem, &dp->reo_cmd_update_rx_queue_list, list) {
+		if (elem->peer_id == peer_id) {
+			rx_tid = &elem->rx_tid;
+			if (rx_tid->tid == tid) {
+				rx_tid->active = false;
+				break;
+			}
+		}
 	}
-
-	if (ml_peer)
-		qref = (struct ath12k_reo_queue_ref *)dp->ml_reoq_lut.vaddr +
-				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
-	else
-		qref = (struct ath12k_reo_queue_ref *)dp->reoq_lut.vaddr +
-				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
-
-	qref->info0 = u32_encode_bits(0, BUFFER_ADDR_INFO0_ADDR);
-	qref->info1 = u32_encode_bits(0, BUFFER_ADDR_INFO1_ADDR) |
-		      u32_encode_bits(tid, DP_REO_QREF_NUM);
+	spin_unlock_bh(&dp->reo_rxq_flush_lock);
 }
 
 void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 				  struct ath12k_peer *peer, u8 tid)
 {
 	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
-	int ret;
-	struct ath12k_dp_rx_tid_rxq rx_tid_rxq;
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_dp *dp = &ab->dp;
 
 	if (!rx_tid->active)
 		return;
 
-	ath12k_dp_init_rx_tid_rxq(&rx_tid_rxq, rx_tid);
-
-	ret = ath12k_dp_rx_tid_delete_handler(ar->ab, &rx_tid_rxq);
-	if (ret) {
-		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
-			   tid, ret);
-		ath12k_dp_rx_tid_cleanup(ar->ab, &rx_tid->qbuf);
-	}
-
-	if (peer->mlo)
-		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->ml_id, tid);
-	else
-		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
-
 	rx_tid->active = false;
+
+	ath12k_dp_mark_tid_as_inactive(dp, peer->peer_id, tid);
+	ath12k_dp_rx_process_reo_cmd_update_rx_queue_list(dp);
 }
 
 int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
@@ -1042,6 +1082,29 @@ static int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab,
 	return 0;
 }
 
+static int ath12k_dp_prepare_reo_update_elem(struct ath12k_dp *dp,
+					     struct ath12k_peer *peer,
+					     struct ath12k_dp_rx_tid *rx_tid)
+{
+	struct dp_reo_update_rx_queue_elem *elem;
+
+	elem = kzalloc(sizeof(*elem), GFP_ATOMIC);
+	if (!elem)
+		return -ENOMEM;
+
+	elem->peer_id = peer->peer_id;
+	elem->is_ml_peer = peer->mlo;
+	elem->ml_peer_id = peer->ml_id;
+
+	ath12k_dp_init_rx_tid_rxq(&elem->rx_tid, rx_tid);
+
+	spin_lock_bh(&dp->reo_rxq_flush_lock);
+	list_add_tail(&elem->list, &dp->reo_cmd_update_rx_queue_list);
+	spin_unlock_bh(&dp->reo_rxq_flush_lock);
+
+	return 0;
+}
+
 int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id,
 				u8 tid, u32 ba_win_sz, u16 ssn,
 				enum hal_pn_type pn_type)
@@ -1122,6 +1185,19 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		return ret;
 	}
 
+	/* Pre-allocate the update_rxq_list for the corresponding tid
+	 * This will be used during the tid delete. The reason we are not
+	 * allocating during tid delete is that, if any alloc fail in update_rxq_list
+	 * we may not be able to delete the tid vaddr/paddr and may lead to leak
+	 */
+	ret = ath12k_dp_prepare_reo_update_elem(dp, peer, rx_tid);
+	if (ret) {
+		ath12k_warn(ab, "failed to alloc update_rxq_list for rx tid %u\n", tid);
+		ath12k_dp_rx_tid_cleanup(ab, &rx_tid->qbuf);
+		spin_unlock_bh(&ab->base_lock);
+		return ret;
+	}
+
 	paddr_aligned = rx_tid->qbuf.paddr_aligned;
 	if (ab->hw_params->reoq_lut_support) {
 		/* Update the REO queue LUT at the corresponding peer id
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index da2332236b77..69d0a36a91d8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -43,6 +43,14 @@ struct ath12k_dp_rx_reo_cache_flush_elem {
 	unsigned long ts;
 };
 
+struct dp_reo_update_rx_queue_elem {
+	struct list_head list;
+	struct ath12k_dp_rx_tid_rxq rx_tid;
+	int peer_id;
+	bool is_ml_peer;
+	u16 ml_peer_id;
+};
+
 struct ath12k_dp_rx_reo_cmd {
 	struct list_head list;
 	struct ath12k_dp_rx_tid_rxq data;
-- 
2.17.1


