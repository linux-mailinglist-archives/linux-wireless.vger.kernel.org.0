Return-Path: <linux-wireless+bounces-7062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0DC8B7E0C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197521C23C22
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA219DF4C;
	Tue, 30 Apr 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WjQ83aZ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A627199E86
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496317; cv=none; b=r0m/ikZCDxg3PHm16x+aZoJlWQe1Gc/u3iW/v74OPxyjYiGfTP2l88qZ0WXO7iqb98uvVhrVmqC4C3hsGMKk3vNuE56oVS0DOk3aYNlXdiNNOV1gODkarPfd5QTOF4sidwEJl3pEYkmmJp4L/zAXr8ryKJkm40SJTHWrgG5/en4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496317; c=relaxed/simple;
	bh=pmR0IYhb5olWVYlXvqqPJKBdX7qtS2MMecuyvX07WbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kmm0lK+tepG+GqxGc5AmcPpDcy/QxuqBQ/2P/8F9bgpca7evGJ5fEsIhG6RF1lghL1m4YBVXgljE/FRjVDENB3zHA/glidR4FSD9yuS7osRtSpzr3TnSiXjJV3YbOQER3fbtcaDUNkctmPB0sNtwzFuWTvWYEmBspz7/Kh+Jkxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WjQ83aZ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UFjE1h029825;
	Tue, 30 Apr 2024 16:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=OIzJjqXkASz71cPUW4OSIe8yGFQmiEU+kileEtHj3ck=; b=Wj
	Q83aZ3B6V43eEmwk0SHn7Z1qBUAJ1j18c+qyRKodNZPWTcDEJwdG7HxmudeWTkLN
	WmBUd3c2P/QdmEHuPKCplBkrG8H+YH2wYbA8J3uKRGa3IXnnoeIrVR30VfEQpcmG
	T26NipimkXj2TiTH02ehiRIKdCyJTn77MzEVhWZ9R21G4OKssZtwlXQh6O8wtYhX
	KH+Vsnd9vP3lMOKImqANtCOiJ0kqqEL9OONNOZna5bgIgI7p9w1TIn+JAdPaJsfE
	eElLwt1moni2XUPmCyl7Hri3f0DN9GGghtz6oE9mrOt+IghnHKdGXDII4y5x0+FU
	u/kd73Yk23Q4z1ub504A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtrep2197-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UGwWOx027351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:32 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 09:58:30 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 2/4] wifi: ath12k: Refactor idle ring descriptor setup
Date: Tue, 30 Apr 2024 22:28:09 +0530
Message-ID: <20240430165811.1377182-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: G3cozBYReu50NKsEaJSgOlBiKrDBt7Pn
X-Proofpoint-ORIG-GUID: G3cozBYReu50NKsEaJSgOlBiKrDBt7Pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=950 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300121

Currently, the WBM idle ring descriptor setup uses implicit value
HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST for the return buffer manager
parameter. To support inter-device MLO (Multi-link operation), this
parameter needs to be configure dynamically based on the device identifier
within the MLO group. Therefore, introduce a new argument to the helper
function ath12k_hal_set_link_desc_addr().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    | 9 ++++++---
 drivers/net/wireless/ath/ath12k/dp.h    | 1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c | 5 +++--
 drivers/net/wireless/ath/ath12k/hal.c   | 5 +++--
 drivers/net/wireless/ath/ath12k/hal.h   | 3 ++-
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 7843c76a82c1..f41b3f9dac3d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -616,6 +616,7 @@ static int ath12k_dp_scatter_idle_link_desc_setup(struct ath12k_base *ab,
 	int i;
 	int ret = 0;
 	u32 end_offset, cookie;
+	enum hal_rx_buf_return_buf_manager rbm = dp->idle_link_rbm;
 
 	n_entries_per_buf = HAL_WBM_IDLE_SCATTER_BUF_SIZE /
 		ath12k_hal_srng_get_entrysize(ab, HAL_WBM_IDLE_LINK);
@@ -646,7 +647,8 @@ static int ath12k_dp_scatter_idle_link_desc_setup(struct ath12k_base *ab,
 		paddr = link_desc_banks[i].paddr;
 		while (n_entries) {
 			cookie = DP_LINK_DESC_COOKIE_SET(n_entries, i);
-			ath12k_hal_set_link_desc_addr(scatter_buf, cookie, paddr);
+			ath12k_hal_set_link_desc_addr(scatter_buf, cookie,
+						      paddr, rbm);
 			n_entries--;
 			paddr += HAL_LINK_DESC_SIZE;
 			if (rem_entries) {
@@ -790,6 +792,7 @@ int ath12k_dp_link_desc_setup(struct ath12k_base *ab,
 	u32 paddr;
 	int i, ret;
 	u32 cookie;
+	enum hal_rx_buf_return_buf_manager rbm = ab->dp.idle_link_rbm;
 
 	tot_mem_sz = n_link_desc * HAL_LINK_DESC_SIZE;
 	tot_mem_sz += HAL_LINK_DESC_ALIGN;
@@ -850,8 +853,7 @@ int ath12k_dp_link_desc_setup(struct ath12k_base *ab,
 		while (n_entries &&
 		       (desc = ath12k_hal_srng_src_get_next_entry(ab, srng))) {
 			cookie = DP_LINK_DESC_COOKIE_SET(n_entries, i);
-			ath12k_hal_set_link_desc_addr(desc,
-						      cookie, paddr);
+			ath12k_hal_set_link_desc_addr(desc, cookie, paddr, rbm);
 			n_entries--;
 			paddr += HAL_LINK_DESC_SIZE;
 		}
@@ -1603,6 +1605,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	spin_lock_init(&dp->reo_cmd_lock);
 
 	dp->reo_cmd_cache_flush_count = 0;
+	dp->idle_link_rbm = HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
 
 	ret = ath12k_wbm_idle_ring_setup(ab, &n_link_desc);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 5cf0d21ef184..e9880b34a7ab 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -325,6 +325,7 @@ struct ath12k_dp {
 	u8 htt_tgt_ver_major;
 	u8 htt_tgt_ver_minor;
 	struct dp_link_desc_bank link_desc_banks[DP_LINK_DESC_BANKS_MAX];
+	enum hal_rx_buf_return_buf_manager idle_link_rbm;
 	struct dp_srng wbm_idle_ring;
 	struct dp_srng wbm_desc_rel_ring;
 	struct dp_srng tcl_cmd_ring;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index fc4b95324955..18030c9e735d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2994,6 +2994,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 	u32 cookie, hal_rx_desc_sz, dest_ring_info0;
 	int ret;
 	struct ath12k_rx_desc_info *desc_info;
+	enum hal_rx_buf_return_buf_manager idle_link_rbm = dp->idle_link_rbm;
 	u8 dst_ind;
 
 	hal_rx_desc_sz = ab->hal.hal_desc_sz;
@@ -3071,7 +3072,7 @@ static int ath12k_dp_rx_h_defrag_reo_reinject(struct ath12k *ar,
 
 	ath12k_hal_rx_buf_addr_info_set(&reo_ent_ring->buf_addr_info, link_paddr,
 					cookie,
-					HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST);
+					idle_link_rbm);
 
 	mpdu_info = u32_encode_bits(1, RX_MPDU_DESC_INFO0_MSDU_COUNT) |
 		    u32_encode_bits(0, RX_MPDU_DESC_INFO0_FRAG_FLAG) |
@@ -3451,7 +3452,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			       (paddr - link_desc_banks[desc_bank].paddr);
 		ath12k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
 						 &rbm);
-		if (rbm != HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST &&
+		if (rbm != dp->idle_link_rbm &&
 		    rbm != HAL_RX_BUF_RBM_SW3_BM &&
 		    rbm != ab->hw_params->hal_params->rx_buf_rbm) {
 			ab->soc_stats.invalid_rbm++;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 78310da8cfe8..ca04bfae8bdc 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1969,14 +1969,15 @@ u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc
 }
 
 void ath12k_hal_set_link_desc_addr(struct hal_wbm_link_desc *desc, u32 cookie,
-				   dma_addr_t paddr)
+				   dma_addr_t paddr,
+				   enum hal_rx_buf_return_buf_manager rbm)
 {
 	desc->buf_addr_info.info0 = le32_encode_bits((paddr & HAL_ADDR_LSB_REG_MASK),
 						     BUFFER_ADDR_INFO0_ADDR);
 	desc->buf_addr_info.info1 =
 			le32_encode_bits(((u64)paddr >> HAL_ADDR_MSB_REG_SHIFT),
 					 BUFFER_ADDR_INFO1_ADDR) |
-			le32_encode_bits(1, BUFFER_ADDR_INFO1_RET_BUF_MGR) |
+			le32_encode_bits(rbm, BUFFER_ADDR_INFO1_RET_BUF_MGR) |
 			le32_encode_bits(cookie, BUFFER_ADDR_INFO1_SW_COOKIE);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index f364b2938ef8..8a78bb9a10bc 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1113,7 +1113,8 @@ dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
 void ath12k_hal_set_link_desc_addr(struct hal_wbm_link_desc *desc, u32 cookie,
-				   dma_addr_t paddr);
+				   dma_addr_t paddr,
+				   enum hal_rx_buf_return_buf_manager rbm);
 u32 ath12k_hal_ce_get_desc_size(enum hal_ce_desc type);
 void ath12k_hal_ce_src_set_desc(struct hal_ce_srng_src_desc *desc, dma_addr_t paddr,
 				u32 len, u32 id, u8 byte_swap_data);
-- 
2.34.1


