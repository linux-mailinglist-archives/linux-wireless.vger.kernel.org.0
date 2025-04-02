Return-Path: <linux-wireless+bounces-21055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A556BA78699
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E716F189175F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610BF146585;
	Wed,  2 Apr 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yf5YfyMY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31D1917E7;
	Wed,  2 Apr 2025 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562016; cv=none; b=gcHXNQJlx5luoChWp2TRB++WfEmy5z5XdHwGID9fmqX2WHTGsBGretzU4ZwjZ2bcZEIIns8qUkxrHrURLbmhwCkJ8slzKUTzCsOf+XM6hBE2IGYY4dvZN6xwhJ64JZSX25X0wp67dsYDV9Jl4sLASHjK6E7NaPlXImBMOABipBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562016; c=relaxed/simple;
	bh=+ugNn2bJ3tlnanInrnZOV/L+7TPZqIFNQqYv3c6SuYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ty890IvdQP4XwYLD1CJ2aHI4uCkSsHH3pFrPQt+E7r9wPIC9/+SF/dZXXPPF7SV3vLmVHzmiiloi/8t8xz2hubz8pTZswNcL6Ktq6RTapJijo42g/XEyy7g6N6UsUSKyteggZSwg7OshK/ap6iCgEfAB7ZWdnY3uKLPbfLBe28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yf5YfyMY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5320TpAZ032704;
	Wed, 2 Apr 2025 02:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7x4JF92XYbOrvePwr2UHKT4dmD+4F6yYEQ7U1Qs0vjc=; b=Yf5YfyMY1Hg92S8g
	CENawjwSviNEqg3n7ssBqnL3P8ch18vayaR1Px94cki0v3ALUyPFa9dRNheB2yPJ
	WvaADQyIo5CvA2fG7pB+9Sq++A0inuDlyMp9+rkDlSOdAh1NrOQsgKdlLnt2gcaX
	nIiejXZRhygDDBjJw3Oyo5sr7T3BmErl5Fm+KH05blI4GrVs+jMV3/pIVe7RTucc
	R33xZ1HmnjhZ8Ob5an+gpoyzQa9KsHW4+DlJ5Ysr9mIQEQO7maDRyo42E/nKrczu
	ucdX6Rob3ntFAGUKmbcKaccKcrSwiZOFEICubl1oYCVpnAMGW/cpxrShLom+MFmy
	N3EMzw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qj61e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:46:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322kQax012719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:46:26 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:46:24 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 2 Apr 2025 10:45:46 +0800
Subject: [PATCH ath-next 7/9] wifi: ath12k: alloc REO queue per station
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250402-ath12k-wcn7850-mlo-support-v1-7-bad47cf00704@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67eca503 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=lhfdp0ZiA_BiyW879yIA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zhlSQDqwrlcUBEiUK8Sxe5myud_rOVn0
X-Proofpoint-GUID: zhlSQDqwrlcUBEiUK8Sxe5myud_rOVn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020017

In MLO case, all link peers share the same REO queue, so the queue
should be allocated only once, currently this is done by checking
primary_link flag in ath12k_dp_rx_peer_tid_setup(). However, the
check not only avoids duplicate allocation, but also bypasses sending
queue configuration to firmware for non-primary links. In an upcoming
patch, changes will be added to make this check no-ops for WCN7850,
as WCN7850 firmware needs to be explicitly notified each link peer's
queue configuration. That said, the duplicate allocation would arise
again after that change, hence it needs to be resolved before hand.

Since all link peers share the same queue, it should be allocated per
MLD peer, not per link peer. So change to do allocation once and save
it in MLD peer, link peers can simply get queue configuration from
there.

Also relocate ath12k_reoq_buf structure to core.h to avoid circular
dependency.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h  |  8 +++
 drivers/net/wireless/ath/ath12k/dp_rx.c | 95 ++++++++++++++++++++-------------
 drivers/net/wireless/ath/ath12k/dp_rx.h |  6 ---
 3 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index c448c72e9f05f8d87db51bb0b97ab3e5414d2920..cec9620c543e834e60f0dbe11a880e6d58d59cd6 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -525,6 +525,12 @@ struct ath12k_link_sta {
 	u8 link_idx;
 };
 
+struct ath12k_reoq_buf {
+	void *vaddr;
+	dma_addr_t paddr_aligned;
+	u32 size;
+};
+
 struct ath12k_sta {
 	struct ath12k_vif *ahvif;
 	enum hal_pn_type pn_type;
@@ -537,6 +543,8 @@ struct ath12k_sta {
 	u8 num_peer;
 
 	enum ieee80211_sta_state state;
+
+	struct ath12k_reoq_buf reoq_bufs[IEEE80211_NUM_TIDS + 1];
 };
 
 #define ATH12K_HALF_20MHZ_BW	10
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 12313aa87e0747f3ea3dbaad50bb80b3a544d45f..6bad4e4440f74d5f9a143ef6ef79a8df5c3cdfab 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -934,17 +934,66 @@ static int ath12k_peer_rx_tid_reo_update(struct ath12k *ar,
 	return 0;
 }
 
+static int ath12k_dp_rx_assign_reoq(struct ath12k_base *ab,
+				    struct ath12k_sta *ahsta,
+				    struct ath12k_dp_rx_tid *rx_tid,
+				    u16 ssn, enum hal_pn_type pn_type)
+{
+	u32 ba_win_sz = rx_tid->ba_win_sz;
+	struct ath12k_reoq_buf *buf;
+	void *vaddr, *vaddr_aligned;
+	dma_addr_t paddr_aligned;
+	u8 tid = rx_tid->tid;
+	u32 hw_desc_sz;
+	int ret;
+
+	buf = &ahsta->reoq_bufs[tid];
+	if (!buf->vaddr) {
+		/* TODO: Optimize the memory allocation for qos tid based on
+		 * the actual BA window size in REO tid update path.
+		 */
+		if (tid == HAL_DESC_REO_NON_QOS_TID)
+			hw_desc_sz = ath12k_hal_reo_qdesc_size(ba_win_sz, tid);
+		else
+			hw_desc_sz = ath12k_hal_reo_qdesc_size(DP_BA_WIN_SZ_MAX, tid);
+
+		vaddr = kzalloc(hw_desc_sz + HAL_LINK_DESC_ALIGN - 1, GFP_ATOMIC);
+		if (!vaddr)
+			return -ENOMEM;
+
+		vaddr_aligned = PTR_ALIGN(vaddr, HAL_LINK_DESC_ALIGN);
+
+		ath12k_hal_reo_qdesc_setup(vaddr_aligned, tid, ba_win_sz,
+					   ssn, pn_type);
+
+		paddr_aligned = dma_map_single(ab->dev, vaddr_aligned, hw_desc_sz,
+					       DMA_BIDIRECTIONAL);
+		ret = dma_mapping_error(ab->dev, paddr_aligned);
+		if (ret) {
+			kfree(vaddr);
+			return ret;
+		}
+
+		buf->vaddr = vaddr;
+		buf->paddr_aligned = paddr_aligned;
+		buf->size = hw_desc_sz;
+	}
+
+	rx_tid->qbuf = *buf;
+	rx_tid->active = true;
+
+	return 0;
+}
+
 int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id,
 				u8 tid, u32 ba_win_sz, u16 ssn,
 				enum hal_pn_type pn_type)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = &ab->dp;
-	struct hal_rx_reo_queue *addr_aligned;
 	struct ath12k_peer *peer;
+	struct ath12k_sta *ahsta;
 	struct ath12k_dp_rx_tid *rx_tid;
-	u32 hw_desc_sz;
-	void *vaddr;
 	dma_addr_t paddr_aligned;
 	int ret;
 
@@ -977,9 +1026,9 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	}
 
 	rx_tid = &peer->rx_tid[tid];
+	paddr_aligned = rx_tid->qbuf.paddr_aligned;
 	/* Update the tid queue if it is already setup */
 	if (rx_tid->active) {
-		paddr_aligned = rx_tid->qbuf.paddr_aligned;
 		ret = ath12k_peer_rx_tid_reo_update(ar, peer, rx_tid,
 						    ba_win_sz, ssn, true);
 		spin_unlock_bh(&ab->base_lock);
@@ -1007,39 +1056,14 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 
 	rx_tid->ba_win_sz = ba_win_sz;
 
-	/* TODO: Optimize the memory allocation for qos tid based on
-	 * the actual BA window size in REO tid update path.
-	 */
-	if (tid == HAL_DESC_REO_NON_QOS_TID)
-		hw_desc_sz = ath12k_hal_reo_qdesc_size(ba_win_sz, tid);
-	else
-		hw_desc_sz = ath12k_hal_reo_qdesc_size(DP_BA_WIN_SZ_MAX, tid);
-
-	vaddr = kzalloc(hw_desc_sz + HAL_LINK_DESC_ALIGN - 1, GFP_ATOMIC);
-	if (!vaddr) {
-		spin_unlock_bh(&ab->base_lock);
-		return -ENOMEM;
-	}
-
-	addr_aligned = PTR_ALIGN(vaddr, HAL_LINK_DESC_ALIGN);
-
-	ath12k_hal_reo_qdesc_setup(addr_aligned, tid, ba_win_sz,
-				   ssn, pn_type);
-
-	paddr_aligned = dma_map_single(ab->dev, addr_aligned, hw_desc_sz,
-				       DMA_BIDIRECTIONAL);
-
-	ret = dma_mapping_error(ab->dev, paddr_aligned);
+	ahsta = ath12k_sta_to_ahsta(peer->sta);
+	ret = ath12k_dp_rx_assign_reoq(ab, ahsta, rx_tid, ssn, pn_type);
 	if (ret) {
 		spin_unlock_bh(&ab->base_lock);
-		goto err_mem_free;
+		ath12k_warn(ab, "failed to assign reoq buf for rx tid %u\n", tid);
+		return ret;
 	}
 
-	rx_tid->qbuf.vaddr = vaddr;
-	rx_tid->qbuf.paddr_aligned = paddr_aligned;
-	rx_tid->qbuf.size = hw_desc_sz;
-	rx_tid->active = true;
-
 	if (ab->hw_params->reoq_lut_support) {
 		/* Update the REO queue LUT at the corresponding peer id
 		 * and tid with qaddr.
@@ -1059,11 +1083,6 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 							     ba_win_sz);
 	}
 
-	return ret;
-
-err_mem_free:
-	kfree(vaddr);
-
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 1376360d71d0903113735ef1cf5836e45cdbd274..d8e9c55c321f02a75a775f99fc54123daeda8279 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -12,12 +12,6 @@
 
 #define DP_MAX_NWIFI_HDR_LEN	30
 
-struct ath12k_reoq_buf {
-	void *vaddr;
-	dma_addr_t paddr_aligned;
-	u32 size;
-};
-
 struct ath12k_dp_rx_tid {
 	u8 tid;
 	u32 ba_win_sz;

-- 
2.25.1


