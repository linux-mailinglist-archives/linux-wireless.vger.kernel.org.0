Return-Path: <linux-wireless+bounces-21052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 808DAA78692
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71FF188AD85
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08211922C4;
	Wed,  2 Apr 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nxprH/wY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F871917E7;
	Wed,  2 Apr 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562008; cv=none; b=p1XAfl5fqUAzVFUBHZtiRidIdZ5F2zRjLNMJur9KQCClWF7fWkQDzrXsgK+F80e5/Ak38hwr6sKkA4OsUYZ8KmBuRsNNMcZTmQwX5VXAXiJ/HgW497SJQL5ZDwyyXmpDD9oMZDAcE0n3f/zRvzKd53amdB+Yhvc9tU6T9jfD4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562008; c=relaxed/simple;
	bh=Eh76cE0/xaWAKqXHicuP/PBAuJDLnIs9Z7AA3QtBoiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nZr0QgdpHPyFR0PfslpqywAC05+GSYbMUudawypm7jSBe1kEFriP6mzzAv8rHGB+BJMU26N06fAtcWqNta2FWyOtveVEosTEiVWSTgN3MUKfqpOc5CjEvTES5aeSA40D2THQjJff4iITXly/9iuiN+kuwK+q3bSD4VwQ2K7VvPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nxprH/wY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531L9Tgp030908;
	Wed, 2 Apr 2025 02:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cxdBpDJK/z/HCMp5QWmopwlzD+JEfXC+GjuZas1EiDg=; b=nxprH/wYiMh0uFeL
	W/rt1N6QVolr3645FvBxcaXzIZ+7e4aV+gaFAGREabEtC6Gqh3td8rfGiupp2gWf
	m3fNGZ9OU3SA/WtR19Dgi6PeZ2fsgAdZrYoDTx31QJyPk90zjRXRNNu77PYXgyde
	l8BVW2V3LNx643e8l2fwt7XadyaOc9Uk4p7tDit7f7ETPxE8rADcVHbku4Qa/Oro
	wgLZ0VWsK9YprV5fUUmVRvGdQ8nL6dCVBmcGf10ucdrtASfNVKxGXhKF8BpTkHZ8
	b+d5XY1In2WqHSOg0lGA1tGSeesvTD+J+ffO01Heqp1zWn7EIZnC2hfUnV+aPGpD
	lnjWwg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45recpj7xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:46:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322kOfx014647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:46:24 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:46:22 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 2 Apr 2025 10:45:45 +0800
Subject: [PATCH ath-next 6/9] wifi: ath12k: group REO queue buffer
 parameters together
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250402-ath12k-wcn7850-mlo-support-v1-6-bad47cf00704@quicinc.com>
References: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
In-Reply-To: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2frQHDvQJ1hUvYCqP1U_iknRMopfVEkd
X-Proofpoint-ORIG-GUID: 2frQHDvQJ1hUvYCqP1U_iknRMopfVEkd
X-Authority-Analysis: v=2.4 cv=J4Sq7BnS c=1 sm=1 tr=0 ts=67eca501 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=0q-2_rlK9mxEvylRaQwA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020017

Currently vaddr, paddr and size fields are located together with other
fields in ath12k_dp_rx_tid structure. Logically they represents the
REO queue buffer so better to group them in an individual structure.

Introduce a new structure ath12k_reoq_buf to group them. This improves
code readability, and benefits the upcoming patch where this structure
is heavily accessed.

While at it, change vaddr type to 'void *' since it is actually not
pointing to any u32 buffer. Also rename paddr as paddr_aligned to better
reflect its actual meaning.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 94 +++++++++++++++++----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h | 10 ++--
 2 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 66603e9c154b9036a8689053955cdbf53a1efe34..12313aa87e0747f3ea3dbaad50bb80b3a544d45f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -556,9 +556,9 @@ void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 	spin_lock_bh(&dp->reo_cmd_lock);
 	list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
 		list_del(&cmd->list);
-		dma_unmap_single(ab->dev, cmd->data.paddr,
-				 cmd->data.size, DMA_BIDIRECTIONAL);
-		kfree(cmd->data.vaddr);
+		dma_unmap_single(ab->dev, cmd->data.qbuf.paddr_aligned,
+				 cmd->data.qbuf.size, DMA_BIDIRECTIONAL);
+		kfree(cmd->data.qbuf.vaddr);
 		kfree(cmd);
 	}
 
@@ -566,9 +566,9 @@ void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 				 &dp->reo_cmd_cache_flush_list, list) {
 		list_del(&cmd_cache->list);
 		dp->reo_cmd_cache_flush_count--;
-		dma_unmap_single(ab->dev, cmd_cache->data.paddr,
-				 cmd_cache->data.size, DMA_BIDIRECTIONAL);
-		kfree(cmd_cache->data.vaddr);
+		dma_unmap_single(ab->dev, cmd_cache->data.qbuf.paddr_aligned,
+				 cmd_cache->data.qbuf.size, DMA_BIDIRECTIONAL);
+		kfree(cmd_cache->data.qbuf.vaddr);
 		kfree(cmd_cache);
 	}
 	spin_unlock_bh(&dp->reo_cmd_lock);
@@ -583,10 +583,10 @@ static void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
 		ath12k_warn(dp->ab, "failed to flush rx tid hw desc, tid %d status %d\n",
 			    rx_tid->tid, status);
 
-	dma_unmap_single(dp->ab->dev, rx_tid->paddr, rx_tid->size,
+	dma_unmap_single(dp->ab->dev, rx_tid->qbuf.paddr_aligned, rx_tid->qbuf.size,
 			 DMA_BIDIRECTIONAL);
-	kfree(rx_tid->vaddr);
-	rx_tid->vaddr = NULL;
+	kfree(rx_tid->qbuf.vaddr);
+	rx_tid->qbuf.vaddr = NULL;
 }
 
 static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
@@ -641,13 +641,13 @@ static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
 	unsigned long tot_desc_sz, desc_sz;
 	int ret;
 
-	tot_desc_sz = rx_tid->size;
+	tot_desc_sz = rx_tid->qbuf.size;
 	desc_sz = ath12k_hal_reo_qdesc_size(0, HAL_DESC_REO_NON_QOS_TID);
 
 	while (tot_desc_sz > desc_sz) {
 		tot_desc_sz -= desc_sz;
-		cmd.addr_lo = lower_32_bits(rx_tid->paddr + tot_desc_sz);
-		cmd.addr_hi = upper_32_bits(rx_tid->paddr);
+		cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned + tot_desc_sz);
+		cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
 					     HAL_REO_CMD_FLUSH_CACHE, &cmd,
 					     NULL);
@@ -658,8 +658,8 @@ static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
 	}
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
-	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
+	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
 	ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
 				     HAL_REO_CMD_FLUSH_CACHE,
@@ -667,10 +667,10 @@ static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
 	if (ret) {
 		ath12k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cmd, tid %d (%d)\n",
 			   rx_tid->tid, ret);
-		dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
+		dma_unmap_single(ab->dev, rx_tid->qbuf.paddr_aligned, rx_tid->qbuf.size,
 				 DMA_BIDIRECTIONAL);
-		kfree(rx_tid->vaddr);
-		rx_tid->vaddr = NULL;
+		kfree(rx_tid->qbuf.vaddr);
+		rx_tid->qbuf.vaddr = NULL;
 	}
 }
 
@@ -729,10 +729,10 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 
 	return;
 free_desc:
-	dma_unmap_single(ab->dev, rx_tid->paddr, rx_tid->size,
+	dma_unmap_single(ab->dev, rx_tid->qbuf.paddr_aligned, rx_tid->qbuf.size,
 			 DMA_BIDIRECTIONAL);
-	kfree(rx_tid->vaddr);
-	rx_tid->vaddr = NULL;
+	kfree(rx_tid->qbuf.vaddr);
+	rx_tid->qbuf.vaddr = NULL;
 }
 
 static void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
@@ -801,8 +801,8 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 		return;
 
 	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
-	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
-	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
+	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.upd0 = HAL_REO_CMD_UPD0_VLD;
 	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
 				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
@@ -810,10 +810,10 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 	if (ret) {
 		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
 			   tid, ret);
-		dma_unmap_single(ar->ab->dev, rx_tid->paddr, rx_tid->size,
-				 DMA_BIDIRECTIONAL);
-		kfree(rx_tid->vaddr);
-		rx_tid->vaddr = NULL;
+		dma_unmap_single(ar->ab->dev, rx_tid->qbuf.paddr_aligned,
+				 rx_tid->qbuf.size, DMA_BIDIRECTIONAL);
+		kfree(rx_tid->qbuf.vaddr);
+		rx_tid->qbuf.vaddr = NULL;
 	}
 
 	if (peer->mlo)
@@ -909,8 +909,8 @@ static int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
 	struct ath12k_hal_reo_cmd cmd = {0};
 	int ret;
 
-	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
-	cmd.addr_hi = upper_32_bits(rx_tid->paddr);
+	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
 	cmd.upd0 = HAL_REO_CMD_UPD0_BA_WINDOW_SIZE;
 	cmd.ba_window_size = ba_win_sz;
@@ -945,7 +945,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	struct ath12k_dp_rx_tid *rx_tid;
 	u32 hw_desc_sz;
 	void *vaddr;
-	dma_addr_t paddr;
+	dma_addr_t paddr_aligned;
 	int ret;
 
 	spin_lock_bh(&ab->base_lock);
@@ -979,7 +979,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	rx_tid = &peer->rx_tid[tid];
 	/* Update the tid queue if it is already setup */
 	if (rx_tid->active) {
-		paddr = rx_tid->paddr;
+		paddr_aligned = rx_tid->qbuf.paddr_aligned;
 		ret = ath12k_peer_rx_tid_reo_update(ar, peer, rx_tid,
 						    ba_win_sz, ssn, true);
 		spin_unlock_bh(&ab->base_lock);
@@ -991,8 +991,8 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		if (!ab->hw_params->reoq_lut_support) {
 			ret = ath12k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id,
 								     peer_mac,
-								     paddr, tid, 1,
-								     ba_win_sz);
+								     paddr_aligned, tid,
+								     1, ba_win_sz);
 			if (ret) {
 				ath12k_warn(ab, "failed to setup peer rx reorder queuefor tid %d: %d\n",
 					    tid, ret);
@@ -1026,18 +1026,18 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	ath12k_hal_reo_qdesc_setup(addr_aligned, tid, ba_win_sz,
 				   ssn, pn_type);
 
-	paddr = dma_map_single(ab->dev, addr_aligned, hw_desc_sz,
-			       DMA_BIDIRECTIONAL);
+	paddr_aligned = dma_map_single(ab->dev, addr_aligned, hw_desc_sz,
+				       DMA_BIDIRECTIONAL);
 
-	ret = dma_mapping_error(ab->dev, paddr);
+	ret = dma_mapping_error(ab->dev, paddr_aligned);
 	if (ret) {
 		spin_unlock_bh(&ab->base_lock);
 		goto err_mem_free;
 	}
 
-	rx_tid->vaddr = vaddr;
-	rx_tid->paddr = paddr;
-	rx_tid->size = hw_desc_sz;
+	rx_tid->qbuf.vaddr = vaddr;
+	rx_tid->qbuf.paddr_aligned = paddr_aligned;
+	rx_tid->qbuf.size = hw_desc_sz;
 	rx_tid->active = true;
 
 	if (ab->hw_params->reoq_lut_support) {
@@ -1045,15 +1045,18 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		 * and tid with qaddr.
 		 */
 		if (peer->mlo)
-			ath12k_peer_rx_tid_qref_setup(ab, peer->ml_id, tid, paddr);
+			ath12k_peer_rx_tid_qref_setup(ab, peer->ml_id, tid,
+						      paddr_aligned);
 		else
-			ath12k_peer_rx_tid_qref_setup(ab, peer->peer_id, tid, paddr);
+			ath12k_peer_rx_tid_qref_setup(ab, peer->peer_id, tid,
+						      paddr_aligned);
 
 		spin_unlock_bh(&ab->base_lock);
 	} else {
 		spin_unlock_bh(&ab->base_lock);
 		ret = ath12k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id, peer_mac,
-							     paddr, tid, 1, ba_win_sz);
+							     paddr_aligned, tid, 1,
+							     ba_win_sz);
 	}
 
 	return ret;
@@ -1196,8 +1199,8 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 		rx_tid = &peer->rx_tid[tid];
 		if (!rx_tid->active)
 			continue;
-		cmd.addr_lo = lower_32_bits(rx_tid->paddr);
-		cmd.addr_hi = upper_32_bits(rx_tid->paddr);
+		cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
+		cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
 					     HAL_REO_CMD_UPDATE_RX_QUEUE,
 					     &cmd, NULL);
@@ -3242,8 +3245,9 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	reo_ent_ring->rx_mpdu_info.peer_meta_data =
 		reo_dest_ring->rx_mpdu_info.peer_meta_data;
 
-	reo_ent_ring->queue_addr_lo = cpu_to_le32(lower_32_bits(rx_tid->paddr));
-	queue_addr_hi = upper_32_bits(rx_tid->paddr);
+	reo_ent_ring->queue_addr_lo =
+				cpu_to_le32(lower_32_bits(rx_tid->qbuf.paddr_aligned));
+	queue_addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 	reo_ent_ring->info0 = le32_encode_bits(queue_addr_hi,
 					       HAL_REO_ENTR_RING_INFO0_QUEUE_ADDR_HI) |
 			      le32_encode_bits(dst_ind,
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 88e42365a9d8bc9074a7b319decc670203a6f5f7..1376360d71d0903113735ef1cf5836e45cdbd274 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -12,13 +12,17 @@
 
 #define DP_MAX_NWIFI_HDR_LEN	30
 
+struct ath12k_reoq_buf {
+	void *vaddr;
+	dma_addr_t paddr_aligned;
+	u32 size;
+};
+
 struct ath12k_dp_rx_tid {
 	u8 tid;
-	u32 *vaddr;
-	dma_addr_t paddr;
-	u32 size;
 	u32 ba_win_sz;
 	bool active;
+	struct ath12k_reoq_buf qbuf;
 
 	/* Info related to rx fragments */
 	u32 cur_sn;

-- 
2.25.1


