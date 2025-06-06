Return-Path: <linux-wireless+bounces-23794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D07ACFD75
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97241751D1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725A8283FE0;
	Fri,  6 Jun 2025 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MF5WMu8t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A6149C7B;
	Fri,  6 Jun 2025 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194841; cv=none; b=EzcUZL4KICZQXyjerTOioApmULsCSmYKlug5dZVJsEYMPfzonb7NNnPgwhH2JkTir8QyfiQUMRD3zU0+AT33A0lN8ROnlxQedjXXa/y/OQ4ZXEAZimGt3J8eCaA4HlMZbUwNviXHTxuegF9fUtc6RV1CRh9Qfhjg9cNQ3ai6pyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194841; c=relaxed/simple;
	bh=R9cs447TBAukVNzslH/T1+spw0IgeAwCpC4Y+6saHaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GjVPHGiSVrnPlxrVGku0gPmrsbU2QqShMbM7QOkQYfkj1Rj4vItfVzWH3D7IACFSxFb3D7VnVRyic0+8feLKnmfIgQPPG2I3K0wq8pzjz3V8oymtA6fLUuriijB5QKrLUCiZYSYA2qlC1imsnUf4IjlA9c4xY2UT4mQ0Em8xuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MF5WMu8t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5567GlMf013323;
	Fri, 6 Jun 2025 07:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRqyFjrw73okLETjUfh57p5f08AP6gjFxBAOBQp4rCo=; b=MF5WMu8tVDSEHdk9
	4OC/soMVyt7uxtjfm9ASJFnuym37FfjBJh4J59OKu3JJ5QOKBDoon+oAx3mRfLVj
	1FeqfACODCIOhsE9HtY9uCNAh3/jqPE+/j+XNhkAZy7U1YmTF6axnc4VVV1H6bWd
	jGFbiwcNCb7btqKDDfoS/KLlAneEJw6ZGEc6LiwUA8wuYqexuK4iDlNS3ppYa8B5
	y3lMZE8zhFP60tY7RYyaSAzFkg4QZJ3VoW2FSHWhzfXrn7oJfXTf0+pTT7bSNO59
	OhLqInPbHpPKmPv0Zno/CUepg/0GGAIDGQUz4d88TuuQWGcIBloZSITi+8MEWZqA
	8cTP3A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472be87h1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 07:27:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5567R9ma010883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Jun 2025 07:27:09 GMT
Received: from [10.133.33.151] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Jun 2025
 00:27:06 -0700
Message-ID: <a8236639-2448-4552-ac21-db7e7370e23e@quicinc.com>
Date: Fri, 6 Jun 2025 15:27:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] wifi: ath12k: fix dest ring-buffer corruption when
 ring is full
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Remi Pommarel <repk@triplefau.lt>,
        Baochen Qiang
	<quic_bqiang@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <20250604144509.28374-5-johan+linaro@kernel.org>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <20250604144509.28374-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=bNYWIO+Z c=1 sm=1 tr=0 ts=6842984d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=3Go43yyQdFlCKqBfqAEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SD3RBLxLsVmQbCrOkhPimDIVX3kGp684
X-Proofpoint-ORIG-GUID: SD3RBLxLsVmQbCrOkhPimDIVX3kGp684
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA2OCBTYWx0ZWRfX8K9upEL4pTkg
 FeGYcOxNj8WoKUpWE7r+XwruokaM0SWCUkD4W2Ia7M8TBsblR1jd1YdpueZfkZKQMlwh+OEyYBd
 NFB/Z8p4QcLU+A7If5JdWUfCyYbWr8/nnHhZrByscms2EqYzSN7OPyTPHiG5vhwjF5dUr0vRK0f
 LIM0GIihzkihS2s+1/NyFH/DsitzodCBzdPZVl5clQhH+UlR1vv5uzoDNW4KOvBr1ztIQzRLqnV
 838Bs4et3hLoe85lOjmrsqUfTFJMYEKsxNMObrXZm4N9I3Gd6JZVuM5j34UXNUgUnhXX0/eIJge
 vST1Rdd7n4rr4G+/7r3hsjFrZrYzFOeHRe8R7OS3jYOsZtsyo722MGKN1tPEI3/89UY/7oGUnJ3
 eshV1Jc7ntikGH9lRUAQpeWyMfVlWnMXY1LgvM5zDKeV5Mgj6FVxPyarNCPs2T24psYVC0KG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=732 adultscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060068



On 6/4/2025 10:45 PM, Johan Hovold wrote:
> Add the missing memory barriers to make sure that destination ring
> descriptors are read before updating the tail pointer (and passing
> ownership to the device) to avoid memory corruption on weakly ordered
> architectures like aarch64 when the ring is full.
> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: stable@vger.kernel.org      # 6.3
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/net/wireless/ath/ath12k/hal.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index 1e2d13cc2d19..4da354e86a75 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -2153,7 +2153,6 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>   {
>   	lockdep_assert_held(&srng->lock);
>   
> -	/* TODO: See if we need a write memory barrier here */
>   	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
>   		/* For LMAC rings, ring pointer updates are done through FW and
>   		 * hence written to a shared memory location that is read by FW
> @@ -2168,7 +2167,11 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>   			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
>   		} else {
>   			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> -			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
> +			/* Make sure descriptor is read before updating the
> +			 * tail pointer.
> +			 */
> +			dma_mb();
> +			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
>   		}
>   	} else {
>   		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> @@ -2184,6 +2187,10 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>   					   srng->u.src_ring.hp);
>   		} else {
>   			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> +			/* Make sure descriptor is read before updating the
> +			 * tail pointer.
> +			 */
> +			mb();

Is rmb() sufficient, since MMIO write already includes wmb()?


>   			ath12k_hif_write32(ab,
>   					   (unsigned long)srng->u.dst_ring.tp_addr -
>   					   (unsigned long)ab->mem,


