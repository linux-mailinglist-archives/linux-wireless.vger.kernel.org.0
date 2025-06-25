Return-Path: <linux-wireless+bounces-24469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0271AE7E44
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 11:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A540188A579
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEDD29A323;
	Wed, 25 Jun 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NS+ytyfS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031DC2877DC;
	Wed, 25 Jun 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845568; cv=none; b=vB8/qWCfUdFolHYKud8zoHt/IsGvnSR6jV/gUUr0qRiFQHkzr9hsxfXRz7IyhuCF0Z+hC0DDkOOpReA98aIF1TwSBMz7fnBpTQvdJmgHFNOfm7f/agjraQhg8CcjtrfPz/n8xM0yYD3i23XSqYslvMRAqxORHw2HcRErIviiT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845568; c=relaxed/simple;
	bh=n3xqORREZKdf2rccDd3FRrw3YnRypr2lyD8j2GDqdQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C0osM7ntT7LQPYmH6pDQXkeTdvQ3zRTz0dZeyhQjLxFKD+GGhk/HtPKFF+xKzBRNxmbX2RsTbLIddWa+xl6Uk5sWF35ZxXgN8NNKUwGJgSv6oIVlbFCLndNd9uas8tjD6+XF4dUA9l03VIeuHy2f2q0OPOgODufrgnKHUbNPyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NS+ytyfS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P89juS015531;
	Wed, 25 Jun 2025 09:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MWRBYYbdI2suFA4YYYEBwVodLd67TfdJKU/AXlno+H4=; b=NS+ytyfSz3QRkjmJ
	FffnMK+i85M9X8Z3wS0W5ZWrnUv40yOBgzH7JxGgI7dgeFDjL6IP777PNs220Zd4
	9MS1/Fsn1aoUWuAqy3ny13ivK4fF3mmJXixEqYgM2b5TjjN8Rn8errdn6PpWD0gv
	xSQEeQ0HrCZgvzHPrEiVuBOARYuKd6JoWwp/ErxdK/hV9PkCxP3pq/SMiSJUajjU
	uGVMFbDf8Yt8c0hiX03fC78Qg6/iJyEWX6bSCTmLbL7KktYWwgylcdyHpOKd0AJn
	uzabluOE+Z1SY2QnmF6JthxgNwTLHrjkLzNwI7LrhthmokeyZqSv5tFlID+p0NOc
	ijg/+Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec269mpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:59:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P9xKtj023120
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:59:20 GMT
Received: from [10.133.33.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 02:59:18 -0700
Message-ID: <9aacb7bd-c613-40d2-b901-53419b57c130@quicinc.com>
Date: Wed, 25 Jun 2025 17:59:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] wifi: ath11k: fix dest ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
 <20250604143457.26032-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250604143457.26032-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3NCBTYWx0ZWRfXxU5BxMuNh6pn
 Pp7XW06PMCB67A5A6cKDTlmyDt+0f8DaXkj4ub0riMUkKeft338d3Y0MstSxa5KDp3yUN2Z3gMd
 ithF0wXdhIJhd9VRrHvj8AstINcPnozC+q685q14EECj+Z7WL+CKTacQnDo3L1vWoqKY4dsviH1
 q8KmwQfUe0ATybJ5/cNB3wmrT9dNfo0SGt11jAffiTQ/ygWEaQ7SS3s2JbUUyl7aVG2o5hY0dmv
 byj6YzZmuomVNRd+oAIQ0QEX+qlAGehdwEFJbWOk5RNbO6R3Qwqp2vgMrKqydBczDBlQMdJXpvc
 TX66XnVV3C70cDXfgv5dkD/VH3Lqln6sVRb0vfAE3QUNaD6u2poOCLtYDaTGYEC61kAZQHu2u/l
 FdFI0tYa1MdSzTgJan7Oh8sg8RQcq6p725pDeb1EsGCEi78q7Y5Y/z09SjFiT6J0UKX6fVoR
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685bc879 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=ISufsDh2QXdYQW1nCwMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6E7vLhd4BjdK1lPRI8HXVZaJqv-x44Kz
X-Proofpoint-ORIG-GUID: 6E7vLhd4BjdK1lPRI8HXVZaJqv-x44Kz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=830 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250074



On 6/4/2025 10:34 PM, Johan Hovold wrote:
> Add the missing memory barrier to make sure that destination ring
> descriptors are read after the head pointers to avoid using stale data
> on weakly ordered architectures like aarch64.
> 
> The barrier is added to the ath11k_hal_srng_access_begin() helper for
> symmetry with follow-on fixes for source ring buffer corruption which
> will add barriers to ath11k_hal_srng_access_end().
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org	# 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/ce.c    |  3 ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c |  3 ---
>  drivers/net/wireless/ath/ath11k/hal.c   | 12 +++++++++++-
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
> index 9d8efec46508..39d9aad33bc6 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.c
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -393,9 +393,6 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
>  		goto err;
>  	}
>  
> -	/* Make sure descriptor is read after the head pointer. */
> -	dma_rmb();
> -
>  	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
>  
>  	*skb = pipe->dest_ring->skb[sw_index];
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index ea2959305dec..d8dab182a9af 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2650,9 +2650,6 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
>  try_again:
>  	ath11k_hal_srng_access_begin(ab, srng);
>  
> -	/* Make sure descriptor is read after the head pointer. */
> -	dma_rmb();
> -
>  	while (likely(desc =
>  	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
>  									     srng))) {
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index 8cb1505a5a0c..921114686ba3 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -823,13 +823,23 @@ u32 *ath11k_hal_srng_src_peek(struct ath11k_base *ab, struct hal_srng *srng)
>  
>  void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
>  {
> +	u32 hp;
> +
>  	lockdep_assert_held(&srng->lock);
>  
>  	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  		srng->u.src_ring.cached_tp =
>  			*(volatile u32 *)srng->u.src_ring.tp_addr;
>  	} else {
> -		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> +		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> +
> +		if (hp != srng->u.dst_ring.cached_hp) {
> +			srng->u.dst_ring.cached_hp = hp;
> +			/* Make sure descriptor is read after the head
> +			 * pointer.
> +			 */
> +			dma_rmb();
> +		}
>  
>  		/* Try to prefetch the next descriptor in the ring */
>  		if (srng->flags & HAL_SRNG_FLAGS_CACHED)

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>

