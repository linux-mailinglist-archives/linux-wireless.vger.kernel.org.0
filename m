Return-Path: <linux-wireless+bounces-27915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41211BC8B77
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C9C3B509D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1852DF3C6;
	Thu,  9 Oct 2025 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QcVoFtMi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457F2E266A
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008291; cv=none; b=CqYyt+jt43hSPiAyBB0CGy0Cg6TYS79h3/Qv//Cn4OJ5Rn6xP373ZmB2DhtD525wqVSjUoRJx1lnRoV8wMLdgj4b/jmRYiSdQWxxbDCkWsgybFBl1/yyRwY15yEdl+YrWwdCyHXSfhotDnIs6Sh2wH1t45ADjPeaTrQJS6w/py0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008291; c=relaxed/simple;
	bh=ubZ7kj1ZP4ndlkSAObtTKjoZGAYuJhfbYPWMyHJtcJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkRDeUNIvSLaHTQ4NpHECP7AaZoyArRcKaRn8aneTE6P7wp5yfKbW/m3ZtiU3g6oTTLtQBpWgXQuUEDG7OH6YNqHIUrYkQHXGHaTz4ctNpHZZVWmUQI8JJI8209ShZ/D3BSrq653CXOl87JC+3/8YXv1vHzKDxxmf/DF+QCQa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QcVoFtMi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EIOf023272;
	Thu, 9 Oct 2025 11:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yuOQUZv1frbEJ96V07cJscka/zeRlWA/rRrqRcv1UGc=; b=QcVoFtMiLLFnbTcO
	FoeFFncSYMf+fdoxBHVmigBhA7EbY79zX9ulpUIUJjeZidW9QsJSm4OENQVpuoBm
	M5MW3nM9eolu9yS+VsR4oqZJby2tleH2M1n0Dj102OZpH4X5byZjS5a+esWe+M4/
	5sL/mENvBOad4KZmQbsBNdnu/xzrNkj7gvUOK9/pKVuK3bB/A7D0OszB+O9viuBY
	ll1z+GC1uHYCyoWv5G0PnIqh+vNy3a8BPUCgWI4UJNroX3solr+fBeQjTayj49SH
	9p6JCL+Sa2bhVmD62z+fB0Lkd+fKOdZFRAQ72Mbi/k9445AWTPlpOKVh3y+j8buZ
	dAITLA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m2hth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBQu7009085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:26 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:25 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 17/18] wifi: ath12k: Rename hal_ops to ops
Date: Thu, 9 Oct 2025 16:40:44 +0530
Message-ID: <20251009111045.1763001-18-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX0Z0wb4bwnqbk
 42ZS43PhIXf2jk01zaxUdBmsqOa94pbY89j0LqXLsFQhpkxxjgUC6pDtdEdTnjLuNEnJFpRazyA
 jtiW7wsoh04QTzVP9RskMvOO9su29ycDYz99V8NVqpWl4yp0EYCDK35DpUsE+n9tyA5SVxSmS/I
 xOP+Oe9WNMbJqrVjPaVzqV21l2DEqpSfXSXICUp9B7GyHaMI8uPvtBscAvdgHcgCuOkXbyk1ydg
 WDpWDLs9/wmviSkA2LohZyf3eb152q5B3B/3VJAXFvfLblb2UZxNAWbKf4xeCUo6U/RIPEIzan2
 rjx64JIiSeFsAXbt9zs5SXV3PjG2diuPTjDNiTQvQQRo64CjUuDdmcuFmWXBaVOE4DFbwL7+bSF
 K73UEteqwGtt/YW/pzsZUqdyd/khmw==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e7985f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=ZPJkkC-cH9Bn9y2QaC4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AxXm346Y35sECey7Y2Aqmdyz22XL3oLA
X-Proofpoint-ORIG-GUID: AxXm346Y35sECey7Y2Aqmdyz22XL3oLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Rename the hal_ops member in the HAL context to ops. The prefix is
dropped to avoid redundancy, as the structure already resides within
the HAL context.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      |  2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       | 16 +++---
 drivers/net/wireless/ath/ath12k/hal.c         | 50 +++++++++----------
 drivers/net/wireless/ath/ath12k/hal.h         |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   |  2 +-
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 60c4447c7489..aa45550301ed 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2052,7 +2052,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k_pdev_dp *dp_pdev,
 
 		rx_desc = (struct hal_rx_desc *)head_msdu->data;
 		hdr_desc =
-			ab->hal.hal_ops->rx_desc_get_msdu_payload(rx_desc);
+			ab->hal.ops->rx_desc_get_msdu_payload(rx_desc);
 
 		/* Base size */
 		wh = (struct ieee80211_hdr_3addr *)hdr_desc;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 327bf99afae2..27062109a3f3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -108,27 +108,27 @@ static inline u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
 static inline u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
 				      struct hal_rx_desc *desc)
 {
-	return ab->hal.hal_ops->rx_desc_get_l3_pad_bytes(desc);
+	return ab->hal.ops->rx_desc_get_l3_pad_bytes(desc);
 }
 
 static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
 						  struct hal_rx_desc *fdesc,
 						  struct hal_rx_desc *ldesc)
 {
-	ab->hal.hal_ops->rx_desc_copy_end_tlv(fdesc, ldesc);
+	ab->hal.ops->rx_desc_copy_end_tlv(fdesc, ldesc);
 }
 
 static inline void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
 						 struct hal_rx_desc *desc,
 						 u16 len)
 {
-	ab->hal.hal_ops->rx_desc_set_msdu_len(desc, len);
+	ab->hal.ops->rx_desc_set_msdu_len(desc, len);
 }
 
 static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 					      struct hal_rx_desc *rx_desc)
 {
-	return ab->hal.hal_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
+	return ab->hal.ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
 }
 
 static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
@@ -136,7 +136,7 @@ static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 {
 	u32 tlv_tag;
 
-	tlv_tag = ab->hal.hal_ops->rx_desc_get_mpdu_start_tag(rx_desc);
+	tlv_tag = ab->hal.ops->rx_desc_get_mpdu_start_tag(rx_desc);
 
 	return tlv_tag == HAL_RX_MPDU_START;
 }
@@ -145,7 +145,7 @@ static inline void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_base *ab,
 						   struct hal_rx_desc *desc,
 						   struct ieee80211_hdr *hdr)
 {
-	ab->hal.hal_ops->rx_desc_get_dot11_hdr(desc, hdr);
+	ab->hal.ops->rx_desc_get_dot11_hdr(desc, hdr);
 }
 
 static inline void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
@@ -153,13 +153,13 @@ static inline void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
 						       u8 *crypto_hdr,
 						       enum hal_encrypt_type enctype)
 {
-	ab->hal.hal_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
+	ab->hal.ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
 }
 
 static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_base *ab,
 						struct hal_rx_desc *desc)
 {
-	return ab->hal.hal_ops->rx_desc_get_msdu_src_link_id(desc);
+	return ab->hal.ops->rx_desc_get_msdu_src_link_id(desc);
 }
 
 static inline void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 296bd7824ae2..3f9c2183c9a6 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -10,76 +10,76 @@
 static void ath12k_hal_ce_dst_setup(struct ath12k_base *ab,
 				    struct hal_srng *srng, int ring_num)
 {
-	ab->hal.hal_ops->ce_dst_setup(ab, srng, ring_num);
+	ab->hal.ops->ce_dst_setup(ab, srng, ring_num);
 }
 
 static void ath12k_hal_srng_src_hw_init(struct ath12k_base *ab,
 					struct hal_srng *srng)
 {
-	ab->hal.hal_ops->srng_src_hw_init(ab, srng);
+	ab->hal.ops->srng_src_hw_init(ab, srng);
 }
 
 static void ath12k_hal_srng_dst_hw_init(struct ath12k_base *ab,
 					struct hal_srng *srng)
 {
-	ab->hal.hal_ops->srng_dst_hw_init(ab, srng);
+	ab->hal.ops->srng_dst_hw_init(ab, srng);
 }
 
 static void ath12k_hal_set_umac_srng_ptr_addr(struct ath12k_base *ab,
 					      struct hal_srng *srng)
 {
-	ab->hal.hal_ops->set_umac_srng_ptr_addr(ab, srng);
+	ab->hal.ops->set_umac_srng_ptr_addr(ab, srng);
 }
 
 static int ath12k_hal_srng_get_ring_id(struct ath12k_hal *hal,
 				       enum hal_ring_type type,
 				       int ring_num, int mac_id)
 {
-	return hal->hal_ops->srng_get_ring_id(hal, type, ring_num, mac_id);
+	return hal->ops->srng_get_ring_id(hal, type, ring_num, mac_id);
 }
 
 int ath12k_hal_srng_update_shadow_config(struct ath12k_base *ab,
 					 enum hal_ring_type ring_type,
 					 int ring_num)
 {
-	return ab->hal.hal_ops->srng_update_shadow_config(ab, ring_type,
+	return ab->hal.ops->srng_update_shadow_config(ab, ring_type,
 							  ring_num);
 }
 
 u32 ath12k_hal_ce_get_desc_size(struct ath12k_hal *hal, enum hal_ce_desc type)
 {
-	return hal->hal_ops->ce_get_desc_size(type);
+	return hal->ops->ce_get_desc_size(type);
 }
 
 void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id)
 {
-	ab->hal.hal_ops->tx_set_dscp_tid_map(ab, id);
+	ab->hal.ops->tx_set_dscp_tid_map(ab, id);
 }
 
 void ath12k_hal_tx_configure_bank_register(struct ath12k_base *ab,
 					   u32 bank_config, u8 bank_id)
 {
-	ab->hal.hal_ops->tx_configure_bank_register(ab, bank_config, bank_id);
+	ab->hal.ops->tx_configure_bank_register(ab, bank_config, bank_id);
 }
 
 void ath12k_hal_reoq_lut_addr_read_enable(struct ath12k_base *ab)
 {
-	ab->hal.hal_ops->reoq_lut_addr_read_enable(ab);
+	ab->hal.ops->reoq_lut_addr_read_enable(ab);
 }
 
 void ath12k_hal_reoq_lut_set_max_peerid(struct ath12k_base *ab)
 {
-	ab->hal.hal_ops->reoq_lut_set_max_peerid(ab);
+	ab->hal.ops->reoq_lut_set_max_peerid(ab);
 }
 
 void ath12k_hal_write_ml_reoq_lut_addr(struct ath12k_base *ab, dma_addr_t paddr)
 {
-	ab->hal.hal_ops->write_ml_reoq_lut_addr(ab, paddr);
+	ab->hal.ops->write_ml_reoq_lut_addr(ab, paddr);
 }
 
 void ath12k_hal_write_reoq_lut_addr(struct ath12k_base *ab, dma_addr_t paddr)
 {
-	ab->hal.hal_ops->write_reoq_lut_addr(ab, paddr);
+	ab->hal.ops->write_reoq_lut_addr(ab, paddr);
 }
 
 void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
@@ -87,25 +87,25 @@ void ath12k_hal_setup_link_idle_list(struct ath12k_base *ab,
 				     u32 nsbufs, u32 tot_link_desc,
 				     u32 end_offset)
 {
-	ab->hal.hal_ops->setup_link_idle_list(ab, sbuf, nsbufs, tot_link_desc,
+	ab->hal.ops->setup_link_idle_list(ab, sbuf, nsbufs, tot_link_desc,
 					      end_offset);
 }
 
 void ath12k_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
 {
-	ab->hal.hal_ops->reo_hw_setup(ab, ring_hash_map);
+	ab->hal.ops->reo_hw_setup(ab, ring_hash_map);
 }
 
 void ath12k_hal_reo_init_cmd_ring(struct ath12k_base *ab, struct hal_srng *srng)
 {
-	ab->hal.hal_ops->reo_init_cmd_ring(ab, srng);
+	ab->hal.ops->reo_init_cmd_ring(ab, srng);
 }
 
 void ath12k_hal_rx_buf_addr_info_set(struct ath12k_hal *hal,
 				     struct ath12k_buffer_addr *binfo,
 				     dma_addr_t paddr, u32 cookie, u8 manager)
 {
-	hal->hal_ops->rx_buf_addr_info_set(binfo, paddr, cookie, manager);
+	hal->ops->rx_buf_addr_info_set(binfo, paddr, cookie, manager);
 }
 
 void ath12k_hal_rx_buf_addr_info_get(struct ath12k_hal *hal,
@@ -113,18 +113,18 @@ void ath12k_hal_rx_buf_addr_info_get(struct ath12k_hal *hal,
 				     dma_addr_t *paddr, u32 *msdu_cookies,
 				     u8 *rbm)
 {
-	hal->hal_ops->rx_buf_addr_info_get(binfo, paddr, msdu_cookies, rbm);
+	hal->ops->rx_buf_addr_info_get(binfo, paddr, msdu_cookies, rbm);
 }
 
 void ath12k_hal_cc_config(struct ath12k_base *ab)
 {
-	ab->hal.hal_ops->cc_config(ab);
+	ab->hal.ops->cc_config(ab);
 }
 
 enum hal_rx_buf_return_buf_manager
 ath12k_hal_get_idle_link_rbm(struct ath12k_hal *hal, u8 device_id)
 {
-	return hal->hal_ops->get_idle_link_rbm(hal, device_id);
+	return hal->ops->get_idle_link_rbm(hal, device_id);
 }
 
 static int ath12k_hal_alloc_cont_rdp(struct ath12k_hal *hal)
@@ -266,27 +266,27 @@ void ath12k_hal_ce_src_set_desc(struct ath12k_hal *hal,
 				dma_addr_t paddr, u32 len, u32 id,
 				u8 byte_swap_data)
 {
-	hal->hal_ops->ce_src_set_desc(desc, paddr, len, id, byte_swap_data);
+	hal->ops->ce_src_set_desc(desc, paddr, len, id, byte_swap_data);
 }
 
 void ath12k_hal_ce_dst_set_desc(struct ath12k_hal *hal,
 				struct hal_ce_srng_dest_desc *desc,
 				dma_addr_t paddr)
 {
-	hal->hal_ops->ce_dst_set_desc(desc, paddr);
+	hal->ops->ce_dst_set_desc(desc, paddr);
 }
 
 u32 ath12k_hal_ce_dst_status_get_length(struct ath12k_hal *hal,
 					struct hal_ce_srng_dst_status_desc *desc)
 {
-	return hal->hal_ops->ce_dst_status_get_length(desc);
+	return hal->ops->ce_dst_status_get_length(desc);
 }
 
 void ath12k_hal_set_link_desc_addr(struct ath12k_hal *hal,
 				   struct hal_wbm_link_desc *desc, u32 cookie,
 				   dma_addr_t paddr, int rbm)
 {
-	hal->hal_ops->set_link_desc_addr(desc, cookie, paddr, rbm);
+	hal->ops->set_link_desc_addr(desc, cookie, paddr, rbm);
 }
 
 void *ath12k_hal_srng_dst_peek(struct ath12k_base *ab, struct hal_srng *srng)
@@ -702,7 +702,7 @@ int ath12k_hal_srng_init(struct ath12k_base *ab)
 	struct ath12k_hal *hal = &ab->hal;
 	int ret;
 
-	ret = hal->hal_ops->create_srng_config(hal);
+	ret = hal->ops->create_srng_config(hal);
 	if (ret)
 		goto err_hal;
 
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 63ad67318b0e..68c873a1f454 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1135,7 +1135,7 @@ struct ath12k_hal {
 	} wrp;
 
 	struct device *dev;
-	const struct hal_ops *hal_ops;
+	const struct hal_ops *ops;
 	const struct ath12k_hw_regs *regs;
 	const struct ath12k_hw_hal_params *hal_params;
 	/* Available REO blocking resources bitmap */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index 5ecbbf548b05..df25164e08f2 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -53,6 +53,6 @@ void ath12k_wifi7_dp_extract_rx_desc_data(struct ath12k_base *ab,
 					  struct hal_rx_desc *rx_desc,
 					  struct hal_rx_desc *ldesc)
 {
-	ab->hal.hal_ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
+	ab->hal.ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
 }
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index e42970346e3d..84c0ba2d1fbe 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -50,7 +50,7 @@ int ath12k_wifi7_hal_init(struct ath12k_base *ab)
 
 	memset(hal, 0, sizeof(*hal));
 
-	hal->hal_ops = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_ops;
+	hal->ops = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_ops;
 	hal->hal_desc_sz = ath12k_wifi7_hw_ver_map[ab->hw_rev].hal_desc_sz;
 	hal->tcl_to_wbm_rbm_map = ath12k_wifi7_hw_ver_map[ab->hw_rev].tcl_to_wbm_rbm_map;
 	hal->regs = ath12k_wifi7_hw_ver_map[ab->hw_rev].hw_regs;
-- 
2.34.1


