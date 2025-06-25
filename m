Return-Path: <linux-wireless+bounces-24454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE0AE74A0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 04:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC63A91E9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 02:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507D1991B6;
	Wed, 25 Jun 2025 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EXSQfTDY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A173074BD;
	Wed, 25 Jun 2025 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817194; cv=none; b=t9RIEOY8LLOaXla8yi6qJOdNvowncsdR2bSWt+C/bEsMGbcBt545puc6RdgLNJS8c6wpVtqre+0lu+kP2jBsA9RT2FhX+tv0SwhbXZQBzzM4pk/xu5w+17PIPeWSP18rtqzo1uK+LT+JpFltAjB41V08vWcnMphtYz4dbrvlWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817194; c=relaxed/simple;
	bh=YT+KkhqdiCNkSCu7M3gdcOkidLb2vRWJFnSJ3zsGz1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eHi4w+l6COeak/980CK/LTj7tqOBv3YS0dN/LxQHGG6oiKCFI3GN1ai4BiWivSSqksCiBUZEE6TBgL4yf6VSZwo5HAOe3CvgkTZkUA7VBrnZcQJx+VvvIcAL8nEBUHF7lHU3LYELLlWKn+hUBuEZMrcTLo160B3SUjXJwzuWzyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EXSQfTDY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OGnrjD015264;
	Wed, 25 Jun 2025 02:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r/1N/ZEHKCn7//UMBjQ6dKobWUiWwTZry94pyLxUFIc=; b=EXSQfTDYn62Gc/PU
	9y4u6ymqb8ow7wg26bnQB4wkVDfbPeKXW1qY2/Sq8saVFPtsVWXlN/DaQo1Kw5k8
	eMICcUlEUEhZCxQK4BaKB1J7OQryX6NR2PB+rdT7QpjpYbYGN3CbWnv+Ajyu+HLD
	46659Q14bXYB3A6cugfVNRmOWvOYk03D7/pWxVkhXiUfcKCuGht5/oRKTv9YDoVM
	NnOkPiG6X+Ai3oAZfC0DeAlC6bMcGgo5TfQxl2Jw7EDqeFQQ4rxxhmjyr0vZsWoe
	s8rt6mJkeUrIovv+YxmHXxFPLSJeHhLMa7RIg1GVLUfVQzWWIQLTorqFDrvi5Ps8
	I99Iug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqmnmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 02:06:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P26QRt020815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 02:06:26 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Jun
 2025 19:06:24 -0700
Message-ID: <70b25ff3-b366-4e2d-a52a-0b2d50ce88c4@quicinc.com>
Date: Wed, 25 Jun 2025 10:06:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250526114803.2122-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9wFME6JHaVT7uTiZXT16ajUDsX2b25Hq
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685b59a3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=ISufsDh2QXdYQW1nCwMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9wFME6JHaVT7uTiZXT16ajUDsX2b25Hq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAxNSBTYWx0ZWRfX3S28tbICocQ9
 VLmPHfXR6UhLNOz5QkCsolXN44KhR3xp8oqIT+J5Ink7DFL4DgZQZ30dkOk2TCUyV8OwnOSJH5e
 15jT9z8TkTH6sRM7hiZKV+6HZTmodIYfnTa+awBEePGEEKyD5ThEZwO6YijeuybtHeacIbrnvZ8
 khJil14J+l1ae9JQUbv4XrQHYSkmd6B4rZ0uRz1MSEsAwKzOWXvX0FrqcuDDG2oNhZzsxflRRD6
 KqhwsmM0C2xrEm9bHj0+Hbc3QMFrIhBn7ssVzPC+QE37pKng8GT4WK6c/xZ67aJK7OezJGkSq9B
 Eu03g3zZApNCGhXQz4eoGAkSA8CEOHA7SzwnbJLkNTVUrw/cq8jRaO9gD9Od96afgvjj2MhDuNI
 XDowaX4HfJ9T242r/2xe/wGbxMuREVii4QRXn5wLKfAPsVNTGEAqoYFx0qecsh7awd5cfr3/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=634 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250015



On 5/26/2025 7:48 PM, Johan Hovold wrote:
> Add the missing memory barriers to make sure that destination ring
> descriptors are read after the head pointers to avoid using stale data
> on weakly ordered architectures like aarch64.
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org	# 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 19 +++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/dp_tx.c |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index ea2959305dec..dfe2d889c20f 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -3851,6 +3851,9 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
>  
>  	ath11k_hal_srng_access_begin(ab, srng);
>  
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>  	while (budget &&
>  	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
>  		struct hal_reo_dest_ring *reo_desc = (struct hal_reo_dest_ring *)desc;
> @@ -4154,6 +4157,9 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
>  
>  	ath11k_hal_srng_access_begin(ab, srng);
>  
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>  	while (budget) {
>  		rx_desc = ath11k_hal_srng_dst_get_next_entry(ab, srng);
>  		if (!rx_desc)
> @@ -4280,6 +4286,9 @@ int ath11k_dp_process_rxdma_err(struct ath11k_base *ab, int mac_id, int budget)
>  
>  	ath11k_hal_srng_access_begin(ab, srng);
>  
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>  	while (quota-- &&
>  	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
>  		ath11k_hal_rx_reo_ent_paddr_get(ab, desc, &paddr, &desc_bank);
> @@ -4353,6 +4362,9 @@ void ath11k_dp_process_reo_status(struct ath11k_base *ab)
>  
>  	ath11k_hal_srng_access_begin(ab, srng);
>  
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>  	while ((reo_desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
>  		tag = FIELD_GET(HAL_SRNG_TLV_HDR_TAG, *reo_desc);
>  
> @@ -5168,6 +5180,9 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
>  	rx_bufs_used = 0;
>  	rx_mon_stats = &pmon->rx_mon_stats;
>  
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>  	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
>  		struct sk_buff *head_msdu, *tail_msdu;
>  
> @@ -5630,6 +5645,10 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
>  	spin_lock_bh(&mon_dst_srng->lock);
>  
>  	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
> +
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>  	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
>  		head_msdu = NULL;
>  		tail_msdu = NULL;
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 8522c67baabf..549d17d90503 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -700,6 +700,9 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
>  
>  	ath11k_hal_srng_access_begin(ab, status_ring);
>  
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>  	while ((ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) !=
>  		tx_ring->tx_status_tail) &&
>  	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, status_ring))) {

Johan, dma_rmb() is put inside _srng_access_begin() for ath12k, but here inside each
caller. Can we achieve consistency between two drivers?




