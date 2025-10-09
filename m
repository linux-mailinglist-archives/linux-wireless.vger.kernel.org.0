Return-Path: <linux-wireless+bounces-27912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D69BC8B6E
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03091892772
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984972E090B;
	Thu,  9 Oct 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RX2Gy4sA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46D2E0419
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008285; cv=none; b=WghfNLgekKGlDx6hLenJ6iFqY9pnlJfx5UVN9AJgxWDLUXPPZ7XMROQZNIFkyumw4FVNvP7m9SN3bWdR4/z7OCp8bYCFNiOpcbULtcPiHcXJM/G7PRPxSJkCo5P3Tv/STVQnEU3UIpsQv0qk+cR1jy17EkkQ3w/KSYf38d3DZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008285; c=relaxed/simple;
	bh=HFiGJ0JtM5dHNlCM864FTcscnvF6U0nge1HpY9H2i+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1Ba39JBWUDmvYjSjbv7yDjGYlnI7N9PbGZcXY3bQaka6d3o+xFJOjFU8ocVASS9JOb1z4Yj7YLFBI0bRld+dqatnEwjEmCS2oNGTRXRW1S0XqLMIkZbVUj7jN7z2yoemWVx142gk+pD3Musv8TYqvGzEhpMiJm9AQEfrOsGdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RX2Gy4sA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EOQw029750;
	Thu, 9 Oct 2025 11:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HplF0G7qfIKFjmNGR1eKsYVzlPUPum4OVqS8cWwu28k=; b=RX2Gy4sAWoQhSk/f
	h0cXvwOlvtW1iidXg4eeoLWpwnE3Hyi+UYdz31yvW8JlLX8loiv9OnJW88NN4m0m
	sR1TpsBRzyiG8afVkCsUFI+4CP9HduOREpDqHzD63zcBbkq+HOhpPD3ox5UNNpNp
	I7Ih61z59SP6h0GpqAzoClnryBBCMObbyx8WO9ARF/YZqzwHzJQ1Us3/W/esNHqr
	gSo9lOwqP03H9IThyghadZ4mxTjhHETveISlDyoLzxxrU6grSiIK5xmPf/MdOfEM
	njnY9AyRiEwbrc5hkOQQ0nVsuighsijrH8Q/gxXOF8uak/DwZLeZSgzrpu/fAJzS
	Wzo08Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nah35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBKF2011597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:20 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:19 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 13/18] wifi: ath12k: Move HAL REO and Rx buf related APIs to wifi7 directory
Date: Thu, 9 Oct 2025 16:40:40 +0530
Message-ID: <20251009111045.1763001-14-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e79859 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=x2GFiomjbweN4U_LYscA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 4jurt3axKMWPi_NIfzihsgEK7W0XtbjV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0RszoQzywQYI
 67ow/XxCughgrNInU4b4MTg5/We75O7v0KHMLeyraKO4i8tscm+LZgScbX/z0Toi/i17Um2ycSS
 yL0vHEfbh5UJL5YqT6h1DFU3xno7kbSj2esZPup6cNWnYjqDE5Vj1fVNiOPK5kqVVYNjgr2JMKW
 +BAyVS6nZdhj9K0V3IHs/TExRGZ1JKu2Uv9mVO5V6dwtvannXw7iCpvIBfwPbTv2O0GdXv1pQNC
 uT2GcTFbXQLWeFQUNo57l2GxGazmBbTdg5wVUH7bJFRJye1Yoaf1vcp9vc/5PF+aatyTZxVD+eP
 W3ljKwP7QaLjPDaVLH0vZcRD5PQ7zIetPREFQTMZPRqzjgl8XI7qQ9JK/im6ER4tsNYymf1W0v9
 6MIeKJW/5gFsEVv3oiu1RfVaMgonIQ==
X-Proofpoint-GUID: 4jurt3axKMWPi_NIfzihsgEK7W0XtbjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move the hardware specific HAL APIs to hal.c file
inside wifi7 directory. These APIs will be called
through the hal_ops mechanism, which are registered
separately by qcn and wcn

Handling following APIs:
ath12k_wifi7_hal_reo_qdesc_setup
ath12k_wifi7_hal_reo_init_cmd_ring
ath12k_wifi7_hal_reo_hw_setup
ath12k_wifi7_hal_rx_buf_addr_info_set
ath12k_wifi7_hal_rx_buf_addr_info_get

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dbring.c      |  4 +--
 drivers/net/wireless/ath/ath12k/dp.c          |  4 +--
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  3 ++-
 drivers/net/wireless/ath/ath12k/hal.c         | 25 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hal.h         | 23 ++++++++++++-----
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  4 +++
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |  6 +++++
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  4 +++
 8 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dbring.c b/drivers/net/wireless/ath/ath12k/dbring.c
index 093298f8acab..a387cb9554d2 100644
--- a/drivers/net/wireless/ath/ath12k/dbring.c
+++ b/drivers/net/wireless/ath/ath12k/dbring.c
@@ -54,7 +54,7 @@ static int ath12k_dbring_bufs_replenish(struct ath12k *ar,
 	cookie = u32_encode_bits(ar->pdev_idx, DP_RXDMA_BUF_COOKIE_PDEV_ID) |
 		 u32_encode_bits(buf_id, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
-	ath12k_wifi7_hal_rx_buf_addr_info_set(desc, paddr, cookie, 0);
+	ath12k_hal_rx_buf_addr_info_set(&ab->hal, desc, paddr, cookie, 0);
 
 	ath12k_hal_srng_access_end(ab, srng);
 
@@ -297,7 +297,7 @@ int ath12k_dbring_buffer_release_event(struct ath12k_base *ab,
 
 		num_buff_reaped++;
 
-		ath12k_wifi7_hal_rx_buf_addr_info_get(&desc, &paddr, &cookie, &rbm);
+		ath12k_hal_rx_buf_addr_info_get(&ab->hal, &desc, &paddr, &cookie, &rbm);
 
 		buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index b2c04fc460d9..faba234a6671 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -562,7 +562,7 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 	}
 
 	srng = &ab->hal.srng_list[dp->reo_cmd_ring.ring_id];
-	ath12k_wifi7_hal_reo_init_cmd_ring(ab, srng);
+	ath12k_hal_reo_init_cmd_ring(ab, srng);
 
 	ret = ath12k_dp_srng_setup(ab, &dp->reo_status_ring, HAL_REO_STATUS,
 				   0, 0, DP_REO_STATUS_RING_SIZE);
@@ -586,7 +586,7 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 			HAL_HASH_ROUTING_RING_SW3 << 24 |
 			HAL_HASH_ROUTING_RING_SW4 << 28;
 
-	ath12k_wifi7_hal_reo_hw_setup(ab, ring_hash_map);
+	ath12k_hal_reo_hw_setup(ab, ring_hash_map);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 5f70bc5e3b99..424cf1d4a1fc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -145,7 +145,8 @@ int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab,
 
 		num_remain--;
 
-		ath12k_wifi7_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
+		ath12k_hal_rx_buf_addr_info_set(&ab->hal, desc, paddr, cookie,
+						mgr);
 	}
 
 	goto out;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index b3010eea9afc..00cd6dcb5bad 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -96,6 +96,31 @@ void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 					      end_offset);
 }
 
+void ath12k_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
+{
+	ab->hal.hal_ops->reo_hw_setup(ab, ring_hash_map);
+}
+
+void ath12k_hal_reo_init_cmd_ring(struct ath12k_base *ab, struct hal_srng *srng)
+{
+	ab->hal.hal_ops->reo_init_cmd_ring(ab, srng);
+}
+
+void ath12k_hal_rx_buf_addr_info_set(struct ath12k_hal *hal,
+				     struct ath12k_buffer_addr *binfo,
+				     dma_addr_t paddr, u32 cookie, u8 manager)
+{
+	hal->hal_ops->rx_buf_addr_info_set(binfo, paddr, cookie, manager);
+}
+
+void ath12k_hal_rx_buf_addr_info_get(struct ath12k_hal *hal,
+				     struct ath12k_buffer_addr *binfo,
+				     dma_addr_t *paddr, u32 *msdu_cookies,
+				     u8 *rbm)
+{
+	hal->hal_ops->rx_buf_addr_info_get(binfo, paddr, msdu_cookies, rbm);
+}
+
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_hal *hal)
 {
 	size_t size;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 0c8262675120..2e85299f3685 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1729,15 +1729,17 @@ struct hal_ops {
 				     struct hal_wbm_idle_scatter_list *sbuf,
 				     u32 nsbufs, u32 tot_link_desc,
 				     u32 end_offset);
+	void (*reo_init_cmd_ring)(struct ath12k_base *ab,
+				  struct hal_srng *srng);
+	void (*reo_hw_setup)(struct ath12k_base *ab, u32 ring_hash_map);
+	void (*rx_buf_addr_info_set)(struct ath12k_buffer_addr *binfo,
+				     dma_addr_t paddr, u32 cookie, u8 manager);
+	void (*rx_buf_addr_info_get)(struct ath12k_buffer_addr *binfo,
+				     dma_addr_t *paddr, u32 *msdu_cookies,
+				     u8 *rbm);
 };
 
 u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
-void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
-				      int tid, u32 ba_window_size,
-				      u32 start_seq, enum hal_pn_type type);
-void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
-					struct hal_srng *srng);
-void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
 dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
@@ -1806,4 +1808,13 @@ void ath12k_hal_reoq_lut_set_max_peerid(struct ath12k_base *ab);
 void ath12k_hal_write_reoq_lut_addr(struct ath12k_base *ab, dma_addr_t paddr);
 void
 ath12k_hal_write_ml_reoq_lut_addr(struct ath12k_base *ab, dma_addr_t paddr);
+void ath12k_hal_reo_init_cmd_ring(struct ath12k_base *ab, struct hal_srng *srng);
+void ath12k_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
+void ath12k_hal_rx_buf_addr_info_set(struct ath12k_hal *hal,
+				     struct ath12k_buffer_addr *binfo,
+				     dma_addr_t paddr, u32 cookie, u8 manager);
+void ath12k_hal_rx_buf_addr_info_get(struct ath12k_hal *hal,
+				     struct ath12k_buffer_addr *binfo,
+				     dma_addr_t *paddr, u32 *msdu_cookies,
+				     u8 *rbm);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 9cbae6d11dd8..fb723e971f5d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1020,5 +1020,9 @@ const struct hal_ops hal_qcn9274_ops = {
 	.write_reoq_lut_addr = ath12k_wifi7_hal_write_reoq_lut_addr,
 	.write_ml_reoq_lut_addr = ath12k_wifi7_hal_write_ml_reoq_lut_addr,
 	.setup_link_idle_list = ath12k_wifi7_hal_setup_link_idle_list,
+	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring,
+	.reo_hw_setup = ath12k_wifi7_hal_reo_hw_setup,
+	.rx_buf_addr_info_set = ath12k_wifi7_hal_rx_buf_addr_info_set,
+	.rx_buf_addr_info_get = ath12k_wifi7_hal_rx_buf_addr_info_get,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index 821b63914f64..39ae33ca17f4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -868,5 +868,11 @@ void ath12k_hal_rx_msdu_list_get(struct ath12k *ar,
 				 struct hal_rx_msdu_link *link_desc,
 				 struct hal_rx_msdu_list *msdu_list,
 				 u16 *num_msdus);
+void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
+					struct hal_srng *srng);
+void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
+void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
+				      int tid, u32 ba_window_size,
+				      u32 start_seq, enum hal_pn_type type);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 2e645f8f4a14..33f8ddcedd83 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -835,5 +835,9 @@ const struct hal_ops hal_wcn7850_ops = {
 	.write_reoq_lut_addr = ath12k_wifi7_hal_write_reoq_lut_addr,
 	.write_ml_reoq_lut_addr = ath12k_wifi7_hal_write_ml_reoq_lut_addr,
 	.setup_link_idle_list = ath12k_wifi7_hal_setup_link_idle_list,
+	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring,
+	.reo_hw_setup = ath12k_wifi7_hal_reo_hw_setup,
+	.rx_buf_addr_info_set = ath12k_wifi7_hal_rx_buf_addr_info_set,
+	.rx_buf_addr_info_get = ath12k_wifi7_hal_rx_buf_addr_info_get,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
-- 
2.34.1


