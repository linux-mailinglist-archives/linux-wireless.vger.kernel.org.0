Return-Path: <linux-wireless+bounces-27910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F8BC8B65
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF88188EEFA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591952E0410;
	Thu,  9 Oct 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kOglMfvh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C182E03E4
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008282; cv=none; b=VoZL7qu9JnoqAr0D+0PTo3JmkkqOCFVZuEa1a00L1Bt8OeJaESfYWobbUA1PhCaPUHSUKsofM0yjjgr4kk1euQ71V6CQvsGoJW9IVjdCTB8/nE3jwE4GwTa3Si1XWdltKHzR/tAp6uYAcrBfiGQtnoyAdQ2dWgWzgzjNFq2l5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008282; c=relaxed/simple;
	bh=a75NWEOEizJ+Kb3KMV48ZrfL0b1hrVKANSQ9WKyyI2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKPK0vZV1cbIzivpN7pk8DBH/muwM6KlNVFFnORNgcwHsm06JEP4t2MSNtJ4iaGT1V44Y0Xtk8FGgVT1uyKLrEvzN2/lV+XlYvirqsrOEdHRrz39RfkzywVpZZIgfxg69O+b8gx+TYKOZ9TJ4YavXsb59baGzbWVYDp36xmTxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kOglMfvh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EIeg023275;
	Thu, 9 Oct 2025 11:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BeLSGc+itKx6sYcw7KVyYJoozfQ30B6WM91N+WTNUis=; b=kOglMfvhukKHOZZG
	5JPwurrfQ7qafiZ0NuKe31x6yAG2WHJ80T3+VS9o4daj5gDnZYWEgJ2J28r1C5OY
	BQ4C6dXbQ2c3WYyXad3mcwqB9yk3E3UG4k/AwgE/CFbU9TBRBsnJzWs4Y7HsN0/m
	kTwEURAUvCFr5E3CCdwm+qSQ07pvEPgcYnnE11kL2Ghh+kh+lJwDkJdzoc3qo+uL
	UAik0FJ4w3jc5VSIdnIP93kG6OSyIqkjgohp7u08yZcoX7bqZe+rNawXIt5h8yUN
	jMA3JM067arO+D8d8PcEjfSr/Q7UFFfem+dEmAq1ZIpHCmUaX5M0kVR3jOy4PBhF
	mUJNOA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m2hsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBHkp024739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:17 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:16 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 11/18] wifi: ath12k: Move HAL CE status and set link desc addr APIs to wifi7 directory
Date: Thu, 9 Oct 2025 16:40:38 +0530
Message-ID: <20251009111045.1763001-12-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/QUvpNWppdHa
 MuNbCpZl8RtfVlRJFTDDm/ZzVX8B187wsH6W1hJy7EvbIEM2USpqfQyuXpH8+G/49L2C6g16T+P
 2uPR+lEL+2C9hnMBaaI11s9Ev4SFm4wNeruc9lxMIXJGMJESVdu6TGFfc8SNKxO6/p9fnDcIXOZ
 S3aEf/iG3TtmyjBITqW2kBjKuVD2wn9bP7ZZxeekIcHcL3O1zCFD14s05L+qYtGU9w1ON+s4xJt
 D2f587s8HOhPWP1qZG/x4dstKZr2+WARQGuwCIkJRnGnUwv7GgTJz4WFZCg9tkJa44UawUfBgui
 WauWAvgW/LggIC2K0sPoLG6pw3mbFDARIVcDWYOjNNMSGBVVjQ8BFE5fFQ26E7iJabWCKNfU6w8
 WY3CO2fPAhBxdoGDHzg0LzT08p+O1Q==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e79856 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=kX_5ZsDEhLr6PecvTysA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0PpOqvaQoMGH0brUSRAc8KDNKPFqqQF1
X-Proofpoint-ORIG-GUID: 0PpOqvaQoMGH0brUSRAc8KDNKPFqqQF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move the hardware specific HAL APIs to hal.c file
inside wifi7 directory. These APIs will be called
through the hal_ops mechanism, which are registered
separately by qcn and wcn

Handling following APIs:
ath12k_wifi7_hal_ce_dst_status_get_length
ath12k_wifi7_hal_set_link_desc_addr

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ce.c          |  2 +-
 drivers/net/wireless/ath/ath12k/dp.c          |  5 ++--
 drivers/net/wireless/ath/ath12k/hal.c         | 24 ++++++-------------
 drivers/net/wireless/ath/ath12k/hal.h         | 14 +++++++----
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   | 23 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   |  6 +++++
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  2 ++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  2 ++
 9 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index ae8fda8689ab..490e49f50264 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -132,7 +132,7 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
 		goto err;
 	}
 
-	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
+	*nbytes = ath12k_hal_ce_dst_status_get_length(&ab->hal, desc);
 
 	*skb = pipe->dest_ring->skb[sw_index];
 	pipe->dest_ring->skb[sw_index] = NULL;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 6429ff72aa04..495e03498187 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -661,7 +661,7 @@ static int ath12k_dp_scatter_idle_link_desc_setup(struct ath12k_base *ab,
 		paddr = link_desc_banks[i].paddr;
 		while (n_entries) {
 			cookie = DP_LINK_DESC_COOKIE_SET(n_entries, i);
-			ath12k_hal_set_link_desc_addr(scatter_buf, cookie,
+			ath12k_hal_set_link_desc_addr(dp->hal, scatter_buf, cookie,
 						      paddr, rbm);
 			n_entries--;
 			paddr += HAL_LINK_DESC_SIZE;
@@ -868,7 +868,8 @@ int ath12k_dp_link_desc_setup(struct ath12k_base *ab,
 		while (n_entries &&
 		       (desc = ath12k_hal_srng_src_get_next_entry(ab, srng))) {
 			cookie = DP_LINK_DESC_COOKIE_SET(n_entries, i);
-			ath12k_hal_set_link_desc_addr(desc, cookie, paddr, rbm);
+			ath12k_hal_set_link_desc_addr(dp->hal, desc, cookie, paddr,
+						      rbm);
 			n_entries--;
 			paddr += HAL_LINK_DESC_SIZE;
 		}
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 490a483b8c30..5c13eaf9c19e 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -205,27 +205,17 @@ void ath12k_hal_ce_dst_set_desc(struct ath12k_hal *hal,
 	hal->hal_ops->ce_dst_set_desc(desc, paddr);
 }
 
-u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc)
+u32 ath12k_hal_ce_dst_status_get_length(struct ath12k_hal *hal,
+					struct hal_ce_srng_dst_status_desc *desc)
 {
-	u32 len;
-
-	len = le32_get_bits(desc->flags, HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
-	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
-
-	return len;
+	return hal->hal_ops->ce_dst_status_get_length(desc);
 }
 
-void ath12k_hal_set_link_desc_addr(struct hal_wbm_link_desc *desc, u32 cookie,
-				   dma_addr_t paddr,
-				   enum hal_rx_buf_return_buf_manager rbm)
+void ath12k_hal_set_link_desc_addr(struct ath12k_hal *hal,
+				   struct hal_wbm_link_desc *desc, u32 cookie,
+				   dma_addr_t paddr, int rbm)
 {
-	desc->buf_addr_info.info0 = le32_encode_bits((paddr & HAL_ADDR_LSB_REG_MASK),
-						     BUFFER_ADDR_INFO0_ADDR);
-	desc->buf_addr_info.info1 =
-			le32_encode_bits(((u64)paddr >> HAL_ADDR_MSB_REG_SHIFT),
-					 BUFFER_ADDR_INFO1_ADDR) |
-			le32_encode_bits(rbm, BUFFER_ADDR_INFO1_RET_BUF_MGR) |
-			le32_encode_bits(cookie, BUFFER_ADDR_INFO1_SW_COOKIE);
+	hal->hal_ops->set_link_desc_addr(desc, cookie, paddr, rbm);
 }
 
 void *ath12k_hal_srng_dst_peek(struct ath12k_base *ab, struct hal_srng *srng)
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 74f05aa1fc6d..b739ebba588b 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1713,6 +1713,10 @@ struct hal_ops {
 				u8 byte_swap_data);
 	void (*ce_dst_set_desc)(struct hal_ce_srng_dest_desc *desc,
 				dma_addr_t paddr);
+	u32 (*ce_dst_status_get_length)(struct hal_ce_srng_dst_status_desc *desc);
+	void (*set_link_desc_addr)(struct hal_wbm_link_desc *desc, u32 cookie,
+				   dma_addr_t paddr,
+				   enum hal_rx_buf_return_buf_manager rbm);
 };
 
 u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
@@ -1732,9 +1736,6 @@ dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
-void ath12k_hal_set_link_desc_addr(struct hal_wbm_link_desc *desc, u32 cookie,
-				   dma_addr_t paddr,
-				   enum hal_rx_buf_return_buf_manager rbm);
 u32 ath12k_hal_ce_get_desc_size(struct ath12k_hal *hal, enum hal_ce_desc type);
 void ath12k_hal_ce_dst_set_desc(struct ath12k_hal *hal,
 				struct hal_ce_srng_dest_desc *desc,
@@ -1743,7 +1744,6 @@ void ath12k_hal_ce_src_set_desc(struct ath12k_hal *hal,
 				struct hal_ce_srng_src_desc *desc,
 				dma_addr_t paddr, u32 len, u32 id,
 				u8 byte_swap_data);
-u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc);
 int ath12k_hal_srng_get_entrysize(struct ath12k_base *ab, u32 ring_type);
 int ath12k_hal_srng_get_max_entries(struct ath12k_base *ab, u32 ring_type);
 void ath12k_hal_srng_get_params(struct ath12k_base *ab, struct hal_srng *srng,
@@ -1782,4 +1782,10 @@ void ath12k_hal_srng_shadow_config(struct ath12k_base *ab);
 void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
 					 struct hal_srng *srng);
 void ath12k_hal_reo_shared_qaddr_cache_clear(struct ath12k_base *ab);
+void ath12k_hal_set_link_desc_addr(struct ath12k_hal *hal,
+				   struct hal_wbm_link_desc *desc, u32 cookie,
+				   dma_addr_t paddr, int rbm);
+u32
+ath12k_hal_ce_dst_status_get_length(struct ath12k_hal *hal,
+				    struct hal_ce_srng_dst_status_desc *desc);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index e691d0ca0d75..06d3690ff0c6 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -12,6 +12,7 @@
 #include "dp_rx.h"
 #include "dp.h"
 #include "dp_tx.h"
+#include "hal.h"
 
 static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 					struct ath12k_ext_irq_grp *irq_grp,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 06a6af8c9c8a..c9e853a32378 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -457,3 +457,26 @@ void ath12k_wifi7_hal_ce_dst_set_desc(struct hal_ce_srng_dest_desc *desc,
 		le32_encode_bits(((u64)paddr >> HAL_ADDR_MSB_REG_SHIFT),
 				 HAL_CE_DEST_DESC_ADDR_INFO_ADDR_HI);
 }
+
+void ath12k_wifi7_hal_set_link_desc_addr(struct hal_wbm_link_desc *desc,
+					 u32 cookie, dma_addr_t paddr,
+					 enum hal_rx_buf_return_buf_manager rbm)
+{
+	desc->buf_addr_info.info0 = le32_encode_bits((paddr & HAL_ADDR_LSB_REG_MASK),
+						     BUFFER_ADDR_INFO0_ADDR);
+	desc->buf_addr_info.info1 =
+			le32_encode_bits(((u64)paddr >> HAL_ADDR_MSB_REG_SHIFT),
+					 BUFFER_ADDR_INFO1_ADDR) |
+			le32_encode_bits(rbm, BUFFER_ADDR_INFO1_RET_BUF_MGR) |
+			le32_encode_bits(cookie, BUFFER_ADDR_INFO1_SW_COOKIE);
+}
+
+u32 ath12k_wifi7_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc)
+{
+	u32 len;
+
+	len = le32_get_bits(READ_ONCE(desc->flags), HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
+	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
+
+	return len;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index b0b591eb5a0a..308f80427676 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -28,4 +28,10 @@ void ath12k_wifi7_hal_ce_src_set_desc(struct hal_ce_srng_src_desc *desc,
 				      u32 len, u32 id, u8 byte_swap_data);
 void ath12k_wifi7_hal_ce_dst_set_desc(struct hal_ce_srng_dest_desc *desc,
 				      dma_addr_t paddr);
+void
+ath12k_wifi7_hal_set_link_desc_addr(struct hal_wbm_link_desc *desc,
+				    u32 cookie, dma_addr_t paddr,
+				    enum hal_rx_buf_return_buf_manager rbm);
+u32
+ath12k_wifi7_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 113a0424d5eb..b764d5cd8aeb 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1009,5 +1009,7 @@ const struct hal_ops hal_qcn9274_ops = {
 	.ce_get_desc_size = ath12k_wifi7_hal_ce_get_desc_size,
 	.ce_src_set_desc = ath12k_wifi7_hal_ce_src_set_desc,
 	.ce_dst_set_desc = ath12k_wifi7_hal_ce_dst_set_desc,
+	.ce_dst_status_get_length = ath12k_wifi7_hal_ce_dst_status_get_length,
+	.set_link_desc_addr = ath12k_wifi7_hal_set_link_desc_addr,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 60a21137bd35..0985f929a4b5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -824,5 +824,7 @@ const struct hal_ops hal_wcn7850_ops = {
 	.ce_get_desc_size = ath12k_wifi7_hal_ce_get_desc_size,
 	.ce_src_set_desc = ath12k_wifi7_hal_ce_src_set_desc,
 	.ce_dst_set_desc = ath12k_wifi7_hal_ce_dst_set_desc,
+	.ce_dst_status_get_length = ath12k_wifi7_hal_ce_dst_status_get_length,
+	.set_link_desc_addr = ath12k_wifi7_hal_set_link_desc_addr,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
-- 
2.34.1


