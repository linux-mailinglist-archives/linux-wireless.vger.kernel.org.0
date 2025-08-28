Return-Path: <linux-wireless+bounces-26824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 354DCB3A848
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4570A1896674
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521CF33CE9F;
	Thu, 28 Aug 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jzPwWCJw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065A341651
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402596; cv=none; b=E3QXLtcIGUakQ7Dh18CcM5o9OoCmzQQtRL8pNZuCdh5BSwGR/vhrl3vUdaW64a6NHcfxDRpAuo5+gFekaRl3iidHC+VdUhp+LPFf6fabTr6wHV2oCHtF9WH5qgIbUmw3SFNCrk1j4gxWsWWnWrH9Yd7wMhwmV0NPPQILZgJK684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402596; c=relaxed/simple;
	bh=K7O48uwyMhWfSCQYysStOHPOA1DZNXuxDZdbOjaIEpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LL1DVmzEyVahzvWUVKIkdUYq9GCb6bi7QHp22zTWYZgRqh+9/2/mOsR+WWpGNrxwnlrDy0M1YpmOYJsCXBNRhbCBVgWLSJXjmiwv7g7jnhNfdqdRtNJSYRZNePj7UUVzxhPk1QnfFixTKYmlXWV8uJcAfq2qUr20DXbqSkDtUG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jzPwWCJw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SBLr8G030085;
	Thu, 28 Aug 2025 17:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LuiwTuNd1tKglvg0Nk322UBekKw+s5IpLsOX4yViEFs=; b=jzPwWCJwdBAs68hT
	D8TuJBISGpZsTwdkDgSQ4aT1uESUL++bwjcaf/7SY0rkH/GGx8RlYc3O57WkTFK+
	2NhxYqJkL1bS2yo8MCyTrbBElPv1LoWFq73KkO8kCs/IBKpfKVLTol5a04Vow0f0
	6aZGfjy0OEUdyngsHee5n88rf1IUNv4oDPMIzradzcECszse1J0cFMBMErfgIZJc
	jgKwr4lRCt9+s6hH0IfW0m0L8LBpNpWroOJ1dGwAxoBzbDKvqGFyzjclBLA81yK1
	l0Eu+VobdI54aXKch77+FFOMxj7MYUttvCzh5s/g9OBUOjJzEn9yVMjGnzcp8Rv8
	W8rc9Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tp5k13kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaVHi003674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:31 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:30 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 14/20] wifi: ath12k: Move arch specific rx tid and related functions to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:47 +0530
Message-ID: <20250828173553.3341351-15-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=V9F90fni c=1 sm=1 tr=0 ts=68b093a0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=iYydl7YHNJadsHBUSOQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5NSBTYWx0ZWRfX4u81zk5h7ERO
 ooG7EtP8NQ59Sekm9kobZO9wzruvPv9p8BGyZORaLd1iKRREJyTPOwqhuCUBXuEL233Xttq+1/u
 1VwcKvxX7MnsOaziJxB7OebbnnRMH8XHYcRmArDJ2FnxVCM83erlwXr5tsBWTL5lIenWrnINbrR
 V49Z29qIRulNwZ4SnG6QSaNKgpOxL61doK113sWf3IN3QGdMgXBoWbuLcB+3Wa2V6gSYjvbTi3a
 8rODhbt0fCxolDM2H9CujSaHspvnyMybEMyS9qQ1WD30K3rcsZuJpwf1ta0yQ6VOwFHD3onuwsF
 v7AvXOH7+UanqxrXhv7P3fyJMslh6DUCLw7lmAe+g68Djnc04waDo9ex/Tq3wou/hqfB2x3WwIz
 xARTfu3V
X-Proofpoint-ORIG-GUID: IZSVAkVZN4vai3KykliOXBxBN8PD7Xbc
X-Proofpoint-GUID: IZSVAkVZN4vai3KykliOXBxBN8PD7Xbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280095

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move arch specific Rx tid related functions to wifi7 directory.

The moved APIs will be a part of dp_rx.c file inside wifi7 directory.
wifi7/dp_rx.c file will continue to be part of ath12k.ko
temporarily until the corresponding infra for movement
to ath12k_wifi7.ko arrives in upcoming patches.

Architecture specific APIs:
ath12k_peer_rx_tid_qref_reset
ath12k_dp_reo_cache_flush
ath12k_dp_reo_cmd_send
ath12k_peer_rx_tid_reo_update
ath12k_dp_rx_link_desc_return
ath12k_dp_rx_peer_tid_delete
ath12k_peer_rx_tid_qref_setup

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 248 +-----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   7 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 240 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  19 ++
 4 files changed, 267 insertions(+), 247 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 22d9c2d8c4e3..d735eee9efee 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -370,8 +370,8 @@ void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 	spin_unlock_bh(&dp->reo_cmd_lock);
 }
 
-static void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
-				   enum hal_reo_cmd_status status)
+void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
+			    enum hal_reo_cmd_status status)
 {
 	struct ath12k_dp_rx_tid *rx_tid = ctx;
 
@@ -385,93 +385,8 @@ static void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
 	rx_tid->qbuf.vaddr = NULL;
 }
 
-static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
-				  enum hal_reo_cmd_type type,
-				  struct ath12k_hal_reo_cmd *cmd,
-				  void (*cb)(struct ath12k_dp *dp, void *ctx,
-					     enum hal_reo_cmd_status status))
-{
-	struct ath12k_dp *dp = &ab->dp;
-	struct ath12k_dp_rx_reo_cmd *dp_cmd;
-	struct hal_srng *cmd_ring;
-	int cmd_num;
-
-	cmd_ring = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
-	cmd_num = ath12k_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
-
-	/* cmd_num should start from 1, during failure return the error code */
-	if (cmd_num < 0)
-		return cmd_num;
-
-	/* reo cmd ring descriptors has cmd_num starting from 1 */
-	if (cmd_num == 0)
-		return -EINVAL;
-
-	if (!cb)
-		return 0;
-
-	/* Can this be optimized so that we keep the pending command list only
-	 * for tid delete command to free up the resource on the command status
-	 * indication?
-	 */
-	dp_cmd = kzalloc(sizeof(*dp_cmd), GFP_ATOMIC);
-
-	if (!dp_cmd)
-		return -ENOMEM;
-
-	memcpy(&dp_cmd->data, rx_tid, sizeof(*rx_tid));
-	dp_cmd->cmd_num = cmd_num;
-	dp_cmd->handler = cb;
-
-	spin_lock_bh(&dp->reo_cmd_lock);
-	list_add_tail(&dp_cmd->list, &dp->reo_cmd_list);
-	spin_unlock_bh(&dp->reo_cmd_lock);
-
-	return 0;
-}
-
-static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
-				      struct ath12k_dp_rx_tid *rx_tid)
-{
-	struct ath12k_hal_reo_cmd cmd = {};
-	unsigned long tot_desc_sz, desc_sz;
-	int ret;
-
-	tot_desc_sz = rx_tid->qbuf.size;
-	desc_sz = ath12k_hal_reo_qdesc_size(0, HAL_DESC_REO_NON_QOS_TID);
-
-	while (tot_desc_sz > desc_sz) {
-		tot_desc_sz -= desc_sz;
-		cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned + tot_desc_sz);
-		cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
-					     HAL_REO_CMD_FLUSH_CACHE, &cmd,
-					     NULL);
-		if (ret)
-			ath12k_warn(ab,
-				    "failed to send HAL_REO_CMD_FLUSH_CACHE, tid %d (%d)\n",
-				    rx_tid->tid, ret);
-	}
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
-	ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
-				     HAL_REO_CMD_FLUSH_CACHE,
-				     &cmd, ath12k_dp_reo_cmd_free);
-	if (ret) {
-		ath12k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cmd, tid %d (%d)\n",
-			   rx_tid->tid, ret);
-		dma_unmap_single(ab->dev, rx_tid->qbuf.paddr_aligned, rx_tid->qbuf.size,
-				 DMA_BIDIRECTIONAL);
-		kfree(rx_tid->qbuf.vaddr);
-		rx_tid->qbuf.vaddr = NULL;
-	}
-}
-
-static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
-				      enum hal_reo_cmd_status status)
+void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
+			       enum hal_reo_cmd_status status)
 {
 	struct ath12k_base *ab = dp->ab;
 	struct ath12k_dp_rx_tid *rx_tid = ctx;
@@ -531,127 +446,6 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 	rx_tid->qbuf.vaddr = NULL;
 }
 
-static void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
-					  dma_addr_t paddr)
-{
-	struct ath12k_reo_queue_ref *qref;
-	struct ath12k_dp *dp = &ab->dp;
-	bool ml_peer = false;
-
-	if (!ab->hw_params->reoq_lut_support)
-		return;
-
-	if (peer_id & ATH12K_PEER_ML_ID_VALID) {
-		peer_id &= ~ATH12K_PEER_ML_ID_VALID;
-		ml_peer = true;
-	}
-
-	if (ml_peer)
-		qref = (struct ath12k_reo_queue_ref *)dp->ml_reoq_lut.vaddr +
-				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
-	else
-		qref = (struct ath12k_reo_queue_ref *)dp->reoq_lut.vaddr +
-				(peer_id * (IEEE80211_NUM_TIDS + 1) + tid);
-
-	qref->info0 = u32_encode_bits(lower_32_bits(paddr),
-				      BUFFER_ADDR_INFO0_ADDR);
-	qref->info1 = u32_encode_bits(upper_32_bits(paddr),
-				      BUFFER_ADDR_INFO1_ADDR) |
-		      u32_encode_bits(tid, DP_REO_QREF_NUM);
-	ath12k_hal_reo_shared_qaddr_cache_clear(ab);
-}
-
-static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u16 tid)
-{
-	struct ath12k_reo_queue_ref *qref;
-	struct ath12k_dp *dp = &ab->dp;
-	bool ml_peer = false;
-
-	if (!ab->hw_params->reoq_lut_support)
-		return;
-
-	if (peer_id & ATH12K_PEER_ML_ID_VALID) {
-		peer_id &= ~ATH12K_PEER_ML_ID_VALID;
-		ml_peer = true;
-	}
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
-}
-
-void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
-				  struct ath12k_peer *peer, u8 tid)
-{
-	struct ath12k_hal_reo_cmd cmd = {};
-	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
-	int ret;
-
-	if (!rx_tid->active)
-		return;
-
-	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
-	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.upd0 = HAL_REO_CMD_UPD0_VLD;
-	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
-				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
-				     ath12k_dp_rx_tid_del_func);
-	if (ret) {
-		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
-			   tid, ret);
-		dma_unmap_single(ar->ab->dev, rx_tid->qbuf.paddr_aligned,
-				 rx_tid->qbuf.size, DMA_BIDIRECTIONAL);
-		kfree(rx_tid->qbuf.vaddr);
-		rx_tid->qbuf.vaddr = NULL;
-	}
-
-	if (peer->mlo)
-		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->ml_id, tid);
-	else
-		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
-
-	rx_tid->active = false;
-}
-
-int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
-				  struct ath12k_buffer_addr *buf_addr_info,
-				  enum hal_wbm_rel_bm_act action)
-{
-	struct hal_wbm_release_ring *desc;
-	struct ath12k_dp *dp = &ab->dp;
-	struct hal_srng *srng;
-	int ret = 0;
-
-	srng = &ab->hal.srng_list[dp->wbm_desc_rel_ring.ring_id];
-
-	spin_lock_bh(&srng->lock);
-
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	desc = ath12k_hal_srng_src_get_next_entry(ab, srng);
-	if (!desc) {
-		ret = -ENOBUFS;
-		goto exit;
-	}
-
-	ath12k_hal_rx_msdu_link_desc_set(ab, desc, buf_addr_info, action);
-
-exit:
-	ath12k_hal_srng_access_end(ab, srng);
-
-	spin_unlock_bh(&srng->lock);
-
-	return ret;
-}
-
 void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 				bool rel_link_desc)
 {
@@ -695,40 +489,6 @@ void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_peer *peer)
 	}
 }
 
-static int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
-					 struct ath12k_peer *peer,
-					 struct ath12k_dp_rx_tid *rx_tid,
-					 u32 ba_win_sz, u16 ssn,
-					 bool update_ssn)
-{
-	struct ath12k_hal_reo_cmd cmd = {};
-	int ret;
-
-	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
-	cmd.upd0 = HAL_REO_CMD_UPD0_BA_WINDOW_SIZE;
-	cmd.ba_window_size = ba_win_sz;
-
-	if (update_ssn) {
-		cmd.upd0 |= HAL_REO_CMD_UPD0_SSN;
-		cmd.upd2 = u32_encode_bits(ssn, HAL_REO_CMD_UPD2_SSN);
-	}
-
-	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
-				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
-				     NULL);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to update rx tid queue, tid %d (%d)\n",
-			    rx_tid->tid, ret);
-		return ret;
-	}
-
-	rx_tid->ba_win_sz = ba_win_sz;
-
-	return 0;
-}
-
 int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id,
 				u8 tid, u32 ba_win_sz, u16 ssn,
 				enum hal_pn_type pn_type)
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index b3095fd46cd5..7bf70cef4365 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -422,12 +422,13 @@ u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 				struct hal_rx_desc *rx_desc);
 bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				 struct hal_rx_desc *rx_desc);
-int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
-				  struct ath12k_buffer_addr *buf_addr_info,
-				  enum hal_wbm_rel_bm_act action);
 bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				 struct hal_rx_desc *rx_desc);
 void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info);
 struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
 					       struct sk_buff *first);
+void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
+			    enum hal_reo_cmd_status status);
+void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
+			       enum hal_reo_cmd_status status);
 #endif /* ATH12K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index bcdfa19a2e5f..d95e3c4daa5d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -8,6 +8,246 @@
 #include "../dp_tx.h"
 #include "../peer.h"
 
+void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
+				   dma_addr_t paddr)
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
+	qref->info0 = u32_encode_bits(lower_32_bits(paddr),
+				      BUFFER_ADDR_INFO0_ADDR);
+	qref->info1 = u32_encode_bits(upper_32_bits(paddr),
+				      BUFFER_ADDR_INFO1_ADDR) |
+		      u32_encode_bits(tid, DP_REO_QREF_NUM);
+	ath12k_hal_reo_shared_qaddr_cache_clear(ab);
+}
+
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
+void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
+				  struct ath12k_peer *peer, u8 tid)
+{
+	struct ath12k_hal_reo_cmd cmd = {};
+	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
+	int ret;
+
+	if (!rx_tid->active)
+		return;
+
+	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
+	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.upd0 = HAL_REO_CMD_UPD0_VLD;
+	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
+				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
+				     ath12k_dp_rx_tid_del_func);
+	if (ret) {
+		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
+			   tid, ret);
+		dma_unmap_single(ar->ab->dev, rx_tid->qbuf.paddr_aligned,
+				 rx_tid->qbuf.size, DMA_BIDIRECTIONAL);
+		kfree(rx_tid->qbuf.vaddr);
+		rx_tid->qbuf.vaddr = NULL;
+	}
+
+	if (peer->mlo)
+		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->ml_id, tid);
+	else
+		ath12k_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
+
+	rx_tid->active = false;
+}
+
+int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
+				  struct ath12k_buffer_addr *buf_addr_info,
+				  enum hal_wbm_rel_bm_act action)
+{
+	struct hal_wbm_release_ring *desc;
+	struct ath12k_dp *dp = &ab->dp;
+	struct hal_srng *srng;
+	int ret = 0;
+
+	srng = &ab->hal.srng_list[dp->wbm_desc_rel_ring.ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	desc = ath12k_hal_srng_src_get_next_entry(ab, srng);
+	if (!desc) {
+		ret = -ENOBUFS;
+		goto exit;
+	}
+
+	ath12k_hal_rx_msdu_link_desc_set(ab, desc, buf_addr_info, action);
+
+exit:
+	ath12k_hal_srng_access_end(ab, srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	return ret;
+}
+
+int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
+			   enum hal_reo_cmd_type type,
+			   struct ath12k_hal_reo_cmd *cmd,
+			   void (*cb)(struct ath12k_dp *dp, void *ctx,
+				      enum hal_reo_cmd_status status))
+{
+	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_dp_rx_reo_cmd *dp_cmd;
+	struct hal_srng *cmd_ring;
+	int cmd_num;
+
+	cmd_ring = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
+	cmd_num = ath12k_hal_reo_cmd_send(ab, cmd_ring, type, cmd);
+
+	/* cmd_num should start from 1, during failure return the error code */
+	if (cmd_num < 0)
+		return cmd_num;
+
+	/* reo cmd ring descriptors has cmd_num starting from 1 */
+	if (cmd_num == 0)
+		return -EINVAL;
+
+	if (!cb)
+		return 0;
+
+	/* Can this be optimized so that we keep the pending command list only
+	 * for tid delete command to free up the resource on the command status
+	 * indication?
+	 */
+	dp_cmd = kzalloc(sizeof(*dp_cmd), GFP_ATOMIC);
+
+	if (!dp_cmd)
+		return -ENOMEM;
+
+	memcpy(&dp_cmd->data, rx_tid, sizeof(*rx_tid));
+	dp_cmd->cmd_num = cmd_num;
+	dp_cmd->handler = cb;
+
+	spin_lock_bh(&dp->reo_cmd_lock);
+	list_add_tail(&dp_cmd->list, &dp->reo_cmd_list);
+	spin_unlock_bh(&dp->reo_cmd_lock);
+
+	return 0;
+}
+
+int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
+				  struct ath12k_peer *peer,
+				  struct ath12k_dp_rx_tid *rx_tid,
+				  u32 ba_win_sz, u16 ssn,
+				  bool update_ssn)
+{
+	struct ath12k_hal_reo_cmd cmd = {};
+	int ret;
+
+	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
+	cmd.upd0 = HAL_REO_CMD_UPD0_BA_WINDOW_SIZE;
+	cmd.ba_window_size = ba_win_sz;
+
+	if (update_ssn) {
+		cmd.upd0 |= HAL_REO_CMD_UPD0_SSN;
+		cmd.upd2 = u32_encode_bits(ssn, HAL_REO_CMD_UPD2_SSN);
+	}
+
+	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
+				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
+				     NULL);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to update rx tid queue, tid %d (%d)\n",
+			    rx_tid->tid, ret);
+		return ret;
+	}
+
+	rx_tid->ba_win_sz = ba_win_sz;
+
+	return 0;
+}
+
+void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
+			       struct ath12k_dp_rx_tid *rx_tid)
+{
+	struct ath12k_hal_reo_cmd cmd = {};
+	unsigned long tot_desc_sz, desc_sz;
+	int ret;
+
+	tot_desc_sz = rx_tid->qbuf.size;
+	desc_sz = ath12k_hal_reo_qdesc_size(0, HAL_DESC_REO_NON_QOS_TID);
+
+	while (tot_desc_sz > desc_sz) {
+		tot_desc_sz -= desc_sz;
+		cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned + tot_desc_sz);
+		cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
+		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
+					     HAL_REO_CMD_FLUSH_CACHE, &cmd,
+					     NULL);
+		if (ret)
+			ath12k_warn(ab,
+				    "failed to send HAL_REO_CMD_FLUSH_CACHE, tid %d (%d)\n",
+				    rx_tid->tid, ret);
+	}
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
+	ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
+				     HAL_REO_CMD_FLUSH_CACHE,
+				     &cmd, ath12k_dp_reo_cmd_free);
+	if (ret) {
+		ath12k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cmd, tid %d (%d)\n",
+			   rx_tid->tid, ret);
+		dma_unmap_single(ab->dev, rx_tid->qbuf.paddr_aligned, rx_tid->qbuf.size,
+				 DMA_BIDIRECTIONAL);
+		kfree(rx_tid->qbuf.vaddr);
+		rx_tid->qbuf.vaddr = NULL;
+	}
+}
+
 int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
 			     struct ath12k_dp_rx_tid *rx_tid,
 			     u16 ssn, enum hal_pn_type pn_type)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index 3589db00c906..45b856aaaa12 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -25,4 +25,23 @@ void ath12k_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
 int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab, struct ath12k_sta *ahsta,
 			     struct ath12k_dp_rx_tid *rx_tid,
 			     u16 ssn, enum hal_pn_type pn_type);
+int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
+				  struct ath12k_buffer_addr *buf_addr_info,
+				  enum hal_wbm_rel_bm_act action);
+void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
+				   dma_addr_t paddr);
+void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
+				  struct ath12k_peer *peer, u8 tid);
+int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
+			   enum hal_reo_cmd_type type,
+			   struct ath12k_hal_reo_cmd *cmd,
+			   void (*cb)(struct ath12k_dp *dp, void *ctx,
+				      enum hal_reo_cmd_status status));
+void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
+			       struct ath12k_dp_rx_tid *rx_tid);
+int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
+				  struct ath12k_peer *peer,
+				  struct ath12k_dp_rx_tid *rx_tid,
+				  u32 ba_win_sz, u16 ssn,
+				  bool update_ssn);
 #endif
-- 
2.34.1


