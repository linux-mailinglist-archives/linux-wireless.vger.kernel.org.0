Return-Path: <linux-wireless+bounces-23735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1591BACEC1E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F24A1898CEF
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950E91FBE87;
	Thu,  5 Jun 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ms6LICTt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C701DC07D;
	Thu,  5 Jun 2025 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112911; cv=none; b=hRb1uhxP5+qqFNe5xtVvS4SzrcjpQb194XC+LLb/CPZrXNy+fkpM/joufH6wR1mO5FOHpA0Inb13hsZoGlWg2ErBboA7O4BFR+2P6VPiRKADlD8Jn2aPOmEOVnGtkSSueuyqioz7Yx3kI9xtfUDCQ8GCdZHuCqQa2QZytIkbke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112911; c=relaxed/simple;
	bh=IHkvBp5TpjBEe0WJ5sx/3VBj07I9aHjoioq4r+ln4h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kpVoXVKcQzO6ibEmdrvtCgv2OSH5aHcOgSEX81INdd+HvQFA/v3LKSADQOLZrAzthwTSteWVWMjC5/Qnqk4MVtHM0Gg3FYKUO42i03EOeSagCHaBAsGAI2xXhHCGSXoMeoLH58OQurrCR69JxyhsXnTlSfCnYKwIEyuKtIbaVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ms6LICTt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554KSSR5012952;
	Thu, 5 Jun 2025 08:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JoSk7H1cYM9YWH7je4bRU4qSBBEMfNEP0Y5AnQ2gpMI=; b=ms6LICTtUaoLqmnG
	qnj54zL7QFbXGhvhhL/uZ4iOf/89ddfuOxbXIWtl2Y0l+SGju5cIHKAldhQq3MD6
	qWMCZtQAGUmGGNVMb7hwEw+Z1hUd8W5aFUToNVSW7/Q0dLquM10el2QGx2C6jmQ6
	Zw2Kw0QbuFCJQkLexN3VPrfN7F/AIx4y9sbZjjIuZk6fXlUzs20P7FMXCjoKbmJ/
	/Q11QfyDTEfFr7cqm1FgxgCGmdJQbN+lbNvDXLeiyOz3A8EMFnN2mOnrR/tkw2K1
	S8a/Es70HJGjZS/fHELgboR8EVmZO6amBniVz5HY/CfcWLYq8wLIHArFBGrbwHQC
	4zho1w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47202weag5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 08:41:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5558fbYp003312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 08:41:37 GMT
Received: from [10.253.10.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 01:41:35 -0700
Message-ID: <6f3eb9fa-617e-4434-8fc4-33dd92c4bdd2@quicinc.com>
Date: Thu, 5 Jun 2025 16:41:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wifi: ath12k: fix dest ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Remi Pommarel
	<repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <20250604144509.28374-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250604144509.28374-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rjXw2fG-_L889ncZZDEnoFtMZr0JayqS
X-Proofpoint-GUID: rjXw2fG-_L889ncZZDEnoFtMZr0JayqS
X-Authority-Analysis: v=2.4 cv=Y/D4sgeN c=1 sm=1 tr=0 ts=68415842 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=d3g4vuyf_DbxgchVgIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3NSBTYWx0ZWRfXxetE9492yGB3
 WfT6/R1QdQnRQ4IhE76FMU4l0y7IU6cH7A3Ac9uRav+u2uRd6ov18OrA7rByyxqx6oOEK/v7xXK
 zl1JY5cgCeTR0qgz2+4moJ0dOrM378XMF2h5A7E/dwhU2woeqNjCKDA3cxrnengb4ZWFbokNjGV
 T2V//HoiveyEw9Br06sx3TMMV/a9pBeDxZxr5SeFOIYA8CsjAH8wzipAyDd7jT3C5WKKobEZn3A
 CzRclG4ToqulouckWTxKjiaaLHzKCfAxxMOQxKxUh9co5eV0XCXnw2pAWWnbhU9DkmeQumyHKiS
 10BDEySfQnu4NS6wMiifKdtfJtelrT1ZSDr8iHpETvMaLgBT0/1UP9PH3PwUPi1UyWyn7eiuLDt
 X7mR8JP7cjOX3oi1Rr7lgdSHNsZ7/I+68yei2Qa2NrAnqH5xt00HTk6jxVXUh0vnIQb0p97c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=985 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050075



On 6/4/2025 10:45 PM, Johan Hovold wrote:
> Add the missing memory barrier to make sure that destination ring
> descriptors are read after the head pointers to avoid using stale data
> on weakly ordered architectures like aarch64.
> 
> The barrier is added to the ath12k_hal_srng_access_begin() helper for
> symmetry with follow-on fixes for source ring buffer corruption which
> will add barriers to ath12k_hal_srng_access_end().
> 
> Note that this may fix the empty descriptor issue recently worked around
> by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
> monitor ring").

why? I would expect drunk cookies are valid in case of HAL_MON_DEST_INFO0_EMPTY_DESC,
rather than anything caused by reordering.

> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: stable@vger.kernel.org	# 6.3
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath12k/ce.c  |  3 ---
>  drivers/net/wireless/ath/ath12k/hal.c | 17 ++++++++++++++---
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
> index 740586fe49d1..b66d23d6b2bd 100644
> --- a/drivers/net/wireless/ath/ath12k/ce.c
> +++ b/drivers/net/wireless/ath/ath12k/ce.c
> @@ -343,9 +343,6 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
>  		goto err;
>  	}
>  
> -	/* Make sure descriptor is read after the head pointer. */
> -	dma_rmb();
> -
>  	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
>  
>  	*skb = pipe->dest_ring->skb[sw_index];
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index 91d5126ca149..9eea13ed5565 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -2126,13 +2126,24 @@ void *ath12k_hal_srng_src_get_next_reaped(struct ath12k_base *ab,
>  
>  void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
>  {
> +	u32 hp;
> +
>  	lockdep_assert_held(&srng->lock);
>  
> -	if (srng->ring_dir == HAL_SRNG_DIR_SRC)
> +	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  		srng->u.src_ring.cached_tp =
>  			*(volatile u32 *)srng->u.src_ring.tp_addr;
> -	else
> -		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> +	} else {
> +		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> +
> +		if (hp != srng->u.dst_ring.cached_hp) {

This consumes additional CPU cycles in hot path, which is a concern to me.

Based on that, I prefer the v1 implementation.

> +			srng->u.dst_ring.cached_hp = hp;
> +			/* Make sure descriptor is read after the head
> +			 * pointer.
> +			 */
> +			dma_rmb();
> +		}
> +	}
>  }
>  
>  /* Update cached ring head/tail pointers to HW. ath12k_hal_srng_access_begin()


