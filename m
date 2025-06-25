Return-Path: <linux-wireless+bounces-24473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AE8AE7E5C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7123A8631
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 10:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D230223704;
	Wed, 25 Jun 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pHrpTZFs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D67239E75;
	Wed, 25 Jun 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845664; cv=none; b=u9a/t4ze3j0xZq3UCIJEXMBe0s4UHIsUkVEVTYvVCxDHtDwCwPoejnWAwIqKyptdk2haPZfbOS+ne52kcMER8sG+8woqjtMEeP7/PDThPfpmIahYkCorl4UhZdtBvXuiJlRlAsIlW+I4jwK5daHcp//0SfPi3UKk8r216SuORSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845664; c=relaxed/simple;
	bh=RWoz2wakwwNGLi4sl9X6dVMEZLDMU2hECt5/SC4AQ6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uMr98V/Pde4lSsx6U2pP+IPyKcZq3OpLzRQyzuhv1jzdTe74s0l5FOrgOw9OOkuX2oEKftHhovEI/Qu9P52K6YFxiU86QXv6R8PfbBxqDgGv1i7nYU8EY3Y1CbdrlZECyUYZr6fE3wQs92OJdz7g8QRdSJ1tVfAm/91qsVAAvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pHrpTZFs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P3VefR027585;
	Wed, 25 Jun 2025 10:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vVfbmAL9nuta9hPZ9Nq1gX/UlCRXU0dU44mdWz4B17A=; b=pHrpTZFsUM+eQDdW
	KP1bxe8k3CXM2AZk37Z0VZwe5ZDMcTjdciP4RhxH/xJw5w1Exby9cMDRcZDAR18V
	tDoYqN61JOfgOYmZY2OSaige+Q4eE+NLonZ4XGteLhI4VeSxEdatszkqtRxp9jvg
	9NKxlSVfinZTlXt87VOaEL/RcaYPTMOsbuY02wFnO4hP7j777OibXwqkOEpxcgMA
	V+CK28WXdLHQtCmWQOYnJM+nT+hKf8ZFzk2ffIvjBpGh5VfVFOWzth7Ceg5V0USP
	tfnomaFhuWfkYqeGbKd+RIC6EkTULlu15MQ09osXdQfzb2t3otBbfNN5sCrO5YtA
	m6OqiA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqnxek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:00:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55PA0pKp017026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:00:51 GMT
Received: from [10.133.33.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 03:00:48 -0700
Message-ID: <d163080d-61ee-4af1-a783-5a77cbc525d1@quicinc.com>
Date: Wed, 25 Jun 2025 18:00:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] wifi: ath11k: fix dest ring-buffer corruption when
 ring is full
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
 <20250604143457.26032-6-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250604143457.26032-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vx5Yl7wNXEWKorOCHEJ7MqcFJEe5imyX
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685bc8d4 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=3Go43yyQdFlCKqBfqAEA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vx5Yl7wNXEWKorOCHEJ7MqcFJEe5imyX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3NCBTYWx0ZWRfX2c8mFj9e0oaI
 5Xz9MCz1PRScfjD5M7sb3oG42qD3NB2w3ni/MOqbpUxJSGKaLTjyUOnTXOsfv5cLW6yAnj8iLw/
 S6qfXNtsVHyaoqcOmMQOondctl6t/ebZcsO3+VrWuIfvTjL31Bh3QwjrzphjJlOcFHDfActAeMT
 OJs28HGVCiyaJVSf68APwqmoiHBYJ3QPwwOQYcaKz91CnMXqNruRybgayPS3t1paIbMHmNmPTTF
 7Pzcow5Ix6t6ASnUQSfrQwqNmoKcoHZUZQFrLfCZyVEBIKOIKBrD222bjp82XXblJNAJDPugneo
 SVUHl/aVYRID2c/YCPgm7T2ZEbEsWO0IPR6496hySa3zZjhUlMx3xeLdZSjWvGCMENaSQVG88iA
 8wXxQEszSS/zMeDiJH4FWEIGgs5xWPiGVBIIvS5i3B1/ZCPHSJ6sDTkVDHiRXJixIuZz/vzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=632 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250074



On 6/4/2025 10:34 PM, Johan Hovold wrote:
> Add the missing memory barriers to make sure that destination ring
> descriptors are read before updating the tail pointer (and passing
> ownership to the device) to avoid memory corruption on weakly ordered
> architectures like aarch64 when the ring is full.
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org      # 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/hal.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index 927ed2bc3fbf..7eeffb36899e 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -854,7 +854,6 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
>  {
>  	lockdep_assert_held(&srng->lock);
>  
> -	/* TODO: See if we need a write memory barrier here */
>  	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
>  		/* For LMAC rings, ring pointer updates are done through FW and
>  		 * hence written to a shared memory location that is read by FW
> @@ -869,7 +868,11 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
>  			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
>  		} else {
>  			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> -			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
> +			/* Make sure descriptor is read before updating the
> +			 * tail pointer.
> +			 */
> +			dma_mb();
> +			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
>  		}
>  	} else {
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> @@ -885,6 +888,10 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
>  					   srng->u.src_ring.hp);
>  		} else {
>  			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> +			/* Make sure descriptor is read before updating the
> +			 * tail pointer.
> +			 */
> +			mb();
>  			ath11k_hif_write32(ab,
>  					   (unsigned long)srng->u.dst_ring.tp_addr -
>  					   (unsigned long)ab->mem,

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>

