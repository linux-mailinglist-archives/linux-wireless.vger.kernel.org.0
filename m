Return-Path: <linux-wireless+bounces-24450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C7AE7480
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 03:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B6E5A4590
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 01:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2BD19B5B1;
	Wed, 25 Jun 2025 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EM3imFgE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACC197A76;
	Wed, 25 Jun 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816424; cv=none; b=k1pNEeZEHYcGoT+4Nk5Bl1W9vQ1N5tv3IGv7na+Uk7x/2Av5MiePP3ksKBq8WSegp25s664sw7m9iSqX223Xt0rDNv++d6pmHtH6JK8lTmcxF9g1pyOq+6BrSkrMpKZXD2dLWSKrtAnbKW052Q0y02U6xyJlM1vauXSiWXvAEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816424; c=relaxed/simple;
	bh=fPGUJkxcXEMwwtO7snODygUTMuAMc1q0a8IipfZhW6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pudskt2MHFWy7PKWN7vbvDysUYxz8TNaiWHd5zvKJJLgJLpjT/T2Br8e0oQCNkCWJktaFvwXOK2HGvZ9OI6gVYptx+Ni4Kkh8GG8F80yuQlCzjSULE4R8fPZFuYvHhQeJ2eNjiNvd1JKXtjNESQu/gUPti6U8kylDpOSPNFQ9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EM3imFgE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OGkmMV021760;
	Wed, 25 Jun 2025 01:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yzYqr02+eay9QpK+UlOyVQXwAJuTLz52YD+EgciPrwk=; b=EM3imFgE9Q3i8z4l
	flGCSemOo0Bb1MWOUQR6MmZur+KnI4GG1mD+GJb5PK03ZCs1dBYH7rzy5B/p192f
	jqR7H8VcNBxdG/9sYU2u07+xBw5R18TNerRjkDGcszKOysVwKrVt5KEx6ho6N4LG
	NA6DG0OBYTjNkSL68zS4kSB0yfaE2mq2QjqSzaAbQAhDKaftd07Yi+0KZeo+TjaY
	gxlAu3AFV8uWXVgmw1Dx53ftPxFH2ewcK7fFFyaCNI4j3qC5QnR0fW1e0W0edH6P
	N2fWbm8r3VPOoU1a5o8bDrU7ko4JxVeLNCEk5mIavbZJJMY2QZnZgHcS6vribMCy
	ev7SRA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bge5nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 01:53:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P1rXWl003573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 01:53:33 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Jun
 2025 18:53:31 -0700
Message-ID: <11124601-a0bb-40a9-a101-bb83d7756ab4@quicinc.com>
Date: Wed, 25 Jun 2025 09:53:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] wifi: ath12k: fix dest ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Remi Pommarel
	<repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250617084402.14475-1-johan+linaro@kernel.org>
 <20250617084402.14475-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250617084402.14475-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vPwE5FK1SHJzIVnmO5xKknypyzFaoU-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAxMyBTYWx0ZWRfXxVtg5TgNBKaa
 7bZfieSTd3ez8WryS7LYtbs0rtjtx/MgROgb17cp26rsSpUeigwkOoYokjuzwytMyHs9hyciR0q
 0HhPrnllOdMvlZeEw0giPvlvgNNDupFZALJqpphnPBPk86nB+7koj81Grq8/knk3SffaI7GKxys
 cRWOt6j6xNWlrvbw9Wd/1I57C+4t8bA63ar3k9RC1XvWGiG9zqL/wD+HdzdV/QB+U5lHKB1I/kv
 g8mPMifBHOlSFzXgrQW3ZrUEp072+rk+PbwabrB45I3DwizjAVQHXI8Dqfg0xu5avoEbkoSAcE8
 hJu9PEvu/dbjsCItnSSkFGP3Z4qx+IcFS2bieLJgji9/Vy+upNptD9TTfSZEyu1hpSQJwVd/Q8G
 KM8iYqJrnbmToIIR5pQamjWjGaPh1hEnzznvjndGyAAYDXn+9aNjlzl95xR4va0yog+ucu0W
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685b569e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=d3g4vuyf_DbxgchVgIQA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vPwE5FK1SHJzIVnmO5xKknypyzFaoU-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=862 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250013



On 6/17/2025 4:43 PM, Johan Hovold wrote:
> Add the missing memory barrier to make sure that destination ring
> descriptors are read after the head pointers to avoid using stale data
> on weakly ordered architectures like aarch64.
> 
> The barrier is added to the ath12k_hal_srng_access_begin() helper for
> symmetry with follow-on fixes for source ring buffer corruption which
> will add barriers to ath12k_hal_srng_access_end().
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
> index 3f3439262cf4..f7c15b547504 100644
> --- a/drivers/net/wireless/ath/ath12k/ce.c
> +++ b/drivers/net/wireless/ath/ath12k/ce.c
> @@ -433,9 +433,6 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
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
> index a301898e5849..f8bd3837b9dc 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -2143,13 +2143,24 @@ void *ath12k_hal_srng_src_get_next_reaped(struct ath12k_base *ab,
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

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>



