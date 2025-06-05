Return-Path: <linux-wireless+bounces-23738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D42ACECA4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF2116FE51
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 09:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F082063FD;
	Thu,  5 Jun 2025 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="peX41RTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD3A927;
	Thu,  5 Jun 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749114790; cv=none; b=gEFmw8mSEAnnYAbIrPe7m9ynO7keH7m89589vLKWQylEEV9DrDVnPmIZTnjnbcAtTGSOQxIJVyotNeBIxUczvQLvuCKiHiZGmpJYDjhilJuBOQmdd3QL+WWCbYHmsljk5k7Zre11Jdr8z4IuO3ywxPhJOzuRV2daMWlb66NnaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749114790; c=relaxed/simple;
	bh=G++elx2LCqVPMzd1qaMXiMItgUkW1e7Mp3r17N/MptE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F9y/BX0xa627qMcTX1NhGLJ6lzSjDbFC/LifY8EVidqOIJt9JEX6Hp1DiSwj/4lXbKBo+kE5QgWQafRgugtEo6uS+5HkWNNS5RB3DUfppYepO+MKxzLRWMsayPUjpd5A6+9cg43H9yqYTeS4PRlm3eeeDyOI045tZHmzJ6JZz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=peX41RTT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557AioQ006342;
	Thu, 5 Jun 2025 09:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+sJbkp7Z3oHzA6Mj9+h6lPD2ASqtY2mNiec+zkMik5s=; b=peX41RTToAJaAcnr
	Rzuck/hJovHhbeTKuu1csfkwy7RwUJW1XlCvC9KQ80TEpHAJ/33+6a5sLa1GiNon
	3RzhPk7YoHsk3vMgvVmMYTqahc9S2JfpMw1lfSlizOwPFq9v0qA06L2C9bPxa9Ho
	9BII5uqU+tmHOuVk2IXIOAomRP1OyPcmLxStxSYTkxkDWQCIiBzHYhTL6f8G6Q7W
	cKDmSUJ5UMwnJSGjBQmBHuRy7PQhjV6mFW/kiqc9W8wD8I5T0ftNZXS1yxflSEqR
	LKdUi3YqZhxhgEX6CGBGyFFmq9VoPelvg2bR0Jt6LwKLdPDQVqSBd2ECi1vbs2o1
	hR1nQw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t0sg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 09:13:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5559D2iF010348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 09:13:02 GMT
Received: from [10.253.10.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 02:13:00 -0700
Message-ID: <b3432e80-9a54-4338-8991-606d1484dcc5@quicinc.com>
Date: Thu, 5 Jun 2025 17:12:57 +0800
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
X-Proofpoint-ORIG-GUID: rCjR7tm-7zmN6W2-66X499j-GCsEmhtX
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=68415f9f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=ISufsDh2QXdYQW1nCwMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rCjR7tm-7zmN6W2-66X499j-GCsEmhtX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3OSBTYWx0ZWRfX7DGYr96K5foe
 W4Lyk7sqlm0Uw3O/sibVX07X64AnNWkAYka2cQFqZhQQgb01kzjxKYLO3Qt+onVCW8fdyyyKmBt
 Idu+xoM3SFLdynu3K2Yqy85DJRUYFTvrWl3PLmrdx1OwU5eu2L/QKiE8opu0VtPRBtkDsUG9onD
 +NnuSVERbpno0hLp/dZEJeTg0UPOoiwQQIbqHJAau8AGnefGwmg60bsJLu0z3slvek6xESmtelc
 wVCVmAYHe35H7Ar9ohC3Hhc153a/3CfPOlVZVOxkv70/UFnaRp4KViEjSiDgzPZPu2xLKE3Un5H
 eOdks9uQnNQBHqT954HRYomjw8l2SVu5NGRtOCZ0GeaMfrnJskr/A9Gb1FZkedzteDvfAYwppag
 ij0OGiayAXxO0OGKKy4P+syBfd5lu7XwnsSYu0CxpIdKVgiHy/4ERWx+AVWojusChfto8UTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=880 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050079



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

My ath12k comments apply here: this consumes more CPU cycles

> +			srng->u.dst_ring.cached_hp = hp;
> +			/* Make sure descriptor is read after the head
> +			 * pointer.
> +			 */
> +			dma_rmb();
> +		}
>  
>  		/* Try to prefetch the next descriptor in the ring */
>  		if (srng->flags & HAL_SRNG_FLAGS_CACHED)


